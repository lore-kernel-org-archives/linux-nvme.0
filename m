From: kashyap.desai@broadcom.com (Kashyap Desai)
Date: Tue, 9 Jan 2018 22:07:28 +0530
Subject: [PATCH 13/14] megaraid_sas: NVME passthru command support
In-Reply-To: <20180108100531.GA6967@infradead.org>
References: <1515159339-26790-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <20180108100531.GA6967@infradead.org>
Message-ID: <35aabb7a8b8ffed4040c5ac01c01fb0a@mail.gmail.com>

Chris -

Overall NVME support behind MR controller is really a SCSI device. On top
of that, for MegaRaid, NVME device can be part of Virtual Disk and those
drive will not be exposed to the driver. User application may like to talk
to hidden NVME devices (part of VDs). This patch will extend the existing
interface for megaraid product in the same way it is currently supported
for other protocols like SMP, SATA pass-through.

Example - Current smartmon is using megaraid.h (MFI headers) to send SATA
pass-through.

https://github.com/mirror/smartmontools/blob/master/megaraid.h

Any open source application is aware of above interface can extend the
similar support for NVME drives. I agree that current nvme-cli type
interface is not going to be supported using this method.  In current
patch, driver processing is very limited since most of the work is handled
in application + FW.

NVME behind MR controller is not really NVME device to the operating
system at block layer. Considering this, do you agree or still foresee any
issues ?

Kashyap

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]
Sent: Monday, January 8, 2018 3:36 PM
To: Shivasharan S
Cc: linux-scsi at vger.kernel.org; sumit.saxena at broadcom.com;
linux-nvme at lists.infradead.org; kashyap.desai at broadcom.com
Subject: Re: [PATCH 13/14] megaraid_sas: NVME passthru command support

NAK.  Please implement the same ioctl interfaces as the nvme driver
instead of inventing your own incomaptible one.
