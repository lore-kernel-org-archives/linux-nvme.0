From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 29 Jun 2017 16:45:07 +0200
Subject: [PATCH] nvme-rdma: stop keep_alive before nvme_uninit_ctrl
In-Reply-To: <1498746799-34110-1-git-send-email-dmilburn@redhat.com>
References: <1498746799-34110-1-git-send-email-dmilburn@redhat.com>
Message-ID: <20170629144507.GS3808@linux-x5ow.site>

On Thu, Jun 29, 2017@09:33:19AM -0500, David Milburn wrote:
> Its possible for nvme_keep_alive_work() to hit an error
> condition after the nvme_uninit_ctrl() in __nvme_rdma_remove_ctrl().
> This can lead to usage of NULL pointer in "dev_err(ctrl->device..."
> since device has been destroyed by nvme_uninit_ctrl().
> 
> This has been seen during continous loop of (discover, connect,
> IO, disconnect).

Why can't we stop the keepalive work in nvme core and get rid of the stopping
in fc.c as well?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
