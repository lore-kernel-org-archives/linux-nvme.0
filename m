Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8FCC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 00:00:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A67764F19
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 00:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A67764F19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uYMA7FQJF293mBdK3sO9JZtnP0BEOuRNMIQyI3hEcFY=; b=SbNPWLxoq2fvKHIPP1cpxzc3k
	oxL5Br0k2b5TZyqnCxZx/mLAdr3zp1eNIB7H8VJ7ZIQejdY/Oxv0sybGmRQst/AM1EGmBttjkjjqp
	7y/d8utE8ORLH44KDTE09fv8TcyasF5bu/LRXe9ZMSrJr/tOlkfaTU/8e13WeHYWdULu+0g8SarJe
	bqU1sFnqxC8g0pGPYKVgClRbaRTergYO6BHCKzIFLnlOnWwd38jQCXRhfEFVdFiKuf4TnONv+Ycoj
	Y2ghspwxqeNib9nFlB/lroDT8aUX68zKrBiEWN1IrGU41ysYxygjZFpxuhpfBui0IMh7vOJzzqDCX
	v3k4nqD0w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKVDd-00AIEF-Vt; Thu, 11 Mar 2021 23:59:54 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKVDX-00AICY-00
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 23:59:48 +0000
Received: by mail-qt1-x833.google.com with SMTP id j7so2558236qtx.5
 for <linux-nvme@lists.infradead.org>; Thu, 11 Mar 2021 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9rzGlCXRuAYzD4FxF8/kX8t+sLM/xQ6RjW+kfB9MHUI=;
 b=Sht35sRAWhjUnG/vlACxlUdN1NXxZ2hn78xSNsQrOQiOnK1nALUmlUGHUAK1T+DYhZ
 MX3lwQI/UxwTrkQv8d3kMYROr1PLyoiqVafUPMi7P056ufFmL/tRZlvShlZxbmxqDyNW
 NLKw5iBy24OxHbW+DCJ1DQJfzdSe8iTc3c8sHbtF9tFwbdZcos5KLgrKfPlUhIrDUvII
 vIew7klGAO8Wn/28Da6K3YhKEWpKl3Z8yXO4c0K2hvWjTBIXhDYwZP0hefzSiur217jB
 Lo+rOwqj5lF4a/tIzhlWfi67C2vz4vtRgSFudHgU/4CmiKi4zEw8bQzulGoxFckdnomp
 ZbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9rzGlCXRuAYzD4FxF8/kX8t+sLM/xQ6RjW+kfB9MHUI=;
 b=hPIpa/tpw/LK+N2ByVWmk3GhuXv/DRrbXTzARaWuKTfN3E4bKvO2M6UZ0VNilzkYe5
 g2nQxpHuAzAYEA8dGzb5o7mNmlX0jJIgaECK+TKrcZhjsiswhkYRRjq44AenI8iZr7JY
 nUB7fSLQfcvnO4Tu7AJnuZLNwllpcVzbMQFwWsxp/rvmaetd1ZwwZ2WdNt4QYsjIx8dA
 PmiEns8AIgu+Or62Pquoz9GpIznPebdrAaQZlmyNbwPAI+tfGTqS0OEMkdvIf7axZ8DW
 tpr+gdPz6YWusjd8pyHOKCVTbGco5uwp2ip6h36ZUYoeaTUDxVnrNY7IeK5DllSDf1T4
 V0XQ==
X-Gm-Message-State: AOAM530dR6adiOcbxPpLS5FrJe3TLNKXGfboXZKrl8hYAd0NDmtxzj78
 BLArmf5V8i4QU7vEOAXrMs5XyA==
X-Google-Smtp-Source: ABdhPJxiCSaM0aAia7Gh2ystvnvxFkgXLtQu1szm+rOtvCsRMIOPRh5BDiwH0XxEbvHajGL8eIa3Yg==
X-Received: by 2002:aed:20cd:: with SMTP id 71mr9996620qtb.346.1615507185328; 
 Thu, 11 Mar 2021 15:59:45 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id z89sm2953405qtd.5.2021.03.11.15.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Mar 2021 15:59:44 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lKVDT-00BbRW-RG; Thu, 11 Mar 2021 19:59:43 -0400
Date: Thu, 11 Mar 2021 19:59:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ira Weiny <iweiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 11/11] nvme-pci: Convert to using dma_map_sg for
 p2pdma pages
Message-ID: <20210311235943.GB2710221@ziepe.ca>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-12-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_235947_147014_3978DFE1 
X-CRM114-Status: GOOD (  15.16  )
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

On Thu, Mar 11, 2021 at 04:31:41PM -0700, Logan Gunthorpe wrote:
> Convert to using dma_[un]map_sg() for PCI p2pdma pages.
> 
> This should be equivalent, though support will be somewhat less
> (only dma-direct and dma-iommu are currently supported).
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/host/pci.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7d40c6a9e58e..89ca5acf7a62 100644
> +++ b/drivers/nvme/host/pci.c
> @@ -577,17 +577,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>  
>  }
>  
> -static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
> -{
> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -
> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
> -		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
> -				    rq_dma_dir(req));
> -	else
> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> -}

Can the two other places with this code pattern be changed too?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
