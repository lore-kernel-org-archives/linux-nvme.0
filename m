Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFCBC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ECbvIPPYFOMRjt5hqTRnsP8IshA6qchKHswe2vHFjiI=; b=EQZ9tr0bVFRd5HdmjhAB6U9Kxc
	N7IwuwtXWsHXwHiUvTk8X7lU+Vq55ziHKbh1VA6Lv+ciAhTyefVbdxlQBlt9retPk+SzWWwXbZ77T
	cCd+iduX6Fbi2AuxpxFPpkXQIX3IaYpFUSZ1/AIsF8eofe7jphFCkh+T2SJ00pcxzqjQq7nrK62fO
	oLlP9Yl18eepfkmSSP2yWSZLqceQaB9D5CV8AlWWJ7u9HvJv+S4W7MWhGGBqaDi7lYWyxtE7tLePY
	m85YFLqlYj/7dCYOCIgNB06X9Mi8YtdpmLbbGO9RLb8m90H1bru/lnwQjD6GF6Gm/jhCHGfcIqLX9
	5PfoZTAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZzA-00CkR2-Pu; Tue, 06 Dec 2022 15:35:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Zz8-00Ck42-P7
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 15:35:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7D6168B05; Tue,  6 Dec 2022 16:35:46 +0100 (CET)
Date: Tue, 6 Dec 2022 16:35:46 +0100
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
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <20221206153546.GA2266@lst.de>
References: <20221206062604.GB6595@lst.de> <Y48+AaG5rSCviIhl@ziepe.ca> <20221206130901.GB24358@lst.de> <Y49JNvdmRPNWw26q@ziepe.ca> <20221206140002.GB27689@lst.de> <Y49PqoAhZOeraLVa@ziepe.ca> <20221206143126.GB30297@lst.de> <Y49WNo7XWZ2aFfds@ziepe.ca> <20221206150131.GA32365@lst.de> <Y49fjFD6foGorhmp@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49fjFD6foGorhmp@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_073554_987392_1E453408 
X-CRM114-Status: GOOD (  12.64  )
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

On Tue, Dec 06, 2022 at 11:28:12AM -0400, Jason Gunthorpe wrote:
> I'm interested as well, my mental model goes as far as mlx5 and
> hisillicon, so if nvme prevents the VFs from being contained units, it
> is a really big deviation from VFIO's migration design..

In NVMe the controller (which maps to a PCIe physical or virtual
function) is unfortunately not very self contained.  A lot of
state is subsystem-wide, where the subsystem is, roughly speaking,
the container for all controllers that shared storage.  That is
the right thing to do for say dual ported SSDs that are used for
clustering or multi-pathing, for tentant isolation is it about
as wrong as it gets.

There is nothing in the NVMe spec that prohibits your from
implementing multiple subsystems for multiple functions of a PCIe
device, but if you do that there is absolutely no support in the
spec to manage shared resources or any other interaction between
them.

