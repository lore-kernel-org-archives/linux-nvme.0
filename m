From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  8 Mar 2019 15:41:19 -0800
Subject: [PATCH 0/2] support nvme-tcp SUCCESS flag optimization
Message-ID: <20190308234121.1347-1-sagi@grimberg.me>

The SUCCESS flag is a bit that exists in the C2HData PDU header and
allows a controller to indicate that the command completed successfully
from the controller perspective, and by setting it, the controller omits
a subsequent completion response capsule PDU.

Its optional usage in the spec, but the host definitly needs to support
it given that the controller is allowed to set it anytime.

Thanks to Steve Blightman and Oliver Smith-Denny for raising my attention
on this.

Sagi Grimberg (2):
  nvme-tcp: support C2HData with SUCCESS flag
  nvmet-tcp: implement C2HData SUCCESS optimization

 drivers/nvme/host/tcp.c   | 32 ++++++++++++++++++++++++++++----
 drivers/nvme/target/tcp.c | 24 +++++++++++++++++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

-- 
2.17.1
