Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE43EB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=; b=e7S0yaY96t+fW7wORcSWF98qId
	+oSaW/i5ODtHEZAGQbPyMAwyO+sYmKqlv1bOcbhg3XOgFtDnjRTb/o/khff00mhtBpb/oVRkZbV7i
	ppE+a3GAZRw4XaQP2c+jZYW4qQ+31RytDuagCdB/9JQFluefNbxTRcwAUBIMUBjd+NKV2t0OOeMiS
	SaAZ5l5mW05RjosKHSo9KpFjycDMbsO8ZKQOomAyLbK++xL2y1VlcIt1+DB7yOS1mt2A6W0FvwJgL
	qU2yLqpJpnkty3gQuQDVC6NFsxbXkDsH0J1lnoHwXJPAYdswNZMe9rhb52EsKD2lnWC6Bv3C0Fv2Y
	8nq91bHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIt6g-00C3GH-1q;
	Mon, 10 Jul 2023 15:47:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIt6e-00C3Fo-2L
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:47:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3F12661074;
	Mon, 10 Jul 2023 15:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34637C433C7;
	Mon, 10 Jul 2023 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689004039;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vp42Whl7grqnnjwtZi2xKv9+NYGEO6Nfb+Lkx7nRnAKDOpsWDoSmQNfgfkv85jkaH
	 0UHv8eq52C8ed3MFTVgDHWJiB2nOcmFBlBTKgRsQrrLsOKkwrzmoRNFqJmyC/moT9B
	 JTP69aLjfNVRPyaLn7p6v1CtH//qe5D6b3RNTyzPwk5KoBN6HCGGpl5jKJkR1f8SZQ
	 DHubNx8A1ZPPNSVVOMo/k64NGl8DrSbiPKRLRHOIPaXwXGDHF6eLSzKYKDPvVvkBQZ
	 J2t1vFcil2taF/PYc9PosAtHUYMVj3KnbdGuyhSTOA727GNOoJsgdeq9nNovstAz4K
	 iO5/4E0I90dAw==
Date: Mon, 10 Jul 2023 09:47:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: jh.i.park@samsung.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, javier.gonz@samsung.com,
	Clemens Springsguth <cspringsguth@gmail.com>
Subject: Re: [PATCH] nvme: add BOGUS_NID quirk for Samsung SM953
Message-ID: <ZKwoAxWgv+JyJMwB@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230704073658eucas1p1f977a725486b9cc7e0bfe70b29286280@eucas1p1.samsung.com>
 <20230704073656.378760-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704073656.378760-1-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_084720_811219_FB7CFC01 
X-CRM114-Status: UNSURE (   6.22  )
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

Applied, thanks!

