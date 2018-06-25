From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 25 Jun 2018 16:03:00 +0200
Subject: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
In-Reply-To: <d4786519-1695-25a0-dbf5-5d6cb9809539@grimberg.me>
References: <20180611184630.3435-1-jthumshirn@suse.de>
 <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
 <20180625070850.jdl7mudz6o6diwsj@linux-x5ow.site>
 <d4786519-1695-25a0-dbf5-5d6cb9809539@grimberg.me>
Message-ID: <20180625140300.rebclfa6pa6mtsat@linux-x5ow.site>

On Mon, Jun 25, 2018@04:31:28PM +0300, Sagi Grimberg wrote:
> 
> 
> On 06/25/2018 10:08 AM, Johannes Thumshirn wrote:
> > On Tue, Jun 19, 2018@05:09:27PM +0300, Sagi Grimberg wrote:
> > > We are going to need it for traffic based keep alive to update
> > > that we saw a completion to extend the kato.
> > > 
> > > But I suggest you simply keep a ctrl reference in struct nvme_request
> > > instead so you don't need to pass it to nvme_complete_req (that's what
> > > I did for traffic based keep alive).
> > 
> > Do you have a patch for this around? IIRC I started this (as Christoph
> > also suggested it) but it turned out to be quite a big refactoring
> > work.
> 
> How about the below? patch #1 is what you are looking for, patch #2 is
> a slightly modified version that applies on #1. Let me know what you
> think...

Looks good (both #1 if we want to use the two patch version or #2).

I have no idea what I did when I was trying to do when I tried it.

  Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
