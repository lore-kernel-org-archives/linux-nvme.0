Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E27C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dY8ZPb80LZRemTiVVZ7tuH0nrYZg7eFrJs64w9exW4A=; b=NFeXe2bSnb75gmxIoqpeFNTrsj
	OT57fOpA21XFOmyl9rXenrHEsDLjK7zjVkOQl7eyYWj/KJMbE2+YwpNTAJ1oNLG8/JYp2qMGqolq7
	hDGUba+4ceHQNUlXsTp1Mf8j9hzmw6u9ZYX5CtnoPAwUgX7PEoQjDV306m5j0lCK/ss8RXKMy7clu
	MfvRHN3wGZqzUA08lwrZYX/6NYl/vsP1SNckjUSZr3D3SLdOFSUEjmpVWgDd7VynCKf4ekFzP9DdT
	yNpkyX+He9704v0jCgvcPb/5F8JbAgRk0GK3PEWVasBt6OFff+7MOkwJU/jh4mLvfvqeuzpRnxE6x
	3jDw4MOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585S-002obZ-8r; Tue, 13 Dec 2022 16:24:58 +0000
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585Q-002oZZ-0T; Tue, 13 Dec 2022 16:24:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: only allow unprivileged passthrough for commands without effects
Date: Tue, 13 Dec 2022 17:24:46 +0100
Message-Id: <20221213162453.584965-1-hch@lst.de>
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

Diffstat:
 host/core.c        |   47 ++++++++++++++++++++++++++---------------------
 host/ioctl.c       |   19 ++++++++++---------
 host/nvme.h        |    3 ++-
 target/admin-cmd.c |   37 +++++++++++++++++++++----------------
 target/passthru.c  |   25 +++++++++++++------------
 5 files changed, 72 insertions(+), 59 deletions(-)

