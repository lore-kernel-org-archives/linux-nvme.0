Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FADC04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 10:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mEVFUR9oVmZVCw5i2vjgfftJ3ZERag/n+RP5XLWwaDY=; b=AzkoRJF/PBHK7pGzKYtKkUiWCP
	iVzUYN85zic/eSg8QmWWl3F8+t19DlR7CY5HD4tasZ/D5PQXs0JqVszWbnQ/DZOExTghki69N2HUd
	IyOAFgfqJ9Uyap0NWFTmW+f0/QzoDGw/bLeJSkvC/K0hX1B+y3PCggHCBJh3H5aVF591hk4/HrF6D
	A5dXDZrSxHklROFqAjUB0i4hqBkMdCOCY9pKgd/L9yg2xWb3DiTAphG9ngws16TUeVa4udduAd3hL
	dTNliQszqSv0j5DMOdc5UuqyZHtpRhodzBQP834UdEopzvzwc22UW6Gt4UJWVdwKMMJcZXTqRl1qR
	lc8HI/9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSy-0000000EyNU-0tla;
	Wed, 08 May 2024 10:24:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSZ-0000000Ey4O-10fm
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B249C61B6B;
	Wed,  8 May 2024 10:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20460C4AF18;
	Wed,  8 May 2024 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163818;
	bh=vKCZGsqgIqVE83qpd+gQHyJxRB0NEdxqv5QYC6Dinvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+pE3cxYdlkNo/TQAxfvWIa4pPqo5OB281nZuMoi7aPkwbMADqfnV8750SGfouLif
	 RLfbrLBxdtA9mRes8mBTNOWk3OCf0JdE4xHuqK6+T6y+Gm6oC4o0Qq5rCkZa31Axjf
	 qHZbcKjSBM/nYsDaQ2YSVY11chh/REJZbaj+BKF1TiCxxjxrlEbCCVt4g7oGqyvVUE
	 0GcP2o+Eod0ALV7a+sfIFUueV5RMA6tTRhb7qTmWnNHn9hmxlSUIv8KfR2pyqd43xI
	 oGxgWw33ZoK1VP6pToBTVbL22+7eaSw49Hv0szWCtkgp5CWOl6ctEd+/zCcogA9Pyg
	 p9SlsjQfKq6jA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 09/19] nvme: add a newline to the 'tls_key' sysfs attribute
Date: Wed,  8 May 2024 12:22:55 +0200
Message-Id: <20240508102305.108949-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032339_712763_EEF1E8E7 
X-CRM114-Status: GOOD (  11.47  )
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

Print a newline for easier userspace handling.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 5b1dee8a66ef..be36206cb594 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -673,7 +673,7 @@ static ssize_t tls_key_show(struct device *dev,
 
 	if (!ctrl->tls_pskid)
 		return 0;
-	return sysfs_emit(buf, "%08x", ctrl->tls_pskid);
+	return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
-- 
2.35.3


