Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912B0C369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=; b=MllT1wWC6hZBmZgXH6RyTkHAX0
	PG2T78mNKX9np4TeaZ0lFql8G7QBsvxfrvoFUguyCpPR2Zl7LtiDNcRI2tcuooGiP8CSii5kOwGfW
	jj2VHiEkS2s1qky8vQ73MgrlGUdALK4OhG8hOK+ESfrOlUYcGaNT4lrhuLZW+PZpjhSTbbww7GRy9
	xCT8TxK5C5PTrsSaQqZ/qnlg7DiXhdP1ipNhGwDjKEfHHb+MZhufVn8PD1DiSm3pqC7/oyJ+lJjS9
	0DTXCWk6z608N+lFfqY9i4kdKRTOqi64hS3UeqCg4v2qBoQk9e6S7InCe4WS9Qq4FodQc9JNjLJtw
	v7uznFGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9UqG-00000007QUa-3TSZ;
	Mon, 28 Apr 2025 20:12:40 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9OLa-00000006QmW-2PyZ
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 13:16:35 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so47304626d6.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745846193; x=1746450993; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=;
        b=OciQqDHa78ZPS5WT4ft8VCfVZTc/5qqIONCbhcwWkysS7jssIcUd5syabCQye338ee
         0QmXL1DqCyaSYtwWszYIWcDV7RYVzeRJ24BcQb81eRq8g7cEdX/hvIhXuDv6GMI8u731
         XJ44OPukfpmyuk7nJT3N0Z5i5wBcSTarnu10coqlcxjuLJ638I+aabKGx4iBPygNzXU3
         Vn1bjdbDgKBVgvpNOn84mqFbbRnb8TKmNg9d0RQG0UUS3soa/kBKrw5vpWUYDOVTeBCr
         wZSyfflSZRwFRsfgzNVyDwu1Ru2Pmk+/tNPE4gRDn3q2ItYGxDV54s6uJ26jMYIsO2fY
         L5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846193; x=1746450993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=;
        b=GrukN/TQpLXDGqXNKVEAU0uaRsrtiVzjyhzVCU5pZ5ahqDDi+443r1mvisfh7ZGivk
         NwWbQOAhvADZ6V+OJAyNuh/L4lsvEPtDpyCSFm6OW79uZYQYXmCNGVVqH12g1thXf9yI
         t8sZ/2O7Hx2y3qkBNhhY6WhKoT7oZRW+L439RDeI5sejpK1fmnPJLvNYxrwbO9ihQnNM
         Tefp9VatbiVg5ytHEeZGeAIcFvamD0duPqDcA3FcVNyDARrkKLL2ib/zu37hd1VbWPMx
         DcNig2yFTmD3654/ijWOMFta3/0BH67U6co/1HGGm0/nmJXnDeGuLg03C4GGPzAp+3VY
         zNHw==
X-Forwarded-Encrypted: i=1; AJvYcCU82iuOvzON+Fsu5+FZiJ+aTZlSSkB/Qeur47sKuoSac4ECtFOYy+7PTRM4g1+vORCSQWRygazB6Nm5@lists.infradead.org
X-Gm-Message-State: AOJu0Yzm2CaF5u7mbMdZttuEOyES8/iWH7pib09HIKf3x8B6Jl2iYOSD
	LcU3uhDpITpDhYiD4RvYcL+fhGzIsNfYw4QnPZky/vE51FbrR1ALtzzngDWYWgw=
X-Gm-Gg: ASbGncsOKz8d8Gg8mOgwEEtT7LQAlYMjIp6U3Bem2KilrE4a+Pnum5/wY/wFtj8wyzj
	FEAnuP234zYuOj05sF8mpFJNhxBAw7DKjnebfRTVnAao1v4sWNLRnNi6fLUxcNhxZVVpFp/xAeK
	Wkd+wnfxs0R25U7qA4wz8+3WLapGBO9cGnHkQbZjUgsgg3JjzV5li4ciA808/ZjKSkn3wFNM3gV
	7yFe86N+pGGtfXpAIG/U/+DJlB8xfUBnHG10DqxpviebPyqmSfK4B9n8Ke5R3tIFdrN2LrdasfY
	aJyI+auVZn/WDhyiuW9RS2HxG0WJiMxfM8HlvyhUvSDRTk5wjRCISdNhhQJUMVXNt42TsZmkRbZ
	mIID8eLyv2rtJxyB0cRE=
X-Google-Smtp-Source: AGHT+IGm1OrVyo7NrhtixKONc1TT2Ec0eky4BVMvt9fZIav2cWhkRh7ddfgsBqvKXcfpG60XtXV5Kw==
X-Received: by 2002:a05:6214:76c:b0:6f2:d367:56bf with SMTP id 6a1803df08f44-6f4cba51bd9mr207427746d6.31.1745846192886;
        Mon, 28 Apr 2025 06:16:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c74d3dcbsm53164536d6.50.2025.04.28.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:16:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9OLX-00000009TaN-1zxp;
	Mon, 28 Apr 2025 10:16:31 -0300
Date: Mon, 28 Apr 2025 10:16:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 07/24] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250428131631.GB1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <2d6ca43ef8d26177d7674b9e3bdf0fe62b55a7ed.1745394536.git.leon@kernel.org>
 <aA1iRtCsPkuprI-X@bombadil.infradead.org>
 <20250427081312.GE5848@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427081312.GE5848@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_061634_726908_39999B15 
X-CRM114-Status: GOOD (  13.91  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 13:12:39 -0700
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

On Sun, Apr 27, 2025 at 11:13:12AM +0300, Leon Romanovsky wrote:
> > So arch_sync_dma_for_device() is a no-op on some architectures, notably x86.
> > So since you're doing this work and given the above pattern is common on
> > the non iova case, we could save ourselves 2 branches checks on x86 on
> > __dma_iova_link() and also generalize savings for the non-iova case as
> > well. For the non-iova case we have two use cases, one with the attrs on
> > initial mapping, and one without on subsequent sync ops. For the iova
> > case the attr is always consistently used.
> 
> I want to believe that compiler will discards these "if (!coherent &&
> !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))" branch if case is empty.

Yeah, I'm pretty sure it will

Jason

