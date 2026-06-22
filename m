Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECD2CD98F2
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ny2LxMQcVwqYpwb6jd2D1S5kV3aBfer3sX0bqWrSA+4=; b=HCCPh4TtgM1jnIrCgnus9bDbLr
	LKHyPzX9UrBj4TwCbOtRM2HWTACaUkIJQKkUYAzWBLr6fYOavM9Z/KusaqI2ZG8QZ9Y9qBX/EN75a
	VxIAI1mw0w4w4EzBKRU1uQRrHvRCpMrtOO4pzZ92IQI7O9MQjp678F3AIDhMJ5Q+0Yr/Cq9JNPHO5
	3TZR1BpntXl83AHBQSKIMCmGuuUUf/hZO/ADQ2s+xv8hQN3KgJQetEnbu0Lk5fQAGARI2cWH154JA
	hj6C2wg74PBX9Kja/z1YDPwse1FHdQjzo/dAZqf1LuuNlz1uYTUiEal8JGpmdo2WM68JgNu1wtJJv
	zB7RTLfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfnL-000000055Xw-0j3N;
	Mon, 22 Jun 2026 14:38:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfnJ-000000055XD-1WQe
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 14:38:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 17C9A43EC0;
	Mon, 22 Jun 2026 14:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD121F000E9;
	Mon, 22 Jun 2026 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139117;
	bh=ny2LxMQcVwqYpwb6jd2D1S5kV3aBfer3sX0bqWrSA+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nWZdqr850HISQ1pRUoZjDbojw/Gs297GgPBmg893bp/gOE/ZryyXFFdNLwn0A9nK1
	 EpawPGm9yoUkOSk4LIaIDY4JnuRthvJ7E9BL5tDp0souDMF+u7PdPyybuR37L3nzeh
	 qibKyOsogEH5loHSKjoIxEdwWA2OaRDGc2JlL/GDydvmqEJxTpjR1T/z3FMA2/bez/
	 nmlBx0XK9XYuI754ds7Llz+Ac73XvRninDskbGWDhACv+addnv+cSbN3FBQL4ovUCa
	 JQG2/yKQWykaBCnaqhtRl+zZkRO//emExZjTiCFQmYGlRs/m5UCOqCJ2LCfQJj6tHQ
	 8y4oJOxgS0zbA==
Date: Mon, 22 Jun 2026 08:38:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make unexported sysfs structures static
Message-ID: <ajlI6zGWNNzywtoX@kbusch-mbp>
References: <20260622142357.494750-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622142357.494750-1-ben.dooks@codethink.co.uk>
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

On Mon, Jun 22, 2026 at 03:23:57PM +0100, Ben Dooks wrote:
> These sysfs attributes are not exported out of sysfs.c so make
> them static to remove the following sparse warnings:

Thanks, though I already have this fix queued up for the next pull
request that will be sent out this week:

https://git.infradead.org/?p=nvme.git;a=commitdiff;h=ac48c49116d3de84fabc224c6e43f08740b1460d

