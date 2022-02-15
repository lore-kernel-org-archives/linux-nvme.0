Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C32FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nl4o5RxNNbIt1Z6dWO7pSY8Wjf8IseaJQhEsbr35n2E=; b=0WzXF3t4f4fjS2gLWf8jWfRmgR
	EMKJcZG8qjlLQrnZ1hqUC8XhjNTtlM3795AEarRko7w+n3ICwbdy5BfVlphDz3yiHGp0iyexBniaZ
	bQYiU3B+SjCj+GmtkoMKMKMUQVB/gvPhaDZKJvT4ZWxE36xbuX8VRgSh3vBaoCj7SifsCJ0XusAoL
	lbHQSL4I4373pkB9i93wxFpJ3LTJNvunaFuVPhNA5OpBlma2inDrd3Ms2cGHRMxCS17hRhGSDCfj7
	+YvpN4mHJQbXi+kopBf+H1UM6fuhMnixHf8SSFLoYevslJ26uYQF9rujJfG1gisNk6drMCk4tVnSU
	svSK0FiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK3KU-004GVz-3r; Tue, 15 Feb 2022 19:17:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK3KR-004GU9-0b
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 19:17:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F2F2268AA6; Tue, 15 Feb 2022 20:17:31 +0100 (CET)
Date: Tue, 15 Feb 2022 20:17:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215191731.GB25076@lst.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_111735_250238_139396D7 
X-CRM114-Status: GOOD (  12.21  )
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

On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
> After the surprise removal of a mounted NVMe disk the pciehp task
> reliably hangs forever with a trace similar to this one:

Do you have a specific reproducer? At least with doing a

echo 1 > /sys/.../remove

while running fsx on a file system I can't actually reproduce it.

