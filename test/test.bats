#!/usr/bin/env bats

#------------------------------------------------------------------------ errors

@test "start with no app name" {
   run ../bin/injarg
   [ "$status" -eq 1 ]
   [ "${lines[0]}" = 'Error: Need at least the app name.' ]
   [ "${lines[1]}" = 'injarg <app> [ ... --args <file> ... ]' ]
}

@test "start with no " {

}

#----------------------------------------------------------------------- ffmpeg1

@test "ffmpeg1: auto load default args file" {
   cd ffmpeg1
   run ../../bin/injarg ffmpeg
   [ "$status" -eq 0 ]
   [ "$output" = 'ffmpeg -nostdin -b 250k -strict experimental -deinterlace -vcodec h264 -acodec aac example.mp4' ]
}

@test "ffmpeg1: select via --args" {
   cd ffmpeg1
   run ../../bin/injarg ffmpeg --args ffmpeg.auto.args
   [ "$status" -eq 0 ]
   [ "$output" = 'ffmpeg -nostdin -b 250k -strict experimental -deinterlace -vcodec h264 -acodec aac example.mp4' ]
}

@test "ffmpeg1: inject values" {
   cd ffmpeg1
   run ../../bin/injarg ffmpeg -nostdin -b 250k --args config.args example.mp4
   [ "$status" -eq 0 ]
   [ "$output" = 'ffmpeg -nostdin -b 250k -strict experimental -deinterlace -vcodec h264 -acodec aac example.mp4' ]
}

#----------------------------------------------------------------------- ffmpeg2

@test "ffmpeg2: try to load default args file" {
   cd ffmpeg2
   run ../../bin/injarg ffmpeg
   [ "$status" -eq 1 ]
   [ "${lines[0]}" = 'Error: Please select one of this args files:' ]
   [ "${lines[1]}" = 'ffmpeg.altname.args' ]
   [ "${lines[2]}" = 'ffmpeg.args' ]
   [ "${lines[3]}" = 'ffmpeg.shortname.args' ]
}

@test "ffmpeg2: select via --args file" {
   cd ffmpeg2
   run ../../bin/injarg ffmpeg --args ffmpeg.args
   [ "$status" -eq 0 ]
   [ "$output" = 'ffmpeg -vcodec h264 -acodec aac example.mp4' ]
}

@test "ffmpeg2: select via --args altname file" {
   cd ffmpeg2
   run ../../bin/injarg ffmpeg --args ffmpeg.altname.args
   [ "$status" -eq 0 ]
   [ "$output" = 'ffmpeg -vcodec h264 -acodec aac "long alternative name.mp4"' ]
}

@test "ffmpeg2: select via --args shortname file" {
   cd ffmpeg2
   run ../../bin/injarg ffmpeg --args ffmpeg.shortname.args
   [ "$status" -eq 0 ]
   [ "$output" = 'ffmpeg -vcodec h264 -acodec aac e.mp4' ]
}

