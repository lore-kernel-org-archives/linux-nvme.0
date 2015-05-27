From: storagepavilion@gmail.com (Pavilion Storage)
Date: Wed, 27 May 2015 14:30:01 -0700
Subject: Problems writing to intel P3700 NVMe drive
Message-ID: <CAFMq3wEyk9PMbD8Cgn5trJyDjaOKpMzR-TNzbx0zXN=Mms573Q@mail.gmail.com>

I am having problems with writing to an intel P3700 NVMe drive on a
ARM based platform and I would appreciate any help in debugging this
problem. Here are my experiments and observations so far:

   - The drive is usable for read operations and I can run fio
(randread, etc) but I cannot write to it.
   - Other manufacturer's NVMe drive can be inserted into this
platform and I can write to it
   - I can insert the intel P3700 into an x86 host and I can perform
write operations
   - I have tried using the nvme-cli
(https://github.com/linux-nvme/nvme-cli) tool and have read the error
codes from read. It just shows 'WRITE_FAULT' which is not very
helpful.
   - I have looked at the SmartLog reports and the 'Critical Warning'
is 0, i.e. the device is not in Read-Only mode
   - I have updated the firmware using the intel SSD-DataCenterTool
and updated the firmware on the drive the latest available version.
The updated drive works fine on x86 platform.

I think there is some combination of the platform and drive that is
causing the problem. Can anyone offer pointers on how to debug this?

Thx
Kishore
