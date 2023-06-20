Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179C0EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 05:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s1gGSDZktVupIm7A1/9DVLRXzjJUxFcFb++grRi0Ipg=; b=ICRkeut5FjLTvt5xMPK5zFmc5m
	IP+Vfg95glWBMgSOHpcQsrpCuxoR7aCcfQ1BdjRjSB5Hn5aOWP9aslxSkK/LlNHj7nP5/wbC7q+Q4
	4am6NB6QaG99l6YNvoe6QFE58I9rNtJ5+sAayNj2jngyfgdE6hFOdv7wHUGLFYd94KEB9Av/7o0yI
	T5RfMy3buETfLVIEdZWLy4YsxUZbNZljksfwcEkiqgimGoYhFAYQgzP7X5Yzzk1SynVEEWnVnwI17
	vXpB26fJnm8L13rYHVosl0/pxi0vCkCIwR23F7Y9+cOwYjtHPj4isjAKZFatAIaEQfaFeQKepU/MJ
	jd9YMO6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBU7h-00ACoq-1B;
	Tue, 20 Jun 2023 05:41:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBU7e-00ACnv-0Q
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 05:41:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 84ABD68AA6; Tue, 20 Jun 2023 07:41:41 +0200 (CEST)
Date: Tue, 20 Jun 2023 07:41:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <20230620054141.GA12626@lst.de>
References: <20230615143236.297456-1-ming.lei@redhat.com> <20230615143236.297456-2-ming.lei@redhat.com> <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com> <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com> <20230616054800.GA28499@lst.de> <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_224146_316666_A451867E 
X-CRM114-Status: GOOD (  17.25  )
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
> > > GD_DEAD is only set if the device is really dead, then all pending IO
> > > will be failed.
> > 
> > del_gendisk also sets GD_DEAD early on.
> 
> No.
> 
> The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
> bio_queue_enter().

IFF we know we can't do I/O by the time del_gendisk is called, we
need to call mark_disk_dead first and not paper over the problem.

An API that force unfreezes is just broken and will leaves us with
freezecount mismatches.

