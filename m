Return-Path: <SRS0=bzk4=OV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74424C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 13:49:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB5B615A4
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 13:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BB5B615A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xTPisvJgqk+AEkkqA0/GksIZZulykvkEjva0Jhnycow=; b=Qgyw/ZzARfdL/8
	dCbmx9FmO9F4X5TP8VmHd0hrR2FLzaFfQU0GxkxSuXo3rzCVEShOLsUFbCKpxaIPUhWHaKDJBm9mJ
	IqdK1JNMdUufUdNeQ0ljAagFHrvmaZ7wifxDlJjVFsGgo3w9CEhWHUhaIwIpED1hxTLmU/8j9+vam
	le0Oa2kigq/IjvwPsQzYXsx1YbkGLd4DAhfv9ZnKBB0w6w0liv5pmXaPAXtbgon+rlsnTJFwY6Obc
	mxU9rfZZmfJrf25bxSNULwSivNIuj+SEyEnp/4k4c/KkoPVqBgdBuTV832y4o0lWwU0paKldMh2wc
	E3QP0f0svQUY4SDlqXnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWIuN-000SFG-Fp; Fri, 01 Oct 2021 13:49:03 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWIuK-000SEC-Iu
 for linux-nvme@lists.infradead.org; Fri, 01 Oct 2021 13:49:01 +0000
Received: by mail-qk1-x734.google.com with SMTP id 194so9117795qkj.11
 for <linux-nvme@lists.infradead.org>; Fri, 01 Oct 2021 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LG5nuVM12UKCUvMUz/H7oZ+JnPtb7xeOrg+cdikjdUw=;
 b=i2nZSJalGl2HFR2lljteQga9LLzznj1VY4sKfMFrOuI5TPw+9fxa9Y7VF6ORCDu6gf
 s1VZcbmu8prmAySSW0muDV9sPFy+ocsOAHMu7czDjdTka8/r9gDirvuLv+DjNcMP+yu2
 2vpgG0jpIzFJO3o2EESr3Knc9sAVcu/3zrGpfyryk0rXsa3CM7UVEgJZI2lyiRkkfNpM
 06X0/la9ZF1/JOw1nIH1hT6QVKTk7TJuv33hiHw5ih9p7MWcfmzNHEd0oxDuij3diKPb
 ruwnbMTM1vlfPcAVocSCOhTaVtV1FJ3tIhW47hPjbC6RUYlSTDx8/p4BvGKL4lQu/579
 YBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LG5nuVM12UKCUvMUz/H7oZ+JnPtb7xeOrg+cdikjdUw=;
 b=HHOLMojhM3VflinztWeKVJjNmBRFJiuolTqlWA4ohiZayqWbX5L77zCwnqglktup2+
 l5jQ9JgmECt8BucU8mnedIJbTwHYsvnfjnQd7GetTs0GT2/1miqMLcgVJIVeA7ncY9bW
 lwR7hK7LwrXV9SA76KeGohyGfa0bm0pf/pObRCJNmq9amULpNHiZxyXBJ/TQ1aM46cpx
 sYqpGCQSinV7QvaWfCMTScSPbq3Lk71ZViStv1zxttjDpwIiyk+KGTj0eVI73Xp2DxLR
 WuFOh0DgAa1Q6qS+N/k8DD+dwScKKUxEzaon0/p4rv4Lw60RswxOi/Kj5IqJJTGSGLVj
 Akbg==
X-Gm-Message-State: AOAM533Q1Ns8kjKT7+g4k34epfnsZiHSqDqqzDSlcQ9Lh8Flc3e+5gQn
 03jiS7IrmNC6082Rew3cEuy29g==
X-Google-Smtp-Source: ABdhPJxAWiRAix1MOnP+fusB3RWFs4aefuUjIqiau0+pjC7MwPUEHTq7EjNfCISJpSPUQC5qQMYTaw==
X-Received: by 2002:a37:65d6:: with SMTP id z205mr9907719qkb.522.1633096138367; 
 Fri, 01 Oct 2021 06:48:58 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id u19sm3747206qtx.40.2021.10.01.06.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 06:48:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mWIuG-008R2P-Oj; Fri, 01 Oct 2021 10:48:56 -0300
Date: Fri, 1 Oct 2021 10:48:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>,
 Alistair Popple <apopple@nvidia.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
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
Message-ID: <20211001134856.GN3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210930003652.GH3544071@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211001_064900_648428_4B0BA891 
X-CRM114-Status: GOOD (  16.24  )
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

On Wed, Sep 29, 2021 at 09:36:52PM -0300, Jason Gunthorpe wrote:

> Why would DAX want to do this in the first place?? This means the
> address space zap is much more important that just speeding up
> destruction, it is essential for correctness since the PTEs are not
> holding refcounts naturally...

It is not really for this series to fix, but I think the whole thing
is probably racy once you start allowing pte_special pages to be
accessed by GUP.

If we look at unmapping the PTE relative to GUP fast the important
sequence is how the TLB flushing doesn't decrement the page refcount
until after it knows any concurrent GUP fast is completed. This is
arch specific, eg it could be done async through a call_rcu handler.

This ensures that pages can't cross back into the free pool and be
reallocated until we know for certain that nobody is walking the PTEs
and could potentially take an additional reference on it. The scheme
cannot rely on the page refcount being 0 because oce it goes into the
free pool it could be immeidately reallocated back to a non-zero
refcount.

A DAX user that simply does an address space invalidation doesn't
sequence itself with any of this mechanism. So we can race with a
thread doing GUP fast and another thread re-cycling the page into
another use - creating a leakage of the page from one security context
to another.

This seems to be made worse for the pgmap stuff due to the wonky
refcount usage - at least if the refcount had dropped to zero gup fast
would be blocked for a time, but even that doesn't happen.

In short, I think using pg special for anything that can be returned
by gup fast (and maybe even gup!) is racy/wrong. We must have the
normal refcount mechanism work for correctness of the recycling flow.

I don't know why DAX did this, I think we should be talking about
udoing it all of it, not just the wonky refcounting Alistair and Felix
are working on, but also the use of MIXEDMAP and pte special for
struct page backed memory.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
