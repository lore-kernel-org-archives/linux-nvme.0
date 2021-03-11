Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEB4C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 19:20:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD8D64F0E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 19:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD8D64F0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xHJKHsQv84Fr9ZoqqcxD597d6fZET1huEdsiG3t0dzA=; b=FXmgupQszmKRv8LSJA6EWQ7hP
	cuWpQxmxg8UmyZHzUKbbapx+0mIo2skBMKe+M+cq90XLsZ37VEhE8yg3+HdHggaAuhgc86lbZJq0z
	dLgI6Z+Z02iQCdBE+8Y+IP5uXtWHM73JoYsXEj72S9Fnb3K0vL+ks2K/MhKB6Ay5hhxH/7SUfN0Tj
	fA8gXJ/ex8UODQDZ4tkDuzwJtJG0tubb/QFjpvnbKNtKZvpsFMVXk5OP7xezdw+G/aHQELz6KbXWR
	XCOutIwnwJjYudiAFdmK5FRGlvZLRAqlhOQomOCtcHCT35N7AoGrhcUyd899T0U340W2i6gRt7HPM
	pAWRQch9A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKQrS-009yST-24; Thu, 11 Mar 2021 19:20:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKQpG-009y2h-N8
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 19:18:29 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B46D964E21;
 Thu, 11 Mar 2021 19:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615490305;
 bh=1+H/0YT4EdbmN2fPQKiH3ImYLm2vg2A1DzfSJaQtfEs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Aaos2H5UvVL4JFXs3/qXGh+DM2F36tuWqixs+7c/M1U9EUfw8Dedu5lArXXTOaW+1
 eCYMR7LyMea7HPR5k+XTHNNXSRwzHABS1gWuYjTAy2vM+L4xIgTpwDCnS2cBMFzYaS
 svVG+kgY5tGo/XqvBc6qjt9ea+N+JXBu9PHBkYhJsO0WpzREZqZO+UiV43U/ehUUn2
 2CWtydG9ALUkT0sSfNl7Hgbp0ZOSmMTsUWmfuZ0uCWiGUiaxy0VFU4KnDIIfUAjS9k
 lnArhLqv1CZn7Euoz5jjvpWV4HLEBKuzcEEmkKqPf5D76si/4V3l+E9NFEN0YQl8li
 zjG98XHIZ0ASQ==
Date: Thu, 11 Mar 2021 12:18:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme: implement non-mdts command limits
Message-ID: <20210311191822.GB36893@C02WT3WMHTD6>
References: <20210310195726.3377288-1-kbusch@kernel.org>
 <YEmv3nNynyBHggoz@apples.localdomain>
 <20210311154952.GB27105@redsun51.ssa.fujisawa.hgst.com>
 <YEo+UOu6paVwzdXY@apples.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YEo+UOu6paVwzdXY@apples.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_191827_432677_EFD662CF 
X-CRM114-Status: GOOD (  13.09  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 11, 2021 at 04:59:12PM +0100, Klaus Jensen wrote:
> On Mar 12 00:49, Keith Busch wrote:
> > On Thu, Mar 11, 2021 at 06:51:26AM +0100, Klaus Jensen wrote:
> > > On Mar 10 11:57, Keith Busch wrote:
> > > > +	if (id->dmrsl)
> > > > +		ctrl->max_discard_sectors = le32_to_cpu(id->dmrsl);
> > > 
> > > Since DMRSL is in terms of LBAs, should this use nvme_lba_to_sect?
> > 
> > We need a namespace for that, but we only have a controller for this
> > Identify.
> 
> Ah yes.
> 
> I remember now that I also complained loudly about this mistake in the
> spec when we implemented it in QEMU.

Worse case scenario is that our 512b assumption will get a slightly smaller
maximum DSM, but it should at least always be safe and successful. I think it
would be nice if the spec clears this up too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
