Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDEFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 00:37:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF7661288
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 00:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFF7661288
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4eU1yR/4U7OsvZSRaZT9+WvtkhIKYduKZtwh+iRg+io=; b=ywdgcVppA9QMKS
	9K3fDQGJARLAdYK5gCEWAsByveJFgkmPteicRU9CFv2QCmVWAgD/gYa0JpuJxxxJyJ9+oH54flXtQ
	g9uxkABMNP/CRqxsVlYjw/9sQQCaZCVIpQhE24voGwQVWn1OaFe/xfClx5Sb1uONtfq2uw5fpFiDE
	E9wl7mfouoj9FZtQXhnwuqzTYo58xAMx/mqmV3UGfp+0tgZEBT1GOZ/haC4ZPuoTjUIWB6ixoJgNQ
	yWI9gYNKlh4fHgvnLgujxVLqKrWtghRUW7QLwSVU5I7tc28JhvOVnbZM3h9Az47dFbGM/Gd2WnMsK
	YwGa28JDGb/MnEk55xlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVk4N-00CfqI-Ee; Thu, 30 Sep 2021 00:37:03 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVk4E-00CfpE-SB
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 00:36:56 +0000
Received: by mail-qt1-x82b.google.com with SMTP id f15so4114362qtv.9
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 17:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BwrEOqITMVHTWeCijhMHSDgtGtdliHDBULe1zYCMads=;
 b=cnipXcpqu4R5bM9dgEXfQv8BOGJdXA84Z/vct47TAZsrhe6w/r9oUXvVRUGjrFVc9o
 1pqzLcPWuKWB7IKDJ67GQ2rJ0XJHZa9rDepLeYkUUjlUxrxSVALpK00Eq0gEhv5XCimW
 sHs4w+N9g0alec3otIgld2+AWdRLOeWRpLw+d3vtzb9Y7LM/WjCoP1OCGXbI5oFH2wcA
 Od4IxfZeZh+ym8BbKDSyGmZFnDZ/c6eOX1Sg9JX8M/BMCZdpEJadR2DfQiZA22RjHFQD
 9rTLu0GC5IGCqxQldXIJQ2vZ9a0iJRa0h0Mj+ZaME/saY1/RCbRN+q8xTUUHVWNi7uTT
 2+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BwrEOqITMVHTWeCijhMHSDgtGtdliHDBULe1zYCMads=;
 b=H8Ae2A6FC3paOSnrfk/+Zkd/WOqQEOhnl0sG/KqwBUBkXhSDP0Pzejyltl5czaO61a
 Bw1zAVJ4RXA/Nsox2ybEDABeNWmXR3nKyct6Y22y8qmnwyCKv8S2rAaat6WT/Fyg9H8q
 TnGEbY1VlqGHYRF2Qa9C5g5osAh1KAOKt5jMIa820uyOz8/7Q4aAXn4BC9XTQkB+XbrH
 DJAeAAmUwh93UTE+K3tWSwf8DY4vV3YekaLPdggHr8xBLgHq3wRPVFV1UR8B0/vbnjM3
 hS0Z2erHAFK4d1IKvoDXqE09BZFZhrNmXwL2Iy0sA8tu6h6cu6MEnNqgUbHU0IN3jQWq
 TFGQ==
X-Gm-Message-State: AOAM533qrLGeH9oL4+8kS6NExOxpDQ86eHumKGd47ocQ+net6sltBAh+
 JqLLVunXP2iByOgpdNUHZgwKvg==
X-Google-Smtp-Source: ABdhPJyC31MajIpVcurSSZ3nYCkO27psWnTuDsfNku/zaFdrDm/CS7iSRUZR5Bb8yV4im907u+gPsg==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr3421614qtd.345.1632962213405; 
 Wed, 29 Sep 2021 17:36:53 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id h4sm815147qtb.67.2021.09.29.17.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 17:36:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVk4C-007upE-BZ; Wed, 29 Sep 2021 21:36:52 -0300
Date: Wed, 29 Sep 2021 21:36:52 -0300
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210930003652.GH3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_173655_239640_25556BA5 
X-CRM114-Status: GOOD (  10.29  )
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

On Wed, Sep 29, 2021 at 05:49:36PM -0600, Logan Gunthorpe wrote:

> Some of this seems out of date. Pretty sure the pages are not refcounted
> with vmf_insert_mixed() and vmf_insert_mixed() is currently the only way
> to use VM_MIXEDMAP mappings.

Hum.

vmf_insert_mixed() boils down to insert_pfn() which always sets the
special bit, so vm_normal_page() returns NULL and thus the pages are
not freed during zap.

So, if the pages are always special and not refcounted all the docs
seem really out of date - or rather they describe the situation
without the special bit, I think.

Why would DAX want to do this in the first place?? This means the
address space zap is much more important that just speeding up
destruction, it is essential for correctness since the PTEs are not
holding refcounts naturally...

Sigh.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
