Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5574DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:48:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B676103E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22B676103E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uCHJzI3y55MYtSzUEaZ+hdytTroZhn/br2uslqllntE=; b=TfEKhnMl6nDM32
	tCJc3iVwa7gz+c8U+oBq+2kxD21IQulld02z8BmA6m5ql32wwIQYjQz+fKywKnW/azUE8bmPqYvL4
	wcjLRZOnkePQwzISt0JU7uCGhrDbJv/LcgQ173FPCJqZW9AxzA36MQB6+LjksTm8ZLb8rs/b+DB2V
	/JDb+p/oBlqP7AOmpfjQ7YNbL3To8/4HhJsqkew6Ht2H4FEbOcgwpprSww9GLypoHsERsRkVXfx+C
	EHTAF2stBBzCBZysFsiZ4ocGjC+WlSIVan+LchRzUNiBQklFenG7+8lypATKprGAkLC3taUWjPwu/
	d/VzbrU82P5h0SRVWaTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVJ4M-008hKm-M9; Tue, 28 Sep 2021 19:47:14 +0000
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVJ4K-008hJB-7j
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 19:47:13 +0000
Received: by mail-qk1-x72e.google.com with SMTP id d207so42216088qkg.0
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EVzDoSDqJZmi4ToqJEIddbvRD+vlWsRISaT7f2OXukE=;
 b=EO1kDwzeZuMv1jUFt2pmKX8GvyZQAUMBJiLy1x1SVytxwcplVnv2ywT1ffuJvbGzDe
 SqreChLnqXdZ3bmpOGx1lq6jv+yPr/cOeERvwxCekQ+2pAL/hPpshqhIf/ZGdT33EAIM
 lOon8sIgHYjE/rwWroGijsvQ3Sfl16uYtuTJKv69ByO+2IJKaQCkRs4E+itlOn/VuGnJ
 ObcFwFaFhFQuJrFju9q8374g29cj0NSSZZgWhx88Ckt7Rqd+521BC3qoxSNjSsHzeMSW
 tdbGfXJrW/lc1jL/isk876EABn7Hc3z0lVBV5inoZjNRJpGnlQE9c49iUQf8C8yixnTL
 5Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EVzDoSDqJZmi4ToqJEIddbvRD+vlWsRISaT7f2OXukE=;
 b=dwucOfES1Q83x5gcGG3mQjavi8YiQ6Mw2rUvZ1Lq2yqYCLPVOaVQTZIpyTlivguUYk
 4MXEfuBDonOzuV8ggCWs3h7lPOChqyMN6uNFCFma6WOtfFY2a4LN9hN/XSvzHsV0brFX
 8o31JHCFE0s7UtWYkcVRC/Qv3hEOLFChxDKuZOHYDmHhKXX6ZXV9j1DH789/JSI5El1p
 WspQS16IWxcOfaANtL56Qyagi6zTg2Cf8Me+uNy6WdCmEjqzafxOmsF3Pf9p/fqZRtdO
 PPQMlNTH5eazWqboSncI9VuhVoUEJzyEP6qDp4/azEa3hSSLGVcfJ8xwg6JwTUBT/fqC
 D3aA==
X-Gm-Message-State: AOAM532Ezzb7cGYhPEoVSQ1P7tXc5vQxbiBr7TRZJ7c9fK+JhC/qyoOP
 T6wgkFTT2GNv/8wI07f6VqWAfg==
X-Google-Smtp-Source: ABdhPJxxZpC5AepjHCbAmIQaz4Zogx1HRof8bzNZRXH/My30paIzwcLwvreCcb7Df5Gio9BelRE2TQ==
X-Received: by 2002:a37:8242:: with SMTP id e63mr1886625qkd.294.1632858428465; 
 Tue, 28 Sep 2021 12:47:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d14sm79297qkg.49.2021.09.28.12.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:47:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJ4F-007GbK-31; Tue, 28 Sep 2021 16:47:07 -0300
Date: Tue, 28 Sep 2021 16:47:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <20210928194707.GU3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-15-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_124712_299728_FBC3277E 
X-CRM114-Status: GOOD (  11.11  )
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

On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> allow obtaining P2PDMA pages. If a caller does not set this flag
> and tries to map P2PDMA pages it will fail.
> 
> This is implemented by adding a flag and a check to get_dev_pagemap().

I would like to see the get_dev_pagemap() deleted from GUP in the
first place.

Why isn't this just a simple check of the page->pgmap type after
acquiring a valid page reference? See my prior note

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
