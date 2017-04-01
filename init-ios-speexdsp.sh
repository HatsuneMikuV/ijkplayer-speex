#! /usr/bin/env bash
#
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

IJK_SPEEXDSP_UPSTREAM=https://github.com/pili-engineering/pili-speexdsp.git
IJK_SPEEXDSP_FORK=https://github.com/pili-engineering/pili-speexdsp.git
IJK_SPEEXDSP_COMMIT=SpeexDSP-1.2rc3
IJK_SPEEXDSP_LOCAL_REPO=extra/speexdsp

set -e
TOOLS=tools

echo "== pull speexdsp base =="
sh $TOOLS/pull-repo-base.sh $IJK_SPEEXDSP_UPSTREAM $IJK_SPEEXDSP_LOCAL_REPO

function pull_fork()
{
    echo "== pull speexdsp fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_SPEEXDSP_FORK ios/speexdsp-$1 ${IJK_SPEEXDSP_LOCAL_REPO}
    cd ios/speexdsp-$1
    git checkout ${IJK_SPEEXDSP_COMMIT} -B ijkplayer
    cd -
}

pull_fork "armv7"
pull_fork "armv7s"
pull_fork "arm64"
pull_fork "i386"
pull_fork "x86_64"
