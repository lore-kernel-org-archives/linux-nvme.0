Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB6C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:56:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B2A610FA
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B2A610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X147PMaKvcxAdxFamNuYs3zZUKMuK1XPxF3vk6+Qwrw=; b=ChSQnWS0G0t3lWZjQZ37WDUpc
	9SDmsFwS/DUbxJ3kRfajv2/DRKLoHSNhypicWD1brTdqHe0+TaDKd6/9tJzGm2it1CtGxfnz1HqIT
	fsfXQOOKz0QbJ7NZYlGOXCj3VquSuu4JIdtOv8hfZCwQXzvbGRiCSiGsvMYyu7/xo+CVLttSrO8if
	4dBCGSRUzkvejhHwCemGTisQ/GDxgOtDSpaHwZvMlkfyPyMcBsFVDrtxHUL/UZpZJu8eO4jxfgvLE
	ZIncEROuRQKxUMlItkusJtQwl5792LJWWucWzqWuw4OHITSD4IKKTOgjvIrcH0xbjnWhZd/UKt1w3
	wtRmBij3g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ligX5-00FaF4-Vy; Mon, 17 May 2021 16:55:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligX2-00FaEs-W6
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 16:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=N0SbHsdelBsQBb8+A+ZjphqcSc7i/BnJ45oflQMUF2g=; b=Smg7fcIu/EpnYuD4sZBhqdQOyX
 13z1nuvPZhB+4od6lI9Xk2asEPnp2MujmAUjwKKD1QaOOVHulcVrIS9QlhD8ua2hnEIl00foCDrYL
 PV3+PcwGZLpd8AqQWbdcjwWoODXJ4r0R8CNp5+cGptZfZpv8KeTybxVDxbABz3Fb73nido2Hns2D6
 Jm3lBtDTAlg2zM03MTnvUcH8Sahndu3d4SSsY9/h+R8qJtcTgiUffCHs10M+7YvZEbvAellWJXrAY
 1K6KgVAY8weSghZ1+/E2oqfj2y8mBARJCGigqG4wxgySV+QN2Cu/w+NeVB4/Q2K4ULfi6KWI2JC4A
 MVCTbsiQ==;
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligX0-00DztZ-D5
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 16:55:51 +0000
Received: by mail-wr1-x42f.google.com with SMTP id n2so7239160wrm.0
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N0SbHsdelBsQBb8+A+ZjphqcSc7i/BnJ45oflQMUF2g=;
 b=cAiNfAHMALBczXj0RaoSTyesPa47r8kBHAORdjBwyJ1BCeeCVZyYW7d582niuXUgU5
 2R56PvB3tN/JF3Y5lqG4VIf3S4mxYjsCR7DbNYAH1p9/pyXKvPlDHz8Ny4i6gCL7hblO
 fsFJZ2mtSi3iH/X7bJLAsQwg/3MTJvNLMM7k9qXOePYSpTjaisPzwTvEX/z2QWxFUpXf
 cBi2h1pP4xMfpG0boMl24ZzaQxbHq7/HdhOoaBCN0lI+61EiPtgA3Bq1qV6bLXogHydL
 yt1cDSAaRCmb9prbaifMGFNEfl8r9tVQQGouxGtrCikP0bh4fSFJvhQa7A+xqbiPXop6
 G9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N0SbHsdelBsQBb8+A+ZjphqcSc7i/BnJ45oflQMUF2g=;
 b=RaUJam+iLGDZvsXnyhH/fg2Q5recOoP5jnZ/o7p3/cW8fxe097jlKqfLiGQf52be86
 OqAUaCaYYHsq60hYneV55LUHUGZWZYXjSq/I78LT7rQ2rl5fDFvfe32KJj+wMG8rD7Zp
 hBipsoakl0ArHdTsJ20o0hfAWbXk8FEtKmkhm1BEgWBn34dFuPyrwbMUm8ahehQAdAPj
 tXtGZdlWfZ1gxEQ1vLBC0uYOvwetPOUCGwycj8KYQ/zV2qgySsVmPAjHlMNzSjepTaOU
 RUOxad2Zia+XYrQyUZKi+3S2wss19XAY1yULM3nMHyQJuC3XW8KAuUEv3aqtNAgbKYTk
 TNJw==
X-Gm-Message-State: AOAM532AsyV3tonUHL3PaZOBtAywe8FVG0NO5474z8IWqlZ+wSSXU7Kg
 CaN11JX3sMzcQm+xlFlQsMWUN7hESRqJYvVvrXI=
X-Google-Smtp-Source: ABdhPJyxVvzx2e2V5BKPlYe/kYKx+qAVx9p7s/eel32ljWLOXdUDyucQzb1RuI6CsT8aItREGEbjSOx8Kqo2HqnYPns=
X-Received: by 2002:a5d:5508:: with SMTP id b8mr743886wrv.278.1621270548615;
 Mon, 17 May 2021 09:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-6-kbusch@kernel.org>
 <20210426144316.GE20668@lst.de>
 <20210426151537.GB12593@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210426151537.GB12593@redsun51.ssa.fujisawa.hgst.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 17 May 2021 22:25:21 +0530
Message-ID: <CA+1E3rLD7Zx2iKtUoTBVc4VXBj2ohXFeXSw59umBZ3Q=QEA0xQ@mail.gmail.com>
Subject: Re: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, 
 Yuanyuan Zhong <yzhong@purestorage.com>, Casey Chen <cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_095550_461919_869BCD95 
X-CRM114-Status: GOOD (  20.52  )
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

On Mon, Apr 26, 2021 at 8:46 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 04:43:16PM +0200, Christoph Hellwig wrote:
> > On Fri, Apr 23, 2021 at 03:05:58PM -0700, Keith Busch wrote:
> > > The block layer knows how to deal with polled requests. Let the NVMe
> > > driver use the previously reserved user "flags" fields to define an
> > > option to allocate the request from the polled hardware contexts. If
> > > polling is not enabled, then the block layer will automatically fallback
> > > to a non-polled request.
> >
> > So this only support synchronous polling for a single command.  What
> > use case do we have for that?  I think io_uring based polling would
> > be much more useful once we support NVMe passthrough through that.
>
> There is no significant use case here. I just needed a simple way to
> test the polled exec from earlier in the series. It was simple enough so
> I included the patch here, but it's really not important compared to the
> preceeding patches.

It would be great to see this in at some point; helps in making
passthrough more useful.
I'll look into integrating this with async-passthrough.

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
