From: thwu@lunartoday.com (Tai-Hong (Type) Wu)
Date: Wed, 13 Apr 2016 13:18:53 +0800
Subject: Newbie question Two Intel P3600 Cards and RAID0
In-Reply-To: <CA+Tq-RpVZaB-OQ6RdA94dcXvdtPmhjqznrYHWXqm5d9F2TzFGQ@mail.gmail.com>
References: <CA+Tq-RpVZaB-OQ6RdA94dcXvdtPmhjqznrYHWXqm5d9F2TzFGQ@mail.gmail.com>
Message-ID: <CAMrWnbEuidHt2a7wVWPmtsHW4ZS=oS4VEzDFfL_h27SpnCEtKA@mail.gmail.com>

Q: Can I use mdadm for NVMe?

Ans: Yes, of course
        I've tried using dozens of NVMe disks to assemble an MD-RAID0,
        and the MD-RAID0 was looking just good.

        Setup:  Default 512KiB stripe,  at CentOS 7 (x86-64 SMP 3.10.0-327+)

2016-04-13 10:06 GMT+08:00 Hiroyuki Sato <hiroysato at gmail.com>:
> Hello members.
>
> I have two Intel P3600 400GB, NVMe PCIe 3.0 cards.
>
> I want to use this cards for large calculation area.
> (RAID0 or something)
>
> My question is following.
>
> * Can I use mdadm for NVMe.
> * It it better to use mtd-raid? (I found this keywords on this mailing list)
> * Or any other recommend way?
>
> Could you point me any documentation link for that?
>
> My environment
> * OS: CentOS7
> * Kernel: 4.4 (build myself)
>
> I already mount those cards as single file system.
>
> Best regards.
>
>
> --
> Hiroyuki Sato
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
