Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FBFE7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ZIij15fhAoaNTgMNA/agucb6f104S7AbJKKr5LRKwo=; b=LTuLrHSvIkRlGHUKWFBhrIgemY
	ZDpnp68MFkcRgNa4sxJudKdtg0a0oelBDAH08m0DW+ti4RW3Jg5p0ZU8QPEFWuwPvGWPfjBuDDXHq
	p19Eb4R2MHgja5LUhOsbdYpbMiNqfNLaHIWiZgyD4cd/wB7HmCDIm9L/vovzrYnMf9n1rKP0SPrqO
	sZ9z7H/ZL4z42+WffBKo5cGo5XzXfCkkhuk8h4e3RTDEI/Y7dkd2SD/1zx2Nn/js/Y8ntjtgrJBMZ
	RKNAi8zkKnA2tYKD6SpPsLLb5QWfs2/WeQQp6eewLYB/7W8U5nnlFQ02UOfQolwzsu69mnY9EnzUo
	8KKYHGGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDLc-0000000ATM4-2a8x;
	Mon, 16 Dec 2024 15:49:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDLa-0000000ATKt-0pH3
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 15:49:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E96D68C4E; Mon, 16 Dec 2024 16:49:16 +0100 (CET)
Date: Mon, 16 Dec 2024 16:49:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Add error path for xa_store in
 nvme_init_effects
Message-ID: <20241216154916.GB23786@lst.de>
References: <20241216152719.17923-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216152719.17923-1-keisuke.nishimura@inria.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_074926_375001_EFBC72B1 
X-CRM114-Status: GOOD (  13.20  )
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

On Mon, Dec 16, 2024 at 04:27:20PM +0100, Keisuke Nishimura wrote:
> The xa_store() may fail due to memory allocation failure because there
> is no guarantee that the index NVME_CSI_NVM is already used. This fix
> introduces a new function to handle the error path.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


