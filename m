Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D548AC47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QLsLrohYOTPYWeqWQJCrqDCgQ39/ntytMGiJILJZ5d0=; b=uVAPAv9lz4TYI4ORiTzBXzskYK
	YdxzLf91+xab/n7QjOcBkKC0wiVcOcWEWvyR4TAsOuXHQBlxZdovVJBq5/L3WqjPRcjBRes7ib3hK
	pbnJNg14cdpdrF1JV/o+SLjk3GUy34FrFPJ4KR4sJo5pPJiu7lT81VdkygL4SFMDhNoiGhteYr3xD
	tLqyHNoenlPkIBERQD4BvXIu0SG9pS4gDJPTT1r9i++mYZIrI6V69jAzJqNrL/4H3HAUpy2efrJ92
	W+AEqRGh8dMgcGeV/mSJGHY6q+pX3msd5wmyhDCZxPwauKymmcsSLScUk5xRDrybH4iM7+cKdSEIb
	nDnFaBbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFS5-00000008VVx-18gc;
	Wed, 28 Feb 2024 08:38:09 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFS2-00000008VV9-2AY7
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 08:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709109482; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QLsLrohYOTPYWeqWQJCrqDCgQ39/ntytMGiJILJZ5d0=;
	b=hnkXV+hJfNHyptgV7vec1yTeqqOEKyYQ89d20RIWjFPjlPI9UyajJxsU3tn6Kp/3Z7SNVuVpVwTRQw1QEiUF8Y9mXiIAB5wFRaiI1tIkrzLbpzB5w2GRkYgMPF4jf+kQqE4/qbKmh3IIlPXbfNnjZzsNtljqNHdhzHLXjIuUv8o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1PIy3c_1709109476;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1PIy3c_1709109476)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 16:38:02 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/2] nvmet: add some commands tracing
Date: Wed, 28 Feb 2024 16:37:53 +0800
Message-ID: <20240228083755.125259-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_003806_740827_7E05E9B7 
X-CRM114-Status: UNSURE (   7.01  )
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

Hi all,
	This series of patches adds tracing support for ZNS commands and
authentication commands to the NVMe target module.

Changes from v2 to v3:
- Translate zns's zsa and zrasf to readble string.

Changes from v1 to v2:
- Remove patch 1, "nvmet: parse dsm command's attr deallocate when tracing".

Guixin Liu (2):
  nvmet: add tracing of authentication commands
  nvmet: add tracing of zns commands

 drivers/nvme/target/trace.c | 98 +++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

-- 
2.43.0


