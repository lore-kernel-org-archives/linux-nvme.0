Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E616FC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 22:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lEXl0AXC4UqSEWNRf4ASbxAmNh2FHhY4CkEdjzfwivg=; b=RFmSXcsMsJFMWpH+O+Bq4SUsWt
	tec50+czDQcdbLhijUjX1HlmAk7ZS9Q4IYVXdlq7xruH2nz7uMfmuoEyVnwz/Rivq2WdDVzGy5Rkq
	QCjLI7HmkttcEJxB1HI/6WhWHlgR+NEOR3tCXcoCKuKu8JLZB1t1sfWvSyS8gEhsVdE2rN2d//rAs
	8WQS3+N8VT10GJTA/wVGx8Y1BSqoprTsVqBtYWq9jq6jS6bLJjNg098ecB0OH1wO1H91wjuYpXZRR
	RreXXQki1tvvD448P/9O1K/FMUuOAa38wsUeh6KhkX9nxxMt0ofqCYo4Fl2C+/UXKcioDhPIAVAZb
	Zp5gbctg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjlYB-0000000DOjA-2Zuo;
	Tue, 14 Jul 2026 22:24:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjlY9-0000000DOit-1RoO
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 22:24:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D4F1601ED;
	Tue, 14 Jul 2026 22:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBD81F000E9;
	Tue, 14 Jul 2026 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784067864;
	bh=lEXl0AXC4UqSEWNRf4ASbxAmNh2FHhY4CkEdjzfwivg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IjLWi+rFSZoYj2+1oL+u93Xp/tw5ZeEjBL7E7Pu6cGNoxq5hoPdKfTuNpuBTBcYdF
	 mxUh7jv17WIAwKSwdvplLsJTKPH7xFnhAtTriOBf3wr/QnAIOWkMVAYa3I4YB4+0i9
	 3wu046PhJj84HFPySCWWGtN582Mpwwk+tJ7S6H5pwhhJdZohTi0vBn8MFHfhI9wgLS
	 xdszfNisrOIHcqRCGSYJQkv/zQ5bcu768Mda79bKskTMQXutRUSq9+szN/bULtP0ys
	 oCEuczp8aohiPjkl9U2eGgzA7SiNZzdONU5cLJr81bgHGJ/WJD3P+nIn8cu+fVfOPO
	 6o/GQKvhte/XA==
Date: Tue, 14 Jul 2026 16:24:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: bound ns descriptor header and body to
 identify buffer
Message-ID: <ala3Frae9lcGlHZP@kbusch-mbp>
References: <2026070931-stopping-cost-239a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070931-stopping-cost-239a@gregkh>
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

Thanks, series applied to nvme-7.3.

