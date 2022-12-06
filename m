Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AED7C4708E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9p1ZzFb9vnzpJ3XA7E3Oyvivu73Y47wj+L+tolNcayQ=; b=Wf15mSqYcFjWMhvBKCLUuuyiGQ
	aaMdcaBRzxrw0YwSJbqOkYY9E88cGI9mtjzv2WyCK+QSdF1XDeZruFjFFP9PwQWAGLGJyBrpUbi6/
	RBKo9gv9owOnk3ZLnBBF9xEv93DDtAbOs/6fSB+h/bfE5SRZkSsd37pCBaDUpuWxI8ExmoonKr6j8
	Fet+sJG/TgMqtHVxZAd4KNB4rEkR49GPHLS8IBFPUPtMPl192oxlMy7WjBSllt2UWGpRpbaYInEsr
	PnapCXghChUgOhy61OAHO+EwGQKdTM3db/Fo9a9FBAHd9C/PVKz1O7TnpMicRX3lk1ZtNX2lAPu9S
	0tjWkgeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Yyx-00AoOi-5S; Tue, 06 Dec 2022 14:31:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Yyu-00Ao5U-H1
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 14:31:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F41368C4E; Tue,  6 Dec 2022 15:31:27 +0100 (CET)
Date: Tue, 6 Dec 2022 15:31:26 +0100
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
Message-ID: <20221206143126.GB30297@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-6-lei.rao@intel.com> <20221206062604.GB6595@lst.de> <Y48+AaG5rSCviIhl@ziepe.ca> <20221206130901.GB24358@lst.de> <Y49JNvdmRPNWw26q@ziepe.ca> <20221206140002.GB27689@lst.de> <Y49PqoAhZOeraLVa@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49PqoAhZOeraLVa@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_063136_773546_2BB6B243 
X-CRM114-Status: GOOD (  12.45  )
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

On Tue, Dec 06, 2022 at 10:20:26AM -0400, Jason Gunthorpe wrote:
> In the VFIO restore model there is no "live OS" on resume. The
> load/resume cycle is as destructive as reset to the vfio device.

Of course there may be and OS.  As soon as the VF is live Linux
will by default bind to it.  And that's the big problem here,
the VF should not actually exist or at least not be usable when
such a restore happens - or to say it in NVMe terms, the Secondary
Controller better be in offline state when state is loaded into it.

