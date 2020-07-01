Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99686C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 02:25:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F22920675
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 02:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rBjk5nMu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UpkGvUz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F22920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2xunSgdOpVv3Il+BhrkS+569oFJOdewEJ8Zn/ODPTuk=; b=rBjk5nMuMVm58ip53RSsdLG3i
	IeqgYRH11Whjd2fxfhpC3nvALISyAr7jmoe8DhYyTr0u6v/9oh+f2nJv/JFD7Gq1eEHxeJweCCxO8
	JsRCmJprrviwb1XysbbV0/jPzsmQ0ssm0BrFlscv+psa0zPBLaSBN05+KytryPahMZ3S/VLceKaEt
	FJgxvrV63+PNk2djdjzISWQMIl3JVS/nzxRjg6ZMNVbAfyFe5XVHrLxTl8fIR2clk2dXJuMvTz2/A
	+VuS68vBzcD5qJaOeRbmc+5j/DK0AUnLofZNgVj8/b/gGhBIEh9Q4u9Dz8b+GIQtHrtgWo6PSgml0
	TF/061vvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqSRM-0001wQ-4B; Wed, 01 Jul 2020 02:25:36 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqSRI-0001tE-8L
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 02:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593570333; x=1625106333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xcbi2Hkwcmiopd4ZEgvwAaDHTo5NOM8ZSJIWs/1e8Pg=;
 b=UpkGvUz0q6hptyVSV9LqV9akg7kk5dBuoJBLJCFvMTPJ/KHjf6OQEX8f
 fJ+0LwZHNfQfN1dQr/iHYl7cVrsNJQ0nrSvrQWEHxoAVyjLyp2YJvkfry
 TgX2TDiAamNpyJvUIJ1wwmekd/Ig5wqSGRO8wkvjhdDfpJKVyUKyRzgKf
 fchsfHp+s5DUYpzu5aYJKHblhU5okx3QyXvJF/5kC4RbHRViQc6i8vpvr
 QJWqnbKVZKqazQH/ixYfyS9xUy1kLd29Zfw9h/kQ61GEMMUi6DH9ojqvv
 2h7SdYoeAUleg4EotY/MdnQq8PVQ2Plky3f10IU94aT/KZLuwV8cPYLFI Q==;
IronPort-SDR: pQCS+0uSVMdgRpJvOPTjCi4srsWigS1bV4uzss3Mgt2BqaFHSY7yWMF1p1z362yHmyHClBtZOc
 rZlSegrcrvuuSrzxrHbcTKcp4SUvmHYb16MEnOPNPwbssCLbmLua+G3zbZ9juWi0Oq+aN5B9Fr
 4j5FRYa/zwEvn4qd8T+ztei1IgtWIrUNnvi6bBD5Fw3stDHSq/XYKygCtFCME5wdvygf8DH3dM
 ipw61/GbEwNE2KHXmUqZQCyXNufIEKUdrDUfaJclIQqrZa7PiOcdZrqw0RBLGCLK+lXhdJo6Aw
 Jj8=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; d="scan'208";a="141536481"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 10:25:33 +0800
IronPort-SDR: VFkW2MgV+3nRd4loGclkhUf9vxLmAIEXdBZRd5MXOGe525ooO2yG/wRjj+RXr1JOdXUv12Bi5L
 WiGy5cgx3rw0lpXGdcG6XCCczy3Dbkb7M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 19:14:22 -0700
IronPort-SDR: kw6spdwRuJU7tl8Ad0x5+yVP5ogztE7ZZLdxvbYrVAujQe+N9t5kXht408SQpRcdqMrZWFcnCF
 GmROCsyQxc/Q==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2020 19:25:32 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org
Subject: [PATCH V2 2/2] nvmet: use xarray for ctrl ns storing
Date: Tue, 30 Jun 2020 19:25:17 -0700
Message-Id: <20200701022517.6738-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200630_222532_604171_5C8423BD 
X-CRM114-Status: GOOD (  19.57  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
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
 drivers/nvme/target/admin-cmd.c | 25 +++++------
 drivers/nvme/target/core.c      | 77 +++++++++++++++------------------
 drivers/nvme/target/nvmet.h     |  3 +-
 3 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 95bb3bc4e335..39e753ed9419 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -109,15 +109,14 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
-	u64 host_reads = 0, host_writes = 0;
 	u64 data_units_read = 0, data_units_written = 0;
-	struct nvmet_ns *ns;
+	u64 host_reads = 0, host_writes = 0;
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_ns *ns;
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
@@ -554,11 +550,12 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 {
 	static const int buf_size = NVME_IDENTIFY_DATA_SIZE;
+	u32 min_nsid = le32_to_cpu(req->cmd->identify.nsid);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_ns *ns;
-	u32 min_nsid = le32_to_cpu(req->cmd->identify.nsid);
-	__le32 *list;
+	unsigned long idx;
 	u16 status = 0;
+	__le32 *list;
 	int i = 0;
 
 	list = kzalloc(buf_size, GFP_KERNEL);
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
index cea7c3834021..d14edaa22ad5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -10,6 +10,9 @@
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
 
+#include "../host/nvme.h"
+#undef CREATE_TRACE_POINTS
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
@@ -115,13 +118,17 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 
 static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
 {
-	struct nvmet_ns *ns;
+	struct nvmet_ns *cur;
+	unsigned long idx;
+	unsigned long nsid;
 
-	if (list_empty(&subsys->namespaces))
+	if (xa_empty(&subsys->namespaces))
 		return 0;
 
-	ns = list_last_entry(&subsys->namespaces, struct nvmet_ns, dev_link);
-	return ns->nsid;
+	xa_for_each(&subsys->namespaces, idx, cur)
+		nsid = cur->nsid;
+
+	return nsid;
 }
 
 static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
@@ -410,25 +417,17 @@ static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
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
-	struct nvmet_ns *ns;
+	XA_STATE(xas, &ctrl->subsys->namespaces, le32_to_cpu(nsid));
+	struct nvmet_ns *ns = NULL;
 
 	rcu_read_lock();
-	ns = __nvmet_find_namespace(ctrl, nsid);
+	do {
+		ns = xas_load(&xas);
+		if (xa_is_zero(ns))
+			ns = NULL;
+	} while (xas_retry(&xas, ns));
 	if (ns)
 		percpu_ref_get(&ns->ref);
 	rcu_read_unlock();
@@ -586,24 +585,20 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
+	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
+	if (ret) {
+		switch (ret) {
+		case -ENOMEM:
+			pr_err("xa insert memory allocation\n");
+			goto out_unlock;
+		case -EBUSY:
+			pr_err("xa insert entry already present\n");
+			goto out_unlock;
+		default:
+			goto out_unlock;
 		}
-
-		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
 	}
+
 	subsys->nr_namespaces++;
 
 	nvmet_ns_changed(subsys, ns->nsid);
@@ -630,7 +625,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 		goto out_unlock;
 
 	ns->enabled = false;
-	list_del_rcu(&ns->dev_link);
+	xa_erase(&ns->subsys->namespaces, ns->nsid);
 	if (ns->nsid == subsys->max_nsid)
 		subsys->max_nsid = nvmet_max_nsid(subsys);
 
@@ -681,7 +676,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	if (!ns)
 		return NULL;
 
-	INIT_LIST_HEAD(&ns->dev_link);
 	init_completion(&ns->disable_done);
 
 	ns->nsid = nsid;
@@ -1263,14 +1257,14 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
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
 
@@ -1523,7 +1517,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	kref_init(&subsys->ref);
 
 	mutex_init(&subsys->lock);
-	INIT_LIST_HEAD(&subsys->namespaces);
+	xa_init(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
@@ -1535,8 +1529,9 @@ static void nvmet_subsys_free(struct kref *ref)
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
