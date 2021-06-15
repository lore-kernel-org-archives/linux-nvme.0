Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F88C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 22:24:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF28361105
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 22:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF28361105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Yq5QrtmpPH+Lb+zpkfROtg/S9S8GRzljqBNEaxvNCQI=; b=bzoTc1sD1H/j0V
	Nc+80NBjWvf/YLiu0BWFwCHQBGGAM1gOxilpGWWR5SqfU8mxskTScvwcFnl92hX1h0puHo92/MqU9
	zR4ST9YEDtUe6oEfllwbOuM1v9c7CrCrO5fzS/LIhHr74akfBEtFPoTNkr0HsjSFwfxzA7msFods9
	LW+HbYoWNTM7w20aW0k0kWOLxb6K0c4u8oMzqL4ioaRwXowVyJMSYlV5NmJ+mIJUGc0Jo6VyEHEXq
	F90Ogs1UBJlk40dpi1RVPq7koOwYdrjINE0YhF5e0wQJYTAb7xHYpQa8M8add/tzP7kCJ1RZrER99
	Sq9aHgzYVYY/7OCtz7Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltHTq-003XI5-1F; Tue, 15 Jun 2021 22:24:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltFBP-002cX5-AM
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 19:57:13 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C6C560FDA;
 Tue, 15 Jun 2021 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623787029;
 bh=aJxtpuB+Py++h4934oM5+CzxS279TVqfyJ2h9dcQ0dI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=hiMfcvcUJ3QIZwYyijPG2VL8mot+7p4olcEoiPrTvFyGV2MBnO86POR1NRX9CJQiH
 QIEkMsgPKjKGe8gmKDZjkIiVOobQSBENz8k4XQmQ5rOOFjRfdoLBoh1PuX/mMCnpNt
 Z536NZdLskHd5vm/2QvYxGdtIe/OEFpBgOqBJcYri9v728nSZELDoxfTs6vI9UJ1es
 YeOfy7x8QtcYLHNCi5Rba3emCVnNTUZti1Q8eGuajI07bwGnf6RRsm8iW9qNrUWzpp
 YYEzSJIw4exDnTPa5xWt34fGgbXmUG4iSLx2rnbcBi463kE0zA4mCNVsRXrkk2y4eX
 VDscxs5VtHNeQ==
Date: Tue, 15 Jun 2021 14:57:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 3/7] genirq/affinity: Add new callback for
 (re)calculating interrupt sets
Message-ID: <20210615195707.GA2909907@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190216172228.512444498@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_125711_500852_1E0882FD 
X-CRM114-Status: GOOD (  38.89  )
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

On Sat, Feb 16, 2019 at 06:13:09PM +0100, Thomas Gleixner wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> The interrupt affinity spreading mechanism supports to spread out
> affinities for one or more interrupt sets. A interrupt set contains one or
> more interrupts. Each set is mapped to a specific functionality of a
> device, e.g. general I/O queues and read I/O queus of multiqueue block
> devices.
> 
> The number of interrupts per set is defined by the driver. It depends on
> the total number of available interrupts for the device, which is
> determined by the PCI capabilites and the availability of underlying CPU
> resources, and the number of queues which the device provides and the
> driver wants to instantiate.
> 
> The driver passes initial configuration for the interrupt allocation via a
> pointer to struct irq_affinity.
> 
> Right now the allocation mechanism is complex as it requires to have a loop
> in the driver to determine the maximum number of interrupts which are
> provided by the PCI capabilities and the underlying CPU resources.  This
> loop would have to be replicated in every driver which wants to utilize
> this mechanism. That's unwanted code duplication and error prone.
> 
> In order to move this into generic facilities it is required to have a
> mechanism, which allows the recalculation of the interrupt sets and their
> size, in the core code. As the core code does not have any knowledge about the
> underlying device, a driver specific callback is required in struct
> irq_affinity, which can be invoked by the core code. The callback gets the
> number of available interupts as an argument, so the driver can calculate the
> corresponding number and size of interrupt sets.
> 
> At the moment the struct irq_affinity pointer which is handed in from the
> driver and passed through to several core functions is marked 'const', but for
> the callback to be able to modify the data in the struct it's required to
> remove the 'const' qualifier.
> 
> Add the optional callback to struct irq_affinity, which allows drivers to
> recalculate the number and size of interrupt sets and remove the 'const'
> qualifier.
> 
> For simple invocations, which do not supply a callback, a default callback
> is installed, which just sets nr_sets to 1 and transfers the number of
> spreadable vectors to the set_size array at index 0.
> 
> This is for now guarded by a check for nr_sets != 0 to keep the NVME driver
> working until it is converted to the callback mechanism.
> 
> To make sure that the driver configuration is correct under all circumstances
> the callback is invoked even when there are no interrupts for queues left,
> i.e. the pre/post requirements already exhaust the numner of available
> interrupts.
> 
> At the PCI layer irq_create_affinity_masks() has to be invoked even for the
> case where the legacy interrupt is used. That ensures that the callback is
> invoked and the device driver can adjust to that situation.
> 
> [ tglx: Fixed the simple case (no sets required). Moved the sanity check
>   	for nr_sets after the invocation of the callback so it catches
>   	broken drivers. Fixed the kernel doc comments for struct
>   	irq_affinity and de-'This patch'-ed the changelog ]
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

> @@ -1196,6 +1196,13 @@ int pci_alloc_irq_vectors_affinity(struc
>  	/* use legacy irq if allowed */
>  	if (flags & PCI_IRQ_LEGACY) {
>  		if (min_vecs == 1 && dev->irq) {
> +			/*
> +			 * Invoke the affinity spreading logic to ensure that
> +			 * the device driver can adjust queue configuration
> +			 * for the single interrupt case.
> +			 */
> +			if (affd)
> +				irq_create_affinity_masks(1, affd);

This looks like a leak because irq_create_affinity_masks() returns a
pointer to kcalloc()ed space, but we throw away the pointer.

Or is there something very subtle going on here, like this special
case doesn't allocate anything?  I do see the "Nothing to assign?"
case that returns NULL with no alloc, but it's not completely trivial
to verify that we take that case here.

>  			pci_intx(dev, 1);
>  			return 1;
>  		}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
