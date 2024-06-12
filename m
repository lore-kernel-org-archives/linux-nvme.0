Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E57C27C75
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6sH1CEcOgctzwlUpR1qyRffnvsDcTs8ckkammOcoHY=; b=idFAHDTeBftHrW8nHNlgmu9f/x
	Mqn1at3OJg1vjgpC4pzlaoSEOj+qJgThjAwVoxgBn92gvgIc3nMTLjpIzI8lFuJXelDr3yPf+Z7fr
	NHUSd8G9rFNVr+gAcEH1MG9uOS2eudHH6WXGUR/4EhiBNqXueNZdpTDT2h1TzsnqyDQwdddFo3Hzs
	dRSPTsWCrX0YMhiH36AJ+/d2C3W0d2cW6736kHv7yT53XKEXoMg4gHlM6n4UYcpxG0uzHCKRaT8MN
	OWZ40yhYrMm3rFfWBGCtkvTxORViNi4D9F24Ls6c//yNy67yTi89smMfyIpdl9e3VzOYuEMESm462
	x4cKmHeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHSCx-0000000Ddiz-217f;
	Wed, 12 Jun 2024 17:56:27 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHSCv-0000000DdiM-1VFA
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 17:56:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9FBF6CE1298;
	Wed, 12 Jun 2024 17:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B183C116B1;
	Wed, 12 Jun 2024 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718214982;
	bh=r6sH1CEcOgctzwlUpR1qyRffnvsDcTs8ckkammOcoHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYAEe1+w2PNk+GSiFk/dk0SzNsM1WX8vgODSk9jAi8Ll9c+M3bZ1JW2WWvl7ylkpG
	 oVcpRMojlg2pCREMdge2+a7BBY9t//Ru6dkjavwaQhc27Z2aVzYQ12oIY8l3KoYY5U
	 xj7Rc+rPlqcFpitiIbHfv8+CxcAhYGKknkP27e/f+2i0Ubi+wsh2Evl9InMpiLPN+T
	 gfYc/pY+qW9s+aQJZdPyeQxPKClYTwbSy7NfOAF2REbc8TTDQ5cjPcVPVrOiOYHhu8
	 i8EVlUKcUmn9pM+nr56WGoGG1okdgm3GC96oPfGmGT8OYweaNohcx2xyDK21AKYBMc
	 dc2TDG406MhKw==
Date: Wed, 12 Jun 2024 11:56:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-passthru: propagate status from id override
 functions
Message-ID: <ZmnhRL4q7QOCYejd@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612-nvmet-passthru-fix-v1-1-f583f8affa2f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-nvmet-passthru-fix-v1-1-f583f8affa2f@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_105625_596856_195CBCE8 
X-CRM114-Status: UNSURE (   8.28  )
X-CRM114-Notice: Please train this message.
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

On Wed, Jun 12, 2024 at 04:02:40PM +0200, Daniel Wagner wrote:
> The id override functions return a status which is not propagated to the
> caller.

Thanks, applied to nvme-6.10.

