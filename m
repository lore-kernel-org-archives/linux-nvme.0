Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C11C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CwdHZ/Sxrj5QxbRM+qHBgUY+XO8Vfhs80Dnr9CXTIVY=; b=1F7P7PWpSk4HVzj4OZdX3KHlzR
	VBC43PuMx0/rsva7bywGyfVHI40YtcuNcDVnkuUOmBeCv+PAR99A6qtgVxOxi+7EH2BwTaIi81Rq1
	gp2AMNG0t/qPzjVEB9wza0pE4zbjC/EpEsFOBMIi6RrXxHRPIEMyrKy3ykYhDgstITuCKKS3hc+KL
	4ovRCoaSfaprl2NLAnTsIUrHW7WdaxQ4qTzFm/Kgx083AsoqiKn7m0tXWVxnk2jKCYOmrTDke6CzO
	esilVGYRIVEXkgliDPZssSlgbPEsF87H8HKx1S6297mSOZuz9O3rLCoMZfPHwzf9dCjqgiPz/RMoW
	zFRDyIZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntX9i-008d9V-93; Tue, 24 May 2022 16:13:10 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntX9f-008d8X-Dy
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 16:13:09 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id y141so4296285ybe.13
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CwdHZ/Sxrj5QxbRM+qHBgUY+XO8Vfhs80Dnr9CXTIVY=;
 b=QpzsHgHGx/GpvM0GzeOb7/1xDTt9Cm17110Qv8w2PTo7nYxX7tb8C4xFSEdQlog5as
 l84JIv9i87XamZ+r38FJI239itdZlp62DbKs2VzE9lh47jo96l4ubjIxGpx+T0jzOPaC
 5JoVmjLO21VTXW7qecO8YNHyosq94tDwb7qykr/I8X0lee5dLiVnU+dNAlWrgMhosd7O
 aOjs/NDb2L+XUMw/bpt0rjFmlY7fq0f/fz8okhBQYexuir1EAlC9JmaiHX7LzyAyzH+k
 8TiI3TUUtYA15qYvGkRkh7M84k2MbfIEOBewPLN0KZhjP2R0pGDGyapViOPtQq1pH158
 yVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CwdHZ/Sxrj5QxbRM+qHBgUY+XO8Vfhs80Dnr9CXTIVY=;
 b=C6Mf0vvmTQI2oKuoh2uEjmcYQtaMWUqXPmc8t3HsV6o80GbgwKTJGInMkNeMe4WUmH
 fsix2CWmA4200IWD4bx0wmaFVK/y5yjT1tZDip2NnG8kWAxiqR68xfhNG+mWe+OVHrfS
 3I1ZRI0K9bFXJH/EXLEwen4FNfPLbgbyUQvd79gcDkiS9JjDYxm/hOyaYjIHCKAp1N8e
 8z2cwx3BfJMu9frRUdjzTG8NP/fDWbXuFfWkAnf8NpoF3ph6z71Swkta+ZZNTRiOIOnF
 QxZY9PPvU7oDYw5oflfQCpd4ys+qi0M336nnoKQmIbInxdgf0rXBz9gxfRdLV/patQAl
 kJzw==
X-Gm-Message-State: AOAM5304Q0zJpWJD2ISPF8UZc0EuCXVvmtm6/op19Mdxj5Olf45zF7ru
 Jn22fEGahWt/u7uvsLxLG/blwKI32aKDJlsuAZhQFmwdPNM7AQ==
X-Google-Smtp-Source: ABdhPJxLdf3D2FT3Tb5tci3q+DMaDLc0HCfz6xKlLHVRpjpmCLWJBstzQtjqYUYjnyjqw3LSEPMINqrhrs7hjO/tyR8=
X-Received: by 2002:a25:ca44:0:b0:64f:62fd:6182 with SMTP id
 a65-20020a25ca44000000b0064f62fd6182mr19178530ybg.97.1653408785640; Tue, 24
 May 2022 09:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
 <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Tue, 24 May 2022 12:12:29 -0400
Message-ID: <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
Subject: Re: nvme: split bios issued in reverse order
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_091307_524584_5DBA460A 
X-CRM114-Status: GOOD (  18.29  )
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

On Tue, May 24, 2022 at 12:08 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 09:25:20AM -0400, Jonathan Nicklin wrote:
> > On Tue, May 24, 2022 at 8:58 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >
> > >
> > > > There seems to be an inconsistency in the order of writes that are
> > > > issued after splitting a bio. Ordering depends on how the application
> > > > write is submitted and the number of I/O queues configured.
> > > >
> > > > In our testing nvme/tcp,
> > >
> > > Is this specific to nvme-tcp?
> >
> > No. This is not specific to nvme-tcp. I confirmed the same behavior
> > directly to a pci device.
>
> I just tried this on a qemu pci device with MDTS set to  '3' for 32k splits.
> Both psync and libaio dispatch the submitted bio's in ascending LBA order. I'm
> using kernel 5.18 with these fio commands:
>
>  # fio --name=global --filename=/dev/nvme0n1 --bs=128k --direct=1 --size=128k --rw=read --ioengine=psync --name=job
>  # fio --name=global --filename=/dev/nvme0n1 --bs=128k --direct=1 --size=128k --rw=read --ioengine=libaio --name=job
>
> The first command produced this trace:
>
>  fio-438 .. 57.799950: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=29184, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-438 .. 57.799995: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=513, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-438 .. 57.800002: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=514, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-438 .. 57.800009: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=515, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-438 .. 57.800017: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=516, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=256, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-438 .. 57.800023: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=517, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=320, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-438 .. 57.800029: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=518, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=384, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-438 .. 57.800046: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=519, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=448, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>
> And the second command produced this:
>
>  fio-445 ..  83.440824: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=32896, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-445 ..  83.440870: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=28801, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-445 ..  83.440920: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=24706, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-445 ..  83.440931: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=20611, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-445 ..  83.441246: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=36992, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=256, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-445 ..  83.441259: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=32897, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=320, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-445 ..  83.441287: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=28802, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=384, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
>  fio-445 ..  83.441348: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=41088, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=448, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

The command lines you have are for read operations. The behavior seems
only to appear with writes.

