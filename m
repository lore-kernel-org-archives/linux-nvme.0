Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9DDC87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xj9S0iTULGKGdfy5WztAdaFNmwCQcU/Zo6ywJFcafF8=; b=t7l1A6WGt9aWcRNBTPCf9xTOiD
	V1q4xH+yU09ut/A00lHsOkrH25uP3w3qdJ3Jr2ROJpAF33TDiLg9ab1r0ncD3oWijAkZ9u+dVaCkt
	h7Go4FKu4UV/ZKr6uvGsf4UAoe/z2/w4bswxOXpw3PSKYdSgl1AwpLOvRzFqggSdjx3MWZoq56Rwd
	xmSBbWyuI/L1vepf0Wo0JgoVTKZ8FL8lVcUUYKG75LpoSW4kIVIRUI16lXjFRZM5hNiJ5yG1cL21y
	47zpkce4Sz9ArtF0+jtodcfbjDkcIxJ0z8ya9S8/PjkCaBGtfbvEr1oyVbIFdR889ltWXOZ1DzNzE
	xTJal2Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh7dk-00000001iYz-0VbZ;
	Wed, 30 Jul 2025 14:18:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh7SJ-00000001h0g-3uDH
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 14:06:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D08468B05; Wed, 30 Jul 2025 16:06:39 +0200 (CEST)
Date: Wed, 30 Jul 2025 16:06:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, hare@kernel.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] nvme multipath eBPF path selector
Message-ID: <20250730140639.GA11278@lst.de>
References: <20250729070653.125258-1-hare@kernel.org> <20250729075401.GA23933@lst.de> <ad394458-29ac-4302-8028-2276519a4122@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad394458-29ac-4302-8028-2276519a4122@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_070656_113757_D984D3CE 
X-CRM114-Status: GOOD (  17.49  )
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

On Tue, Jul 29, 2025 at 09:53:09AM -0500, Mike Christie wrote:
> On 7/29/25 2:54 AM, Christoph Hellwig wrote:
> > On Tue, Jul 29, 2025 at 09:06:47AM +0200, hare@kernel.org wrote:
> >> From: Hannes Reinecke <hare@kernel.org>
> >>
> >> Hi all,
> >>
> >> there are discussion on having to deploy more complex I/O scheduling
> >> algorithms for NVMe,
> > 
> > Are "we"?  Where?
> 
> I think that's me. I was originally looking into eBPF path selectors
> for ADNN:
> 
> https://www.snia.org/educational-library/adaptive-distributed-nvme-namespaces-2020

ADNN needs to use eBPF, but controller provided eBPF, not from the user.
This has been clearly communicated to the group in 2022, but as usual
FMDS is drifting off into their own parallel universe, not only on the
issue of path selection.  Based on these factors ADNN in it's current
trajectory is unlikely to ever be implemented in Linux.


