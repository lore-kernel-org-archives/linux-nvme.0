Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B47CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 07:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Uzv4Qswz4LFBdvHpOhuwV4rJuXdjy1M6zDzf0eSJNg=; b=XMVqsYZNEJQkDGBu7Gwk82nP3y
	bshCnJS6WPU/GIjsSs5I7tQxcnkV73gl+SeVsxOdafSv+YEf917TmZkRfoHZql9eLm+NjHp0ni8Dg
	oee53K7hXgzuXFElo1f3KQbO3I0ByyShU+bqfqSTroIdiXcyvyNFNIZP6C3wAJzcF4rLzuuI0652l
	Xt0XOnTZg/xz/sWoppIvd1eiNKW55NJoq5Bd2TeXIMYztX/r4YTgfLMuAbc2LhbKpUqNMHeddT4Lc
	WgLZJ+pEuQCzd8WWyRoHRLD+lSSBifEu6YRInBIYC7qnLjIyC1PiTnVFPfY76aAS5AMo1JaBzBTq6
	y9RZROiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Z2-0000000AdXS-0hCc;
	Fri, 26 Jun 2026 07:01:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Yz-0000000AdX8-2bmp
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 07:01:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C33C368AFE; Fri, 26 Jun 2026 09:01:17 +0200 (CEST)
Date: Fri, 26 Jun 2026 09:01:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] nvmet: replace sysfs_emit() with sprintf() in configfs
 show attrs
Message-ID: <20260626070117.GB11368@lst.de>
References: <20260622025915.1294806-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622025915.1294806-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_000121_813175_E3C2C13A 
X-CRM114-Status: UNSURE (   9.50  )
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


Adding Greg to see if he agrees.

But if we add churn to change this, we should probably switch to
using seq_file for memory safety, and have some generic
configfs-level infrastruture for that.


