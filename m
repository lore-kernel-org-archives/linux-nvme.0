From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 24 Jul 2019 03:35:56 +0900
Subject: [PATCH 0/5] nvme-cli: lnvm: introduce chunk-log command
Message-ID: <20190723183601.29370-1-minwoo.im.dev@gmail.com>

Hi all,

This series introduces a "chunk-log" subcommand for lnvm extension
plugin.  This command will send a get-log page NVMe admin command to the
given namespace which is for OCSSD.  We just can use nvme get-log
command with log id, but this subcommand is much more easier to use
because it gives parameters.

liblightnvm also provides nvm_cmd rprt_all command to retrieve this
information, but nvme-cli can do it also.  If you have something else
for this, please let me know.

This series also holds few clean-ups for the existing codes.

The last patch is introducing alias command name "geometry" for the
id-ns subcommand.

Please reivew.

Thanks!

Minwoo Im (5):
  lnvm: make data_len to sizeof() instead of magic number
  lnvm: export lnvm_get_identity
  lnvm: add chunk_info log page structure
  lnvm: introduce chunk-log command for chunk info
  lnvm: introduce alias geometry for id-ns for lnvm

 nvme-lightnvm.c          | 41 +++++++++++++++++++-
 nvme-lightnvm.h          | 17 ++++++++
 plugins/lnvm/lnvm-nvme.c | 84 ++++++++++++++++++++++++++++++++++++++++
 plugins/lnvm/lnvm-nvme.h |  3 +-
 4 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.17.1
