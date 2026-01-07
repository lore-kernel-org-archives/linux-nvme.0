Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F200D0D16D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/u8/mdCRbNm8MvpUWRoGYHAWAojzapM2ntHzieeqBkA=; b=OWwTjXfSMeByQwRq4UlBmbN4Kl
	wf7uw6TX8AZl/t+u1631jw9sYnsEAf+SAUfn7BDLLCAdCMch4KSXAfRR50TqJCYHVs2ZREA9dtwC4
	bW3TJ0T5fyb+tkPsHRs7qEOstpFEvKbGQovCzOVJElW2QBXwKiNrcl4tjRcPvGWKD1lGss80oX6xh
	9TOwoEqYZBRlpRydE0Bm7PjHYncXtLIegrWSFPNvIgslpZiPk+4rSyHZ7R6THtyE8T8xAmM1R/5E/
	/Loqc3lr6wSaz5Bs4IWTYEU5vrkudeIbNaQv+yfX42MiS8zxYYmTDZdKWt7z2tdlb3YvVOj4732N6
	+MWo0v/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vda50-0000000Fbxw-2EWq;
	Wed, 07 Jan 2026 20:24:30 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vda4x-0000000FbxN-1Q9p
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 20:24:28 +0000
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-8b2ea2b9631so274901085a.3
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jan 2026 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767817465; x=1768422265; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/u8/mdCRbNm8MvpUWRoGYHAWAojzapM2ntHzieeqBkA=;
        b=Eix/RzlWRjHm/pGwJvCM8IOeN6WngniJhmtQcm4HA2LVNQJ6+wHV/jtQwNHFj0CfKh
         3kvgmtOpL+QygnIBrqkbQ0YU6hM0IeiLT0SER5xk/V0L2Rmo3ke702V+3quk1Q8By0Ko
         NMYQLvXGh27VX8GTQD8nGoBeUI+BAedkQs6pgH7tenx7sOP5XJjIONoWeoXj+HatlbYM
         r8YSTGrMxk8b+o5Smm4rvnbI64Cp+Gd26hWsf42xNuJkWAdv6aG0mEkO2IQNF2MlcD70
         C7MEyicVJOkoqUqjRLoMOd1SgpL3HAdVuOQwpwWJBsz7rGz9rfaxijAOEy4WLQ1/46CO
         Hd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817465; x=1768422265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u8/mdCRbNm8MvpUWRoGYHAWAojzapM2ntHzieeqBkA=;
        b=C7FzC260qGjWTfX1Q3Xk7sz0jikJP+HvPw34SAQ0AS+J3ArBKU2yRz1WREY1+ct3FV
         pNKJMcsOnjJwzPfGxtlj6iAsmTTEuDXKQmdmv5PRIM/IrVtcWHr7vTPJiHJPIwVsCuOQ
         ulz79T9dS8liXo5k8VRRPLYaCQ57NVfz4hBaeIB/7LZ0gcNsiPHEAx2Eo7U41/sG8EyS
         E04TBBQIr7ZZTbbuQsj6y1wEJSU0lH4dWlxbHPLrOJLDMQgRVn90oNWLzQMxoI/jr2G+
         IvxexEVWOjU5h8ZlxUILl0zOhBKnh5+AdPwFPpr7EeSX5bwP0A+X51HLz+y4TUZvQzN7
         VUQg==
X-Forwarded-Encrypted: i=1; AJvYcCU56Mwtju1ENA2TOvl5yzeOtnvLUDKHhJcQmQDU59swm1o4Z7+NVBXz+/7BhSykPAZSxr0efEslX7iP@lists.infradead.org
X-Gm-Message-State: AOJu0YxecOB1s/hku3Y4GCnZloIfk78ekchlLGkKBrTHE5ZpE5NiCm/y
	Xoa95TIwv/vIZMvtPqgjt2nJoxAHq60T8VCqv0hbrVMiDSKASigWe5Q5R0EDyIvzq7g=
X-Gm-Gg: AY/fxX7tsjhN/NwfTEbgQnEgtfNm3Fv50hfNq3aCxARW2MKz02hl+cbX7oTnItiokUW
	MUym+Upvaffjrjvd6LU1ArcqqXhqmBm1Vd0J9EUIu+M7iWkFvlBpyC4NaMQmOR8YxJBCNO7Y7oF
	9MOFyASHb0Io6wwgrKuSzUjc9hdDxEm2L78IuL7yrBt4ZYg7jUuNPk4TqHBHB03D3rIUJ00RVkt
	er7FPu39A6ROe601DVbTNKKrDWRrRsYspxw3l+YT0XwIJTUeYv2rz69BsmdzBHiR7HvfzlXe4lr
	9LHgtdFrwb9BzAsSfgy9cucVYlcOjQT7Uzj59DPd1cCoqMTl/ZMef2sQPKxeTuezTrI7WpGRA6V
	CvqGdCg6tHTXaRviWLlzvu3lE2uzE2lnaSaDlyX6iWQy8jtMHYRuuJ/oSpJuyREHoiYJf8r603s
	wzaPkCum1087c4Z9W3l9iKtbG7qRsFOOdZlmbxEPxsEwgdN+VH5lX34vWRkQpG2P2CZ38=
X-Google-Smtp-Source: AGHT+IFkPMUDNbhV7qApG1EaAD4bH67XKeWGZyq9t6Oa6ftUcT4ea6J2MjhLCsI7jETaTx/wz1BYtw==
X-Received: by 2002:a05:620a:2681:b0:8b2:e669:987e with SMTP id af79cd13be357-8c3893dcc02mr421767485a.46.1767817465357;
        Wed, 07 Jan 2026 12:24:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51ceb5sm470433485a.35.2026.01.07.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 12:24:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vda4u-00000002F6i-0YUA;
	Wed, 07 Jan 2026 16:24:24 -0400
Date: Wed, 7 Jan 2026 16:24:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 10/13] PCI/P2PDMA: support compound page in
 p2pmem_alloc_mmap()
Message-ID: <20260107202424.GC340082@ziepe.ca>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-11-houtao@huaweicloud.com>
 <07a785e5-5d2e-4c81-a834-1237c79fdd51@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a785e5-5d2e-4c81-a834-1237c79fdd51@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_122427_409120_4DC74564 
X-CRM114-Status: GOOD (  19.83  )
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

On Mon, Dec 22, 2025 at 10:04:17AM -0700, Logan Gunthorpe wrote:
> I would have expected this code to allocate an appropriately aligned
> block of the p2p memory based on the requirements of the current
> mapping, not based on alignment requirements established when the device
> is probed.

Yeah, I think this is not right too.

I think the flow has become confused by trying to set a static
vmemmap_shift when creating the pgmap. That is not how something like
this should work at all.

Instead the basic idea should be that each mmap systemcall will
determine what folio order it would like to have, it will allocate an
aligned range of physical from the genpool, and then it will alter the
folios in that range into a single high order folio.

Finally the high order folio is installed in one shot with the mm
dealing with placing it optimally in the right page table levels.

You could use a heuristic (ie I'm 2M size aligned or 1G size aligned)
or maybe use the MAP_HUGE_2M/MAP_HUGE_1G flags, or something else
perhaps.

Don't follow what DAX did, this doesn't have the limitations DAX had
to work with.

I also don't think drivers should be open coding the
vm_insert_folio_xx() stuff, the mm should have a helper to accept a
folio of any order, the VA and the phys, then install it optimally. So
don't export vm_insert_folio_pmd()/etc please.

Finally, Peter Xu has been working on the issue of setting the
alignment of VMAs when they will be used to hold large aligned folios,
that would help this be more useful by avoiding the need for MAP_FIXED:

https://lore.kernel.org/kvm/20251204151003.171039-1-peterx@redhat.com/

Assuming the folio size can be determined early enough in the VMA
process, though Lorenzo's recent refactorying here into mmap_prepare
may be helpful.

Jason

