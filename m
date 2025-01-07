Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FB6E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kbb8eiGkRBCGGbgzzfOOeGqWDJhasr7p64hEWf9dgPY=; b=rDNRzSwJEqIp7/zphumyA5U4B+
	2GMxyjHPnXDiYWw0bLvFqPbxojHNWm7kD+9Y04W2nI81BzIlf34L58gQQae0mtchwO+nLY6ksbEHM
	mUAq3YP4/IjpzCIVBDghnvms9ZF1r2WD57HBc2yWuXpNewOWRHRxKlpDpOV3dni9YrapFOvCMfFPN
	9tQwztxTeNYWgG+bkocB1Kv2hm18a++FWsjE/iWHQrqjPn3tfryYDADYrmcg+rMlUXBlO+p+ipMPQ
	xB8hDm7Rh5HavNgOxtNiltAoxGbez3BYASt2OPPRBqy68/H8a5C8oHypI520w5rH61le//+HBQtjT
	SfajqDIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVA0y-000000054Bv-26wp;
	Tue, 07 Jan 2025 13:53:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVA00-0000000546w-115Y
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 13:52:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 830B868D07; Tue,  7 Jan 2025 14:51:53 +0100 (CET)
Date: Tue, 7 Jan 2025 14:51:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 3/8] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <20250107135153.GB22046@lst.de>
References: <20250107063120.1011593-1-hch@lst.de> <20250107063120.1011593-4-hch@lst.de> <220cdd33-527f-405d-90af-2abaace36645@linux.ibm.com> <20250107082145.GA15960@lst.de> <90ae40c5-b695-4e17-8293-6a61648ed24a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ae40c5-b695-4e17-8293-6a61648ed24a@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_055200_421776_CF1D40C0 
X-CRM114-Status: GOOD (  15.08  )
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

On Tue, Jan 07, 2025 at 02:53:40PM +0530, Nilay Shroff wrote:
> When I applied you patch on my system and access io_poll attribute
> of one of my nvme disk, I see it returns 1, though I didn't configure 
> poll queue for the disk. With this patch, as we're now always setting 
> BLK_FEAT_POLL (under blk_mq_alloc_queue()) it return 1. So when I haven't
> configured poll queue for NVMe driver, shouldn't it return 0 when I access 
> /sys/block/nvmeXnY/queue/io_poll ?  

While that was the case with the previous RFC series it should not be
the case with this version, as the nvme driver does not enable the
poll tag set map unless poll queues are enabled.  I also double checked
that I do not see it on any of my test setups.


