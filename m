Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C451D2CDFF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eyjlMckV6D2vhGN++ftFlIP2fK0697M4bKOKH0oZ7Vg=; b=1So8aEqjZmlFc0U7FlC06qEXhe
	qnSAhexX6Y+xoP5FwWRV29v6oN/hKMIHhNoewae6T0sY0QNz5NSwS3cxswCVEwV7DQX5+0iMMj+P9
	5VnYochi2A3jpHlyNNWSB2kdGkpAZuNajmnfGFKX8e/KgUXN4PjARZ33xi+ld+m2JylKhVZcYQ4bY
	kcrgbdCYRgoF+Ieqrm84ZMerhprdLAf4tCihqkPtXvcoQQR4LfsptYXw4iNnwTL9kMeZ+jeo+JuGR
	OrX0ZteKILOrU4ZH5vFNRlwI9u6rKVQENsoT1PNW/+8wN73RHyI4i30y0FEfgyMuiFVXWiktAbw43
	DSC6xAVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3I3H-0000000BWxS-1bUd;
	Tue, 22 Oct 2024 16:48:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3HbR-0000000BQZd-1c77
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 16:19:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7FBB1A43A4D;
	Tue, 22 Oct 2024 16:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1A2C4CEC3;
	Tue, 22 Oct 2024 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729613964;
	bh=Y/3P49OEbSOH3mTkIP/+Nmcz1EphORRLCT1ekxEZXmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0Toa4PZx7tWx+ATJKIjfDIG74gWERlPmE39AlBMGg2x678UHioZzezOOebLPjHab
	 HSfRbxO3KO1gEEHfQZbkBSD6VQmqeVIeHPYBh2MrwRxSlkpIbwmniB28Se1IZx2LXd
	 9i4N2K/D2UFObMyo6bvF34MRyjJK9BQ6JVbEsq3b+PSiGjHxgqyy4CNrXRLKt+POt2
	 cZZEsPvGwmQJ8Z9S16FDof8WSKMjQ+lqonCJrUXm6A1IrZG3Dn8405+bNncWZD6Fgx
	 MAObV2UNhO5Axc6aiZjDwrcHoBLuFgLtYBauzU9/p8MX2nk04COCG21ee8IeaWzl9Q
	 fZ6AYIYiiudtw==
Date: Tue, 22 Oct 2024 10:19:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2] nvme: enhance cns version checking
Message-ID: <ZxfQiYKvH3i2XwLz@kbusch-mbp>
References: <20241017181231.2937468-1-kbusch@meta.com>
 <20241018051201.GD19831@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018051201.GD19831@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_091925_505386_55463BD1 
X-CRM114-Status: GOOD (  12.54  )
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

On Fri, Oct 18, 2024 at 07:12:01AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 11:12:31AM -0700, Keith Busch wrote:
> > +	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
> > +	    (!(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)))
> 
> No need for the braces around the ngation here.
> 
> > +		return cns <= 3;
> > +
> > +	/*
> > +	 * NVMe 1.0 used a single bit for the CNS value.
> > +         */
> > +	return cns <= 1;
> 
> Slightly messed up indentation.

Fixed up, and applied to nvme-6.12.

