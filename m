Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A937AC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 18:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VwU//eJ9yadzq/fsfDhiEtvVbtfHI98m1htYpt9Ipdk=; b=JjHCcgxTYT0U3K+R0JpZWvtDEB
	jGwhqC1AXgxZg275FTmRP9lPD1DWZHj77WOLKp2tPT+L9kDl4m8evHqaLeWbxeXzvQq+f3j6cL/Yk
	OK+iU2hzDHGJltMtc0KLorlVAEuJ0NVymLk0wAsUK7SGh9VaXGPpy5U7QEXTHF/84Zh/bRryBGAQa
	+TsJYnz+aE172Dq27Qf95OWMuKy8/T0AEDrWvOIEsfH6yD/U0OifQzmwYcqJvrevubmq3jjhzBK3q
	0FWAXGUICX1Ow4/vdBkGrob6+0dQQFN6i2s9ps7WAdnTs33msxSmcYwyrHKcZGC4HdVzpT1H48BUP
	HWd83M4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmtq-0000000BVek-3rKI;
	Wed, 07 Feb 2024 18:43:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmtn-0000000BVbJ-2A4W
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 18:43:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwU//eJ9yadzq/fsfDhiEtvVbtfHI98m1htYpt9Ipdk=;
	b=HYNMBFi7Tnz3bHNyIAROETFlIecBhyR9q7AF4y7E1FEQlxu3VlLQvY5JP3eeygZeYr3pCn
	wKzAOSKnjQpQesdQK3BG2uO13nwaOLE9w1QE7NHRnLv0oYyUKw786ybLtYuUHrI/A1CyR9
	Lz5hEk/7eOMsnnsvneTkCbeUYGIUrBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-m-6gGQ7ROWmYlHUy-tFPLQ-1; Wed, 07 Feb 2024 13:42:28 -0500
X-MC-Unique: m-6gGQ7ROWmYlHUy-tFPLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28C2C84AF81;
	Wed,  7 Feb 2024 18:42:28 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC90B4011FF1;
	Wed,  7 Feb 2024 18:42:27 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 6/6] sd: async cache flush on shutdown
Date: Wed,  7 Feb 2024 13:41:00 -0500
Message-ID: <20240207184100.18066-7-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-1-djeffery@redhat.com>
References: <20240207184100.18066-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_104355_778372_8CFC2AB0 
X-CRM114-Status: GOOD (  19.00  )
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

Add async shutdown for the cache flush to the sd device by sending a
SYNCHRONIZE_CACHE command asynchronously. If there is any sort of error,
falls back to the synchronous sd_sync_cache() to try again and resolve
any errors.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/scsi/sd.c | 66 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/scsi/sd.h |  2 ++
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0833b3e6aa6e..f972310df76a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3838,23 +3838,64 @@ static int sd_start_stop_device(struct scsi_disk *sdkp, int start)
 	return 0;
 }
 
-/*
- * Send a SYNCHRONIZE CACHE instruction down to the device through
- * the normal SCSI command structure.  Wait for the command to
- * complete.
- */
-static void sd_shutdown(struct device *dev)
+static void sd_sync_cache_callback(struct scsi_cmnd *scmd,
+				   struct scsi_exec_args *args) {
+	struct scsi_disk *sdkp;
+
+	sdkp = container_of(args, struct scsi_disk, shutdown_params);
+	complete(&sdkp->shutdown_done);
+}
+
+static void sd_async_shutdown_start(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	const int timeout = sdkp->device->request_queue->rq_timeout
+			    * SD_FLUSH_TIMEOUT_MULTIPLIER;
+	int ret;
 
 	if (!sdkp)
 		return;         /* this can happen */
 
+	init_completion(&sdkp->shutdown_done);
+	sdkp->shutdown_params.callback = sd_sync_cache_callback;
+
 	if (pm_runtime_suspended(dev))
 		return;
 
 	if (sdkp->WCE && sdkp->media_present) {
+		unsigned char cmd[16] = { 0 };
+
 		sd_printk(KERN_NOTICE, sdkp, "Synchronizing SCSI cache\n");
+		if (sdkp->device->use_16_for_sync)
+			cmd[0] = SYNCHRONIZE_CACHE_16;
+		else
+			cmd[0] = SYNCHRONIZE_CACHE;
+
+		ret = scsi_execute_cmd_nowait(sdkp->device, cmd, REQ_OP_DRV_IN,
+					      timeout, sdkp->max_retries,
+					      &sdkp->shutdown_params);
+		if (!ret)
+			return;
+		sdkp->shutdown_params.result = ret;
+	}
+	/* no async I/O to do, go ahead and mark it complete */
+	complete(&sdkp->shutdown_done);
+}
+
+static void sd_async_shutdown_end(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+
+	if (!sdkp)
+		return;
+
+	if (pm_runtime_suspended(dev))
+		return;
+
+	wait_for_completion(&sdkp->shutdown_done);
+
+	if (sdkp->WCE && sdkp->media_present && sdkp->shutdown_params.result) {
+		/* for any error with the async flush, retry as sync */
 		sd_sync_cache(sdkp);
 	}
 
@@ -3867,6 +3908,17 @@ static void sd_shutdown(struct device *dev)
 	}
 }
 
+/*
+ * Send a SYNCHRONIZE CACHE instruction down to the device through
+ * the normal SCSI command structure.  Wait for the command to
+ * complete.
+ */
+static void sd_shutdown(struct device *dev)
+{
+	sd_async_shutdown_start(dev);
+	sd_async_shutdown_end(dev);
+}
+
 static inline bool sd_do_start_stop(struct scsi_device *sdev, bool runtime)
 {
 	return (sdev->manage_system_start_stop && !runtime) ||
@@ -4003,6 +4055,8 @@ static struct scsi_driver sd_template = {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.remove		= sd_remove,
 		.shutdown	= sd_shutdown,
+		.async_shutdown_start = sd_async_shutdown_start,
+		.async_shutdown_end   = sd_async_shutdown_end,
 		.pm		= &sd_pm_ops,
 	},
 	.rescan			= sd_rescan,
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 409dda5350d1..7b5098211cec 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -91,6 +91,8 @@ struct scsi_disk {
 	struct device	disk_dev;
 	struct gendisk	*disk;
 	struct opal_dev *opal_dev;
+	struct scsi_exec_args shutdown_params;
+	struct completion shutdown_done;
 #ifdef CONFIG_BLK_DEV_ZONED
 	/* Updated during revalidation before the gendisk capacity is known. */
 	struct zoned_disk_info	early_zone_info;
-- 
2.43.0


