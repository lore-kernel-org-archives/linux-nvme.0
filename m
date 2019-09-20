Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F56C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:26:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AF02080F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fwr1H3Hp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja5JlVw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AF02080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ejjePU63NK8Ja1aPnOtZJpFvZNIGHH6u9cqvyWPsnk8=; b=Fwr1H3HptLSr7b
	H547+FjRKOdAEqq6KMaE/m/wXeMHKgBFGsZOymC74uw1zTU7IoTe5na+/D7TtYcKifz+IwzIJ8ysy
	rsguk3UQ6vEhdMVV0JyEhDB/IYeh6MkHGdU1bRrEPrx/LNrm/dqhjosnwmrqSaTyGvggNzDHhiAlw
	q+ZhSetdlKTaybU9bO1GUsHhEphEUZ10PJAnip8KUYl3wEAOP3N7MBJZuqmngMJxu4Kt/sx1FkFya
	jbU695mg20rY08vbtaE83ymWynjhT/4Lvxwg5Y9hbhLPBQWjj5oLU0IrTKJHb/cWYIHoRzNO8w35n
	ArWCyNAmYXNRTyl2tw3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBNcA-0001fj-2N; Fri, 20 Sep 2019 18:26:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBNc7-0001fQ-Py
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 18:26:41 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2EF672070C;
 Fri, 20 Sep 2019 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569003999;
 bh=i1Ur6NlyITnANive2sC5JCKUoJsiKXHrgVwP7SYtqyI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ja5JlVw8TihX2Ru36kug/A27MWxu2DbKvWvpqxS/p3sJ05SWguwLa7BoAsfWX2wkd
 TceuRVO3fS1i3TEnto/NFrWpq6lH0Iu+VPdqARD7MWE7E2KEsnVgDvCAlm+KKBW0y5
 oEMYZZWvsZsqpQu2LtY0MxB37wet6zDOLz3qwxd0=
Date: Fri, 20 Sep 2019 12:26:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 6/6] nvme: Wait for reset state when required
Message-ID: <20190920182637.GD97854@C02WT3WMHTD6>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-7-kbusch@kernel.org>
 <debdee44-22a1-0361-9d20-4af6a11dab0d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <debdee44-22a1-0361-9d20-4af6a11dab0d@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_112639_867465_DA8BDDA0 
X-CRM114-Status: GOOD (  15.04  )
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

On Fri, Sep 20, 2019 at 11:13:06AM -0700, Sagi Grimberg wrote:
> On 9/19/19 2:34 PM, kbusch@kernel.org wrote:
> >   static void nvme_reset_done(struct pci_dev *pdev)
> >   {
> >   	struct nvme_dev *dev = pci_get_drvdata(pdev);
> > -	nvme_reset_ctrl_sync(&dev->ctrl);
> > +
> > +	if (!nvme_reset_continue(&dev->ctrl))
> > +		flush_work(&dev->ctrl.reset_work);
> 
> Is nvme_reset_continue allowed to fail here?
> As I see it, the flush must complete regardless doesn't it?

I was thinking a surprise hot-removal, but no, the pci driver is holding
the device lock across the prepare/done sequence, so I don't think it's
possible for this reset_continue() to fail to schedule.
 
> >   }
> >   static void nvme_shutdown(struct pci_dev *pdev)
> >   {
> >   	struct nvme_dev *dev = pci_get_drvdata(pdev);
> > -	nvme_dev_disable(dev, true);
> > +	nvme_disable_prepare_reset(dev, true);
> >   }
> >   /*
> > @@ -2898,7 +2920,7 @@ static int nvme_resume(struct device *dev)
> >   	if (ndev->last_ps == U32_MAX ||
> >   	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
> > -		nvme_reset_ctrl(ctrl);
> > +		return nvme_reset_continue(&ndev->ctrl);
> 
> Is the controller allowed not to be in RESETTING in this stage?
> do we need a WARN_ON if it is?

This one, though, I think a hot removal can cause this to fail since the
device lock isn't held from suspend all the way through resume, so we
could be in the DELETING or DEAD state.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
