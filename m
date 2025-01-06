Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5173E77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 08:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+XLxyZ1p4AY6JZ/tX1OGamWMQlIfcfgJnZAoytgDW7c=; b=Gy3XLwEoCl1ySDdLs5zjxWTGpe
	O5uIqf1s05DsKkp+6hx4Vustn3aFtsCNVuRltlS3wYgauHLez+dZ0M0FEar0mYjNklsweCYsXN0Ad
	HRa5dSQuDSP0iLIbgkrwbCqJlOdDFWEOlb1Czw2MVHvT/Zk3gPcEIy+sdEAn5RGgTmLbU1GOjGRDN
	tmnGfJzYfoRWH3Ezqa6KBOHZCmxrvXMaYBa8mGBXhn3nQDMxkOQ4QnMByJy0Gr5p6G+4Sfaik4tc/
	xIokBdhKgLNj+Yj8DKJ8/va5n73GJVufnw9uBOefq3AJofq1Rr6hcsCdKji+UTJF/Dv8rJzdyrvpY
	rRx1sKxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiWR-00000000W96-1I2N;
	Mon, 06 Jan 2025 08:31:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiWN-00000000W8D-2MuD
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 08:31:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCA8E68BFE; Mon,  6 Jan 2025 09:31:29 +0100 (CET)
Date: Mon, 6 Jan 2025 09:31:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 3/3] nvme: Fix queue freeze and limits lock order
Message-ID: <20250106083129.GE18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-4-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104132522.247376-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_003135_754466_02C8D5B5 
X-CRM114-Status: GOOD (  14.48  )
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

On Sat, Jan 04, 2025 at 10:25:22PM +0900, Damien Le Moal wrote:
> Modify the functions nvme_update_ns_info_generic(),
> nvme_update_ns_info_block() and nvme_update_ns_info() to freeze a
> namespace queue using blk_mq_freeze_queue() after starting the queue
> limits update with queue_limits_start_update() so that the queue
> freezing is always done after obtaining the device queue limits lock (as
> per the block layer convention for sysfs attributes).

FYI, there's a few more like this.  In my WIP series I've basically
made the normal queue_limits_commit_update contain the freeze and add
a special version without the freeze, which makes a lot of this
more obvious.  Let me dust it off even before sorting out the poll
flag so that we have a little more discussion material.


