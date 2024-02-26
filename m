Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428A8C54E49
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kH+zNWdjUG+286Bn4ddvXn/PY88oZ1Tanq920a4wdqM=; b=uvX7l04pgHX/7nJRPWbqCMoMW1
	cjp17q5kD3dVxhzhI9jutXNu8gCuHvlzTV54OSJdRGcDDxYzmiG4LIxencxZD+yPNLeId4bYPdhwG
	9Q7kts8QDRI+8kcZ9ZTS8oooEPEd+FSftt7++HnUD5sQ6RrL4xoXrPTGRghvT5lDOXwvMSIW7EJo2
	PATariunBnVq26EjhsNY2qhELadRKDI8BnCiI8doT8LpM1RlPlaQZAT+U7HfLETTvYyy/a1j8660n
	+iKveHgSJGLexL0FUOioKg9aU2ampYcZdYb+wLTpLvmaf+TUgWafzKZutFlcoocyEjqV0eYgxiRNI
	ylq9QXxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rea2b-00000000YaH-2YG5;
	Mon, 26 Feb 2024 12:25:05 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rea2T-00000000YVp-1lt8
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 12:25:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 71EC6CE1307;
	Mon, 26 Feb 2024 12:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73950C433C7;
	Mon, 26 Feb 2024 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708950294;
	bh=7E81wuVKo12T2HBaAgSo78NAlergcTd6Pv3TS9iI55w=;
	h=From:To:Cc:Subject:Date:From;
	b=Psu7UfOU4klOuXETtZ5yGzMnllly1pSg+8LVB4LMuvgxIVk+pSc+61RSgqus6eoAR
	 KBKFtD2U3GMiQ3VkuObD1xqFZ8zW1zFCoAZ/wk8evvRqvX674JNTnCjwWj6UG7S9KM
	 SFbX40PImvYFFCwkQ0eXlrzXiUwCP4UVwLWPrfWAFtPAdnbXshZWBnQ8ozMEYrIZiL
	 pztj17FdJoAATAcnrtBB0NII+TK1T9XZBVD/6G1XuIrZJbnGdOpiWhlxmNfGOgiRU8
	 vArxdCCJ6h3YSFEwjF6HqCDhRTQ3g55O95J/hWkiUkil7d3UC1CX+laLmHrEEQtbSz
	 1GMxWG+s+BNyw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: add 'static' suffix for user-specified TLS keys
Date: Mon, 26 Feb 2024 13:24:49 +0100
Message-Id: <20240226122449.46976-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_042457_674376_9909CD2E 
X-CRM114-Status: GOOD (  11.72  )
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

From: Hannes Reinecke <hare@suse.de>

If the user specifies a specific TLS key via the '--tls_key'
option to nvme-cli we should be adding a ';static' suffix
to the 'tls_key' sysfs attribute to signal that this is a
user-specific key, and not one auto-selected during TLS
protocol negotiation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index d099218e494a..79f25029c2fb 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -674,10 +674,14 @@ static ssize_t tls_key_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	char *suffix = "";
 
 	if (!ctrl->tls_key)
 		return 0;
-	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
+	if (ctrl->opts->tls_key)
+		suffix = ";static";
+	return sysfs_emit(buf, "%08x%s",
+			  key_serial(ctrl->tls_key), suffix);
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
-- 
2.35.3


