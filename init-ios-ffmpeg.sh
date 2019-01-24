#! /usr/bin/env bash
#
# Copyright (C) 2013-2015 Bilibili
# Copyright (C) 2013-2015 Zhang Rui <bbcallen@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# IJK_FFMPEG_UPSTREAM=git://git.videolan.org/ffmpeg.git
IJK_FFMPEG_UPSTREAM=https://github.com/Bilibili/FFmpeg.git
IJK_FFMPEG_FORK=https://github.com/Bilibili/FFmpeg.git
IJK_FFMPEG_COMMIT=ff3.4--ijk0.8.7--20180103--001
IJK_FFMPEG_LOCAL_REPO=extraSpeex/ffmpeg

IJK_GASP_UPSTREAM=https://github.com/Bilibili/gas-preprocessor.git

FF_TARGET=$1

# gas-preprocessor backup
# https://github.com/Bilibili/gas-preprocessor.git

if [ "$IJK_FFMPEG_REPO_URL" != "" ]; then
    IJK_FFMPEG_UPSTREAM=$IJK_FFMPEG_REPO_URL
    IJK_FFMPEG_FORK=$IJK_FFMPEG_REPO_URL
fi

if [ "$IJK_GASP_REPO_URL" != "" ]; then
    IJK_GASP_UPSTREAM=$IJK_GASP_REPO_URL
fi

set -e
TOOLS=tools


FF_ALL_ARCHS=$FF_TARGET
FF_TARGET=$1

function echo_ffmpeg_version() {
    echo $IJK_FFMPEG_COMMIT
}

function pull_common() {
    git --version
    echo "== pull gas-preprocessor base =="
    sh $TOOLS/pull-repo-base.sh $IJK_GASP_UPSTREAM extraSpeex/gas-preprocessor

    echo "== pull ffmpeg base =="
    sh $TOOLS/pull-repo-base.sh $IJK_FFMPEG_UPSTREAM $IJK_FFMPEG_LOCAL_REPO
}

function pull_fork() {
    echo "== pull ffmpeg fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_FFMPEG_FORK ios/ffmpeg-$1 ${IJK_FFMPEG_LOCAL_REPO}
    cd ios/ffmpeg-$1
    git checkout ${IJK_FFMPEG_COMMIT} -B ijkplayer
    cd -
}

function pull_fork_all() {
    for ARCH in $FF_ALL_ARCHS
    do
        pull_fork $ARCH
    done
}

function sync_ff_version() {
    sed -i '' "s/static const char \*kIJKFFRequiredFFmpegVersion\ \=\ .*/static const char *kIJKFFRequiredFFmpegVersion = \"${IJK_FFMPEG_COMMIT}\";/g" ios/IJKMediaPlayer/IJKMediaPlayer/IJKFFMoviePlayerController.m
}

#----------
case "$FF_TARGET" in
    ffmpeg-version)
        echo_ffmpeg_version
    ;;
    armv7|armv7s|arm64|i386|x86_64)
        pull_common
        pull_fork $FF_TARGET
    ;;
    all|*)
        pull_common
        pull_fork_all
    ;;
esac

sync_ff_version

