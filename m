From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue,  7 May 2019 04:46:42 +0900
Subject: [PATCH V2 0/2] nvme-trace: Add support for fabrics command
Message-ID: <20190506194644.11109-1-minwoo.im.dev@gmail.com>

  The first one introduces a new inline function to check whether the
given nvme command is for fabrics or not.  We do the checks in many
places so that we can have it as an inline.

  The second patch is the actual commit to support fabrics command
tracing with updating review comments on previous V1.  Actually it has
been updated entirely, but keep it tracked for the history and make this
patch V2.

I would really appreciate it if they are reviewed.

Thanks,

Changes to V1:
  - fabrics commands should also be decoded, not just showing that it's
    a fabrics command. (Christoph)
  - do not make it within nvme admin commands (Chaitanya)

Minwoo Im (2):
  nvme: Introduce nvme_is_fabrics to check fabrics cmd
  nvme-trace: Add support to trace fabrics command

 drivers/nvme/host/core.c          |  7 +++-
 drivers/nvme/host/fabrics.c       |  2 +-
 drivers/nvme/host/trace.c         | 67 +++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h         | 37 +++++++++++++++++
 drivers/nvme/target/core.c        |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  2 +-
 drivers/nvme/target/fc.c          |  2 +-
 include/linux/nvme.h              |  7 +++-
 8 files changed, 120 insertions(+), 6 deletions(-)

-- 
2.17.1
