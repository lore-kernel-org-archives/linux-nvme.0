Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72DDC87FC5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oOWNKXD3yAlXJ7rsG4SQ1n/pxVPwdGNEvI28YYleje8=; b=mx0pmI+2fYIXOVxUgu4ZnXbMCo
	9wA6BbBVwWaD6QdIKWdrt/dYnJNchbd5Zn3KU0fKCU+umEzyz4Vqehsa8RTPnXIeStux1rJoyu+gb
	8ssmUKkbFcCdoIsDJRGhEDuNyzKLXCpWnlPehTGbUCoYtiKZProl8dGJA2TPsdSXSgCtovKpsOErn
	v4KITS3bc9KfP2ywT7Z5a5+XQuARfT/FKPW5bj+oKY5lDwNYwYvnLJrwPkhBBhNB6zp4tFv8+Qr9s
	vGggOdGImjjG0TgwFmkTV7J1ATI8uHBuRzwW5VvHyxrCS32Mo+NSgYVHhR9VaIB906afzjPGwdEMy
	YNKIFW9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udl9U-0000000GWG1-26xl;
	Mon, 21 Jul 2025 07:41:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udl6e-0000000GVnC-1hgX
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 07:38:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BEAC68B05; Mon, 21 Jul 2025 09:38:37 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:38:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/7] blk-mq-dma: set the bvec being iterated
Message-ID: <20250721073836.GB32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_003840_585670_87D89ABD 
X-CRM114-Status: GOOD (  12.26  )
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

On Sun, Jul 20, 2025 at 11:40:35AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This will make it easier to add different bvec sources, like for
> upcoming integrity support. It also makes iterating "special" payloads
> more common with iterating normal data bi_io_vecs.

You're not really setting the bvec, but the bvec table, i.e. the start
of the contiguous chunk of bvecs for the bio / bip.  Can you make this
a bit more clear both in the commit message and the structure member
naming?  This really confused me and took a bit of careful reading
to understand.

Otherwise this looks fine.

