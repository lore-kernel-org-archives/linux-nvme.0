Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74904C4CEC9
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 21:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DE921848
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 21:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EDIrmb3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DE921848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9PRZeoe3Mtq/0c9CFylxe7cn4s5hBegGH9tbbBdB8ZE=; b=EDIrmb3VvKfXhB
	EPpm+QcahaOAdQ0DvS+UXqolm8IGW9i4OjwfKcMngzZlym6HPDUd92pKb/QxTkpECF0ciK3u9Hm2R
	qV2HIss85MNyJPLT1aiM1jRsyq3iDgKARLsGRXK/PViNMnUl5CxlYpCU5bXZcC47mBI5czx9CSVY1
	cZbR1cwvpc0ndU5gpy+bY93LAteI7j81E2Amt2xO81vbo4TiKC/kWXGUBwyofwAKFbQ8qmPuCqlCm
	8D+Zz/fJ1/pdMXKh53Z6PL7+5XvITiVNB8XbTxLoxdhoWveX+smKRQgR8KsMrkxFdmwcMc7OHtZ6H
	Cq6Mvwz+MJhKr1G69DGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAhwn-0007Cu-P3; Wed, 18 Sep 2019 21:57:13 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAhwk-0007Bp-Ce
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 21:57:12 +0000
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id b726423193c484be; Wed, 18 Sep 2019 23:57:07 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mario.Limonciello@dell.com
Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Date: Wed, 18 Sep 2019 23:57:07 +0200
Message-ID: <10489808.bq04Fa26WH@kreacher>
In-Reply-To: <346fd9ced98e40229d0cc0871ad5ed32@AUSX13MPC105.AMER.DELL.COM>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
 <4858057.cjDlXVALXj@kreacher>
 <346fd9ced98e40229d0cc0871ad5ed32@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_145710_595917_BFD2F57C 
X-CRM114-Status: GOOD (  22.33  )
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
Cc: Crag.Wang@dell.com, sagi@grimberg.me, linux-pm@vger.kernel.org,
 sjg@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, Ryan.Hong@dell.com,
 kbusch@kernel.org, Jared.Dominguez@dell.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wednesday, September 18, 2019 11:43:28 PM CEST Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Wednesday, September 18, 2019 4:31 PM
> > To: Limonciello, Mario
> > Cc: Keith Busch; Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> > nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> > Dominguez, Jared; Linux PCI; Linux PM
> > Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest
> > state
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Thursday, September 12, 2019 1:42:33 AM CEST Mario Limonciello wrote:
> > > The action of saving the PCI state will cause numerous PCI configuration
> > > space reads which depending upon the vendor implementation may cause
> > > the drive to exit the deepest NVMe state.
> > >
> > > In these cases ASPM will typically resolve the PCIe link state and APST
> > > may resolve the NVMe power state.  However it has also been observed
> > > that this register access after quiesced will cause PC10 failure
> > > on some device combinations.
> > >
> > > To resolve this, move the PCI state saving to before SetFeatures has been
> > > called.  This has been proven to resolve the issue across a 5000 sample
> > > test on previously failing disk/system combinations.
> > 
> > This sounds reasonable to me, but it would be nice to CC that to linux-pm
> > and/or linux-pci too.
> > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > ---
> > >  drivers/nvme/host/pci.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index 732d5b6..9b3fed4 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> > >  	if (ret < 0)
> > >  		goto unfreeze;
> > >
> > > +	/*
> > > +	 * A saved state prevents pci pm from generically controlling the
> > > +	 * device's power. If we're using protocol specific settings, we don't
> > > +	 * want pci interfering.
> > > +	 */
> > > +	pci_save_state(pdev);
> > > +
> > >  	ret = nvme_set_power_state(ctrl, ctrl->npss);
> > >  	if (ret < 0)
> > >  		goto unfreeze;
> > > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
> > 
> > This is the case in which the PCI layer is expected to put the device into
> > D3, so you need
> > 
> > pdev->state_saved = 0;
> > 
> > at this point, because you have saved the config space already.
> > 
> > >  		ret = 0;
> > >  		goto unfreeze;
> > 
> > And here you don't need to jump to "unfreeze" any more.
> > 
> > >  	}
> > > -	/*
> > > -	 * A saved state prevents pci pm from generically controlling the
> > > -	 * device's power. If we're using protocol specific settings, we don't
> > > -	 * want pci interfering.
> > > -	 */
> > > -	pci_save_state(pdev);
> > >  unfreeze:
> > >  	nvme_unfreeze(ctrl);
> > >  	return ret;
> > >
> > 
> > 
> > 
> 
> Thanks, I actually followed up with something along that line in a v2 sent out
> today.  My apology you weren't in CC, but here is a weblink to it.
> http://lists.infradead.org/pipermail/linux-nvme/2019-September/027251.html
> 

I don't think that pci_load_saved_state() will work, because it sets
state_saved at the end again (if all goes well).  You simply only need to
clear state_saved here.





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
