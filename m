Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C44EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jun 2023 07:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eTjIy77irMuI3XZjtWd9fTpFOTT6rjGVGWqD+UG2Fho=; b=c7UgUE+aFkXnfsuwz7Zvvs1n9C
	jT/np3zdZ/i1Kiv8wujhf3uLEnOQeQfpfG4Q+u0Y4v3SAhP859hKke9Kt40z1GYFdu64vSpCZaaXs
	7vlydzrWPcFoS0VGtzSt/StoFQxtOky7Oj3BxZEWvUsMgRQYywvCe1Ig5lflnEcnhgP9d2FRs5+BT
	4rX7v6a1+ffMSAYaElLU6vvrUPhDeqhOcarhBBBlRKWIFkHu1PbNTHbZ6whw4YHjTXfOv0ff399Mx
	PL6shBRkWNcGfTlHZ6TvbREpvWFmYW0nwyQT3INlwYDS+9la7jWQVxv1J+s4SVht2qCGF5m/5RBvz
	U3vimGwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qA3rk-00H99x-05;
	Fri, 16 Jun 2023 07:27:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qA3rh-00H99D-0O
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jun 2023 07:27:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE64F6732D; Fri, 16 Jun 2023 09:27:21 +0200 (CEST)
Date: Fri, 16 Jun 2023 09:27:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <20230616072721.GA30186@lst.de>
References: <20230615143236.297456-1-ming.lei@redhat.com> <20230615143236.297456-2-ming.lei@redhat.com> <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com> <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com> <20230616054800.GA28499@lst.de> <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_002725_301421_0139D103 
X-CRM114-Status: GOOD (  20.30  )
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

On Fri, Jun 16, 2023 at 03:20:38PM +0800, Ming Lei wrote:
> > > > Shouldn't those writebacks be unblocked by the existing check in
> > > > bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
> > > > disk state update or wakeup on this condition?
> > > 
> > > GD_DEAD is only set if the device is really dead, then all pending IO
> > > will be failed.
> > 
> > del_gendisk also sets GD_DEAD early on.
> 
> No.
> 
> The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
> bio_queue_enter().

What is the workload here?  If del_gendisk is called to remove a disk
that is in perfectly fine state and can do I/O, fsync_bdev should write
back data, which is what is exists for.  If the disk is dead, we should
have called blk_mark_disk_dead before.

