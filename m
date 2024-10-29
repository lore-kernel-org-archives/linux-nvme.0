Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29CAD3A67B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KaR541SwuMqOrchd6Sjwv/vkRGY/cykc107gdFrtJzo=; b=bX4gLYIJZvv4A2gAm+7JmzoNMT
	iLvd9+15J/lnKvPnE0PgQ0gFrEF3ZN4frnAWvlX0XE32RGeMX8ld8p4erH9+Gu7PSI/epmYeIOTL5
	Vg4yrd8ilT4cRnbbg5S1PWwshdFdsDVgAHAKRWKj5o18k4nTlVUOj+ftjxhOu3B8VJbdIfva3Iwgq
	6bFKnCDjeEarXpjczD5wdiyklSsRfNYQnbAV7iHzBO5uhnbg8M3Gy8iBeibM466AsQ3n2XhCTPXWZ
	9uGsXRcRl/m1ZU/bTRwV944Zu6SVw+sK6qKln8qvSH+49lzrrBaGejCutcVRNJcNN0Zt3Z6rRcR6X
	XGQiN4Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rG0-0000000FYhF-0eDq;
	Tue, 29 Oct 2024 18:47:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pOu-0000000FB3L-2Jzi
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Oct 2024 16:49:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KaR541SwuMqOrchd6Sjwv/vkRGY/cykc107gdFrtJzo=; b=GNf+mlYqqqi+pSRqfGa/H23yn9
	4UxMYO08lX294Qp2au/T+AVEkDLPMHkNKMBvvfyKYbO03yj+fMr+4jHc4fG6UzJv2ymx6vcVI6qhZ
	ysuFBtkWBxmRALuaaHeKSqDpnKN1KPfopIeUfBGbcm9EtRhhqH9S9lvwbhcqlqXif+/NE3dQHEbG/
	r9fSvyM0SRoQqGpissOJCODmxHJb0vr1MaSUtHcmFGR5M8o2VWmciotjgoIFticy+69rf+NL+2f5q
	a5z0kgOlkip953ZbaS8c1gk1lUTtVr4FlPtVKcf/VF25Da1f86I0h8KyPAFpHhfQ+XIN0pwrTMDEA
	XdMDKt5Q==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pOr-00000009xDF-2u5O
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 16:48:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 186275C5F18;
	Tue, 29 Oct 2024 16:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB9EC4CEE7;
	Tue, 29 Oct 2024 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730220528;
	bh=UHUCi4vpc9NsIGRx2NWApkLxNhg8anztoSGFsyKXm3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyHYnWW1pjm6Aj8Kkcd/dadQl9cdDWv80O4cGEbK301k/HKDeMTCHwvXC+cwoVNue
	 We6HnodpvPrTnrRZK2G3lOYDParD9rcxcFpCDPsScBhny2/aGDhYpHfyMfzYn2V5i2
	 8vIqKiSqrbDs8K9LAxdas5kt/hXTScdnJlrcx6hI16sgOa8vSRzptDpr4ytKHcn6JC
	 2K+J092fr8qm+NMl8fhV653EwxDOStqEih+f09slsAjOAG/FjJ16ZGRrUEa75cPx7F
	 SRKR/Kt8/jRcBo0e6P4sI47wJZ5jEmWK0WEOf/k+ExW9WR6qRlyhSZXoppq6fNCTC3
	 iAO+F3XpPWYrQ==
Date: Tue, 29 Oct 2024 18:48:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/18] PCI/P2PDMA: refactor the p2pdma mapping helpers
Message-ID: <20241029164843.GO1615717@unreal>
References: <a4d93ca45f7ad09105a1cf347e6b6d6b6fb7e303.1730037276.git.leon@kernel.org>
 <20241028205902.GA1114413@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028205902.GA1114413@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_164857_973819_5BDBF2A9 
X-CRM114-Status: GOOD (  15.28  )
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

On Mon, Oct 28, 2024 at 03:59:02PM -0500, Bjorn Helgaas wrote:
> Prefer subject capitalization in drivers/pci:
> 
>   PCI/P2PDMA: Refactor ...
> 
> On Sun, Oct 27, 2024 at 04:21:01PM +0200, Leon Romanovsky wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > The current scheme with a single helper to determine the P2P status
> > and map a scatterlist segment force users to always use the map_sg
> > helper to DMA map, which we're trying to get away from because they
> > are very cache inefficient.
> > ...
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> A couple minor nits below.

I'll fix, thanks

