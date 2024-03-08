Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD60C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=; b=yK4QlIoqIt7liqbpBT7iQFYzDh
	oJQNxgIHLgA4pWmFeY1QSNOexjBT7M9CmVzyC5hpt06gdDmPQChJFonuz4DfI/HKKkMKbQJFrft42
	7nWsJzDLtnwP4cvplsIDxKLMSs3fnC+P2JJIfZPXq3i+27brHdkYIqfIf5LCBbUQzvglvX7abbLbR
	+Th+8GZRhuPYuid3dOnrf8BBXSrr0J8+QKvSxCSlIbIJzoKNBWi3daXCqNJSRdPpls32jguHmv0W7
	58GauQFjHdIz5/c1mhK6QKnot+MT6jBjv+P89FEPGcfyBmUHrR0D8d6IIYuPYCppRbkpLwrePCVnE
	kB3koDOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricyH-0000000A8Po-2E27;
	Fri, 08 Mar 2024 16:21:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricyE-0000000A8OX-0f4A
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:21:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D0B1060B99;
	Fri,  8 Mar 2024 16:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAB4C433C7;
	Fri,  8 Mar 2024 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914875;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M52j7vmjicx6TB3TqBjKRWGp2rsiWbQXY2S4jVBVZrlpoeLP3nRguZFHvkakOghGb
	 E2JZ+Lu5drNsM0pymoxu2N1URchLuVh0Mk3dGBkOtW+ca5yqtROYyjuWKwGzzC9jng
	 o9ln1PTti6UUUXVVS9AAsveqvXXompUus2pU2Z04IfetQm3t1vJbsBqH4S2S7KquqE
	 CUGhDNmCqO4e3UlfO+Uq9F/wPIjX4eh5iRkB7Wj+78+VBX8ZZe4h6Tn4Ck5k0g2p4J
	 2sLta63E5uk9+POsSzhgGUasaCzCwVeubC7LUDbu6P2vXHxZt8Oqicg2HUYQO6R8EL
	 K+zj1CKIxTDMg==
Date: Fri, 8 Mar 2024 09:21:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/2] nvmet: add some commands tracing
Message-ID: <Zes6-Z9GYWWp4ivT@kbusch-mbp>
References: <20240228083755.125259-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228083755.125259-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_082118_300293_3C91E1AD 
X-CRM114-Status: UNSURE (   5.69  )
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

Thanks, applied to nvme-6.9.

