Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC944CD5BBF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 07:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iHpw4K9Dc7dx9qHJdM6RLi9Nm+UVXuwSZQ6mKhEZdmo=; b=mPQDBRAyUvQhi82gOsQO2VL2g6
	qa8BFXyERSSMDmdONFVCnMVaQJKCaKdBzhBpzRzyxb5p/7DNncnlS+3WNWwz0tnxhXZmyvxPjuQV3
	HbsIwIAbG5IQ0scYIZYXVrMFFqgxz5FYTayZOZKRui/ZvPeYSOOSX3LhHH6dlPOL0/u2V/lpZF3hA
	O2aWbmPrl3PWE+/LHboE/3jtNcW2JU0LYl021feYwftxZkXChic63Ps55VnPUf27jBrsCvP8DEOqS
	53zuyGINyRlPt3LAUfk5wEIFkukyrl1kTeGh1aO4dPnW5yGP/en5yMWoNVvf7Z2o+QRtNWup//YFr
	XqIwBW7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPnX-0000000GXFE-0ws4;
	Mon, 25 May 2026 07:32:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPnU-0000000GXEW-0JEM
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 07:32:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CAE8768B05; Mon, 25 May 2026 09:32:19 +0200 (CEST)
Date: Mon, 25 May 2026 09:32:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block, nvme: export and use passthrough stats
Message-ID: <20260525073219.GA5305@lst.de>
References: <20260522151537.1509784-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522151537.1509784-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_003224_251635_06642F4B 
X-CRM114-Status: GOOD (  11.95  )
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

On Fri, May 22, 2026 at 08:15:37AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> So stacking drivers can also report passthrough workloads through
> iostat.

Except that this patch also wires it up in nvme.  So please split
it and write proper commit messages for both parts.

> +static inline bool blk_rq_passthrough_stats(struct request *req)
> +{

And maybe add a kerneldoc comment now that this is public.


