Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D4BCD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2CqEAcMA+aUhyKC296NUnzawkrQL6YZocZfAIAsHD28=; b=q2eKE0+/VEXK3Aoe2DFFY7IezO
	u7nH5fhPIq93FkYIUJRcPsNGBxDPylNYDGInuIqqkYBM5W4s4A/cyrcduk5xhJpEQS7ozDDy46mw0
	7+FsZ76bvfWa4/SYjpUGQsqoQi1saGiB194pfYk2+Sk/hfa64R8UQlcwHYaQNHYwDEpX0lc55h7g4
	kP7BY/jXFCQQAqX8ozq4YIZKLJZg8SB6hAJXXnN64y+OtTE7+1emXKwsOh+jzXmREb0P2w1x8gmho
	AJLfxHtAUVLlg0AJQpqD0SQMRBsolb2c7z/l+q5JW0h9+OiBFA2v2dJK/WIwvXblN69eo3Lbz2AEw
	TPvIbceg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF8G-00000004HeU-3kWy;
	Wed, 27 May 2026 14:21:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF8B-00000004Hdr-37BR
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:21:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDB2D68B05; Wed, 27 May 2026 16:21:07 +0200 (CEST)
Date: Wed, 27 May 2026 16:21:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v4] nvme: reject keep-alive passthrough on non-fabrics
Message-ID: <20260527142107.GA13687@lst.de>
References: <20260522162639.395802-1-coshi036@gmail.com> <ahCvVhKxRLRPWscH@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahCvVhKxRLRPWscH@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_072112_402525_AFDCE0E4 
X-CRM114-Status: GOOD (  25.76  )
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

On Fri, May 22, 2026 at 01:32:38PM -0600, Keith Busch wrote:
> On Fri, May 22, 2026 at 12:26:39PM -0400, Chao Shi wrote:
> > +/*
> > + * Some Set Features commands change controller behaviour that the driver is
> > + * not prepared to handle on every transport.  Reject such commands from
> > + * userspace passthrough rather than letting them put the controller into a
> > + * state the driver cannot deal with.  The list can be extended as other
> > + * problematic features are identified.
> > + */
> > +static bool nvme_passthru_cmd_allowed(struct nvme_ctrl *ctrl,
> > +				      struct nvme_ns *ns,
> > +				      struct nvme_command *c)
> > +{
> > +	/*
> > +	 * This only filters admin commands (ns == NULL).  I/O commands share
> > +	 * the opcode space with admin commands - Dataset Management is 0x09,
> > +	 * the same value as Set Features - so they must not be inspected here.
> > +	 */
> > +	if (ns || c->common.opcode != nvme_admin_set_features)
> > +		return true;
> > +
> > +	switch (le32_to_cpu(c->common.cdw10) & 0xff) {
> > +	case NVME_FEAT_KATO:
> > +		/*
> > +		 * Keep Alive is optional on PCIe (NVMe 2.0a 5.27.1.12) and the
> > +		 * driver only arms keep-alive for fabrics.  Enabling it on
> > +		 * other transports starts a keep-alive command the driver is
> > +		 * not set up for and harms idle power states, so reject it.
> > +		 */
> > +		return ctrl->ops->flags & NVME_F_FABRICS;
> > +	default:
> > +		return true;
> > +	}
> > +}
> 
> This doesn't need to be its own function. You can add these checks to
> the existing nvme_cmd_allowed():

Sorry for only catching this.  Adding it to the common function is of
course good, but I think it's grown to a size where splitting that common
code into sub-helper as suggested probably helps readability.


