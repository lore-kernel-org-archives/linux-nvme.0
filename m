From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Oct 2017 13:07:18 +0200
Subject: [PATCH 4.14-rc fix-regression] nvme-rdma: Fix possible double
 free in reconnect flow
In-Reply-To: <1508410857-13678-1-git-send-email-sagi@grimberg.me> (Sagi
 Grimberg's message of "Thu, 19 Oct 2017 14:00:57 +0300")
References: <1508410857-13678-1-git-send-email-sagi@grimberg.me>
Message-ID: <mqd1slzbdll.fsf@linux-x5ow.site>

Sagi Grimberg <sagi at grimberg.me> writes:

> The fact that we free the async event buffer in
> nvme_rdma_destroy_admin_queue can cause us to free it
> more than once because this happens in every reconnect
> attempt (we rely on the queue state flags DELETING
> to avoid this for other resources).

Do you appen to know which commit introduced the regression? A fixes
line/tag would be really nice here.

Thanks,
        Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
