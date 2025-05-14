Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E897EC3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 05:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wsyGg83p/WGq2FUII0mFN184PPrTSq4gJCpXHFmHDC4=; b=V3bQ+0MVTuZIr8jrbEk40249ap
	/QTSUGvimludap74JrID6YznIBHL0Nhtrx5qKG2hpap+PB6yEMNlWoAn9vlKvialAvmT2cb4RLaVK
	GOhISs+1IjRyAr5CHtIklqYZ4PIcAe2XNRSW4UanRMBpB8VXi4qI63PCGcrAdMyTfW65jH65Qh2ka
	Ay4ktWOkPvOhfqJ6oURrqT0zWLznvt/cc4aA84IGjdOmrfMuC55HupMMs+6QO/G0+rPgSGATWjcAG
	o4FnFKoHkfyMQYo0K0W+xZSryy44RDqNTMHPitHATBvzfvIkRIEa1JwCIvkXLLVElfw26pjnhKAJT
	OVRFWmhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4Ps-0000000E3gM-3xVZ;
	Wed, 14 May 2025 05:12:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4Pq-0000000E3fw-2DDY
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 05:12:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82A7568C4E; Wed, 14 May 2025 07:12:21 +0200 (CEST)
Date: Wed, 14 May 2025 07:12:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool
 allocations
Message-ID: <20250514051221.GD24101@lst.de>
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-6-hch@lst.de> <aCNf_rHaLdS-WTEO@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCNf_rHaLdS-WTEO@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_221226_706451_48869D1F 
X-CRM114-Status: GOOD (  15.61  )
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

On Tue, May 13, 2025 at 09:06:38AM -0600, Keith Busch wrote:
> >  		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
> >  			__le64 *old_prp_list = prp_list;
> > -			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
> > +
> > +			prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod),
> > +					GFP_ATOMIC, &prp_dma);
> 
> You could assume nvmeq->descriptor_pools.large here. We'd never use the
> small pool if we've enough elements to chain lists, and it would skip
> the extra condition branch on each loop.

Yeah, I'll fix it up.

Something only vaguely related:  do you remember why the metadata SGL
descriptors are limited to just the small pool?  It would be nice
to support as many metadata as data entries, which we'd almost get
by using the larger one (we'd still be one off).


