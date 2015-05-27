From: storagepavilion@gmail.com (Pavilion Storage)
Date: Wed, 27 May 2015 15:40:31 -0700
Subject: Problems writing to intel P3700 NVMe drive
In-Reply-To: <00c601d098cd$41255e30$c3701a90$@storageio.com>
References: <CAFMq3wEyk9PMbD8Cgn5trJyDjaOKpMzR-TNzbx0zXN=Mms573Q@mail.gmail.com>
 <00c601d098cd$41255e30$c3701a90$@storageio.com>
Message-ID: <CAFMq3wE7PzKs=dYxxUhFsHeTkR0CT8mh6NVfrk-9mKxdisoDTg@mail.gmail.com>

Greg,
I am running this on Linux (Ubuntu/3.12) and I am accessing the raw
device (/dev/nvme1).

I have tried accessing with dd, nvme-cli and fio
Thx
Kishore

On Wed, May 27, 2015@3:34 PM, Greg Schulz <greg@storageio.com> wrote:
> I may have missed it somewhere, what OS (and version) are you using?
> Also are you accessing the nvme device e.g. /dev/nvme0n1 raw or via
> partition or filesystem?
> Gs
>
>
> Greg Schulz  |  Sr. Advisory Analyst  |  greg at storageio.com
> Phone 651-275-1563  |  twitter @storageio  |  blog www.storageioblog.com
> Server StorageIO and UnlimitedIO LLC aka StorageIO  |  www.storageio.com
>
> Author of the books:
> Cloud and Virtual Data Storage Network (CRC Press & Intel Recommended
> Reading List) The Green and Virtual Data Center (CRC Press & Intel
> Recommended Reading List) Resilient Storage Networks ? Designing Flexible
> Scalable Data Infrastructures (Elsevier)
>
> The information contained in this email and any attachments is confidential
> and may be legally privileged and or confidential. If you are not the
> intended recipient then you must not use, disseminate, distribute copy or in
> any other way use, the information contained in this email or attachments.
> If you receive this email in error, destroy it immediately and contact
> us. Thank you.
>
> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Pavilion Storage
> Sent: Wednesday, May 27, 2015 4:30 PM
> To: linux-nvme at lists.infradead.org
> Subject: Problems writing to intel P3700 NVMe drive
>
> I am having problems with writing to an intel P3700 NVMe drive on a ARM
> based platform and I would appreciate any help in debugging this problem.
> Here are my experiments and observations so far:
>
>    - The drive is usable for read operations and I can run fio (randread,
> etc) but I cannot write to it.
>    - Other manufacturer's NVMe drive can be inserted into this platform and
> I can write to it
>    - I can insert the intel P3700 into an x86 host and I can perform write
> operations
>    - I have tried using the nvme-cli
> (https://github.com/linux-nvme/nvme-cli) tool and have read the error codes
> from read. It just shows 'WRITE_FAULT' which is not very helpful.
>    - I have looked at the SmartLog reports and the 'Critical Warning'
> is 0, i.e. the device is not in Read-Only mode
>    - I have updated the firmware using the intel SSD-DataCenterTool and
> updated the firmware on the drive the latest available version.
> The updated drive works fine on x86 platform.
>
> I think there is some combination of the platform and drive that is causing
> the problem. Can anyone offer pointers on how to debug this?
>
> Thx
> Kishore
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
