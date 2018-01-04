From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 4 Jan 2018 12:08:18 -0700
Subject: [PATCH 07/12] nvme-pci: clean up CMB initialization
In-Reply-To: <20180104190137.7654-8-logang@deltatee.com>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-8-logang@deltatee.com>
Message-ID: <078f4435-22ac-1ff7-0b91-5022e22d126e@deltatee.com>



On 04/01/18 12:01 PM, Logan Gunthorpe wrote:
> From: Christoph Hellwig <hch at lst.de>
> 
> Refactor the call to nvme_map_cmb, and change the conditions for probing
> for the CMB.  First remove the version check as NVMe TPs always apply
> to earlier versions of the spec as well.  Second check for the whole CMBSZ
> register for support of the CMB feature instead of just the size field
> inside of it to simplify the code a bit.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Oops, I forgot:

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
