From: hch@lst.de ('Christoph Hellwig')
Date: Mon, 7 Nov 2016 19:51:02 +0100
Subject: nvmet_rdma crash - DISCONNECT event with NULL queue
In-Reply-To: <1478544616.3350.29.camel@linux.intel.com>
References: <01d901d2345f$da0d2e00$8e278a00$@opengridcomputing.com>
 <1d09c064-1cbe-7e6e-43d2-cfa6cf0c19ea@grimberg.me>
 <024e01d23476$6668b890$333a29b0$@opengridcomputing.com>
 <3512b8bb-4d29-b90a-49e1-ebf1085c47d7@grimberg.me>
 <004601d2351a$d9db85b0$8d929110$@opengridcomputing.com>
 <20161102151540.GB14825@lst.de>
 <bd82c206-668a-0794-2d51-3c48058350d3@grimberg.me>
 <1478543378.3350.17.camel@linux.intel.com> <20161107184126.GA4400@lst.de>
 <1478544616.3350.29.camel@linux.intel.com>
Message-ID: <20161107185102.GA4820@lst.de>

On Mon, Nov 07, 2016@10:50:16AM -0800, J Freyensee wrote:
> OK, so basically the nvmet change would be to make sure unique cntlids
> are used across all NVM subsystems within the NVMe Target then?

Yes.
