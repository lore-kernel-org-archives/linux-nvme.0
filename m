From: hare@suse.de (Hannes Reinecke)
Date: Tue, 19 Feb 2019 13:13:56 +0100
Subject: [PATCH 0/2] nvme: fixup crash in device_add_disk()
Message-ID: <20190219121358.57975-1-hare@suse.de>

Hi all,

during testing we've ran into an issue where the system would crash
in device_add_disk(); analysis showed that there is a race condition
in nvme_validate_ns() if called simultaneously for the same controller.
This patchset tries to fix it up.

As usual, comments and reviews are appreciated.

Hannes Reinecke (2):
  nvme: return error from nvme_alloc_ns()
  nvme: protect against race condition in nvme_validate_ns()

 drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

-- 
2.16.4
