$encoder = (gc -path .\commands.txt -Encoding Ascii | Out-String)
$Out=''
foreach($s in $encoder.ToChararray()){
$temp_c = [int][char]$s
$temp_c -= 7
$temp_c = $temp_c -bxor 2
    if($temp_c -lt 10){
    $temp_c = '00'+ $temp_c

    }elseif($temp_c -lt 100){
    $temp_c = '0'+ $temp_c
    
    }

    $out += $temp_c
}

$mem_stream = New-Object System.IO.MemoryStream
$Gzip_stream = New-Object System.IO.Compression.GZipStream($mem_stream,[System.IO.Compression.CompressionMode]::compress) 
$stream_write = New-Object System.IO.StreamWriter($mem_stream)
$stream_write.Write($out)
$stream_write.Close()

$out_base64 = [System.Convert]::ToBase64String($mem_stream.ToArray())
$out_base64
write-host "------------------------------------------------------------------------"

$decoder = "MTE0MDk5MTA2MDg4MTAwMDk2MDA0MDAxMTAxMDkyMTExMDI3MTA4MTEwMDkyMTA1MDA0MDAxMDY0MTA3MDk0MTA2MTAxMDkzMDk2MDk4MDI3MDQyMDg4MTAzMTAzMDA0MDAx"

$decoder = [System.Convert]::FromBase64String($decoder)
$mem_stream = New-Object System.IO.MemoryStream
$mem_stream.Write($decoder,0,$decoder.Length)
$mem_stream.Seek(0,0) 

$Gzip_stream = New-Object System.IO.Compression.GZipStream($mem_stream,[System.IO.Compression.CompressionMode]::Decompress)
$stream_read = New-Object System.IO.StreamReader($mem_stream)
$decoder = $stream_read.ReadToEnd()
$decoder

$output=''
for($d=0;$d -lt $dec.Length;$d += 3){
   $temp_c = $dec.Substring($d,3)
   $temp_c = [int]$temp_c -bxor 2
   $temp_c += 7
   $temp_c = [char][int]$temp_c 
   $output += $temp_c

}
iex($output)