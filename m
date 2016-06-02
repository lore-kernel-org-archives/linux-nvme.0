From: hiroysato@gmail.com (Hiroyuki Sato)
Date: Thu, 2 Jun 2016 16:26:51 +0900
Subject: RAID0 mdadm Question
In-Reply-To: <574E9B89.60109@intel.com>
References: <CA+Tq-RoTOSwAbJJFBgkDEC8LV-CiFOHKvbC3i3tkUUoxu03ziQ@mail.gmail.com>
 <574D9790.1080106@intel.com>
 <CA+Tq-Rr9yU1VNr-XQ=S5_hnP0saZz7poc8SCESaidZ43Wmak+w@mail.gmail.com>
 <574E9B89.60109@intel.com>
Message-ID: <CA+Tq-Rpha3uXbdYKMQkyKM-R0cfofgU-PN1AwapL8F5WRb8PFA@mail.gmail.com>

Hello Artur.

Thank you for replying.

I've succeed to mount that filesystem again.
I re-create label and partition. and mount it.

Thanks again.





2016-06-01 17:23 GMT+09:00 Artur Paszkiewicz <artur.paszkiewicz at intel.com>:
> On 06/01/2016 04:08 AM, Hiroyuki Sato wrote:
>> Hello Artur
>>
>> Thank you for your replying.
>>
>> I found /dev/md126. But It does not contain partition information.
>> I'm not sure why partition information lost.
>>
>> Could you tell me if you know any other commands?
>>
>> Best regards.
>>
>>
>> Step1 scan drives
>>
>>   mdadm --assemble --scan
>>   mdadm: Container /dev/md/imsm0 has been assembled with 2 drives
>>   mdadm: Started /dev/md/0_0 with 2 devices
>>
>>
>>   # cat /proc/mdstat
>>   Personalities : [raid0]
>>   md127 : inactive nvme0n1[1](S) nvme1n1[0](S)
>>         6306 blocks super external:imsm
>>
>>   md126 : active raid0 nvme1n1[1] nvme0n1[0]
>>         781416448 blocks super external:/md127/0 128k chunks
>>
>>   unused devices: <none>
>>
>> Step2 check partition information
>>
>>   parted /dev/md126
>>   GNU Parted 3.1
>>   Using /dev/md126
>>   Welcome to GNU Parted! Type 'help' to view a list of commands.
>>   (parted) p
>>   Error: /dev/md126: unrecognised disk label
>>   Model: Linux Software RAID Array (md)
>>   Disk /dev/md126: 800GB
>>   Sector size (logical/physical): 512B/512B
>>   Partition Table: unknown
>>   Disk Flags:
>>
>> 2016-05-31 22:54 GMT+09:00 Artur Paszkiewicz <artur.paszkiewicz at intel.com>:
>>> On 05/31/2016 11:41 AM, Hiroyuki Sato wrote:
>>>> Hello
>>>>
>>>> NVMe Newbie question.
>>>>
>>>> I have two P3600 PCIe NVMe Cards.
>>>> And I created RAID0 volume with mdadm command.
>>>> It works fine. But after reboot, I can't mount file system it.
>>>> It seems lost partition table.
>>>> (No partition information)
>>>>
>>>> Environment
>>>>   - NVMe: Intel P3600 cards * 2
>>>>   - Linux: 4.4.0
>>>>   - OS: CentOS7
>>>>
>>>> Question
>>>>
>>>>   1, Do I need re-create file system on each Boot time?
>>>>
>>>>   2, If not What step is missing?
>>>>
>>>>     generate mdadm.conf?
>>>>
>>>> Best regards.
>>>>
>>>> NVMe RAID step
>>>>
>>>>   Basically I followed this doc
>>>>     https://communities.intel.com/community/itpeernetwork/blog/2015/10/01/how-to-use-and-benchmark-nvme-ssd-create-a-software-raid-and-analyze-performance-the-answers-are-here
>>>>
>>>>   Step1: create container
>>>>
>>>>     mdadm -C /dev/md/imsm0 /dev/nvme0n1 /dev/nvme1n1 -n 2 -e imsm -f
>>>>     mdadm: /dev/nvme0n1 appears to be part of a raid array:
>>>>            level=raid0 devices=0 ctime=Thu Jan  1 09:00:00 1970
>>>>     Continue creating array? y
>>>>     mdadm: container /dev/md/imsm0 prepared.
>>>>
>>>>   Step2, create md device
>>>>     mdadm -C /dev/md0 /dev/md/imsm0 -n 2 -l 0 -c 128 -f
>>>>     mdadm: array /dev/md0 started.
>>>>
>>>>   Step3: Create Partition
>>>>     parted /dev/md0
>>>>
>>>>     (parted) mkpart
>>>>     Partition name?  []?
>>>>     File system type?  [ext2]? xfs
>>>>     Start? 0%
>>>>     End? -1
>>>>
>>>>     (parted) p
>>>>     Model: Linux Software RAID Array (md)
>>>>     Disk /dev/md0: 800GB
>>>>     Sector size (logical/physical): 512B/512B
>>>>     Partition Table: gpt
>>>>     Disk Flags:
>>>>
>>>>     Number  Start   End    Size   File system  Name  Flags
>>>>      1      1049kB  800GB  800GB
>>>>
>>>>     (parted) quit
>>>>     Information: You may need to update /etc/fstab.
>>>>
>>>>   Step4: Newfs
>>>>
>>>>     /sbin/mkfs.xfs -K /dev/md0p1 -f
>>>>
>>>>   Step5: mount
>>>>
>>>>     mount -o noatime,nodiratime,nobarrier /dev/md0p1 /mnt/nvme1
>
> I don't see a step where you create a partition table, so maybe it's
> reusing a gpt table that was present on the first device and that is
> causing problems. Please try writing a fresh partition table between
> steps 2 and 3 like this:
> # parted /dev/md0 mklabel gpt
>



-- 
Hiroyuki Sato
