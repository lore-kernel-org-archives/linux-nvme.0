Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9355BC71135
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 06:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4S+5NsBHeTgRw6H79+RvgGJnEakQUo0TwVJizMOnyBI=; b=XCbPI7L4sygYnL
	7GlC+Jnh3WHK+1quHWbsqh3jd+ewHVUb1ge+EpNI0QY/N6gfAGI6AAf1fibQkkLeDUw9xa2m2v7IL
	Rj9jk46QRE6w4FLsXpe4iLTmCkpyX/xSi4PAO5dJ2qP4O0mOWOJXwlMdzg0/efIjF6TK21ceCfAUi
	VTAqTksnOa8nnWv79jNO6yJwrf2ZY4rMLixN4MmRpDtlg0pvbME5YXv8OACgLU8j/fYpkus3rCk12
	C7N03BFveR8mYRWUtWWToDXhQ3+u4qPOZ8u34owbtu0nb6/UAsg4DGEQQLw4HbPFuXk7lnXK0oolO
	QG0/11iwoPuUTfRjuu6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR3bL-00000003Y51-3Q8I;
	Mon, 16 Jun 2025 06:45:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR3Z1-00000003XTY-0Nxz
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 06:43:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F1D215C532E;
	Mon, 16 Jun 2025 06:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCCDC4CEEA;
	Mon, 16 Jun 2025 06:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750056206;
	bh=i8eZ5db7jwLf3O2OU4sJwtCvyGnyULzOXR46Z6sekOg=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ea2GD93oQhfMVYrQqOBlhv16244neKYQsZ5tMJvqX4kKmN7Cu7dUxD6fMUJhdufGQ
	 D6iPWyjHsx48zcXJTnZtaOuAupGhsUInQzo5yhmnnqm1VvfdYVdNCTlG4CRmnC594E
	 cqI9WHBK0swPEqvw05iJgLssF6bWQUi3GLFIR31MO+9vGN6c2gR8zP7Jfsu3b4/v7V
	 /IMHMQlqFoRNYu9BprdLtUt5hKiobkNmnPPokSQm0OcNOaWzE7XUQh2KXtb7FXIkw4
	 ROJrXWpn78imzqt/xuKQU0bgd/DbXvwHEWBCs7p96qNzE59E20ZLC/a1mrnde4DxT+
	 Rkj2ZwzBNG2uA==
Message-ID: <2105172c-5540-40d0-9573-15001b745648@kernel.org>
Date: Mon, 16 Jun 2025 08:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-3-hch@lst.de>
 <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
 <20250616050247.GA860@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250616050247.GA860@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250615_234327_196098_994C367A 
X-CRM114-Status: GOOD (  12.65  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 16/06/2025 07.02, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 03:43:07PM +0200, Daniel Gomez wrote:
>>> +struct blk_dma_iter {
>>> +	/* Output address range for this iteration */
>>> +	dma_addr_t			addr;
>>> +	u32				len;
>>> +
>>> +	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
>>> +	blk_status_t			status;
>>
>> This comment does not match with blk_rq_dma_map_iter_start(). It returns false
>> and status is BLK_STS_INVAL.
> 
> I went over you comment a few times and still don't understand it.

The way I read the comment is that status is only valid when
blk_rq_dma_map_iter_* returns false.

But blk_rq_dma_map_iter_start() can return false and an invalid status (in the
default switch case).

Assuming the comment is the right thing, I'd expect a valid status for that
case:

--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -179,7 +179,6 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
                        req->cmd_flags &= ~REQ_P2PDMA;
                        break;
                default:
-                       iter->status = BLK_STS_INVAL;
                        return false;
                }
        }

