Return-Path: <SRS0=bzk4=OV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD915C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 22:14:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1304D61A8F
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 22:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1304D61A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4vrqVbV8CTkAwXLLDg02ji0ZvH0JXDxKW3T3pKMJHic=; b=qJQR/PTptKRe9W
	PHK1RHfUcdAzeo1fsUiYmbzikpCHEX8hlkXEFBBmH58xhxR1EKb3/FCv2RWiMCCtLquMddlNI+4Fp
	vm/A+RVOdZV5Nelo7NQwRMzPVC0uLmzQhEF4HC3LKYjbp9uY6en67NHWeMS2G1c/51g7tFjcuM/PE
	1pvcJw9Gq0r7XGY8X4UuP9Paq9q0dX1SEA/634c5QbDljLb1DgJP0SQwb25N6nPFSEsVY/rCxAxSQ
	f/q/Z3jb44mnePAkihqiwK0rWOs1jTaVd7myS0DFqNeBC2PRLNt98EXJVdb3PF73Ibj2haNrwdWsd
	R+HiZPqL+eMddJHWUd3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWQnD-001NKV-5K; Fri, 01 Oct 2021 22:14:11 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWQnA-001NIy-RL
 for linux-nvme@lists.infradead.org; Fri, 01 Oct 2021 22:14:10 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id d20so3029366qvm.8
 for <linux-nvme@lists.infradead.org>; Fri, 01 Oct 2021 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Dlj3GwcHZB/hfgpWys67iaiDnLMMEzD7BT0/JUJOZSA=;
 b=EYJBCgdxRWFQwama5Ss0sx2D4qnIU/NFx7XF8E6GPLVVfNfvYaFMHC2BJIcCXsVoIF
 iCVvjpeBI3ImpoxruP60EpxdKHxMF088MpggWRWO7IYnFWYmW7H6nN3tO2gp7dE0tPcr
 PZxWZiHqQ0kOXeNKhD0DGvipG0AB/RuuNPtsQvgGuq0gEvYHfaW0BPvSOUVVBNQSYbh9
 0YWWGW3L+w61nc7KMA8GAJec757jPzc4w6+ESAcdFTN5R3q4fIgS/oiFDTnJz8JfMv7h
 ts1ZBK4JepAEgYw1PQejU7GFCd4skwXqph1TdAhgLH6c2/iHJ7h16XxYT4AhYwcn5M99
 FT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Dlj3GwcHZB/hfgpWys67iaiDnLMMEzD7BT0/JUJOZSA=;
 b=1j+dfdGtLX7VNNaeo1NVAFwJwhqYa7QyYMHulXyjZAGN3vy2h6+XU7QuqDhH6hCHjZ
 2dF9RCqjGvD4urdl7JgoCDbR9z/kDaskQiR9hvqLLeG01VE+cyeEAbcQ5EI0/skRZjqi
 QAklqbhPT78HtDfpPsMQP9hFFHRFS/rPxVqTIRZ8nrBMhRorTcvFDWFfwhk/Ti9cJkN3
 Na9+cZQs9TyaEEDQ6aF+3RBzUJugaO8zV8c8s2BhUy6I2XVrT2ZB4YL+0Y2AIC7maWRw
 pNcZQMEr/+75i5rv6qVzbuFcMDiExKOw9t5DasbjR7dIl9jzG/wiUCxHHTCeKTFYmBEB
 /J5A==
X-Gm-Message-State: AOAM532tDWvPxcdcUjNmBdCPuY85tfWkuF88fqNNP4jznFCsdCmeteLu
 vWBnylAun43voO96CWxlBjpVLg==
X-Google-Smtp-Source: ABdhPJxstfy2KGuFAOeM51qITA8tU2CEYk8H/V5BgLnRDG7386cROIjg8GYfgca/wk61maljwb6gxg==
X-Received: by 2002:a05:6214:dac:: with SMTP id
 h12mr7351043qvh.39.1633126446714; 
 Fri, 01 Oct 2021 15:14:06 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id p9sm3635312qkm.23.2021.10.01.15.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 15:14:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mWQn7-009XgW-9E; Fri, 01 Oct 2021 19:14:05 -0300
Date: Fri, 1 Oct 2021 19:14:05 -0300
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
Message-ID: <20211001221405.GR3544071@ziepe.ca>
References: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211001_151408_966050_43A6FF44 
X-CRM114-Status: GOOD (  18.02  )
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

On Fri, Oct 01, 2021 at 02:13:14PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-10-01 11:45 a.m., Jason Gunthorpe wrote:
> >> Before the invalidation, an active flag is cleared to ensure no new
> >> mappings can be created while the unmap is proceeding.
> >> unmap_mapping_range() should sequence itself with the TLB flush and
> > 
> > AFIAK unmap_mapping_range() kicks off the TLB flush and then
> > returns. It doesn't always wait for the flush to fully finish. Ie some
> > cases use RCU to lock the page table against GUP fast and so the
> > put_page() doesn't happen until the call_rcu completes - after a grace
> > period. The unmap_mapping_range() does not wait for grace periods.
> 
> Admittedly, the tlb flush code isn't the easiest code to understand.
> But, yes it seems at least on some arches the pages are freed by
> call_rcu(). But can't this be fixed easily by adding a synchronize_rcu()
> call after calling unmap_mapping_range()? Certainly after a
> synchronize_rcu(), the TLB has been flushed and it is safe to free those
> pages.

It would close this issue, however synchronize_rcu() is very slow
(think > 1second) in some cases and thus cannot be inserted here.

I'm also not completely sure that rcu is the only case, I don't know
how every arch handles its gather structure.. I have a feeling the
general intention was for this to be asynchronous

My preferences are to either remove devmap from gup_fast, or fix it to
not use special pages - the latter being obviously better.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
