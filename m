From: james.smart@broadcom.com (James Smart)
Date: Mon, 22 Aug 2016 10:29:38 -0700
Subject: [PATCH 5/5] nvme-fabrics: Add FC LLDD loopback driver to test FC
 host and target transport
In-Reply-To: <20160811212336.GH18013@infradead.org>
References: <5792b91f.Lb5BdNQrSWnmgOYG%james.smart@broadcom.com>
 <20160811212336.GH18013@infradead.org>
Message-ID: <de5d47f0-3d47-8004-19ed-0cb2f39c9aa3@broadcom.com>



On 8/11/2016 2:23 PM, Christoph Hellwig wrote:
> On Fri, Jul 22, 2016@05:23:59PM -0700, James Smart wrote:
>> Add FC LLDD loopback driver to test FC host and target transport within
>> nvme-fabrics
>>
>> To aid in the development and testing of the lower-level api of the FC
>> transport, this loopback driver has been created to act as if it were a
>> FC hba driver supporting both the host interfaces as well as the target
>> interfaces with the nvme FC transport.
> A proper FC loop device should support SCSI and NVMe.  Any chance to
> morph it into one that does both?

Nope. Not really appropriate for this module, whose goals were to test 
the fc-nvme interfaces. SCSI is a whole different beast.

-- james
