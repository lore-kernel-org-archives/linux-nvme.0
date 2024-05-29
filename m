Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A426C27C44
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z46mNi+mInrQnwxI6JBJnQxiI/9s8qF/Kz7vO/QKFX4=; b=Nf/S+VwZd85wI6duqNBmgLpwS3
	3m4GhCm1qfcGG9LeFzQDCVXjDi6vqvS0zDjNWTfVNlHNK+yD45xdRSk9W5TOeuL3775ve+0/ld6vN
	8McovWP0loNeK7KgA518LJlr03d0gG87I0QgBOKz9Wda1/4KROUjCKO8XMwmG25QtNLZWiPR5OgQf
	rGW3EiCvXrU/E94fmT9UbpZLQs/wxHX/IEg8ZoXViQvFrdqcfH4o5SoZXJ7dfSwTF9tGMOJYTgD+1
	sRl7creR5BJKnkhRxqoct3bFZBHhf1lKRHWd0t1hf9eFnQR0wCPGBr/JHakdDpqnR7ZGmaI7PiYqL
	j6OgeLHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCILk-000000045hu-1DtE;
	Wed, 29 May 2024 12:24:12 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCILg-000000045fb-2alj
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 12:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716985442; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=z46mNi+mInrQnwxI6JBJnQxiI/9s8qF/Kz7vO/QKFX4=;
	b=c0VMfn6bi/9LJXfUS/bLrxDm5YdFq7UVIwRRMjtddJlzfKCflR/iVbWG8NuD76IV4umN6bePvk8TBy/fYIXt9cXQWpkDRcttn7LrqyGrMVWZ0L0y8VzQxW3YqkofRLI4dECdcDmxL8Y6IJ/6aGdZP6rjnrqsmApxvpwOu0DkYf4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W7Tq3Gd_1716985435;
Received: from localhost.localdomain(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7Tq3Gd_1716985435)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 20:23:56 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: linux-nvme@lists.infradead.org
Cc: Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Weiwen Hu <huweiwen@linux.alibaba.com>
Subject: [PATCH 0/3] Refactor and fix about NVMe status code
Date: Wed, 29 May 2024 20:22:57 +0800
Message-ID: <20240529122300.92377-1-huweiwen@linux.alibaba.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_052409_111010_F29AC905 
X-CRM114-Status: UNSURE (   9.60  )
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

We discovered that the PR ioctl status code is not correct for cloud disks
in Alibaba Cloud.  It turns out that we have MORE bit set in the status,
but nvme_sc_to_pr_err() forgot to mask it.

Besides fixing this (PATCH 1), I also (PATCH 2 and 3):
- replaced many magic numbers;
- replaced NVME_SC_(DNR|MORE|CRD) => NVME_STATUS_$1 .
These should clarify the code and make it easier to read, thus reducing the
chance of introducing bugs like this one in the future. The patches should
not affect the behavior of the code, and are independent to the fix.

Weiwen Hu (3):
  nvme: fix nvme_pr_* status code parsing
  nvme: fix status magic numbers
  nvme: rename CDR/MORE/DNR to NVME_STATUS_*

 drivers/nvme/host/constants.c          |  2 +-
 drivers/nvme/host/core.c               | 40 +++++++++++-----------
 drivers/nvme/host/fabrics.c            | 10 +++---
 drivers/nvme/host/fault_inject.c       |  2 +-
 drivers/nvme/host/fc.c                 |  6 ++--
 drivers/nvme/host/multipath.c          |  2 +-
 drivers/nvme/host/nvme.h               |  6 ++--
 drivers/nvme/host/pr.c                 | 10 +++---
 drivers/nvme/target/admin-cmd.c        | 24 +++++++-------
 drivers/nvme/target/core.c             | 46 +++++++++++++-------------
 drivers/nvme/target/discovery.c        | 14 ++++----
 drivers/nvme/target/fabrics-cmd-auth.c | 16 ++++-----
 drivers/nvme/target/fabrics-cmd.c      | 36 ++++++++++----------
 drivers/nvme/target/io-cmd-bdev.c      | 12 +++----
 drivers/nvme/target/passthru.c         | 10 +++---
 drivers/nvme/target/rdma.c             | 10 +++---
 drivers/nvme/target/tcp.c              |  4 +--
 drivers/nvme/target/zns.c              | 30 ++++++++---------
 include/linux/nvme.h                   | 16 +++++++--
 19 files changed, 153 insertions(+), 143 deletions(-)

-- 
2.45.1


