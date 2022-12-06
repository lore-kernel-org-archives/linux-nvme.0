Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD276C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W2Wu/VqSKp43h5x2rSzuMUJjgQaWCLtIuyJyNNcr5pk=; b=KgoW7mWqVWWM2D19dyhO5fv0ld
	RtTXU5EY8VvGOgjBX0gBM/9TreA0iew/zERDQ5XpldtyIkf0ziXVZVEbKjvEaykPEd+VOs9qV5UCW
	h3l0vQTEleDaOxFRQHzfJMUCaWXqZK4xc6FlenS5jt278mDk5qIfDAku6edjAn7/58wYnBSqOBE24
	3ge0a5AuJ+19V/TkZOfoJaj4Cg0EzFujiQ0k7K3dPe7q4njTBOuOt6w3S8+dhzhQvg5u1fO2YAzVe
	YWjHjyk3M+gD1zcQEYTkcWRyuYOcn5oBTLh/+REvblvMMVuc5BnryJCaWqe07ZWmC7YtmHoCzFms6
	vS57npHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2bDx-00FUzd-Ox; Tue, 06 Dec 2022 16:55:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2bDu-00FUoq-IG
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 16:55:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B56DF68B05; Tue,  6 Dec 2022 17:55:03 +0100 (CET)
Date: Tue, 6 Dec 2022 17:55:03 +0100
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
Message-ID: <20221206165503.GA8677@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-2-lei.rao@intel.com> <20221206061940.GA6595@lst.de> <Y49HKHP9NrId39iH@ziepe.ca> <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca> <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49k++D3i8DfLOLL@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_085514_768548_E2A74869 
X-CRM114-Status: GOOD (  13.45  )
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

On Tue, Dec 06, 2022 at 11:51:23AM -0400, Jason Gunthorpe wrote:
> That is a big deviation from where VFIO is right now, the controlled
> function is the one with the VFIO driver, it should be the one that
> drives the migration uAPI components.

Well, that is one way to see it, but I think the more natural
way to deal with it is to drive everyting from the controlling
function, because that is by definition much more in control.

More importantly any sane design will have easy ways to list and
manipulate all the controlled functions from the controlling
functions, while getting from the controlled function to the
controlling one is extremely awkward, as anything that can be
used for that is by definition and information leak.  It seems
mlx5 just gets away with that by saying controlled functions are
always VFs, and the controlling function is a PF, but that will
break down very easily, especially once you want to nest the
controlling scheme (and yes, I'm not making this up, as the
nesting scheme is being proposed for nvme privately).

