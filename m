Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E36C3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 05:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAXbPhzEIya3CXnPo/EU1UCYVy5pG9DgIMi4YWQp1b0=; b=vFRCXTvGCNUpQ7NL/CUORCYuh2
	omXTEjd40WmE59g8WfxBtSeRI2DiA55PXzHIopCv0y3yLUL6NnongIvmri+KDwmrkhD+z9YhK6z3H
	cq/C2oHC1pczJK55oE3wnQKo1kUi0hcdKVcNG4MdlHLm8hwcTaNxn4FknnPcjgs6Z0XnB6UbQ4uRK
	/RyZrfN80t00EqOcGl1sOVVgA6trZWY/eeeoIXDBJqmZAlP8ywHyV8fQC2S7KDuxHXcUYC2NdHjiD
	8sG4yUI9TI2dWO+RNslH05jKF/kJlOwuhXDS8PxX12LPHWq8P2RMyTbBve+CPr23DoOtJAHbL3AW2
	pm3J+tWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFxc-00000002UBp-2OAv;
	Fri, 09 May 2025 05:07:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFoa-00000002Tax-0Yqw
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 04:58:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DD1A67373; Fri,  9 May 2025 06:58:21 +0200 (CEST)
Date: Fri, 9 May 2025 06:58:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: lock per namespace in nvme_poll_irqdisable
Message-ID: <20250509045821.GA29348@lst.de>
References: <20250508-nvme-pci-polling-v2-1-0c7e1edad476@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-nvme-pci-polling-v2-1-0c7e1edad476@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_215828_313292_7735F0D9 
X-CRM114-Status: GOOD (  12.95  )
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

On Thu, May 08, 2025 at 04:57:06PM +0200, Daniel Wagner wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We need to lock this queue for that condition because the timeout work
> executes per-namespace.

I've applied this to the nvme 6.15 branch, but I rewrote the commit
log as I can't find anything per-namespaces here, the CQ lock is
per-CQ.


