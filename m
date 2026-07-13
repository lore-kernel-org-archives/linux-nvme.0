Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF59C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 20:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O//KfDC0M4shhfyX1LLpcreHey2JDXMUVgzUoqlMH5E=; b=xL6KYQi0R1wM/qFtc3HGP5Ybh5
	Npjlt78vKPAY1T2FOvTX7tdLjmLFRSiOKuf+TJLkwQ1fUuQRgf7N3M4eSrIj0es9XH4dQjLGRKKtm
	WcCkNPBX8QuFqVqFRSLp2mULdOZVOyW6JTlegma5p7lFdY/uTtO9STDOIi1x2uKCFkIQ1Y3ZZB67J
	XPFPcdjiZ1h2673rGwCCjdoi1CFqnMerPemA+4o74knv2w0hsFross6MzvfGU8kbg8o4dfihG0cd+
	qFYRJUhsdXMjnW+oCe7aL1TQQP+sNGQS9LNTKLTZ8MKu0OuDwumzSmsQDreFz4WGU8tVMfoqSbZT2
	Cso2Hjww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNdf-0000000APcd-2Tey;
	Mon, 13 Jul 2026 20:52:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNde-0000000APcX-23PV
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 20:52:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0BEAE6013A;
	Mon, 13 Jul 2026 20:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F821F00A3A;
	Mon, 13 Jul 2026 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975947;
	bh=O//KfDC0M4shhfyX1LLpcreHey2JDXMUVgzUoqlMH5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AKsT7cv6sCUPDIryFduoTd9EL5INtCxHMXaHQArW9qdRAdh/s5OIPYzJbTPLKarZH
	 TeYV/0IMAQ5AsPKUUBzzG5/X7+HWWsqlvqljmUHLrYC4me0lgSRBaokEjj4rET15oR
	 6nx6l5h5hsZQ1D5+uvvueCXXIKthoubfcy0KxLZmoPvWb0mGSnT5PmLfE/vwVJ13k/
	 7yR5jTHlG2v1cqJLYKjYNotG3zwDQR2TD0H9CGLcxqKr6e42l+qw7CSQKDmldzyxNS
	 ZK4+ieehKkSTX6rPwZC8eCEE5BMSBZ1WWicHFQYWV48R2P11p77yyJCWYzv94bic87
	 ZLqJuqMV3tyMw==
Date: Mon, 13 Jul 2026 14:52:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Colascione <dancol@dancol.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make sending wall-clock time to NVMe opt-in
Message-ID: <alVQCljd3a0dRRPw@kbusch-mbp>
References: <20260713203443.322748-1-dancol@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713203443.322748-1-dancol@dancol.org>
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

On Mon, Jul 13, 2026 at 04:34:43PM -0400, Daniel Colascione wrote:
> Some NVMe devices maintain a persistent log, the PEL, of events like
> power-on and thermal excursions. The NVMe Set Features (Timestamp)
> command allows an operating system to inform the NVMe of the current
> wall-clock time. Wall-clock timestamp updates are logged to the PEL
> alongside other events. By correlating PEL records, an attacker can
> infer a user's usage patterns and even guess at time zone changes.

How does an attacker come to acquire PEL records if the system isn't
already compromised?
 
> The nvme_core.timestamps_enabled_default module parameter supplies the
> default value of the per-controller flag. Default it to false as the
> privacy-preserving choice. Users who want to provide controllers with
> real-world time can set the module parameter to true or enable
> the per-controller sysfs flag, perhaps via udev.
> 
> As an alternative, we could also get the timestamp updates out of the
> kernel entirely and have interested users run nvme(1) to
> update timestamps.

The use cases for the timestamp feature are outside the specification.
But I know of at least one implementation that uses it to determine how
long it has been powered off so it can better apply correction to media
drift. Yeah yeah, depending on the host for something so critical is
pretty fragile, but it apparently worked out well enough. This proposal
would break them.

