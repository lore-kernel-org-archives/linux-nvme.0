Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33432CD4F25
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iH9lD8cE/jOV6ljavGbtr97vVHN1UWoSkAOEmyBkm6o=; b=ctzViMAxf7N0A9XZtqY2AvTH7L
	Uy//gVXccsYaviacLaQW2NjaaYsG4gMJiRrSxYAFEEVt5zbqzknXfTo+MyZ4LB1gvFN5O8YH0nT/0
	b2SDp+8XncnPEeXwYTNfR58J24BcBf3B8bmBhbgtnCrZBMvD4QIvdaFwiItpkaWvLn+x/F/lQeGt6
	PapF6r9OPbR4fmZIwIjmEvH1q/dGxbp1w9cS+9EwbzUdm1AkQvPNQw6JPnILDWsUUjUtfZswKI5gG
	0H6BbPyK2B8gICJ7f25s/qYroESp2GEX5n7apvpxi1Jm2pOe9kQkTL6c3xcikWEfTzQePk1rB/XaC
	Hykac0aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNWxY-00000005hbF-2lNj;
	Thu, 14 May 2026 14:22:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNWxW-00000005haR-3I12
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 14:22:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AC22340A0D;
	Thu, 14 May 2026 14:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2270BC2BCB3;
	Thu, 14 May 2026 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778768561;
	bh=f/UNxw30b2EGW9YHla+43oYlmJOOtuZJSU9HEYT2C1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2+A3n8dwaX97anNJARl4tn+pCcGn9p81ndwioLquy/Vrrv7DoQmm+6fztm4hbJYR
	 OjiF99+IgubeHvsoeLE7+xF24pA8hZK2bHngQZb9vbrTMjlNXDupJKuN39HqlYx891
	 TNr4j1N5BP4AotWiaOuedBmqskzV7hV3krebN3uqMJTyqqmEiLJNq67Lr1ZfmCBgnk
	 U5OtJivk03oUbSi8g6tJDvOGJ0YosCP+QSdxClmTpxFmplLPqIUiDob7aaGXfjG4iY
	 6f1apkIdXtURZrdSLCVLJ+WIr7KW2PxYZ4g5pP+Q3N0iYElKaIbZqrPZq6zugJWtHC
	 IHbFOqWCDF1IA==
Date: Thu, 14 May 2026 08:22:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sungwoo Kim <iam@sung-woo.kim>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix race bug in nvme_poll_irqdisable()
Message-ID: <agXar7qtrPkpKaK5@kbusch-mbp>
References: <20260307194636.2755443-2-iam@sung-woo.kim>
 <20260513182736.GA324918@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513182736.GA324918@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_072242_864627_56D17BA3 
X-CRM114-Status: GOOD (  27.18  )
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

On Wed, May 13, 2026 at 01:27:36PM -0500, Bjorn Helgaas wrote:
> On Sat, Mar 07, 2026 at 02:46:36PM -0500, Sungwoo Kim wrote:
> > In the following scenario, pdev can be disabled between (1) and (3) by
> > (2). This sets pdev->msix_enabled = 0. Then, pci_irq_vector() will
> > return MSI-X IRQ(>15) for (1) whereas return INTx IRQ(<=15) for (2).
> > This causes IRQ warning because it tries to enable INTx IRQ that has
> > never been disabled before.
> > 
> > To fix this, save IRQ number into a local variable and ensure
> > disable_irq() and enable_irq() operate on the same IRQ number.
> > Even if pci_free_irq_vectors() frees the IRQ concurrently, disable_irq()
> > and enable_irq() on a stale IRQ number is still valid and safe, and the
> > depth accounting reamins balanced.
> > 
> > task 1:
> > nvme_poll_irqdisable()
> >   disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector)) ...(1)
> >   enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector))  ...(3)
> > 
> > task 2:
> > nvme_reset_work()
> >   nvme_dev_disable()
> >     pdev->msix_enable = 0;  ...(2)
> > ...
> 
> >  static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
> > +	int irq;
> >  
> >  	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
> >  
> > -	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> > +	irq = pci_irq_vector(pdev, nvmeq->cq_vector);
> > +	disable_irq(irq);
> >  	spin_lock(&nvmeq->cq_poll_lock);
> >  	nvme_poll_cq(nvmeq, NULL);
> >  	spin_unlock(&nvmeq->cq_poll_lock);
> > -	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> > +	enable_irq(irq);
> 
> An internal run of sashiko complained about this, and I think it's
> right.  As the commit log mentions, the cached IRQ number is stale if
> nvme_reset_work() frees all the vectors between (1) and (3).  It's
> likely the pci_alloc_irq_vectors() in nvme_pci_enable() will get the
> same IRQ number, but it would be a coincidence, and it doesn't feel
> like a good idea to rely on it.
> 
> First sashiko review:
> 
>   This commit caches the IRQ number in nvme_poll_irqdisable() to
>   ensure disable_irq() and enable_irq() operate on the same IRQ
>   number, preventing an unbalanced enable warning if the device is
>   concurrently disabled.
> 
>   If pci_free_irq_vectors() frees the IRQ concurrently, is it possible
>   for the IRQ number to be reallocated to a completely different
>   device before enable_irq() is called? Could this cause an unbalanced
>   enable or incorrectly unmask the interrupt for the new device?

Yeah, that looks legit. This should fix it:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 139a10cd687f9..34845d73cb3ab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1885,8 +1885,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 */
 	if (test_bit(NVMEQ_POLLED, &nvmeq->flags))
 		nvme_poll(req->mq_hctx, NULL);
-	else
-		nvme_poll_irqdisable(nvmeq);
+	else {
+		mutex_lock(&dev->shutdown_lock);
+		if (test_bit(NVMEQ_ENABLED, &nvmeq->flags))
+			nvme_poll_irqdisable(nvmeq);
+		mutex_unlock(&dev->shutdown_lock);
+	}
 
 	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT) {
 		dev_warn(dev->ctrl.device,
--

