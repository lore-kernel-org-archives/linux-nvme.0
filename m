Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5585C07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:13:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B03961966
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B03961966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VVQZlKt84PcWEH6dwbeP1GyupYAwxVDNmucYBX7YMq0=; b=Z7sGKGXOyNVp1r
	k/E7GBsCDf9ZLLKuu1Udr9RHh7N9j/5eCp9yflS7VZKGHaPEgL/wEYzqmmj7P0J4q0Sn1CR+gZWQu
	wf7vpONw+LfteW1KoFWW19rLGAmbJ9gV6vEcMHOwJqhpEw2h6JHonBdLmjd8r/cGoitGXQ03mMP2i
	z2CKBBc1JTMSfKTu4ml8eg7yIyr9Q6JZrAyl/lclgKOMPo7EjiDJQaJrGgdlB/h0exAGJXD5cSBfJ
	Vsj5y9rEkQ5LIhvTtgSvf6NN2tGYST1SS86aywmtp7xmTGnRLuALcrWmH3A15cBIKDBaYyYPMefHK
	QyHi0ftKJDyHtSVA+o4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QHl-009Ipd-Jo; Mon, 05 Jul 2021 15:13:25 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QHi-009IoS-Gz
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:13:23 +0000
Received: by mail-pj1-x102e.google.com with SMTP id g24so11888700pji.4
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=04kgaJvqJScDYuLDpGx1FmDxXBGCIWOopDifA8aKHwE=;
 b=kWlMsC61CqEAz21EoaMUW64Ryo3XcMxxRhf1W7GnDqqMbsjaW7TmKxknzh2K/WmVhk
 MgdIFn8Z6M8ZHTW0WN+dvMoDh/ip2k6wQdendfigMavCwRQypjoS/1CrdnknWKdr7M5r
 7natHoIuzacX/Dm+Bagqmv9Oyln5azRuMWMp5MD+VlTqNolu/yZnOLEHlZizshFekQvF
 BMBUt9NbMvAMGTA3S6HwKqPF1XudCoPFxpYraWLOlzH+CaKT1odSIQwiXVaTC/rWKCwq
 MTQOqX1+ZC75M6WfFHxYBVhR30dXReIsinv7hCDxlOJYssKEfiFdsReNcwSbuisyVw5k
 vVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=04kgaJvqJScDYuLDpGx1FmDxXBGCIWOopDifA8aKHwE=;
 b=ezKy6Yj59nlyXliN/ZZy6FDk0KlmeM1VVtWPgqfSA0ryECE1Tae53q35S8cPUKJiGg
 wRojZaX7TLTmS4At3MSc3JjJbBx/atutjLJ1IZmoUZgFngfrm6OYoaZotH0UZSEMco3P
 AdPFD0xGqb5pd1yPYEmslHqzBShnBawT8pLnaMjGwUHVzSG/im7EYWOlaRA4QRKCf0vJ
 1w6WueaCIdkg0c2/jQ/vZlbCSP2np8V2XgGWi4fLLGT9Sup6Nr4clgiHKnlAbaeS5T06
 q6A9GE9WshjFXFG2fzWemnYemhkLoEPvOzSuy4XGX4qSSmx7flcCHs/+GxLKPNRsRZrw
 U1zw==
X-Gm-Message-State: AOAM533JX0jJLMaYojzTEyMIgyM9rMtBCw6gO5ZrAUidDCmfidSKZ4/R
 C03duv1o/n19yq+wOMRnB9mshoRhi3wzJ37CNM8=
X-Google-Smtp-Source: ABdhPJzcUKNFt78pSbi9QhgG58rXCw3p5419/aKym3toe63JLfml7Fo8pb+F5KpR0YgIYLx8eB1t/3NojcdG09oFDxM=
X-Received: by 2002:a17:90a:4417:: with SMTP id
 s23mr15758219pjg.228.1625498001818; 
 Mon, 05 Jul 2021 08:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-10-pkushwaha@marvell.com>
 <20210701134118.GE18548@lst.de>
In-Reply-To: <20210701134118.GE18548@lst.de>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 5 Jul 2021 18:13:10 +0300
Message-ID: <CAKKgK4x0O+VXY_T3zpqoC0ZEh5rBVj1gHu_kgfEi+f57+XMzrA@mail.gmail.com>
Subject: Re: [PATCH v4 09/20] qedn: Add qedn - Marvell's NVMeTCP HW offload
 device driver
To: Christoph Hellwig <hch@lst.de>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shai Malin <smalin@marvell.com>, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, 
 prabhakar.pkin@gmail.com, Arie Gershberg <agershberg@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_081322_619200_49E04AE1 
X-CRM114-Status: GOOD (  20.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 1 Jul 2021 at 16:41, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jun 29, 2021 at 03:47:32PM +0300, Prabhakar Kushwaha wrote:
> > From: Shai Malin <smalin@marvell.com>
> >
> > This patch will present the skeleton of the qedn driver.
> > The new driver will be added under "drivers/nvme/hw/qedn" and will be
> > enabled by the Kconfig "Marvell NVM Express over Fabrics TCP offload".
>
> I don't see why we need a separate hw/ directory.   nvme-pci.c already
> is very much a hardware driver.

We will restructure and keep only the bare minimum qedn.c under nvme/host.

>
> > +config NVME_QEDN
> > +     tristate "Marvell NVM Express over Fabrics TCP offload"
> > +     depends on NVME_TCP_OFFLOAD
>
> I think it also depends on PCI.

Thanks!

>
> This whole patch is a bit pointless.  In general splitting a driver
> submission into multiple patches is not very helpful unless the later
> patches add pretty much optional and clearly separatable bits.  Otherwise
> it just becomes really hard to review.

Understood. We will improve it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
