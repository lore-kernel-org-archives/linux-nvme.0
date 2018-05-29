From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 29 May 2018 09:22:40 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180529030236.GA28895@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com> <20180529030236.GA28895@redhat.com>
Message-ID: <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>

On Mon, May 28, 2018@11:02:36PM -0400, Mike Snitzer wrote:
> No, what both Red Hat and SUSE are saying is: cool let's have a go at
> "Plan A" but, in parallel, what harm is there in allowing "Plan B" (dm
> multipath) to be conditionally enabled to coexist with native NVMe
> multipath?

For a "Plan B" we can still use the global knob that's already in
place (even if this reminds me so much about scsi-mq which at least we
haven't turned on in fear of performance regressions).

Let's drop the discussion here, I don't think it leads to something
else than flamewars.

     Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
