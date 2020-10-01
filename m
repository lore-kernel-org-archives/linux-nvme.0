Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F9CC4727C
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 05:01:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83CB221E7
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 05:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJtHwLgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83CB221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+3PJIqGgxhTJZ17XmvrkMOZHxbHTY6PmOpEjizTvYvQ=; b=XJtHwLgw5VpVKQkZaDOefvhDT
	fRAZG5vs6J5bXZHY04XHg3+zIYEX09S4lCxKr04hD+0tAMF3d7zLgCN2UiDAytUX9P/Ra+hYgaY9O
	OtuSvn3Tb0ue2BWEBy633rs9Kd8NdyGcTIZY7BZzKTXS+60m66yaM4visGFQTWLM9l4H6VDfW3ljG
	EfU4082hn6yjd6U+TXNNaRlDoBXa/ta49INOoM6DdpbgRhN+3kJzJBOC+PcUmS9OC8LELOMI3EVy2
	i+GZAfgsyKZNYbEHp//l3Kkwc/RY+O20py2OlffAhDPG9hEKpOvcX7rIcdUMZZHhbSfZou/v1/hVD
	xD/YbXouQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNqiN-0003xl-7e; Thu, 01 Oct 2020 05:01:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNqiJ-0003x1-ML
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 05:01:09 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4E2ED20888;
 Thu,  1 Oct 2020 05:01:05 +0000 (UTC)
Date: Thu, 1 Oct 2020 08:01:01 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blk-next 0/2] Delete the get_vector_affinity leftovers
Message-ID: <20201001050101.GT3094@unreal>
References: <20200929091358.421086-1-leon@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929091358.421086-1-leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_010107_790341_A7159434 
X-CRM114-Status: GOOD (  13.20  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 12:13:56PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> There are no drivers that implement .get_vector_affinity(), so delete
> the RDMA function and simplify block code.
>
> Thanks
>
> P.S. Probably it should go through block tree.
>
> Leon Romanovsky (2):
>   blk-mq-rdma: Delete not-used multi-queue RDMA map queue code
>   RDMA/core: Delete not-implemented get_vector_affinity

Jens, Keith

How can we progress here?

Thanks

>
>  block/Kconfig                    |  5 ----
>  block/Makefile                   |  1 -
>  block/blk-mq-rdma.c              | 44 --------------------------------
>  drivers/infiniband/core/device.c |  1 -
>  drivers/nvme/host/rdma.c         |  7 ++---
>  include/linux/blk-mq-rdma.h      | 11 --------
>  include/rdma/ib_verbs.h          | 23 -----------------
>  7 files changed, 2 insertions(+), 90 deletions(-)
>  delete mode 100644 block/blk-mq-rdma.c
>  delete mode 100644 include/linux/blk-mq-rdma.h
>
> --
> 2.26.2
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
