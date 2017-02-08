From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Feb 2017 14:36:32 +0100
Subject: [PATCH 4/4] nvme: support ranged discard requests
In-Reply-To: <CANvN+ekrmaCZaYt02wX1DRz4+hTLicjyP-tYDTTcKsWe2Lo5MQ@mail.gmail.com>
References: <20170208131343.4003-1-hch@lst.de>
 <20170208131343.4003-5-hch@lst.de>
 <CANvN+ekrmaCZaYt02wX1DRz4+hTLicjyP-tYDTTcKsWe2Lo5MQ@mail.gmail.com>
Message-ID: <20170208133632.GA13064@lst.de>

On Wed, Feb 08, 2017@01:32:22PM +0000, Andrey Kuzmin wrote:
> On Wed, Feb 8, 2017, 16:14 Christoph Hellwig <hch@lst.de> wrote:
> 
> > NVMe supports up to 255 ranges per DSM command,
> 
> 
> 256 per spec, with number of ranges being zero-based.

You're right.  I'll do another round of the patch.  That beeing
said in my tests I never even managed to get three-digit ranges
anyway with any workload.
