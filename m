Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AFFD339B3
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PVgGO8I+aKJHmvYCR04uOsA3HSUhN0BC0EboYMzK8as=; b=oAYL0pV11BFXb4
	oeqGawDA1ffc0uwFsVoi6/ELTAbKjNydU+CHtIAi/lrL7RpVGLg0kMkKhZ+c9uxbM2GNROwzrXwT7
	aogrOE9tKK8FHr/dDGDaQWZalm3tSQ6kbbC3w+D1IvF9pgt5cKDMerBgjKYTct/sUhkzjUsKWeIvZ
	VnbLK1j2Qafeu0+pkTHosVA0Y+AdqSjAqodXdUcOaPKXLmtRR1WtxhV6ZLT2WIDLl60SfQoMFhXvB
	YzQ9Rpn1jO4GNqFn+sqSoTyKprrDaVLQ+RJhNHMSORkrbh46SqO/ay4yfT/GOv4Es2C4xO7iqL0VA
	jrwNmeqGfW1ZVYUO2ZGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UGO-0000000BmKS-03A1;
	Mon, 28 Oct 2024 18:14:48 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UET-0000000BlrY-2RL8
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 18:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=PVgGO8I+aKJHmvYCR04uOsA3HSUhN0BC0EboYMzK8as=; b=K19VSXkL0jbE9wKlLQwlzKl5Qt
	dFI8msaT1mELaj5hwKIwDlCJ46EwcaMmEobLfzfEKq+Eq7nTnteRjLb92tlfPf+mQ1jHZs/uau/Zv
	btPElz6z7lxamWA9dafk7bpsCpOHuPE5ytvXdPKxSvkskCQz9G9p+Cd3hVlToTbBzJvAgoSIlT37A
	r+ZWM2l+KvYFm7d2b43t3ljFpzoofdPK8h6WvgnWHW7sU/zCs1CIEnQebX78Y3u5+eOJI3mrSnt5j
	dSSu52KwvY+eSIGe4RXd3JdoU0j37bdCROcQ7YHpM0slV0+MpM5Xaz7qZFasLUl12Cvd6Oj0uBW7u
	ffpSvEzg==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1t5UEF-002ZWw-0E;
	Mon, 28 Oct 2024 12:12:35 -0600
Message-ID: <30e87c78-1021-4fa4-8aa6-e81245e77379@deltatee.com>
Date: Mon, 28 Oct 2024 12:12:34 -0600
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
 <f7ee023a7497ad3d8a7a31b12f492339d155ac39.1730037276.git.leon@kernel.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <f7ee023a7497ad3d8a7a31b12f492339d155ac39.1730037276.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: leon@kernel.org, axboe@kernel.dk, jgg@ziepe.ca, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, bhelgaas@google.com, yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com, alex.williamson@redhat.com, m.szyprowski@samsung.com, jglisse@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux.dev, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 09/18] docs: core-api: document the IOVA-based API
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_111249_657898_02C7D34E 
X-CRM114-Status: GOOD (  11.06  )
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


I noticed a couple of typos below:

On 2024-10-27 08:21, Leon Romanovsky wrote:

> +Part Ie - IOVA-based DMA mappings
> +---------------------------------
> +
> +These APIs allow a very efficient mapping when using an IOMMU.  They are an
> +optional path that requires extra code and are only recommended for drivers
> +where DMA mapping performance, or the space usage for storing the dma addresses

The second 'dma' should be capitalized as it is in other uses.


> +    int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
> +		size_t offset, size_t size, int ret);
> +
> +Must called to sync the IOMMU page tables for IOVA-range mapped by one or
> +more calls to ``dma_iova_link()``.

"Must be called" instead of "Must called"

Thanks,

Logan

