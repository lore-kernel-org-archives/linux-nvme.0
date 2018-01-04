From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 4 Jan 2018 12:08:29 -0700
Subject: [PATCH 08/12] nvme-pci: clean up SMBSZ bit definitions
In-Reply-To: <20180104190137.7654-9-logang@deltatee.com>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-9-logang@deltatee.com>
Message-ID: <4432ed79-e463-e868-64af-0f130dafb261@deltatee.com>



On 04/01/18 12:01 PM, Logan Gunthorpe wrote:
> From: Christoph Hellwig <hch at lst.de>
> 
> Define the bit positions instead of macros using the magic values,
> and move the expanded helpers to calculate the size and size unit into
> the implementation C file.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Oops, I forgot:

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
