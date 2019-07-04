From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Thu, 4 Jul 2019 12:03:25 +0200
Subject: [PATCH 0/3] Miscellaneous changes for nvme-tcp
Message-ID: <cover.1562234605.git.mskorzhinskiy@solarflare.com>

A few unrelated changes for NVMoF subsystem, that was found during testing
of NVMoF TCP.

I didn't add any special comments inside the code regarding reasons why
that was done, as I assume people who interested in this will take a look
into the git blame\git log. Of cource, I can add this comments into the
code and resend, if it is prefferable.

patch 1: just a hint message
patch 2: found during extensive testing on various filesystems
patch 3: found during testing on debug kernels with VM_DEBUG enabled

Mike Playle (1):
  nvme-tcp: set the STABLE_WRITES flag when data digests are enabled

Mikhail Skorzhinskii (2):
  nvmet: print a hint while rejecting NSID 0 or 0xffffffff
  nvme-tcp: replace sendpage calls with sendmsg calls for SLAB chunks

 drivers/nvme/host/core.c       |  5 +++++
 drivers/nvme/host/tcp.c        | 40 ++++++++++++++++++++++++++++++++++------
 drivers/nvme/target/configfs.c |  4 +++-
 3 files changed, 42 insertions(+), 7 deletions(-)

-- 
2.16.4
