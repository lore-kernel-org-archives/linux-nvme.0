Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0724FC3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 06:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dOyeCXTp1/UlAgaqjmoJMi6dt0KkYtBLDZN51Jaqp/c=; b=EI7VTgoNmJ3YSiZWLDfhIoa2aH
	oo1aOKCbMLl8PWkZtF0oCS20ZlDBmbwNpg2/t12p70fx5aE9ChbV9apNjZmiGOD8qYjAvKo3JNxbv
	Q6JgDS00Deb62FF2WPL1MNn9op7k5HBSt+upW4DM5xensnF559l90C5euw9xhy7CBE/IPKpkj++7W
	mouEqERk2zp8gInNkfs8gHAjqO+DJLNCjrN6QETfnSN1mNpGHVAHdrM0OH2xNxclUWG+qKhQLQJX/
	g/EfjwDV92QuvN3wTBS4vUdrP4CCzDOoDRtbDziHlk7lK4WJ7zOrY+BYCQ+ge5iuOTmTIlIpXPLup
	Wrxzjckw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2RP9-0024OW-DK; Tue, 06 Dec 2022 06:26:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2RP6-0024MF-Vv
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 06:26:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC88E68B05; Tue,  6 Dec 2022 07:26:04 +0100 (CET)
Date: Tue, 6 Dec 2022 07:26:04 +0100
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
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <20221206062604.GB6595@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-6-lei.rao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221206055816.292304-6-lei.rao@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_222609_194901_A299487B 
X-CRM114-Status: GOOD (  15.95  )
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

On Tue, Dec 06, 2022 at 01:58:16PM +0800, Lei Rao wrote:
> The documentation describes the details of the NVMe hardware
> extension to support VFIO live migration.

This is not a NVMe hardware extension, this is some really strange
and half-assed intel-specific extension to nvme, which like any other
vendors specific non-standard extensions to nvme we refused to support
in Linux.

There is a TPAR for live migration building blocks under discussion in
the NVMe technical working group.  It will still require mediatation
of access to the admin queue to deal with the huge amout of state nvme
has that needs to be migrated (and which doesn't seem to be covered at
all here).  In Linux the equivalent would be to implement a mdev driver
that allows passing through the I/O qeues to a guest, but it might
be a better idea to handle the device model emulation entirely in
Qemu (or other userspace device models) and just find a way to expose
enough of the I/O queues to userspace.

The current TPAR seems to be very complicated for that, as in many
cases we'd only need a way to tіe certain namespaces to certain I/O
queues and not waste a lot of resources on the rest of the controller.

