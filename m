Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF319C4708C
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aSgRaVWR8iZWB72ixyTeWX7EBz8XGfKB0f733gCuC0Y=; b=zrinKw/duM5bBS+6LYONWpiRMZ
	3qIPb+AZAMQK8fTfSlyxt0QC9Ir5gkfJJ1epDjIcImUaeek0WG9hkW6JglZNt13wi+/IpoatvqRf0
	vfY9T9bFTlYmcyJSV4x5/AcnXP+HEFe9DDeDhrUeVlErz47ENAm5msSquT+fiiwX7sZ7oTQnKRUam
	EIZLIJIF14Ld7XZ8xeLL8fmBFrrTC17IxVWOLr7BruR8+moq48hXS9IvARESYGfj1dOREo49/KdYh
	oawhV6NKoNQTm3MPw7IeXGx83HAr7P1R8RjQm3sZJsoAFSKCwyMbwykowehB7TDr1u90Y1B8fxp+v
	jpawxW9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YSq-00A7oi-Ob; Tue, 06 Dec 2022 13:58:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YSn-00A7ZZ-Cm
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:58:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF0C268B05; Tue,  6 Dec 2022 14:58:10 +0100 (CET)
Date: Tue, 6 Dec 2022 14:58:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Lei Rao <lei.rao@intel.com>,
	kbusch@kernel.org, axboe@fb.com, kch@nvidia.com, sagi@grimberg.me,
	alex.williamson@redhat.com, cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <20221206135810.GA27689@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-2-lei.rao@intel.com> <20221206061940.GA6595@lst.de> <Y49HKHP9NrId39iH@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49HKHP9NrId39iH@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_055826_045786_09524659 
X-CRM114-Status: GOOD (  17.07  )
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

On Tue, Dec 06, 2022 at 09:44:08AM -0400, Jason Gunthorpe wrote:
> Not speaking to NVMe - but this driver is clearly copying mlx5's live
> migration driver, almost completely - including this basic function.

Maybe that's not a good idea in an NVMe environment, and maybe that
should have talked to the standards committee before spending their
time on cargo cult engineering.

Most importantly NVMe is very quiet on the relationship between
VFs and PFs, and there is no way to guarantee that a PF is, at the
NVMe level, much in control of a VF at all.  In other words this
concept really badly breaks NVMe abstractions.

> Thus, mxl5 has the same sort of design where the VF VFIO driver
> reaches into the PF kernel driver and asks the PF driver to perform
> some commands targeting the PF's own VFs. The DMA is then done using
> the RID of the PF, and reaches the kernel owned iommu_domain of the
> PF. This way the entire operation is secure aginst meddling by the
> guest.

And the works for you because you have a clearly defined relationship.
In NVMe we do not have this.  We'd either need to define a way
to query that relationship or find another way to deal with the
problem.  But in doubt the best design would be to drive VF
live migration entirely from the PF, turn the lookup from controlled
function to controlling function upside down, that is a list of
controlled functions (which could very well be, and in some designs
are, additional PFs and not VFs) by controlling function.  In fact
NVMe already has that list in it's architecture with the
"Secondary Controller List".

