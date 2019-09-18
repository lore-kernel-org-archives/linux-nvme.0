Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE2C4CEC9
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 21:27:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A008A21907
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="geTjuTNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A008A21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K//lF+zRwDuwEG1Bhufh2YzRLu+9PNscixl0k2T/+lc=; b=geTjuTNE7+YCJu
	ksfBtcyiJVtu5CGtVIvHem8uHeMsrh6XnUYyY1KrxGUjV5F9ZX5gXE77/U+bE50u95Q/gRBwCob5n
	kU0x/48vzDn6Y6gkR3l4upyfqDZDBnotFeBlgVcWn0Zgnj4effi9UbDifBq/tanawjytCpflwuQXa
	I4Jcys5icUsOmDoiHWIso+X4vrK9mD2COb6qPsY2wA87TJk0U/i39EnamqL5wx1tiTNt4ch5OSU6A
	7EmYRpqU1P48Y5qs88O6hJpzI8WKkjq/DlIW/wj+DelTXeL54F4CzbmWQCqSWcfL8CQgbXgKs/jFP
	gdXJWpaA8P+xbdwnmwHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAhTg-0005ME-Jf; Wed, 18 Sep 2019 21:27:08 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAhTd-0005LS-9n
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 21:27:06 +0000
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id e472a91455a20de2; Wed, 18 Sep 2019 23:27:02 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mario.Limonciello@dell.com
Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Date: Wed, 18 Sep 2019 23:27:01 +0200
Message-ID: <5633857.hqcsiBO4aL@kreacher>
In-Reply-To: <706f61c67b354f3d8f841a82e3d48541@AUSX13MPC105.AMER.DELL.COM>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
 <10773060.Xg13aEV830@kreacher>
 <706f61c67b354f3d8f841a82e3d48541@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_142705_503368_B8D3F8EC 
X-CRM114-Status: GOOD (  23.00  )
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
Cc: Crag.Wang@dell.com, sagi@grimberg.me, sjg@google.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 Ryan.Hong@dell.com, kbusch@kernel.org, Jared.Dominguez@dell.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wednesday, September 18, 2019 6:52:31 PM CEST Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Tuesday, September 17, 2019 4:36 PM
> > To: Keith Busch
> > Cc: Limonciello, Mario; Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> > nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> > Dominguez, Jared
> > Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest
> > state
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Tuesday, September 17, 2019 11:24:14 PM CEST Keith Busch wrote:
> > > On Wed, Sep 11, 2019 at 06:42:33PM -0500, Mario Limonciello wrote:
> > > > The action of saving the PCI state will cause numerous PCI configuration
> > > > space reads which depending upon the vendor implementation may cause
> > > > the drive to exit the deepest NVMe state.
> > > >
> > > > In these cases ASPM will typically resolve the PCIe link state and APST
> > > > may resolve the NVMe power state.  However it has also been observed
> > > > that this register access after quiesced will cause PC10 failure
> > > > on some device combinations.
> > > >
> > > > To resolve this, move the PCI state saving to before SetFeatures has been
> > > > called.  This has been proven to resolve the issue across a 5000 sample
> > > > test on previously failing disk/system combinations.
> > > >
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > ---
> > > >  drivers/nvme/host/pci.c | 13 +++++++------
> > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index 732d5b6..9b3fed4 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> > > >  	if (ret < 0)
> > > >  		goto unfreeze;
> > > >
> > > > +	/*
> > > > +	 * A saved state prevents pci pm from generically controlling the
> > > > +	 * device's power. If we're using protocol specific settings, we don't
> > > > +	 * want pci interfering.
> > > > +	 */
> > > > +	pci_save_state(pdev);
> > > > +
> > > >  	ret = nvme_set_power_state(ctrl, ctrl->npss);
> > > >  	if (ret < 0)
> > > >  		goto unfreeze;
> > > > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
> > > >  		ret = 0;
> > > >  		goto unfreeze;
> > > >  	}
> > > > -	/*
> > > > -	 * A saved state prevents pci pm from generically controlling the
> > > > -	 * device's power. If we're using protocol specific settings, we don't
> > > > -	 * want pci interfering.
> > > > -	 */
> > > > -	pci_save_state(pdev);
> > > >  unfreeze:
> > > >  	nvme_unfreeze(ctrl);
> > > >  	return ret;
> > >
> > > In the event that something else fails after the point you've saved
> > > the state, we need to fallback to the behavior for when the driver
> > > doesn't save the state, right?
> > 
> > Depending on whether or not an error is going to be returned.
> > 
> > When returning an error, it is not necessary to worry about the saved state,
> > because that will cause the entire system-wide suspend to be aborted.
> 
> It looks like in this case an error would be returned.

Not necessarily.

If nvme_set_power_state() returns a positive number, you need to clear
pdev->state_saved before jumping to unfreeze.

Actually, you can drop the "goto unfreeze" after the "ret = 0" (in the
"if (ret)" block) and add the clearing of pdev->state_saved before it.

Let me reply to the original patch, though.

> 
> > 
> > Otherwise it is sufficient to clear the state_saved flag of the PCI device
> > before returning 0 to make the PCI layer take over.
> 





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
