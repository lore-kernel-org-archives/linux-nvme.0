Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCE7C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xZkaB3vSNVhh3AwEWOTxc3wLSRpDilse7YBukLyfPIQ=; b=4jqvqj73Rp4vuZUxMMoXLEBNUv
	WtfIDyNKL88rItD3AIQqGU/IMN7wLlpPCUb1mPvJl1eDKiuNAej/m6zGw5dByT0h++uvrP7PelW1e
	KEtjQDMYTCD0qJVQv8mWyUaNnR6/9oVE2oQsT5GgsPBfGrkC3a1sHZMHQKavjSIxYQXsbLigJ0crP
	Cim1lJGwaurGqTrcU1vvO5Ig/3I6e1UNnX0ESiJl39xSRYwfZnABfvrsgVjrwHhy7sI3MoSf0WEDG
	ymxgfWHnlPYSecV8NDlaX3UtlIGyFMzVlGYwKtVFBF8Db9Wzqwn4loCR5Knrg6Pc0VvF3nUW63IQH
	/doMYsTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyT1-00000006KGJ-3T1C;
	Mon, 17 Aug 2026 14:37:35 +0000
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvySy-00000006KEG-2AW4
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 14:37:34 +0000
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a47a6f35;
	Mon, 17 Aug 2026 22:37:22 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH 0/2] nvmet: avoid configfs recursion when enabling backends
Date: Mon, 17 Aug 2026 22:37:12 +0800
Message-Id: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01027db8703a1kunmc75580f1e6400
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGk5PVk8fTktCHktDSkpJTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KywU49zqZbkoGv6mn38VdoEC77PYf7D43LK6J0Fh/hiac+LQ8TRNirJGsYXijXKNv7nQsRKsq8lwea81eLBLW3EDFduefc0e/B8mgPrJgbcLenMKL22WO37vBT8daUWJvkE1n64YEY0bGhzOLubt/nCG1aD6zl+/qUi1ZytlnHE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=xZkaB3vSNVhh3AwEWOTxc3wLSRpDilse7YBukLyfPIQ=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_073732_747883_8B34D356 
X-CRM114-Status: UNSURE (   5.84  )
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

The nvmet configfs store callbacks run while configfs holds the item's
frag_sem. Two enable paths then call filp_open() on user-controlled
paths:

- file-backed namespace enable via device_path
- passthru controller enable via passthru_ctrl_path

If either path points back into configfs, the open path re-enters
__configfs_open_file() and tries to take the same frag_sem again.

Resolve the configured path before opening it, reject configfs-backed
paths, and use dentry_open() on the resolved path. This prevents the
configfs recursion without changing valid backend users.

Runyu Xiao (2):
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c | 19 ++++++++++++++++++-
 drivers/nvme/target/passthru.c    | 17 ++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.34.1

