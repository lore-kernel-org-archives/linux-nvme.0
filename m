Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D96DC7115C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 06:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pU6v4Jv+lwIENOosKtVLMiplsUndBuvCHpeyxE87pc4=; b=QQc8Wsd0k9+0d1z3M/v+3Tj4gu
	awhQJvDHE6Mynl8W7kYQbjDGhiLSpH+pi+e1jYxsLHr0nDafw2TFph6efzskr0g8F9oKMjiaDWbmH
	8uKd6Vkm07zMeqq1hNrNylmfuM1p+IIZrGlwOOAZqxluO0a5qJCG6LHceVN77xZgvcxqc0ZZdhyO+
	rsMuGXgV5OObdA34cBzNXG+VFfXiY+DTc63Xm/YDOYZvKYXOkQ84R0rz/gnme6c25smuq/uzmrFlI
	zaYC/bMKZXq+7BBBjsTziRXNFxx6UiKkuOqZ5wOjF9CysTw6jKWyeVMaaVhBbCPQ7Md+WW/TKihDW
	9Itz+9Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJzu-00000007jKV-3txR;
	Wed, 25 Jun 2025 06:52:42 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJni-00000007gnH-3LSH;
	Wed, 25 Jun 2025 06:40:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Subject: fix atomic limits check v2
Date: Wed, 25 Jun 2025 08:39:54 +0200
Message-ID: <20250625064003.436582-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
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

this series tries to fix the atomics limit check to limit it to
the per-controller values and to the controller probing.

I think this should solve the root cause of the report from Yi Zhang,
but needs new verification.

Changes since v1:
 - initialize subsys->awupf in nvme_init_subsystem to make sure that only
   happens once per controller

Diffstat:
 core.c |   83 +++++++++++++++++++++++++++++------------------------------------
 nvme.h |    3 --
 2 files changed, 39 insertions(+), 47 deletions(-)

