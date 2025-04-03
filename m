Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06D1C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AIHNDYt8zOEvKEXYIrILWGrGrQWiz0c8MVzsxSmYm5A=; b=mr/v5Xb8iHqsTSOQ7KAUuGjUru
	CtrzTacd+Tpr/yButF/MGNCEyI9e6Qa4r7HfOxi7x4pJlFv7ELQ8GxlxbvOYC5lDamotibQCmMA3o
	SJxm0C0yRghkoNEmL7/mA9OCWAFAGjWFiUbtQiu4hkGzM5qbPLITJzToEPfvL0F6o4hW8Wj9tJZ/1
	bKcCKZFLaw4F9Ax4JHxeDdeR0b8MxjbPUsE7hmWxDOyloAm7/XaomWCZJ3Yd0ZZWJ0tXtf4UaOVbf
	/RxEspv6dVXQEhzcuRyLN7NmcM8kIuJbF2puFCXfGiYq2Dkj+vR5DWJ/d7G0x4lSXFGQNfIp3RYNd
	rTPs0RHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CVr-00000007lsQ-0Qc3;
	Thu, 03 Apr 2025 04:49:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CVo-00000007ls3-181r
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:49:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FC6568C7B; Thu,  3 Apr 2025 06:49:02 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:49:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kamaljit Singh <kamaljit.singh1@wdc.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, niklas.cassel@wdc.com,
	damien.lemoal@wdc.com
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit
 ioq creation for admin & disco ctrlrs
Message-ID: <20250403044901.GD22803@lst.de>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com> <20250328213640.798910-2-kamaljit.singh1@wdc.com> <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_214908_550715_F6F1A375 
X-CRM114-Status: GOOD (  20.86  )
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

On Mon, Mar 31, 2025 at 09:03:11AM -0600, Keith Busch wrote:
> On Fri, Mar 28, 2025 at 02:36:40PM -0700, Kamaljit Singh wrote:
> > -static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
> > -{
> > -	return ctrl->opts && ctrl->opts->discovery_nqn;
> > -}
> > -
> 
> I suppose it's fine to rename this function with an nvmf_ prefix, but
> it's not really related to the rest of the patch and makes the diff
> larger than necessary.

It isn't, nvmf_ is really for code in the fabrics library and not used
by core code.

> > +	/* An admin or discovery controller has one admin queue, but no I/O queues */
> > +	if (nvme_admin_ctrl(&ctrl->ctrl) || nvmf_discovery_ctrl(&ctrl->ctrl)) {
> > +		ctrl->ctrl.queue_count = 1;
> > +	} else if (ctrl->ctrl.queue_count < 2) {
> > +		/* I/O controller with no I/O queues is not allowed */
> > +		ret = -EOPNOTSUPP;
> > +		dev_err(ctrl->ctrl.device,
> > +			"I/O controller doesn't allow zero I/O queues!\n");
> > +		goto destroy_admin;
> > +	}
> 
> The queue_count comes from the user. If the user provides a bad value
> for an IO controller, you're erroring. If they provide a bad value for a
> discovery or admin controller, you override the value. Why the different
> behavior?

Also we historically do allow I/O controllers without I/O queues to
allow for various kinds of recovery action.  So I don't think we
should change that.

