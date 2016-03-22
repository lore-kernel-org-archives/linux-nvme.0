From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 Mar 2016 17:57:28 +0000
Subject: guaranteed progress for NVME commands?
In-Reply-To: <20160322144615.GA24460@localhost.localdomain>
References: <20160322074531.GA32289@infradead.org>
 <20160322144615.GA24460@localhost.localdomain>
Message-ID: <20160322175727.GA4188@localhost.localdomain>

On Tue, Mar 22, 2016@02:46:16PM +0000, Keith Busch wrote:
> I'm not sure why the driver is even considering that.
> The transfer size doesn't matter; only nr_phys_segments should determine how
> many elements the nvme_iod sgl needs to have.

err, scratch that. The size has to be accounted for when considering
PRP lists, which are unnamed fields in struct nvme_iod.
