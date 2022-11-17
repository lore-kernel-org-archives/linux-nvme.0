Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89451C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWxita7pnea4UHF1Ur8f5D+v0sZcUpTQCkDX7Qmvn8c=; b=Tj7ZlFCnd1fs20YqvAXPjP7U5q
	/7frPrK51egY8d4U7SSS0WZHHCNlQZmIkKrOGvwtnGBi1Dd/0NSoILkEW5RRxJaPRa0ChW4ysRTS+
	DAX6U8UH030AO9Z0kPz+KwXFjmhStYLJ80IgZPcQ6jH1qyxCmAqYSRJo1brZkETZDTwZCzLJ99OUU
	k4OTXqXlrnSgqaQyI8SsBrH5qWpkIVTeaQp4unAPcg2Ppcet1x/mNAXjidhFmgSfwELTX5HkGip3k
	QDgsx+C542JoJCBit8v3P0jazUR/dr0FUSK0yCtIbV1S781fgHTV7CtNLjmPlmiJ1BbFU12ZcTJvb
	oPdksPiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovhPZ-00FhHn-Kw; Thu, 17 Nov 2022 16:06:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovhMX-00Fff8-K7
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 16:03:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D4228B820FE;
	Thu, 17 Nov 2022 16:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A19DC43145;
	Thu, 17 Nov 2022 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668701012;
	bh=cYPz/gWl7pYHVIjV/qKSnr5qbQ9n2qQCh5k44zuxIKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1COBeYSbnfFXCpkboo6ONZlXh3UYBgArccwvqGDgDTp4wMmXezrvmzYl1EDrRGXF
	 CtxCMKkK+r3YEj537m9hTznGOx8vawoXHbLRm79TDJztputLs40QXjqow+TSvjaFYn
	 JJnDpW1jC8cNq7peeNFWCum89Or2xT/zikb7kgXlvuVxp/8flM75TJrnk5+GYgu799
	 aVwA0/nPQkAq9QucJ3JIlMMHvk6giYY0379c5/2pKryvrCRjs/s9+Kt46kGHNPrGZ5
	 Zbs71frva0Zr/3fKRnMuTd/yLRb5znjVCVijFF4GSKSpRecNLrrsJFxRuHOm/kQpIO
	 GKzRdNFpsdEbg==
Date: Thu, 17 Nov 2022 09:03:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <Y3ZbUUenpmSCI8z6@kbusch-mbp.dhcp.thefacebook.com>
References: <20221116130104.2186334-1-hch@lst.de>
 <CGME20221116161659epcas5p4bcdb97e2fae59e65bd2bf913cc3e686f@epcas5p4.samsung.com>
 <Y3UL2LER7I9KUxGW@kbusch-mbp.dhcp.thefacebook.com>
 <20221117035121.GA22055@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117035121.GA22055@test-zns>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_080337_863298_0626C39A 
X-CRM114-Status: GOOD (  21.66  )
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

On Thu, Nov 17, 2022 at 09:21:21AM +0530, Kanchan Joshi wrote:
> On Wed, Nov 16, 2022 at 09:12:08AM -0700, Keith Busch wrote:
> > On Wed, Nov 16, 2022 at 02:01:00PM +0100, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > I recently had to debug some testing code that tried to send fabrics
> > > commands and caused a major havoc.  This series adds checks for various
> > > very low-level passthrough commands that have no business sent by anyone
> > > but the driver itself.  The list might now be complete, so discussion
> > > is welcome.
> > 
> > People do use the fabrics command for 'get property' to check on their
> > device, which is a harmless command that you've blocked.
> 
> Not about this series, but should not fabrics command be allowed for
> unprivileged users? Trying to understand the harm linked to that.

The driver needs to own the fabrics connection setup. If users mess with
that directly, it can really confuse the driver as to the state of the
target and things will mysteriously stop working. Instead of issuing
passthrough fabrics commands, users should use the /dev/nvme-fabrics
special file.

