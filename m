Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76591C3ABB6
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=; b=ZuqmZtVc4fZAS0GKiSVMm2gPeS
	QF6EeH4L1R/UU4aZh4zNSYhZghrtp8xPLalVT9IBGCAQ5AkV1I2tfvj/sACfrE4gSF1OfJpc/miS3
	fx6W/KQXiobrix2dDvEtxypAz1BFBPy0IoCMiFesUFyMPJLeUaeKC8z7jt0ypRd+UYRAQJKPkeZrv
	7ky2iVidJx/s8Qx03OvfjiCJ3fbatPjxzGpLRP68ZvUtbpbu73ZkgUVDzoQel/mKMi0LJklp2OVkO
	9obVOoRvPvXkCmPPtLEg37xk+D7XknIFrrdZhWH1H4PFo0IfTHX746GIeRijXiEwRjv+SCEjBPD1W
	Xw/SIUqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBvFM-00000007O7J-27Sp;
	Mon, 05 May 2025 12:48:36 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBuwU-00000007JbP-3U2F
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 12:29:08 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6e8fce04655so47271306d6.3
        for <linux-nvme@lists.infradead.org>; Mon, 05 May 2025 05:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746448145; x=1747052945; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=;
        b=jh4BcaVR1QiUrehQe0xrBq8y0Lp4FDoRCymwnsKhoHyZ2C7vWtb0QLp2q14ryZucHV
         zBbXDzZPfGJxSbAfuHoauCQVJYOQzWVpFkGDQb3cdYN8cIdsQ5tOHFbeTeQgkgj3Ov0R
         NpHmDkwBOY5PAsApSbvoSpvLTTp7nmmSch8pTdaoPdVd8JcDUgYdBGA4RKflchHMfvyk
         ohTqfUTbMZBLTnjCeP9eYsHgl09g5+LThk+Lh+FVkgHT7xSwEPqvLNMBSkM8Lh9KLNim
         p3caXXGVflRnr7UKiW+pdTm6kH3PkaCTIWqA9BLmSZQVPGNhlFgM9PEhdJUU76qZIyJG
         aUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448145; x=1747052945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=;
        b=KaT7Ol5kSw1vZOc0YskzYROlFct4F4qF/mET23N+xjAqJRiBTV9GXXWCBc1fmNBp60
         IIzP58yLIV4Ks1F5LXTJEZ4Iqlw/8c9Q7dxRpShIvbJBf1Ra7hIN5oWs0A5kyP8GiBAQ
         ufTnm0NexrbA7I5owi8oqnp58+Ssvu/maVhNHINqioCWVJ8Nfor/pkH9VCUOMw4aRV5S
         pIozoOmO7s5ZEsFnol5nJvOOKqotLm0B8g3wI8IEgivRxV0JyuqU5WafQUd3B6atlefq
         M73w7mMpzNMBBQbA11suvJBHYmuKA8tyc8KQ+KKuSkb3rnezvKCQA6zkpGhPXPfAlTta
         xF9g==
X-Forwarded-Encrypted: i=1; AJvYcCW79Tan36TCaY0xibtfoDCSxnkZ1rOvPXXIkMdEn0E7UG1ASIbVHGZ2uaulh0QwWIqQmk+h2DMafeuj@lists.infradead.org
X-Gm-Message-State: AOJu0YznGJTJ+NoQBAYv1bessu5RbKZ5FJQiqRSfvSEaP9aCaL1aloUG
	s2W3CflA8azv472NHvSAkvQM9HW9FE9tLmGJvkwfih6zSaUq6yz6tybZiyxpATc=
X-Gm-Gg: ASbGncsjFxKVluwIXv3sP/LHbJSbA3U1OglkxE73u1KSm50o4NEoEYUZTTcEhpln6eJ
	vihbx4HN0jPwL96ZWkmJWCPulL2dC8/FhMxSycWfkvl5miHCteGWmpe1jY6+qFntBXJysjDoSB3
	xPT0m8YNAxY1SKmqAJtN/uqZ3uV94IMLjsW7BF5Tz3AllhJ9X0szfly5vKV9vHpzIrOEICLLRPH
	SS47sDLNh2pGeubbG+hUZCRBHy7St8zV5inqlaR+Sn4GgoT54ZYnjMBA2J5rRrXO2kM1VW45gPP
	3E0LuPXOOcFIFjkGhYDiKO4F/4khs3DBirkVce5n2RbqgzbGdwbEsJCrLFk49Hedslk2+lspJ9t
	4rQdz5nHlLWq0FgJvot4=
X-Google-Smtp-Source: AGHT+IHrrCkbPkXSi1eXZMzeybSC5P++W/lKXALdeEOdhNPGMmZG6yFN5oZZyeIbSctGCJtNUEnJAg==
X-Received: by 2002:a05:6214:b69:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6f523852b68mr146814446d6.38.1746448144313;
        Mon, 05 May 2025 05:29:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3887sm54983076d6.38.2025.05.05.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:29:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uBuwQ-0000000GxAs-3q1W;
	Mon, 05 May 2025 09:29:02 -0300
Date: Mon, 5 May 2025 09:29:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v11 0/9] Provide a new two step DMA mapping API
Message-ID: <20250505122902.GF2260621@ziepe.ca>
References: <cover.1746424934.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746424934.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_052906_980090_9DB69FF9 
X-CRM114-Status: GOOD (  14.38  )
X-Mailman-Approved-At: Mon, 05 May 2025 05:40:34 -0700
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

On Mon, May 05, 2025 at 10:01:37AM +0300, Leon Romanovsky wrote:
> Hi Marek,
> 
> These are the DMA/IOMMU patches only, which have not seen functional
> changes for a while.  They are tested and reviewed and ready to merge.
> 
> We will work with relevant subsystems to merge rest of the conversion
> patches. At least some of them will be done in next cycle to reduce
> merge conflicts.

Please lets have this on a branch so I can do the rdma parts this
cycle.

Thanks,
Jason

