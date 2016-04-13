From: hiroysato@gmail.com (Hiroyuki Sato)
Date: Wed, 13 Apr 2016 15:16:49 +0900
Subject: Newbie question Two Intel P3600 Cards and RAID0
In-Reply-To: <CAMrWnbEuidHt2a7wVWPmtsHW4ZS=oS4VEzDFfL_h27SpnCEtKA@mail.gmail.com>
References: <CA+Tq-RpVZaB-OQ6RdA94dcXvdtPmhjqznrYHWXqm5d9F2TzFGQ@mail.gmail.com>
 <CAMrWnbEuidHt2a7wVWPmtsHW4ZS=oS4VEzDFfL_h27SpnCEtKA@mail.gmail.com>
Message-ID: <CA+Tq-Rr94L8zStHMXFRfewJV_HzxhU1gvsO08DOgXJeumbk+pw@mail.gmail.com>

Hello

I've succeed to create RAID0 with NVMe cards.
I executed following commands.

mdadm -C /dev/md/imsm0 /dev/nvme0n1 /dev/nvme1n1 -n 2 -e imsm -f
mdadm -C /dev/md0 /dev/md/imsm0 -n 2 -l 0 -c 128 -f

I followed this instruction.

https://communities.intel.com/community/itpeernetwork/blog/2015/10/01/how-to-use-and-benchmark-nvme-ssd-create-a-software-raid-and-analyze-performance-the-answers-are-here

Thanks.

P.S
Is this(mdadm) better than mtd_raid technorogy?

2016-04-13 14:18 GMT+09:00 Tai-Hong (Type) Wu <thwu at lunartoday.com>:
> Q: Can I use mdadm for NVMe?
>
> Ans: Yes, of course
>         I've tried using dozens of NVMe disks to assemble an MD-RAID0,
>         and the MD-RAID0 was looking just good.
>
>         Setup:  Default 512KiB stripe,  at CentOS 7 (x86-64 SMP 3.10.0-327+)
>
> 2016-04-13 10:06 GMT+08:00 Hiroyuki Sato <hiroysato at gmail.com>:
>> Hello members.
>>
>> I have two Intel P3600 400GB, NVMe PCIe 3.0 cards.
>>
>> I want to use this cards for large calculation area.
>> (RAID0 or something)
>>
>> My question is following.
>>
>> * Can I use mdadm for NVMe.
>> * It it better to use mtd-raid? (I found this keywords on this mailing list)
>> * Or any other recommend way?
>>
>> Could you point me any documentation link for that?
>>
>> My environment
>> * OS: CentOS7
>> * Kernel: 4.4 (build myself)
>>
>> I already mount those cards as single file system.
>>
>> Best regards.
>>
>>
>> --
>> Hiroyuki Sato
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme



-- 
Hiroyuki Sato
