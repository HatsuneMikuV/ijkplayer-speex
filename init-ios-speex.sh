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

IJK_SPEEX_UPSTREAM=https://github.com/xiph/speex
IJK_SPEEX_FORK=https://github.com/HatsuneMikuV/speex.git
IJK_SPEEX_COMMIT=Speex-1.2rc1
IJK_SPEEX_LOCAL_REPO=extraSpeex/speex

FF_TARGET=$1

set -e
TOOLS=tools

echo "== pull speex base =="
sh $TOOLS/pull-repo-base.sh $IJK_SPEEX_UPSTREAM $IJK_SPEEX_LOCAL_REPO

function pull_fork()
{
    echo "== pull speex fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_SPEEX_FORK ios/speex-$1 ${IJK_SPEEX_LOCAL_REPO}
    cd ios/speex-$1
    git checkout ${IJK_SPEEX_COMMIT} -B ijkplayer
    cd -
}


for FF_SH in $FF_TARGET
do
    pull_fork $FF_SH
done
