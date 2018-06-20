From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Jun 2018 10:40:11 +0200
Subject: [PATCH 0/7] few nvme-rdma fixes for 4.18
In-Reply-To: <20180619123415.25077-1-sagi@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
Message-ID: <20180620084011.GC3284@lst.de>

On Tue, Jun 19, 2018@03:34:08PM +0300, Sagi Grimberg wrote:
> Patches 1-5 fixes some allocation/free glitches reported. patches
> 6-7 try to centralize some setup/teardown logic such that fixes
> can be applied in a single location (which can probably go to
> 4.19).

Yeah, the last two are clearly 4.19 material.

But even the ones before are pretty invasive.  I'll apply them to
nvme-4.18 for now, but I feel a bit uneasy.
