Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B670C369D7
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wWxVg46eMCFdiWQ6X6K5wh7BwyllE/TFgcnWyILw7vo=; b=K99/ftzt81kpq/3Lq35j/X0l7A
	icUWA4ESGntS3r4tv99L4dAF2lFI22ygISij4Wuba8MMaqbLHqZQmAlFe/RQmnPZ9FTZUTOSJiNHV
	GelXZa/ueUfBpqYui9qBj3cWqCD0WbD/e/DbX9xSXYVTIkYbXhL8gcxazfBemUDxIxpcZ4PIc6/Mm
	JIz4Ql1i5mPyleuKe2H2LCqTqS7XvVNHyXrE+ywBuaGeqNRzdjWWU/LCT8Lyt+rrd4U3GQVE9Y959
	15CYISx2GiFGnl87LwHZu0q8WYWnq3al2FS7dSlmcu5uujb+bOV6tNncFSWB3VSVSvgAsQdkGECdU
	aMycVVjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ezd-0000000BbUz-03ks;
	Wed, 23 Apr 2025 18:38:45 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7dSQ-0000000BCn4-44Fk
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:00:24 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4766cb762b6so1237361cf.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745427621; x=1746032421; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWxVg46eMCFdiWQ6X6K5wh7BwyllE/TFgcnWyILw7vo=;
        b=mgYHez6XbGTzxHGdGw/LqrinWtdbKFLH/qRsJHyxM12sZjldaibRsCzA3aLM8nBowV
         70e5Q1aEBYAOOpqGeWpOkx2UljOGYCfRrDuOBnQTF+C5FkgFY7KsfvQK4sor/fsp0aPN
         KVqkAk6ULvptzFhihImcb/SsNbkSBsKHTxhdseM9wuJjx8aOZqmDVA9FKC/1yBcKC+z9
         /RT4+OKlH92ctUTCwanI3LzIqzhYYW5P4FuQZfxUxP6/sR0rEshPkcGigq108XZxok8j
         Zh0AmQiYw620I1AnWXSVNf5pBWdbqYsM2T7qa8e9+sJ880+sBIr0su7ooRkocmw132dT
         TB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427621; x=1746032421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWxVg46eMCFdiWQ6X6K5wh7BwyllE/TFgcnWyILw7vo=;
        b=fW19MGlWrhR6cMc3ExNFuh8QHUHw6ABwdmwInB3WXTFi/r5ab6wFc6VO7aBgbXFYbK
         XkdatGBI7TBV7stw0/Q2fYNwUGCcmECjrCXIOVqko6IgFpXWSguClJsksdarvWeeKsm2
         6gobYefvZiohIXikDYpbGR/xrGTwLZ2xuG3957o1nrNKjf5pWdMkQizPwAIvHpv4KeOX
         vgSbnJ8QOaoBn1jcdJPODXgb6i16XB/jwUDd2s9dCvmqPBnQPvdymtoy0EzY2SWaQwn+
         nJxZ/cLTlUCHn7CHhdOxOJCQbeZnntunYAPOZpfnaty7UYShxug4kkbYjeevSJRQN4c6
         jQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUiY6HG/dliJ6lhRWmqIzZcFl0vDHPq1aqetwCQOrumECPRahQ4SAdKf5XfiwrDCmybg2SGHRb35lys@lists.infradead.org
X-Gm-Message-State: AOJu0YwPdO3SKurowU7mnqQyGp1W/PwKSsofywH/c6sCbNjh67nMo22P
	ITfIq3ygdlFGu4hpMiJ6qtSg3e4lMgDeSDpXuaTU26E7sCfYolo6DHmbeM7kmMQ=
X-Gm-Gg: ASbGncu8JEWvZxAYL3s/+PCZ9AxTHXV0Cfko0NcO2fd5TAES0BoEGdyBiiUejjk+IKi
	vir6tkFXDJ/JyVg1dtyOfmqY/fGgHYE6OyhMR6mlg7vY3YJX49mxtsyT7JS/Hbr4355h8Dvep3Y
	Po4sNeTGqspxzu86u6rvGGrBu2FT+XRnpXKh30m4e+9tzYGGF6hQmXOGo38I7Bs8AQORihftK/F
	q5A5ad2cOqzvTsxYW6iaKTJVcm/gB28VugQK8FQ2s9FG6gNJn5/n8Jw30G80gx5GtC0K/4raXxU
	Q8TLkAPPsmrLVV4Zt4BDwFMbYPiXtXLm7zuxcaLyLLa2K/R2iQs/c/p1lVLvGPBLBxwAO8KrShM
	JnOwAcWgmU22rcJNwRd54iRWdKopkJw==
X-Google-Smtp-Source: AGHT+IHksHmB8zXVAbJv0K8R7XmlcjQan86yStXGt3YpvcZVpCrvagDTNNdOsaaJ2R0ZGC6sR1O+4g==
X-Received: by 2002:a05:622a:118f:b0:47e:641:9665 with SMTP id d75a77b69052e-47e0641979dmr20773641cf.5.1745427621264;
        Wed, 23 Apr 2025 10:00:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfcfd0sm72347416d6.82.2025.04.23.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:00:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dSO-00000007LHo-0vIz;
	Wed, 23 Apr 2025 14:00:20 -0300
Date: Wed, 23 Apr 2025 14:00:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250423170020.GI1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
 <20250423092437.GA1895@lst.de>
 <20250423100314.GH48485@unreal>
 <20250423154712.GA32009@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423154712.GA32009@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_100023_009085_4EC701D1 
X-CRM114-Status: GOOD (  17.94  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

On Wed, Apr 23, 2025 at 05:47:12PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 01:03:14PM +0300, Leon Romanovsky wrote:
> > On Wed, Apr 23, 2025 at 11:24:37AM +0200, Christoph Hellwig wrote:
> > > I don't think the meta SGL handling is quite right yet, and the
> > > single segment data handling also regressed.  Totally untested
> > > patch below, I'll try to allocate some testing time later today.
> > 
> > Christoph,
> > 
> > Can we please progress with the DMA patches and leave NVMe for later?
> > NVMe is one the users for new DMA API, let's merge API first.
> 
> We'll need to merge the block/nvme patches through the block tree
> anyway to avoid merges from hell, so yes.

RDMA has been having conflicts on the ODP patches too, so yeah we need
a shared branch and this thing into each trees. I'd rely on Marek to
make the shared branch and I'll take the RDMA parts on top.

Thanks,
Jason

