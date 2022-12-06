Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071C4C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6lmomtKU2m7NVUDNuYZCowEHtQdjQ36fjJ7MozGmdyw=; b=SJ9bRJH9wnadtv+0a/PXLu5fdB
	/tJL9akz6n7267CrmtmLHNxzTtzsd6WD/DdEtpBrAH3xn3ADaf9NVEGcJQ4i/GsTBLcd9X6EvV2Ol
	7ver0ycSxqwKO6Iq+yvlkLbKOyubv8ezObQpNwgNFpT+f8aMYHNiCNxwOBpt3JbX31LdVz+E+M2E1
	Lzt4HWY7ou5rdJCguQvVIVu1tnZ3ck/Cjz7L6vk2OnP1QGjRrS+9iYxP6SZljV2GfagEZR+b+AHdk
	V/C+1G9uGYksD3ujIL9wjJ3LiJx6sA98xlmMvVCVP2maR7X5VQCtAX+B7qQcoGicYlINY3gLVt97C
	46hnshuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YMP-009y09-Dr; Tue, 06 Dec 2022 13:51:49 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YMK-009xmS-Cf
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:51:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 271FCB816A1;
	Tue,  6 Dec 2022 13:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1752EC433C1;
	Tue,  6 Dec 2022 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670334699;
	bh=T0tECl+xmG6w0G2M4NSz1zr6ar6ZtXwJiCFE6TbkrEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZi7gMbq8B+FXS/1OuUYuWdkweUmNL/lhM3MJDJshCQ6/juDh+jZcL+KhtmNXqlau
	 7LIZfO4dgwQ181y4DwAUq6112FGbvoAjAqw0Tt+808kN0e+AldDa6wYaUb6RxCEDvs
	 R0mCO6+70yfykLt1ZqHUvoJgDEsVt9Dkp21s75OSyURs/pdG17cv+Ly5KuoKA4Svk1
	 8YZZs2TG+M7+HG1Kef00M2Kqfh0e8r3AhTD7x2w4QUMkFZMeHvHR3gm8isTHndWkcN
	 5AKf100eN2p2Bem082iu/A8UIhNMrbhxE2hK9hwVZBLNdwLlMza2lhzdB3xb2PCh2O
	 8KZzypuFsEaWQ==
Date: Tue, 6 Dec 2022 13:51:32 +0000
From: Keith Busch <kbusch@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Lei Rao <lei.rao@intel.com>,
	axboe@fb.com, kch@nvidia.com, sagi@grimberg.me,
	alex.williamson@redhat.com, cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <Y49I5MRsgHdNkIff@kbusch-mbp>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de>
 <Y49HKHP9NrId39iH@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49HKHP9NrId39iH@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_055144_591126_89AA2E65 
X-CRM114-Status: GOOD (  18.20  )
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
> On Tue, Dec 06, 2022 at 07:19:40AM +0100, Christoph Hellwig wrote:
> > On Tue, Dec 06, 2022 at 01:58:12PM +0800, Lei Rao wrote:
> > > The new function nvme_submit_vf_cmd() helps the host VF driver to issue
> > > VF admin commands. It's helpful in some cases that the host NVMe driver
> > > does not control VF's admin queue. For example, in the virtualization
> > > device pass-through case, the VF controller's admin queue is governed
> > > by the Guest NVMe driver. Host VF driver relies on PF device's admin
> > > queue to control VF devices like vendor-specific live migration commands.
> > 
> > WTF are you even smoking when you think this would be acceptable?
> 
> Not speaking to NVMe - but this driver is clearly copying mlx5's live
> migration driver, almost completely - including this basic function.
> 
> So, to explain why mlx5 works this way..
> 
> The VFIO approach is to fully assign an entire VF to the guest OS. The
> entire VF assignment means every MMIO register *and all the DMA* of
> the VF is owned by the guest operating system.
> 
> mlx5 needs to transfer hundreds of megabytes to gigabytes of in-device
> state to perform a migration.

For storage, though, you can't just transfer the controller state. You have to
transfer all the namespace user data, too. So potentially many terabytes?

