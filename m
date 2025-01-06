Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A284BE77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u3u4e4h2vhvK3jfvYBnqQlWOxzG/vuxc/BDzp3ituoM=; b=N3lofvcZwblT+BAGCeJH6W2Ys+
	B2J7lc86tsomze7tyREb4R99QUoNZCxBUqutzjNiGk94xq6+pJW5uedxESCq2SABeQZlHWrkWeXuG
	/tUZkCGOiLcTBz62/YNxG70MQeG7sWrW4GLSiMCZidkfW7tPnf9ditTg4JEdLEBoai7zMAfO/9gRD
	lVntkROMBuzMq3MBvbrOIxqpGf3pRJ+93GpUxmHJMX0Odm+qKe8IgZrtzTEpK2hBYDWh1kDd8hAEm
	KOkKGLnf96SgN8+OiL1uOSJuUO7Fp901+WWSLoxR9TMqOuNJM5Bygmu200EwDFJ7hYCx0LHsnjc0g
	eAzYscLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUp1G-00000001lbY-3U4Y;
	Mon, 06 Jan 2025 15:27:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUp1E-00000001lZz-0CiZ
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 15:27:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B42BE68C7B; Mon,  6 Jan 2025 16:27:48 +0100 (CET)
Date: Mon, 6 Jan 2025 16:27:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 06/10] virtio_blk: use
 queue_limits_commit_update_frozen in cache_type_store
Message-ID: <20250106152748.GB27431@lst.de>
References: <20250106100645.850445-1-hch@lst.de> <20250106100645.850445-7-hch@lst.de> <07353499-b62d-488a-9575-12de5d9b6f2e@kernel.org> <20250106105957.GC21833@lst.de> <3cf61c5f-b53b-43b6-90de-e42272f74e3f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf61c5f-b53b-43b6-90de-e42272f74e3f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_072752_227348_77BF4996 
X-CRM114-Status: GOOD (  13.16  )
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

On Mon, Jan 06, 2025 at 10:09:16PM +0900, Damien Le Moal wrote:
> Sounds good to me, but let's be consistent then: do not remove the
> freeze/unfreeze from virtio_blk in patch 2 and do it here in this patch.
> Otherwise, patch 2 *does* change the behavior of virtio_blk, introducing a bug
> (missing freeze around commit update).

Yeah, I'll fix it up.  As mentioned in the cover letter I just brushed
this up just enough to be presentable for now.

