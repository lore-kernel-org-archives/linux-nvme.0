Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0ABC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 14:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVONVhFIMozKQMIv6+ud8+0mfKas86XM8jPahKm21a4=; b=fpoZWTSGQalOgwGqb+0TzyjDJ6
	gzlOMj1YtYu9VFIBs/WOdsjJ45icspWvOaKfWx5GonY6Ema/I8wE7lNHovLcnfTGcg7edrnINSffN
	rX5/eXyjcqTDmwwdCIM8KrC9mq9uRTzT7tdM9o4A0LWPi/9itcIYUKCVsvfJzzTCkM0VzO17Db41M
	NRiA4iZXeI8bhjHIOshZsBM/w63PaxlxWWnVKNePK7qE5DZRTlMYv1j/TV56AJGDyOe88jWdsRQfi
	w71P53PqzLYG6RGxM5H+QHVH/N1cKgWG59HqKprSuS+eognJi93wWu2ks60dqg3KQ2DBu0NUNDJX5
	cxYcnapg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YVR-00AA5f-5a; Tue, 06 Dec 2022 14:01:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YUX-00A95u-AG
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 14:00:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B58B68B05; Tue,  6 Dec 2022 15:00:03 +0100 (CET)
Date: Tue, 6 Dec 2022 15:00:02 +0100
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
Message-ID: <20221206140002.GB27689@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-6-lei.rao@intel.com> <20221206062604.GB6595@lst.de> <Y48+AaG5rSCviIhl@ziepe.ca> <20221206130901.GB24358@lst.de> <Y49JNvdmRPNWw26q@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49JNvdmRPNWw26q@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_060013_972789_048BB356 
X-CRM114-Status: GOOD (  19.41  )
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

On Tue, Dec 06, 2022 at 09:52:54AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 06, 2022 at 02:09:01PM +0100, Christoph Hellwig wrote:
> > On Tue, Dec 06, 2022 at 09:05:05AM -0400, Jason Gunthorpe wrote:
> > > In this case Intel has a real PCI SRIOV VF to expose to the guest,
> > > with a full VF RID.
> > 
> > RID?
> 
> "Requester ID" - PCI SIG term that in Linux basically means you get to
> assign an iommu_domain to the vfio device.

Yeah I now the Requester ID, I've just never seen that shortcut for it.

> >From what I understood this series basically allows two Intel devices
> to pass a big opaque blob of data. Intel didn't document what is in
> that blob, so I assume it captures everything you mention above.

Which would be just as bad, because it then changes the IDs under
the live OS on a restore.  This is not something that can be done
behind the back of the hypervisors / control plane OS.

