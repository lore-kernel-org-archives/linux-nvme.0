Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64E4C4345F
	for <linux-nvme@archiver.kernel.org>; Sun,  5 May 2024 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKB6YLSNJL854QSVR6Ylw1i1qlJgNfvLSDvIS/fCb8M=; b=KKj/eYL813k23skzU5oHTlWOO+
	aCPtaGdEo8StTuBxMm2YBXINPeAywsgC2mPLWLtAFil6Wo+yuR8GfOUcwKU4md6fsf+tyvTAuqD7V
	A2EL6wfsj7eqAV3DFCRpLbnL/qJbtWqqY1Ww9RGwM+9+THGvWsxtcxcrqE/PLyey5bYSgdehYG2B/
	Ye9pfvuaA9P4SHL6K1X9hjN3ypjyqh4nla6A3ZAmLo+6/uY4XqjPDzs+ku3jaOk9mrOHWkcWhzEXF
	KRSVJAlQAyWO9/pKnoezjZNQZs1igRbVCkmwmruc1j4SnUhYwPeNI9Ybk+sK9U/k1CNe4I1Y+ycNT
	8OnjAn1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3fIl-00000004s5J-0wGu;
	Sun, 05 May 2024 17:05:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3bpq-00000004Khm-3yHt
	for linux-nvme@lists.infradead.org;
	Sun, 05 May 2024 13:23:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 96D1560C64;
	Sun,  5 May 2024 13:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5357AC113CC;
	Sun,  5 May 2024 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714915399;
	bh=jjLgkhsN4WjaKTyfGnNOYYnBmrIQeAxiqhWYRqvmHnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5GHCqguzvr4zXSvt+GZwExP+D4+ViMFS5ymKVV8WJY+Di3qvsEp58G9bzM0BAvHF
	 stRLiuNs0tAjzhnbTK/8wL+10XQCHTZHBZmaoU+SwNNRsdc3zzqE5WaLVDQBWFhIvC
	 raDXBTYUnDUM4UtQUw45YXqktzY6vnT/akcSLM5mL4wzzUFTgqPDcpICsM95p6XfvX
	 O4u+h30wrlLfM0mEibSSqU02f0NAECeoPPcaFHr27oYznJKIN+ZSxxnHDgLyJZSjxm
	 mLLAI46IamcYUju5EL6BBITjFGKFCEyP7IgsxkDT4H6bFHDEu7oWOLwbNzfk28/Nrq
	 GrAQIMAtf2uAg==
Date: Sun, 5 May 2024 16:23:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>
Subject: Re: [RFC RESEND 16/16] nvme-pci: use blk_rq_dma_map() for NVMe SGL
Message-ID: <20240505132314.GC68202@unreal>
References: <cover.1709635535.git.leon@kernel.org>
 <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org>
 <c9f9e29e-c2e1-4f99-b359-db0babd41dec@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f9e29e-c2e1-4f99-b359-db0babd41dec@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_062323_057864_577B3F7B 
X-CRM114-Status: GOOD (  20.32  )
X-Mailman-Approved-At: Sun, 05 May 2024 10:05:23 -0700
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

On Fri, May 03, 2024 at 04:41:21PM +0200, Zhu Yanjun wrote:
> On 05.03.24 12:18, Leon Romanovsky wrote:
> > From: Chaitanya Kulkarni <kch@nvidia.com>

<...>

> > This is an RFC to demonstrate the newly added DMA APIs can be used to
> > map/unmap bvecs without the use of sg list, hence I've modified the pci
> > code to only handle SGLs for now. Once we have some agreement on the
> > structure of new DMA API I'll add support for PRPs along with all the
> > optimization that I've removed from the code for this RFC for NVMe SGLs
> > and PRPs.
> > 

<...>

> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index e6267a6aa380..140939228409 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -236,7 +236,9 @@ struct nvme_iod {
> >   	unsigned int dma_len;	/* length of single DMA segment mapping */
> >   	dma_addr_t first_dma;
> >   	dma_addr_t meta_dma;
> > -	struct sg_table sgt;
> > +	struct dma_iova_attrs iova;
> > +	dma_addr_t dma_link_address[128];
> 
> Why the length of this array is 128? Can we increase this length of the
> array?

It is combination of two things:
 * Good enough value for this nvme RFC to pass simple test, which Chaitanya did.
 * Output of various NVME_CTRL_* defines

Thanks

