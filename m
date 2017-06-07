From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Wed,  7 Jun 2017 15:25:43 +0800
Subject: [PATCH 2/2] nvme: relax APST default max latency to 100ms
In-Reply-To: <20170607072543.14071-1-kai.heng.feng@canonical.com>
References: <20170607072543.14071-1-kai.heng.feng@canonical.com>
Message-ID: <20170607072543.14071-2-kai.heng.feng@canonical.com>

Christoph Hellwig suggests we should to make APST work out of the box.
Hence relax the the default max latency to make them able to enter
deepest power state on default.

Here are id-ctrl excerpts from two high latency NVMes:

vid     : 0x14a4
ssvid   : 0x1b4b
mn      : CX2-GB1024-Q11 NVMe LITEON 1024GB
ps    3 : mp:0.1000W non-operational enlat:5000 exlat:5000 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0100W non-operational enlat:50000 exlat:100000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-

vid     : 0x15b7
ssvid   : 0x1b4b
mn      : A400 NVMe SanDisk 512GB
ps    3 : mp:0.0500W non-operational enlat:51000 exlat:10000 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    4 : mp:0.0055W non-operational enlat:1000000 exlat:100000 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-

Signed-off-by: Kai-Heng Feng <kai.heng.feng at canonical.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c07d8d4e18c9..903d5813023a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -56,7 +56,7 @@ MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
 static int nvme_char_major;
 module_param(nvme_char_major, int, 0);
 
-static unsigned long default_ps_max_latency_us = 25000;
+static unsigned long default_ps_max_latency_us = 100000;
 module_param(default_ps_max_latency_us, ulong, 0644);
 MODULE_PARM_DESC(default_ps_max_latency_us,
 		 "max power saving latency for new devices; use PM QOS to change per device");
-- 
2.13.0
