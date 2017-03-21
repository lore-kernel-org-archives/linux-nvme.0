From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 21 Mar 2017 09:44:32 -0400
Subject: [PATCH 2/2] nvme-loop: fix module_init (theoretical) error path
In-Reply-To: <1489897752-16691-2-git-send-email-sagi@grimberg.me>
References: <1489897752-16691-1-git-send-email-sagi@grimberg.me>
 <1489897752-16691-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170321134432.GE30013@linux-x5ow.site>

On Sun, Mar 19, 2017@06:29:12AM +0200, Sagi Grimberg wrote:
> if nvmf_register_transport happend to fail, we
> need to nvmet_unregister_transport as well.
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
