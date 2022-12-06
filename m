Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5783C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBw4GoLXylEeInY9aM7/58wBqzSxKE5sngF/7k3KKjM=; b=PjUndjzspvwecFyOPSz3ueY1lo
	n8K3Nvd1MDxeMlC2T5WLlFmvH8HpR/kUSkFeHmk9zLnoWxWvilPJ9OPTJx1kgWhuUvBfCnQDYRzZ5
	kV7i69ji65vEjCO8QIScZd3PMtIRZsVRmE038w6KkOzoGz4DjDlmOA+HqSo52k7cvK1AET/FP4Tay
	/GMX1myRn8N0ByxOyotazIvZALbdhC7zcXjtEbTKmzgpwsqtY8YJEgzo7gf0mlKVQIVGkVQHkVDar
	IEtrn+ygq/k7pcQOwM9bnZBXVYzIYltuC5sVUoOFw0jZVaA4jKz7WHesj58JwAsS02T8c+1CyHC9p
	iNuG0UKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2a1T-00Cu1U-7l; Tue, 06 Dec 2022 15:38:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2a1R-00Ctqs-48
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 15:38:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 832A468B05; Tue,  6 Dec 2022 16:38:11 +0100 (CET)
Date: Tue, 6 Dec 2022 16:38:11 +0100
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
Message-ID: <20221206153811.GB2266@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-2-lei.rao@intel.com> <20221206061940.GA6595@lst.de> <Y49HKHP9NrId39iH@ziepe.ca> <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49eObpI7QoSnugu@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_073817_353150_48ED27BD 
X-CRM114-Status: GOOD (  14.72  )
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

On Tue, Dec 06, 2022 at 11:22:33AM -0400, Jason Gunthorpe wrote:
> > controlled functions (which could very well be, and in some designs
> > are, additional PFs and not VFs) by controlling function.  
> 
> In principle PF vs VF doesn't matter much - the question is really TLP
> labeling. If the spec says RID A is the controlling RID and RID B is
> the guest RID, then it doesn't matter if they have a PF/VF
> relationship or PF/PF relationship.

Yes.  Or in fact if you use PASIDs inside a single function.

> We have locking issues in Linux SW connecting different SW drivers for
> things that are not a PF/VF relationship, but perhaps that can be
> solved.

And I think the only reasonable answer is that the entire workflow
must be 100% managed from the controlling function, and the controlled
function is just around for a ride, with the controlling function
enabling/disabling it as needed without ever interacting with software
that directly deals with the controlled function.

