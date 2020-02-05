Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F4EC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 02:13:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B6B214AF
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 02:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lfnRqbRj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FA+C6PmJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TIlMh+kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B6B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jGWm9JrMA2Zub5gvbawp3EDK/xwt5xeYMOLgmKUI6ho=; b=lfnRqbRjUYnOeH
	CqYgS8pSR3ACD/qTZATKwHVMcqXsFt6s0XXGiOEfVSY/8Tp4DIT5hle5KRzUt/YpW4v0A3q//mbz+
	NgkgyGAGawLtj+CAbz4TB0KJRW4P7+YgCrf6hIYEi9VaVcLs0pgtS0/IDVnVNVTehkmbNK45LLa1Q
	HCdCrzPpBAtA+ey37i5+jP758Bzdk5IPw1iGmrOnCQmvTRC7hw2w/ehMiZfUlt4ajNSYw5xx1ytQo
	Zx80TZo/sf0X1CQqQOR0cMbnZ89/q1vlvrHKqKblofeQpqyKBWZxlpCLh43Kb0oROagu4GIePVxRm
	uyclS3xvc2m7uOMMTzwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izACS-0006h3-81; Wed, 05 Feb 2020 02:13:56 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izACQ-0006Ym-Gu
 for linux-nvme@bombadil.infradead.org; Wed, 05 Feb 2020 02:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=e+ocK0gDwxrRSmXyRtLFdEmXMoovfOGi26oMC8GaBOE=; b=FA+C6PmJgAkml69i0I7i2D236v
 FqiCXYD5um//zAUSnk5W6IhT7n1/d6Al+UwOfPTX8eQC4VbjIzYSdiTQpMJI2TnmbaqfdK4EPGg2N
 0dJMlzx8jay2iVzqAZRPzDRloLXZcDrfIFuAblu4mAilOYOnXlI1HdE/rhpsY/etuYSl5S9gqa1Ev
 alEgL43BDD5CQvRp6XrfSayDyJjZIzz1LrJd7x/bC21FpXPgcl7c/9bVNEFgatoElGQY7xOuQyue6
 06EN5aK+HcJKLXooZj8k1m6XDait7DVr2zU3ifI1ZNStiJbl6Dc2JNZg0LkGYjzD2PU1m2TIKfPHy
 ChLCTSQw==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz9wv-0000QE-5H
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 01:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580867873; x=1612403873;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tuvhtOcFDAu+VAvFwgHNpV4Z6sktQLNkBPVJdSJMpcI=;
 b=TIlMh+kX4MGKfLbE0lRMgFCXtXcd7QRVIH9J5Ff/yophwpg6EfpgBoOH
 d0kUZBQ+OGxXkppMKrpGy+bmLHm6MCn0e8I0urZrACg0OadY6avVzYlLM
 KVUd009BVE5Gtss63U4N+wJBOTvwKAUn5DhIwUqbi3f0FyUvb6b+aCW+F
 i6PX8sst5dYxnKhoB1cBUtRazj7C/YVcjs1Nrpa4banJCI5MBthq2HUIO
 e53ZXoiI5BZKYHCo/2WWRKERX4UtDF3f3SZ6RwjLBoLURRalwa37r/zWz
 f7SeuFQGRSzTtA+oqeaRMx5CC0nwE9MuHstKSJq4uLuAWJPjB89WooMYt Q==;
IronPort-SDR: fnuBScNxrPYJCi8vVC3RvU73o6gOTvxygSO1q17HdWytvgAK1ywFS2sLIsnPzZiC3Vd0DzgAoI
 Ug0yFx3a7NM4dCY/DMwbpNHISzZodGr9oZjhhuBbnwf5OwPjT/Nm0JTusflRO/tDqEoZKWGiQn
 0GiXYDAJkHfEsT/T1y/CtrgH5Jd5USC59rd90YBstjAepVKQBh52pp8174AOlGoUPexTyhf1i/
 Ym/f50s2SfdDkb3/H+LPAP49LVBKAZ2Yu0XcgPpJsosqzSUUuUI2sjYep8ygQykoJKhUW7nMSA
 CmM=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; d="scan'208";a="130576317"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 09:57:48 +0800
IronPort-SDR: lP+wEUfibNzPo+2pTMyvR9VOnGqvoN5o7Z1/sx21v7ADTYBrUMxyySJQPbeoSbSKrfn8+vK49t
 GY+1OszQ5fBbcV5RFnFZt9R4y/RXiXxIEqiY4UFBai8foT37oOxaLm+RAC+mwZ0Q/H1xk//Bbw
 fs09It7WNH4uXi7TNxZtzAlrqBdFw+vvHMsRkm1KvDYlHiYzhVCElRo0Xv9RJfPXEx8r9MRI4v
 4rqvOSftlKyOeTMpkqpt4QQnxYvExJkvabqt7oj39kLoL6yNW3Ves8UMrtZsuwR8qjX/GoHoA5
 UNoacRSRjJfjaoWDOkl8+scK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 17:50:50 -0800
IronPort-SDR: 48X0lX4zrj3TYkbyL9Q31Yh3+VESp3iAdOSuHWFsR0ISXccoMB+NAlArbIHpqNRr180kRK6xKI
 XvjQohXpleLKzlf6b5f/Cr4kyxhuxTIzVFTMNZ5NpnyIUK77KooWH+hFYRPcNAZu99+GOFwNoE
 xGASt7T4V8Du0nT9oV+MnlFyERBrCqCCTyTHvFgMfLwv7bqp0e/63uedAsuQIQoe6Uzn06K+4l
 QycgnpYEHApfzDlZ3edH5k1Y/0IBECPvISqfZmAJBSNtPP64NEGtujJoIpzdSHve3ceeWDWb8d
 HMc=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Feb 2020 17:57:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: add file-backed ns write-through support
Date: Tue,  4 Feb 2020 17:56:53 -0800
Message-Id: <20200205015653.21866-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
References: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
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
