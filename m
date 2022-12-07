Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07619C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Nr2HN/QvkKmAnTHNO48T6RDV2gQD2S0zZ5w1++whvc=; b=YpTPTdqxxjXy4T+DexhEL9Q4IH
	Hkxke5h/1ghlgrGcoOrPf3ewQMcNm3QQxXzVY57n21mTjig0q8QmLv01qaghCleFlUUuRNQSnLnxn
	r11u1EenzZZtqBBgQTm+aC4WjRtk3R6ZUkbm1LNjQ+L6AhguzLsj6/2tw67eDNEu1Heg79vzOOCWD
	2V80V0tA49yMrJFjf8RZlBdedbhCNOiuO2XMExXaKAw0yiK7uKPaTXAxR/yhQvhQgH/eDlEr5oHik
	Gfrpf/zMsouRO9H0JXpzYyK8sngCgXoRG7tC41fGPAg/+LaD3nnExf6CJ7+Cq6+jZCIdX4d7dYfTx
	LzFacr5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2xKU-006gvU-4I; Wed, 07 Dec 2022 16:31:30 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2xKS-006gtH-E1; Wed, 07 Dec 2022 16:31:28 +0000
Date: Wed, 7 Dec 2022 08:31:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <Y5C/4H7Ettg/DcRz@infradead.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
 <20221207052001-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207052001-mutt-send-email-mst@kernel.org>
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

On Wed, Dec 07, 2022 at 05:21:48AM -0500, Michael S. Tsirkin wrote:
> Christoph you acked the spec patch adding this to virtio blk:
> 
> 	Still not a fan of the encoding, but at least it is properly documented
> 	now:
> 
> 	Acked-by: Christoph Hellwig <hch@lst.de>
> 
> Did you change your mind then? Or do you prefer a different encoding for
> the ioctl then? could you help sugesting what kind?

Well, it is good enough documented for a spec.  I don't think it is
a useful feature for Linux where virtio-blk is our minimum viable
paravirtualized block driver.

