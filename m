Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4582CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=InL1o4jKSWjKIEI1aNwx6pCIWRPyZ3QTqivmJuoeMvY=; b=oSkKwiA0BBDWAqGG9oxJR1hUMP
	hYVMKi4qSNAEqj6IEYxMpC0aEucAre6D2TnaWoclhE4OoYK7UHKRRPJsmCm522DUCObr0oPWXErux
	Fg55ih1PjMg8o8yW+ur94mKgkrskhDIGWQnFvWNu0SHphCpvFL5KebbaGMU4MlPYuNkTuyTftIp4Q
	0y868gTNPDh+KvopeW5WEbJF54T9zDb9KWTikEvrEJT/7G+Alg+acBCxOQ1ABmNI/5tp4EKHHQ4X2
	LATycS396sBD1NTNnNx5QAF9Hj4JBFaUVwv4vPYsnMj4IqKUoqrOLo9I6WgL1LDU5/Nw6LkWAimHZ
	CbqJFzRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOK-000VKg-47; Wed, 14 Dec 2022 16:13:56 +0000
Received: from [2001:4bb8:192:2f53:94cc:fc26:a27c:8f96] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOE-000VIm-Im; Wed, 14 Dec 2022 16:13:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: only allow unprivileged passthrough for commands without effects v2
Date: Wed, 14 Dec 2022 17:13:38 +0100
Message-Id: <20221214161347.764071-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this series first fixes a few minor issues in the CES log support in the
host and target drivers and then uses the log to deny unprivileged
passthrough of commands that have effects, where the only practically
relevant effect is the modification of contents of the data stored in the
namespace.

Changes since v1:
 - make sure ctrl->effects an nshead->effects is always available
 - initializse known effects at init time
 - remove the use_workqueue field in nvmet_req
 - fix up a commit message

Diffstat:
 host/core.c        |   95 ++++++++++++++++++++++++++++-------------------------
 host/ioctl.c       |   20 ++++++-----
 host/nvme.h        |    3 +
 target/admin-cmd.c |   37 +++++++++++---------
 target/nvmet.h     |    1 
 target/passthru.c  |   61 ++++++++++++++++++++--------------
 6 files changed, 122 insertions(+), 95 deletions(-)

