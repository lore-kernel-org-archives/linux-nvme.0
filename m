Return-Path: <SRS0=bzk4=OV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 22:46:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE8861ADF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 22:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CE8861ADF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MEv9GCkguSJRIG2YeVTAia1wNX5tIO+LbrLh+/WuMoI=; b=k2O6t0AIWVG4gD
	sVB314xjTY7DvkKpBpyiztdEuYKgVMFY/CjJOi8HgFNVCaJ3dVxWRnXomt5GtDq+diTtXkA8Aa7x+
	0xBNeuq9ycO4V/R5wipO94SN5Pnw1VZ2JUHRzUUjEjV6f6od/vM7g2czqe9NkZWYi7YenXLx5T7M3
	2qtWyxTH9d5xHqifTHWu//o3dKpN+i9ZmwCP3MKpkX2z+/77HTlSiSlZm26pA1+NApik+0yRxsfNW
	RTFzTboJC2u9mrXg8VaBROw/aGvtYMuso74JFZHx3ZOfFzs1Zyw7avztz6f6OyYcFnMXkDW8Bui/a
	sK1ueD1nCQSLXRWCqFmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWRIA-001P2h-Vl; Fri, 01 Oct 2021 22:46:11 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWRI7-001P1U-VO
 for linux-nvme@lists.infradead.org; Fri, 01 Oct 2021 22:46:09 +0000
Received: by mail-qt1-x82b.google.com with SMTP id b16so10462405qtt.7
 for <linux-nvme@lists.infradead.org>; Fri, 01 Oct 2021 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tnXGytG/2aEvcazdaoXj71bXQnwjyukOXIDiPveIZXA=;
 b=pOTSnHYVXRz06VuaU1BDucThq3XLijVNOmqw8gUYgVjcX4bjaU1DPW80GPFpz1Bry3
 5Izso0qtrLy+uxnjkbarKVIHYAhUgvRAYbABr2JkvP9GCyg+7YRvw6KqUUc7seGsa9fH
 KzDaVUI4r8DRENRxq0vwC8QCWDmKp8VauDJh3yS5lxyhzeb0C6mReZGMghzJA7mUDjLv
 3H6R6bTZK2L5cSKTP/HRhXJP2RtP51MG45N0gotai5Ttri7QJaEBuKZ8DLCGMwehfYns
 QMf6evJgsJzNYeGrSyM/G3W4DM7LKIUGIRGLmulP3Gv60VEJqAsqbGSn5orZIQ0iTuZ9
 WZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tnXGytG/2aEvcazdaoXj71bXQnwjyukOXIDiPveIZXA=;
 b=2cBYPj+p+FAva8hd/wDNi9GYJbNzLAy1uDc3JcVilqZjR3nEMpZvsKbT8cMOr/nLyD
 Y/T24nnraFvf9QH8bQfJuWDlbwGf85c28Jpkc97r0Q8/VbPzfNildrWzgILEihT/WU/3
 NyHRTNOZnuvOT8PhkyNK16Wb1pLRYvnEFIhIncsKHKx+tHM/pWvGdnI1/IapCvWCxIV6
 bnXMgJOVyxL4oqI+MW7ld+wl/UKIFi43q+hLsBHBB69gr2ywPtfA/uCaY54S6/jGnk2I
 P+eqgb/dP1XzdXdedQmjlukqMYckixP8LVbrwYk8qqijSAt2KxZhuQLdVtDEt11CDmiT
 kWBQ==
X-Gm-Message-State: AOAM531/I70jfAPRmMkM4/ip/BIDTOEe72+6alifYumkCZPE3XQZOFxB
 i7Wr0VlcouppBUjOpm2HXME7Cw==
X-Google-Smtp-Source: ABdhPJwIsqD13TKJo7mm1SIikHRk6qEvBFD6JpS7ZAJB6SMruIQLkql7OpNf4qMoVFvzMVj7AMSNJA==
X-Received: by 2002:ac8:7dc1:: with SMTP id c1mr551179qte.289.1633128366918;
 Fri, 01 Oct 2021 15:46:06 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id p187sm3759342qkd.101.2021.10.01.15.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 15:46:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mWRI5-009Y55-Ly; Fri, 01 Oct 2021 19:46:05 -0300
Date: Fri, 1 Oct 2021 19:46:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>,
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211001224605.GS3544071@ziepe.ca>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
 <20211001221405.GR3544071@ziepe.ca>
 <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211001_154608_045654_524CCCCF 
X-CRM114-Status: GOOD (  15.64  )
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

On Fri, Oct 01, 2021 at 04:22:28PM -0600, Logan Gunthorpe wrote:

> > It would close this issue, however synchronize_rcu() is very slow
> > (think > 1second) in some cases and thus cannot be inserted here.
> 
> It shouldn't be *that* slow, at least not the vast majority of the
> time... it seems a bit unreasonable that a CPU wouldn't schedule for
> more than a second. 

I've seen bug reports on exactly this, it is well known. Loaded
big multi-cpu systems have high delays here, for whatever reason.

> But these aren't fast paths and synchronize_rcu() already gets
> called in the unbind path for p2pdma a of couple times. I'm sure it
> would also be fine to slow down the vma_close() path as well.

vma_close is done in a loop destroying vma's and if each synchronize
costs > 1s it can take forever to close a process. We had to kill a
similar use of synchronize_rcu in RDMA because users were complaining
of > 40s process exit times.

The driver unload path is fine to be slow, and is probably done on an
unloaded system where synchronize_rcu is not so bad

Anyway, it is not really something for this series to fix, just
something we should all be aware of and probably ought to get fixed
before we do much more with ZONE_DEVICE pages

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
