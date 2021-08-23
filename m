Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9435DC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 20:31:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56ED061401
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 20:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56ED061401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dBq4dFRtzUei6wLBUZOr+yWilK54v5FvKK6E3wHCfgs=; b=EQfsE99dMz/BvR
	zJGVnrepcGZx54s+pLiHbq9keMZp3aBN4S+tetHxON7jABf2hskRnl3bM5VjXgueZ/LvWIotAYiuz
	FOYJq65zSgtnGUJyG/6GaSDpo4az2/5zRXkW+KphLY+lJdrk8D5TXGdVn1vNlh7M++2ehqwuHC5X4
	sWRjQipDPHwywKnMuV7inpYsQ4CSVpRCFJrxW8Srr1HsGiVjKO/eDM3ozpKzmMQfFDpRQzgVdzWcV
	8JKdN3IoZZ6hHMIj/kBcoDRZNFGNpKT3dm6d1pRDyK6eUihuZ1WA1sbwJEKYpN/m1fPuy9B0/ENmy
	lIPsGkPE47RypP+h5Fqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIGbd-000aje-IG; Mon, 23 Aug 2021 20:31:41 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mIGZa-000ZjY-Cl; Mon, 23 Aug 2021 20:29:34 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com
Cc: hch@infradead.org, hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 08/10] dm: add add_disk() error handling
Date: Mon, 23 Aug 2021 13:29:28 -0700
Message-Id: <20210823202930.137278-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210823202930.137278-1-mcgrof@kernel.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/dm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7981b7287628..cd26fde4ab56 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2077,15 +2077,21 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	if (r)
 		return r;
 
-	add_disk(md->disk);
+	r = add_disk(md->disk);
+	if (r)
+		goto out_cleanup_disk;
 
 	r = dm_sysfs_init(md);
-	if (r) {
-		del_gendisk(md->disk);
-		return r;
-	}
+	if (r)
+		goto out_del_gendisk;
 	md->type = type;
 	return 0;
+
+out_cleanup_disk:
+	blk_cleanup_disk(md->disk);
+out_del_gendisk:
+	del_gendisk(md->disk);
+	return r;
 }
 
 struct mapped_device *dm_get_md(dev_t dev)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
