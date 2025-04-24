Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969C2C369D8
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6hXpeFv17Go1fQZO2l00KUq0djvqX4j0LhOJE1RpTI=; b=eIRRZ5O25Ud4hJk10z+dVwytx1
	tPbikAoVOMMxncBfctRpFEAGWh7Ooh8YPnU2cKwH4ndZKFwgIdXmlhw4/CwaXc9LVJsuCHD1H5tXV
	+3Umpk6H1H67BQMEgEAPten2PvloCHtDe0RfyJcDfmw47SkzXH4Ezf51CMasGsVE6wabzHCqduCVd
	kAWg9eSgVUz41XGpz4QXcCDXaod+Llvz3qbPHIZahj/TZoxnVYHuZBm1UlkuLAN9yi+IMCSr3GJew
	6ZuJkVeej6egJvcLMfQEr07Zgy2p1Tkr1yzTEXEEgctKaWGJvy+gApVIqok/0uhn6euBxFgCDJ2KZ
	TJLyPKdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z3S-0000000EaP7-1oWs;
	Thu, 24 Apr 2025 16:04:02 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vM9-0000000DxiT-2Igq
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 12:07:06 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so10081826d6.2
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745496424; x=1746101224; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6hXpeFv17Go1fQZO2l00KUq0djvqX4j0LhOJE1RpTI=;
        b=fvgU7wMMdc6D9fNMgea0bTFCpSMe8ko7WAPmNYxn1jUcy+1J4zkIxlWvkYQvZmr4wR
         wQUyved3mSDZAWZINZndrop482oRsotvLPStC4u2BWJYUNO9Zd/HSzVwjDS4lqsJ4102
         adRbYjbf0z6P8hpb9h7UUVVCuC8+CqsiwJE0BrWKZZ4w1PVUC6H5YsjmnQig2rie7BCZ
         iNJmHyP84Zm9ICDKjtpdmvBl3Q725SYsu0PWmMZbtNpQZinOrSFe/lNp8z13+n67M4n4
         D56e7Z9tTELGxoD6tAjsAJdpE/78uyZx0tyBAqzKlEoKSNdno0OZ+GuJDrE9Xn7IM9ik
         9opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496424; x=1746101224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6hXpeFv17Go1fQZO2l00KUq0djvqX4j0LhOJE1RpTI=;
        b=m3vpDnVilHwhTM4eRXbXDZ37AAnUTd8uhYULlPMPRfy7EOH7etlAZXp3bAaPyijmjb
         I95clIb2MOJPuqjh97iaSKGOwv/hn6T+oKMYnVvGuBYFywEANuIrRoP0viq5sqfi+e+z
         TFZ0Na8E72yiAlyFhTw2Aw0b4t6JNGPEWseYgvrXnvegHFgFMfFFyg7hhpt5KctgRP/0
         AbDB7DZnD/DwCjCKOo6KZ+4BgqBss3s0YWzcyS7esG9+JWRW8AFcTKCH3DHOxGhjhFxZ
         D+xXL9uG8R3URBsk89GQD/0LN/uotvKpRd5WZhREGMEFLAlklzki6JX9AawK6Mp40xCn
         GQYA==
X-Forwarded-Encrypted: i=1; AJvYcCVhT6YVQQOZxyyzE6zWGyeNTbsq6GyG9DdX+tDIpMOqUhSuIUJ9Dp688NwbpG3ZcsO5IAeome6WGK+J@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9l3+X0CE6jevMkiMPzDE6AXHcLC9i2NSHlnnEhZZ5UMmvBFip
	t33xoe7hRMEC7Jmt1HBWrUJKwYGJWgAtwNi4VIuIAaTXGecWTK0G42AuKd9wzgyHzw6YmLy9a5q
	j
X-Gm-Gg: ASbGncs7lbzQL9tcZwj10T162aHLdteCpZDXcYB+p9T4aHH50eLc7vmfPWbUoCfrkA3
	S7OHyMTOdPTd9ahWmP+nEbpIyDqqtQEZMBU7S+xi7JbzkHJVqtkYuc7UpGljMxkwY6xrDlDjZr5
	DU3YQTm0pS89xKBVXnuO34EvDlxO3mxw13f8GOvStAUDTzCPmUnrysEEuhLq5PW2ZNzSk5iAXua
	MX1U0TeBmNg1iTq4/SIfnaVLjOTaiOqOjLLtcvirmFss1ti/6oa6NEiFLnsQ1sIRP2bCOtAWLnD
	oLZ82yzsf5L7RrVdbo/qbHD+CRt/mHDX+/P7ha3m0ogOA68vOR9hW+cDNZAkzrkBXv8Lb9hpV7u
	j8WXXp0pDaTezVXbUKPE=
X-Google-Smtp-Source: AGHT+IHFhKOxhA0o2WRAa+GJNDxvcX1iIXnEJwZa2QwM9rbiZA2VutZzFm82YY72gKJwza388e3Bog==
X-Received: by 2002:a05:6214:518c:b0:6e6:65a6:79a4 with SMTP id 6a1803df08f44-6f4bfc85415mr35084026d6.44.1745496424198;
        Thu, 24 Apr 2025 05:07:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aae668sm8460536d6.113.2025.04.24.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:07:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7vM7-00000007TSP-0PWP;
	Thu, 24 Apr 2025 09:07:03 -0300
Date: Thu, 24 Apr 2025 09:07:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250424120703.GY1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
 <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
 <20250423233335.GW1213339@ziepe.ca>
 <20250424080744.GP48485@unreal>
 <20250424081101.GA22989@lst.de>
 <20250424084626.GQ48485@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424084626.GQ48485@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_050705_581556_C7B094DC 
X-CRM114-Status: GOOD (  15.93  )
X-Mailman-Approved-At: Thu, 24 Apr 2025 07:04:07 -0700
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

On Thu, Apr 24, 2025 at 11:46:26AM +0300, Leon Romanovsky wrote:
> On Thu, Apr 24, 2025 at 10:11:01AM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 24, 2025 at 11:07:44AM +0300, Leon Romanovsky wrote:
> > > > I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
> > > > DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.
> > > 
> > > Thanks for the fix.
> > 
> > Maybe we can use the chance to make the scheme less fragile?  i.e.
> > put flags in the high bits and derive the first valid bit from the
> > pfn order?
>
> It can be done too. This is what I got:

Use genmask:

enum hmm_pfn_flags {
	HMM_FLAGS_START = BITS_PER_LONG - PAGE_SHIFT,
	HMM_PFN_FLAGS = GENMASK(BITS_PER_LONG - 1, HMM_FLAGS_START),

	/* Output fields and flags */
	HMM_PFN_VALID = 1UL << HMM_FLAGS_START + 0,
	HMM_PFN_WRITE = 1UL << HMM_FLAGS_START + 1,
	HMM_PFN_ERROR = 1UL << HMM_FLAGS_START + 2,
	HMM_PFN_ORDER_MASK = GENMASK(HMM_FLAGS_START + 7, HMM_FLAGS_START + 3),

	/* Input flags */
	HMM_PFN_REQ_FAULT = HMM_PFN_VALID,
	HMM_PFN_REQ_WRITE = HMM_PFN_WRITE,
};

Jason

