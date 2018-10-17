From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Oct 2018 18:37:20 +0200
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
Message-ID: <20181017163720.GA23798@lst.de>

On Wed, Oct 03, 2018@02:05:16PM -0500, Steve Wise wrote:
> Christoph, Sagi:  it seems you think /proc/irq/$IRP/smp_affinity
> shouldn't be allowed if drivers support managed affinity. Is that correct?

Not just shouldn't, but simply can't.

> But as it stands, things are just plain borked if an rdma driver
> supports ib_get_vector_affinity() yet the admin changes the affinity via
> /proc...

I think we need to fix ib_get_vector_affinity to not return anything
if the device doesn't use managed irq affinity.
