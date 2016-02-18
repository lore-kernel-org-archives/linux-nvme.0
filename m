From: hch@lst.de (Christoph Hellwig)
Date: Thu, 18 Feb 2016 14:28:56 +0100
Subject: NVMe wwid revisited
In-Reply-To: <56C5C15C.8030903@suse.de>
References: <56C5C15C.8030903@suse.de>
Message-ID: <20160218132856.GA5150@lst.de>

On Thu, Feb 18, 2016@02:04:28PM +0100, Hannes Reinecke wrote:
> Hi Keith,
> 
> I've had a look at the current NVMe implementation for SCSI VPD page
> 0x83, in order to implement a generic 'wwid' field.
> 
> And I've even looked at the NVM-Express-SCSI-Translation Reference
> version 1.1. What a mess :-(

There is a version 1.5 by now..

> So I guess they actually meant for the designator type to be of T-10
> Vendor Identification (ie designator type 1).

The 1.5 spec has actually fixed this up:

6.1.4.3 T10 Vendor ID Based Descriptor

...

DESIGNATOR TYPE  |  Shall be set to 1h indicating T10 vendor ID based format.

> Which, of course, raises the question: What _is_ the correct
> identification?
> Implement it according to the translation spec, leaving out the 'T10
> Vendor Identification' field?
> Or implement it with the correct designator type?

Leave it as-is, given a certain Linux distributor started using it for
their udev rules and we'd otherwise break their setup.
