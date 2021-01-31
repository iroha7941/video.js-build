#!/bin/sh -e

ffmpeg \
    -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 \
    -f lavfi -i color=c=green:s=1280x720 \
    -shortest \
    -c:v libx264 -t 3 -r 30 \
    -pix_fmt yuv420p \
    -b:v 800k -maxrate 2000k -bufsize 1600k \
    -tune animation -keyint_min 30 -g 30 -sc_threshold 0 -movflags faststart \
    -c:a aac -b:a 96k \
    -f hls \
    -hls_segment_type fmp4 -hls_playlist_type vod \
    -hls_time 6 \
    green.m3u8

mv init.mp4 init.mp4.bak
openssl enc -aes-128-cbc \
    -K 71615cb265ca144707d9530ea4874e0f \
    -iv 5f569b6b78c97686f23757b9f82e8cd4 \
    < init.mp4.bak > init.mp4

mv green0.m4s green0.m4s.bak
openssl enc -aes-128-cbc \
    -K 71615cb265ca144707d9530ea4874e0f \
    -iv 5f569b6b78c97686f23757b9f82e8cd4 \
    < green0.m4s.bak > green0.m4s

mv green.m3u8 green.m3u8.bak
perl -p \
    -e "print \"#EXT-X-KEY:METHOD=AES-128,URI=\\\"enc.key\\\",IV=0x5f569b6b78c97686f23757b9f82e8cd4\n\" if(/EXT-X-MAP/);" \
    green.m3u8.bak > green.m3u8

echo '0000000: 7161 5cb2 65ca 1447 07d9 530e a487 4e0f' | xxd -r > enc.key

rm *.bak
