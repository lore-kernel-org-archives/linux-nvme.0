Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7F5E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7t4JN7BLv2Yp1mrkUobHyEiyvEO1XEs23Zyn+HKT/+I=; b=lO5WeSyywqUW0tGBU1VG5HXMnU
	iOcLJTcPwegrJGw4EB2w1m3c16/5wvM+ICRQ5bztef0QTjN6MM36TkIDw7wPRWxdwKhFaix3e4thG
	KaiHMBNMiwCwG25B6QWdRX2MhAGrVD+io0mpqSKjU99GbGwm12wLivvW9164od/W7YHBzw6W4vFoz
	chJKE5lFB4Xp0aI7AsYqWWs/YSU1D3DSX6FUaApK2v4rGX8LoLz4O/ARmYf80Bsq98gFfxaPysCmt
	qh6wfzO/1HRXUxyrqNJJz1dJN/CNGi+kMHEPfAvG321xYaC93jr80BcsSCSdfdwC1NbKCnBNQ1WXx
	Mid/uW2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkq7-00000000xL2-0AIT;
	Mon, 06 Jan 2025 11:00:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkq3-00000000xJz-3T3j
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 11:00:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4254968D05; Mon,  6 Jan 2025 11:59:57 +0100 (CET)
Date: Mon, 6 Jan 2025 11:59:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 06/10] virtio_blk: use
 queue_limits_commit_update_frozen in cache_type_store
Message-ID: <20250106105957.GC21833@lst.de>
References: <20250106100645.850445-1-hch@lst.de> <20250106100645.850445-7-hch@lst.de> <07353499-b62d-488a-9575-12de5d9b6f2e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07353499-b62d-488a-9575-12de5d9b6f2e@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_030004_007008_58E73DE3 
X-CRM114-Status: GOOD (  15.39  )
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

On Mon, Jan 06, 2025 at 07:56:19PM +0900, Damien Le Moal wrote:
> On 1/6/25 7:06 PM, Christoph Hellwig wrote:
> > So far cache_type_store didn't freeze the queue, fix that by using the
> > queue_limits_commit_update_frozen helper.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This should be squashed in patch 2, no ?

patch 2 is supposed to just be a mechanical conversion, and each
behavior change should be in it's own patch.


