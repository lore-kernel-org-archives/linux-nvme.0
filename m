Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03864606A325
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GWoGWUrU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fj5lo260dYvQAeAPMJArWPIv25ADO1FHWkm4Gpv3BMo=; b=GWoGWUrUtqVl/L0tjiCstHUkP4
	WDGZMqwt01abzCSSYdW5yd7x8zaTr5kPK9puNbXxKLvMycGoVrU+RX1e47AHeynR84Ogv79CXaGlX
	vPyIaRG70+6QueLCDIxwM6iDWANhOP6mNyeIVATR8Sh9rzDL9ocWLki0Zw5b0j31J8yuVVTx9Q2KX
	V2AwGQDJKJhnq9Z94krAjr8GTS8O7CcmmrUDpwscSuVA+klKHNv07b5ezNKrI8/8pCYP3ydPWSjMB
	7286WzeYVft+w/kiwpZFT4NFnfNt+ZFWbbnSztVF3R/8atVsqNK/FehHElvoL4JlVlU3mXw+hmYpe
	i0gKQgLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSNT-0000000Fgii-2SUK;
	Fri, 20 Nov 2026 17:26:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSNN-0000000Fghe-2fDC
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:26:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5595F6732A; Fri, 20 Nov 2026 18:26:14 +0100 (CET)
Date: Fri, 20 Nov 2026 18:26:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v5 2/2] nvme-multipath: don't wait for a grace period
 in nvme_mpath_set_live()
Message-ID: <20261120172614.GD941@lst.de>
References: <20261119-bug-nvme-mpath-set-live-srcu-v5-0-e1483e2e447f@linux.dev> <20261119-bug-nvme-mpath-set-live-srcu-v5-2-e1483e2e447f@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-bug-nvme-mpath-set-live-srcu-v5-2-e1483e2e447f@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_092620_218386_1F921823 
X-CRM114-Status: GOOD (  13.80  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -712,6 +712,11 @@ static void nvme_requeue_work(struct work_struct *work)
>  		container_of(work, struct nvme_ns_head, requeue_work);
>  	struct bio *bio, *next;
>  
> +	/* Let bios that found no usable path reach the requeue list first. */
> +	if (!poll_state_synchronize_srcu(&head->srcu,
> +					 READ_ONCE(head->requeue_srcu_cookie)))

Let's use a two-tab indent here to make this a bit more readable..

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

