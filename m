Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2255DCDE026
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t1pqA5vZnOv5Ob2tHvv/L6YvIitIsENj/KjxMLGGYpA=; b=C80uFMvlknT4J7JWuNaSRVedFK
	dTJzZLpBXYaKHb8J1Yob5I1wIkbpT/JDpaRHYNN/Ju00gF1OI+eL0nHKukNhdK/LG1ECpzawGtRJ7
	GDXAWxjTgpa2HIA7TOzNwIalyJL7XhXdvLJOIL8Ms+QuHzAuSNDATeYFzpnMMUmGbdIBz+RYSBOAh
	PlylE1oPPSk0EL5OiVi5GoA2U74TUHbNAF6xD4LgUOw/y2vIR6bv765MkPvW7zQOkmsOZxGr+SSfQ
	eSlLZPoIr75Nyl1OI/w33DdRKrSpLBjR1LJa0LZzDYmmma0Ctr/A1vdoyAbOkgfJ1M+IS7UwQiUc7
	onZE67YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJowN-0000000BnEj-3SFi;
	Fri, 14 Nov 2025 08:13:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJowK-0000000BnEN-2mMu
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 08:13:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4282D416D9;
	Fri, 14 Nov 2025 08:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D86FC113D0;
	Fri, 14 Nov 2025 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763108030;
	bh=P0FgX3vUN9KZb40lNaLzQGkELt39BZYMmApmf8qsUKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUjPqlYCj8le/ZIID0iCiUcPg3CnQw0wcsFTZ+qK9ck+cMIm9r++W0UW1KeEsPSTl
	 WJguODf8qwDn2XNi0Ia35XwCXxBJM2pjKr0WzY2X2Ymhk1xUHmZ6FU5Co5uVUwnIcn
	 hxWjIuXr2OI9y7/fSfgEZMSd78aCMvDarXeZ5duknv3COWwqUWu3jhHNvmJOJrEJc7
	 wZPjzzw+jagijJcSD9v08HIxZA2IzMqkIbfU/yZls6KehYNUGNc5RoHW4BmLafcMjN
	 4324ZZKwTy59OzVOlUmvcvpDFCI9nQT1DfmV3hZ6vpwRJHLZpOF/JT3frib2oYH7GG
	 ZvG6WOjUN9DtA==
Date: Fri, 14 Nov 2025 10:13:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <20251114081344.GA147495@unreal>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal>
 <569825cd-c98f-4399-ad25-d4e62fba4255@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569825cd-c98f-4399-ad25-d4e62fba4255@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_001352_744128_7446C2F3 
X-CRM114-Status: GOOD (  29.65  )
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

On Thu, Nov 13, 2025 at 01:43:09PM -0700, Jens Axboe wrote:
> On 11/13/25 12:50 PM, Leon Romanovsky wrote:
> > On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
> >> On 11/13/25 10:12 AM, Jens Axboe wrote:
> >>> On 11/13/25 9:39 AM, Jens Axboe wrote:
> >>>>
> >>>> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
> >>>>> Changelog:
> >>>>> v4:
> >>>>>  * Changed double "if" to be "else if".
> >>>>>  * Added missed PCI_P2PDMA_MAP_NONE case.
> >>>>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
> >>>>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
> >>>>>  * Removed REQ_P2PDMA flag from block layer.
> >>>>>  * Simplified map_phys conversion patch.
> >>>>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
> >>>>>  * Added Chirstoph's Reviewed-by tag for first patch.
> >>>>>  * Squashed patches
> >>>>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
> >>>>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
> >>>>>  * Reordered patches.
> >>>>>  * Dropped patch which tried to unify unmap flow.
> >>>>>  * Set MMIO flag separately for data and integrity payloads.
> >>>>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Applied, thanks!
> >>>>
> >>>> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
> >>>>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
> >>>> [2/2] block-dma: properly take MMIO path
> >>>>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb
> >>>
> >>> And now dropped again - this doesn't boot on neither my big test box
> >>> with 33 nvme drives, nor even on my local test vm. Two different archs,
> >>> and very different setups. Which begs the question, how on earth was
> >>> this tested, if it doesn't boot on anything I have here?!
> >>
> >> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
> >> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
> >> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
> >> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
> >> be a fatal error. And secondly, this just further backs up that there's
> >> ZERO testing done on this patchset at all. WTF?
> >>
> >> FWIW, the below makes it boot just fine, as expected, as a default zero
> >> filled iter then matches the UNKNOWN case.
> >>
> >>
> >> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> >> index e5ca8301bb8b..4cce69226773 100644
> >> --- a/drivers/nvme/host/pci.c
> >> +++ b/drivers/nvme/host/pci.c
> >> @@ -1087,6 +1087,7 @@ static blk_status_t nvme_map_data(struct request *req)
> >>  	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> >>  		iod->flags |= IOD_DATA_MMIO;
> >>  		break;
> >> +	case PCI_P2PDMA_MAP_UNKNOWN:
> >>  	case PCI_P2PDMA_MAP_NONE:
> >>  		break;
> >>  	default:
> >> @@ -1122,6 +1123,7 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
> >>  	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> >>  		iod->flags |= IOD_META_MMIO;
> >>  		break;
> >> +	case PCI_P2PDMA_MAP_UNKNOWN:
> >>  	case PCI_P2PDMA_MAP_NONE:
> >>  		break;
> >>  	default:
> > 
> > Sorry for troubles.
> > 
> > Can you please squash this fixup instead?
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index 98554929507a..807048644f2e 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -172,6 +172,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
> >  
> >         memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
> >         iter->status = BLK_STS_OK;
> > +       iter->p2pdma.map = PCI_P2PDMA_MAP_NONE;
> >  
> >         /*
> >          * Grab the first segment ASAP because we'll need it to check for P2P
> 
> Please send out a v5, and then also base it on the current tree. I had
> to hand apply one hunk on v4 because it didn't apply directly. Because
> another patch from 9 days ago modified it.

Thanks, will do.

