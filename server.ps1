$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$port = 8080
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:${port}/")
$listener.Start()

Write-Host "서버 실행 중: http://localhost:$port"
Write-Host "종료하려면 이 창을 닫으세요."

$mimeTypes = @{
    '.html' = 'text/html; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.json' = 'application/json'
    '.ico'  = 'image/x-icon'
    '.png'  = 'image/png'
    '.svg'  = 'image/svg+xml'
    '.woff' = 'font/woff'
    '.woff2'= 'font/woff2'
}

while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $path = $ctx.Request.Url.LocalPath
    if ($path -eq '/') { $path = '/index.html' }

    $filePath = Join-Path $root ($path -replace '/', '\')

    if (Test-Path $filePath -PathType Leaf) {
        $bytes = [System.IO.File]::ReadAllBytes($filePath)
        $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
        $mime = $mimeTypes[$ext]
        if (-not $mime) { $mime = 'application/octet-stream' }

        $ctx.Response.ContentType = $mime
        $ctx.Response.ContentLength64 = $bytes.Length
        $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $ctx.Response.StatusCode = 404
        $bytes = [System.Text.Encoding]::UTF8.GetBytes('Not Found')
        $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    }
    $ctx.Response.OutputStream.Close()
}
