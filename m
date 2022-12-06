Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E61DC4708E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4qbkKWhWPanWRYEN6xzgaOcSVOJAns1k+cY++VtfwfI=; b=S8FSd39D3vW6qb9nxu+nJBH8vp
	/EaUnTSAY4ROG4UsO/PHaq3cPNeYuQ3S/O/1x3gDVKunx+H3NU363Wdc2PMkpGPyaT3EEfDwZ1TkL
	mr8KP/PTdfjHRhjKY2JZZC1s+UN5x9lYk2mdw4FJsnn5RZGdiJLpfJDUqjiWNFVP3h0VUa5LPRYtI
	WmzqZoV3ASBym6DR2t4aPd4WD93UETgfQCpdOrsPmgFw66ahITmpGg3foXZV2ViLRk1YTf1iDkJKB
	/yZL3ox+CGLXRSTwhjv5bXEWFJLcMoYf2xd02GfGFcTNVsM0XnAy7cRfdho0j7ZaM2jdGpN6VoPD1
	T/Ru25Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YF5-009ls2-U4; Tue, 06 Dec 2022 13:44:15 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YF2-009loa-Ql
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:44:14 +0000
Received: by mail-pg1-x52a.google.com with SMTP id f3so13405688pgc.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qbkKWhWPanWRYEN6xzgaOcSVOJAns1k+cY++VtfwfI=;
        b=pMTEtuDRlb/LRGsjD9um2ZuhbgiEurbfTulD3JNY4dinWi9LzpixZtViJOlgsP5ukD
         QwZ7ovixznLKNSzMQRS6Vub7GRjRPRign7Qtc3IJa2NYlkptLhko0T28GgSzBD484JJ6
         CRx7ys70PFEALQUZ2MS6I1Nw8MHu0CbeBXoztNU2LHuQnIqLXSWFhzxlxONjWbSjnwwK
         lKAb8L5p2SIHMrFMgBoa2S5bQxyaLRF8qoN7JmSX5Ngnqh5hK9zyDwecixglL3xTef3r
         ZbDAGhH9tnvfkEswYSHUZl5s9FMTFx/elBmvPvSU1zmIDxOgKLXdJO+28vile3hAAG1Q
         oAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qbkKWhWPanWRYEN6xzgaOcSVOJAns1k+cY++VtfwfI=;
        b=oqAe8YHlvQW3Q15p0jH0ziBoCLy9PY6yF58XlJivUqYuNG+I/i92qZuqhu1qSSSAbE
         jwPnNosLa5J5UkZ6mgiwAy6dLJjI54F2XyvoNd4vVx7XgiBRUXHd2T6JbixBEwJHE+Hq
         dDP6qpZ08uK+TLme35LBlhr/miQ3yFpDcDMUciEhkb9DbKWtsiDLl4stQoKCoRjuex62
         jj/C5F1u+/XX6Dls/mqk23EBsG+oUUB5xkG9S5nFlPoqa8HkVtUfhFQf/TerQ5uQaVoa
         5A1crnIYF6/GQEafkpu/Kg4lXIsbxorOBclcu/GgQmbsRZrNJwr5kFSDBxlhri8pyGj6
         OIJg==
X-Gm-Message-State: ANoB5pkAm2CqLoK7jwFAHDedPZUPzziIYlXPr0BVCmrDW384Y2h5fnLE
	vysSNZcUCQ6uvU2AycWrbpye4onmsGDzHLNU
X-Google-Smtp-Source: AA0mqf7qnh+I/sFr2gLN57AjRk8weKbLt5zxdv5BY0erfYcMVzmg1gMkminrCllLyLKwgqjK2bBlGA==
X-Received: by 2002:a63:dd16:0:b0:476:d2d9:5151 with SMTP id t22-20020a63dd16000000b00476d2d95151mr58290007pgg.487.1670334250591;
        Tue, 06 Dec 2022 05:44:10 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b00186acb14c4asm12688493plf.67.2022.12.06.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:44:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2YEy-004bTc-NA;
	Tue, 06 Dec 2022 09:44:08 -0400
Date: Tue, 6 Dec 2022 09:44:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Lei Rao <lei.rao@intel.com>, kbusch@kernel.org, axboe@fb.com,
	kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
	cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <Y49HKHP9NrId39iH@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206061940.GA6595@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_054412_886711_2C8BF1E4 
X-CRM114-Status: GOOD (  19.10  )
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

On Tue, Dec 06, 2022 at 07:19:40AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 06, 2022 at 01:58:12PM +0800, Lei Rao wrote:
> > The new function nvme_submit_vf_cmd() helps the host VF driver to issue
> > VF admin commands. It's helpful in some cases that the host NVMe driver
> > does not control VF's admin queue. For example, in the virtualization
> > device pass-through case, the VF controller's admin queue is governed
> > by the Guest NVMe driver. Host VF driver relies on PF device's admin
> > queue to control VF devices like vendor-specific live migration commands.
> 
> WTF are you even smoking when you think this would be acceptable?

Not speaking to NVMe - but this driver is clearly copying mlx5's live
migration driver, almost completely - including this basic function.

So, to explain why mlx5 works this way..

The VFIO approach is to fully assign an entire VF to the guest OS. The
entire VF assignment means every MMIO register *and all the DMA* of
the VF is owned by the guest operating system.

mlx5 needs to transfer hundreds of megabytes to gigabytes of in-device
state to perform a migration.

So, we must be able to use DMA to transfer the data. However, the VM
exclusively controls the DMA of the VF. The iommu_domain of the VF
belongs to the guest VM through VFIO, and we simply cannot mutate
it. Not only should not, but physically can not, ie when IOMMU nested
translation is in use and the IO page tables are in guest VM memory.

So the VF cannot be used to control the migration, or transfer the
migration data. This leaves only the PF.

Thus, mxl5 has the same sort of design where the VF VFIO driver
reaches into the PF kernel driver and asks the PF driver to perform
some commands targeting the PF's own VFs. The DMA is then done using
the RID of the PF, and reaches the kernel owned iommu_domain of the
PF. This way the entire operation is secure aginst meddling by the
guest.

We can contrast this with the hisilicon live migration driver that
does not use the PF for control. Instead it has a very small state
that the migration driver simply reads out of registers. The VF has a
page of registers that control pause/go of the queues and the VFIO
varient driver denies access to this page from the guest VM so that
the kernel VFIO driver has reliable control over the VF.

Without involving PASID this is broadly the only two choices for doing
SRIOV live migration, AFAIK.

Jason

