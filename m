Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F04EC55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lcl4FAtpNuAdLQKqzDUO+o171Vwb/K79BKqq1n629Vs=; b=A5/S4CihOv2rixbCerBD9RGlFV
	b5Z2Cox6VoU5vyed1ugn7jYxzQ0Mw6QsMjYNfa8Rls4adGT5LYNwHnFIwqWgAdxjtE8D1YXO3Nyx7
	cOpzEg9h/Lc2tkTjnDWzbRFNrtUIvaURGHHYK3cKHPdlHHb9kPP7pgJVsqAsyh4UwG9xd56kfCtHE
	s2Jc4Z4fEENxUeuCK/WO5Ax0AxYNVDGoVTN1x4mTwh0O7WD8ksvoBNsX2yEI5GAAw7YG+hQeRlyI8
	hf1uUhcs4x4d2dHuHV84jkKY9lZ/DrZXdaaR84JCAwskW5bh8n8pFkvQ8VZ5HguBNKF3haORH0dx0
	2jIJGA/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP5X-0000000AMid-0D9A;
	Thu, 30 Jul 2026 11:38:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP5U-0000000AMiE-0y36
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 11:38:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B13B968C4E; Thu, 30 Jul 2026 13:38:04 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:38:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/4] nvmet: propagate percpu_ref_init() failure in
 nvmet_ns_enable()
Message-ID: <20260730113804.GA25859@lst.de>
References: <20260730043105.3071328-1-kanie@linux.alibaba.com> <20260730043105.3071328-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730043105.3071328-3-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_043808_422700_3049CAE4 
X-CRM114-Status: GOOD (  14.14  )
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

On Thu, Jul 30, 2026 at 12:31:03PM +0800, Guixin Liu wrote:
> The return value of percpu_ref_init() is discarded. At this point ret is
> 0 from the preceding successful steps, so when the allocation inside
> percpu_ref_init() fails the code jumps to the out_pr_exit cleanup chain
> which ends with "return ret", i.e. reports success. The configfs enable
> store then tells userspace the namespace was enabled even though it was
> not and its backing device has already been torn down.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


