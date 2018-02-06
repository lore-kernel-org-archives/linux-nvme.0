From: jsmart2021@gmail.com (James Smart)
Date: Tue,  6 Feb 2018 06:48:28 -0800
Subject: [PATCH 0/2] nvme-fc: io termination cleanup
Message-ID: <20180206144830.968-1-jsmart2021@gmail.com>

The patches address io termination issues in nvme-fc:

The first patch addresses a race condition on io termination vs
reset/delete abort paths that allowed an io to complete yet the
association termination counted it and is waiting for the completion.

The second patch addresses cleanup of the code that was synchronizing
io termination between the lldd done path and the blk-mq completion
path. the completion path existed because, at the time, the eh_handler
could return a successful return status, allowing the complete routine
to be called, although the io was still active in the lldd. Since then
the eh_handler has been corrected to reschedule the io timer after
initiating the abort and this condition is no longer true.

James Smart (2):
  nvme_fc: correct abort race condition on resets
  nvme_fc: cleanup io completion

 drivers/nvme/host/fc.c | 143 ++++++++++---------------------------------------
 1 file changed, 29 insertions(+), 114 deletions(-)

-- 
2.13.1
