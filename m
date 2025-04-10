Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5573AC3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zsj9fnlIkW7j1wu9aFFsabLXTKsx6ktCDr7T+r/NSkY=; b=MXX2r0C6eumGgj5vcBrrhJhNp8
	oh6UyVv+GNKyyZR5dPTPn795VPLkxECtjNnUZI3clUDguDPp/ThrmDmDdqExpMJzC9KtK/sQyd37u
	v9L81OcxgjsI3bmw6u+b/PSmqNTmkymhonAhW2NxXpCdpL8r9zmWAunSkw23d/dTpqQdIPNJ/MO/U
	cOL9KpIKt6KULHYNSn+qNU0Rdix4Hq73ygeq9n+mYHZDF2/9C5ZYbaceOXv5i36okIDmtsCqaZwt0
	+3DjpZn4TRdoKKhBkOGE1JWVNqH9N8KygiGbqo8NxRqIEctoOI3+1zk5qlxFDEoHVI/UZnb81QxCl
	vM9wmrRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2pt2-0000000ABMj-2AFD;
	Thu, 10 Apr 2025 11:16:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nsc-00000009sQj-3IdV
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 09:07:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F36856843D;
	Thu, 10 Apr 2025 09:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95EBC4CEDD;
	Thu, 10 Apr 2025 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744276045;
	bh=pDFQSticHDrhRH5z+iWEYx0/gf4BCZEfdPz8+HgWdio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVCFxn6nj6wewTLo9c8ei8U2J4F5bgJUc6YiEA1ree1+OYs7953+IRmIzX5UsqVmU
	 Ji0mrOz4h1Oa51vnH8Ss+bsRB2Ol1XknfHmVrCMvBkCIVlbi+/cp3NqvaXr84O55S3
	 y8hWQCcrS0YFy54kZXDFwbr9+STvh8FQBOM846hC8WtFtRMqdmshQwOa4Nw+F/sNm0
	 vCbaey/YgcPZden9NvP4Yx4Zi2cj6jI+zlmWl6nLbdlvyYnnq8A3j1axXz0x7m7jSx
	 2LUu7DgJg6SNRMM03199N2wsDLzoPWDCmSeJuRo68fRU50aYXxtSzzdwgwm1ftqQV3
	 U7sD6HcTujB4g==
Date: Thu, 10 Apr 2025 10:07:22 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Message-ID: <Z_eKSrfAsjT94hZD@kbusch-mbp>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
 <Z_Y4TFTqriOTxXsO@infradead.org>
 <23d2c5c3-0832-4b62-a151-74a021c63201@nvidia.com>
 <Z_eCIQ5dtv9oKd9X@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_eCIQ5dtv9oKd9X@infradead.org>
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

On Thu, Apr 10, 2025 at 01:32:33AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 01:33:38AM +0000, Chaitanya Kulkarni wrote:
>
> > Perhaps using the minimum of all AWUPF and rejecting any ctrl which are
> > lower than the initial value is right fix ?
> 
> That's what I mean in my previous mail.

You'll get different results depending on the non-deterministic order we
enumerate. Can't we just change the stacked limit to the smallest
observed value as we go?

