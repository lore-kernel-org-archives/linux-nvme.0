Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:35:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6235F61368
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6235F61368
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HFHU5eMun4lho5NOqfU+FX/gCjAa28f1bb6/pR50uyo=; b=27NYvG8V7PDwuH
	ZmRx79F5sqRBo1XXiCv4v3kxtzg6FFwaRDHuHqSb3Vbq4wab5WBwMcK9q8c4LGCSR9WqPkq3WQUOX
	wIBiHhUocB45f7zvT9Z4dNhZYwaUrbXibMOQuq70A/dFUvHfuMOIehDBVB9JYxCunJcs/tpUZmtIm
	S1m0z/UZsmus/w3c5GOUGFfwsZYkfXUGDa6pqOVTBekgLbUfueE5PGpfbhwnKQAzl0heTQjCjIwnl
	jDct28R8ihoHea5b07dGFbY3Sh41LNmlkDkXYQRQ3mdXAujPqOTNV2H8r/nZiYpyo02UMN0OCESaq
	tN8fcTZiRDFrsvy6rnag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVhDr-00COpP-DJ; Wed, 29 Sep 2021 21:34:39 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVhDn-00COoH-W1
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 21:34:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=Bs8bMhC7bQAuNPOpZEH0zniuEdm9NW/YrFeZImeIfOA=; b=I2EoSXtUtxxE6I7rRXNlaQi1Cr
 26y7kb5TT5Pm2pY5KxdBM9XFbLlCc1/rp6B788hVTB6/j0GiBnouY+POEQdum7NZv9aXHc5gg45iF
 yDAL1n2pfsNdyOEb90H2C4R4SoWew8wSXqeMJiwcAExoJRoh6co1C/CZ0YGaO2ofnpKtpl9BhvsIt
 n2teiyqjsDdWHRe3V8sdAM1Oxu9gQupPSVaReSA3KUwu7+sZf+t5nMdzuSACvG6+2YM5krqC8RIUR
 dFiVhA4xErhytJnA9uXt2A1tDoLp4et4Tm1Ld8W02rwrG6hBlPYYC+mPAn/D7qJpK5zLNDI85nLXB
 zO+aoKCA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVhDc-0006Oe-EH; Wed, 29 Sep 2021 15:34:25 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
 <20210928194707.GU3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
Date: Wed, 29 Sep 2021 15:34:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928194707.GU3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_143436_042804_A0E7021C 
X-CRM114-Status: GOOD (  13.90  )
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




On 2021-09-28 1:47 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
>> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
>> allow obtaining P2PDMA pages. If a caller does not set this flag
>> and tries to map P2PDMA pages it will fail.
>>
>> This is implemented by adding a flag and a check to get_dev_pagemap().
> 
> I would like to see the get_dev_pagemap() deleted from GUP in the
> first place.
> 
> Why isn't this just a simple check of the page->pgmap type after
> acquiring a valid page reference? See my prior note

It could be, but that will mean dereferencing the pgmap for every page
to determine the type of page and then comparing with FOLL_PCI_P2PDMA.

Probably not terrible to go this way.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
