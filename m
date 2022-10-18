Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0240BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4wK+0Ol+1zo/qcO2FWzhkCvvhTLa4H+/9mPIKaDJV6c=; b=rLy+3RRSYU+TYn4nnDxlq3ZBrY
	RQnSN2GMFyjshj2Ygo/EQzWY13jwIQemXqFWeoo9bQGft9C4fOGVKy88zqRcvMJkaA8pxCYBIeN8e
	ixuQMz7LktFeckNM05lEx7M4ofBygQxuKZDnOULNx3Modmuv4CXHMyNmovy13sZweyVcntGM3LSjl
	fvjwhsOdlwxIHYEVQIDbpmEDNmCg+jgq2WY5YR6EqLrs7Hczec1TFzOvzpERMLdYBGcNTJ3bNzNF4
	zq91tS8TslfhqhOvH2OanRmBIFuCbJ+TNqtEzDKhsdOpvD5r+ouxzoxZBlnJQub0Q/9XfaJVvGRod
	1gbdiUyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoUx-007co9-DM; Tue, 18 Oct 2022 15:27:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoTn-007bm9-C0
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:26:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21ACB68C4E; Tue, 18 Oct 2022 17:26:04 +0200 (CEST)
Date: Tue, 18 Oct 2022 17:26:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Wagner <dwagner@suse.de>,
	Alan Adamson <alan.adamson@oracle.com>, gost.dev@samsung.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: ignore starting sector while error logging for
 passthrough requests
Message-ID: <20221018152603.GB23173@lst.de>
References: <CGME20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92@eucas1p1.samsung.com> <20221006091053.36611-1-p.raghav@samsung.com> <3f6f41b5-c743-83f7-a8f4-ab3ee2f16b3a@samsung.com> <20221018144535.GA20131@lst.de> <Y07E+bH0E2s7xKWN@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07E+bH0E2s7xKWN@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_082607_586028_FD0AFACF 
X-CRM114-Status: GOOD (  14.34  )
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

On Tue, Oct 18, 2022 at 09:23:37AM -0600, Keith Busch wrote:
> What's the preferred opt-in mechanism? If we want to do it per-command,
> we have an unsused 'flags' field in the ioctl structures that we can
> start defining options for these kinds of things. If we don't want that
> level of fine grained control, we could set it at the controller or
> module level with a new sysfs file, though I'm not sure this warrants
> creating new exports there.

The flags field is what I had in mind.  There's also another thing
on the plate as some folks really want to opt into kernel error
handling for passthrough commands, and that seems to be the only
way to do it.

