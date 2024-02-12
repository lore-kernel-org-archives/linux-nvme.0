Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F7FC4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2kJJHxjlDHmVC1keeHn49d8F+NLUTbwPyRxQi4H/WY=; b=jaK0ieftQzu1UhKTX90TQAVHdz
	VzaVORwC7cQhJ6EPVvEKeP95jK7ZM3mI7/v1g+EJenDrSMcZF6WVsFoqgkhmuFe+x9/GW3RiOT+N2
	crM8yHd2ecCL5RJtSW9RDvPTLl0aMEQydnZtIRZLi//dxxQ7p/VaancEraBbZqXX5+zQxXn+sS5eM
	GgXSK4RwNqnMtkw0f9XGuCXzJwYzlEEOUzUHl0GriqfGBzKIDuggb9zkDgOUMf+LaKtyQU+fp6Rli
	wa8v55M3ecZc+dU63eN49ouy7R2YrNh+jpVn+lhoR/UiDoQQcN6x3bBQqRVdilWzHMEpIyQAcxvIl
	04Ku7HIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQgI-00000004UwW-2QhM;
	Mon, 12 Feb 2024 07:24:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQgG-00000004Uvk-0Y67
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:24:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7999E60B33;
	Mon, 12 Feb 2024 07:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDDEC433C7;
	Mon, 12 Feb 2024 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722683;
	bh=+Gv/VC5NcWqqN18JSwFFw7Fat9gAWSXTSwmPjBcFj+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YOzqJq7MEx89Uid+NYxhbdV1hR2XUZyL1Eu2D+0iew02XLCVIrBFKA48KU7p/2Xq7
	 LfJDC8aB5S/gqjyI5SOyyjBZxqWxYascqCl8IeXn6OtKUTaKYCBGORy3OxSP2NxiGm
	 i/Pesv0hmYvVy+viEmNoi1pPtvyeWcF49iVYc4EZKm4Bvf+T9td4H0yQPcT3HIlCNU
	 /4vd6yiqDGQ+JPTLnRafemp9y8GPein7GNeYRCRi15yUDAcbZQlSBbYefQO4ObZKRV
	 rQtwsK7SID+p/05V1tKvAXC9F542GXMecBO9T9IZSAtL6Ixl/wRxKb56WdWuFNhBqT
	 HDeCfqi+NLWkg==
Message-ID: <e1061d81-ca74-4b56-b87d-4f6660340093@kernel.org>
Date: Mon, 12 Feb 2024 16:24:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240212064609.1327143-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_232444_255858_E3C25756 
X-CRM114-Status: GOOD (  14.47  )
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

On 2/12/24 15:45, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.  Also use the low-level
> validation helper to implement blk_set_default_limits instead of
> duplicating the initialization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       |   1 +
>  block/blk-settings.c   | 228 ++++++++++++++++++++++++++++++++++-------
>  block/blk.h            |   4 +-
>  include/linux/blkdev.h |  23 +++++
>  4 files changed, 218 insertions(+), 38 deletions(-)

[...]

> +	/*
> +	 * Random default for the maximum number of sectors.  Driver should not

s/sectors/segments ?

> +	 * rely on this and set their own.
> +	 */
> +	if (!lim->max_segments)
> +		lim->max_segments = BLK_MAX_SEGMENTS;

Other than the above, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


