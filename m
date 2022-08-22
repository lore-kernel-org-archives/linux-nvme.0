Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B958C28D13
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Aug 2022 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OXJSHC3u10OP+HTbMpSxeKMRN8oREsLJAZ1clqoMmSE=; b=U6gm8+lY8qjOngpc6O82J9bfQi
	0SSzZjv9Xq6DuKSfihTDXPLAMuzYedPrC26jkOkUDeuBMScpWKCPe/0506QNq/UoaU+gtKzosM1vL
	pbDB/Ajzi0PZZhOy1jSGrKOMhKYOE8r37SMKMZJ11gbDs26LyUwpxxnbKmhl5lVo+HbHAVxLKCful
	yKhpHcfpayZaBxJWtcZLnkHR6jB1nmLZnXShl/qbwZT1EETsM1k67RVth9/qc32zyODs8D5a6kYdM
	U1mZqCBrqDfQIW6pM6/Mf8zkSOANxtdEXzhgmqS+SbpDnWPB+kSOYStlUIc2ck6qz+0gA7wrlgymx
	AXF/y4OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ1aM-005oS1-AW; Mon, 22 Aug 2022 07:10:58 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ1aD-005oJq-VG
	for linux-nvme@lists.infradead.org; Mon, 22 Aug 2022 07:10:52 +0000
Received: by mail-ed1-x534.google.com with SMTP id c39so12646407edf.0
        for <linux-nvme@lists.infradead.org>; Mon, 22 Aug 2022 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OXJSHC3u10OP+HTbMpSxeKMRN8oREsLJAZ1clqoMmSE=;
        b=RA4HZQCDGyC/SIDeLGpy5vj438ALKhnGrTPthx9WF5F5HpgPWbDULm3ZlExFGAc+XU
         9TsJVTaLDSbjyoumB0uaFuxID66Xi0UX+lP/uzTBbVBLCqQfOQBFVLTsNaa1Nu1gFVPM
         yeD6KyTOSzgfNeF+ICDsLrL4weCG72go6GbDCuVATFaQLL1ywpBnEq0oz5qGr/kfWznP
         HPQ43J8OvsDDKcrL7nl4kCWc1P9UBD8HnAqD/6Ukgwy98732aajgzuqiLeH2wptvoSh0
         cKvsSp87AAINTffTiuu/6mUev0LmUwqTYB3ivP+ugQlsh02tsfcavwdvLsx6Mp6hSRbf
         tEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OXJSHC3u10OP+HTbMpSxeKMRN8oREsLJAZ1clqoMmSE=;
        b=vYnJ3G8J5QlHnVG3Z0mmqQYkJRbNgnw9mx3hRB5lTWsZA4mdOkDw1EW2s8YTMhGQf5
         kEuBl0ehIrRreqAYQOwenwLMeTgDQcZtSVdkDJpIU3q0m1n2hbp58J6Q4IJIArCeF0Aa
         2vHZ191ElYYOoJASa/zMJBS+RXQZd6Yb1B2Rxga8ZxZ3ZBJJd/9UbIRG8OZ9nXkOVhLm
         PH+KXc/fRPmtIdqvIQkkaG2oWtkPeEC9IXlER3R8z9PpPvvfHQ9W0r0E0nrOwmU2S2ZN
         CXWf/H7mC6WAQenUbrxbXBBBls0SFR2/DznE9sq3FMvXgM+fonjzrmjebK5rsy0c5qdY
         bE4Q==
X-Gm-Message-State: ACgBeo3HDTmsVfuUCs1TkzFd2HhT+ujN7Iw+aOlfGSoF4uCw+wUYrQIW
	h7ty5Tyy9mMt9O4vl625sUfgJLld+cZBWpd6hEsVIg==
X-Google-Smtp-Source: AA6agR6GlsGATx8E1XQpTn7CSZWm+8KDw8Qzr9k38Vth1pGheZzAb26A/rhtk2zLUbTv2V3eAdYhXR2P8sP7f+aMfWg=
X-Received: by 2002:a05:6402:5106:b0:440:3693:e67b with SMTP id
 m6-20020a056402510600b004403693e67bmr15167256edd.226.1661152244210; Mon, 22
 Aug 2022 00:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-15-jinpu.wang@ionos.com>
 <20220821055745.GA26064@lst.de> <CAMGffEkhQd6oGgg+m9AUkquYnkufyrt1ptEkg5LG_HE_7s-Vsw@mail.gmail.com>
 <20220822062537.GA21455@lst.de>
In-Reply-To: <20220822062537.GA21455@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 22 Aug 2022 09:10:33 +0200
Message-ID: <CAMGffEk1CJAkaZi5GHrKdW-y1HQRUuo0YfRuGR8hFpNe1dZyoA@mail.gmail.com>
Subject: Re: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_001050_194146_48ABDF8B 
X-CRM114-Status: GOOD (  19.69  )
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

On Mon, Aug 22, 2022 at 8:25 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Aug 22, 2022 at 07:12:23AM +0200, Jinpu Wang wrote:
> > On Sun, Aug 21, 2022 at 7:57 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Please don't send me just two random patches out of a series, as I
> > > have no way to review them.  If the patches are independent, send them
> > > independently and if they depend on common prep work send the entire
> > > series to everyone.
> > Hi Christoph,
> >
> > As mentioned in the cover letter, the bugfixes are all independent,
> > for each of the drivers.
>
> I still haven't seen the cover letter as it was never sent to me.
> But if patches are independent please send a series per subsystem
> as that makes that very clear.
Thanks for the hint, this definitely helps the subsystem maintainer to
get a clear background.
I'll do it in the future.

