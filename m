From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 2 Aug 2017 11:17:38 +0200
Subject: [PATCH 2/2] lpfc: support nvmet_fc defer_rcv callback
In-Reply-To: <20170802083220.GE4256@linux-x5ow.site>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-3-jsmart2021@gmail.com>
 <20170802083220.GE4256@linux-x5ow.site>
Message-ID: <20170802091738.GH4256@linux-x5ow.site>

On Wed, Aug 02, 2017@10:32:20AM +0200, Johannes Thumshirn wrote:
> On Tue, Aug 01, 2017@03:12:40PM -0700, James Smart wrote:
> > This patch is intended to enter the kernel through the nvme block
> > tree which pulls in the nvmet_fc api change at the same time. It is
> > not to be merged via the scsi trees without the latest nvme support
> > in it.
> 
> This should be placed below the '---' separator, so git won't pick it up and
> preserve it in the history.

Btw, I just found out and thought it's worth sharing: You can use 'git notes'
for these notes and if you use git format-patch --notes git automatically
places you r notes underneath the separator.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
