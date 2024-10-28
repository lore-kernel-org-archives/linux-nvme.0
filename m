Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3100D339B2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8p+XeF371FBdizlYdFFfI+9cvX4PxDYJkCjxcGvOnbA=; b=ko8xu3GzWITBi/
	n9dmrYFvNpVId1AVGx4uEIW47Fw60CUUEZC4wL0PO1OdUZd9yzFqyqhqcgzCOK+tY+XmUptn+5AUw
	+X6EKgztU8VPJyXY9PwsZOID/kbX/HEre3EnrWGjtMiQ7kKzmU0iQeSOLY+9O6TSQ9KeMCFfT+1uT
	iA99CSlTP9j3onlbM3rVAEU3LSTQcWKO9kBYLgpM+NL5YAjnDkbVH7WHuS40m17Fki2uloPCWr54J
	/ZLNKe4w2iYmUfjvUchQKRMkUhUIzYKq5MagCtR9mRtRqbfHwNgVGtAbDkrkYTuX52rUe+xw4EhO/
	rCLiFfk/bLHM5lhdf9Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UGL-0000000BmJC-3T4P;
	Mon, 28 Oct 2024 18:14:45 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UDH-0000000BlU5-3YeI
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 18:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=8p+XeF371FBdizlYdFFfI+9cvX4PxDYJkCjxcGvOnbA=; b=ZgpvCfWocWsIQTbiuMoGgvu81j
	S/fCHcyzInt5f0gPKd+LIK7OJ5mxEaoNwY3if96O+eQaCdejZ8p5V3sgl/v9nalWlDJO5DRXi/kIn
	wvHhSbq4aAwqMIMsOMusADIniYrFBNpOPovhNcwteIj9k4BUkv8XY28rtPNRm9woscrRzWxlXqEZb
	x/tnpblDzlq9tceUkjNsArDEQcZsmuRZZSVXzOBFycNxqU3EB7/U9E1zPZg62v7QNAB9eXmVwn9dD
	fGPW5l7LzLYo6jMaIh+Joy5PZ/qKbf8+LukxoA/IHSVyQYhrFtbPf9diRx5yqeRINUUkSejoMIZIj
	4p2sRADA==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1t5UCo-002ZVS-20;
	Mon, 28 Oct 2024 12:11:07 -0600
Message-ID: <31cae8da-74fa-4a45-a88f-ad76572246d4@deltatee.com>
Date: Mon, 28 Oct 2024 12:10:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yishai Hadas <yishaih@nvidia.com>,
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
References: <cover.1730037276.git.leon@kernel.org>
 <a4d93ca45f7ad09105a1cf347e6b6d6b6fb7e303.1730037276.git.leon@kernel.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <a4d93ca45f7ad09105a1cf347e6b6d6b6fb7e303.1730037276.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: leon@kernel.org, axboe@kernel.dk, jgg@ziepe.ca, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, bhelgaas@google.com, yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com, alex.williamson@redhat.com, m.szyprowski@samsung.com, jglisse@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux.dev, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 01/18] PCI/P2PDMA: refactor the p2pdma mapping helpers
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_111135_972762_EA0E4351 
X-CRM114-Status: GOOD (  16.34  )
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



On 2024-10-27 08:21, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The current scheme with a single helper to determine the P2P status
> and map a scatterlist segment force users to always use the map_sg
> helper to DMA map, which we're trying to get away from because they
> are very cache inefficient.
> 
> Refactor the code so that there is a single helper that checks the P2P
> state for a page, including the result that it is not a P2P page to
> simplify the callers, and a second one to perform the address translation
> for a bus mapped P2P transfer that does not depend on the scatterlist
> structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Looks good to me. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

