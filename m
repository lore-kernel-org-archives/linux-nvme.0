From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 Jan 2018 08:45:40 -0800
Subject: [PATCH 13/14] megaraid_sas: NVME passthru command support
In-Reply-To: <35aabb7a8b8ffed4040c5ac01c01fb0a@mail.gmail.com>
References: <1515159339-26790-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <20180108100531.GA6967@infradead.org>
 <35aabb7a8b8ffed4040c5ac01c01fb0a@mail.gmail.com>
Message-ID: <20180109164540.GA11861@infradead.org>

On Tue, Jan 09, 2018@10:07:28PM +0530, Kashyap Desai wrote:
> Chris -
> 
> Overall NVME support behind MR controller is really a SCSI device. On top
> of that, for MegaRaid, NVME device can be part of Virtual Disk and those
> drive will not be exposed to the driver. User application may like to talk
> to hidden NVME devices (part of VDs). This patch will extend the existing
> interface for megaraid product in the same way it is currently supported
> for other protocols like SMP, SATA pass-through.
> 
> Example - Current smartmon is using megaraid.h (MFI headers) to send SATA
> pass-through.
> 
> https://github.com/mirror/smartmontools/blob/master/megaraid.h

And that is exactly the example of why we should have never allowed
megaraid any private passthrough ioctls to start with.
