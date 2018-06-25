From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 25 Jun 2018 09:08:51 +0200
Subject: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
In-Reply-To: <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
References: <20180611184630.3435-1-jthumshirn@suse.de>
 <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
Message-ID: <20180625070850.jdl7mudz6o6diwsj@linux-x5ow.site>

On Tue, Jun 19, 2018@05:09:27PM +0300, Sagi Grimberg wrote:
> We are going to need it for traffic based keep alive to update
> that we saw a completion to extend the kato.
> 
> But I suggest you simply keep a ctrl reference in struct nvme_request
> instead so you don't need to pass it to nvme_complete_req (that's what
> I did for traffic based keep alive).

Do you have a patch for this around? IIRC I started this (as Christoph
also suggested it) but it turned out to be quite a big refactoring
work.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
