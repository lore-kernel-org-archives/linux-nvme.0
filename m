Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AD1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 22:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6oFkOcjiJ9pd7ZwoFCjqWsy2jUKWHBahJm665LhtTfM=; b=aadK9a4jhzWeMGbfWyYkbMXrl5
	9f0EHxGxihDCzAKJ0v60FROjbAq5RmPZv8O2xHzA6YVYGjQENbaylTHbvgOJDEN9IdqpBaMu8P6P7
	DBZs9D4Us0tqnzhMtLtcb9oo1Z8cvG9Mnl6cDk671wk8w/sODLoKw8pGEsjlAOMrzsBg+8fKc2yQf
	DF+Z09Cg224x7wiFINJlRQOwaT9+1sdun66PSEEhz/jHiCNFIqUentmYoZ36xfK+GFEuxYZYSRy2j
	fvyF+bw+OyHKfE+hzLCBgrzT18BRzEAo9txQpdSi9eN3PcNSCPOdDMqd5wyaHzHSD2MktAYH2gPkk
	0fkxlQQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntdR9-009OZT-2b; Tue, 24 May 2022 22:55:35 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntdR5-009OYZ-N4
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 22:55:33 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id v26so5092523ybd.2
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6oFkOcjiJ9pd7ZwoFCjqWsy2jUKWHBahJm665LhtTfM=;
 b=zCSls0OlQx9s/R+y9uxyyvln2qdUB+VP0qERz1MtD1xmj2f4dd7Hfb1QvSeQ87NyQh
 Svcd67Zsz0whYnMUKnpRGp/C+qhW6VHpv5GrkDw7/KPlqSl4VCcyKxOVcC7xZ+tbY+vL
 qcWwW48+Ort+gGlnxUsbKKmwCwytrLiBbfzeGF/nYGR9TTr8NqYEZMDFd+V/AuB2xbIu
 l2NhtRRq2Ow0SfhJbUa6mfzXMt8lmunqS29DJTCi+0tLbby71glKgXVIYZGH72RtX5LF
 rXoh1sZdGkCP6in1LIfmq41FakOdxvCE4HfVoJ54i7MOvqJAns0+slJpXG8PRGgBFnc0
 O2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6oFkOcjiJ9pd7ZwoFCjqWsy2jUKWHBahJm665LhtTfM=;
 b=2nnLD/uxSm8dkSeG1CmyfsgYv4J+vVvBkKY2MIqSiHB+uxPkNu6MVSp+/YU7Yk+w7B
 zU8n9rC+bPF/qEiiM6fdImMnEkNrzNz1lHnS7WYDgu2Jh4cmuviCVZSEdk9eK2Ez3xLt
 jLWl7Bv+S5breL5p6TIFgDxukPlX8AxfvrXChP19K8L+bChvjU2kgo8kGzwnwejl5nqP
 2kwfd9qCZOV5LneZd/aBnlj3XJxSUGcX9h42RDS/hn3Ind/G+9hddVeUa1p0Q9Qig3Lh
 Y2fTrGSCPkrxJhEdVEKoYQ+VorM64dFlZJxJr3CIOrm+7c/C6vxrwt+WuPoGgwM0Xgt+
 mrRQ==
X-Gm-Message-State: AOAM5303AANvL9UtwpyPuhmXzUP2qgn5XXolhrCENo4bc0ZTZ07C8Xxf
 ngHWJpWTUzd9v8ZC3AKpIN8Q/XaAYQ5/5AXevHBcyg==
X-Google-Smtp-Source: ABdhPJwQ0pwlQap4Fc/k4kYgMcP9SomecDdP7UXU2WPnReQ7UdwDCvYeYFxupVyKLNQny0cA2u5KkGSqLB0WEww4nW8=
X-Received: by 2002:a05:6902:282:b0:64d:e139:c9b8 with SMTP id
 v2-20020a056902028200b0064de139c9b8mr29837200ybh.6.1653432927446; Tue, 24 May
 2022 15:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
 <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
 <Yo0xE5g3bowmF3H0@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0cpUNdb3mu+9pHG2oDfBmgmmCMQAo13axqO=jL5fwr_QJA@mail.gmail.com>
 <Yo1AOXKXkmrnnvou@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0coj1vAKRgf5BHAvjWeNgwj0JXyfDm6kFN48ZMpfdoHA7g@mail.gmail.com>
 <4c78726a-5c37-f1f6-014d-259bb9bdf252@opensource.wdc.com>
 <CAHex0cre2RAqVH1BFHgb2KWCr-YfZWmrZwtv8w9qpU5Cd9iejw@mail.gmail.com>
In-Reply-To: <CAHex0cre2RAqVH1BFHgb2KWCr-YfZWmrZwtv8w9qpU5Cd9iejw@mail.gmail.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Tue, 24 May 2022 18:54:51 -0400
Message-ID: <CAHex0coMNvFa1TPzK+5mZHsiie4d1Jd0Z8ejcZk1Vi1_4F7eRg@mail.gmail.com>
Subject: Re: nvme: split bios issued in reverse order
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_155531_822205_E4BE0A44 
X-CRM114-Status: GOOD (  23.84  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Just to clear up confusion on the observed behavior, Here's a trace
from a virtual NVME device in QEMU (thanks for the idea Keith).

# CPUs >1 to ensure multiple nvme queues
4

# Kernel
Linux debian 5.16.0-0.bpo.4-amd64 #1 SMP PREEMPT

# Simulate effect of NVME MDTS @ 32K
echo 32 > /sys/block/nvme0n1/queue/max_sectors_kb

# Basic QD1 Write w/ libaio (split IOs get issued in descending LBA order)
fio --name dbg --filename=/dev/nvme0n1 --rw=write --iodepth=1
--bs=128K --ioengine=libaio --direct=1 --size=1M

fio-3201    [002] .....  1070.001305: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=3, cmdid=4867, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
fio-3201    [002] .....  1070.001308: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=3, cmdid=17154, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
fio-3201    [002] .....  1070.001309: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=3, cmdid=29441, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
fio-3201    [002] .....  1070.001310: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=3, cmdid=13056, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

fio-3201    [002] .....  1070.001559: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=3, cmdid=8963, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=448, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
fio-3201    [002] .....  1070.001560: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=3, cmdid=21250, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=384, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
fio-3201    [002] .....  1070.001561: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=3, cmdid=33537, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=320, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
fio-3201    [002] .....  1070.001561: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=3, cmdid=17152, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=256, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

# Basic QD1 Write w/ pvsync (split IOs get issued in ascending LBA order)
fio --name dbg --filename=/dev/nvme0n1 --rw=write --iodepth=1
--bs=128K --ioengine=pvsync --direct=1 --size=1M

kworker/1:1H-139     [001] .....  1392.956314: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=2, cmdid=33088, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
kworker/1:1H-139     [001] .....  1392.956316: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=2, cmdid=33089, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
kworker/1:1H-139     [001] .....  1392.956318: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=2, cmdid=16706, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
kworker/1:1H-139     [001] .....  1392.956320: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=2, cmdid=4419, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

kworker/1:1H-139     [001] .....  1392.956537: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=2, cmdid=37184, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=256, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
kworker/1:1H-139     [001] .....  1392.956538: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=2, cmdid=37185, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=320, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
kworker/1:1H-139     [001] .....  1392.956539: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=2, cmdid=20802, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=384, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
kworker/1:1H-139     [001] .....  1392.956540: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=2, cmdid=8515, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=448, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

On Tue, May 24, 2022 at 6:01 PM Jonathan Nicklin
<jnicklin@blockbridge.com> wrote:
>
> With the drive exercised as follows:
>
> app: fio
> engine: libaio
> queue depth: 1
> block size: 128K
> device max_sectors_kb: 32K
>
> A 128K user IO is split into four 32K I/Os which are then issued in
> reverse order as follows:
>
>              fio-12103   [001] ..... 89587.120514: nvme_setup_cmd:
> nvme1: disk=nvme1c1n1, qid=2, cmdid=12328, nsid=1, flags=0x0,
> meta=0x0, cmd=(nvme_cmd_write slba=192, len=63, ctrl=0x0, dsmgmt=0,
> reftag=0)
>              fio-12103   [001] ..... 89587.120515: nvme_setup_cmd:
> nvme1: disk=nvme1c1n1, qid=2, cmdid=12327, nsid=1, flags=0x0,
> meta=0x0, cmd=(nvme_cmd_write slba=128, len=63, ctrl=0x0, dsmgmt=0,
> reftag=0)
>              fio-12103   [001] ..... 89587.120518: nvme_setup_cmd:
> nvme1: disk=nvme1c1n1, qid=2, cmdid=12326, nsid=1, flags=0x0,
> meta=0x0, cmd=(nvme_cmd_write slba=64, len=63, ctrl=0x0, dsmgmt=0,
> reftag=0)
>              fio-12103   [001] ..... 89587.120518: nvme_setup_cmd:
> nvme1: disk=nvme1c1n1, qid=2, cmdid=12325, nsid=1, flags=0x0,
> meta=0x0, cmd=(nvme_cmd_write slba=0, len=63, ctrl=0x0, dsmgmt=0,
> reftag=0)
>
> On Tue, May 24, 2022 at 5:44 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> >
> > On 5/25/22 05:32, Jonathan Nicklin wrote:
> > > On Tue, May 24, 2022 at 4:29 PM Keith Busch <kbusch@kernel.org> wrote:
> > >>
> > >> On Tue, May 24, 2022 at 03:37:56PM -0400, Jonathan Nicklin wrote:
> > >>> On Tue, May 24, 2022 at 3:25 PM Keith Busch <kbusch@kernel.org> wrote:
> > >>>>
> > >>>> On Tue, May 24, 2022 at 12:12:29PM -0400, Jonathan Nicklin wrote:
> > >>>>>
> > >>>>> The command lines you have are for read operations. The behavior seems
> > >>>>> only to appear with writes.
> > >>>>
> > >>>> Huh, I'll be darn...
> > >>>>
> > >>>> I think it's because the writes are plugged and the reads are not. The plug
> > >>>> appends requests to the head of the plug list, and unplugging will dispatch the
> > >>>> requests in the reverse order.
> > >>>
> > >>> Thanks for confirming! That's about where I got to. Do you have any
> > >>> ideas on what might explain the difference in behavior between
> > >>> fio/pvsync and fio/libaio? And, why does this not seem to occur when
> > >>> only one nvme queue is present? Perhaps the in-order cases are an
> > >>> indication of not being plugged?
> > >>
> > >> I actually didn't see a difference between libaio or psync, and also io_uring.
> > >> They all plugged and reversed the dispatch order. Do you have a scheduler
> > >> enabled?
> > >
> > > Nope, there's no scheduler in the way.
> >
> > If the drive is exercised at QD=1, e.g. psync() and libaio with iodepth=1,
> > then plugging does not matter as there will be no merge (so no at-head
> > insertion in the plug). Commands will be executed in the user submission
> > order. At higher qd, if merge happen while plugged, then order will be
> > reversed (libaio with iodepth > 1 only).
> >
> > >
> >
> >
> > --
> > Damien Le Moal
> > Western Digital Research

