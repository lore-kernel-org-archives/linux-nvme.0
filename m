From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Aug 2016 14:23:36 -0700
Subject: [PATCH 5/5] nvme-fabrics: Add FC LLDD loopback driver to test FC
 host and target transport
In-Reply-To: <5792b91f.Lb5BdNQrSWnmgOYG%james.smart@broadcom.com>
References: <5792b91f.Lb5BdNQrSWnmgOYG%james.smart@broadcom.com>
Message-ID: <20160811212336.GH18013@infradead.org>

On Fri, Jul 22, 2016@05:23:59PM -0700, James Smart wrote:
> 
> Add FC LLDD loopback driver to test FC host and target transport within
> nvme-fabrics
> 
> To aid in the development and testing of the lower-level api of the FC
> transport, this loopback driver has been created to act as if it were a
> FC hba driver supporting both the host interfaces as well as the target
> interfaces with the nvme FC transport.

A proper FC loop device should support SCSI and NVMe.  Any chance to
morph it into one that does both?
