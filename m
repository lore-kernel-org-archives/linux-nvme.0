From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 Dec 2015 15:26:58 +0100
Subject: namespace list locking and ioctl fixes V2
Message-ID: <1450967222-10404-1-git-send-email-hch@lst.de>

This series fixes locking for the namespace list in the
nvme controller, and also sorts out two major issue with
the ioctl interface:

 (1) it fixes access to the namespace in the NVME_IOCTL_IO_CMD ioctl
     on the character device and disables it for the unsafe case
     of a device with multiple namepaces.  It also warns about
     this usage in general.
 (2) it makes the SG_IO emulation optional.  There is no need to
     emulate SCSI commands for a Linux block device, and the
     current code actually is bigger than the rest of the NVMe
     core driver in source and binary form.  Anyone who cares
     about build size or reduce attack surface should disable
     it.  In fact I can't see any good reason to enabe it at all.

Changes since V1:
 - rebased ontop of a code move patch from Sagi, which is now included
   as new first patch in the series.
