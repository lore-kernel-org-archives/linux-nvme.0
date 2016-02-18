From: hare@suse.de (Hannes Reinecke)
Date: Thu, 18 Feb 2016 14:04:28 +0100
Subject: NVMe wwid revisited
Message-ID: <56C5C15C.8030903@suse.de>

Hi Keith,

I've had a look at the current NVMe implementation for SCSI VPD page
0x83, in order to implement a generic 'wwid' field.

And I've even looked at the NVM-Express-SCSI-Translation Reference
version 1.1. What a mess :-(

First of all, there's an error in the spec:

Section 6.1.4.3 T10 Vendor ID Based Descriptor has:

DESIGNATOR TYPE
Shall be set to 8h indicating SCSI name string format and assignment
authority.

T10 VENDOR IDENTIFICATION
Refer to 3.12

VENDOR SPECIFIC IDENTIFIER
Shall be set the concatenation of the translation of PRODUCT
IDENTIFICATION field from standard INQUIRY data as specified in
3.9, and the IEEE Extended Unique Identifier (EUI64) field of the
Identify Namespace Data Structure

This does _not_ match with T-10 usage; T-10 Vendor ID based
identification is _NOT_ a scsi name string.
And the scsi name string has to start with either 'eui.', 'naa.' or
'iqn.'. Plus the SCSI name string has to be in UTF-8, not ASCII.

So I guess they actually meant for the designator type to be of T-10
Vendor Identification (ie designator type 1).

Can you address this with the NVMe committee?
Or do you have someone which I can poke?

Which, of course, raises the question: What _is_ the correct
identification?
Implement it according to the translation spec, leaving out the 'T10
Vendor Identification' field?
Or implement it with the correct designator type?

(Which is interesting in itself; one simply _cannot_ implement a
valid translation according to the spec. How curious ...)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
