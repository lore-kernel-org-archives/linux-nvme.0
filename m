Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3547FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6zovptVzx58RczcDDF/GHwqT6njr7ijSc0Jf8Ihuxtc=; b=IawO4H2pnfj7axaFsH2VsU8DmH
	VPwTkOqYSXAWWc5XRwX2jRQ5lvBacbR9g+8278Kzs29w5rDbVdbnTGwiwuip448jNcdv7atPeNImF
	gD02U1I3UIOfny7P8xt5dXGIonnl9baMGTPkiaJ7KI//HeioGWaBAbuDRGDm3pkjoiREnPQeT6taA
	2gwZtUdQ9pfX0Rvq8XLMjQmdI5g2J1fMknUCihZ7sbVv57lcXaP4DxZlbuPgw4/8E+FTvJsy6uhfx
	uk1P+TH0GPCxaUiNSCdLOD43aQziel/IcenrLal6sW+IPHIKH4bRITcPc2G7UTsd0kFm87rwQvRkD
	fN0yI/TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU9ME-009lgJ-UR; Tue, 15 Mar 2022 15:45:10 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU9MB-009lez-Sw
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 15:45:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 88295B81751;
 Tue, 15 Mar 2022 15:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B137C340ED;
 Tue, 15 Mar 2022 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647359105;
 bh=6ACoB6C854ALKc6msd0mg4qS4PA8EU4ds1l7GjQ+R0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tJb0FKSJRGF0Nokr5813fqJMoQg6OkwoflkvAAGTo5iD7sYLAKaQJwnMsP3jz0Y1z
 nEs+WBjkcCHm1azdHmua2W12gBvAUHaY3yH8O3jJ65/e0YO1Ck5AQcl28T+cdcUJw5
 /b7uKJw8wi3JiS8evsM0Fcz0pbfDNYfb898xcd3KJCES//eqfUDhTsXXypPhxwUCk/
 6tNTqymytU4Upj/dBpZc0CFLx5d/JzmObM9XAEEuGHaYWxl9XzEGmfSy1oKFN47lpk
 E0rF10GlHcaa36Jl8zit77ffgbm12sDuhNILJyuRDGZOSUecj5XZCYvVdbHTT7zQIt
 ZK3Qwa3hcWVhg==
Date: Tue, 15 Mar 2022 09:45:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: cleanup how disk->disk_name is assigned
Message-ID: <YjC0f2WVMurUmtlK@C02CK6Q3MD6M>
References: <20220315145125.2586068-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315145125.2586068-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_084508_110341_D184E417 
X-CRM114-Status: GOOD (  12.96  )
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

On Tue, Mar 15, 2022 at 03:51:25PM +0100, Christoph Hellwig wrote:
> They way how assigning the disk name and commenting on why it is done
> is split over core.c and multipath.c seems to be rather confusing.
> 
> Now that ns_head->disk always exists we can do all the work in core.c
> and have a single big comment explaining the issues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

