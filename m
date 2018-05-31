From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 31 May 2018 10:42:48 +0800
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com> <20180529030236.GA28895@redhat.com>
 <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
Message-ID: <20180531024247.GA15700@ming.t460p>

On Tue, May 29, 2018@09:22:40AM +0200, Johannes Thumshirn wrote:
> On Mon, May 28, 2018@11:02:36PM -0400, Mike Snitzer wrote:
> > No, what both Red Hat and SUSE are saying is: cool let's have a go at
> > "Plan A" but, in parallel, what harm is there in allowing "Plan B" (dm
> > multipath) to be conditionally enabled to coexist with native NVMe
> > multipath?
> 
> For a "Plan B" we can still use the global knob that's already in
> place (even if this reminds me so much about scsi-mq which at least we
> haven't turned on in fear of performance regressions).

BTW, for scsi-mq, we have made a little progress by commit 2f31115e940c
(scsi: core: introduce force_blk_mq), and virtio-scsi is working at
always scsi-mq mode now. Then driver can decide if .force_blk_mq needs
to be set.

Hope progress can be made in this nvme mpath issue too.

Thanks,
Ming
