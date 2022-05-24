Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDDFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wd7d9ep88ByE38zD5bt6vgkmsRGd8wBMBDdBWJZDjbk=; b=vZ/oOHE6ZChHZgW/VPV2TiGkiq
	g+S8vKidB6VrB0DXQ9gneGuswqjvbQrTPPyayYytycOeFpwBHWIqA2oA4mt3S2TvAnByY3EOYrBWE
	urhfUEMf/Hf0VzEzSsG5JDWChPK1IC80thhn8w5JLohGxAPdLPzPpbb0zOc1V0bp5SPydhaMlFYaU
	ycmk+5pexGJGvg8B84fYxrbQ3LSG23GBDGjSYeLvDrTeiWckr7JM667NFefzGhG+LOEL4zzy1xrLT
	O46wwIHkA47fupbSHFge5Fuu30syJZ7TOuZo3ZjldjmdW/4FV4JkYk3CiHRzqacLbF4gGUcX9MyPb
	3PVa9tvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntbDh-0098CF-LV; Tue, 24 May 2022 20:33:33 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntbDe-0098Be-Ph
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 20:33:32 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id s14so5548107ybc.10
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wd7d9ep88ByE38zD5bt6vgkmsRGd8wBMBDdBWJZDjbk=;
 b=xIaNtX+ZCbu0lb42fAEeYghEUEBSD8HmO5n3QuWXCDpq7Wpun/rDgCS6hYWL91Gi9g
 oF2o+x/Kik6z24ORwfQCWVgvSPsacuVp8a+51N0Xw5GuQ8HYlkKlgF5/tHTNf34k62qX
 JoYQNU5LlF+yJIqoikjNMkQlDhVm9oGnDOF1gv7UiwxSsseZE8/mTE9CVjsUJJvUq2As
 6bDZHWFO2BPMz/eAqGTzp15sQGxl+l6gpWketWV9BYqri9XIKnpm6jXsY+xWo3TxKsWA
 tCOL7rymqrZi0n5gKJHQtxPA1G6uYN/6I8ios0HI78JHpWM0rwdlf+xIGfcOnpGyNyGx
 nS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wd7d9ep88ByE38zD5bt6vgkmsRGd8wBMBDdBWJZDjbk=;
 b=y8jsCKdi3TAoN0eThhs22t5/US9xxr7mCQ9S87c3u/AzQTCRhu34bXl9O/zjbUbFp0
 XcK84EZsU+WAvuBkp3JJv5Ue2yvzOwuu1IpRV4mF+a/uqQUhGPzy/A+Y4TwfOTUQJeXC
 DH5/1A3/9FUZnL9wFVS/ydVP1GRqjaDgpQ2TWYsDxFnpZZkZpN0oXpmHCYK3LyVsX66H
 QG50fj3kttPcYSUh/jk6fzpqLl3YvagVv7z8CPAFY4oBdzU2bURem5GwB7IxL4OR5rKT
 fonNSSfvvWhPfcowbs5SqY3PUayTlmE/KsygL6WToa+99KT2kLunmSWJf24XMEhrhBWF
 R+Iw==
X-Gm-Message-State: AOAM532YdGjsHNZ06izcEP8tXQhZONGutAfKkcoynn+4oKbn/aYLeoRb
 xe744FMUKns66VohNBt07lzgds/kIS4V4TEtcRy1BSNSWl1Jgg==
X-Google-Smtp-Source: ABdhPJzI3a1j1K71Ga/tmShe+58GoTUkOANJkFZQA3Q+MmcRr+fpJXIAJqFvYKodbzg6wWj3IeArdTVfNq/MhnbdSJ0=
X-Received: by 2002:a05:6902:282:b0:64d:e139:c9b8 with SMTP id
 v2-20020a056902028200b0064de139c9b8mr29383950ybh.6.1653424407620; Tue, 24 May
 2022 13:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
 <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
 <Yo0xE5g3bowmF3H0@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0cpUNdb3mu+9pHG2oDfBmgmmCMQAo13axqO=jL5fwr_QJA@mail.gmail.com>
 <Yo1AOXKXkmrnnvou@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yo1AOXKXkmrnnvou@kbusch-mbp.dhcp.thefacebook.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Tue, 24 May 2022 16:32:51 -0400
Message-ID: <CAHex0coj1vAKRgf5BHAvjWeNgwj0JXyfDm6kFN48ZMpfdoHA7g@mail.gmail.com>
Subject: Re: nvme: split bios issued in reverse order
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_133330_887287_E5D17A38 
X-CRM114-Status: GOOD (  19.54  )
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

On Tue, May 24, 2022 at 4:29 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 03:37:56PM -0400, Jonathan Nicklin wrote:
> > On Tue, May 24, 2022 at 3:25 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > On Tue, May 24, 2022 at 12:12:29PM -0400, Jonathan Nicklin wrote:
> > > >
> > > > The command lines you have are for read operations. The behavior seems
> > > > only to appear with writes.
> > >
> > > Huh, I'll be darn...
> > >
> > > I think it's because the writes are plugged and the reads are not. The plug
> > > appends requests to the head of the plug list, and unplugging will dispatch the
> > > requests in the reverse order.
> >
> > Thanks for confirming! That's about where I got to. Do you have any
> > ideas on what might explain the difference in behavior between
> > fio/pvsync and fio/libaio? And, why does this not seem to occur when
> > only one nvme queue is present? Perhaps the in-order cases are an
> > indication of not being plugged?
>
> I actually didn't see a difference between libaio or psync, and also io_uring.
> They all plugged and reversed the dispatch order. Do you have a scheduler
> enabled?

Nope, there's no scheduler in the way.

