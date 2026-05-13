Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9247BCD4F21
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 18:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=MWh7wSPfCtSjVJnGdzbrdfVUasSLM70S65dzPy4NDBE=; b=bWBQ+Wc7AXUEQT
	E6cS7BualtZET+LZShDsssioEBM+xuLqaqeUMQj9puu/IxIiZA+75WEvxY1NCCejpW1ByV9AZae9S
	dpeThfGI+gMLiVqpkuCHJPYLeAuavycKzA1Qlk19I2FISMsnf/6Up5m7QUUod/L58bVPPwJOKOF5v
	vnPWigGGF0TeIZEiF7Zv3S29l8dY188e+xAW5gqR6gbLpK6lhY6kwbxd1SHdJkpES2YvvcrC2VvLj
	tmcM2rDVIvGlSkG2IVavURXRhGfJIgWn4u8oyIfmdS8tH25B9d+U4lZDTuRFUTq9RgUjmf+2NpqOX
	NMBZmFWfcG3TLwq/QxYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNEJ4-00000003TX5-3Yr8;
	Wed, 13 May 2026 18:27:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNEJ1-00000003TWB-0DU1
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 18:27:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DDB56012B;
	Wed, 13 May 2026 18:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E830BC2BCC6;
	Wed, 13 May 2026 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696858;
	bh=m7UgsZu2WOoo5TwerUJvbQ/ULWpIWi71T7A+TM8mRyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FqcpsPaRd1tHhNkmoyTMsICifFPh9fAgyiE6INnbyWIQVVQLlxOHmmlvtr1gAGmnq
	 pqhXP4tkA069+CW0mSLxCTYUNzGEUpf0OxD9MGzbaecyM2LP7VtesMjcFfwTFZf2bY
	 9iYDv8h5Vq3+1GCD0GmF/meeIgVO5YaICYZGDMV1L8tJCLmlHwoLXf76Bcp06qliXh
	 XgKN+rRn7bMwJPO3+RKz9b3I+HNeWtoch6krJgEnDoMayIrBn7wqXFG7K4nHsHnkJN
	 xSEiSRotUNBTIw4PHxT/8v3MNGJKkRN0Hi0jsq1C674oHDHMeBTa1ml3Rn+YSOVT2l
	 Xv8bXr+FAkCvQ==
Date: Wed, 13 May 2026 13:27:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix race bug in nvme_poll_irqdisable()
Message-ID: <20260513182736.GA324918@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307194636.2755443-2-iam@sung-woo.kim>
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

On Sat, Mar 07, 2026 at 02:46:36PM -0500, Sungwoo Kim wrote:
> In the following scenario, pdev can be disabled between (1) and (3) by
> (2). This sets pdev->msix_enabled = 0. Then, pci_irq_vector() will
> return MSI-X IRQ(>15) for (1) whereas return INTx IRQ(<=15) for (2).
> This causes IRQ warning because it tries to enable INTx IRQ that has
> never been disabled before.
> 
> To fix this, save IRQ number into a local variable and ensure
> disable_irq() and enable_irq() operate on the same IRQ number.
> Even if pci_free_irq_vectors() frees the IRQ concurrently, disable_irq()
> and enable_irq() on a stale IRQ number is still valid and safe, and the
> depth accounting reamins balanced.
> 
> task 1:
> nvme_poll_irqdisable()
>   disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector)) ...(1)
>   enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector))  ...(3)
> 
> task 2:
> nvme_reset_work()
>   nvme_dev_disable()
>     pdev->msix_enable = 0;  ...(2)
> ...

>  static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
>  {
>  	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
> +	int irq;
>  
>  	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
>  
> -	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> +	irq = pci_irq_vector(pdev, nvmeq->cq_vector);
> +	disable_irq(irq);
>  	spin_lock(&nvmeq->cq_poll_lock);
>  	nvme_poll_cq(nvmeq, NULL);
>  	spin_unlock(&nvmeq->cq_poll_lock);
> -	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> +	enable_irq(irq);

An internal run of sashiko complained about this, and I think it's
right.  As the commit log mentions, the cached IRQ number is stale if
nvme_reset_work() frees all the vectors between (1) and (3).  It's
likely the pci_alloc_irq_vectors() in nvme_pci_enable() will get the
same IRQ number, but it would be a coincidence, and it doesn't feel
like a good idea to rely on it.

First sashiko review:

  This commit caches the IRQ number in nvme_poll_irqdisable() to
  ensure disable_irq() and enable_irq() operate on the same IRQ
  number, preventing an unbalanced enable warning if the device is
  concurrently disabled.

  If pci_free_irq_vectors() frees the IRQ concurrently, is it possible
  for the IRQ number to be reallocated to a completely different
  device before enable_irq() is called? Could this cause an unbalanced
  enable or incorrectly unmask the interrupt for the new device?

Second sashiko review:

  The commit caches the return value of pci_irq_vector() into a local
  variable to ensure disable_irq() and enable_irq() operate on the
  same IRQ number, preventing an unbalanced enable warning when
  pdev->msix_enabled is cleared concurrently.

  If pdev->msix_enabled is cleared concurrently and nvmeq->cq_vector >
  0, pci_irq_vector() will return -EINVAL. Since disable_irq() takes
  an unsigned int, does this result in passing a very large unsigned
  number (like 0xffffffea) to the IRQ subsystem?

  The commit message notes that operating on a stale IRQ number is
  valid and safe. However, if pci_free_irq_vectors() frees the MSI-X
  vector concurrently, couldn't this cached irq number be recycled and
  reallocated to a completely different device before enable_irq(irq)
  executes? If the new device had explicitly disabled its IRQ, does
  this code inadvertently enable it, breaking the other device's
  synchronization?

