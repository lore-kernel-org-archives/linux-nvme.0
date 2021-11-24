Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0744C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Nov 2021 19:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FDEfYcStv3OyBWwswlEReh0RezC/nV5IGGwjQwLCz0=; b=oyqC0P90If2RDfy6JD9iZIFrYF
	09wAEeGAVCkf4p+uz0ImSnjYVjDD2tg5+mZHvpZJ+wkHcB+sJKmZIcBiW150sxNv3Ku+CKTk84XHZ
	iZHuXevAqfTjqic7gYDV1l4MAPgkqPnstk0sFOLezv8o0++7WIoWeazdys1GhiffbNIk3ilsMYu3O
	MtV9O5RipFbBy3meFCbbZb40S8IxyPOpYE+idaCKv1UUcIacBCJePhU0FrRbKIzs2HiVEx89TGY+9
	Yvk2lcZfla5MZb0D5feFnrm7xdfCMRnRkBIG4BqLotK5L38+A6QtrSdv134MFOEuEEynKg2l6RtHv
	KTLdYcAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpyOH-005ivL-Mb; Wed, 24 Nov 2021 19:57:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpyOE-005iux-Qq
 for linux-nvme@lists.infradead.org; Wed, 24 Nov 2021 19:57:12 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B1D260ED4;
 Wed, 24 Nov 2021 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637783829;
 bh=boWToD2/RQFeTXP+mmwO38bGgb8ZUKEipv4DMXr3InA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ty35Vjf6uFCzrrajbCp2F6Cn162hvjjiHGATEGTJvaBVT3rEBhb8vMfdoTWOOtZyj
 oJJ8Pf+6Docv4ycHcCGV4NRfr2bd2fUPY4zfa1MwK99TMgGGcdza739Oebm4tUtBp1
 0ZxLTu924SQJZft4vnxN+Dc9yzhwYETh4kylTrHoD5/0Z4PGges7tKknhuyy2pkQie
 gswk/jJ5y6zDAIgXUcvsXc0+z1y5O0HuRq2oJu+y0sIH+yjMiWCGQXaoplFx0LAQ8b
 0Ao4fKr4S+c04GhARLAqcZU71Y+CBX4KsOdf317ffjE0KORPk4QBnG/UjRUQFBulpF
 9cJKKOkaFDodQ==
Date: Wed, 24 Nov 2021 11:57:06 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: disable namespaces with unsupported metadata
Message-ID: <20211124195706.GB3576243@dhcp-10-100-145-180.wdc.com>
References: <20211123174554.3574990-1-kbusch@kernel.org>
 <20211124184757.GA22791@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124184757.GA22791@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211124_115710_937974_3357863E 
X-CRM114-Status: GOOD (  19.42  )
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

On Wed, Nov 24, 2021 at 07:47:57PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 09:45:54AM -0800, Keith Busch wrote:
> > The only fabrics target that supports metadata is RDMA and usable only
> > if it is 8B per block, and formatted for protection information. If an
> > rdma target were to export a namespace with a different format (ex:
> > 4k+64B), the driver will not be able to submit a valid command for that
> > format.
> > 
> > Suppress exporting these namespaces as read/writeable to the block
> > stack.
> 
> Where do we disable the namepsace?  We only do not set the metadata
> supported flag here, don't we?

Without the flag set, a namespace with metadata gets to be 0 capacity.
That will make it unusable through the block stack r/w path, at least.
 
> > +		/*
> > +		 * Currently rdma is the only fabrics nvme host that supports
> > +		 * metadata integrity segments, but will not use the metadata
> > +		 * payload if it doesn't satisfy 'nvme_ns_has_pi()'.
> 
> s/fabric nvme host/transport/
> 
> > Since the
> > +		 * initiator is not able to form requests that satisify the
> > +		 * format, do not support the namespace if the metadata does
> > +		 * not satisfy that requirement.
> > +		 */
> 
> I can't really parse this sentence.  Also initiator doesn't make much
> sense in a NVMe context.

I'll reword this.

