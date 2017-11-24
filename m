From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 23 Nov 2017 22:04:55 -0700
Subject: [GIT PULL] nvme fixes for Linux 4.15
In-Reply-To: <514cf7e6-f651-112e-c8bb-e5ad837d4394@kernel.dk>
References: <20171123144438.wfs2fo64l6vwgfxj@infradead.org>
 <514cf7e6-f651-112e-c8bb-e5ad837d4394@kernel.dk>
Message-ID: <1dcadbce-8a97-9578-686a-c43bd8dc06fc@kernel.dk>

On 11/23/2017 09:54 PM, Jens Axboe wrote:
> On 11/23/2017 07:44 AM, Christoph Hellwig wrote:
>> Sagi Grimberg (3):
>>       nvme-fc: check if queue is ready in queue_rq
>>       nvme-loop: check if queue is ready in queue_rq
> 
> The nvme-loop part looks fine, but why is the nvme-fc part using:
> 
> enum nvme_fc_queue_flags {                                                     
>         NVME_FC_Q_CONNECTED = (1 << 0),                                         
> +       NVME_FC_Q_LIVE = (1 << 1),                                              
> }; 
> 
> for flags that are used with set_bit() and friends? That's just
> misleading, should be 0, 1, etc, not a shift.
> 
> The rest looks pretty straight forward, but the above is an eye sore.

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e0577bf33f45..0a8af4daef89 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -31,8 +31,8 @@
 
 
 enum nvme_fc_queue_flags {
-	NVME_FC_Q_CONNECTED = (1 << 0),
-	NVME_FC_Q_LIVE = (1 << 1),
+	NVME_FC_Q_CONNECTED = 0,
+	NVME_FC_Q_LIVE,
 };
 
 #define NVMEFC_QUEUE_DELAY	3		/* ms units */

-- 
Jens Axboe
