Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9D0C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYYN0aTtwouPgTuS2UxnocbhzDnR6yWVgGD69Ak97ok=; b=q5RNPXmtV6hbGsempcr9h1G1b7
	fD8ZEx4snFbPTmaTavOSb4BGBDHs45tXtJSiGJgmmXtgcPnR5oevec3TxNd0I/RJvBn6doaTEdIBF
	yV/1/0sDroZl1KOXzDiV+4YgbZu8cR4kng4KO4V8QbSSWH9IX/I4MfJp5EpqTB3voal3KNf8g2FvN
	nRSGPzut+DZ69Tf9ADF6Pg1cF0nncDaYpZRKVv+YcsqcIyCZP1mcdg58i/Juhh1PVuoRwLNaxIWTg
	baKFSRpuoF9BpQsCdWlssRfJz6IRc6x01jZgRQRzBgp6ZatCkpfClzcA5FaB/CNCtyQfenhSZae66
	n0kr0u4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ulE-0045yo-2P; Wed, 07 Dec 2022 13:46:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ulA-0045xT-V0
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 13:46:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9865D68BFE; Wed,  7 Dec 2022 14:46:45 +0100 (CET)
Date: Wed, 7 Dec 2022 14:46:44 +0100
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
Message-ID: <20221207134644.GB21691@lst.de>
References: <20221206061940.GA6595@lst.de> <Y49HKHP9NrId39iH@ziepe.ca> <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca> <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca> <20221206165503.GA8677@lst.de> <Y4+U3VR2LeEh2S7B@ziepe.ca> <20221207075415.GB2283@lst.de> <4f11e0bb-e090-bf9b-4f98-578273865200@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f11e0bb-e090-bf9b-4f98-578273865200@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_054653_160444_8FF827CC 
X-CRM114-Status: GOOD (  21.91  )
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

On Wed, Dec 07, 2022 at 12:59:00PM +0200, Max Gurtovoy wrote:
> Why is it preferred that the migration SW will talk directly to the PF and 
> not via VFIO interface ?

It should never talk directly to any hardware, but through a kernel
interface, and that's probably vfio.  But that interface needs to
centered around the controlling function for all the reasons I've
written down multiple times now.

> It's just an implementation detail.

No, it's not.  While you could come up with awkward ways to map how
the hardware interface must work to a completely contrary kernel
interface that's just going to create the need for lots of boilerplate
code _and_ confuses users.  The function that is beeing migrated can
fundamentally not be in control of itself.  Any interface that pretends
it is broken and a long term nightmare for users and implementers.

> I feel like it's even sounds more reasonable to have a common API like we 
> have today to save_state/resume_state/quiesce_device/freeze_device and each 
> device implementation will translate this functionality to its own SPEC.

Absolutely.

> If I understand your direction is to have QEMU code to talk to 
> nvmecli/new_mlx5cli/my_device_cli to do that and I'm not sure it's needed.

No.

> The controlled device is not aware of any of the migration process. Only 
> the migration SW, system admin and controlling device.

Exactly.

> So in the source:
>
> 1. We enable SRIOV on the NVMe driver

Again.  Nothing in live migration is tied to SR-IOV at all.  SR-IOV
is just one way to get multiple functions.

> 2. We list all the secondary controllers: nvme1, nvme2, nvme3
>
> 3. We allow migrating nvme1, nvme2, nvme3 - now these VFs are migratable 
> (controlling to controlled).
>
> 4. We bind nvme1, nvme2, nvme3 to VFIO NVMe driver
>
> 5. We pass these functions to VM

And you need to pass the controlling function (or rather a handle for
it), because there is absolutely no sane way to discover that from
the controlled function as it can't have that information by the
fact that it is beeing passed to unprivilged VMs.

