Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9C8C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xikaPq1xIDHed58qVgcVVbhIgW6DVjOO+wJNTvxtoSQ=; b=URN2tgHs3hVONYHozqcAw/gr5e
	flUFEJXbbjE9VIH1v4DSybObG0bQuvLef2y1JLYQYwbn3nRkXC5J9hcNE9JFgFkNUDu0o4Ai8CJYj
	YAZN1Krmz5kRBacHQ9a03NxSkBRMdQzYY//1ZStwLMR2+U5CcTO7RUDA4K5CMCap20RxC6Eo+q5IG
	/zTUEOriaDY1wNwydoggMVzI89tS0jM3OVQNr2WEJHnpxRevyuyyur+r4ZPVh0TjP4MZ6VszV7GmG
	FedcsrOzSXxy7ij4UIx7DMyQfVdnGT7dCQatJvuK1WZF/jmz7Ln0Cl4ahjaCIZiapKilBJ79z4DWM
	m08xFCLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpJX-0000000725N-02ph;
	Mon, 20 Jul 2026 14:49:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpJU-00000007248-0SJh
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 14:49:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96DBE68C4E; Mon, 20 Jul 2026 16:49:43 +0200 (CEST)
Date: Mon, 20 Jul 2026 16:49:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mykola Marzhan <mykola@meshstor.io>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/7] blk-mq-dma: restore BLK_STS_TARGET for
 unsupported P2P transfers
Message-ID: <20260720144943.GA17375@lst.de>
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-2-mykola@meshstor.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719105327.864949-2-mykola@meshstor.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_074948_293211_B9612854 
X-CRM114-Status: GOOD (  11.41  )
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

On Sun, Jul 19, 2026 at 10:53:21AM +0000, Mykola Marzhan wrote:
> matching dma_map_sgtable()'s -EREMOTEIO: "When this happens, return
> BLK_STS_TARGET so the request isn't retried." The conversion to
> blk_rq_dma_map silently changed the status to BLK_STS_INVAL, which
> regresses two consumers:

This is a really weird writing style, and suggested to me you neither
understand the code nor the problem.  Please actually think yourself,
write the patches and commit logs yourself instdad of this garbage.

And please also explain how you even generate the I/O that fails this
way.


