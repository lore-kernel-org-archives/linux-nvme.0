From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 04:32:46 +0900
Subject: [PATCH V2 0/3] nvme-cli: lnvm: introduce chunk-log command
Message-ID: <20190727193249.22655-1-minwoo.im.dev@gmail.com>

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

Changes to V1:
  - Add Signed-off-by and Reviewed-by from Matias and Javier
  - Squashed 2/3/4 patches into a single one
  - Remove nested-if suggested by Javier
  - Early return instead of goto suggested by Javier
  - Update print format for chunk-log suggested by Matias

Minwoo Im (3):
  lnvm: make data_len to sizeof() instead of magic number
  lnvm: introduce chunk-log command for chunk info
  lnvm: introduce alias geometry for id-ns for lnvm

 nvme-lightnvm.c          | 73 +++++++++++++++++++++++++++++++++++-
 nvme-lightnvm.h          | 17 +++++++++
 plugins/lnvm/lnvm-nvme.c | 81 ++++++++++++++++++++++++++++++++++++++++
 plugins/lnvm/lnvm-nvme.h |  3 +-
 4 files changed, 171 insertions(+), 3 deletions(-)

-- 
2.17.1
