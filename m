Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8909AD1AD45
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=npTh0hJ9OReB2/XVPh3WwcfGSQO+rpdg9dm12iWDLKc=; b=AVaL/mfzYNs6IsvBL5kSOPiUeA
	J3HpuSVwi6rZHJrqj4Hu+Slu2Rsz59StAH+4QZiubHEH/pfX+VSQteusLfskB1GtWkr84kKRzr58j
	0Sl3sSFUbzCNW2VnSB3CN8ONI/9t/FQl5X10T6z0ZRucHI0Dp251hHy2Z6elqzajI69rmrhwL7UxO
	wRnlZefIrWd/0/FjWB88DmYW+eNOkhq1IU2B96WvyPExUcQksMgKsl0EfTy/rUEKby/MjK7adTLXf
	xGtG+RT2ZbqTxn1RfO0BEqXfyF9dMkH5b/9XTdxmOZV5DGERJss/lEwgLHI5X0tRBfFqogjw6bM8s
	+HhU9WrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LlO-0000000EA1T-0pDn;
	Thu, 17 Oct 2024 08:21:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LlL-0000000E9zm-17Qj
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:21:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02E7E227A87; Thu, 17 Oct 2024 10:21:36 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:21:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <20241017082135.GA28355@lst.de>
References: <CGME20241016201330epcas5p33226adcbff73f7df7cced504aea64a13@epcas5p3.samsung.com> <20241016201309.1090320-1-kbusch@meta.com> <20241017060123.GA8191@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017060123.GA8191@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_012139_470156_DBB04DCF 
X-CRM114-Status: GOOD (  10.23  )
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

On Thu, Oct 17, 2024 at 11:31:23AM +0530, Anuj Gupta wrote:
> Not for nvme passthrough, but all this code is needed for io_uring
> metadata series. Please see the need/justifcation [*].
> 
> [*] https://lore.kernel.org/linux-block/20241017054900.alfiqn3o37f4kkxb@green245/

But it could easily set it in bio_integrity_map_user.

