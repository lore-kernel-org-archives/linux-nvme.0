Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6993EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ROQ6vCMmRelNRq2vl5hRuopOHbMey2rq+lXrLToo33A=; b=sg0s+jMiVXRnsZXvITEPUfh5B2
	hRiCxcdypJhY75vLtUlCCLg9MKocvG6ttoBD6+PCY+71lFfxQssvASAkqkf1qrn0OMoSnE4RJ7TSY
	wW8FBkkkkzy5AE6AjPIzm06RKCJEB2c/abHjL+5Gb3/EQFVZpCKsO5jLZe+TembCEoyCKnEI9YPRS
	tZD5hV7ElwwRbNi/dg/04zW1dfpBmfAqblHidvfMdsnJjjLywbtGtzT+0BZehYiwdyIN1KKg6K1BG
	K6qVUUq0aUp2gF1zoxD9z5SDHj6cE0ci8Y2d9ptGV9P0CERN9FYDpiIMt/gqqTRmGCwMIKy8NWies
	SR+jfixQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nybZ6-008M0j-CY; Tue, 07 Jun 2022 15:56:20 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nybZ2-008LzH-Uj
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 15:56:18 +0000
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
	s=mail; t=1654617363;
	bh=UwJaoAVoa61DCnp3vhNmUCc8wPxbMXJadrTLt8SmqCQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qrntoUTld+NGDiE5Bqw7eLxramszHrt0peuvaCimeBz3YqtUbTTA+OPnBTPFsxOvW
	 xAFMmjL6upk/fe1S282aPfDeyezCHZgCk1j1MJ9Hq0MJXUFW4B1SmzedqWbC63lU7h
	 Xr+KWNhLEUQwNO3rOAW+51Vl1yMAXWDGytoXvPo8=
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] nvme: add device name to warning in uuid_show()
Date: Tue,  7 Jun 2022 17:55:55 +0200
Message-Id: <20220607155555.8623-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1654617355; l=1083; s=20211113; h=from:subject; bh=UwJaoAVoa61DCnp3vhNmUCc8wPxbMXJadrTLt8SmqCQ=; b=bg7FhTgM0Iz/uy954ZRKT/GOeWkKox3seP2mKi3+lLyDYj2x7go1RWrifrHKufOY7qmjOXAYWuMl qbOACxxkCX5BXmHEPExMMa7l1rkPmecuQiP15JaPCGZWCZx0R+M/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_085617_184074_24AFB92B 
X-CRM114-Status: UNSURE (   9.55  )
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

This provides more context to users.

Old message:

[   00.000000] No UUID available providing old NGUID

New message:

[   00.000000] block nvme0n1: No UUID available providing old NGUID

Fixes: d934f9848a77 ("nvme: provide UUID value to userspace")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..189bbd6c0c29 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3285,8 +3285,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	 * we have no UUID set
 	 */
 	if (uuid_is_null(&ids->uuid)) {
-		printk_ratelimited(KERN_WARNING
-				   "No UUID available providing old NGUID\n");
+		dev_warn_ratelimited(dev, "No UUID available providing old NGUID\n");
 		return sysfs_emit(buf, "%pU\n", ids->nguid);
 	}
 	return sysfs_emit(buf, "%pU\n", &ids->uuid);

base-commit: e71e60cd74df9386c3f684c54888f2367050b831
-- 
2.36.1


