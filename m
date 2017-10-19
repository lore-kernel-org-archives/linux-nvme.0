From: jsmart2021@gmail.com (James Smart)
Date: Thu, 19 Oct 2017 16:11:37 -0700
Subject: [PATCH v2 0/2] nvme_fc: rework io timeouts and termination
Message-ID: <20171019231139.23611-1-jsmart2021@gmail.com>

This is a rework of a prior patch that has now been split into two
patches. One patch addresses changes to the io timeout error handler.
The other patch addresses io completions for failing ios to ensure
io retries or to fail commands during association create.

Patches also address prior review comments

James Smart (2):
  nvme_fc: correct io termination handling
  nvme_fc: correct io timeout behavior

 drivers/nvme/host/fc.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

-- 
2.13.1
