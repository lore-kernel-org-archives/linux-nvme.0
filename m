Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0C7C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=OJD1WrIam2cQDqiBucDgnB7QF5
	1URt+25jt8IG3Vp25+wNndnz5StdIn3fgxjOXeSV3nyxbiCuijolTuaMTQFOT4/78bUkpOC7hcXPt
	dkxd+RJ7jWK1kHZAAPFzX8oarM0ZvQvcwdPXYQded/MWXZcXZa1ntFF/aYNvqKwD/+vj68Mc1cppb
	httqUPKP6BUowof7rSi6TmsYyd/u9yv9hJch8rmBU+lN7bfp0Pb74Xs6QlGUNAUKtZ0W9pJVRqjpi
	Du1aRaKnxFbOwuUVg41ORBfholCfp7SXOlS2qs7xSKCeJTqhDILO1Unp3wxd1PvI976yyL3oLvKxy
	zRBGSmFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLaM-0060sa-3b; Tue, 25 Oct 2022 15:11:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLaK-0060rM-1X
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:11:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5265668B05; Tue, 25 Oct 2022 17:11:17 +0200 (CEST)
Date: Tue, 25 Oct 2022 17:11:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvme-tcp: Fix possible circular locking when deleting
 a controller under memory pressure
Message-ID: <20221025151117.GB22870@lst.de>
References: <20221023080443.592097-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023080443.592097-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_081120_253241_69A99CFC 
X-CRM114-Status: UNSURE (   9.82  )
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

Thanks,

applied to nvme-6.1.

