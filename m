Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDDBC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3++csgYYJKNmRcfV7AZ8C8zQ5YQv6RV08cipTgzHlaY=; b=glpcHDCeJ4mEhA1NOwGLXEYGKB
	qw7pEgLUlG7hfk1g234eAy3GaKn3PD/a+p4dhgeYckxRWmVXjWPFyWtIO63mr3pi3AafxpiAGqn7t
	mL92fWQQgSFFcuZydBkGUlJTUmETCKW01nwiKGXvzG9S/KuaXkDcW3rnCQbdgwLJO4sIOsN213ua5
	UWJ+EFTnN7tQydTDLDj33zZ0JNOH4T1l56IoN7furzGgDbM0Vfqdk5PtiSEwh5wEZeat1eM++E4xK
	3XkkKAD5Jtrs1USoI4AJz2v6wzoEncreqD245J9X6ZH8qKvSmPkZjwWybejKhddE7gfIU0JJ/DnC/
	anPYVEsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LS4-00HTXN-2t;
	Wed, 31 May 2023 13:01:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LS2-00HTWc-1l
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 13:01:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1FB968B05; Wed, 31 May 2023 15:01:14 +0200 (CEST)
Date: Wed, 31 May 2023 15:01:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] block: add request polling helper
Message-ID: <20230531130114.GC27468@lst.de>
References: <20230530172343.3250958-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530172343.3250958-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_060118_728136_D20EE865 
X-CRM114-Status: GOOD (  12.08  )
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

> +int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,

It would be nice to fix the overly long line while you're at it.

> +		unsigned int flags)
> +{
> +	return blk_hctx_poll(q, blk_qc_to_hctx(q, cookie), iob, flags);
> +}

But looking at the two callers of blk_mq_poll, shouldn't one use
rq->mq_hctx to get the hctx anyway instead of doing repeated
blk_qc_to_hctx in the polling loop?  We could then just open code
blk_qc_to_hctx in the remaining one.

The rest looks good to me.

