From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Jun 2018 14:59:18 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180604071829.tq7wmx4bvk4uzubd@linux-x5ow.site>
References: <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com> <20180529030236.GA28895@redhat.com>
 <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
 <20180529080952.GA1369@lst.de> <20180529232718.GA1730@redhat.com>
 <f4951571-d37d-73cd-1d6c-0ca84647d5ac@kernel.dk>
 <20180604081921.3cedecbc@pentland.suse.de>
 <20180604071829.tq7wmx4bvk4uzubd@linux-x5ow.site>
Message-ID: <20180604125918.GC30945@lst.de>

On Mon, Jun 04, 2018@09:18:29AM +0200, Johannes Thumshirn wrote:
> What we really should do is, try to give multipath-tools a 'nvme
> list-subsys' like view of nvme native multipathing (and I think Martin
> W. has already been looking into this a while ago).

Which has been merged into multipath-tools a while ago:

https://git.opensvc.com/gitweb.cgi?p=multipath-tools/.git;a=commit;h=86553b57b6bd55e0355ac27ae100cce6cc42bee3
