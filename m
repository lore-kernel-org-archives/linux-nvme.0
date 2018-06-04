From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 4 Jun 2018 09:18:29 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180604081921.3cedecbc@pentland.suse.de>
References: <20180525135813.GB9591@redhat.com> <20180525141211.GA25971@lst.de>
 <20180525145056.GD9591@redhat.com> <yq1muwj45sg.fsf@oracle.com>
 <20180529030236.GA28895@redhat.com>
 <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
 <20180529080952.GA1369@lst.de> <20180529232718.GA1730@redhat.com>
 <f4951571-d37d-73cd-1d6c-0ca84647d5ac@kernel.dk>
 <20180604081921.3cedecbc@pentland.suse.de>
Message-ID: <20180604071829.tq7wmx4bvk4uzubd@linux-x5ow.site>

On Mon, Jun 04, 2018@08:19:21AM +0200, Hannes Reinecke wrote:
> Without it we're having a choice of disappointing (paying) customers or
> disappointing the upstream community.

I personally think (regardless of the fact, that I wrote the patch
under discussion), using the module parameter is sufficient for these
kind of customers. For me it's an either/or kind of setting (either
native or dm-mpath).

Downstream distributions could still carry a small patch flipping the
default to off if they want to maintain backwards compatibility with
existing dm-mpath setups (which for NVMe I doubt there are many!).

What we really should do is, try to give multipath-tools a 'nvme
list-subsys' like view of nvme native multipathing (and I think Martin
W. has already been looking into this a while ago).


   Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
