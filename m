Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44828C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:34:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A996561153
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A996561153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=69zmC+VDFl9JR6OF/iqW/tnK0DysI9GrcVyGyFEiL7I=; b=FWG2kvfKOdqiduAYj6+BLDAPo
	D7g2PKeU8hPRBRDFGrb8gfFSBbq8eLI1JASoLSTJRhw1ybv+OzgSybPoHekCxBRB0H/GO2Y1WA0ZH
	7ZARN/dSDsHOLGRcX5q5ZIbyRTnVBMFuBiVwCTC2jTlooAGwHKeU9Dkiu1MT5omMOhNyE24NFsDbI
	w9LDp8rYxHAcXrdSzTJMi9Xp3bvFGq5rohQqZgDJ3mBdoP1dI/mG2fd3YI5dYHhPbz71CusSR9pno
	98lJtp6rKq4ENxog5hPCgTy18ZV+SigGMDCiPQkTNTDzaXxiKi5LhV2B9/BLS/TeAw+tSod9xBEFy
	fyAn9JMBQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbTT5-0027n5-79; Tue, 27 Apr 2021 19:33:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTT4-0027mx-3i
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 19:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=R+F2zOJdoXavuDhUMY1QiZp/NrhfLweB0na9Qyx1V6M=; b=1n0huVuj7CHpF2vDA77jlL8ORA
 c/bUVo67dgdk6P8PuiG5iQwseM1x++iW+vRc36rKHmCun6lTFwkJNTQIIDNq775pEK3ejokEJ9Esy
 VpZPlrORtkzuyyJlLqNsjqSkwAadvpHZj3/I+7FprvE7lwWhHCWEK2Y+xsuCPixIe8zmPTEoMtijk
 vwcecGbtMYu3Fz2a0pM0mnhWpvaBA1Kve35+54vWUHs7iSR171XWW1XCnAmti0lLLNEH+MCa28neY
 HJj2vN5CqdYeIB//gKJ0+wZbwqdRXa3jL66LZ3BDVMdU7oVNEKTl8ceQpku3/EasDMNtHl78PvVaT
 OBrM0JuA==;
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTT1-00GweJ-AW
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 19:33:56 +0000
Received: by mail-pl1-x62d.google.com with SMTP id o16so17856008plg.5
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R+F2zOJdoXavuDhUMY1QiZp/NrhfLweB0na9Qyx1V6M=;
 b=TJz59G9wTmQQcbNbRY6OLyN78TksPOrBEHchyw0NBoPqX7sH+F3GGV9C/CfZW1h60M
 za+EgCvhm5j94fG3EFrSszh3F9AtXSEv6o4v4pzjNzSIPeAEJTXAJgDlK3w7dIOwvVl3
 GDz/9VRq+nxGIFibJgIM4ZDwttw1bZanScMikT8vBhr3hHdh3+D1AMW+87r/3r/WeSeL
 mFN1NYGu0fU/BHLpJfQ111ayxh2eOXs3wIHf4Gc1C7LSKzpmBZACVlSiQZcSoeU7Fukr
 d9IJK8EwTF9bbg0KdJNjSvCfq8EatvIhTdt5V794cL+MA6LlTikeW2O5j+OCr1c9eKX8
 S8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R+F2zOJdoXavuDhUMY1QiZp/NrhfLweB0na9Qyx1V6M=;
 b=taIdKqw7jkgtTMbkegIiD0i4sGD1g4RpER5lH7nknnsSexG5Q7kaOwsTOeF6LrZgIl
 77ixaEKfmsLnupvFCI4mZ9VBejzWW05OOr1WEIakW53D0YpMrMR39Lr4cM9qFnuMlp+/
 GMiWxlwcvwKIvEyMZ8LqTivEX/q0t0DGxWLRXUdHuRXPJA38+6TI1ctfRyLGvPZ6AqqR
 3uch+bvVZ68KMLtCrCS/k8q7TXRHnMX7QYkt9SMNpWhIyYqYsiJ468SotF0siySENvuy
 1hwABG06SPg93BOCRbqBUdAdHnzlIFRHP1UNCCEN0U69voUJRtH+j8lmTo/hoBAUVeZv
 0YNQ==
X-Gm-Message-State: AOAM530G95BIAYA2Jg8m+xERcaUkxcuQwe6qb65h9quYzdk3yFrkmDBY
 iTQnYDiHUs6nhV4uTFTDsXa9xwKpHcXjvlEG
X-Google-Smtp-Source: ABdhPJwz3MILTFTzWsw6JFNbmAnxbzNG2cgSRXVHlPFwKXyKDZuqS3fiLINQaBtKfebJ6/AT25pPWg==
X-Received: by 2002:a17:902:8a8a:b029:ec:857a:4d51 with SMTP id
 p10-20020a1709028a8ab02900ec857a4d51mr25612392plo.68.1619552034009; 
 Tue, 27 Apr 2021 12:33:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id o5sm460461pgq.58.2021.04.27.12.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:33:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTSx-00Dgwh-Mo; Tue, 27 Apr 2021 16:33:51 -0300
Date: Tue, 27 Apr 2021 16:33:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
Message-ID: <20210427193351.GR2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-10-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_123355_385326_05B1059F 
X-CRM114-Status: GOOD (  16.64  )
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

On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 002268262c9a..108dfb4ecbd5 100644
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>  #include "direct.h"
>  
>  /*
> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  	struct scatterlist *sg;
>  	int i;
>  
> -	for_each_sg(sgl, sg, nents, i)
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_pci_p2pdma(sg)) {
> +			sg_unmark_pci_p2pdma(sg);

This doesn't seem nice, the DMA layer should only alter the DMA
portion of the SG, not the other portions. Is it necessary?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
