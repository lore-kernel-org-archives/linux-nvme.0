From: hiroysato@gmail.com (Hiroyuki Sato)
Date: Wed, 13 Apr 2016 13:58:18 +0900
Subject: Newbie question Two Intel P3600 Cards and RAID0
In-Reply-To: <CA+Tq-RpVZaB-OQ6RdA94dcXvdtPmhjqznrYHWXqm5d9F2TzFGQ@mail.gmail.com>
References: <CA+Tq-RpVZaB-OQ6RdA94dcXvdtPmhjqznrYHWXqm5d9F2TzFGQ@mail.gmail.com>
Message-ID: <CA+Tq-Rp4_EuyvFnXM5RwYi_UJUrFZ-w349==YwdZ4Hyf3rKrRw@mail.gmail.com>

I found this article.

https://communities.intel.com/community/itpeernetwork/blog/2015/10/01/how-to-use-and-benchmark-nvme-ssd-create-a-software-raid-and-analyze-performance-the-answers-are-here

It documented about Software RAID with Intel matrix storage Manager Software.

Thanks.




2016-04-13 11:06 GMT+09:00 Hiroyuki Sato <hiroysato at gmail.com>:
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



-- 
Hiroyuki Sato
