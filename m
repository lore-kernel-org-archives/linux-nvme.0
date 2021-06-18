Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD5C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 19:33:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826B961261
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 19:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826B961261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QMAQMz2nCWvNd80NpOuqO6E+TX4h6PepLUKDStP/XbQ=; b=BjHVrUgwrZyPtO
	jfv4ncUaH3UO8obTH0sstqZu3lB07N/AMo42sTNEmha6aEWcuqlNXz8IWWc7Yva1v15igTjhEQb/F
	9YzoNAJGXdisFiWg0FJ/4NlDGCVPYKJPlN2qzCRaipKsifbUkkmWOe5r8vxhy12tCCCVQFSKNj4Nw
	JJxi4HtJOpmBOWYPRSwRfbuLzV+YMc+zSPii+0eCO0hThg4Npb/GFQRoKDGq5YBNkNNCoNf34avIJ
	rABZQtI6KuRJkPqCQU+B412y4Sh3nBG9xT15M3nkmSV9fTcWQnmgG+CpPvPV0WlJTiR88sgNqfa80
	wkdmgdpYuWcwROBKvuXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luKEC-00FJ7b-Oc; Fri, 18 Jun 2021 19:32:32 +0000
Received: from galois.linutronix.de ([193.142.43.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luKEA-00FJ77-IW
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 19:32:31 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1624044748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGYDUibjRJnL82nD8o3BWNGmm7rRgf7fDGXt/JOep+Y=;
 b=sUzKg4BepwE7mv3qWCix1guOBHZSMT8DXBkwFLMTULjbfeKMG/v0Be1pssBXpuJ7qBTefD
 EAZZcGJtwmWTWqNQOzwsdfNv+JGakxIdAvjKTy5DhKOEa2tb9jZpjFwLshZ5nXdaR/vWFB
 +f82bgqbIbec0ACPaDMfh0QHpV8mQBNW/Ngi6TnKCRMlJlivQvuWcSJC8OaGKXFAa6/C4e
 1igh80HtnFSygR8IyCIwjJbh5jNhn/ZA4LT2UB1cEZSuWMW7SN9uyidMjirfiMM5/9FUzL
 bTk2LH8lobMsGTlcV6Om83acKgM4PUNr2UFCR+yBKRgUyS12TvSAVrFOOEnffA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1624044748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGYDUibjRJnL82nD8o3BWNGmm7rRgf7fDGXt/JOep+Y=;
 b=O4Tyuu3AGxQcKB3jYIokFBqi7TQbdNSdn3r02m2Tb81waKj+8YkqzliySHPtD3MwGFeKI3
 49tR6qJY2A6WWYDQ==
To: Ming Lei <ming.lei@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Sumit Saxena <sumit.saxena@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 3/7] genirq/affinity: Add new callback for
 (re)calculating interrupt sets
In-Reply-To: <YMlIbt3EPyRJHNWf@T590>
References: <20190216172228.512444498@linutronix.de>
 <20210615195707.GA2909907@bjorn-Precision-5520> <YMlIbt3EPyRJHNWf@T590>
Date: Fri, 18 Jun 2021 21:32:28 +0200
Message-ID: <875yybezoz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_123230_800429_383B7765 
X-CRM114-Status: GOOD (  17.03  )
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

On Wed, Jun 16 2021 at 08:40, Ming Lei wrote:
> On Tue, Jun 15, 2021 at 02:57:07PM -0500, Bjorn Helgaas wrote:

> +static inline void irq_affinity_calc_sets_legacy(struct irq_affinity *affd)

This function name sucks because the function is really a wrapper around
irq_affinity_calc_sets(). What's so legacy about this? The fact that
it's called from the legacy PCI single interrupt code path?

> @@ -405,6 +405,30 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
>  	affd->set_size[0] = affvecs;
>  }
>  
> +static void irq_affinity_calc_sets(unsigned int affvecs,
> +		struct irq_affinity *affd)

Please align the arguments when you need a line break.

> +{
> +	/*
> +	 * Simple invocations do not provide a calc_sets() callback. Install
> +	 * the generic one.
> +	 */
> +	if (!affd->calc_sets)
> +		affd->calc_sets = default_calc_sets;
> +
> +	/* Recalculate the sets */
> +	affd->calc_sets(affd, affvecs);
> +
> +	WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS);

Hrm. That function really should return an error code to tell the caller
that something went wrong.

> +}
> +
> +/* Provide a chance to call ->calc_sets for legacy */

What does this comment tell? Close to zero. 

> +void irq_affinity_calc_sets_legacy(struct irq_affinity *affd)
> +{
> +	if (!affd)
> +		return;
> +	irq_affinity_calc_sets(0, affd);
> +}

What's wrong with just exposing irq_affinity_calc_sets() have that
NULL pointer check in the function and add proper function documentation
which explains what this is about?

Thanks,

        tglx

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
