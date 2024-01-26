Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390B4C47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mgPbQ+FuUcCNO4TJAWRkXliPfQCX2Ifa+M/plIKBn7w=; b=yegjNFyTe3vE0aB4Uwv7J0gNCs
	5fmHI8whGa+eQ2X9e7QRMcnKEEpaZ2M3TNhchxKQEEN665KVQRCwb5/wqjbmfOTQSApjyYlHJcr27
	ZREhigOmplwkxXNprgbPzCyfDsZgrpGs3zV0cpo/dbN3/DZavr86/BUpxJbJTs1pmZElPru+DceQn
	Qr4VnliHwM2qPeuLFp4vjHV5BX9WdTO5g6z8PHM0/Iv/IwfLBqF/u0aj2PMcZWwCszjYhLV/797uO
	8bpdVDr0nG/CmCxQVm5waGD4L7pHPxT0D1AzsS/UX8zA1tFJePcyGD6buMxjrZi/DaW779+6PtK1m
	yYPVheXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTP6Y-00000004g29-0W5m;
	Fri, 26 Jan 2024 16:30:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTP6V-00000004g1Y-10r0
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 16:30:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A832F62554;
	Fri, 26 Jan 2024 16:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCCEC433F1;
	Fri, 26 Jan 2024 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286624;
	bh=v0qdQR9nYD9/qOoECb7LiKHfknlAPmnm93OsmNPCDqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5H3iTEOec1D1OUnLuSGtmF8fytO1zI5peaqzuvKarWtEDZXi95q4RkWqPMDbOiqH
	 RTg+3PaoxIFheowCIlfBa3wHCXoPJxDGf45eaoV5gSSzt8TI+OpQIZwmqPKUF2d50u
	 6qvra8wJb5og15RUpmps/V2E7pniEX+6RXIet2pLugLK39Y3ZI3P545BKlwKcMiwQO
	 ifAyDG2xgryj4gQtgs2qCIzAidO8aQ/xf/oiaSq0D+ARh1iZv0MtxKR9xRADgOXkgK
	 th6RvpwfVVgBt0njnq6Hpsfsksvfz52d04ey9/SXfiwMLx5r+juILqAZeNZfC2pVa1
	 4MDlQu+wxWBxA==
Date: Fri, 26 Jan 2024 09:30:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2] nvme: use ctrl state accessor
Message-ID: <ZbPeHZWxvrCT9xqd@kbusch-mbp.dhcp.thefacebook.com>
References: <20240125155213.3727106-1-kbusch@meta.com>
 <221c0e4d-2aea-4e5f-8b17-76cd0a5284d7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221c0e4d-2aea-4e5f-8b17-76cd0a5284d7@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_083055_832226_9BA89692 
X-CRM114-Status: GOOD (  15.25  )
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

On Fri, Jan 26, 2024 at 08:25:38AM +0000, Chaitanya Kulkarni wrote:
> On 1/25/24 07:52, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> >
> > The ctrl->state value is updated in another thread using WRITE_ONCE, so
> > ensure all the readers use the appropriate accessor.
> >
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >
> 
> Keith,
> 
> Not sure if nvme_check_ready() needs nvme_ctrl_state() ?
> 
> consider :-
> 
> * Thread A running timeout handler :-
> nvme_timeout()
>   ends up resetting ctrl state at the end of function using WRITE_ONCE() :-
> 
>   disable:
>             nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)
>              WRITE_ONCE()
> 
> * Thread B issuing I/O :-
> nvme_queue_rq() or nvme_prep_rq_batch()
>   nvme_check_ready()
>    ctrl->state == NVME_CTRL_LIVE
> 
> Since timeout handler's nvme_change_ctrl_state() call will result in
> updating ctrl->state with WRITE_ONCE(), hence reader in the 
> nvme_check_ready()
> should also read using nvme_ctrl_state()->READ_ONCE() ?
> 
> if it is not needed please ignore above question, looks good to me ..

It should be a READ_ONCE() here. Consider it's an inline function that's
called in a loop (at least from pci), so a compiler may optimize the
read so that it happens just once instead of at each iteration as
expected.

I missed this one, I'll get it added for the next version.

