Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC47AC369D8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=; b=YAJW5GVUtuItG3YKG1gv1o9wak
	FGN5TlCxjz+2sc0jMq6I/lE38Oif2ftlUgwLkCtGYiceqjWMndaptsK1cfq34+hQe0mT8O0iH9kIO
	zlzAU5lq2SADh2M2vqDANkzMwlXuGSrEH8+nQr26zhD6xHfowaQ9q59Y+KfNllAon9q0bq5EfdDFk
	mIoJdxzdI74G/vhhlzy5+L6kPHTlDxObxwfxcbABfX6S2kfWSd9Tydr9wGGuMo6WOAwop0034rBVH
	7IECIWf2aQ3hP8Cx+ixnaleq5ZzBj6xBoJDJci6FxyeUCFEs9OwJE856vFZn5qYUmEEMopvk9J4gg
	Y+ux2KFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7f7t-0000000Bd8l-3odH;
	Wed, 23 Apr 2025 18:47:17 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7e3k-0000000BI0I-2mnr
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:38:57 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7c5e1b40f68so9191085a.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429935; x=1746034735; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=GCrDwKoGCKtj81E//BZnw8a+H4Ck9XytVXnQW7SUCBwUqIgIQ+F3byahGzjDAZk4LX
         vR9S64ODvOX/RtHmC7Q07eRUVXtoHAM5nLqjabGzDgRpyVlJSejc57vYAGOzkG6SRWdn
         tQ08yvqFEXkGblvg47YykvAjrz3RS1YZjV1YYNUh2uikjMV9a/Y2ltXP+zz2JnNiSROL
         ZUpMRV5MTODuWGIqevIq9geUAqETbhek66EbxAHSflsaUQCyQsn9Arem0tZ1OEXI1ufh
         x86hhDdJWUfy2D6eRdAp2VLkT6xIIzehYxmtoA8nq2AGqrQm4bTUWYcHQev1jB3JD5VM
         eVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429935; x=1746034735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=AqLxOJLIimPygZG/JPL+NMy0nOy0jyaOc9K3ifT4MVLa7sldzNuty6cR0oow4/jOiN
         SrOQrRSPrPJirVilBK7eUan3i1vXXCXrUEC+tDMWffCe33pVNpxONa9IbC985KknR8Ti
         nR0NUOCTnvr58UCI+3GbLVku5DtFPMUaQg6gDY5IIuESsNzPoPcBPR3NDRBfNjpFMUVO
         /BQx05F+sQucthfjtOdHmQwN1BKgrbXov/JkkO0DyjwfGGjEYqtLK2u9dNaYZ9g0gNeQ
         m5m2klqGRI0sCWiRwUI+uZlK/MgwNZ7OOdyE+ApmF1QMVDBjLju5YI16wzMLr21dqLuG
         UlvA==
X-Forwarded-Encrypted: i=1; AJvYcCXPicubp83NZrunKgi4AqQ5TxUIaZoGuBSe0O0U4uYC9GJH7z9L7kSf/EPsOerIzt8Ri+fgBLQHkB95@lists.infradead.org
X-Gm-Message-State: AOJu0Ywh9WfaCLAAB6Bbk87oM6Rp3z+hpDapOSUhuYBt1JyfBVZKt+K+
	CqEEfefED/CqN69DOaMa6M6uFX3xTG7589b4lbzQi4YDwUBM+YqcXRo2ePwnkTM=
X-Gm-Gg: ASbGncvQD4n5f2kNBrbHxUWqfeMFk01IHJbT6OqbtAfVwtWIGi3l84vfP0niciXbkUk
	abGpYl0l+vBfTZtM6sYwF986kp5fOZ2Y0OOPUbrubVNy1vrECUTiikVw4wZhqsQRWdX919kveuN
	epVH+tvEc6qSD8WP63s9T0s6JhYu7FUrK3QQevKJHOudVeWAKbILSYCqbA5Tt3pYbponVs/Inex
	NSGumx3OsGNPlYCs89IpITgRJe4q7Ea25mo1uJrOtpVcXubhl2TBnKVGvMiSDFgaMOdxkoG2G2G
	5efb88wtwJMh5RXEt7y7guP4GYo6XH3PDD8Ul8DipIPOSpudneKAqnc4imm9FFwAr6k8XlB0btA
	dk/ezE9noajieH9vFsbw=
X-Google-Smtp-Source: AGHT+IGgN3qsfS6onNY8+gQMZCTHD3MSF9+S5w+6n1/7VM1d4IchwJLfZsPm7/0ZCJyeB599ZskZwg==
X-Received: by 2002:a05:620a:1917:b0:7c5:ae20:e832 with SMTP id af79cd13be357-7c927f6ff15mr2997015185a.11.1745429935582;
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8c9f2sm708523885a.29.2025.04.23.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e3i-00000007Le6-2jjE;
	Wed, 23 Apr 2025 14:38:54 -0300
Date: Wed, 23 Apr 2025 14:38:54 -0300
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
Subject: Re: [PATCH v9 14/24] RDMA/umem: Separate implicit ODP initialization
 from explicit ODP
Message-ID: <20250423173854.GP1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_103856_705851_57BDB8C0 
X-CRM114-Status: GOOD (  11.84  )
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

On Wed, Apr 23, 2025 at 11:13:05AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Create separate functions for the implicit ODP initialization
> which is different from the explicit ODP initialization.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 91 +++++++++++++++---------------
>  1 file changed, 46 insertions(+), 45 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

