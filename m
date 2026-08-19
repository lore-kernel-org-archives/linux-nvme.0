Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D16C5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MunvRRyoT472We3pqFLM4NIFhmOa/CU+LlKipVY5NLs=; b=tZv80ICu8GI1eJjSGBHrYZKcUi
	vozwP5OsjracHToJ06Lta539VM5F53T4TfnyNxcz2qX36uvAyjJ4d41wPZUmWNiUiqzzKlHvofNHP
	kQNI85MOOCnoRuMXkoINfjRwSB1lJnMPwLuy/sk9Qh4OGU3AJJFL5S1SXZ7iRp2GiKer7kl84lNaO
	stPNpGbo8fF+gHlYpStU4yUu/xY1aSPzRtQfvmg/kofhmLY+gUL+st7t1+fXBIqRDyjEPUzEjf80+
	VivbkWjVDmEZYp/Fdc2Me/uQXVjvSV8oRhOYW1nShCL2jhh5gnl0yPuCfn8uJPgbqXueX2Juz4KJo
	ewGw/XAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiHu-0000000A64i-3f9e;
	Wed, 19 Aug 2026 15:33:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiHt-0000000A64R-0USf
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:33:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D96B240678;
	Wed, 19 Aug 2026 15:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DBF1F000E9;
	Wed, 19 Aug 2026 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153588;
	bh=MunvRRyoT472We3pqFLM4NIFhmOa/CU+LlKipVY5NLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FWVDs0XGyrom+fjCI0UHQR0u+00NRjJjgDFu/yG5Ceywyw9IIWSRyxwYwkxzbVIbK
	 SM6IPFmMO3eltxOKpR91X3zZG0JZiV5hgGb3UWpde7JGPcy9Zh9ETrNZCqnx0W/Pla
	 7K/Qwgedrf/KEgqDFpo2eMsd7KMsx4QMe1q8c8NQWlpEn3F0KxDFsbrrnX0cCT7wFP
	 /F6mzedrfA5xI9Vi6gDIjGxcXweUXsmR+HWjd2Si2g5NDifGGk3ZBXr+0PY5kDPQvQ
	 Bg1H+zY1/PWDLd67OZV/lH54+wpBcIYqkeFmpP5p4qhUGf1q8Rsqrlh3eYAdDIqrLJ
	 vRpZpyu+E+kmw==
Date: Wed, 19 Aug 2026 09:33:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, harimishal1@gmail.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	gost.dev@samsung.com
Subject: Re: [PATCH v2 0/2] fix racy access to FDP placement id array
Message-ID: <aoXMs3EORQugrJzU@kbusch-mbp>
References: <CGME20260818060330epcas5p4556a447149a5c2cd1e9aadd64952c01d@epcas5p4.samsung.com>
 <20260818060253.4104-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818060253.4104-1-joshi.k@samsung.com>
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

On Tue, Aug 18, 2026 at 11:32:51AM +0530, Kanchan Joshi wrote:
> Patch 1: prep to send non-admin commands from nvme_alloc_ns_head
> Patch 2: avoid the race by moving fdp registration to nvme_alloc_ns_head

Thanks, applied to nvme-7.3.

