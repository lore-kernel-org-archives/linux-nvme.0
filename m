Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699ADC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 01:57:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB742082E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 01:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IYm4zS2Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a2EsPL+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB742082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jGWm9JrMA2Zub5gvbawp3EDK/xwt5xeYMOLgmKUI6ho=; b=IYm4zS2Zs65HEj
	HgGID0X8751m3eN20piIrkQBqL86EcZ6rHa9e5DuPEi80qEk87/+eeZ0qM3Rd5RwBpDrKCTUdI7oR
	wj1ifswj1BvP8P/XFXbHHG8J7sefhS8sCk48KvKWYqpcUuCzQh4Wk9hdNDmDg09IQVyMhBz7kAhtX
	N4xxFVaTcJg+c9gxE5dN5M60MALSOtKy1pCIhYeH5vR8OkHNocuNJZc3V/ORG7CpHuG1yAW+zOUzd
	cru/KdFR/X6sUeO1TSQUQGsu+B664QXFqM0vvxVU6k8r7i9WX7CGwg63XHSoicUrMjsNM5Sz1AoKK
	wZOF3nqFvECSy8bzleLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iz9wO-00005d-Cg; Wed, 05 Feb 2020 01:57:20 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz9w7-0008Gw-2o
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 01:57:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580867823; x=1612403823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tuvhtOcFDAu+VAvFwgHNpV4Z6sktQLNkBPVJdSJMpcI=;
 b=a2EsPL+MWtCXi72FIIL0NRHy3OjXarogJIaVv1G7BBLuoYVGfl66aImn
 sVd0r8vnW8KiZ0dKqKhwyP4GCNVwpTRvvg4/ip2N6IgZenjnMKvDl+he2
 ksqk+HEik3u1nTV8PB6kEdALTFaDkfwyP4M2zzhKQV2JHNT9rBu+Cal44
 grudmZW/IRHaZJUk8d+y2H8iCkEPnyWvkmApZwoIn8LcIqrCSC2kYq1ij
 5yZPOkuJCVC2AsO3ZmSYlMzGkoHXMtMSByFoYWuHS63Uxe9nUzh62JOYk
 UPv0CGlhZPEeToxLayDG5eOVOMtVYRVNVqkW9yYmNTvb/4LmBfnqZ5f7z A==;
IronPort-SDR: Ye7UYoGdBknzcZLuJTc5DcBu6UuLDw+7qLmAq3jWO720RMKe5wIuwtibJMBOX6HB7aeoUpALs0
 9wMlip/Sip9x3rbJFIn+vVFwobUAgxHtO0naT74XNr02wYekqW3pRSVREkfiklJ88ryw31t02P
 NobUR03T4HogdxGCiDUEXnxxJor5RmwQmjhXC9hgD1H96e8tOLRurVpTjvNBZ+GOntrxH0eHrt
 3I5yE68lafQZe/JiWqvtHF9mNypqTy/kyESTk4ldy8elL8vEzh5hnmk/tgvwyQE+9QPaAg8N/b
 o5Q=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; d="scan'208";a="130576286"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 09:57:03 +0800
IronPort-SDR: JohyNO/ed7LmMPh86hO5CnYR2Cla290VjKqryNmUwtSyRXLq1ywqzb0T9JNp0BmW8wfEtkZje0
 8Pkb8RV2RJBkcJBRwdHJ3TjAbWtJLQ8Vz0Dkiqc1KgHWuKe1WfFVFh79phRDCfZrUorUa4jU4l
 6xDi6AqHZfdFYFr0r1HU/q3EM9N5LCEqv1O/41zyZGgJr3pzsYqvL2BUwGzk+3A8vLE8HPqrH4
 5bnwGnH/0TzPII7sQGNImzJBsl9uZ9L9vDGYpK7nKeb6xI/ndLmL67xN9KFJMZsE7DJdcHTCMI
 qb1dnd8AIoA1bhr1wr2TOvEa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 17:50:04 -0800
IronPort-SDR: eNshM3n3gaz+wkRjZD84ko8fa5eW+uChFE3yhsbb2V/HEtf6JeudfKg8e98AJmU0fjRHrRemqE
 juPJmosyXz/W+IsnxmjLgtVcK1LHPqIrJgpJU73z7XioO0mp4LOXN0vOnK3ttoTX0nlzV5sw1G
 7auUgHrq8e6KTHbTSDQSOCIjRgVjLMLRLTW2MIbxCcW5etgHOm8o/0brmVZRmFlyzcB6JVMS61
 VCLZA2ZJenbyGt+H67j3G3/GkAE+KqvYDaIXWKrrbPnwndALkX20XC4fS7DvMwTMzmtyEIwogb
 kFg=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Feb 2020 17:57:01 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: add file-backed ns write-through support
Date: Tue,  4 Feb 2020 17:56:50 -0800
Message-Id: <20200205015653.21866-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
References: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_175703_172456_54550145 
X-CRM114-Status: GOOD (  16.43  )
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

Cc: hch@lst.de
Cc: sagi@grimberg.me
Cc: MRuijter@onestopsystems.com

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
