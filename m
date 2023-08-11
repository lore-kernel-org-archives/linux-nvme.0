Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D697C04FDF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+VvG+qanYVVtcIzr1nzOMpltdtzys8SDvpDOLMGyxXQ=; b=uxNPkuR2VHd84TWjlqF5FyRS4O
	HrAEzBo3A3a+bU1Gr0PlptNmQGSZzF/n+zP6EOjfSbp9oLa44lSHFAUihqkNU1maqUyjT2YsgbxOD
	5qoe6LDblai+/AzAjS9Wn7VorMqipl6KlMXryLFIzfSUpmN5HOvJGHmbLGk2woeXkxk7k8pEv1QwY
	KoJ0LdoVXqM/6r+ACSmYSkX+oavjGtzrovYhMbvNQWkkThjUhee3O/NvSG48w8rly/onP31EmQXw2
	p4jOsytgp0MClzXMZ30/cMjJDfH4rfnuAq0qb/BWROR0KK9Obtpoz11/zgRjO/HwQNjj6Sbs6mcvv
	Fw0m3jWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR3s-00AYgT-1p;
	Fri, 11 Aug 2023 12:16:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPx7-00ANFp-1V
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 11:05:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E37E51F896;
	Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1691751905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VvG+qanYVVtcIzr1nzOMpltdtzys8SDvpDOLMGyxXQ=;
	b=WCk7VvfxgVgbtBC5hvdq7s4tr7vq+1LIcLuhFbtbOIuHWTAGfnLyN/edoHR/KE8MidPHoD
	fbetoNlEvH08xSIqojCekPsPcF66139DoEwFW+BB1uqtLEOb+mJZNvIFx9yZprQiQ6MIcv
	WDiyzlnvTj/v/yNGeSdCufqEB42XuCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1691751905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VvG+qanYVVtcIzr1nzOMpltdtzys8SDvpDOLMGyxXQ=;
	b=wwiHgMNl6kaEcRc8ZXkF818Bk2nlWlaawr35deBuRknkb+pZ9I1Twvz9I80srYTyfny3n7
	OcjZUT3aH9HLkcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5E5113592;
	Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ehItNOEV1mRTRQAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E6E0A078C; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 13/29] nvmet: Convert to bdev_open_by_path()
Date: Fri, 11 Aug 2023 13:04:44 +0200
Message-Id: <20230811110504.27514-13-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=jack@suse.cz; h=from:subject; bh=FAuKndxt7wCQ/EOUvXjS4qpj9RdHieyhESE54xG3zVI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXOgK7AqYwzOQFWZD0qRRsuDjzkADkBgAP3+VaB B3qfROiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYVzgAKCRCcnaoHP2RA2UuTB/ wNninM0hrQc6qC2V3w/QG7II38duTpbl1+HPXy4sJyFK4JT93bRZ4alsQHlVoaFsECH7fPbEpJn9/g tPWc7h0gGZJ+urNfqfbqJLtzydQHDu3Hr8IDPw0DQt7mnxjHinNPg7XhsNwpUncAUU+6mzT0yICXN8 HUoCZem/9UBZi5b0g9t0ymx1fWQ2L6xPscG1XA37X3otZEhhGKhTDACiHQng70/fQOTQ7fDohgjbBb oZp2Uptgqfvkkzi+EeN5fb8pSfhInQNytwIg4jy0bIhqfOtW8bgzS1GoR7KbpLvf5Bh8eXwiO94N44 aeerRQZk6+ZCYWmA4yAwkO4YcqnkVW
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_040509_665731_72BF91C0 
X-CRM114-Status: GOOD (  16.08  )
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


