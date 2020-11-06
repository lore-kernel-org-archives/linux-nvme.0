Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11742C388F2
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:39:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858312151B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qxP5G+Hx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aVspDJwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858312151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Aomny6+m+Kgb+9rwaqPhpG5xAGrYZFEdjtH4GrmYXHc=; b=qxP5G+HxHguJQlDtQqnLiB2Hi
	auieEOYUyBhnmhky1fD0xHzx4gP1QxBS8g4U7ahUPEyuHDaknV/xn3exIj/5alko6HGbt7jrTZcoq
	kfohyrcQ9+4z9AMK6JA1E5VAUwCIayeRLpaK41zv1aU0/i0qlpCBgewcCcO8ILtiYjran+fyAcAwp
	bU2CFBDRFKzQs2JgToO2ywariUwmkM4wvixOvEzIfog0zxNhbCctPlVTirYzz/219KbGGRWEPHlCd
	ZfZOTdPSfgVh0/oODMR4mhINZeWQ5wfvh3Rk+gz03yaV0TEv4hjwyp0RXzTRp8WtB2lEq2OnUK2ns
	KvGEls49g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb5i6-0000xE-V8; Fri, 06 Nov 2020 17:39:38 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb5i4-0000vv-7Q
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:39:37 +0000
Received: by mail-qt1-x841.google.com with SMTP id f93so1308328qtb.10
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 09:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QqZ++Pt3MZPl0c26h7esX3kKVTLpDd4DLyuldQOeJ6E=;
 b=aVspDJwpvtyG5+kighP26kbunhoVoDrk2g+dikuA78Pm3bA2qTEMgmEOIf1kZJzMIf
 jREWUhSOExSA/q/FCxqA4XBVE24zI+bsJoB1MfEIxBjq2vdyDXVafteyCmFKOVp6mNFr
 a+tx6++MRi2ULgDc9l1aIYs8bYmkHkHdREfE1OJi7rMzsOZFvHKvzXQ7XJqg4Rv2jtLq
 /+Dlp7JoggqKZn8R6W1cCZQ0admWy+NkyCMZtOTh144o5mkYSgGm7bfVWOa4R1qrCUIm
 0U96w1WKj0KdQqF8ogG0DBvSehQPHSPP+p8q7o2QpQF4H1UThgaq/hW1ayZpgvaa/xXc
 nKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QqZ++Pt3MZPl0c26h7esX3kKVTLpDd4DLyuldQOeJ6E=;
 b=adTapbeS9zagVjZp7b10ECpfr7H+lCRwRlhSCTnB1zjPwf5ARbhERGd8U5kGnSPiTp
 0C4ANN5iClkUr7ff0qWsp85ijmQl/mbCZ73UWfgmo/y8rUnSztzWAENeKrElF4uCYA9M
 koZGErVYitTo5UTrFvOZpf8v5ncYEtEbT1qgFzlnx9eQpBIexC5p3lYs4CdDY0fAoC+X
 hDaIf78jflC9wBX9K/ez52ttkMkwXEAESWGinnKsfNgnXgeFdnoMLrMYFpXX96MD67xa
 Cb3sQJeciR2N2l+tV0SZzyG0Pv24XQlUZo748keaHNceQ6qdgKUh0nTRKcsKiQB4ucyq
 ChVg==
X-Gm-Message-State: AOAM533TbQJMbm1QtJiI75RUrfHyxAfApUArQgwtFN60ChJiyr+3xDhE
 zDr7ggGWzWuBEH6jndb7ePKcP3Y07RNVldFk
X-Google-Smtp-Source: ABdhPJwk/LVr/ux401xFB0f8tEBQvqxB/lNHOmPBnGlIZGn/taGrIczG0r9kVyPbYEVYIeCjEKrF7Q==
X-Received: by 2002:ac8:1e84:: with SMTP id c4mr2651870qtm.340.1604684374450; 
 Fri, 06 Nov 2020 09:39:34 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id o19sm1032238qko.3.2020.11.06.09.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:39:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb5i0-000zRk-Qy; Fri, 06 Nov 2020 13:39:32 -0400
Date: Fri, 6 Nov 2020 13:39:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
Message-ID: <20201106173932.GT36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-16-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-16-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_123936_439375_3B3FE690 
X-CRM114-Status: GOOD (  23.67  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 06, 2020 at 10:00:36AM -0700, Logan Gunthorpe wrote:
> Allow userspace to obtain CMB memory by mmaping the controller's
> char device. The mmap call allocates and returns a hunk of CMB memory,
> (the offset is ignored) so userspace does not have control over the
> address within the CMB.
> 
> A VMA allocated in this way will only be usable by drivers that set
> FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
> checked the first time the pages are mapped for DMA.
> 
> Currently this is only supported by O_DIRECT to an PCI NVMe device
> or through the NVMe passthrough IOCTL.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/host/core.c | 11 +++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  |  9 +++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f14316c9b34a..fc642aba671d 100644
> +++ b/drivers/nvme/host/core.c
> @@ -3240,12 +3240,23 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>  	}
>  }
>  
> +static int nvme_dev_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct nvme_ctrl *ctrl = file->private_data;
> +
> +	if (!ctrl->ops->mmap_cmb)
> +		return -ENODEV;
> +
> +	return ctrl->ops->mmap_cmb(ctrl, vma);
> +}

This needs to ensure that the VMA created is destroyed before the
driver is unprobed - ie the struct pages backing the BAR memory is
destroyed.

I don't see anything that synchronizes this in the nvme_dev_release()?

Many places do this by putting all the VMAs into an address space and
zaping the address space when unprobing the driver to revoke the
pages, but there is a tricky race here :\

https://lore.kernel.org/dri-devel/20201021125030.GK36674@ziepe.ca/

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
