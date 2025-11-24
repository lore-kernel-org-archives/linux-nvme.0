Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABEACFD313
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6FRocwaHIhMFyB+36Mw3jg/Dsf6A/xofGrZpyO05iQ=; b=NwYyVjEBJqPuJfL9ZVibZ+oNZV
	VNGqsgFEhASvn3A1u99Mj1cjjkGhTav8Ee8E0sf7IQXLLd1UZLAWYr4qc4EpXKt15J0cnoVBgdbjU
	T1rmZGELDS7Y9uYP7wdEcJmqvq0WK56v/MncEf3fQA0I8v1aT034lQa4qbqXVT/K1iAmuBTDyZfrp
	0TF7BQold31dhx2U+BxxKyRzt+T+SoQq8tvXb0YqZPYF10iWH4fTxM65Qdbln4W8vmcMmApJyH1zr
	ppWGHwaJCQfM5xql2DqdTDPBvPijwdgLEEPo5AhPBLBvffbu8MjXJ8Kb90AwRHx24IGxcoXqE4R1z
	sHYepjug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNXVT-0000000Bq7Z-041j;
	Mon, 24 Nov 2025 14:25:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNXVR-0000000Bq6t-0JQW
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 14:25:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91DC268B05; Mon, 24 Nov 2025 15:25:25 +0100 (CET)
Date: Mon, 24 Nov 2025 15:25:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] nvmet-tcp: Use kvcalloc for commands array
Message-ID: <20251124142525.GA16757@lst.de>
References: <1763966961-32140-1-git-send-email-israelr@nvidia.com> <1763966961-32140-2-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763966961-32140-2-git-send-email-israelr@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_062529_264034_B521BF9A 
X-CRM114-Status: GOOD (  13.59  )
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

On Mon, Nov 24, 2025 at 08:49:21AM +0200, Israel Rukshin wrote:
> Replace kcalloc with kvcalloc for allocation of the commands
> array. Each command structure is 712 bytes. The array typically
> exceeds a single page, and grows much larger with high queue depths
> (e.g., commands >182KB).
> 
> kvcalloc automatically falls back to vmalloc for large or fragmented
> allocations, improving reliability. In our case, this memory is not
> aimed for DMA operations and could be safely allocated by kvcalloc.
> Using virtually contiguous memory helps to avoid allocation failures
> and out-of-memory conditions common with kcalloc on large pools.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


