Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FE1C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVOE0Qze6KAKFuWJyCwEDvPCVxvmNHfTbpJ4qsW5XxU=; b=yu0n9BWZYYz1tw/wFwPauhp7P/
	CIIauwXO8qLpQeVGRQJ1wzI6l2+GpykmrOXSJkNgC5Wqcx+f1ldXQiLf+UJcHZh8Mum44msEASoY4
	VN8YzhxyO5Wepj5PlESBVYpzW8brN0AhaviAAOUtVnJCaXvLtKH0NBwr/AOy7DH2aFFcpzPvq/0fw
	tU28gMbLmIRujr+jTyF60sgNsGGjt2xokymAXQMJdz7WWjf9B6wYb3b8Z5VizCduWbX73VZJIghdq
	QBy+8xOWgekCbxVOPJRqvvOzPWJq3ovAjmbcQzPbxXcrmdr+Q3isrUZ8iN76HABoLqR8Gf5Tn6dmI
	4msG3EdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oho6V-00HabX-An; Mon, 10 Oct 2022 08:25:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oho6S-00HaaL-Uy
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 08:25:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 775F568AA6; Mon, 10 Oct 2022 10:25:33 +0200 (CEST)
Date: Mon, 10 Oct 2022 10:25:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] nvme: don't wait freeze during resetting
Message-ID: <20221010082533.GA24101@lst.de>
References: <20220926013404.2217794-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926013404.2217794-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_012537_192312_D770F3A7 
X-CRM114-Status: GOOD (  16.04  )
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

On Mon, Sep 26, 2022 at 09:34:04AM +0800, Ming Lei wrote:
> First it isn't necessary to call nvme_wait_freeze during reset.
> For nvme-pci, if tagset isn't allocated, there can't be any inflight
> IOs; otherwise blk_mq_update_nr_hw_queues can freeze & wait queues.
> 
> Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> while requests are in progress"), it is fine to unfreeze queue without
> draining inflight IOs.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chao Leng <lengchao@huawei.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- remove the change in rdma/tcp which may make non-mpath reset
> 	time much longer, as pointed by Sagi

So how can this be corret for PCI and apple but not for rdma and TCP?

Also please don't update two drivers in a single patch.

