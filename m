Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06D9CA601B
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 05:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krzHIwcfibK7gOF4hb73/webqprmVFn/kkFH14YrjSI=; b=dl+3u1+92LvC2nwnFqfwWTIKQM
	07Oiv2EkxGYWf009wmFCA+YQDMXrsdObCTxKCSQk+dr1Yd+MYyFaMFa+6A1BkZS1onRNS0QVCt8Uh
	LB23PwlrcP3SWEps8DQbrdCwuxSZ6gySoRzXJ+wRlF6rgIrwDxNftOx1cJD0YCt4FzAbPYNNPy4l6
	I36fcNObdgqUF2DnVWPjexe0jHJjh4+HKlyiVv7W4oeIjlU/ElJLBMbXQsfRNJWMYRUnzP/fnKpVM
	99gjVWlIgiOL50pbqVjf/fxINVvm1XrM9Zz9wlBg/7E7KuYrcqzUtIUOKGW0aifNSSYTaf2d1Wy/J
	eSLrWSrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF2o5-00000005VNt-1QPW;
	Fri, 09 Oct 2026 05:06:09 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF2o3-00000005VMf-0v2g
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 05:06:08 +0000
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B78620B7168;
	Thu,  8 Oct 2026 22:06:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B78620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791522365;
	bh=krzHIwcfibK7gOF4hb73/webqprmVFn/kkFH14YrjSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLsXUZDPoBCSEy8wG/u7gjXtLG2ECC5KTYBGZg0TxWdd03KBPFWXQHyxNys7PLSWG
	 +wjGNPzIVNkkiUCDgNlAaHWYBP5pBXjUQvdZasP7wt78xwrZ0yuZm76GpK4tzfR/bO
	 8nnshNNyrkdqeS2WejN6dJq8XdlKoJPQdMjEJUrw=
From: Naman Jain <namjain@linux.microsoft.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] nvme-pci: select IRQ_POLL
Date: Fri,  9 Oct 2026 05:05:54 +0000
Message-ID: <20261009050556.2817978-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009050556.2817978-1-namjain@linux.microsoft.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_220607_285891_AF078AED 
X-CRM114-Status: UNSURE (   9.85  )
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

A later patch uses irq_poll to process NVMe completions in bounded
batches. Select IRQ_POLL so that support is available when the NVMe PCI
driver is built into the kernel or as a module.

Assisted-by: LLM
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/nvme/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c9..22164b901da85 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -5,6 +5,7 @@ config NVME_CORE
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
+	select IRQ_POLL
 	select NVME_CORE
 	help
 	  The NVM Express driver is for solid state drives directly

