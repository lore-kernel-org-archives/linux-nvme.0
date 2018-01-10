From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 10 Jan 2018 16:22:15 +0000
Subject: [PATCH 13/14] megaraid_sas: NVME passthru command support
In-Reply-To: <35aabb7a8b8ffed4040c5ac01c01fb0a@mail.gmail.com>
References: <1515159339-26790-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <20180108100531.GA6967@infradead.org>
 <35aabb7a8b8ffed4040c5ac01c01fb0a@mail.gmail.com>
Message-ID: <1515601333.2745.8.camel@wdc.com>

On Tue, 2018-01-09@22:07 +0530, Kashyap Desai wrote:
> Overall NVME support behind MR controller is really a SCSI device. On top
> of that, for MegaRaid, NVME device can be part of Virtual Disk and those
> drive will not be exposed to the driver. User application may like to talk
> to hidden NVME devices (part of VDs). This patch will extend the existing
> interface for megaraid product in the same way it is currently supported
> for other protocols like SMP, SATA pass-through.

It seems to me like there is a contradiction in the above paragraph: if some
NVMe devices are not exposed to the driver, how can a user space application
ever send NVMe commands to it?

Anyway, has it been considered to implement the NVMe support as an NVMe
transport driver? The upstream kernel already supports NVMe communication
with NVMe PCI devices, NVMe over RDMA and NVMe over FC. If communication to
the NVMe devices behind the MegaRaid controller would be implemented as an
NVMe transport driver then all functionality of the Linux NVMe driver could
be reused, including its sysfs entries.

Bart.
