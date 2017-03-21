From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 21 Mar 2017 09:43:58 -0400
Subject: [PATCH 1/2] nvme-rdma: fix module_init (theoretical) error path
In-Reply-To: <1489897752-16691-1-git-send-email-sagi@grimberg.me>
References: <1489897752-16691-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170321134358.GD30013@linux-x5ow.site>

On Sun, Mar 19, 2017@06:29:11AM +0200, Sagi Grimberg wrote:
> If nvmf_register_transport happened to fail
> (it can't, but theoretically) we leak memory.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
