Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D48C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8kbuzs4xiP//0iTFpWA4ja2EMtVImR4HAxViGkqSPJM=; b=xiYfa+zfTHb+qkre6SA9/zdUyN
	m2XBFFkeB2dMo1CkDUvrW1O6Mvyd2DwhdQKioSF4/Fmqd2jcpFU4WPGb8yzXLVGPiMmumwo/beJwi
	aAAfF0tSpgdPadxm+eJkdnpDStY2OpKkxbfQFsS8HlZu2PpL1DC4yCN2lYuojlztWYQWuTzoqjR5T
	jjwWUxnUnyYn0fMMiP/fwkKD/JFSiVZHiN3NqdfpE6mmQGP/ySy2s6hgZ+zJFNBuNJeE/HEorckEr
	opai9mm6JT+DOTbF2PFOaCr7K0PUbVV5TSYBJvg3AM1VQW8b7b8/tQqbcMplI+lAQem5IwDcVBSa+
	96DquVEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olroi-007pNF-0i; Fri, 21 Oct 2022 13:12:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olroc-007pKl-3D
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 13:12:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAF7168B05; Fri, 21 Oct 2022 15:11:48 +0200 (CEST)
Date: Fri, 21 Oct 2022 15:11:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Message-ID: <20221021131148.GA21741@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-2-hch@lst.de> <Y1HxM+3bXNpsZvzk@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1HxM+3bXNpsZvzk@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_061158_297137_E902FEA3 
X-CRM114-Status: GOOD (  13.59  )
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

On Fri, Oct 21, 2022 at 09:09:07AM +0800, Ming Lei wrote:
> Just one small issue on mtip32xx, which may call blk_mark_disk_dead() in
> irq context, and ->bd_size_lock is actually not irq safe.
> 
> But mtip32xx is already broken since blk_queue_start_drain() need mutex,
> maybe mtip32xx isn't actively used at all.

A while ago active users were still reported.  But I bet no one
regularly tests hot removals with these cards.


