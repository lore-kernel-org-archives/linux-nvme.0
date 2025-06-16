Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FD6C71155
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=58TRFRhb3AEAQu0bn7+W3Qdzjz+4hWOCtnQrq0jeiQE=; b=WDKEjZxAhDp3Sq
	f2JyBYVra1fJLeb7BwLiWvvcMRORXzewsEovg/aIlQjqAZQZqvbIuzqfM6ALBZ3Pxt9OCcPWc3TkQ
	uv718PcuZA+eHradU52oHdrNPgL7zuaegtiu4HT72eIkDJlKM2XYFmgDJKrYwn0EENljpQWdFlMZn
	CDetx3v+hpWjHkDxmLRyUGRwfIAh4a+KRzFvg3Fzii/+MQ4fSQkJeCgsz5z/lZrQ50dtCFjKWxp0e
	I65x5BdGRwuhfz7FLxaXi5pQv+x6VWJXGmiegU95ET7gTc/sYjsp0mO9ShpezjrOjLvkJy4IEVOZN
	qsYpp1lQ8cRzahHv641A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRAYO-00000004f5h-3lKh;
	Mon, 16 Jun 2025 14:11:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9Jz-00000004RBH-1bBx
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 12:52:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3BCEE5C542A;
	Mon, 16 Jun 2025 12:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBC1C4CEEA;
	Mon, 16 Jun 2025 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750078338;
	bh=lLluGiDj3IspTt0wBlfDTiSMeTHl4JxzJK1kL5J5Ad4=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hf69rWp0DWw+PRlmlHKCpDWH8GViZHh1RoN3phpFiuApY3BgzmEiuwzNdFsw6eY+P
	 uInQ5YxaUbd50Cn3AywFyulrUastqRXP2KmUbzsYZ8j2HkfKMgl1qxNCI6Dkk24/QC
	 ODU9StPhCY1KDKVFOERclA4NAyotiWPCQiN2NFPY01llmbiEDZgZ8uQRga+sp+QPnS
	 wi7iIeakhTIFncHg4Hz+ltXqoRJdsffwM4taQB2noBkZ6N/UEVkcbZ1hrSKwR+lbfh
	 xxcKUPTCjKUXafzwWy5LtI6rHP7ABBmuWUBJPlfvIy/lSVzTW0JtRr7H3DBKSxBVUJ
	 aZjyRSr7Lr75w==
Message-ID: <2c210c03-9213-4c62-aa4f-2803b6d0ef0a@kernel.org>
Date: Mon, 16 Jun 2025 14:52:15 +0200
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
 <2105172c-5540-40d0-9573-15001b745648@kernel.org>
 <20250616113141.GA21749@lst.de>
 <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org>
 <20250616124205.GA27570@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250616124205.GA27570@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_055219_469272_4C7EC304 
X-CRM114-Status: GOOD (  13.62  )
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



On 16/06/2025 14.42, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 02:37:43PM +0200, Daniel Gomez wrote:
>> 	
>> 2. In the if/switch case default case (line 181-183):
>> 	It sets the status to invalid and *iter_start() returns false:
>> 	
>> 		default:
>> 			iter->status = BLK_STS_INVAL;
>> 			return false;
>>
>>
>> Removing the invalid assignment "makes it" valid (because of the
>> initialization)
> 
> Huhhh?  How do you make a field access valid by dropping an assignment?
> 

It should be valid already. But if the initialized value at line 160 can be
changed through the previous code then, this should suffice:

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 37f8fba077e6..7d5ebe1a3f49 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -179,7 +179,7 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
                        req->cmd_flags &= ~REQ_P2PDMA;
                        break;
                default:
-                       iter->status = BLK_STS_INVAL;
+                       iter->status = BLK_STS_OK;
                        return false;
                }
        }

