Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D760C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aLIY6u7/8wOXZ0gklFVuNCYxDFk1pF4PhKr3e7ykIDo=; b=QtfHD5bBDn9Izv0vRTAgfVrdwQ
	jChK0TU1exZJ/H2w+g+BnxEv7dadO9B0NDVHYsUTz9noUl+fKZhYriYXWYQgw+PcUkCyfBu+JGrLH
	jjqPtzKDpQMInMal78ksHZaJCyXa0W8aZsb6Wf6QpsfkJBEYJr/BTlYEVsY14TaIhanp901CrfmKY
	5w6R+vTy0QG5GCGK4pPbk+sCn2L1VW1E6pzDT51QXuo+cp4mcmzu299JbLWHn5jJMj37RLzssbPWY
	ZpITLo83ZGYJIlKUHGg7dnAreaM9Betl3V1tmsejvcAkBrbjNFrNu/75PircyaDfeTnigZY7OAric
	vgRc7tpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHnyv-0000000HTSO-2A6m;
	Thu, 13 Jun 2024 17:11:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHnyr-0000000HTRY-16U9
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 17:11:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CA8868BEB; Thu, 13 Jun 2024 19:11:15 +0200 (CEST)
Date: Thu, 13 Jun 2024 19:11:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: Re: [PATCHv3] nvme: fix namespace removal list
Message-ID: <20240613171115.GA30686@lst.de>
References: <20240613164246.75205-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613164246.75205-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_101121_476868_F3140092 
X-CRM114-Status: GOOD (  14.55  )
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

On Thu, Jun 13, 2024 at 09:42:46AM -0700, Keith Busch wrote:
> It would be neat to have a more elegant helper that we've been messing
> with, and be able to use a single srcu synchronize, but in the interest
> of time, this patch will fix the regression.
> 
> I was hoping to not have per-ns srcu sync's, but this path pretty
> much only gets called on the last namespace anyway, so it should
> functionally work out to be a single sync without to optimizations.

Yeah, compared to the 2-3 synchronize_srcu calls in nvme_ns_remove
one more probably doesn't matter right now..

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


