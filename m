Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C27C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:32:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650542065E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LVXohJLx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iOXXImjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650542065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CJPZ+izv+qfwDw5UDjCh+ORjFEO/MEtodqga23jFZUU=; b=LVXohJLxhn7psS91TRb5h5e1e
	FBKC1N2CGKruaGakVGVe9ZQEdRhHkFh1MRtCsbg7WULr5FN2PunFdkl3HZwp4RhFMN74notpjmnSa
	4a1XlFXXl5oaC/6wruGfQX4n6qIexQe3UUlNkSv2xAYDPOPX193Fgy+wnRQ3tQPVCP0/gPoQ4pxsK
	p+8ITGWvjEFTWB0PJiz80EXFgA78gq/jHESW18Wbvc0HqeLKwE6Z91b7UWl1jK5z/LA4pU3YLojLP
	ZgpfZHcG3ZM8Q/Fg/tkixnFAiZUmXy8nrRyRQphsQ0gvk3X446Tq0jIhB9bH27JCvZRd4EItEYIgb
	12SvUzOjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUPb-0005ie-Jg; Tue, 14 Jul 2020 23:32:35 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUPW-0005gE-Nj
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769550; x=1626305550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=prwTPnwdhT6rbTG0FCmfHiXuXe+4oi71u4CHwiScSLE=;
 b=iOXXImjClKKAF/2lE83J6pbOi8PNH+3AtnwRfGNhJB4iTHvaFZS76rNZ
 cF1ma8RkIZsw2Rrnd4K8OKl31Hl+VVKWMd00Gu7U58K16ZhAgk/jKd4pu
 /MwbnIuA+ejYT3YTJsbAPzR10eccfmoyWNZ0P8Ocr8P+OBfIzY9J7qOwK
 jM8PyOw0et/bUDANit7Lp+dU46WgEBr4/UpxGk1fVO7JtrYEg8s7O2Kf3
 /n2z5KgCReLWsCvI9c1o42IdPnNf9w7ZbQOl592WVE4I0E8B4nN4vFBrh
 KBsuir6h8gPOOyptmoTflLrBqTuSJPvteCV2phErRE47fGzxekkVy2aKB A==;
IronPort-SDR: uiTGvlrJtF8u65MYcLjPrf753D7hf2ISUHLDs9JKeb7lV0O4cKnMklkF5MaRea4oVSW3EVmdnW
 HMnZimIlYOCrs0BiTXc6oRNJHCsMroavEmIOd/iFPYMyCsSwcUHsHQWSDGGyy2Cw4PC+DqdHmj
 FFk04mmv29K66+4XKhKDCqggk1kZLuPsb8ZiX3faVMBe3rND86jFtIIH4c+f7tY4wK1G1jYLWF
 QGNensuhw4YX66rQGE/9WIBNb7IWgZoPoCUlCK3D5GvvwyfHB3mNE454/FLSBSSVtyu9P9dWAM
 gzs=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="251729714"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:32:29 +0800
IronPort-SDR: xiTfCZx6kO/IsiOaYaFYnpPBPeVWjoO/et8/OpS0x59eCLi1ufsk9by+cTAYnytjR8RdzAXrgv
 W3Pzf+pxsUighIF99rPZGXKMmwN4oKrqw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:20:56 -0700
IronPort-SDR: r8dqfVveTEdkMYVHfCvVJShSig4JdlsvFK0uaqo0YOP5wtMVpHDfzj6B/QmNuomuJQIXqdysEa
 N7MvlHkchW+w==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:32:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 10/10] nvmet: use xarray for ctrl ns storing
Date: Tue, 14 Jul 2020 16:30:57 -0700
Message-Id: <20200714233057.10915-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193231_135984_4C2E3B46 
X-CRM114-Status: GOOD (  17.10  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch replaces the ctrl->namespaces tracking from linked list to
xarray and improves the performance when accessing one namespce :-

XArray vs Default:-

IOPS and BW (more the better) increase BW (~1.8%):-
---------------------------------------------------

 XArray :-
  read:  IOPS=160k,  BW=626MiB/s  (656MB/s)(18.3GiB/30001msec)
  read:  IOPS=160k,  BW=626MiB/s  (656MB/s)(18.3GiB/30001msec)
  read:  IOPS=162k,  BW=631MiB/s  (662MB/s)(18.5GiB/30001msec)

 Default:-
  read:  IOPS=156k,  BW=609MiB/s  (639MB/s)(17.8GiB/30001msec)
  read:  IOPS=157k,  BW=613MiB/s  (643MB/s)(17.0GiB/30001msec)
  read:  IOPS=160k,  BW=626MiB/s  (656MB/s)(18.3GiB/30001msec)

Submission latency (less the better) decrease (~8.3%):-
-------------------------------------------------------

 XArray:-
  slat  (usec):  min=7,  max=8386,  avg=11.19,  stdev=5.96
  slat  (usec):  min=7,  max=441,   avg=11.09,  stdev=4.48
  slat  (usec):  min=7,  max=1088,  avg=11.21,  stdev=4.54

 Default :-
  slat  (usec):  min=8,   max=2826.5k,  avg=23.96,  stdev=3911.50
  slat  (usec):  min=8,   max=503,      avg=12.52,  stdev=5.07
  slat  (usec):  min=8,   max=2384,     avg=12.50,  stdev=5.28

CPU Usage (less the better) decrease (~5.2%):-
----------------------------------------------

 XArray:-
  cpu  :  usr=1.84%,  sys=18.61%,  ctx=949471,  majf=0,  minf=250
  cpu  :  usr=1.83%,  sys=18.41%,  ctx=950262,  majf=0,  minf=237
  cpu  :  usr=1.82%,  sys=18.82%,  ctx=957224,  majf=0,  minf=234

 Default:-
  cpu  :  usr=1.70%,  sys=19.21%,  ctx=858196,  majf=0,  minf=251
  cpu  :  usr=1.82%,  sys=19.98%,  ctx=929720,  majf=0,  minf=227
  cpu  :  usr=1.83%,  sys=20.33%,  ctx=947208,  majf=0,  minf=235.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 17 ++++------
 drivers/nvme/target/core.c      | 58 +++++++++------------------------
 drivers/nvme/target/nvmet.h     |  3 +-
 3 files changed, 23 insertions(+), 55 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 95bb3bc4e335..55918fcef80b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -113,11 +113,10 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 	u64 data_units_read = 0, data_units_written = 0;
 	struct nvmet_ns *ns;
 	struct nvmet_ctrl *ctrl;
+	unsigned long idx;
 
 	ctrl = req->sq->ctrl;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
 		/* we don't have the right data for file backed ns */
 		if (!ns->bdev)
 			continue;
@@ -127,9 +126,7 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 		host_writes += part_stat_read(ns->bdev->bd_part, ios[WRITE]);
 		data_units_written += DIV_ROUND_UP(
 			part_stat_read(ns->bdev->bd_part, sectors[WRITE]), 1000);
-
 	}
-	rcu_read_unlock();
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
@@ -230,14 +227,13 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_ns *ns;
+	unsigned long idx;
 	u32 count = 0;
 
 	if (!(req->cmd->get_log_page.lsp & NVME_ANA_LOG_RGO)) {
-		rcu_read_lock();
-		list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link)
+		xa_for_each(&ctrl->subsys->namespaces, idx, ns)
 			if (ns->anagrpid == grpid)
 				desc->nsids[count++] = cpu_to_le32(ns->nsid);
-		rcu_read_unlock();
 	}
 
 	desc->grpid = cpu_to_le32(grpid);
@@ -556,6 +552,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	static const int buf_size = NVME_IDENTIFY_DATA_SIZE;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_ns *ns;
+	unsigned long idx;
 	u32 min_nsid = le32_to_cpu(req->cmd->identify.nsid);
 	__le32 *list;
 	u16 status = 0;
@@ -567,15 +564,13 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 		goto out;
 	}
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
 			continue;
 		list[i++] = cpu_to_le32(ns->nsid);
 		if (i == buf_size / sizeof(__le32))
 			break;
 	}
-	rcu_read_unlock();
 
 	status = nvmet_copy_to_sgl(req, 0, list, buf_size);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9cdc39c8b729..2908acc7b1e2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -115,13 +115,14 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 
 static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
 {
-	struct nvmet_ns *ns;
+	unsigned long nsid = 0;
+	struct nvmet_ns *cur;
+	unsigned long idx;
 
-	if (list_empty(&subsys->namespaces))
-		return 0;
+	xa_for_each(&subsys->namespaces, idx, cur)
+		nsid = cur->nsid;
 
-	ns = list_last_entry(&subsys->namespaces, struct nvmet_ns, dev_link);
-	return ns->nsid;
+	return nsid;
 }
 
 static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
@@ -410,25 +411,12 @@ static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
 
-static struct nvmet_ns *__nvmet_find_namespace(struct nvmet_ctrl *ctrl,
-		__le32 nsid)
-{
-	struct nvmet_ns *ns;
-
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
-		if (ns->nsid == le32_to_cpu(nsid))
-			return ns;
-	}
-
-	return NULL;
-}
-
 struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid)
 {
 	struct nvmet_ns *ns;
 
 	rcu_read_lock();
-	ns = __nvmet_find_namespace(ctrl, nsid);
+	ns = __xa_load(&ctrl->subsys->namespaces, nsid);
 	if (ns)
 		percpu_ref_get(&ns->ref);
 	rcu_read_unlock();
@@ -586,24 +574,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->nsid > subsys->max_nsid)
 		subsys->max_nsid = ns->nsid;
 
-	/*
-	 * The namespaces list needs to be sorted to simplify the implementation
-	 * of the Identify Namepace List subcommand.
-	 */
-	if (list_empty(&subsys->namespaces)) {
-		list_add_tail_rcu(&ns->dev_link, &subsys->namespaces);
-	} else {
-		struct nvmet_ns *old;
-
-		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
-					lockdep_is_held(&subsys->lock)) {
-			BUG_ON(ns->nsid == old->nsid);
-			if (ns->nsid < old->nsid)
-				break;
-		}
+	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
+	if (ret)
+		goto out_dev_put;
 
-		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
-	}
 	subsys->nr_namespaces++;
 
 	nvmet_ns_changed(subsys, ns->nsid);
@@ -630,7 +604,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 		goto out_unlock;
 
 	ns->enabled = false;
-	list_del_rcu(&ns->dev_link);
+	xa_erase(&ns->subsys->namespaces, ns->nsid);
 	if (ns->nsid == subsys->max_nsid)
 		subsys->max_nsid = nvmet_max_nsid(subsys);
 
@@ -681,7 +655,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	if (!ns)
 		return NULL;
 
-	INIT_LIST_HEAD(&ns->dev_link);
 	init_completion(&ns->disable_done);
 
 	ns->nsid = nsid;
@@ -1263,14 +1236,14 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 		struct nvmet_req *req)
 {
 	struct nvmet_ns *ns;
+	unsigned long idx;
 
 	if (!req->p2p_client)
 		return;
 
 	ctrl->p2p_client = get_device(req->p2p_client);
 
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
-				lockdep_is_held(&ctrl->subsys->lock))
+	xa_for_each(&ctrl->subsys->namespaces, idx, ns)
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 }
 
@@ -1523,7 +1496,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	kref_init(&subsys->ref);
 
 	mutex_init(&subsys->lock);
-	INIT_LIST_HEAD(&subsys->namespaces);
+	xa_init(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
@@ -1535,8 +1508,9 @@ static void nvmet_subsys_free(struct kref *ref)
 	struct nvmet_subsys *subsys =
 		container_of(ref, struct nvmet_subsys, ref);
 
-	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
+	WARN_ON_ONCE(!xa_empty(&subsys->namespaces));
 
+	xa_destroy(&subsys->namespaces);
 	kfree(subsys->subsysnqn);
 	kfree_rcu(subsys->model, rcuhead);
 	kfree(subsys);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6f8bd6a93575..49e14111446c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -52,7 +52,6 @@
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
 struct nvmet_ns {
-	struct list_head	dev_link;
 	struct percpu_ref	ref;
 	struct block_device	*bdev;
 	struct file		*file;
@@ -219,7 +218,7 @@ struct nvmet_subsys {
 	struct mutex		lock;
 	struct kref		ref;
 
-	struct list_head	namespaces;
+	struct xarray		namespaces;
 	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
 	u16			cntlid_min;
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
