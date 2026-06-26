Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B467CCD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=404XUIMW54gi+rKXIkSqgRslgjyr/DQ8KgSXyJOkNfg=; b=P1z5kzjHeSnLho+DKjnZ1tHvcX
	gaB/MbekLJVUM2ZKlUhxChPvNDnJANRz3NcKTNbsTMMByVGDhl2Uj6oPgGYUDzUYdF6IKz678Q54Z
	kCwqF/cbnkdy5IWIxubHWtS09quFUTsVKYG6UwQy2t1ghfMhw+JFZ3vQmLL1BnZTvzSjvpPPfWyYX
	Fnhi3x2M1QMhd0y9/Yg0xoo1chF32r49kMomgsNAbpLJPWcy/m/8GbzuJlZhtk3lCkPRf1Va/Zqz1
	kOJdUA2gZgEvZf5TaFKuA2sUM/Qa5Re9TFAAT6m2KruHHayfCnLV2T53OUQEqGqqGQu8BUSpttEvG
	4W+2TxBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Ht-0000000Ac9R-2qeY;
	Fri, 26 Jun 2026 06:43:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Hr-0000000Ac8r-2Ovl
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:43:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CB8468B05; Fri, 26 Jun 2026 08:43:35 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:43:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 07/17] nvme: add Clang context annotations for
 nvme_subsystem::lock
Message-ID: <20260626064335.GG10731@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-8-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-8-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_234339_764948_ED59F789 
X-CRM114-Status: GOOD (  15.57  )
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

> +	scoped_guard(mutex_init, &subsys->lock)
> +		INIT_LIST_HEAD(&subsys->nsheads);

Same init mess as a few patches earlier.

> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -719,7 +719,14 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	INIT_WORK(&head->requeue_work, nvme_requeue_work);
>  	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
>  	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
> -	head->delayed_removal_secs = 0;
> +	/*
> +	 * The namespace head is not yet visible to other threads, so
> +	 * initializing delayed_removal_secs does not require holding
> +	 * subsys->lock. So suppress Clang's context analyzer warning by
> +	 * annotating initialization of delayed_removal_secs using
> +	 * context_unsafe.
> +	 */
> +	context_unsafe(head->delayed_removal_secs = 0);

head is a zeroed allocation, and we call nvme_mpath_alloc_disk
exactly once on it.  So we can just remove the initialization
of delayed_removal_secs entirely here.

> +	struct list_head	nsheads __guarded_by(&lock);
>  	char			subnqn[NVMF_NQN_SIZE];
>  	char			serial[20];
>  	char			model[40];
> @@ -562,7 +562,7 @@ struct nvme_ns_head {
>  	struct mutex		lock;
>  	unsigned long		flags;
>  	struct delayed_work	remove_work;
> -	unsigned int		delayed_removal_secs;
> +	unsigned int		delayed_removal_secs __guarded_by(&subsys->lock);

Btw, I find throwing the __guarded_by at the end of the line really
hard to read, especially with all these long lines.

What about moving them to the next line with an extra tab indent
instead?


