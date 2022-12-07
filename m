Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D47EC352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFbTMKifR19f/YC2npw/cOoZPDj+JbbptX5KKMQ41IM=; b=ga75pIIg1b9St06W2hl9wiQf84
	eUn2zBZ9QuZlTfUKRu/in1dlrc9fq3jjOSR5JnAZB3PQdGxzHP3tEyiDAIoW8wEdI58GtzhGmD0b3
	wkMJJeb7PLyUK1geZQuC7w9L8ddcQewTHQhIC8s+mR45NZcVRR8UsEErBWeFpznNi33qD0sWY32Bx
	KdNc/zs06bZt8YdyO98NkKaHVvnDbjb/7ruRCHBrnUGXaArFZ7/th3C4Pzp+a83r97jBx7/WxtTHt
	Ker7EoO6IQYH51SVI6bYI86z0yJl/wzoX5vHX2mK5R8XTPlVhPpNA3osFMlXwEikFfDvPC5HQAdkx
	cE50IqZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2oxq-00E2fY-6n; Wed, 07 Dec 2022 07:35:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2oxn-00E2ZL-TX; Wed, 07 Dec 2022 07:35:31 +0000
Date: Tue, 6 Dec 2022 23:35:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <Y5BCQ/9/uhXdu35W@infradead.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
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

This just seems like a horrible interface.  And virtio-blk should be
a simple passthrough and not grow tons of side-band crap like this.

If you want to pass through random misc information use virtio-scsi
or nvme with shadow doorbell buffers.

