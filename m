From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Fri, 10 Mar 2017 22:36:44 +0000
Subject: [PATCH RFC 2/4] nvme-fabrics: add target support for TCP transport
References: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
 <5b315c79-53a4-090d-db5e-dbbc3f333793@solarflare.com>
 <20170310220827.GB25489@lst.de>
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0E2EE5@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>

On 03/10/2017 02:08 PM, Christoph Hellwig wrote:
> On Fri, Mar 10, 2017@11:31:16AM +0000, Bert Kenward wrote:
>> Memory is currently allocated as zero-order pages. It's possible
>> that using higher order pages may be desirable, trading potential
>> allocation latency for less fragmented SKBs on transmit.
> 
> FYI, that would be a useful optimization for RDMA as well.  I know
> SCST had some sophisticated code for doing nice SGL allocations and
> caching, maybe it's time to get that upstream.  Bart, is that something you'd
> be interested in looking into?

This driver looks indeed like yet another driver that could use an
SG-list + page list cache. I will have a look.

Bart.
