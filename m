Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35575C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 20:02:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9EF6044F
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 20:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE9EF6044F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e9+gIBNI0m+SST/i3suLX5xIC5iI2nsIjvxyVCspHFU=; b=4FinQj+C3nCoRO
	+ztBQQv5NNqI+v4yjWp8OU6XGwaiLR9zGEfnNL2siHvGgAvqbPwdopvWCQD01UgU4Ac7O5iiI3Lw2
	3nCu7Kf+LIJwKYWI3dPDhQyHqzk2kFiJswekqdPg1gcWxChBkotblbpklUmh9j1gZyhwC1O/TYlPP
	Kd9tWblq3NknPrW+asxUTIq+amVmELirmVAsyZ8ouECeuQyOf7cZFHbD3QlImBWU7NR20FORSVbPP
	8FZKv7XvnhyzcWRWq/6+4a8hxMaBqIIoC8DPFvFzvFOngChfNYscDHJTGhXV8Yx2fiaCMDZP5NXDk
	Ejk3EgdDhJz3VvS4KEZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVJJ0-008jCe-6a; Tue, 28 Sep 2021 20:02:22 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVJIx-008jB7-EV
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 20:02:20 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id a14so75183qvb.6
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8ofNzGMHz0Qp7Vb1PEGbzr+csLxgvNVMaUgwkeEL8ao=;
 b=BTYTlYEgPWO99OPBZyk/cDtFjiKDi6RUgSJ31zCZYRP6tGSCQBiYMS+UXlfSM0VbBD
 6Tu9VdA0CwUny5io4aMB9uF5u1nLSiIwBCKDebs10z/0ZskvnJP7PB1zZvCzBpBiEt29
 qhHuWeg3mDcttX2rZBXbRiaPEQPfCC27N6qrBwkEJroXzsejH0SCT2whj/UIzgeE8KCq
 G0HlbMZZCKbHxBZ07c9L+w8YU9ao1gj0SAdqI8eVVGNZyalMrwaQSzOBrWoj283raOhh
 fjZPTOhOgCStfsb2qPWpV+p11BFXZXufzBmGMyAwN31llm3krg0lMdM93E/edRRHHsRz
 HR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8ofNzGMHz0Qp7Vb1PEGbzr+csLxgvNVMaUgwkeEL8ao=;
 b=J2kGcyMRxJTSLpWSNPzUh17eBuZc8NmHSzvUUgUvisdnfzB4WYBYTGJIOidffo9nqU
 pQtCsh0GqhYLmFvLgvmhmvz6gyfrQWSPVHpKHLZzE1GxvGxZlDdOno8PdpA0hdcSuvz7
 URW1m+hhrRUVoTMSmHcOnV5jTJK+RZvN4zmk0Gj8zij+ZE+AEkF8bEXr+J8x6oMBv+Ex
 0xkQ3b8njylGMInz73C+8SUPzSrdv0+dDC4nks27iAbei97tuPstRDF29ZRsyGRjQUwe
 xLhFWq+zSV0aZK8g5z8ZwenxAdbc0v7gjY61L6BU/1TvZVt+Au5ddX9R4NmKfVt6DoDt
 qK4A==
X-Gm-Message-State: AOAM533cHPsy2PH4xIxIqXaxM0ABwdvmzaudAlYD+1m+IN7Acy4fe0ZD
 T04KbCaz4yYOXgfNI6iEmy3UuA==
X-Google-Smtp-Source: ABdhPJw+cOaZtO6fam+GTeKC9NFUKJArkBLrl4fnuqh08VULcSHQpo9t4cj7egTNmbgVzUNdTaqNrg==
X-Received: by 2002:ad4:54cd:: with SMTP id j13mr7586675qvx.4.1632859337946;
 Tue, 28 Sep 2021 13:02:17 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id t17sm98562qtq.56.2021.09.28.13.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 13:02:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJIu-007GrC-E4; Tue, 28 Sep 2021 17:02:16 -0300
Date: Tue, 28 Sep 2021 17:02:16 -0300
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
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210928200216.GW3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_130219_512929_847B46AA 
X-CRM114-Status: GOOD (  15.55  )
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

On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset continues my work to add userspace P2PDMA access using
> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> patches in this series, but the early P2PDMA cleanup and map_sg error
> changes from that series have been merged into v5.15-rc1. To address
> concerns that that series did not add any new functionality, I've added
> back the userspcae functionality from the original RFC[2] (but improved
> based on the original feedback).

I really think this is the best series yet, it really looks nice
overall. I know the sg flag was a bit of a debate at the start, but it
serves an undeniable purpose and the resulting standard DMA APIs 'just
working' is really clean.

There is more possible here, we could also pass the new GUP flag in the
ib_umem code..

After this gets merged I would make a series to split out the CMD
genalloc related stuff and try and probably get something like VFIO to
export this kind of memory as well, then it would have pretty nice
coverage.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
