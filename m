Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7C2C27C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 11:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GO927bW8DsaPXRnTFTbB35PB53Iq+dTk7uhgqvI5xEA=; b=CoAWq7TsbloWDVF/0GTAwM6vzX
	36p5dormxHNGE5dVzMmlIPdmOzE1vQhZk7w6ESdrOdf5Bt4Wozf3QFAOclld9Ln/MhRn8WYY4NGHR
	5oumlqXCX6McYKIyHV4G2qveWvMgFiNDpn+9CrQrY2WoiunYnB1MuYHWnGooSfs1nfrdQO+r7hpid
	JnK7gNDPYQG85Kngrwy+HRsB+it5cvJRHUJy2xORRDydEMt31gq9z8whfXf3m8E8smSlzhzYr7As8
	CjN3D9SqoEdMEerYM44lZNDLteebe4A5FGxFhbd15ytOUThBGbdKCK7YUXTjYMrbWaBsDYZOTeKkj
	1VC8sO1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdcx-00000004t2g-1lhD;
	Mon, 10 Jun 2024 11:55:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdco-00000004sxW-2IVC
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 11:55:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A0EF967373; Mon, 10 Jun 2024 13:55:41 +0200 (CEST)
Date: Mon, 10 Jun 2024 13:55:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, javier.gonz@samsung.com,
	bvanassche@acm.org, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v2] nvme: enable FDP support
Message-ID: <20240610115541.GB19495@lst.de>
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com> <20240528150233.55562-1-joshi.k@samsung.com> <ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com> <20240608051740.GA24010@lst.de> <5e686875-21de-869d-4b19-bdd9e272d690@samsung.com> <yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_045546_866464_C5F8E6C9 
X-CRM114-Status: GOOD (  14.84  )
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

On Mon, Jun 10, 2024 at 07:27:16AM -0400, Martin K. Petersen wrote:
> > And TP 4146 author list shows 10 companies. Perhaps good enough for 
> > diverse opinions on how to go about things before settling down.
> 
> I think FDP and SCSI streams are less than ideal. 10+ years and the
> standards bodies still haven't been able to produce an approach that
> makes sense in the context of a general purpose operating system.

The SCSI temperature hints are I think exactly what we want.  The fact
that they had to be shoe horned in in a weird to claim to be streams
is a little awkward, but sometimes that's need to get things done.

Hint to Samsung and Meta: if you have to hack them into NVMe to
still claim it's FDP so that you marketing budget isn't lost we
can probably live with that..


