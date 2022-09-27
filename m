Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB63C6FA83
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+knJ5T8TjMm5viOTJDIwjHf8YzjU5XT8An6B0kYFWs=; b=Fb2OHYslAF50wAMG3tcPx4FyT9
	J/bqAvwpKbjdM65MCJGeL76GeLVAV8/gjKGpRQy/MHa7vne/xN5X1YyOOt5e38QBOs4ggIaHPy50Z
	4Jd5cqcK0su9Bsc6Mx8cFiYBl6mIkqho5BusW7ASQ83Wv21Os9tL4efdKCzmu5ddLJ7Wlzvb+CSD1
	Q31LzD0NzbnkrvnYMexGU2Oka2v4ZKhetJxYpsrehu9bwJO23erbEqtkDg7ACYuHveu7iIjnyjCmF
	gNuCrqFCBPS/Mz94TkYH6sbMDAQVizlULGUqlTxlzdASCD9VqSjUm0TmSnGrK3CMcCcoxdfMTqD95
	fLJNLKvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od4zr-008mlb-AA; Tue, 27 Sep 2022 07:27:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od4zo-008mkK-En
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 07:27:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0654C68AA6; Tue, 27 Sep 2022 09:27:09 +0200 (CEST)
Date: Tue, 27 Sep 2022 09:27:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: consolidate tagset / misc request_queue allocation
Message-ID: <20220927072708.GA16710@lst.de>
References: <20220920171611.1289361-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920171611.1289361-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_002712_659183_769C2D60 
X-CRM114-Status: UNSURE (   8.22  )
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

I've pulled this series into nvme-6.1 with the additional F_FABRICS
check pointed out by Sagi.

