Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8DEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 22:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYgCo5TH5/8IT2ES165uEc/nJiJaYZ21yVm09KOrCG8=; b=jkIK9AFpL3Dy2nyLcpFeM+ttHc
	sR+yCDlUnrPwD5i8HnauYkcIrqtTm01FRxk1lUpWRPJOUEv9XYFeigj1UEEsikHZZU2zg8d3dNmuT
	aeYXxU3pGlZr+c1kye4CguhMNVnIHXkOYl9WyrpFKu9KNiKMLazsA/t3ueSGP01fh5aznkNQVrRIq
	GUvRUswYbU5LF/g4vleMGKlI8MyepUb5+rvbOBTa4XMMV38WW2mU4jxoWVZitFSZUmAWiruCZUBqK
	eAVD0257YCkEc+Xv6gYsBUa1fYiAg/f8w+JafUzr7MSoRNz0XTtKhAAUh/J5xGZzEkZQELAWynqhW
	DbAi6/LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntcbh-009HqU-Qv; Tue, 24 May 2022 22:02:25 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntcbf-009Hpf-Iq
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 22:02:25 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id z7so11949633ybf.7
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OYgCo5TH5/8IT2ES165uEc/nJiJaYZ21yVm09KOrCG8=;
 b=mlxLv76iijmAlBN1tGVXCVK3H7gnySPmyv2jKi3yamHkOYn0qyd9tqBU0d3k7yre9L
 8M1I9bnKC3INCl089TcTKZtRZ08C6DRC5Xh3eDpiMDJZxKhDvopq1SUTPygdiQ/L0KHv
 oZXUMHS2rk9VVDiOICG7+fH+Y0NpkbtszeQkcMqphlIkshZLZpI4dXNWekbBpOF8CeeJ
 UEg6wgsvgkrCwWLnxcGwJb8L5stxZZZX7lBCnIIjMvUvWMvpkBakVDpmnGsAaGK7h0+D
 /w7Pju+mJjVF8K0FVUsSl4wDV7VUWdQ/CQE/tjZ30K0OKUqEakVTuOEo8zCNKYMIAVPP
 MQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OYgCo5TH5/8IT2ES165uEc/nJiJaYZ21yVm09KOrCG8=;
 b=qa9YxBuYosuWH9KKHB5QRgP2UJO65KsCK+JvB/m8CCXXPg46S7U6U0F6w5YYAS7Wj8
 WGgKQP0+om6YHg1d8TcR2rv9FSkn+KUATuuUb0/z5H/u9NpWSwOgRsco/t01a5SNNRxg
 77aPtNT3I4jl9oKrbVshyiBlEajZW1InWNTig60sOxddyIwMvl6nYSZd8/uoP5J4ubwa
 RhLZZg6NIqyZ+YIdvRBjFN3K0RaDmGjdjFjJQLWm/xQXC0pGGioNKY+dS3dyeBjQDXXc
 vExB1aLzlqkHAKxTDeu9JMosKtKNkQJG8rt4RI0q3Q28WI2HmO7XaDQ2pAaZhvXQbvEp
 vtuA==
X-Gm-Message-State: AOAM531fE8DpkHKjczkZ60YkGF++n6lSBXLIjG8smgHlFk9SAPNEjHTZ
 tNvCOvMFakvKtkMVD0gPoaHxwKHncdxHpGJKCdCqHg==
X-Google-Smtp-Source: ABdhPJznYbne5apvMfQpsB31EoTP435apgqu9TwZweCT0aOPU5lCdpAMl3+8y4LcHIsH5B9SCJ8zltvS5Kr09ilmPHI=
X-Received: by 2002:a25:c307:0:b0:64d:c9ac:8ada with SMTP id
 t7-20020a25c307000000b0064dc9ac8adamr28712298ybf.13.1653429741843; Tue, 24
 May 2022 15:02:21 -0700 (PDT)
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
In-Reply-To: <4c78726a-5c37-f1f6-014d-259bb9bdf252@opensource.wdc.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Tue, 24 May 2022 18:01:45 -0400
Message-ID: <CAHex0cre2RAqVH1BFHgb2KWCr-YfZWmrZwtv8w9qpU5Cd9iejw@mail.gmail.com>
Subject: Re: nvme: split bios issued in reverse order
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_150223_676129_AA6F82D7 
X-CRM114-Status: GOOD (  20.44  )
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

With the drive exercised as follows:

app: fio
engine: libaio
queue depth: 1
block size: 128K
device max_sectors_kb: 32K

A 128K user IO is split into four 32K I/Os which are then issued in
reverse order as follows:

             fio-12103   [001] ..... 89587.120514: nvme_setup_cmd:
nvme1: disk=nvme1c1n1, qid=2, cmdid=12328, nsid=1, flags=0x0,
meta=0x0, cmd=(nvme_cmd_write slba=192, len=63, ctrl=0x0, dsmgmt=0,
reftag=0)
             fio-12103   [001] ..... 89587.120515: nvme_setup_cmd:
nvme1: disk=nvme1c1n1, qid=2, cmdid=12327, nsid=1, flags=0x0,
meta=0x0, cmd=(nvme_cmd_write slba=128, len=63, ctrl=0x0, dsmgmt=0,
reftag=0)
             fio-12103   [001] ..... 89587.120518: nvme_setup_cmd:
nvme1: disk=nvme1c1n1, qid=2, cmdid=12326, nsid=1, flags=0x0,
meta=0x0, cmd=(nvme_cmd_write slba=64, len=63, ctrl=0x0, dsmgmt=0,
reftag=0)
             fio-12103   [001] ..... 89587.120518: nvme_setup_cmd:
nvme1: disk=nvme1c1n1, qid=2, cmdid=12325, nsid=1, flags=0x0,
meta=0x0, cmd=(nvme_cmd_write slba=0, len=63, ctrl=0x0, dsmgmt=0,
reftag=0)

On Tue, May 24, 2022 at 5:44 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 5/25/22 05:32, Jonathan Nicklin wrote:
> > On Tue, May 24, 2022 at 4:29 PM Keith Busch <kbusch@kernel.org> wrote:
> >>
> >> On Tue, May 24, 2022 at 03:37:56PM -0400, Jonathan Nicklin wrote:
> >>> On Tue, May 24, 2022 at 3:25 PM Keith Busch <kbusch@kernel.org> wrote:
> >>>>
> >>>> On Tue, May 24, 2022 at 12:12:29PM -0400, Jonathan Nicklin wrote:
> >>>>>
> >>>>> The command lines you have are for read operations. The behavior seems
> >>>>> only to appear with writes.
> >>>>
> >>>> Huh, I'll be darn...
> >>>>
> >>>> I think it's because the writes are plugged and the reads are not. The plug
> >>>> appends requests to the head of the plug list, and unplugging will dispatch the
> >>>> requests in the reverse order.
> >>>
> >>> Thanks for confirming! That's about where I got to. Do you have any
> >>> ideas on what might explain the difference in behavior between
> >>> fio/pvsync and fio/libaio? And, why does this not seem to occur when
> >>> only one nvme queue is present? Perhaps the in-order cases are an
> >>> indication of not being plugged?
> >>
> >> I actually didn't see a difference between libaio or psync, and also io_uring.
> >> They all plugged and reversed the dispatch order. Do you have a scheduler
> >> enabled?
> >
> > Nope, there's no scheduler in the way.
>
> If the drive is exercised at QD=1, e.g. psync() and libaio with iodepth=1,
> then plugging does not matter as there will be no merge (so no at-head
> insertion in the plug). Commands will be executed in the user submission
> order. At higher qd, if merge happen while plugged, then order will be
> reversed (libaio with iodepth > 1 only).
>
> >
>
>
> --
> Damien Le Moal
> Western Digital Research

