From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 10:38:44 +0200
Subject: [PATCH 0/3] misc nvme fixes
Message-ID: <20180607083847.51019-1-hare@suse.de>

Hi all,

here are some small fixes I've found required when testing ANA
support. They are not directly related to ANA itself so they're send
as a separate patchset.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: also check for RESETTING state in nvmf_check_if_ready()
  nvme: do not access request after calling blk_mq_end_request()
  nvme: bio remapping tracepoint

 drivers/nvme/host/fabrics.c   | 1 +
 drivers/nvme/host/multipath.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.12.3
