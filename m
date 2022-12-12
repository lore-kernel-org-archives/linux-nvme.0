Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E13C10F31
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLUDrSGdWzdKZERgAr7jfBsBF+ux277QdvOu3IszU6g=; b=I8gw8tx86/zNswKP11jXbBg/Ur
	5ndLvD1R5dG/pZPYlTD5xs1maUcSbSC0DvjI9GY8caCWdQujTM1bv1lp2nj/TTgsZ2XKV98PXlqlw
	xBVnrd/rZImoDROHaCC0kWY+txQTypranXMoM0ntPxj+2Db9DfZ27AVWOTpZfh54dXfcAvfSCp9IO
	PEXi11Irs4sMeYOjxFOR/qLL5VeZ3T87HgzWNzz+HCJYvcDiUJp8kgr8GNkbgLDgQDKeZ699l42qb
	hbxLHj3BNf1xUn26VobVdNDJa1XLhenkTxxanuEUgBm9PmuDwFI4f7rjaAlJdMtUE/qF47F3zDg1x
	flH2eqAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4dsp-009roX-3N; Mon, 12 Dec 2022 08:09:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4dsm-009rmF-S9
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 08:09:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 24CC067373; Mon, 12 Dec 2022 09:09:48 +0100 (CET)
Date: Mon, 12 Dec 2022 09:09:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "Rao, Lei" <lei.rao@intel.com>, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, kbusch@kernel.org, axboe@fb.com,
	kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
	cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com,
	Oren Duer <oren@nvidia.com>
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <20221212080947.GA11892@lst.de>
References: <20221206130901.GB24358@lst.de> <Y49JNvdmRPNWw26q@ziepe.ca> <20221206140002.GB27689@lst.de> <Y49PqoAhZOeraLVa@ziepe.ca> <20221206143126.GB30297@lst.de> <Y49WNo7XWZ2aFfds@ziepe.ca> <20221206150131.GA32365@lst.de> <9bc8e614-a687-e419-f9fd-e3177cfb41dd@nvidia.com> <cf88c2ec-bdd6-1df3-6c77-64a17dc3eb86@intel.com> <d4aeda5c-d7bb-4427-5157-fb7530dfd1fb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4aeda5c-d7bb-4427-5157-fb7530dfd1fb@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_000953_071728_298EE47B 
X-CRM114-Status: GOOD (  16.84  )
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

On Sun, Dec 11, 2022 at 04:51:02PM +0200, Max Gurtovoy wrote:
> I don't think that medium migration should be part of the SPEC. We can 
> specify it's out of scope.

This is the main item in the TPAR in the technical working group,
with SQ/CQ state beeing the other one.  So instead of arguing here
I'd suggest you all get involved in the working group ASAP.

> All the idea of live migration is to have a short downtime and I don't 
> think we can guarantee short downtime if we need to copy few terabytes 
> throw the networking.

You can.  Look at the existing qemu code for live migration for
image based storage, the same concepts also work for hardware offloads.

> If the media copy is taking few seconds, there is no need to do live 
> migration of few milisecs downtime. Just do regular migration of a VM.

The point is of course to not do the data migration during the downtime,
but to track newly written LBAs after the start of the copy proces.
Again look at qemu for how this has been done for years in software.

