From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Fri, 17 Jun 2016 14:21:13 -0300
Subject: [PATCH 0/2] 2 patches about asynchronous events notification
Message-ID: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>

The 2 patches in this small series are related to asynchronous events' handling.

The 1st aims to print textual information instead of just print the event code.
The 2nd patch enables asynchronous events notification by default.

There are some points below, for which I'd be glad to hear some suggestions!

1) In the 1st patch, we do first a direct lookup in a table and then we
fallback to full table search in case direct lookup does not succeed. We can
rely in direct lookup solely if we are sure the NVMe spec. won't ever add
events with non-incremental codes. Since I cannot guarantee this myself, my
choice was to keep the full table search (which code won't be reached with
current events of the spec.);

2) The 2nd patch was sent as a RFC, because I'm not sure if there is some
con in enabling those events by default; I might be missing some caveat here.

Thanks in advance.



Guilherme G. Piccoli (2):
  nvme: introduce asynchronous events textual output
  nvme: enable asynchronous events notification by default

 drivers/nvme/host/core.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  9 ++++++
 drivers/nvme/host/pci.c  | 16 ++++++++++
 3 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.1.0
