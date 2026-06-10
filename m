Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C770CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAUItNuUVLejDW5TE99iMV9rBMc3o4QdZhoqXAHyDa0=; b=t3fSO1gAqIgpsSkrbIQg2vhlHB
	CyCEjmvP7IzKxqLLd2kQ0jZKCCv+UHBZnpD7sQz4Y6L15xmn1R6F4omMhaBw5vMWQnzYPhMT8j10U
	2FauypTFTUBGI2PqgIlMYF8U7k95iYpfT2fWBw5I+YdGGb3KFoJ3TlVsvklfvuu+MfA6MISZn3Xp7
	y8O0Ik2yUZF1MG547gcSJ5NK7vVmk5maoSsEgsqe4Cyql8etpbi8+COt8xItCJR8pemP75Lvkz9JZ
	z2W61mYdihkAoTIW8aU96/J4k+3vU7WcCXEFWS8z+lpWZ1oWGObZrfXT/V1043W8XXnBSU6FpuCh2
	yy7jT4Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHg9-00000007cCq-2Owa;
	Wed, 10 Jun 2026 12:05:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHg6-00000007cCS-2QvD
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 12:05:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85EDA68C4E; Wed, 10 Jun 2026 14:04:58 +0200 (CEST)
Date: Wed, 10 Jun 2026 14:04:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com, randyj@purestorage.com
Subject: Re: [PATCH v2] nvme-rdma: parallelize I/O queue allocation and
 startup
Message-ID: <20260610120458.GD19624@lst.de>
References: <20260604195321.2232838-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604195321.2232838-1-sgogte@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_050502_800303_7859C2D5 
X-CRM114-Status: GOOD (  13.30  )
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

On Thu, Jun 04, 2026 at 01:53:21PM -0600, Surabhi Gogte wrote:
> +static void nvme_rdma_setup_queue_async(void *setup_queue, async_cookie_t cookie)

Overly long line.  Easily fixed by renaming setup_queue to data
as in the async_schedule_domain prototype.

> +static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl, int first,
> +				     int last, size_t queue_size)

should first and last be unsigned?

Also please use two-tab indents for prototype continuations.

> +	async_synchronize_full_domain(&setup_queue_domain);
>  
> -out_free_queues:
> -	for (i--; i >= 1; i--)
> -		nvme_rdma_free_queue(&ctrl->queues[i]);
> +	ret = atomic_read(&ctrl->qsetup_err);
> +	if (ret) {

Jump to an error label if there was an error to reduce indentation
a bit below.

> +	ctrl->queues[0].ctrl = ctrl;
> +	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
> +	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);

The nvme_rdma_alloc_queue prototype change would be a nice prep patch
to split out from the main change.


