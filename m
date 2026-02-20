Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0FEC5ACD1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dlwqpBDJLohovqOqN1l4hMEygSPaWXYi3iPxAS6xRmA=; b=ECRjouE+Sjk4WBvlr2NxRILQ8T
	VX81oy4aofq871s6Cs1QXbpZWWwXpZnXkS7pNHDhsFboloO3M77DBwTpma7R5wG1LpOER+kCWsSYK
	69piGCY1oDey86E5K4Js/Vf5BI+PUWH0nJq2XRoyd4OfEe60vqsy1PpZS544jYIQRhghvdAytpRbV
	MxyHoIuQAcIQgA7aVfBrAtjiwv8KhU/cSbsQW4h0ZleV7tNbmJDRuQAalR2xjbE4zjmqAnWGis3Cm
	vpuGJWVrlDKtUR9ehNJgfwJsPf04zz1ayw7ZBAk6bzI3Hy1wNDLr6bQqGnEwgp3xqOwxVYWJrNDPx
	Jsvkz2SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT5u-0000000FC7L-1tZp;
	Fri, 20 Feb 2026 16:11:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT5r-0000000FC0y-1WQa
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:11:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40CE868B05; Fri, 20 Feb 2026 17:11:00 +0100 (CET)
Date: Fri, 20 Feb 2026 17:10:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
Message-ID: <20260220161059.GF15071@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com> <20260220032809.758089-6-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220032809.758089-6-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_081103_636772_7C591B0C 
X-CRM114-Status: GOOD (  12.60  )
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

On Thu, Feb 19, 2026 at 08:28:08PM -0700, Caleb Sander Mateos wrote:
> Use the NVME_NS_FEAT_OPTPERF_SHIFT constant in nvmet_bdev_set_limits()
> to set the OPTPERF bits of the nvme_id_ns NSFEAT field instead of the
> magic number 4.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


