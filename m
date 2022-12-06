Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D75CC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UpQCizgc+BhSXXXJGOD6HsWmKUqtIQEMMGLawhksOcU=; b=kXreeJkNgdnEAYV+VEmJRk84iO
	7NhdnYBydWA9Zr1CMVa15zRr4HXhJft/c6QP7KOzbFFKQb31yCV34FbbkdZh1fYVvGn9bAQfPo+r+
	7Ll5fmHtiTyGezCDcW0mAkOaD2/+duJTzmVprcgMBuEsVZFFa81HwJ0Kglh1pOmgQT2rAZcEeZJrf
	iOoMDwZbb6Bps/Kq41ofiuuTTc9yf6S0RlPrjKxXAbacX9cjczhW1wi4kHyO63GK6eLahRidGQUWh
	P7m8k9jgv7HDQa6j4z1YCXxFxDZFybifPRkj9CIKhqC+tjEzu+lHLwaVVhUNz3f6pgZrtvfGLNOLF
	7LQXIPAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZkI-00CEpm-4K; Tue, 06 Dec 2022 15:20:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZSA-00BuzV-Vi
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 15:01:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A0CA68CFE; Tue,  6 Dec 2022 16:01:33 +0100 (CET)
Date: Tue, 6 Dec 2022 16:01:31 +0100
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
Message-ID: <20221206150131.GA32365@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-6-lei.rao@intel.com> <20221206062604.GB6595@lst.de> <Y48+AaG5rSCviIhl@ziepe.ca> <20221206130901.GB24358@lst.de> <Y49JNvdmRPNWw26q@ziepe.ca> <20221206140002.GB27689@lst.de> <Y49PqoAhZOeraLVa@ziepe.ca> <20221206143126.GB30297@lst.de> <Y49WNo7XWZ2aFfds@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49WNo7XWZ2aFfds@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_070152_881222_1DBBFF78 
X-CRM114-Status: GOOD (  11.94  )
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

On Tue, Dec 06, 2022 at 10:48:22AM -0400, Jason Gunthorpe wrote:
> Sadly in Linux we don't have a SRIOV VF lifecycle model that is any
> use.

Beward:  The secondary function might as well be a physical function
as well.  In fact one of the major customers for "smart" multifunction
nvme devices prefers multi-PF devices over SR-IOV VFs. (and all the
symmetric dual ported devices are multi-PF as well).

So this isn't really about a VF live cycle, but how to manage life
migration, especially on the receive / restore side.  And restoring
the entire controller state is extremely invasive and can't be done
on a controller that is in any classic form live.  In fact a lot
of the state is subsystem-wide, so without some kind of virtualization
of the subsystem it is impossible to actually restore the state.

To cycle back to the hardware that is posted here, I'm really confused
how it actually has any chance to work and no one has even tried
to explain how it is supposed to work.

