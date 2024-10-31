Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F55CE67485
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 20:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/pEQTczTiq8UIkWg7TPO3VMAg1G//4dSD/mob7u6xE=; b=ZuP6MaqWE5WaT0G20M11EIzz8c
	5SP4Piqfp7RkC9SxdV/Z1MNnHAeRHe0uPQig0wGQEkWifriFHJqDxXf/I7qEp8kOYz6h+JSrWpPic
	28IQyepKNMxwC7kn7DlqR/hFe7LNV/OzOTZsCFnPgh3EvHmCFnv8lA5HInI73fGHHvaJjZdOsuTcN
	JR3gmV5KOPJhs266tw9zI+P/hh12yvFyyQVYPr7Fq+nv931jmUojoB5Wz4OhQofHqLoa87aGx1Ddr
	18y0wViu54mvPrQEomMv07Z1IVWvTx+VA/jsBQRfQRYenkeJrUD1UCzCC7HiJam4O3sX/C6KpJZ0I
	tWLYuIhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6cCq-00000004q57-1m6f;
	Thu, 31 Oct 2024 20:55:48 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6cCm-00000004pyu-3qHy
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 20:55:46 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XfbqT6Dh1zlgMVS;
	Thu, 31 Oct 2024 20:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730408124; x=1733000125; bh=B/pEQTczTiq8UIkWg7TPO3VM
	Ag1G//4dSD/mob7u6xE=; b=ZtIOVQTDUxy4QOQyeqVfTWcwWtIKOOg1Jac03tiI
	A7rCqvb9vtKSHPFTp3wF/OdOCTXggfRQmjW1Xz2AyQuoNB4AiXSB6jL3uB70g+in
	79BqU7XO0OVtBFrfJD3PLeY1HqTIVPag3Az5jepT8ofoaTAMY/ewHawQhH4R+bvg
	NqlDCexeZlHL8u4+B7neARRpjrmuBRu8CaY9eoTp1+/XajADX9rfWmgbndjW9rLQ
	XuadQP3u1OUiJL6NnXZlZfO6UYtdFeZQhmbg7NR4i+B2vLIqZ50DBphSoU0yOLfj
	+sqOmryDNyCHXB3zQKpW/jPG+KIxEnZasIOEgmoiYq7Z1g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 27aSEBHRr0Fw; Thu, 31 Oct 2024 20:55:24 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xfbq63bYdzlgTWK;
	Thu, 31 Oct 2024 20:55:14 +0000 (UTC)
Message-ID: <4c7e679a-d3e6-4426-a679-ee581b5c728c@acm.org>
Date: Thu, 31 Oct 2024 13:55:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] block: share more code for bio addition helpers
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730037261.git.leon@kernel.org>
 <e6be9d87a3ca1a2f9c27bce73fbab559c21c765f.1730037261.git.leon@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e6be9d87a3ca1a2f9c27bce73fbab559c21c765f.1730037261.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_135544_993056_71531FA4 
X-CRM114-Status: GOOD (  12.34  )
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

On 10/27/24 7:21 AM, Leon Romanovsky wrote:
> +static int bio_add_zone_append_page_int(struct bio *bio, struct page *page,
> +		unsigned int len, unsigned int offset, bool *same_page)
> +{
> +	struct block_device *bdev = bio->bi_bdev;
> +
> +	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
> +		return 0;
> +	if (WARN_ON_ONCE(!bdev_is_zoned(bdev)))
> +		return 0;
> +	return bio_add_hw_page(bdev_get_queue(bdev), bio, page, len, offset,
> +			bdev_max_zone_append_sectors(bdev), same_page);
> +}

Does "_int" stand for "_internal"? If so, please consider changing it
into "_impl". I think that will prevent that anyone confuses this suffix
with the "int" data type.

Thanks,

Bart.

