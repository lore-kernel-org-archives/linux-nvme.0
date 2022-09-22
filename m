Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1378C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XkufidiM4E8AW79WmG+yUVbbnK8Hjd8wG2FuMFk9k9Y=; b=KF7nV19AUhKY3upQD54KOnCPNV
	lY0eGA/4D9q47XM0f0xtUOpCTv24V7qM4PK4M0n71cnC3WhxmMDWt5Zb5QbYQWG/fTTYF8MjWxXrT
	vZniE5vg1aZbiwI4DtyO67Gwzh2OSg2eEi0VrJX4Wr/gpb8r2ZYl4t0PZrgc/kGJGnOw8EA1B4rza
	al3eLOgrVwpZTGOgI1rsCup383yV3x87LrDBUZrlMP8CdRR94R31J/qepeBmvjxWoPDaQZ9LrSK65
	y39mo08N2LjfENQTeMFVFzUVuHUCrF53f+8F0rmo16Jo5IBjeLLKQC6XW1hVQCkCmLYhyCuBz1O3Z
	fDFq5WGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obFZI-00DX7T-UQ; Thu, 22 Sep 2022 06:20:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obFZG-00DX6b-F5
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 06:20:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6262168BEB; Thu, 22 Sep 2022 08:20:10 +0200 (CEST)
Date: Thu, 22 Sep 2022 08:20:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Liu Song <liusong@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [RFC PATCH] blk-mq: hctx has only one ctx mapping is no need
 to redirect the completion
Message-ID: <20220922062010.GA27946@lst.de>
References: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk> <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_232014_670140_4FD31E4B 
X-CRM114-Status: GOOD (  13.91  )
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

On Wed, Sep 21, 2022 at 11:32:03AM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> High-performance NVMe devices usually support a large hw queue, which

a larger number of?

>  	/*
> -	 * For a polled request, always complete locally, it's pointless
> -	 * to redirect the completion.
> +	 * For request which hctx has only one ctx mapping,
> +	 * or a polled request, always complete locally,
> +	 * it's pointless to redirect the completion.
>  	 */
> -	if (rq->cmd_flags & REQ_POLLED)
> +	if (rq->mq_hctx->nr_ctx == 1 ||
> +		rq->cmd_flags & REQ_POLLED)

Some very odd comment formatting and and indentation here.

