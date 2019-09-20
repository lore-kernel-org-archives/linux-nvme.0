Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA4CC3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 21:06:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CED205F4
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 21:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pjMKxeF6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEhWDqrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CED205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pFW6ljhvfcdUL0fwRniXTHwucp1LUSgdONwCtc6hSh4=; b=pjMKxeF6nToef/
	lg3vZWBakK4zYFP3tGRs0k/XjqQ1hB2egdrDiE/+MEDivPVWT+s+g36S1QQHeJmkMdUg7wo+88tIb
	g7eWaydrRe6RPPrLCCQwVYcc57JGMHyoSKcD1Ak4U2D/TpW5JwsRt43QAoN3N2Ggp2eS0elczVmjw
	tYhUdxjTvt/5QmDcg3oAOlIRRmM7MB9KJqIz0F5uyDBw1jE01ZuFf3mTFu1viRf8g82TPWzgxDqfL
	ahrm1DrkEL/QK0EQW11EIqLQSEqm2L7u8fw9aCBi9hQfdKMANFQYtQzxQo3XiB5SVHBHmH3MBSIIp
	iETlB60To9m9J8fTs3bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBQ7A-0005q1-D0; Fri, 20 Sep 2019 21:06:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBQ77-0005pZ-JA
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 21:06:50 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50DEE205F4;
 Fri, 20 Sep 2019 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569013608;
 bh=xs5oGTif9HdSNkhNlpe1eqvmzTMtiKdWGHq2YaYl3Pc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SEhWDqrGXDllKD3CNeSvzGvTFC/uv6U2ohYpUNHAewlefZyVCtojCfMneMrczlK/r
 M88t11BOTLNF4tuHukFJ12q6Q8NXsUlKuRRPstLYqjzaxI7ksdtgtqyunatVBgxCv7
 mvaU70cjh+as8QlL4B5h26VDRmlOWZ1czJo6ESro=
Date: Fri, 20 Sep 2019 15:06:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 6/6] nvme: Wait for reset state when required
Message-ID: <20190920210645.GA30909@keith-busch>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-7-kbusch@kernel.org>
 <debdee44-22a1-0361-9d20-4af6a11dab0d@grimberg.me>
 <20190920182637.GD97854@C02WT3WMHTD6>
 <20190920192903.GE97854@C02WT3WMHTD6>
 <8bae471f-e7d6-89a3-81bc-498b9d42c392@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8bae471f-e7d6-89a3-81bc-498b9d42c392@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_140649_665828_485506B1 
X-CRM114-Status: GOOD (  16.77  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 20, 2019 at 01:49:57PM -0700, Sagi Grimberg wrote:
> 
> > > > >    static void nvme_reset_done(struct pci_dev *pdev)
> > > > >    {
> > > > >    	struct nvme_dev *dev = pci_get_drvdata(pdev);
> > > > > -	nvme_reset_ctrl_sync(&dev->ctrl);
> > > > > +
> > > > > +	if (!nvme_reset_continue(&dev->ctrl))
> > > > > +		flush_work(&dev->ctrl.reset_work);
> > > > 
> > > > Is nvme_reset_continue allowed to fail here?
> > > > As I see it, the flush must complete regardless doesn't it?
> > > 
> > > I was thinking a surprise hot-removal, but no, the pci driver is holding
> > > the device lock across the prepare/done sequence, so I don't think it's
> > > possible for this reset_continue() to fail to schedule.
> > 
> > Oh wait, there actually is a way, and I even accounted for it in this
> > patch, but just forgot about it. If we start an FLR while the controller
> > is CONNECTING, and if that CONNECTING fails, we'll transition to DELETING.
> > So yeah, reset_continue could fail.
> 
> And nvme_remove() will flush the reset_work?

If scheduled, yes, nvme_remove() flushes reset_work.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
