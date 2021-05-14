Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B986AC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 13:51:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C6061132
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 13:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C6061132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v+81l8jysO5E+wVNGUajyCLTnyhSPrrQHWzz1eYWZEY=; b=KC1+F4ct/FAJuRBUOYvHO8pJ7
	OITxOErc+7HGS5/vdEwQWauwJt4LfhCEcRa7pe5F1Dhr4hQBHxXSetuuY8LDy21DktDdkNRWTUc0Q
	A3g0TVroCSu8fxZjdWePaLLq19mW0g5KnArc6pbPJE4ceVS3TyKJywG8A2SZxsrOICZreTBCFpC/z
	jqwbng6d4iXhOGMpY1P1rZqztzQ992SNbvuNB0Uemymfq2cbOvW99UkC1ZNTFSTr/0QobTVdrxWAB
	nH5/IKhiNNGmlD7C93cg97Ig6mmg5PX7Dx2aA0YJMB8GDhm4PsGg36pZobALXDy6mJSynDrMi89Zk
	xxUdQHgMg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhYE2-008CXn-8B; Fri, 14 May 2021 13:51:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYE0-008CXX-5c
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 13:51:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hft/toSWDBmRgmUey65z0TkNis0F4nNkU44LMc/hi9c=; b=Mevb8rRc7M+BDQaEvkUEICsljN
 EkU2IXq+G6K007vuBW48cBuUHQ2RXI4NsnTV279iFmtgjdR5cX4BqBiN0JN7281849TU7wcAEar3A
 pEnJtUPaoyBBKtZDMdfkIXpPbuiIy84hSfHJM2mCCFLjhEecAXKtQvc29TNQORIrCcULt49+nnlAR
 7q2kz7WEKMTnZm3KcfDyLkXYy2ijIstbyqNH+EgDsmLhYj3U32YZv4LM+oliEFAltWpvp32LwHl8o
 0XqeAI+mGGJSRCn/HUWsZz8k35tftZXawagbeTbNFH2dL83dH1PJ+M6Q8kIJMFZOfj69RaVSN85KK
 +kmnd3vw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYDx-00C10v-Mn
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 13:51:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2C7076736F; Fri, 14 May 2021 15:51:26 +0200 (CEST)
Date: Fri, 14 May 2021 15:51:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v2 08/22] dma-mapping: Allow map_sg() ops to return
 negative error codes
Message-ID: <20210514135126.GB4715@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513223203.5542-9-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_065129_896744_092935CD 
X-CRM114-Status: UNSURE (   9.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>  		enum dma_data_direction dir, unsigned long attrs);

I don't think it makes sense to expose this __dma_map_sg_attrs helper.
Just keep it static and move the sgtable helper to kernel/dma/mapping.c
as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
