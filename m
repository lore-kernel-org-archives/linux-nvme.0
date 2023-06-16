Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A38FEB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jun 2023 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DEHAefYT42nW4IwQcu3PQ1uBcaQKIAv2dPimLUGt2xg=; b=qFpDg1c8FVepuDFF7OM21QojFI
	YOSkAUNyEdLANfQzswH7KzktLeE4lZB/h6/wwLg8xuz1ZKg0LzHYKFteRYLIv2FVhFN2NEASUKcFg
	yaBdeBFoeAGVm2STg7IqSpW8ZiF1+XRCfB6RGtoy5NCzASt0/gaQeWI5NqhimsRephf17fci2bSkc
	8bo7ZpIluIAb9JFrb2MByYC1zVfUjZ1pcM9VaFQ5snFg7ZUkl0/LJzcJf5aVkvyyTzbR05HyOeo7M
	VFmj6uCr+hLz4M8F4AZ562u26GLZ8X41aFtsy7WKknHrjoexclmdbmHu/ySoto93aQ+KqBFoIsSys
	gL5BYuRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qA2Je-00GvmI-2z;
	Fri, 16 Jun 2023 05:48:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qA2Jb-00GvlY-1A
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jun 2023 05:48:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBAB267373; Fri, 16 Jun 2023 07:48:00 +0200 (CEST)
Date: Fri, 16 Jun 2023 07:48:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <20230616054800.GA28499@lst.de>
References: <20230615143236.297456-1-ming.lei@redhat.com> <20230615143236.297456-2-ming.lei@redhat.com> <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com> <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_224807_550862_23A5BA42 
X-CRM114-Status: GOOD (  17.46  )
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

On Thu, Jun 15, 2023 at 11:43:51PM +0800, Ming Lei wrote:
> On Thu, Jun 15, 2023 at 09:16:27AM -0600, Keith Busch wrote:
> > On Thu, Jun 15, 2023 at 10:32:33PM +0800, Ming Lei wrote:
> > > NVMe calls freeze/unfreeze in different contexts, and controller removal
> > > may break in-progress error recovery, then leave queues in frozen state.
> > > So cause IO hang in del_gendisk() because pending writeback IOs are
> > > still waited in bio_queue_enter().
> > 
> > Shouldn't those writebacks be unblocked by the existing check in
> > bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
> > disk state update or wakeup on this condition?
> 
> GD_DEAD is only set if the device is really dead, then all pending IO
> will be failed.

del_gendisk also sets GD_DEAD early on.

