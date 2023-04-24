Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571A5C77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JbTxF4Q8v/3roWD+HCsKBdoIk69ELAXqjZAnS8HnPHo=; b=g+igniL1kjPctKMuow0ktEeobB
	KNaaUi8b51oRye91TCvgVvfgSufagRn77EzCrzP3T8r6H66gB2smnygMtRa/Lcl1LoUr3jIw1egFh
	5N3wfzjY6BNhz6Q2OMyGyklmYi9A3P3w7iGVAkP4LiqktRUsdr4vrNAfaBCuV3Vl4PTz1GySdJObR
	DelXZoQGVS7aDPHX4tencWHd9BLMn2KQERSdH3Hv7LCv4AdXlXVikoSRgDbLqLzJMnUnSMW3HwXqG
	9FSbR8lgM1RmGcN4xJ9oszFWsL0AgVwoxvSmfZlkubxPZk5NiPMzHayAR2rWaeydMrSXzcF29UExZ
	lV9V0JiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pr0Yk-00GxWz-0q;
	Mon, 24 Apr 2023 18:05:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pr0Ye-00GxVg-20
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 18:05:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2742F61EF6;
	Mon, 24 Apr 2023 18:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F45C433EF;
	Mon, 24 Apr 2023 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682359499;
	bh=JbTxF4Q8v/3roWD+HCsKBdoIk69ELAXqjZAnS8HnPHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elx1P8QkkbdXBAinRKlLpxMOFCtGGYzHTQWEMS9RtxV1rGkIqb+I+97ETjS35I8gS
	 /VvqSC9MyKhNuiT6sLmpnMqlDwDjongBEbTkHrQ4LIhGWAsPzHsabozFr/DihWRMpF
	 7MO2yOhF8StgRYaoVJOf6mLPGuSyvHTNa+OeGF67pc3WGkIEa4Fvx6mgLgPzQk0cCy
	 PmE7ZQEuc40A8uxz1N/rqAh4trfrB45nh/2KLqhsguLhdyajeX96/dHUSMsLHPpLb5
	 HbmADUy9t8H16EVbxGwDp1YSLf1tESWlWiD1LB3yhtYrP6h0GLf+kpta1D2f/sgVVW
	 w2GwYreZU4MCQ==
Date: Mon, 24 Apr 2023 12:04:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, oren@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
Message-ID: <ZEbEyOk0HErXlZ2Y@kbusch-mbp.dhcp.thefacebook.com>
References: <20230424141818.16173-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424141818.16173-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_110500_695003_B8DB6189 
X-CRM114-Status: UNSURE (   9.88  )
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

On Mon, Apr 24, 2023 at 05:18:18PM +0300, Max Gurtovoy wrote:
> The core.c file became long and hard to maintain. Create a dedicated
> file to centralize the sysfs functionality. This is a common practice to
> separate sysfs/configfs related logic from the main driver logic .c file.
> For example, in the nvmet module the configfs interface has its own
> dedicated file.

This move sounds appropriate, and change looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

