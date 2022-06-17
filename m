Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B935DC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xN7Qm2xsxD+W7XqbxXpAMfniWLKHywepqVzEA/73To=; b=dvLPEpnKllovOz4x7QRRscJFVp
	Ainz8d0XV+fGVjUbaGqTwN6XVNNrSyJAzo1bO9I+uIbL1WO1R6qae/h5tNrOsn9zDeMV3kI2TzE5w
	AnJ/b9LCMC12pL+y8A7k8nkTM3G5BlXw2HDo5Ug2FGOUg2pbvfbN9Z6YIEL9fyMweVWliNK7FvnKJ
	QNwS/82R9LYCq/w9rLgvT99JW/hGA8TvVdlyrRs8d0SHsrBqki+tRapehKum1ATitGmcqC2HRxgSG
	2cM+gtS5WVSbvNbWrCBDYgGA/jZdi3zsi9BaBp5t9LGPrGWuxvV+xmLUwu/Xp7HNfeVh8Vql4lDjj
	CaEueU0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2DSS-0085Rg-0h; Fri, 17 Jun 2022 15:00:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2DSP-0085Q0-Hz
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 15:00:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0F561AD1
	for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 15:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD2FC341C0
	for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 15:00:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GGM1aEzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1655478018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5xN7Qm2xsxD+W7XqbxXpAMfniWLKHywepqVzEA/73To=;
	b=GGM1aEzBR9H8jJGW5CCu9Hy3xXkuMMtu3jTK2VoVWX8G6FgJWl0jOpRzzDa14B3QjFFtqK
	oKzq74trAXkKNjcnquSvnyKX9+yqcaBdqtqFUXJMDIkyLlN6FNAaY8/+nSSM8KyT2fL0zp
	aRe/EYPayNBtk9/r3jSZFCggzGV/ROY=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c28075e4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
	for <linux-nvme@lists.infradead.org>;
	Fri, 17 Jun 2022 15:00:18 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-317803b61e5so19508767b3.1
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 08:00:17 -0700 (PDT)
X-Gm-Message-State: AJIora/mB1NWJDsod71IGsvAbeyE0l8X3fUE36YKIksvJ62wFJhMOALi
	Dz+tj3um4hbHrqladEDjem7HkypX4js2tdh1iJ4=
X-Google-Smtp-Source: AGRyM1szVvpcbqSAJno1PlJkEvH81srMmd5rf9aZJ0qFwrX9T1tUuAImMly87CUgCfaEDlyDzgSNGM+sKIUqMUrdFgA=
X-Received: by 2002:a81:c5:0:b0:317:6551:94e5 with SMTP id 188-20020a8100c5000000b00317655194e5mr12068788ywa.499.1655478016872;
 Fri, 17 Jun 2022 08:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220617083206.1146088-1-hch@lst.de>
In-Reply-To: <20220617083206.1146088-1-hch@lst.de>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 17 Jun 2022 17:00:05 +0200
X-Gmail-Original-Message-ID: <CAHmME9qfB39W3YP4Q-D=gC7TB8viVRXf-WKyGZBOTqbkgHPuNg@mail.gmail.com>
Message-ID: <CAHmME9qfB39W3YP4Q-D=gC7TB8viVRXf-WKyGZBOTqbkgHPuNg@mail.gmail.com>
Subject: Re: [PATCH] nvme: move the Samsung X5 quirk entry to the core quirks
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, monish.kumar.r@intel.com, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_080021_668918_40FF06F6 
X-CRM114-Status: GOOD (  10.33  )
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

Hi Christoph,

You might want a Fixes and a Cc: stable@ on there.

Jason

