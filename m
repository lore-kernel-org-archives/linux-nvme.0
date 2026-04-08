Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2024C1073C95
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CWXyft5P4P1SpJrgm9DtP4FL89ODUQncQF1XBqUj8ZA=; b=rCnd8t7v6A7FojnQGaKc3ZRNDy
	N0BcgNQNC6McQat5jDQqdH6PYp+POKh8B5b2w92fPTQz5YQEKkBe1wdlYuQs5IKqxEzbDULV360JW
	VbeD3EWE1CyefcwO/0Ral5vuIafOcywawb5P1Bz9oqH+G19t0wlfKUwUGCQIGCT3uPf9dNyu4eZkm
	L38J/QafUtWuSPoQpPiB/Sm4YreqLJ4UobNu5vT2yDb9vHjrPDILcOa4OW9D9+R7CsbL+nN3eZAbK
	IfOzIP1SIphCGt9M+cVTHuDXwxJnw7KyxqL0om1+9RiJ4wDdeUk04SyJTe5pmAq9Ps6PZPC3QsMJP
	rz7QIcXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAQWC-00000008i3M-2ybq;
	Wed, 08 Apr 2026 10:52:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAQWA-00000008i34-2dIR
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 10:52:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B369960128;
	Wed,  8 Apr 2026 10:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EE7C19421;
	Wed,  8 Apr 2026 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645537;
	bh=CWXyft5P4P1SpJrgm9DtP4FL89ODUQncQF1XBqUj8ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeqUIsaXtle8BZqvPCd8LRyFtih4idVbTDHtaymyE9wtgvjUPikyy2ejyQc3vq2xd
	 nF5twmdu8e+f8gc7t2cf79cT03BPCHAWsdea3izgeKm0WkKMwhzIJEQrZO77q6tj2X
	 nJSo6hG3AY9hegFouWb/R9y/JBqCXegNpFBVo4p3TvUbrvINwdU3/RG96L8dMaETaG
	 leQpi3p4A8W6ugQJTa55fGELzIJGSyHejyGSaUoI0eXziBWIuoPfcwijJwsa9rqpNy
	 jEx/vHO//rKqJA7/85Ogc/BEdMDKsQTRTLpjCwyd50PZKqITJU59U5SZSCW7ZOcprW
	 Sxew2EKECxAgw==
From: Sasha Levin <sashal@kernel.org>
To: Cengiz Can <cengiz.can@canonical.com>
Cc: stable@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5.10.y] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Wed,  8 Apr 2026 06:52:15 -0400
Message-ID: <20260408105215.946773-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404212344.1808777-1-cengiz.can@canonical.com>
References: <20260404212344.1808777-1-cengiz.can@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> The stable backport of commit 52a0a9854934 placed the bounds checks
> after the iov_len calculation.

Queued for 5.10, thanks.

