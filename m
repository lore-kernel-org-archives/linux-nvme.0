Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA06FC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 04:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ts5YA0AQDvRRH6A43FWM2GhDoBhXyYOVsqfAQh8IlUc=; b=goL16szY64rLBvTCVDLF3/xo4+
	R4WBWC73SnZMcM+2TAqmZJe8bp88vO54WwEfQwH8eVVXUjYLFxaUITt1UecyuSbRU6uCrrXBThUIP
	uLinpkFQW5plLJJuGCu0Ht4Sw09dEFGRcSBidf5Tf1hC5+z8RSJpgUNKL9Y3fI62a3kwl398X//bL
	3OKqOg2kp/FxH6YYXoARXTtyXWPD0YRNzyl/LvFRp7GgT3f5+nyu9mjzV8WUJbvvLJicH6ketVPVT
	81iyCnhREoHF73Kw4o+lQe5mB3/4HnI0vyYjhG0NjhrpiRsIHETFhvLesY8xzk+R+qMhQoI3sWh/2
	/WYTnrlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO942-00000001h5b-0xBK;
	Mon, 01 Jul 2024 04:54:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO93z-00000001h4d-1pIL
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 04:54:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB4D768BEB; Mon,  1 Jul 2024 06:54:46 +0200 (CEST)
Date: Mon, 1 Jul 2024 06:54:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to
 blk_mq_alloc_disk
Message-ID: <20240701045446.GA26763@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-13-hch@lst.de> <4f515e0f-f370-4096-85a8-907942bb41fe@oracle.com> <20240629051958.GA15371@lst.de> <2455c846-e232-4e6e-8ba0-cd9de0cc7b03@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2455c846-e232-4e6e-8ba0-cd9de0cc7b03@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240630_215451_644288_A98FB433 
X-CRM114-Status: GOOD (  16.38  )
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

On Sun, Jun 30, 2024 at 10:55:12AM +0100, John Garry wrote:
> According to the comment on virtio_cread_feature, it is conditional (which 
> I read as optional) and that function can only fail with -ENOENT. So I 
> don't think that the probe should fail. virtio people?

Oh well..

> I think that it would need to be:
> 		blk_size = lim->logical_block_size = SECTOR_SIZE;
>
> Which is a big ugly, so maybe:
>
> 	if (err)
> 		blk_size = SECTOR_SIZE;
> 	lim->logical_block_size = SECTOR_SIZE;
>
> or, alternatively, set bsize to SECTOR_SIZE when declared.

Maybe just set up logical_block_size at lim declaration time as in
your patch that started this, and then kill the blk_size variable
entirely and just use lim->logical_block_size.


