From: hch@lst.de (Christoph Hellwig)
Date: Fri, 10 Mar 2017 23:08:27 +0100
Subject: [PATCH RFC 2/4] nvme-fabrics: add target support for TCP transport
In-Reply-To: <5b315c79-53a4-090d-db5e-dbbc3f333793@solarflare.com>
References: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
 <5b315c79-53a4-090d-db5e-dbbc3f333793@solarflare.com>
Message-ID: <20170310220827.GB25489@lst.de>

On Fri, Mar 10, 2017@11:31:16AM +0000, Bert Kenward wrote:
> Memory is currently allocated as zero-order pages. It's possible
> that using higher order pages may be desirable, trading potential
> allocation latency for less fragmented SKBs on transmit.

FYI, that would be a useful optimization for RDMA as well.  I know
SCST had some sophisticated code for doing nice SGL allocations and
caching, maybe it's time to get that upstream.  Bart, is that something you'd
be interested in looking into?
