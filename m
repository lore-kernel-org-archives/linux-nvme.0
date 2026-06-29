Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5414C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iAQwDUCvuRpnFpurzAXZ3Ii4On
	9w2tu3r8rSOvyfND2Cs11DFV/xuqUO4dEI5LVYnY4ytRKubpzBfWsi7brLbE+mKKhTffXFDgizzHB
	eJQTUQjLyfOR6c+BEdDdIu1sEpLkS/noOf1oRiPTtmhtOLDLuxk/LmC1yT81RjW1DUuhZIMYU+Fx/
	naXkCeXOp7XedwGJ7d8SzruQJ2kpWgfxlAvbEQCPA0rT09U3WfG99W3Lc4YBEZzgqDNduI+4wq0if
	9OOcpCkOCdJtNa5YrHvcnK+sGFXpiXJuwJ7XzHSpeo3oStmkAxZ6TTv9jDpQMS8gw4GHXfyn3lP4Y
	Gpf5ivkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBCD-0000000EZpe-3QKU;
	Mon, 29 Jun 2026 12:34:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBCB-0000000EZol-3n4k
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 12:34:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7EA7668C7B; Mon, 29 Jun 2026 14:34:35 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:34:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com, randyj@purestorage.com,
	adailey@purestorage.com
Subject: Re: [PATCH v4 2/2] nvme-rdma: parallelize I/O queue allocation and
 startup
Message-ID: <20260629123435.GA22441@lst.de>
References: <20260627041551.1981256-1-sgogte@purestorage.com> <20260627041551.1981256-3-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627041551.1981256-3-sgogte@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_053440_076403_FDF4DCFD 
X-CRM114-Status: GOOD (  10.47  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


