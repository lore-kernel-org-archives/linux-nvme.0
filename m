Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83A1ECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 08:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CFds7XLAidVoJOIhtgk4625a0JA0XxXOF9vnzsnO7GQ=; b=a4W4ZzhkCyKT6CnVbY8NEhVTb5
	0YkaYdn91+hz+Ur3+MFpm9n7yMM7cFyzIBuuCRgdJgqQx/21THmOwB/IPWwEazgWiBYV/sgr3ahVe
	eqN7IeNsL/6myzD2q9a0jZea4c9AiaqPeV3EypoqKD+0h0KSGUrbvSkfMIasrpnbriCk1mMU5QrrE
	2WWsJU+DXv2XhrxPYBZWt5zg2BtlW0YFmy/QDPjEfK2HrmUblPWJXN3FEvcQOT8DxgJaPB1YG6Dxh
	WtA6pi3Z5XD1nTReUrwoy9up/Q2KI5t1sREqsYEbR7PEMO3B+8LbeY38/RxUdkNQMpcUuNF4RM9h+
	Q1Gf9AEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdrH-002sxp-22; Fri, 23 Sep 2022 08:16:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdrD-002sva-SD
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 08:16:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6E2FC6200E;
	Fri, 23 Sep 2022 08:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE6C433C1;
	Fri, 23 Sep 2022 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1663920982;
	bh=qQQawoyo8Ms4rX1gVkbqT0fErkXp61RRShIVeBDKDKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9+tOWYJSpa68OMyolen1G+5DULplrdUjy4vXQ2W5eZ0I6oOtsDqosgxCxyn5Uxg+
	 +redHmE741xCg+64+6lVvrTSCeBcS3CZKLk7kCE53NVX586JI8bIsLA2Z/BPLeOB/Y
	 kVm7JeJmU3M/nPyA8FAHfVzZlG18ryXif+fvcTo0=
Date: Fri, 23 Sep 2022 10:16:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 0/8] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <Yy1rUyTlJZU6U6Nh@kroah.com>
References: <20220922163926.7077-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922163926.7077-1-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_011623_994071_042DA9BD 
X-CRM114-Status: GOOD (  15.15  )
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

On Thu, Sep 22, 2022 at 10:39:18AM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This is the latest P2PDMA userspace patch set. This version includes
> some cleanup from feedback of the last posting[1].
> 
> This patch set enables userspace P2PDMA by allowing userspace to mmap()
> allocated chunks of the CMB. The resulting VMA can be passed only
> to O_DIRECT IO on NVMe backed files or block devices. A flag is added
> to GUP() in Patch 1, then Patches 2 through 6 wire this flag up based
> on whether the block queue indicates P2PDMA support. Patches 7
> creates the sysfs resource that can hand out the VMAs and Patch 8
> adds brief documentation for the new interface.
> 
> Feedback welcome.
> 
> This series is based on v6.0-rc6. A git branch is available here:
> 
>   https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v10

Looks good to me, thanks for sticking with it.

greg k-h

