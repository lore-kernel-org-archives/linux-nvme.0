From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Apr 2018 12:35:57 +0200
Subject: [PATCH] nvme: make NVME_SC_UNWRITTEN_BLOCK a thin-provisioned
 error
In-Reply-To: <20180418123317.24da7d3e@pentland.suse.de>
References: <20180418072723.25874-1-hare@suse.de>
 <20180418101835.GA15833@lst.de> <20180418123317.24da7d3e@pentland.suse.de>
Message-ID: <20180418103557.GA16207@lst.de>

On Wed, Apr 18, 2018@12:33:17PM +0200, Hannes Reinecke wrote:
> Ah. So that's related to the DULBE bit; good to know.
> (Maybe it could be mentioned in the spec together with the definition
> in status code.)

Now that SuSE is a NVMe member you can submit clarifications to Fred
for the ECN process..
