From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 9 Mar 2017 14:52:20 +0100
Subject: [PATCH rfc 07/10] nvme-rdma: Don't rearm the CQ when polling
 directly
In-Reply-To: <1489065402-14757-8-git-send-email-sagi@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-8-git-send-email-sagi@grimberg.me>
Message-ID: <1999891a-f19a-f705-705c-98afed65497b@suse.de>

On 03/09/2017 02:16 PM, Sagi Grimberg wrote:
> We don't need it as the core polling context will take
> are of rearming the completion queue.
 ^ care?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
