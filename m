From: olivier.mallinger@ip-maker.com (Olivier Mallinger - IP Maker)
Date: Wed, 2 Mar 2016 18:32:41 +0100
Subject: Tested LBA size ?
Message-ID: <56D723B9.6030004@ip-maker.com>

Hello.

Does anyone already experience to use a NVMe SSD with a namespace 
defined with a  LBA size higher or equal to 8kB.
I successfully tested a device with LBA sizes of 512 bytes, 1kB, 2kB or 4kB.
But when I use a LBA size of 8kB, the NVMe initialization is good but I 
can not see any read command access to drive after.
The controller is enable but the host does not perform any access expect 
for CSTS read.
My host page size is 4kB.

Any idea (bad configuration, ...) ? I don't understand what is expecting 
the driver.
Thanks.
Regards.
Olivier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: olivier_mallinger.vcf
Type: text/x-vcard
Size: 316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160302/e2256369/attachment.vcf>
