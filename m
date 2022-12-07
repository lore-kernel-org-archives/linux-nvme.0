Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0C5C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZBMyZDbc7QumwwSL0lohTnnIwNe3YkrpMxmaWTYx1A=; b=k8woiIbzjFBc3esZk++sHfpmvl
	xgPVsAsuvDa8okfxtRPBE9Xz9/dNQefk3Ews+ROGbp0tWOVl8PQzW4RvLLUlBH5ib1zMEUeR7pfWB
	NKoGLYxhce3YGns0TMh4hyT2gYi3WURqpLcCAqrjpbPLT4mxRZpmmJbCD/MoeBoGKkKkD8UUPm7wc
	Jw6M3nUdnHsANFh0LkABMozEIdtvxxdIW3o12jExmXV4rvPgtk9bqLDSBFlPV5IYpk6oND4q6bv1o
	ZCZN60VsPHnYXuxwHDQjb+q/p4sucTN4BV9Vrv1+2egahKSEJ2BVo8JcAvbh58u8ppz0Us808PLbD
	08hlNm5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2pKE-00EVsw-Q0; Wed, 07 Dec 2022 07:58:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2pKB-00EVp9-3b
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 07:58:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB37E68AA6; Wed,  7 Dec 2022 08:58:34 +0100 (CET)
Date: Wed, 7 Dec 2022 08:58:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
	Lei Rao <lei.rao@intel.com>, kbusch@kernel.org, axboe@fb.com,
	kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
	cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <20221207075834.GC2283@lst.de>
References: <20221206055816.292304-2-lei.rao@intel.com> <20221206061940.GA6595@lst.de> <Y49HKHP9NrId39iH@ziepe.ca> <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca> <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca> <20221206165503.GA8677@lst.de> <Y4+U3VR2LeEh2S7B@ziepe.ca> <2975e217-749b-6929-cd2d-4b6276ef33d1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2975e217-749b-6929-cd2d-4b6276ef33d1@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_235839_331123_DD154F97 
X-CRM114-Status: GOOD (  19.64  )
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

On Wed, Dec 07, 2022 at 04:30:20AM +0200, Max Gurtovoy wrote:
> I'm not sure how awkward is for migration driver to ask the controlling 
> device driver to operate a migration action.

It can't.  That's the whole point.  The controlled function that is
being migrate must be absolutely unaware of that (except for things
like quiescing access or FLRs that could happen anyway), because
otherwise your have a fundamental information leak.

> The controlling device driver can expose limited API for that matter.

No, it can't.  It must be in charge.

> Also the concept of primary controller that control it's secondary 
> controllers is already in the SPEC so we can use it. It's not introduced in 
> this RFC but we're here to fix it.

Yes, it is as I've pointed out multiple times.  But, that relationship
is only visible to the primary controller.  It also doesn't help with
the general problem where the secondary controller must be able to
completely change it's identify and thus the subsystem.

> In our case the primary controller is the PF and the secondary controllers 
> are the VFs.

Yes, that's your case, and probably a very common one.  But also far from
the only one, so there is no way Linux or the specification can rely
on that dumb fact.  Never mind that there are virtualization schemes
(look at the s390 code) where the PF to VF relationship gets lost.

