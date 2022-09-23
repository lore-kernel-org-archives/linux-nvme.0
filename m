Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE08C04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESjxMV4FxoH+Qzt/uSGYOPflTsCgLENu7dcc3YowE6k=; b=KETa6g2Mz8zWzwLbVz53ye0A1Y
	OmVWxcOiPBpwx9qK0AtCBRK8N/hCuPOGHjozpsmw9HkgxiG6QZ0LKfebc5JQOIyTnQBBwWFTeFzyn
	CIwZSedreMoT1qwOdze6y7ZmCpUqcz3NRwtrwP/4ZuH41AQRgNGA+hgPBjI7tOcyNO980Zw/li+OY
	0LyOt7V6SenoM/0h6a85BjQEYxdTkPBD8LapvNeW39Wx/B0xYtFJuSGCqIq2gDEcwWv9I9z9CkvFi
	acN8S3VuwrSdBD5Wqc98YDiFoqrWQMAYUSytE69u8rkBU1/SYUcWCDwcS7vijSGyyoBCBr034I0rw
	1G6T1Bvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obnAk-005Ifw-8l; Fri, 23 Sep 2022 18:13:10 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obnAh-005IdZ-At
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 18:13:08 +0000
Received: by mail-qt1-x835.google.com with SMTP id g23so574804qtu.2
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ESjxMV4FxoH+Qzt/uSGYOPflTsCgLENu7dcc3YowE6k=;
        b=kY7MMNDmdRDXgBREGl1n+cj9EEOun4Jy+ls14IMPSV0csWh1NDhj6Y4IB13T7BfdUg
         Wi26eUp33Pa5tk7zFyBI2Mq+szalxQ6Q7xLkG63kAED5icqyWvausogbFqMjBz0Q3OAh
         8jqc4H2+05KPQwocTeDkku8kSoajsIwV/5IYLvCARPSewr33UpGNeEeIiU9QvvDqKKWA
         39NJUXg4YGPg3p8VI/Tc5XyFrJVFGr/E8X/vqYnNdWZ2ScfDLSTdMHKUBAKg0NCPBOg6
         IuCIVAumakjRmdj960aYL4S9ORJZ+CwZb7srEB3nY3ZBFIp+qJ2V46gkbAaTq221ryrS
         b8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ESjxMV4FxoH+Qzt/uSGYOPflTsCgLENu7dcc3YowE6k=;
        b=E0wjeV+oFTSyqgrhxdqgHBFTSUH0eHEOIyYw29NwIgi+ov3ffkwFhsNZTcmUUoVHJg
         G7xVAiLd/zXDm30AXout0UKK3Swakw7IHGElCSYsr2ieTeyPnCXFRpDkGoVXeTLKe9po
         Xc5kviC+q+AA1lqqbvbdAEPBLtD/NwCFdpi66XfhSEhCeNzBNU6pdhSJwXE6+GbetHte
         dgoIax4kxJfD+Rnp6PI+KpRfQxW1m0rDrzz5gio+h6ei/fjocsJJ9xFMPQLl7i9AdcFE
         YpUTgJ5lgj7ZzgPrMGAzUL2upmxAr1AZQObIwmVkQ+eyYWuEpA3ORZqN8SZ/+kUjk2Kp
         hKxQ==
X-Gm-Message-State: ACrzQf0smAGZQqpcaKSbx1LQhXZygRbJtrp3QSgvVzLAHLrkceVkMZmp
	N0U5gOZCNSsvzR+h8m/fKVyL+g==
X-Google-Smtp-Source: AMsMyM70jy04UOYomyiLCRjAafYD9I2h2rthRpjbDcZ+gaI+Pe3GK1nBzDBvaI6cptEThcPFiSijKQ==
X-Received: by 2002:a05:622a:1053:b0:35c:bab4:bd80 with SMTP id f19-20020a05622a105300b0035cbab4bd80mr8343380qte.189.1663956782680;
        Fri, 23 Sep 2022 11:13:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id r13-20020ac87eed000000b0034035e73be0sm5730575qtc.4.2022.09.23.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:13:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1obnAb-002jAI-6N;
	Fri, 23 Sep 2022 15:13:01 -0300
Date: Fri, 23 Sep 2022 15:13:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <Yy33LUqvDLSOqoKa@ziepe.ca>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922163926.7077-2-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_111307_393312_50DCB019 
X-CRM114-Status: GOOD (  15.01  )
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

On Thu, Sep 22, 2022 at 10:39:19AM -0600, Logan Gunthorpe wrote:
> GUP Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> allow obtaining P2PDMA pages. If GUP is called without the flag and a
> P2PDMA page is found, it will return an error.
> 
> FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set.

What is causing this? It is really troublesome, I would like to fix
it. eg I would like to have P2PDMA pages in VFIO iommu page tables and
in RDMA MR's - both require longterm.

Is it just because ZONE_DEVICE was created for DAX and carried that
revocable assumption over? Does anything in your series require
revocable?

> @@ -2383,6 +2392,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>  		page = pte_page(pte);
>  
> +		if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
> +			     is_pci_p2pdma_page(page)))
> +			goto pte_unmap;
> +
>  		folio = try_grab_folio(page, 1, flags);
>  		if (!folio)
>  			goto pte_unmap;

On closer look this is not in the right place, we cannot touch the
content of *page without holding a ref, and that doesn't happen until
until try_grab_folio() completes.

It would be simpler to put this check in try_grab_folio/try_grab_page
after the ref has been obtained. That will naturally cover all the
places that need it.

Jason

