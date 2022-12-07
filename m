Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CC7C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ev1V7EMVbOz+sX0QM7wf1hPTVfYf6nYQ8XRYUcsAV9g=; b=pHVOjscmjNZkYhTDIsH4/uwhjC
	9zDHKmo+9nT0ZpGTF1NchXg/JZBu5biJ2tqTaRfEuTLx7YWsuOvRNexohO2aFLFqaUucOCvevgEvs
	IiuChlVUmHKKCie9MItq/9j54c8je1r3nnIJHrMxGvQWs9DlNbMM6uXpdgr588yvBvW71YCEDsNAP
	/a6PVkTP2HmD/CwQnlRhrkCq+5OlAqOfKfMjLdkDjBUNbWvJnix18JIAAGApVtQ4hz75nBsLuFMWm
	L+U0+AhVz+D0kLQg7N2ySAmzcksiikhsVZnwpdknrut1HAfpOY3RYzDYmAwv/pEeDEfx700Qop12i
	9aHcDnTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2xOB-006knB-7n; Wed, 07 Dec 2022 16:35:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2xO7-006ker-J6
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 16:35:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC7F367373; Wed,  7 Dec 2022 17:35:06 +0100 (CET)
Date: Wed, 7 Dec 2022 17:35:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20221207163506.GA2010@lst.de>
References: <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca> <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca> <20221206165503.GA8677@lst.de> <Y4+U3VR2LeEh2S7B@ziepe.ca> <20221207075415.GB2283@lst.de> <4f11e0bb-e090-bf9b-4f98-578273865200@nvidia.com> <20221207134644.GB21691@lst.de> <d28a7848-b284-6c86-a2ae-ab79de3675d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28a7848-b284-6c86-a2ae-ab79de3675d4@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_083515_797354_813C8F22 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 07, 2022 at 04:50:00PM +0200, Max Gurtovoy wrote:
> When we perform step #3 we are narrowing it's scope and maybe some caps 
> that you're concerned of. After this setting, the controlled function is in 
> LM mode (we should define what does that mean in order to be able to 
> migrate it correctly) and the controlling function is the migration master 
> of it. Both can be aware of that. The only one that can master the 
> controlled function is the controlling function in LM mode. Thus, it will 
> be easy to keep that handle inside the kernel for VFs and for MDEVs as 
> well.

Maybe.  So you'd introduce a kernel linkage that both side would have
to be part of?

