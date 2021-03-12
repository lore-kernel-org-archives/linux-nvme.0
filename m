Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B98FC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 16:19:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA8A64F80
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 16:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA8A64F80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yOCkpu5+VtAcNRr1e+SUK3qQcmnS1WfWgr0CF5VwaPI=; b=qGdj/m4BxxYZoxMiKjcg1Lf1V
	xmuBNeFDjpKcvK3Tj/oBYO8fOE5SVlh1MzmKTEyv3HaPNyh9gS30bl+G6L5X2mp9SeS9juGJXIB3f
	bfLYMQACghI5fGYF024UgeJs0S7EZQgfRg91oPkVsGKod53fOsgnM90WvaGKxxW/RN4yYo2/Xnhiv
	t18v3xzqwf7cTWzbw7MMH+YBNMVtDA+/mm4d8PvdvFPPzYt+110u8ZTj74KgPERhQGcpiDVS9oqmg
	AmC5vgVXnhHMmtTPkstP+vYh9NO8FhSq92vBbuhgIn7ub1gKjPtvkLz5IgNJUGR4QKxVcxCwUye5j
	QkniwiF0A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKkVW-00BvZB-3w; Fri, 12 Mar 2021 16:19:22 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKkVK-00BvW2-KN
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 16:19:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=I89VDuZejubSyokWT+qiAjRrhT4T4AjRHHyD/4UUauw=; b=YWISg10aSxm+jQaX+X6OhfxFPO
 wP4pNsP9huRyLmE2n03E4hyIpdRH1yQeyJ+V9wg1wgsxjmVmS1xL+gBAk6XsaxpB+l0aIYU98JxQZ
 ciEEug4Y5ay/LYN0UyHg/bEyINwquKoUxnSPKQlqr1ajywPFKVP1ujdzy7/srZYnjWdTlz12JRzIw
 pI3U2FUOw+RIbjwTV9CMHkfRjKlk6ew/bqxHeIk3ZfYxJ+T4OZozC6OE16gN7hqtn6YLwyH0xRZPH
 86uvVT4Ir+w62abwFg8otMV5BX+4owBFgtQVj4Uu2xHzYQCNGi5/KyJe8bEhgCWqEgHXOqoB1UiVm
 ehwWevcw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKkV1-00079p-IQ; Fri, 12 Mar 2021 09:18:52 -0700
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates
 <sbates@raithlin.com>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c66d247e-5da9-4866-8e6b-ee2ec4bc03d5@deltatee.com>
Date: Fri, 12 Mar 2021 09:18:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, hch@lst.de,
 andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com,
 daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca,
 christian.koenig@amd.com, willy@infradead.org, iweiny@intel.com,
 dave.hansen@linux.intel.com, jhubbard@nvidia.com, dave.b.minturn@intel.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_161913_955224_AF548B29 
X-CRM114-Status: GOOD (  23.93  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021-03-12 8:51 a.m., Robin Murphy wrote:
> On 2021-03-11 23:31, Logan Gunthorpe wrote:
>> Hi,
>>
>> This is a rework of the first half of my RFC for doing P2PDMA in
>> userspace
>> with O_DIRECT[1].
>>
>> The largest issue with that series was the gross way of flagging P2PDMA
>> SGL segments. This RFC proposes a different approach, (suggested by
>> Dan Williams[2]) which uses the third bit in the page_link field of the
>> SGL.
>>
>> This approach is a lot less hacky but comes at the cost of adding a
>> CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
>> scarce bit in the page_link. For our purposes, a 64BIT restriction is
>> acceptable but it's not clear if this is ok for all usecases hoping
>> to make use of P2PDMA.
>>
>> Matthew Wilcox has already suggested (off-list) that this is the wrong
>> approach, preferring a new dma mapping operation and an SGL
>> replacement. I
>> don't disagree that something along those lines would be a better long
>> term solution, but it involves overcoming a lot of challenges to get
>> there. Creating a new mapping operation still means adding support to
>> more
>> than 25 dma_map_ops implementations (many of which are on obscure
>> architectures) or creating a redundant path to fallback with dma_map_sg()
>> for every driver that uses the new operation. This RFC is an approach
>> that doesn't require overcoming these blocks.
> 
> I don't really follow that argument - you're only adding support to two
> implementations with the awkward flag, so why would using a dedicated
> operation instead be any different? Whatever callers need to do if
> dma_pci_p2pdma_supported() says no, they could equally do if
> dma_map_p2p_sg() (or whatever) returns -ENXIO, no?

The thing is if the dma_map_sg doesn't support P2PDMA then P2PDMA
transactions cannot be done, but regular transactions can still go
through as they always did.

But replacing dma_map_sg() with dma_map_new() affects all operations,
P2PDMA or otherwise. If dma_map_new() isn't supported it can't simply
not support P2PDMA; it has to maintain a fallback path to dma_map_sg().
Given that the inputs and outputs for dma_map_new() will be completely
different data structures this will be quite a lot of similar paths
required in the driver. (ie mapping a bvec to the input struct and the
output struct to hardware requirements) If a bug crops up in the old
dma_map_sg(), developers might not notice it for some time seeing it
won't be used on the most popular architectures.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
