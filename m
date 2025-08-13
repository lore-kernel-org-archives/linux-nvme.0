Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84B9C87FCF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cx8X+AML38wKXicObrukfBOUN3c+V+llLj76A4M43u4=; b=RoN3eCPuA4UAuFI8ieERvH3/D7
	X1cNXOs0JNCjmWl7Mt3AGdktg8Fdd0Hh6TnzPoy/P4Bk3RyuVw6YvCKkzPiLlQpfojoqIdxS1umON
	K/j9FtzNcJrb2Kyp9KDtCt1xEtZBD8ha0JQ9/C9W4qTRrcF9owOyNhOClF4kqK4H1SmNLWhWcCswN
	lis1iQ+28FihhLakya5EF0W0pfRq1FoxOxvO0IzyQkp3jQdfYL6gM/Ph8zXKid9K/+gmlTTN1Xs+G
	cvD3hWJyvPltcdh0kbFOAxThLZ3H7iBJoMZ5k1g8NmdHb1PO56pslNTJHVZ9D3Dt6vfj4UlSebH7V
	Dq4h2+zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umETN-0000000EQjA-0rUX;
	Wed, 13 Aug 2025 16:37:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDnE-0000000EGJt-1agu
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:53:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 22FC8227AAC; Wed, 13 Aug 2025 17:53:31 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:53:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 4/9] blk-mq: remove REQ_P2PDMA flag
Message-ID: <20250813155331.GB14188@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_085336_565102_4AC2948F 
X-CRM114-Status: GOOD (  11.35  )
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

On Wed, Aug 13, 2025 at 08:31:48AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> It's not serving any particular purpose. pci_p2pdma_state() already has
> all the appropriate checks, so the config and flag checks are not
> guarding anything.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I think I've also reviewed this before, but:

Reviewed-by: Christoph Hellwig <hch@lst.de>


