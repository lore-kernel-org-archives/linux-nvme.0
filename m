From: hiroysato@gmail.com (Hiroyuki Sato)
Date: Tue, 31 May 2016 18:41:03 +0900
Subject: RAID0 mdadm Question
Message-ID: <CA+Tq-RoTOSwAbJJFBgkDEC8LV-CiFOHKvbC3i3tkUUoxu03ziQ@mail.gmail.com>

Hello

NVMe Newbie question.

I have two P3600 PCIe NVMe Cards.
And I created RAID0 volume with mdadm command.
It works fine. But after reboot, I can't mount file system it.
It seems lost partition table.
(No partition information)

Environment
  - NVMe: Intel P3600 cards * 2
  - Linux: 4.4.0
  - OS: CentOS7

Question

  1, Do I need re-create file system on each Boot time?

  2, If not What step is missing?

    generate mdadm.conf?

Best regards.

NVMe RAID step

  Basically I followed this doc
    https://communities.intel.com/community/itpeernetwork/blog/2015/10/01/how-to-use-and-benchmark-nvme-ssd-create-a-software-raid-and-analyze-performance-the-answers-are-here

  Step1: create container

    mdadm -C /dev/md/imsm0 /dev/nvme0n1 /dev/nvme1n1 -n 2 -e imsm -f
    mdadm: /dev/nvme0n1 appears to be part of a raid array:
           level=raid0 devices=0 ctime=Thu Jan  1 09:00:00 1970
    Continue creating array? y
    mdadm: container /dev/md/imsm0 prepared.

  Step2, create md device
    mdadm -C /dev/md0 /dev/md/imsm0 -n 2 -l 0 -c 128 -f
    mdadm: array /dev/md0 started.

  Step3: Create Partition
    parted /dev/md0

    (parted) mkpart
    Partition name?  []?
    File system type?  [ext2]? xfs
    Start? 0%
    End? -1

    (parted) p
    Model: Linux Software RAID Array (md)
    Disk /dev/md0: 800GB
    Sector size (logical/physical): 512B/512B
    Partition Table: gpt
    Disk Flags:

    Number  Start   End    Size   File system  Name  Flags
     1      1049kB  800GB  800GB

    (parted) quit
    Information: You may need to update /etc/fstab.

  Step4: Newfs

    /sbin/mkfs.xfs -K /dev/md0p1 -f

  Step5: mount

    mount -o noatime,nodiratime,nobarrier /dev/md0p1 /mnt/nvme1


-- 
Hiroyuki Sato
