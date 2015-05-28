From: storagepavilion@gmail.com (Pavilion Storage)
Date: Wed, 27 May 2015 17:46:55 -0700
Subject: Problems writing to intel P3700 NVMe drive
In-Reply-To: <CAFMq3wEa=kxznE77oFdg03QBHqszmH5-Vvmmm9pW1nkPUZi_Og@mail.gmail.com>
References: <CAFMq3wEyk9PMbD8Cgn5trJyDjaOKpMzR-TNzbx0zXN=Mms573Q@mail.gmail.com>
 <00c601d098cd$41255e30$c3701a90$@storageio.com>
 <CAFMq3wE7PzKs=dYxxUhFsHeTkR0CT8mh6NVfrk-9mKxdisoDTg@mail.gmail.com>
 <00cd01d098d1$94047010$bc0d5030$@storageio.com>
 <CAFMq3wEa=kxznE77oFdg03QBHqszmH5-Vvmmm9pW1nkPUZi_Og@mail.gmail.com>
Message-ID: <CAFMq3wFa6LciFQrg-jx8=2eCqsaNHL8xFBGfn6w1Y0-CoGcoQg@mail.gmail.com>

Greg
I have verified that the same drive is working in an x86 system with
the same firmware. Also, this appears to be a problem with multiple
intel P3700 SSD drives, not just one. I have tried other manufacturers
drives in the same slots on our ARM platform and verified that the
platform (and the slot) is working.

Yes, these are PCIe x4 Gen3 slots.

>From the error log the (StatusField.SCT and StatusField.SC appear to
0x2 and 0x80) which for a write command is LBA out of range, but that
does not make sense because the error is the same regardless of the
LBA address used.

thx
Kishore

On Wed, May 27, 2015@5:09 PM, Greg Schulz <greg@storageio.com> wrote:
> Interesting, have you tried the bad card in a different x86 based server to see if it is the card?
> Also, if the card is good, yet wont write in the specific server, have you checked the servers BIOS, granted if you have one card working and one not, that?s a different ball game.
> Not sure if there is an ARM variation of the intel UEFI sysinfo tool that would give you more info.
> Whats not clear is if you are getting an actual write protect error or simply a write fault.
> Write protect are usually an indicator of something actually wrong with the underlying nand flash, or its FTL and with a good controller, it will try to work around before giving up.
> Write fault could be a write-protect, however could also be a driver, bios, firmware or even PCIe slot issue.
> Have not tried the 3700 in a PCIe G2 slot, assume you have them in a PCIe G3 slot or riser?
> Good luck
> Cheers
> Gs
>

On Wed, May 27, 2015 at 4:53 PM, Pavilion Storage
<storagepavilion@gmail.com> wrote:
> Greg
>
> Here is the output from the dd command on a good (non-intel;
> /dev/nvme0n1) and bad (intel drive; /dev/nvme1n1). There is no
> difference in displayed output of dd, but the write is successful in
> the non-intel drive. The nvme-cli command tool correctly shows the
> failure to write, but offers no further clues beyond the failed
> status.
>
> thx
> Kishore
>
> -------------------------------------------------------
> [root]# dd if=/dev/null of=/dev/nvmen0n1 bs=512 count=1000000 conv=notrunc
> 0+0 records in
> 0+0 records out
> 0 bytes (0 B) copied, 1.62e-05 s, 0.0 kB/s
> [root]#
> -----------------------------------------------------
> [root]# dd if=/dev/null of=/dev/nvme1n1 bs=512 count=1000000 conv=notrunc
> 0+0 records in
> 0+0 records out
> 0 bytes (0 B) copied, 0.00032024 s, 0.0 kB/s
> [root]#
> ---------------------------------------------------------
> [root]# ./nvme-cli write /dev/nvme0n1 -s 0 -z 4096 -d /dev/null
> write: success
> [root]# ./nvme-cli write /dev/nvme1n1 -s 0 -z 4096 -d /dev/null
> write:WRITE_FAULT(2280)
> ---------------------------------------------------------
>
> On Wed, May 27, 2015@4:05 PM, Greg Schulz <greg@storageio.com> wrote:
>> Thanks for the follow-up and extra info, I have 3700s running on x86/64 Ubuntu 14.04 and working fine.
>> I did update the drivers from the Intel site even though they were already in the 14.04 kernel when I was troubel shooting something else.
>> What happens if you do a dd if=/dev/null of=/dev/nvme0n1 bs=512 count=1000000 conv=notrunc
>> Cheers gs
>>
>>
>> -----Original Message-----
>> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Pavilion Storage
>> Sent: Wednesday, May 27, 2015 5:41 PM
>> To: greg at storageio.com
>> Cc: linux-nvme at lists.infradead.org
>> Subject: Re: Problems writing to intel P3700 NVMe drive
>>
>> Greg,
>> I am running this on Linux (Ubuntu/3.12) and I am accessing the raw device (/dev/nvme1).
>>
>> I have tried accessing with dd, nvme-cli and fio Thx Kishore
>>
>> On Wed, May 27, 2015@3:34 PM, Greg Schulz <greg@storageio.com> wrote:
>>> I may have missed it somewhere, what OS (and version) are you using?
>>> Also are you accessing the nvme device e.g. /dev/nvme0n1 raw or via
>>> partition or filesystem?
>>> Gs
>>>
>>>
>>> Greg Schulz  |  Sr. Advisory Analyst  |  greg at storageio.com Phone
>>> 651-275-1563  |  twitter @storageio  |  blog www.storageioblog.com
>>> Server StorageIO and UnlimitedIO LLC aka StorageIO  |
>>> www.storageio.com
>>>
>>> Author of the books:
>>> Cloud and Virtual Data Storage Network (CRC Press & Intel Recommended
>>> Reading List) The Green and Virtual Data Center (CRC Press & Intel
>>> Recommended Reading List) Resilient Storage Networks ? Designing
>>> Flexible Scalable Data Infrastructures (Elsevier)
>>>
>>> The information contained in this email and any attachments is
>>> confidential and may be legally privileged and or confidential. If you
>>> are not the intended recipient then you must not use, disseminate,
>>> distribute copy or in any other way use, the information contained in this email or attachments.
>>> If you receive this email in error, destroy it immediately and contact
>>> us. Thank you.
>>>
>>> -----Original Message-----
>>> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
>>> Behalf Of Pavilion Storage
>>> Sent: Wednesday, May 27, 2015 4:30 PM
>>> To: linux-nvme at lists.infradead.org
>>> Subject: Problems writing to intel P3700 NVMe drive
>>>
>>> I am having problems with writing to an intel P3700 NVMe drive on a
>>> ARM based platform and I would appreciate any help in debugging this problem.
>>> Here are my experiments and observations so far:
>>>
>>>    - The drive is usable for read operations and I can run fio
>>> (randread,
>>> etc) but I cannot write to it.
>>>    - Other manufacturer's NVMe drive can be inserted into this
>>> platform and I can write to it
>>>    - I can insert the intel P3700 into an x86 host and I can perform
>>> write operations
>>>    - I have tried using the nvme-cli
>>> (https://github.com/linux-nvme/nvme-cli) tool and have read the error
>>> codes from read. It just shows 'WRITE_FAULT' which is not very helpful.
>>>    - I have looked at the SmartLog reports and the 'Critical Warning'
>>> is 0, i.e. the device is not in Read-Only mode
>>>    - I have updated the firmware using the intel SSD-DataCenterTool
>>> and updated the firmware on the drive the latest available version.
>>> The updated drive works fine on x86 platform.
>>>
>>> I think there is some combination of the platform and drive that is
>>> causing the problem. Can anyone offer pointers on how to debug this?
>>>
>>> Thx
>>> Kishore
>>>
>>> _______________________________________________
>>> Linux-nvme mailing list
>>> Linux-nvme at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>
