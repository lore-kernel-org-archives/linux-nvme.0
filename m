Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E3CC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 02:01:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615BF2082E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 02:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I3UGyh2C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G7OZn+kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615BF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YRZFErFZS2Sug2neH8lmkKWxwfbhMFvjuiTtfBQNJpQ=; b=I3UGyh2Cgeucb6
	R3/zxR1rPZNlIBQy+ZCtGxFZgMacQRbPi/vTaAajkiY6nhxFmuMGayJ2v9gnMaEPB+qq0Nem7Ck7p
	xAAEB638itdLczgTDE5D3vETw3BzCuJRd0+kbr4JS6zAD8Pvy3qd+w+xJ8fbWXuz5QzVovwLFE+WT
	z/+e9hHM74YmZXnjAee6QRJCJh89t/MJyTl4oMbrVcOKRNMhVjHNTBea3ks0rzOTKiwOdHK9gDR+f
	eTD4CofTl9EGkckJOb9BbCIhs5dVePbmDMt/n1yka4EE94y/7LIFDftM/vHmZT1mrlZ8kNrpxDGr8
	KocaqXku1lPR2/CEyVkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izA0o-00033Q-IU; Wed, 05 Feb 2020 02:01:54 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izA0V-0002g1-7m
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 02:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580868094; x=1612404094;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bFXlxMm0Ok9gq8AiS/3bjtGISPAfsZIylGHLVgnCXi4=;
 b=G7OZn+kdEjhCW4hvugdm10pX5DHat3iOo/u6McR4T4WJBJ9bZX2dUrAo
 jW+WbVogkCbcmD46RrURMZfjKdfxzz1eGaStNQ43wxXzNjgQMR+9O7To7
 hnxM0xbJJapHWRm08pvKlpTC1YOvEYsF08gqrE+0T/Bx+NpMBs8fHl6T2
 WgdU7SiPKaBMtp9blo+ittjGXLCa6yQjoKa7xyZv2tqaCR6oEGXtJSE++
 3gQB2qXwHoZeVnmggHcmZA23UwbUFcJrz59Iln/D+0tUYr2GQW5W9XczI
 4ikNDvWYLJSWunSS91rGauqvKuyhnIpTExQ2jJp22X0MAE6wIfCGWrqq1 A==;
IronPort-SDR: TvYlBnjhRtpl7RIkrpr6SXOJ5KTTiueiUGW52dQMuouV9bp5SRsSfPJpQO6MW/jE6zkzqzZmTk
 1jGUzA7FmrIQHV3BiV2dSmY9chMqn17ZIRvmaXzQ3XoF3/YbpRBhdx11SzBjq8qYBVmrfC1mnU
 0RVzd3TfVyzdEmUwowySjhPnqWM5Tux66q9lfg2A7Zi9dp9Bof9nBy3uH7/4MsgXwNFcqe0aP9
 8rHCXaccX3YNqtEosH6IIxDnzwuD4k4r36TT9Kcb7JlTzamnGfGkQSXn0a16jEHmNWtOdSGP2F
 pug=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; d="scan'208";a="129112446"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 10:01:34 +0800
IronPort-SDR: bD85IqImQE4nxexMF4HVT1AiX0rPPuol1KtsSziaRQJAPKiN32ZcE6sgxamcTvz1Ey/8Yvyqcz
 nSc9wugMBXUly+DrrTFMvTazHTSz/+GyfESqOUx4JP/rWlwsJuBGB9WvS5QK+aYXVs7zH36bTb
 Q6gCKOixIiPbf5QEozt8NGyah2zT95ohNv5naoyyX3jxuDFnY4e+KTNAqTOYLZgEno2U9+G5La
 kavS+AOhUfudQ6c2ZJH+qq6QaA4QEFv/GBwTueoaBrnXNiP1Ij3srj+nVvF6vedTqzWUWC3C1z
 ZHthRZ4U1eZMDeCD8JU2cgzQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 17:54:36 -0800
IronPort-SDR: OkUULsvuY7ehfOkS+MXa8nh46EaqtYOr4+AZB7pXgVYPkgWkUpG9w0N0nc0NWjaP8fg7E9byBA
 y6/0tXIuf4r6KPqdZTrqw4wCCYwWuC//qiYZ/pQosVk1GwmE60ZSoli/5m5tBaAg2LnIb/s4cX
 f+wf4s4OA5at8reRrOLzjod5XqWizqS/Z/73bTpC2bbrAwnXCE7NE6M8DFW3OY8TlscI9tT1nG
 4engWv00cyVyo5pr6MTxjMNZ7mIsiB1lAIpIJIoHmM/6J30nnNxyRcqqmpcbXswQiugYSaBgeW
 Wik=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Feb 2020 18:01:34 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: add file-backed ns write-through support
Date: Tue,  4 Feb 2020 18:01:20 -0800
Message-Id: <20200205020120.22210-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200205020120.22210-1-chaitanya.kulkarni@wdc.com>
References: <20200205020120.22210-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_180135_371205_21B0EC13 
X-CRM114-Status: GOOD (  15.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: MRuijter@onestopsystems.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a new configfs parameter "write_through" which allows
user to optionally write through I/O. This approach increases
performance for I/O workloads like 70% read and 30% write where
applications are mostly dealing with write once and read many times
scenario e.g. social media posts, pictures. This also avoids cost of
round trip required for read operation when buffered-io is enabled to
populate the cache when the dataset is large and distributed among
namespaces residing on different controllers with different targets.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c    | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 16 ++++++++++++----
 drivers/nvme/target/nvmet.h       |  9 +++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 500cacfc715c..70477343f194 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -584,6 +584,35 @@ static ssize_t nvmet_ns_backend_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, backend);
 
+static ssize_t nvmet_ns_write_through_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->write_through);
+}
+
+static ssize_t nvmet_ns_write_through_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting write_through value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EBUSY;
+	}
+
+	ns->write_through = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, write_through);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -592,6 +621,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_backend,
+	&nvmet_ns_attr_write_through,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 8a642cda123d..4ac306419177 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -35,8 +35,10 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	struct kstat stat;
 	int ret;
 
-	if (!ns->buffered_io)
+	if (nvmet_file_ns_is_direct_io(ns))
 		flags |= O_DIRECT;
+	else if (!ns->buffered_io && ns->write_through)
+		flags |= O_DSYNC;
 
 	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
@@ -198,7 +200,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	 * A NULL ki_complete ask for synchronous execution, which we want
 	 * for the IOCB_NOWAIT case.
 	 */
-	if (!(ki_flags & IOCB_NOWAIT))
+	if (!((ki_flags & IOCB_NOWAIT) || (ki_flags & IOCB_SYNC)))
 		req->f.iocb.ki_complete = nvmet_file_io_done;
 
 	ret = nvmet_file_submit_bvec(req, pos, bv_cnt, total_len, ki_flags);
@@ -229,8 +231,12 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 static void nvmet_file_buffered_io_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	int write_sync = 0;
 
-	nvmet_file_execute_io(req, 0);
+	if (req->cmd->common.opcode == nvme_cmd_write && req->ns->write_through)
+		write_sync = IOCB_SYNC;
+
+	nvmet_file_execute_io(req, write_sync);
 }
 
 static void nvmet_file_submit_buffered_io(struct nvmet_req *req)
@@ -264,8 +270,10 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 	} else
 		req->f.mpool_alloc = false;
 
-	if (req->ns->buffered_io) {
+	if (req->ns->buffered_io || req->ns->write_through) {
 		if (likely(!req->f.mpool_alloc) &&
+				req->ns->buffered_io &&
+				!req->ns->write_through &&
 				nvmet_file_execute_io(req, IOCB_NOWAIT))
 			return;
 		nvmet_file_submit_buffered_io(req);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d78d9990e513..815096728dc6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -69,6 +69,7 @@ struct nvmet_ns {
 	u32			anagrpid;
 
 	bool			buffered_io;
+	bool                    write_through;
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
@@ -516,6 +517,14 @@ static inline u32 nvmet_dsm_len(struct nvmet_req *req)
 		sizeof(struct nvme_dsm_range);
 }
 
+static inline bool nvmet_file_ns_is_direct_io(struct nvmet_ns *ns)
+{
+	if (!(ns->buffered_io || ns->write_through))
+		return true;
+
+	return false;
+}
+
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 
 /* Convert a 32-bit number to a 16-bit 0's based number */
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
