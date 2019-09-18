Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3668DC4CEC9
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 22:04:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0681921848
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 22:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mB7nTvBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0681921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lG4kTqP2lX2FHHgVJXcqr/VaIdN8FDH4zHqQtCBP+qU=; b=mB7nTvBLQe7RUw
	gAzfxJ9x7D34G2CZl2FP4YATqKoHr+MJ8ooM91wDoBzIXiRQ5+H4dovWwFnmA0PvdsY5FY+s4zHvx
	pzcRl6aQXDm1GjXtjg0PPArt3TsKxdnhFy6OrnjcNzZDgEeaITAKeR6gSqIOqrr0X5TeBfsSlQszy
	r+FRs8WahS49XAEd1hty4bE98SjlkkIt1wH2dXsKjbSW6yav/BOgqQSGN4x/TslzwVZIG03BX2m2V
	2pnSEGtjbgahhS3kdGVUN+ICXjaPoJDa4o1hs7ptOnsh8W21v/uYyikHeYinGEBfnUE1Z0slkRijN
	xsZtn8P81kBrj/zNOpBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAi3b-0000uL-2D; Wed, 18 Sep 2019 22:04:15 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAi3X-0000tL-My
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 22:04:13 +0000
Received: by mail-ot1-f66.google.com with SMTP id z6so1304578otb.2
 for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2019 15:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bJQPPaEQfRujWhva+eG3XWYsZN4JmOiFGTYIBU8GRfQ=;
 b=eYvzcfC6wwZu5u7dTGqEF/CBW++soYMjB1YARR0je3oRRbyfZBURrzoCcBIsJT874D
 qVIEPRX/JnPi6qRtCMaBBcskrs3bk1eFBEJWo/QzdXcHE1VV+lwRExyjYrgf2ub7v5bs
 t3Pki5h0t2PnypcYgggxkZBZVh+1okEBpsmKmSuLS/XbXN+aoQPiMR6UwhjZU22LjNaB
 fKWrKzplzDC9tRfcpdZacME9GsU0vVYMXVQXNxRdz5SRKGDxAtdmclkWAJHWPBlBSBcm
 6QACNWSpCNc+ZAEOZ3v7SNCmlUL1DyPL21Jyafb1HoiQNR22VrJSW6ihfISfm9mbS4iP
 08fw==
X-Gm-Message-State: APjAAAXuXZsF1Z0zb08elc8jYlXLRj2WKVNMVxLuVtAo0HvftipJQowX
 4maUT8OxlX90vExOFYWL01Ljpc6YOBFS57uJA0Y=
X-Google-Smtp-Source: APXvYqy4t38dZCR52mMACnH8PhL4bjKROen1EQLwOHpraGIwLh95YbB75ppd/j9YGKJ3hGlXh2Xry/BpznO93HaN/dM=
X-Received: by 2002:a9d:798c:: with SMTP id h12mr4348107otm.167.1568844249341; 
 Wed, 18 Sep 2019 15:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
 <4858057.cjDlXVALXj@kreacher>
 <346fd9ced98e40229d0cc0871ad5ed32@AUSX13MPC105.AMER.DELL.COM>
 <10489808.bq04Fa26WH@kreacher>
 <247e1ed126774d32b0d70092b65adb6a@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <247e1ed126774d32b0d70092b65adb6a@AUSX13MPC105.AMER.DELL.COM>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Sep 2019 00:03:57 +0200
Message-ID: <CAJZ5v0iwovZtCnnu+CF5Z6DjRsC2a43Jdi+9SEufADAOF8sCcg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
To: Mario Limonciello <Mario.Limonciello@dell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_150411_752653_CB95DC9F 
X-CRM114-Status: GOOD (  27.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Crag.Wang@dell.com, Sagi Grimberg <sagi@grimberg.me>,
 Linux PM <linux-pm@vger.kernel.org>, sjg@google.com,
 Linux PCI <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@fb.com>,
 Ryan.Hong@dell.com, Keith Busch <kbusch@kernel.org>, Jared.Dominguez@dell.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 19, 2019 at 12:00 AM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Wednesday, September 18, 2019 4:57 PM
> > To: Limonciello, Mario
> > Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-
> > nvme@lists.infradead.org; linux-kernel@vger.kernel.org; Hong, Ryan; Wang,
> > Crag; sjg@google.com; Dominguez, Jared; linux-pci@vger.kernel.org; linux-
> > pm@vger.kernel.org
> > Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest
> > state
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Wednesday, September 18, 2019 11:43:28 PM CEST
> > Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Sent: Wednesday, September 18, 2019 4:31 PM
> > > > To: Limonciello, Mario
> > > > Cc: Keith Busch; Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> > > > nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> > > > Dominguez, Jared; Linux PCI; Linux PM
> > > > Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into
> > deepest
> > > > state
> > > >
> > > >
> > > > [EXTERNAL EMAIL]
> > > >
> > > > On Thursday, September 12, 2019 1:42:33 AM CEST Mario Limonciello wrote:
> > > > > The action of saving the PCI state will cause numerous PCI configuration
> > > > > space reads which depending upon the vendor implementation may cause
> > > > > the drive to exit the deepest NVMe state.
> > > > >
> > > > > In these cases ASPM will typically resolve the PCIe link state and APST
> > > > > may resolve the NVMe power state.  However it has also been observed
> > > > > that this register access after quiesced will cause PC10 failure
> > > > > on some device combinations.
> > > > >
> > > > > To resolve this, move the PCI state saving to before SetFeatures has been
> > > > > called.  This has been proven to resolve the issue across a 5000 sample
> > > > > test on previously failing disk/system combinations.
> > > >
> > > > This sounds reasonable to me, but it would be nice to CC that to linux-pm
> > > > and/or linux-pci too.
> > > >
> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > > ---
> > > > >  drivers/nvme/host/pci.c | 13 +++++++------
> > > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > > index 732d5b6..9b3fed4 100644
> > > > > --- a/drivers/nvme/host/pci.c
> > > > > +++ b/drivers/nvme/host/pci.c
> > > > > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> > > > >         if (ret < 0)
> > > > >                 goto unfreeze;
> > > > >
> > > > > +       /*
> > > > > +        * A saved state prevents pci pm from generically controlling the
> > > > > +        * device's power. If we're using protocol specific settings, we don't
> > > > > +        * want pci interfering.
> > > > > +        */
> > > > > +       pci_save_state(pdev);
> > > > > +
> > > > >         ret = nvme_set_power_state(ctrl, ctrl->npss);
> > > > >         if (ret < 0)
> > > > >                 goto unfreeze;
> > > > > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
> > > >
> > > > This is the case in which the PCI layer is expected to put the device into
> > > > D3, so you need
> > > >
> > > > pdev->state_saved = 0;
> > > >
> > > > at this point, because you have saved the config space already.
> > > >
> > > > >                 ret = 0;
> > > > >                 goto unfreeze;
> > > >
> > > > And here you don't need to jump to "unfreeze" any more.
> > > >
> > > > >         }
> > > > > -       /*
> > > > > -        * A saved state prevents pci pm from generically controlling the
> > > > > -        * device's power. If we're using protocol specific settings, we don't
> > > > > -        * want pci interfering.
> > > > > -        */
> > > > > -       pci_save_state(pdev);
> > > > >  unfreeze:
> > > > >         nvme_unfreeze(ctrl);
> > > > >         return ret;
> > > > >
> > > >
> > > >
> > > >
> > >
> > > Thanks, I actually followed up with something along that line in a v2 sent out
> > > today.  My apology you weren't in CC, but here is a weblink to it.
> > > http://lists.infradead.org/pipermail/linux-nvme/2019-September/027251.html
> > >
> >
> > I don't think that pci_load_saved_state() will work, because it sets
> > state_saved at the end again (if all goes well).  You simply only need to
> > clear state_saved here.
>
> Explicitly calling it with NULL as the saved state to restore seemed to have that effect
> of clearing state (there is an explicit check in there if it's NULL to just return 0).

Ah, OK, right.

I still would rather clear the flag directly, though, as using
pci_load_saved_state() for that is just more convoluted. :-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
