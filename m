Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C71BCF2560
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rzPEj4eurnkGH9Ev1raz8nnyXgF/BqMIBftE0wJlaYE=; b=OnXHxF/zSdu9LfFEegcspY824t
	QnICP4hnFpe4Kc28daranC875i46QqcWsiiwohv0su2LmLEQPs5/MwliEo6LLAU49JusKCYcYnavN
	z8Kg2FXU3TIkdWFyXwtYxbr2+zwhHzPiJBcq0/Hs8beVrsu3kgenRUvVTym7PpvBQFjn5fpOipVik
	xsSX92iwTXjL+I+4AqTl6XOYP5TzVHp3dDasB/ipK+t7y8IZiaF21i5hl0kuAZcHBJtsT14GSldY2
	6ifGUCTcm8D1V+D956OxDvAeREK15JNdBxLGiO3157i6UW1N+Y41Q36gWm+MQ3avc0/Dpx3t1FfaV
	q19FgUMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLUqe-00000001Dit-0Jg1;
	Tue, 18 Nov 2025 23:10:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLUqc-00000001Dic-1tVw
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 23:10:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 88FED6014A;
	Tue, 18 Nov 2025 23:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B5C2BC86;
	Tue, 18 Nov 2025 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763507452;
	bh=7QQygTuOQynkohM3s2IldwIWULLZl54zzYKbrbFD0h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjl6TzrpZsV04eh6v4kBgSjuImsUEm9WB8cKFVv14EuRtklHdlW51lAuUidl0puBT
	 /IF5mdPC3JYaXh8luXYGEmHJQo6wAyvmAkXCf0uDKs/u1yPKSB3EC5rRQ6qmwZWhyx
	 FaDwU0h5JeIWJPU53QMFBRrhcdrYcLXS3EIyuLJTvuLMl/vXie8Kgsa9IFsKIUy0GO
	 /h8GD/lqiNP4ZMu8+UmzWPn6pK8NKXbje/eKaBBlPAveJaAP6m1psqUscXnmTOWsik
	 C89DuwxDNpGBXHoLLilCTvrfvxfD5l29AztFyNNomSnF5rTmkbcSzkWnn8HjY+SvPO
	 KhHFFIK87Wpdg==
Date: Tue, 18 Nov 2025 16:10:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <aRz8-IB6dq5tlpae@kbusch-mbp>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <aRt5DPnMwzDw8_dF@kbusch-mbp>
 <20251118051823.GA21858@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118051823.GA21858@lst.de>
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

On Tue, Nov 18, 2025 at 06:18:23AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 17, 2025 at 12:35:40PM -0700, Keith Busch wrote:
> > > +	size_t total_len;
> > 
> > Changing the generic phys_vec sounds fine, but the nvme driver has a 8MB
> > limitation on how large an IO can be, so I don't think the driver's
> > length needs to match the phys_vec type.
> 
> With the new dma mapping interface we could lift that limits for
> SGL-based controllers as we basically only have a nr_segments limit now.
> Not that I'm trying to argue for multi-GB I/O..

It's not a bad idea. The tricky part is in the timeout handling. If
we allow very large IO, I think we need a dynamic timeout value to
account for the link's throughput. We can already trigger blk-mq
timeouts if you saturate enough queues with max sized IO, despite
everything else working-as-designed.

