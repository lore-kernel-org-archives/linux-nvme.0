Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23DC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:16:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D03D61182
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D03D61182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bDCKshSs3dOE+HQO6XMZu7oyJDazLySBfJPYqTYkUOQ=; b=ItvnB8ruzCZ0lX6fBSWgSDf3x
	DsfrQKfFbbsWpmBPETLqaW2LEhjC188VsGCYyLB8vgZ8KMZyEBj9woWwUEkgDqYS3DHPysmPvELqO
	4AFtXpHHNrptz6STC5l84ZP6Bj34fY78kswCJR0rQwOtMldEBGDjsJgV1hC3DeqCFaws2z2d9owqO
	GRJcbkb6bT3BBpBcvILTL2LkMJsBbZKhq2o8ohgh8vaD/O08+j7OwRZISn0rUNPvVjt+K0F2YHG00
	pxJ/6ZXdFavQ14857pTs1Zj1+UuEq7m0ZeS4oS1NMFCX3Kv2ms0xSzTWNBEgmneIDENlBK+68++xC
	hMr4AEkzg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhaU1-008SQ6-Vx; Fri, 14 May 2021 16:16:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhaTm-008SPt-Ti
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 16:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=8mPdRqweUyDLPmZFuViN51lMyyF6RcsMDP/27vYhzgo=; b=yinyUEVPrGek7FMnmJNK1j0C5Y
 uEIWuGdpcalGv5VRc7g6OYp2GjgfP9oPmpT4eRLdMgUgmLfU9niZHKflDdPFFm9j6fGxl6SzYWT7N
 iNxDvL2GfyU7xZ1TRcZ2ZpRCXZrzZWDNLa71JBli5fcf0zEouH0GffXxncKy/jaN1aPD34fldxYMe
 /hsX63V3FokW/jcXPigWQXxLbo55ry4MpY+DjOKag5Pg6PNYf/0EcQ9Fn1Tw8s5FUV8KoKMthF5/c
 grZfcM69dvdtltgoe3czW9Sgo6k0uiGWXV22tkLCzPBQ6p05HBJqsZJfw6GtRIPqkDc2joMcUOu45
 Q6xatkMg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhaTk-00C6Yy-1O
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 16:15:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=8mPdRqweUyDLPmZFuViN51lMyyF6RcsMDP/27vYhzgo=; b=U+OPhYGBE7d5nwlGLwZsALzoro
 3tgyDKF/0JnvDnEhiVty+7KLtudPXGsgdLrXK8kYa1UhRxLVYx5DTHvguR2b2SxqVbUGMOinTz5RG
 MaiKBrvV+aFk8n5JKHIpqq0/+O13MOf6raVLj/ytmq6kFn5OoOGeKnMdZV7srdp5EypPDRzRNnvDt
 Xcx+TrldLjB0CdBFWcHNA4i8QC6d1CT/44a9DZFyyrmkyCerhqDEyUgv2VGtTRFpKTv3RSlewLnZy
 ZjgSDqhOMfyPwZfy59y4RAtucHTLNIX3hzhpPDgPTeL+UzDpvLPANK7ryKC925sZWizH3oNMMS0fQ
 rpj+1uKw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lhaTO-00065v-3k; Fri, 14 May 2021 10:15:35 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-7-logang@deltatee.com> <20210514134900.GA4715@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e1407362-26fe-09db-0964-acfbb45c032c@deltatee.com>
Date: Fri, 14 May 2021 10:15:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514134900.GA4715@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 06/22] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_091556_099786_04D2B14C 
X-CRM114-Status: GOOD (  16.87  )
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



On 2021-05-14 7:49 a.m., Christoph Hellwig wrote:
> On Thu, May 13, 2021 at 04:31:47PM -0600, Logan Gunthorpe wrote:
>> Attempt to find the mapping type for P2PDMA pages on the first
>> DMA map attempt if it has not been done ahead of time.
>>
>> Previously, the mapping type was expected to be calculated ahead of
>> time, but if pages are to come from userspace then there's no
>> way to ensure the path was checked ahead of time.
>>
>> With this change it's no longer invalid to call pci_p2pdma_map_sg()
>> before the mapping type is calculated so drop the WARN_ON when that
>> is the case.
> 
> Why?

Before this change, the if the mapping type wasn't already calculated
pci_p2pdma_map_sg() would just fail. This was fine for NVMe-of as it
always called pci_p2pdma_distance() ahead of time which calculated the
mapping type, stored it in the xarray and did not proceed if the two
devices could not talk to each other.

This patch makes it so if the mapping type is not already calculated at
dma map time, it does the calculation. This means the dma map operation
can fail if the two devices aren't able to talk to each other.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
