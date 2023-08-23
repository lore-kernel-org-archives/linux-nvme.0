Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC38EE49A0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Aug 2023 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MBsPveD1xI53cn0DT68/0aGElxKX0zddJPsr7N619Ak=; b=XEVrpM4XLuoznrW1SwZKEgnG5y
	rpmJXYFqSadDRKIbBhM4qH3SGOK0SUityEuijTO8fXg0fvskeDtpNqScoB6Eg82j7NUiAosD4FbXi
	BlTJqc2LBziraXDYxbPzGCPoI+GHZToLyIi1d2T/Xub+DKRJ5NgMVjd7YNJYEffhUB2jpBfiOq3w7
	b0QGvBTFjdZ5UPj2KO7/ZAvDzc63banZFQ2k5mkbSeHCWbQ2tDt94jhOqIZiZS1BTg68Dba/9R5ze
	6dw9jylijfSLozzEEOYhH5XB69pNkSDl0EGb+xouCp25P3BBZJqkBthIUg6uLYM/ckTBszzKxMaTa
	3HLFXYTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYlQB-000McI-1h;
	Wed, 23 Aug 2023 10:49:07 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYlQ6-000MUS-0P
	for linux-nvme@lists.infradead.org;
	Wed, 23 Aug 2023 10:49:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A27542074F;
	Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBsPveD1xI53cn0DT68/0aGElxKX0zddJPsr7N619Ak=;
	b=CDGV6etjiImeGEUO+0BUVbX7RrWvHoApelFxQwE+MvKkuapFoSM3992rna3Bq9ee4PSIw6
	+LXG9cXNVM1eYwTwr/bQdOFAS6mHFaO1dN/yAeP3C+dn99TY4Go53DK6Qw+n5oqjlDEuxc
	PqGpPheiFx2BLmX9XP87j/wbjP/DRao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1692787738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBsPveD1xI53cn0DT68/0aGElxKX0zddJPsr7N619Ak=;
	b=N6z3QTU6ieH93k9KF4kE1tM6zgWhTjKW3zovp7A1dMknTyjGy4QJojKcRNyAdb0/bhpQHV
	8PGnGalNM2lFCrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9240E13592;
	Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kmaxIxrk5WRMIAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5625FA078D; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	<linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/29] nvmet: Convert to bdev_open_by_path()
Date: Wed, 23 Aug 2023 12:48:24 +0200
Message-Id: <20230823104857.11437-13-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=jack@suse.cz; h=from:subject; bh=P3kIXEticntI8ldLR8W/RXMKkQjvvAD6UtqoFr/c9Kw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP5SvEBatGZsIjgJiA6c5YnzkSHf0MP6rkeUG43 o8ebsHqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj+QAKCRCcnaoHP2RA2TUwB/ 4wcLZc14Yrt0gDhGdTJgkH8N4G8qwWxdOI88u2Lhfw2i3xYxHB4dmlkDvPGtGjq3hru2kNmml/zFpD aPXPQZSkA2xl0l5ycYbfKZ2qzVnS9dHCTaAh9XilOwY2ZOE+nPcazmIxaALS0e5vH27HAdIdVGXgfX +Ub5T4XFFXhhZeUarI3y6eUEhQwi4B9QxU0SV7K79+qmqy7HICDwIK8sJkE6uYE9ESXiqe/GE4GYFw 9G11zl4Aiw6O8tf+86EMdVp4YqdlAvfOVfDX7gDHNIAa4FpwiNqdy3Iy2XrbiBysP54gJ0Id1iFCh3 6kIb4sVIV1B9A4YMizL+G7Z/Y87xCZ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230823_034902_325525_4E5DCF86 
X-CRM114-Status: GOOD (  17.08  )
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

Convert nvmet to use bdev_open_by_path() and pass the handle around.

CC: linux-nvme@lists.infradead.org
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/nvme/target/io-cmd-bdev.c | 20 +++++++++++---------
 drivers/nvme/target/nvmet.h       |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2733e0158585..0bf05c19d8b5 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -50,9 +50,10 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
-	if (ns->bdev) {
-		blkdev_put(ns->bdev, NULL);
+	if (ns->bdev_handle) {
+		bdev_release(ns->bdev_handle);
 		ns->bdev = NULL;
+		ns->bdev_handle = NULL;
 	}
 }
 
@@ -84,17 +85,18 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (ns->buffered_io)
 		return -ENOTBLK;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(ns->bdev)) {
-		ret = PTR_ERR(ns->bdev);
+	ns->bdev_handle = bdev_open_by_path(ns->device_path,
+				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	if (IS_ERR(ns->bdev_handle)) {
+		ret = PTR_ERR(ns->bdev_handle);
 		if (ret != -ENOTBLK) {
-			pr_err("failed to open block device %s: (%ld)\n",
-					ns->device_path, PTR_ERR(ns->bdev));
+			pr_err("failed to open block device %s: (%d)\n",
+					ns->device_path, ret);
 		}
-		ns->bdev = NULL;
+		ns->bdev_handle = NULL;
 		return ret;
 	}
+	ns->bdev = ns->bdev_handle->bdev;
 	ns->size = bdev_nr_bytes(ns->bdev);
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b564..360e385be33b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -58,6 +58,7 @@
 
 struct nvmet_ns {
 	struct percpu_ref	ref;
+	struct bdev_handle	*bdev_handle;
 	struct block_device	*bdev;
 	struct file		*file;
 	bool			readonly;
-- 
2.35.3


