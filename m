Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BACC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDzP+Gvd21EQF+auiWUM6KdxZ18F/5sPQ9Wt+bKbjpM=; b=hKQlaehTkE8jmiMiYFxZhKCB08
	J0XTSG2oZHUIkRFVK9fp9i/XIulV76tB0SA+rAj1WrGpz9nymq3oUbjAyu5XVGwpB28RJSbG3/32s
	75QgbBP+icr6X8GZAFOpHjBUVTx/rxdBXDLOVceeJ6oPe3oQl0hUTgx9pwrmkaeZ7iNe8yt5p2HI4
	9DXyfYh3RfCXHyRDQ11nGrHW9ZSTEt+BvLV5uSv1y1QK5CPI03qCKFn6UdPIviCR94+OLgTRc51W2
	/GmkW0j8V7F9oY6xsgPY5c/dDss40DVEZGPiHJ2YiimcqlEoaYMN4gDhc1xRpDqfIlugioOeHVATi
	49zR1HxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozw97-007R2W-D8; Tue, 29 Nov 2022 08:39:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozw90-007Qzz-MR
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 08:39:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5BB6268AFE; Tue, 29 Nov 2022 09:39:06 +0100 (CET)
Date: Tue, 29 Nov 2022 09:39:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] nvme: fix (S)RCU protection of nvme_ns_head list
 (alternate)
Message-ID: <20221129083905.GA25314@lst.de>
References: <20221118232756.1457075-1-csander@purestorage.com> <20221124002432.3715594-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124002432.3715594-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_003910_890975_4C225AFA 
X-CRM114-Status: GOOD (  13.37  )
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

On Wed, Nov 23, 2022 at 05:24:32PM -0700, Caleb Sander wrote:
> +++ b/drivers/nvme/host/multipath.c
> @@ -175,10 +175,12 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>  	sector_t capacity = get_capacity(head->disk);
>  	int node;
>  
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(ns, &head->list, siblings) {
>  		if (capacity != get_capacity(ns->disk))
>  			clear_bit(NVME_NS_READY, &ns->flags);
>  	}
> +	rcu_read_unlock();

I can't see how protection iteraction of the same list once with
SRCU and once with RCU can work in practice.

