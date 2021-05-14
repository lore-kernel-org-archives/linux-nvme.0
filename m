Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EAEC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 14:00:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAE161460
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 14:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAE161460
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4wIkJ4hIIiAIkrx8Kzqjlofl27Qrgxen7O9eYQfkSN4=; b=fDOcHnOcUUSz2qhYM3V0Mz2Yi
	cfiCJt9yeHYpH8tW0tAyaPUOqq11qk9PTpoi5z0Z7cpcY796FIuD4ByPU+P0HXLB4h7SBAbODU20v
	dxyiQxPn35LzeTkwXvxB7QS/an+bhK+xhGbaKnl8BgeBUq5ksuWvD71Rg+b4/sNiNVwvliH+EQWTy
	bPcIhVqF4STxr87HA8tQigFepEEo5qgybP2brnS3wEBZQLACkiF5DXWPeXT2+j6u6A1U9oEht1S2y
	0Tq1H9F4yCrx6Z3n54UI8LIZLKACqgZIf1w0wlKZlFczqns44kdUpk4mtKzcgyKAGIHj7iFMXILat
	MnkTqPWFQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhYMU-008DhZ-3a; Fri, 14 May 2021 14:00:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYMQ-008DhO-Uy
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 14:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wLmrD4x6IUN+aoDiPycBpC8PZ5eCuzXdu65Uq8kcVAI=; b=Aa/Jb6OknHbM2i1BPz9GoRiIfZ
 SOhHNWaeEeP9iQJk9+RJMYRIJVE/o1MFXTEdx5GVV6GjQLAZekKog6OjOY9+nQt5eFxnnO7QHnQ9I
 9lHCeqsAuDxWPI87f/CpDmyefbc17tOxjYMUCne549Y7IxAE7alyR8G8mJ/TnlyqRG4iYAWu5UdZw
 C5uw0DcOitbsq9pFbJ2CPKrf+wqB52O0xIzEX3yn6r1jYJohYk5q8jXw+yvzsgAzSpq1AIxOKp73x
 SzFgGMtDQIhHKCz112FvzRUd6GwSyeQkYw6fPSPmbLlIaCxN5Tc3X06nLtL/W0/XgKYKj/ZlcAuZz
 fNYnn4Xw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYMO-00C1P0-FG
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 14:00:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 062446736F; Fri, 14 May 2021 16:00:08 +0200 (CEST)
Date: Fri, 14 May 2021 16:00:07 +0200
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
Subject: Re: [PATCH v2 00/22] Add new DMA mapping operation for P2PDMA
Message-ID: <20210514140007.GE4715@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_070012_664127_611C29C1 
X-CRM114-Status: GOOD (  11.74  )
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

On Thu, May 13, 2021 at 04:31:41PM -0600, Logan Gunthorpe wrote:
>  17 files changed, 570 insertions(+), 290 deletions(-)

I'm a little worried about all this extra code for no new functionality
at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
