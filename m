Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375FECCD1A0
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qH9stToMqk3SMsag+rAXvfNzqj12US92NzTuc5WZtvM=; b=krA+EJJZ0l2yMLli65MAGqZR/b
	i98LXJmcjbvWmOeLM+eKmICGWYN0twBk38yH4k43i8dP00qrwR1WODqqSydTI2XGc/4T3BwjvKl/I
	ndYmLc3SVi3z59SgyyLgOQBqMnL9YDlGvkFZBMyfphMdcT3oUyzw0mGvRZgdBCawgPbo7r1kElcL1
	ZqjOC96g76EiG4saBvpRRRztWUocYH9B7/kaXzOUkZCTn5+5ZvceeDLMEM47lySi7rO6Jb6s1dw+9
	ToB2VLxqmz7miyAh6QW/v1P4yBeQU6RzCZ6r+iVwNMrVYF4cJGisQAU/3mh7WR0uWpSKpkPpw5R7c
	qbMUdqSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqtPY-00000008C54-3aA5;
	Wed, 18 Sep 2024 12:03:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqtPW-00000008C4Z-21tK
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 12:03:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DDA1227AAD; Wed, 18 Sep 2024 14:03:51 +0200 (CEST)
Date: Wed, 18 Sep 2024 14:03:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Fix warnings given by checkpatch
Message-ID: <20240918120351.GA20881@lst.de>
References: <20240918081134.908075-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918081134.908075-1-roheetchavan@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_050354_690673_656C8D01 
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

Please don't waste peoples time by sending checkpatch cleanups.

Good coding style is nice to have, but unless you do actualy substantial
work in the area that has issues it's just churn that creates work.


