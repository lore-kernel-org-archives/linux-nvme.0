Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146C8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwIqy+Hl3ygZgeC0m/MEuZKpclVNp5nenEs8SJYSAgs=; b=aUhD50irk1SFFfkh/GMhc+Sidj
	60nyNz2JrogRsiik1Ospve3hYPRmEjxxIJYP1hECI2bRe1ZFC6+jSSkXNg3kXS5uD9OKhGQ8dQYy1
	F/snXnIE7NqWudF6adBCUmuD5CCiz2V1DZmk9X5gCeaZGVP0+Eo/LFU0t6i7VSSAmZZNptM39FeP1
	XYlb9kZWhJTU1Og70/2BI1Za/2EDROJSeFT08OYR6HxyaBtmI9PMPYNhX7EnwZX5oHwnV4i5BFpS0
	/b+9kZZkTeldcxNWFs24ap2qz/gUGVsOgO1p2tLewv4CwPCk5wGmTufWrCFjDqidcHi8GK8m4fZet
	8TQlRrBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntUXw-0086Rq-Sd; Tue, 24 May 2022 13:26:00 +0000
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntUXu-0086R2-Ob
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 13:26:00 +0000
Received: by mail-yb1-xb31.google.com with SMTP id z7so9574578ybf.7
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RwIqy+Hl3ygZgeC0m/MEuZKpclVNp5nenEs8SJYSAgs=;
 b=MgjUryKFIK3cqY16vTbDzBHG057j1T7LAVeGIpxm6GBWZiAy+vWXSCbWAizckS4dSf
 W5CzPzyONjmEeIbrsHNHUiiFRPH4l05t9auI9mqX4p6ZKQAFVQY/+NkyRfrLZqcejBql
 KS2JsZxRqdKxcHejA04fLMUrav1ILnpsG8wS/g4nVNeSuHr1mACVVxl4A9fo5GN7P7xI
 ydWkTaw7LKgCFY2J7fDw7Kf9chBLyi1/OyooG2dmBfjcpDOP+hEf5+cLfRDdm15TkmCX
 CjVNSAEpOeGITx6T+hgnr0Qyi5s7e9mQTcVKsbmOZNrl+B35AsBlvcUDbxoCMx87bbfy
 Zbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RwIqy+Hl3ygZgeC0m/MEuZKpclVNp5nenEs8SJYSAgs=;
 b=Nso2Q862hRDAil7E9SCJoptRE+WJ2zfqGrrjg2zYa5L4IpreP+NLfsvtkShSqjHyI8
 xBJNfRV6EeoDkGRkSAX6obmCXIrDkMoDCVPjTHVdmoLGOwD7ji1BIt7gpSBqkkUvKzdZ
 ruKPZXergI08UnhFbz/chJAPBz2CNVXh+hpkZwLaCVBqWer+BlPpT/JfjRYWu1PljBp4
 aXvvSmVKlXVPWz2Ili//nmf6KH+iNaCr42X8WA9pn73KijUIQEojEOybnLT1ZjmKqxfW
 LEoL8XYeFvr5FEJN8kGWcuiLG7f118GeIa4lRy0b5JQVJZ0UrnOJn+oIBEEGaJjWCo3f
 rJHg==
X-Gm-Message-State: AOAM532ipMbPGpUrlBLn+bftwhk2jZzPSZSJBnnB+3hrJa3M/KLY/+XA
 4I37hhjrtQli9fMUG7lUDghOkdCM3RGExFHUAM2uhw==
X-Google-Smtp-Source: ABdhPJyUHxXSwn/mXjiVbHhWfv1BNXMZDUpsxoDRmX3q6+0ZZXLlZCPkrbIGVa3NzPRTuWBfyrEikNpbo/i5g0nxur4=
X-Received: by 2002:a25:d1d0:0:b0:64b:a952:a4e6 with SMTP id
 i199-20020a25d1d0000000b0064ba952a4e6mr27567709ybg.574.1653398756592; Tue, 24
 May 2022 06:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
In-Reply-To: <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Tue, 24 May 2022 09:25:20 -0400
Message-ID: <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
Subject: Re: nvme: split bios issued in reverse order
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_062558_872901_A5F0D3A0 
X-CRM114-Status: GOOD (  31.16  )
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

On Tue, May 24, 2022 at 8:58 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > There seems to be an inconsistency in the order of writes that are
> > issued after splitting a bio. Ordering depends on how the application
> > write is submitted and the number of I/O queues configured.
> >
> > In our testing nvme/tcp,
>
> Is this specific to nvme-tcp?

No. This is not specific to nvme-tcp. I confirmed the same behavior
directly to a pci device.

>
> > a 128K write issued with fio/pvsync
>
> is this specific to the io engine?

Yes. With ioengine=libaio, the IOs are reversed. With ioengine=pvsync
the IOs are sequential.

>
> > is split
> > into four 32K I/Os (the target maximum data transfer size is set to
> > 32K, and max_sectors_kb is therefore 32K). As expected, the four write
> > I/Os are issued to the target in sequential order. However, if the
> > 128K write is issued using fio/libaio, the four 32K writes are issued
> > in reverse order:
> >
> > fio-8098 [001] ..... 254009.711080: nvme_setup_cmd: nvme1:
> > disk=nvme1c1n1, qid=2, cmdid=16468, nsid=1, flags=0x0, meta=0x0,
> > cmd=(nvme_cmd_write slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
> >
> > fio-8098 [001] ..... 254009.711083: nvme_setup_cmd: nvme1:
> > disk=nvme1c1n1, qid=2, cmdid=16467, nsid=1, flags=0x0, meta=0x0,
> > cmd=(nvme_cmd_write slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
> >
> > fio-8098 [001] ..... 254009.711084: nvme_setup_cmd: nvme1:
> > disk=nvme1c1n1, qid=2, cmdid=16466, nsid=1, flags=0x0, meta=0x0,
> > cmd=(nvme_cmd_write slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
> >
> > fio-8098 [001] ..... 254009.711085: nvme_setup_cmd: nvme1:
> > disk=nvme1c1n1, qid=2, cmdid=16465, nsid=1, flags=0x0, meta=0x0,
> > cmd=(nvme_cmd_write slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
> >
> > Further investigation found that if the number of I/Os queues is
> > limited to 1 at connect time,
>
> Is this specific to a single I/O queue?

With ioengine=libaio && queues > 1, the IOs are issued in reverse
order. With ioengine=libaio && queues == 1, the IOs are in sequential
order.

>
> > the issue order is sequential for both
> > pwritev and libaio.
>
> I'm assuming that this is 100% repeatable?

Yes. !00% repeatable.

>
> >
> > I've spent some time tracing through the bio/blk_mq code and
> > can't seem to find what might be causing the difference in
> > behavior. Can anyone confirm that this is expected or desired
> > behavior?
>
> What is the controller mdts? does the 32k go in-capsule? or does
> the controller send r2t?

mdts=32K, io capsule size=32K, no R2T

>
>
> Also, if we assume that this is indeed the case, is this a fundamental
> issue?

Maybe it is fundamental since it occurs for both PCI and TCP devices?
The part that I can't reconcile is why there is a difference in
behavior for ioengine=libaio when multiple queues are present. It
feels like it has something to do with the interaction with bio
splitting and plugging.

Here are a couple more details:
- you can reproduce it on a PCI device by setting max_sectors_kb to 32
- the order issued is not present if the submitted IO is a read.

I'm happy to run additional testing to shed more light on the behavior.

