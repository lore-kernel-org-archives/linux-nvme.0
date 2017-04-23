From: hch@lst.de (Christoph Hellwig)
Date: Sun, 23 Apr 2017 09:40:11 +0200
Subject: [PATCH 5/7] nvmet/fc: mark the sqhd field as __le16
In-Reply-To: <01043680-3084-a345-96b1-9820a45f3ed6@broadcom.com>
References: <20170421085005.5945-1-hch@lst.de>
 <20170421085005.5945-6-hch@lst.de>
 <01043680-3084-a345-96b1-9820a45f3ed6@broadcom.com>
Message-ID: <20170423074011.GB20524@lst.de>

On Fri, Apr 21, 2017@06:17:08PM -0700, James Smart wrote:
> This is fine, but this also highlights several different areas where sqhd 
> is referenced and endianness wasn't accounted for.  So I'll need to make a 
> complimentary patch.

All the assignments to/from it are already to __le16 values.
