Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF47C636CD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=flSLkTva5YFnfy13LfQWAFDpNqlr5F+747MxY8IgAfQ=; b=FhT2f7K03++ccXjnoN0ZN01Yhz
	Ft0A2SzGkCufB9dG52tMno9c638nj4IjK8z0EElQnr/UVN4OnWLE5JwkIj5qWVkhuC2bDo1h3cEpK
	seZtB7ezNeP4OZJtRRx3SXFuwJb9Xi6AyTfb3QqWOM39qpNzcBBNpzUCoEuiiv/B58PFqMLKiVCV1
	3z9xAjJFh8Sv8B1K4JjS2YjpMNfu30iIoGVW0e9wU0vIu5HX08IiNzT1Txik5qdwp/Z7g1rw+bVSz
	4q7OuquLFcB88GC0sIH1mMLqRhfbEhqPepjlzLaf+Gm7/hb1bf+YwguuY4Hm6/kmX3KHcavm8vXF5
	lqly5cXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQWzE-006hs6-B1; Fri, 10 Feb 2023 17:15:00 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQWzB-006hqG-BZ
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 17:14:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 24875B824CE;
	Fri, 10 Feb 2023 17:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89BAC433EF;
	Fri, 10 Feb 2023 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676049293;
	bh=w0S9mmScSNnifyh2kozXqaAbMO2U92cpB2+CyJXsxU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlgjIXCvgRTBU9I/uXsNym+AroruK4M34FQoBgVTXMZhpNI1lSY7UYoslRc+HXK4v
	 hnTQhr0XPAxwB6dtUsep60qOV370COizmRQXrJ/ICPuQpgZkzLp5UVvOPS1lAM7WPN
	 NeKYJXxHUZgflBNxFhHP4LhAtoiVAa7M6iyjX5s54g3oySvjQ2guVKiylYP/YYh1U8
	 2ikTAUmta4z0lFWbY2GOiE8M2Qd3Xu6l+T/tZ1Tlsv7QYZ9ugdVdxJmdK07d5OHJCM
	 U8uMjGHZNDnB0YP7BPRlKQRTSddfe2FW4Xu3fsL61ZQxx4EbIrCBADjOEVy2hLouHL
	 LpR4I8GT7c0QQ==
Date: Fri, 10 Feb 2023 10:14:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: hch@lst.de, kbusch@meta.com, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH 0/4] nvme patches for 6.3
Message-ID: <Y+Z7iQRfmoY49qRU@kbusch-mbp.dhcp.thefacebook.com>
References: <20230108182219.GD25544@lst.de>
 <fb65a843ba3da23dbb5b7423a2d413c0f263604d.camel@linux.ibm.com>
 <Y+Zhvn1KwbMVmpGx@kbusch-mbp.dhcp.thefacebook.com>
 <Y+Zkn3bj80lR4bZo@kbusch-mbp.dhcp.thefacebook.com>
 <128ea5592001c2a11fbd18c6c2726f35978dfa54.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <128ea5592001c2a11fbd18c6c2726f35978dfa54.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_091457_583585_410F8F31 
X-CRM114-Status: GOOD (  14.18  )
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

On Fri, Feb 10, 2023 at 05:29:31PM +0100, Niklas Schnelle wrote:
> So if I understand things correctly possibly thanks to "nvme-pci: use
> mapped entries for sgl decision" a collapsed DMA mapping lands us in
> the entries == 1 case in nvme_pci_setup_sgls() so no extra mapping is
> needed and thus the dma_unmap_sgtable() is the only unmapping we need
> in nvme_unmap_data()? Does that mean that previously this case might
> have used prps and thus now needs fewer mapping operations?

Yes, exactly. The older code could have still decided on using sgls, but it's
definitely more likely with the newer code. This does reduce the memory
allocations so it should be more optimal.

The older code did account for this use_sgl nr_allocations=-1 correctly though,
and I messed that part up when changing it.

> Either way, feel free to add my:
> 
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks, I'll send a formal patch today.

