Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EF1D462C5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z80AXVH6DhYlCclVi4HhKl6CaEUNplZmj0CiTBtqhog=; b=So+ksLzIGeqlIKgt33CD8IDARV
	m0eNBSvaQTU2NJurbxXlY/O+WhvwtgnVoYNBI29bAMfEaO8OaodOwfo+xVXL7XD+iAjvsTP0J86W9
	i2UEDW8dFBlkmPwFvzFoTLNSSGpXk+PtxQm9NssCvO9WcACNdaNBV5GRbNExVRdk6falx25FswZMn
	0vQk2ZeuC8nmAqgJ0DEPU0P1ZD/XjAxIklxlAnCscOJina/i+y/1b8I6pcmNuck3osR+VLJ3HjDS3
	75x6kLVCQ3hyUXFPXeyWYly0hI3IwtgrXl/wjU4X/xGN9eyl1dnob/U3mEMp6CWaDsDY5EeqXyMvG
	VSPZaomg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFbK-00000007M57-2wVz;
	Wed, 13 Nov 2024 15:48:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFbI-00000007M40-0AhK
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 15:48:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 32F1E5C5838;
	Wed, 13 Nov 2024 15:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B003C4CEC3;
	Wed, 13 Nov 2024 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731512891;
	bh=2rn76pFjHWYLsU+49oRyQC7UnFJl57iq+/C8kMeS6D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktZu0n1vE/1hJdhxYbYFpGo5aORnm6gVCI5ECgm+ZtxKlupC2aZRdAuNATqE48vSM
	 BWGrTsYrlfMwNJGvnswJmH7nlUgpQSriNEpfOGWhJO2XP0CPfQmkQerUFDEvecC+Jw
	 TWq3UqVdt4or0HOein5O5nwG3f06crEfm9F7oTiuuc2kRp8zn3CPdLxe60k6S7lfDq
	 u9KOs+8vEgAUXisfLDKpWHVI2+dy4oWj5E05CFmDRSLQLxoBKjD/rosEgYxBDE1Nln
	 lWBl9hAkJ4eKusRuJmUEK4jdXxzXLxsKArd7GHNvR72Fcd+0Nj4+55B1FVWBbddgen
	 fC733U09c3adA==
Date: Wed, 13 Nov 2024 08:48:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 2/2] nvme-pci: use sgls for all user requests if
 possible
Message-ID: <ZzTKORM566PReqHI@kbusch-mbp>
References: <20241112210620.2650523-1-kbusch@meta.com>
 <20241112210620.2650523-3-kbusch@meta.com>
 <20241113045859.GC20379@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113045859.GC20379@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_074812_142273_67FCE62A 
X-CRM114-Status: GOOD (  15.90  )
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

On Wed, Nov 13, 2024 at 05:58:59AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2024 at 01:06:20PM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > If the device supports SGLs, use these for all user requests. This
> > format encodes the expected transfer length so it can catch short buffer
> > errors in a user command, whether it occurred accidently or maliciously.
> > 
> > For controllers that support SGL data mode, this is a viable mitigation
> > to CVE-2023-6238.
> 
> The patch itself looks fine, but instead of the handwaivy mitigation,
> maybe just disable passthrough without SGL support by default to actually
> fix and not just mitigate the CVE?

SGL is an optional feature that many devices don't implement. Even fewer
do it for metadata. Disabling it entirely is "breaking userspace" for
users I need to support.

