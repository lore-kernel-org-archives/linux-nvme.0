Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E71C54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YSi91J2Vevwss2Bc6D2Ppdsb0TyisgNBR+t6gy+a4DM=; b=1+TwoGMjwicqAPsQ1GYKIMZAJ2
	ksw2PSsnfRQuCX/h1CxGXfIhTmSHIG7DOR4OE8OLNwqv7xcxGIHYz2FypeCVWLs8XT1izP4X2TnHK
	bz4XnFag58m11FQ5kd9urDnf299msR9ogjIuYDpR6x4sP0zjrjALbpwfJAfuxflaS43y0y8m2zySk
	DSdfFYUrzJXZxAEIEYF/jatXnZElF4O2WIVOfxJQbpm+TcPUE9xqaYmK12YZA+RssRYnDB1V+dPIp
	5SiY1hTxQ/Tk0zSDcWbwc/CX58SY9r+3xLYTucvLyxwdTm2eMDHerOaUPhBxnLCnxeDLsYfILwC9o
	CHgW70wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5vj-00000008MJe-1Mtx;
	Wed, 29 Jul 2026 15:10:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5vh-00000008MJP-2X0q
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 15:10:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D2A7B41758;
	Wed, 29 Jul 2026 15:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4751F000E9;
	Wed, 29 Jul 2026 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337843;
	bh=YSi91J2Vevwss2Bc6D2Ppdsb0TyisgNBR+t6gy+a4DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hcHv9WhjWVlsM6xKCg24D07hSXhMqGYLvx2MPq20/0HN3kK9Oud0hp+bCDJvOTm9I
	 Xxp6LjtxF0uQEZtb+2eGMs3sUqwBaRjbQ5Tm70uhV9zAu0xaOfHTTbiAorMD0yHbby
	 qlB9UtuggAY3QQupU104WZFCbHHKHixkn2okc/5hPiI/FrP3LToow/PXu9zwQL2wcJ
	 X6wemaqpUQZnlAPYSeIxKTUthS6bGC0j2rbEmKQ85bOln1x91IRccxxTbElY1m0hQ5
	 1nwccJgJ7EfS6VBaSH8PsGnR75Zff7z4Qd9BDfikjAraSRDCCgIb/YtiTGFDvafP3N
	 94LjWrKr5vTmA==
Date: Wed, 29 Jul 2026 09:10:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvmet: fix return status of RMI log page on
 allocation failure
Message-ID: <amoX8VJpmyeKevPd@kbusch-mbp>
References: <20260729105607.1398478-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729105607.1398478-1-kanie@linux.alibaba.com>
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

For future refernce, please use something sane like 'git send-email' to
submit a patch series. This one is split across different threads.

