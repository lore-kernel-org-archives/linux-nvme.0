Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095A5E77180
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ViaHOxeQ1tTAgcIROioeoxaMv15MrhNe+MpLa/2actw=; b=shmfyaeFP0ySCzcU3lwQiQ8Er6
	6meehIuCApmItf+aROU5h7M5iN4N0lorrToGrDqgbvS4z6LXNg9J8Y6Llz0Vo/AQ0DpgeMouOYnzk
	c80bpfOTaRTLqxRGRrIxD6c65WkB2T0fWOrt5t3CAU7CAdggz8SaYI3FPDSgjWDRemkAkBjDVwX5k
	JwWRXA4Kzf9zVcrLRgc8Dnn3V/Rakgq7X56m4DpQdBfEgEKOmjcWl0xws5FpdZv1772N7G7NDJYLI
	U0EDOIPhR1WA0hjKjRGnzf/I5F3wEBXu1Jw4W0nMOyTaE9As+GUTKV0zZsIOuPswnMqhZ8LEjVblH
	ORNTEGYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDiR-0000000AWxu-0iiV;
	Mon, 16 Dec 2024 16:13:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDiO-0000000AWwK-1mDr
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 16:13:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C523968C4E; Mon, 16 Dec 2024 17:12:55 +0100 (CET)
Date: Mon, 16 Dec 2024 17:12:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv14 10/11] nvme: register fdp parameters with the block
 layer
Message-ID: <20241216161255.GC24735@lst.de>
References: <20241211183514.64070-1-kbusch@meta.com> <20241211183514.64070-11-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211183514.64070-11-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_081300_602212_D02C19DE 
X-CRM114-Status: GOOD (  12.97  )
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

On Wed, Dec 11, 2024 at 10:35:13AM -0800, Keith Busch wrote:
> +	size = le32_to_cpu(hdr.sze);
> +	if (size > PAGE_SIZE * MAX_ORDER_NR_PAGES) {
> +		dev_warn(ctrl->device, "FDP config size too large:%zu\n",
> +			 size);
> +		return 0;
> +	h = vmalloc(size);
> +	if (!h)
> +		return -ENOMEM;

Isn't an unconditional vmalloc here for something that usually should
have less than a handful of descriptors a little aggressive?  I'd use
kvmalloc here to get the best of both worlds, and the free path seems
to already use kvfree anyway.

Otherwise the incremental changes vs the previous version for the entire
series look good to me.

