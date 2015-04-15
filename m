From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 14 Apr 2015 23:11:42 -0700
Subject: uapi/linux/nvme.h
Message-ID: <20150415061142.GA14354@infradead.org>

The NVME UAPI header contains a lot more than just the controller
definitions - it's basically the whole NVME command set.

Any reason for this?  IT's very unlike what we do for ATA and SCSI, and
fairly dangerous as we now need to make all changes to the command set
headers in a way that wouldn't break userspace software.
