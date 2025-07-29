Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CA1C87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+/fXdbSLVfmLarxKWhTMbsb4LtNDZkfKeZpZrSWbJJ8=; b=Lg+SeJCeC4HlfWSoeixym1kOeo
	VMRTweVWM1kHNwzvG6p+wALnuv5XdfWCRAOx2Y0jyejkDbZn4Qt1+QNsdDLkyRd+E0owI9TXegy+1
	SomXdrIvZsyNkSJXPaq7MAgwepImFjtn/2etURuHsVg8GONoHbZqxVRVkwX5Ejo96Yu4dtfdj8Fjb
	Cmt5Trbe1QDJJC+SPuvhg5LaNvX6JHdsf92Z1MMxXveBwObwPKHO94Z8omEk/mZpXhoeM6HAkGPrV
	Hq7IEXTYgV8lV1w1PLggz/Avb6ovWoJW7SmVUkXm7uzmWY72lFnnPJZjx8HXl3qjphaBftOcz70uB
	70wrTKtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugrQh-000000005cP-19JP;
	Tue, 29 Jul 2025 21:00:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugrLv-0000000053v-0BGH
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 20:55:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 75BFF41A77;
	Tue, 29 Jul 2025 20:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0862C4CEEF;
	Tue, 29 Jul 2025 20:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753822514;
	bh=ZzYN96Moe8AtxV3K1biVgKSey9DTJG3tHDYusHZa7ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=robIGI1TLqiOPkAznr10kff37xRqHA52O4BOzbC6VYFTpLoIKUcZ5iEd0T7dGcMgb
	 CsXwIEyPU3c/QSfMiSEIouaBywg8sJfdYK8XkdTTqHpyH0b8zfIb6HzfUF3C1/sAlp
	 k/U1A77RCwjr28QQauKsZi8rwcp5hTcpYt5MvbqIAT0BvsXp9Pgh0pdQhX8AbPWa8Z
	 NHElScaTAGfTcHxb6St/LqiO6o+pxTAo0kM+/MatgIlQ8JgfbgO7qwj+W12jnQf88m
	 z+BwIDZ3AX68giQMRwC0seehrYmNnd+HLkWSLab/wpZMdjUi0pXTAVkma6nTwbDvFP
	 W/G5AgJLB85Fg==
Date: Tue, 29 Jul 2025 14:55:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv3 2/7] blk-mq-dma: provide the bio_vec list being iterated
Message-ID: <aIk1L5DpRpn_O_mS@kbusch-mbp>
References: <20250729143442.2586575-1-kbusch@meta.com>
 <20250729143442.2586575-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729143442.2586575-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_135515_117003_4DA5BFB5 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jul 29, 2025 at 07:34:37AM -0700, Keith Busch wrote:
> @@ -244,8 +244,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
>  	int nsegs = 0;
>  
>  	/* the internal flush request may not have bio attached */
> -	if (bio)
> +	if (bio) {
>  		iter.iter = bio->bi_iter;
> +		iter.bvec = bio->bi_io_vec;

Oops, this should have been:

		if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
			iter.bvec = &rq->special_vec;
		else
			iter.bvec = bio->bi_io_vec;

Hopefully over time everything coverts to the dma iterator and this
legacy sg mapping can fade away.

> +	}

