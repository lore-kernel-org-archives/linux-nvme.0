Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EBBC432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:26:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49C9600D0
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E49C9600D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+xb02zHE6tP9rPFKBMmUVjNmYKW/BeBlh3KEfuyvVRs=; b=cvhgSlLIafi7uX
	SeSJsQiyDJGtLHVn9uWINN4glugishOYGDiEuN9N66NPYEp1iL0p9NcgLWLPptxsfxjX9f7stJsx9
	Kc9nSrGzbWZN5U7xX5biiavAhj6BWBG4aZko8UhHBq8K4kC5ifYYWR+9YryDasiByUvZpLGn1ZaIt
	T2ub9QzFzRmpbbDMJNOEV/kqZQy19HIDTLBfw4C/cDuG8YSGs0/tvImqgFOCUsf7LgBp3Sdd32/6Y
	4Q+qxdbqpAuTmUhQOmgbfHhXg6qom3xS7we5aKgS1XDLBfxCuRQMHdEBEXg9SIOexKxh1N6bL9xbG
	zAIrjaaKM1XU4mGvyjRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKon7-000cr8-Kr; Mon, 30 Aug 2021 21:26:05 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mKomk-000ciH-RM; Mon, 30 Aug 2021 21:25:42 +0000
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
Subject: [PATCH v3 6/8] dm: add add_disk() error handling
Date: Mon, 30 Aug 2021 14:25:36 -0700
Message-Id: <20210830212538.148729-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830212538.148729-1-mcgrof@kernel.org>
References: <20210830212538.148729-1-mcgrof@kernel.org>
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

There are two calls to dm_setup_md_queue() which can fail then,
one on dm_early_create() and we can easily see that the error path
there calls dm_destroy in the error path. The other use case is on
the ioctl table_load case. If that fails userspace needs to call
the DM_DEV_REMOVE_CMD to cleanup the state - similar to any other
failure.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7981b7287628..4e6b9d6ac508 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2077,7 +2077,9 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	if (r)
 		return r;
 
-	add_disk(md->disk);
+	r = add_disk(md->disk);
+	if (r)
+		return r;
 
 	r = dm_sysfs_init(md);
 	if (r) {
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
