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

IJK_OGG_UPSTREAM=https://github.com/xiph/ogg.git
IJK_OGG_FORK=https://github.com/xiph/ogg.git
IJK_OGG_COMMIT=v1.3.2
IJK_OGG_LOCAL_REPO=extraSpeex/ogg

set -e
TOOLS=tools

echo "== pull ogg base =="
sh $TOOLS/pull-repo-base.sh $IJK_OGG_UPSTREAM $IJK_OGG_LOCAL_REPO

function pull_fork()
{
    echo "== pull ogg fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_OGG_FORK ios/ogg-$1 ${IJK_OGG_LOCAL_REPO}
    cd ios/ogg-$1
    git checkout ${IJK_OGG_COMMIT} -B ijkplayer
    cd -
}

pull_fork "armv7"
pull_fork "armv7s"
pull_fork "arm64"
pull_fork "i386"
pull_fork "x86_64"
