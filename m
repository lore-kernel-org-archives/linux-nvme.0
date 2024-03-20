Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4540C54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 03:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e4mBNhNJAfzCLIgLNL/TVEW4LEiyH9RiGFcR6yq7AKo=; b=R1ByOsOqXfW5g4wL4BtjMDK5Af
	KmhBlrCI1CmV3EOYFHocGbIlNs5R3Oz1AbBfvX1u/L/lx9mv6tT5d3HpW2R5/A8w8uwFTio4qfxu1
	XUNz9Cka2HQpk8PCsjVcPC2mgzPRl1Q0JovnTgQpzUmwYycQjccqwLCI7h9NtuGpU6j5KdFgkdZ/B
	KRGs7Gf14jyMmKejq4fSxVGcKfla1gNEU2fv/fQCjAW0pGNk/DRn+ZIDjjeh+b1M1KdYu38GlVy0T
	2vYqwTv0oeta6DRUAt9REkro/9G0haVsFL3uavgRksQkwoTy+TemEfnXjDi8SzLH0z1gcpeemaRpz
	35aV5Gmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmmTP-0000000FDNy-1iQx;
	Wed, 20 Mar 2024 03:18:39 +0000
Received: from mail-m49216.qiye.163.com ([45.254.49.216])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmmTL-0000000FDKI-1TvZ
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 03:18:37 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id CBBFB4C01BA;
	Wed, 20 Mar 2024 11:17:56 +0800 (CST)
Message-ID: <08b936ff-10d0-48d8-aacd-6ae1e2659600@easystack.cn>
Date: Wed, 20 Mar 2024 11:17:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jirong Feng <jirong.feng@easystack.cn>
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, peng.xiao@easystack.cn,
 Christoph Hellwig <hch@lst.de>
References: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
 <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
 <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
 <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
 <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
 <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
 <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
 <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
 <20240131062526.GA16177@lst.de>
In-Reply-To: <20240131062526.GA16177@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB5KVh0fGh5PHR8fGUxISVUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8e59dd9296022ekunmcbbfb4c01ba
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQg6Ogw6PTc0GlY8HykeOD4e
	TzUKCw1VSlVKTEpLQktPTUxMSE5IVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFJT05INwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_201835_659804_C889B227 
X-CRM114-Status: UNSURE (   3.74  )
X-CRM114-Notice: Please train this message.
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

hi,

just kindly ask, how about the previous patch? will it be merged?


