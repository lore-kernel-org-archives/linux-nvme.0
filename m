Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C77C87FCA
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ChiF7sG+6G6+tl7yi6O9Fgrx4PAeuoTHWXIZ8EQYKjc=; b=gSzRY0uF97Sy7uUcO+AR6Nky01
	0FrgwAW9qT3oFKyb1vepwdKVupLFMQcErQmKg2GROumdSpjabQ+7SK0DsfWr610L5iTFxV5hjvlM4
	UAW9MdIDX3IIOL0mAOkW+SQh+Oa+AsqtaBTHLtMcQCux68HMCLfRQQ5oOi3mjtqjDStrMpX4HucfR
	B/n74ttzKPTwG8cPnGS2OEAT7RWMO8Kct69GkDviJWoXL1uArOZI/cB8YwLGp8JUKpDRNpFO9WWJb
	n4HoON+yIbLXWR3E85LhvKTEYOLsyndVXz+Mhf5UZeG4+hQHTdvt6FDhs8SGCmfr41pJfBCMOXLhC
	AcJ4Zbbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6it-00000005fke-2OAJ;
	Sun, 10 Aug 2025 14:08:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6ir-00000005fk3-3SQr
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:08:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 778A2227A88; Sun, 10 Aug 2025 16:08:26 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:08:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 4/8] blk-mq: remove REQ_P2PDMA flag
Message-ID: <20250810140826.GD4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_070830_004510_31312B36 
X-CRM114-Status: UNSURE (   9.98  )
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

On Fri, Aug 08, 2025 at 08:58:22AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> It's not serving any particular purpose. pci_p2pdma_state() already has
> all the appropriate checks, so the config and flag checks are not
> guarding anything.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


