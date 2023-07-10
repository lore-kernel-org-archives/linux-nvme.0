Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635BAEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6eEwovQ6Voh+PrpdEZqTZ3rnr3Usxqv48CTCsUWDWKc=; b=N1Zb4FWliOJbyIr0Abn5n2wMQa
	7KCy5cVXO5S3fwHv/Ic/RAeLiOhlQwT8A4arUQcTPYCHjysXC/EiJ26VCDvrVwbrqTy0EiGUFuKiL
	q6P3/emOCUwVZOqWcUg91BQkdI5emSOwvhrcYbodUqL38k1XP9BW1/CU3x4auE0dXKO2jbGcxYdrq
	vdx5qMZPT+8xtq0Z7mXiKnXd1YKtch18bYbZ0yVH2goGSGXBAzYQ1KYx/rkf3gn4grM1e/ig4VTbL
	WaST/5LNDSHYisMmJXNv9nt/c+nEmLOy69uU00+3MOX219MAb0rNkT6w2HkOU+meh8WUFoQaaQze1
	usU0FmEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIkYu-00Abey-1E;
	Mon, 10 Jul 2023 06:39:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIkYr-00Abdz-2R
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 06:39:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF1D26732D; Mon, 10 Jul 2023 08:39:48 +0200 (CEST)
Date: Mon, 10 Jul 2023 08:39:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme: fix max_discard_sectors calculation
Message-ID: <20230710063948.GA24519@lst.de>
References: <20230707094616.108430-1-hch@lst.de> <20230707094616.108430-4-hch@lst.de> <06da81f9-dbdd-f706-0e26-afcfb89cfe32@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06da81f9-dbdd-f706-0e26-afcfb89cfe32@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_233953_933522_06B002DE 
X-CRM114-Status: GOOD (  17.73  )
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

On Mon, Jul 10, 2023 at 12:57:56PM +0900, Damien Le Moal wrote:
> On 7/7/23 18:46, Christoph Hellwig wrote:
> > ctrl->max_discard_sectors stores a value that is potentially based of
> > the DMRSL field in Identify Controller, which is in units of LBAs and
> > thus dependent on the Format of a namespace.
> > 
> > Fix this by moving the calculation of max_discard_sectors entirely
> > into nvme_config_discard and replacing the ctrl->max_discard_sectors
> > value with a local variable so that the calculation is always
> 
> I do not see a local variable replacement... May be you meant direct calls to
> blk_queue_max_discard_sectors() ?

Yeah, I used a local variable first, but then noticed they are
pointless as we can just call blk_queue_max_discard_sectors directly
and didn't update the commit log.

