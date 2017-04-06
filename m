From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 6 Apr 2017 20:17:43 +0200
Subject: [PATCH v2] nvme_fc: avoid double kfree(), don't call
 nvme_cleanup_cmd() in nvme_fc_unmap_data()
In-Reply-To: <1491497276-15944-1-git-send-email-emilne@redhat.com>
References: <1491497276-15944-1-git-send-email-emilne@redhat.com>
Message-ID: <20170406181743.GB8215@linux-x5ow.site>

On Thu, Apr 06, 2017@12:47:56PM -0400, Ewan Milne wrote:
> nvme_cleanup_cmd() is already called by callers of nvme_fc_unmap_data().
> Don't call it twice to avoid double-free on completion of discard commands.
> 
> v2:
> Move nvme_cleanup_cmd() call *after* nvme_fc_unmap_data() for consistency.
> 
> Signed-off-by: Ewan D. Milne <emilne at redhat.com>
> ---

Thanks,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
