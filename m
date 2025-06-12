Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9044C71153
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c+K6uqnEnh6Br+k901/fecPb5ywoda8Yr23qdCBijhI=; b=xNnUVLTtje8AkE
	0Jx0nyJApEaRYxUE/MmkPlf9hepjC6HMfp4VmNRX4UqBRhvTFzvl6c7GIdnk+Xl2TkRI2gP9xc6Cg
	El5rPoHt+orW4UvOMBjGml3m35ZbOvM1Idf4KG2/L7pLjFbGS63fg29g4ZD09LczvsR6kPoeVGOAA
	j1OT6NMqlfpKpoYfMd0x346zIjjFl6SbxprdbTvEW5QmT9lAZlmGEz4IOr/CpAIXOiAja8GjT01Ig
	wb5aCi2QpRlV8SHGs6Rs+LoXMfTKwvfG8BgG00k6UJEeXc4m7VRXv3JlUDa6jPYhcQdRZgFzyjsZW
	K/ymzdWpgguv71x2OwTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPq76-0000000EjLx-2jbj;
	Thu, 12 Jun 2025 22:09:36 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPjlX-0000000Dm5d-2S5b
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 15:22:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=c+K6uqnEnh6Br+k901/fecPb5ywoda8Yr23qdCBijhI=; b=lM0aviSPeCdRLUr+6RLCHjKdSL
	swQfaURCp/51nds1zd4o8MPNa1odfL+TrqOBqepA7lUEK6XxZxZ/M9sHqnDvhLBQH9yJe3Av8LZkt
	vw31/mRVfmYjR5xGnOyinQX2QXhq7D4ASdl3uPALNLNvmTl6OTftjPkHi5dgGigeLFGL0lep0TGY0
	sr32EPDixO7oIlMLxqqZ6qv3sIbg3QXcor0tXHZ0pM1wZOBXAbMGmi39N+ladhKP6pu3Lv3BZrM8E
	Rz8pd1u6drzyOtnA4YAzZvULmBWDrei4pKcLdh9rYJ9tr6uijLT/oTC714OQ8T6KTuR193ZXv12Ab
	w/aZXrqg==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uPjlN-008S23-1v;
	Thu, 12 Jun 2025 09:22:44 -0600
Message-ID: <022b3644-549e-450f-9d36-5c516765ebf0@deltatee.com>
Date: Thu, 12 Jun 2025 09:22:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250610050713.2046316-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: hch@lst.de, axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com, joshi.k@samsung.com, leon@kernel.org, nj.shetty@samsung.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_082255_627934_4E31605C 
X-CRM114-Status: GOOD (  11.48  )
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



On 2025-06-09 23:06, Christoph Hellwig wrote:
> To get out of the DMA mapping helpers having to check every segment for
> it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> transfers, and that a P2P bio only contains ranges from a single device.
> 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the DMA mapping path, and only for already
> marked bios.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

