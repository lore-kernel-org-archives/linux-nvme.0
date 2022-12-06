Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2BCC3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9DLj6pU7ZId8To+3EmxZLBSnyglnyuBljGwFrd6CRA=; b=WZgo4cmwq6T2zpKlIoq7LarL3N
	tq8coygt+40BEBn4js0xOk34H/EcVUwF6GaldpmesLHqCFixdOIFG7TARk9YkcJUXLIMj67pAWVDL
	Qt6Bik0O0mSffua8Bd1brZlG9AF7b4NDr5mQaKhRZBdKWeLRmzDOBnLAJcTVxzJnEyBQs3DdGoju8
	OFEwwtTMBOx91QbRI/uCsC5TL23mctLiV8Lo3whpnSW7dYUISQoHaDHq/VE7uIKSq9JDpnWn9ghkr
	jI7aRgcC3KjOaUTo1m8EM+QDbXPkGuIdgK1Z8czh66/GCN4W5//qiFqvGyEQv4Gr+VN5jhvH14VqF
	QRy0fjtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2RJ6-001w3m-K8; Tue, 06 Dec 2022 06:19:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2RJ3-001vnb-0x
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 06:19:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 051516732D; Tue,  6 Dec 2022 07:19:41 +0100 (CET)
Date: Tue, 6 Dec 2022 07:19:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lei Rao <lei.rao@intel.com>
Cc: kbusch@kernel.org, axboe@fb.com, kch@nvidia.com, hch@lst.de,
	sagi@grimberg.me, alex.williamson@redhat.com, cohuck@redhat.com,
	jgg@ziepe.ca, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <20221206061940.GA6595@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-2-lei.rao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206055816.292304-2-lei.rao@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_221953_250718_44097C4F 
X-CRM114-Status: GOOD (  11.27  )
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

On Tue, Dec 06, 2022 at 01:58:12PM +0800, Lei Rao wrote:
> The new function nvme_submit_vf_cmd() helps the host VF driver to issue
> VF admin commands. It's helpful in some cases that the host NVMe driver
> does not control VF's admin queue. For example, in the virtualization
> device pass-through case, the VF controller's admin queue is governed
> by the Guest NVMe driver. Host VF driver relies on PF device's admin
> queue to control VF devices like vendor-specific live migration commands.

WTF are you even smoking when you think this would be acceptable?

