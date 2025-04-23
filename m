Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E93FC369D7
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+fayQ/PBTnrOfxtrw3IgFnI1QJK9xAjEiHuuXs7Kpg=; b=420QO3bZwSkHfMcVNrZQImcI03
	EvpNc6kJ5Mh6zmjxPoWndz2s5hCXXDffzQJrQuS2xSdnjKMzvGyds4kj5vLdrgLWPMi4jH4i9U2WC
	KtARVrOrDhZxippj2taAQuwTR1C/GRBhbjK0IlxQnhY5XOzZXioMmbTfkMP38ap3X/DLObLifDcmL
	WpqHMCwTGRsw8MbV2fk2/mbwUT9KRCY8Cr1T7iXx8VZYvoOHuCcopw4Y1FRC3qN2C/6pjIzCarVCr
	Hw9csJSkt3boblrco5r4+ycDldBG5rhgIziiOnN37P53F2OPuseoceqjT2Y557iXofJfiZTUNR40L
	HMGo0plw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7f7s-0000000Bd7W-22jx;
	Wed, 23 Apr 2025 18:47:16 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7dzt-0000000BHUR-3S5t
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:34:59 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7c0e135e953so8169885a.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429696; x=1746034496; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+fayQ/PBTnrOfxtrw3IgFnI1QJK9xAjEiHuuXs7Kpg=;
        b=C7LHAkb3oSw3XQyfh06G9hFiv1vtNYerRIxAQZn6DwVpKE83TX81LskMJFWSRiyl7W
         gQ1+BjrJIJOg0/FR/m0OrfE816J4aLm/JeLsG/W8ZiZIrEX0mam9UfPxUBOB5fb3DFPq
         u/aRjcaUWINSCICPOPFDjDiBJR9aigeD/4TX2437yVaVS+WIxGE1VdDAmiQDQVQBIRWV
         WdthL3R6/yBpX90Q3szB820LebQm270rZMj6vk0lHXUuFGViq0lORT7IMqzzKPutGBcP
         OHBdd4lS+j0ryCobBSQhVXKyPfBXtTx2J9Y1IgaGxQE2s7T50a+gIkEamjKO8JmSR2r3
         OmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429696; x=1746034496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+fayQ/PBTnrOfxtrw3IgFnI1QJK9xAjEiHuuXs7Kpg=;
        b=khxwRwNFiylRoH9Gbiv63fN5NVPKraKcaWSosmn04W2hUdgNHB5aQsPkR6auGTx/bH
         YZn4PolHXUdwMHS5iMmOZ5Rk8h1hxgGp8gXYv8l51dkbAyYw7l/6d8/8eog/5qrAw4jX
         GDlTuJ/WiO14+BX1ajMYtGjU9xnN18IvBALDNnwTJihK6VaO9n5g3goSTvrrw0i6wZMB
         gJIUMDf341EYAjC0+8504ogpBw5Hnr6ueKq7g2ihU+pJSy2TcHcXaMPCAWPXfrHVsIWJ
         GYBecfSJbMPs6THy9lb7pcri7G6oYJrCybpeZ9HfTUYkYJUulauLcQKSpanZSG6vMIg9
         WpGg==
X-Forwarded-Encrypted: i=1; AJvYcCWfGcCH1F1SCBp4HNNcVQZmLzkpOzobGocsJ9WtKnmDFbWf+quWuty46ATls81/9Y+U+qLW2BP+OeZY@lists.infradead.org
X-Gm-Message-State: AOJu0YyCYdAM+v3sYJYeXzPJpm3ItkSyFvAWrHqb9EOP4IBTjhsRNqTH
	nGQpDOfTEp8oJdWs7+c6h1EXPuUdKn400rm6zzU64nd9nWjuyg/JdxwwY6syGVw=
X-Gm-Gg: ASbGncvK8iU2eYY/VnAnmjEuK4J8pwj4v3VVzkwc/HS1MAMQGFI1zf8b/EZ3ZS02btW
	jXwIR6tDNrDsRNup2Gk5FBn+clkL9uiQme2ISbNHD24t0I8/usmtZrebpFEgfOTRdH1FzXtm48N
	PLrJf3eSudR+ahhKzWx6xiRDmZfyOV1YSdRegmjdJaeG11EGtER8pR6LI18thT08/a0mnNVw4Fe
	HWOsglc3ywX+b754M5eLdxLn3wfU6+47XmZbkNzCFTglSDCYHII07hiQAjgsLTaRvKsbX/0+EP5
	f/pIYtyl4POPrWd/XckCqIaJFMxqKWLvaicKA5QbspMlTeTO+lGHz0qTEn/AwbgPg2f0iRBgh8k
	E8jPcuOJ4Tc3HuPOvbIc=
X-Google-Smtp-Source: AGHT+IHrcKTZfJXCAhkO2WaOum0PT2hRMW3vGaRhpe2sCjwAXzgjbldqD9beTUKDcznlrIIPKNuBAw==
X-Received: by 2002:a05:620a:2953:b0:7c7:97ff:ca42 with SMTP id af79cd13be357-7c955e7c7d7mr65261285a.41.1745429696505;
        Wed, 23 Apr 2025 10:34:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8bf65sm707741185a.25.2025.04.23.10.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:34:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dzr-00000007LbA-2PtY;
	Wed, 23 Apr 2025 14:34:55 -0300
Date: Wed, 23 Apr 2025 14:34:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 12/24] RDMA/umem: Store ODP access mask information in
 PFN
Message-ID: <20250423173455.GN1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <f81331e55cf95b941e6c57f940a2a204141bf2e1.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81331e55cf95b941e6c57f940a2a204141bf2e1.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_103457_869949_8A887B5C 
X-CRM114-Status: GOOD (  13.01  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

On Wed, Apr 23, 2025 at 11:13:03AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> As a preparation to remove dma_list, store access mask in PFN pointer
> and not in dma_addr_t.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c   | 103 +++++++++++----------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |   1 +
>  drivers/infiniband/hw/mlx5/odp.c     |  37 +++++-----
>  drivers/infiniband/sw/rxe/rxe_odp.c  |  14 ++--
>  include/rdma/ib_umem_odp.h           |  14 +---
>  5 files changed, 70 insertions(+), 99 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

