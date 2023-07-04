Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FCDC001DD
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jul 2023 12:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2k+j+NE7t+sLhdMxVC5FbUtMZY9ghkeloF+1sdNBw5U=; b=d45jxxIixsLHDY0wlR5YRTpp1x
	YgKkTQfCdKo89Z7epwQf484W7Gd5m6OEdQfpYSH+QRlj/zJ1Z1EcjTTEU7UToINeaQCN4s31YDMAF
	Gd6SfxvgHN1zFZWvOEWixqxPqeCqfJKd/UtLTeeDU5QBcppWRxt0WOiMdJpqZ/11OGkEMB9EWguQe
	/cElv4RLr9yoFi8GpxxGJecYuTpa6j75o2sm2bRxZ08Dt7wldgrrnoiJokxCTHXfVbv632FIsjLLq
	G4tUREeNNJ/GlOe4z8zYNzeTZbOJl4F45tTvp53TNbx+hm0jdlDidLLIrCk4dx8IsaWw+FIYsaUbm
	MMgR1h5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGf3F-00DFL2-0A;
	Tue, 04 Jul 2023 12:22:37 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGf39-00DFCi-0g
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jul 2023 12:22:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB17E20565;
	Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2k+j+NE7t+sLhdMxVC5FbUtMZY9ghkeloF+1sdNBw5U=;
	b=bJTDv9Oe6VTEkA9Nhd3EAypNI+c9gp/+E4ZEHfcaqq+ASBHa/KS/VLHE5SLtemqufQqbli
	h7FxUWrIk6Y546WHYmWnF5nEQodmH5lyGHf1mz46U/Qrqov7nnXTcXrH3kjyF0pJfYb0Z2
	E4MUTfbtTpQeSlFq6ezcIve4RiOb2Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688473345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2k+j+NE7t+sLhdMxVC5FbUtMZY9ghkeloF+1sdNBw5U=;
	b=jwiqwhK0A/AO7ckOIsmCljZpUg1l+B8uOPzP72ThC49vlUv7wzsvJA80LRIvfEPC5tKOpC
	38hZ7g60My3rFvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC709139ED;
	Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CBXPNQEPpGQuMAAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E17D3A0771; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 14/32] nvmet: Convert to blkdev_get_handle_by_path()
Date: Tue,  4 Jul 2023 14:21:41 +0200
Message-Id: <20230704122224.16257-14-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=jack@suse.cz; h=from:subject; bh=SMA9+AJK4skV38lQheF5vU7uxGpgwS7tw1AAPHPgwXA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7WUlCLN1lE1WDAZ8su7Zxa6wNR0751J0IzdLis KCB8UpWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO1gAKCRCcnaoHP2RA2fD7B/ 0ZzomC6r5IMCN5PEDZh85MjDl2Hk141xaglkf/++C3+/kBWW/YIEGYx3CkLjCto5WH0QXGZSzdXBUE CCkhNSMSb2efJJpzrNBqhnDPF9nJ33V+M1T7vJQoOZWoam7wI6r1LmusjtBr4X1+dJiW4TuO8L0Ydu pVvLx2Wr7OvyVOt4fDPvK3+ZT+lt/etsHVH2RRzEo7K6bu5azEBZnn5qjo7gxed00OyK5wh9v8kYjd 4gmSTjc6azKCcoboXDlCE6ksKQU6yGr0gRboYxGyD6Yane5I74B02+XUu+9E1b3HyFA3LnMhFwNRD5 +c7lKSDHE2veqnT22pzHefvMBZueK6
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_052231_425981_7F8A57FE 
X-CRM114-Status: GOOD (  18.23  )
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

Convert nvmet to use blkdev_get_handle_by_path() and pass the handle
around.

CC: linux-nvme@lists.infradead.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/nvme/target/io-cmd-bdev.c | 20 +++++++++++---------
 drivers/nvme/target/nvmet.h       |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2733e0158585..0f177a7e3b37 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -50,9 +50,10 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
-	if (ns->bdev) {
-		blkdev_put(ns->bdev, NULL);
+	if (ns->bdev_handle) {
+		blkdev_handle_put(ns->bdev_handle);
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
+	ns->bdev_handle = blkdev_get_handle_by_path(ns->device_path,
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
index 6cf723bc664e..eac3f2c814b8 100644
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


