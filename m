Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B83C433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 03:32:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1830D207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 03:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="twRrD//a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IkScJzTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1830D207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sPE1E7p9azs3wj/P/C8JhR6BxYgJQjZdE6nV+vaLp6s=; b=twRrD//ayKa2DhkvdovP2Kcpg
	WhUQUPyJ+OLFevAZSUCuuNw+Cra9GL1ko70krYd7QjuGSfrewGf84qHNW9EFwABZTiiQN3vD7eVL/
	vSA5rhMLoacqx4Jy47DYhghNJ1Y2h8Va9bxgXCY8BcnFkqyN+xCke8B3siDbjv1b/137MGvds0SsD
	R8i0PvhhlvC/ncAMNvZhWg8uR6tB7P2CRy6BVQ1+lWCIWQIioQTDZK9Ld6OpdX1ikT5UBgfkMkG4Y
	WJF3pvMmJAolLRTjxkx18fN5/XkK/A6u6FTI3zBAyc8ZeSV0/HUwtUy3/mZfL8UDO6ubuB1rApgsE
	VuJwMuHJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxMXa-0002dR-Dl; Mon, 20 Jul 2020 03:32:34 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxMXO-0002bH-Fc
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 03:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595215944; x=1626751944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0CCWKVeq+RRHYXBVFtaqBU7CdbYMQPeBUtpqtMLiJsE=;
 b=IkScJzTo5d506h7/9vw/w9jAzARU/NkYmH7MJf1iJlcq2iyd2GQTVL2n
 CZbRB2PPO0Ahk1q2AWc+9h/A7WzuChV05a52mzw9FkQfG+7ghaY/ocDMB
 warrYuFs6jNgrcZOuMymUovw3A1/D5dV0CSGF8OszdszwXRTee/N/WAe7
 qgNtau29RiRJMwXQwhNa0CZ9tqYNgK78o3Flc5MI/d8NOIIfWaWgadFvN
 xxXTtX3zscVPL2Cinx/wqoLI9bU7uiNdgDeIGBgEkK94cI+G0BTBJCvPD
 AKcXNhDwOTmcqoGL5Dkjimq7weuYbigeUWGAIgzGvlsm4y+PglLFMEBNx A==;
IronPort-SDR: v2cS31QkGB0PgsMOgxX6A8RyNSyyv6Bfqw38gVU6jg77ngzI9VS61+Ou+I1nUjpIMnrTD8IPm+
 jj6G7SeD8+GH/FC3NOBkHATmJrAR2UoGDyUo4q4KdDIszwUsRqkRSJ2Z+nJScLh5ItSJpgicVd
 SL/I+d59xeTJcgTxd/QlB0BV1xcyZUG0OwYJZfPG4xGNG9ducHjqXER2QR12X93MamluiAYcUf
 3FPjQK4gXyJvQCPlZDU9Vzr1Ezm6qOS/vTvUKi9/tuymLUdbIQCosP9noJ7zO+FBMU8QRQhcTJ
 Rkg=
X-IronPort-AV: E=Sophos;i="5.75,373,1589212800"; d="scan'208";a="245915585"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 11:32:24 +0800
IronPort-SDR: YBGNXj4ycbzH/3A2cTxqKEJfKERVC8T2AHXKrqLsB7e8ikiyzIbp5pRnmICuBt5V3ynf5U4YtZ
 w4LyY5qEDSx/fC/ntL/APRZ4tN8YGYUUg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2020 20:20:07 -0700
IronPort-SDR: nKXV5MgygAQAotqZOe432D7WXRIr3ncuuajF7Ic0FegOz4UngcPa5h3mxCyL6NreUoaWGTNrs4
 Vs4MsMUYmpBQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jul 2020 20:32:22 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 1/2] nvmet: use xarray for ctrl ns storing
Date: Sun, 19 Jul 2020 20:32:02 -0700
Message-Id: <20200720033203.11474-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200720033203.11474-1-chaitanya.kulkarni@wdc.com>
References: <20200720033203.11474-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200719_233222_835281_E9F57389 
X-CRM114-Status: GOOD (  16.61  )
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
 drivers/nvme/target/admin-cmd.c | 17 ++++-----
 drivers/nvme/target/core.c      | 64 +++++++++++----------------------
 drivers/nvme/target/nvmet.h     |  3 +-
 3 files changed, 27 insertions(+), 57 deletions(-)

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
index 9cdc39c8b729..9b9e88bfc210 100644
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
@@ -410,28 +411,13 @@ static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
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
 
-	rcu_read_lock();
-	ns = __nvmet_find_namespace(ctrl, nsid);
+	ns = xa_load(&ctrl->subsys->namespaces, nsid);
 	if (ns)
 		percpu_ref_get(&ns->ref);
-	rcu_read_unlock();
 
 	return ns;
 }
@@ -586,24 +572,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
+		goto out_restore_subsys_maxnsid;
 
-		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
-	}
 	subsys->nr_namespaces++;
 
 	nvmet_ns_changed(subsys, ns->nsid);
@@ -612,6 +584,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
+
+out_restore_subsys_maxnsid:
+	subsys->max_nsid = nvmet_max_nsid(subsys);
+	percpu_ref_exit(&ns->ref);
 out_dev_put:
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
@@ -630,7 +606,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 		goto out_unlock;
 
 	ns->enabled = false;
-	list_del_rcu(&ns->dev_link);
+	xa_erase(&ns->subsys->namespaces, ns->nsid);
 	if (ns->nsid == subsys->max_nsid)
 		subsys->max_nsid = nvmet_max_nsid(subsys);
 
@@ -681,7 +657,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	if (!ns)
 		return NULL;
 
-	INIT_LIST_HEAD(&ns->dev_link);
 	init_completion(&ns->disable_done);
 
 	ns->nsid = nsid;
@@ -1263,14 +1238,14 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
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
 
@@ -1523,7 +1498,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	kref_init(&subsys->ref);
 
 	mutex_init(&subsys->lock);
-	INIT_LIST_HEAD(&subsys->namespaces);
+	xa_init(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
@@ -1535,8 +1510,9 @@ static void nvmet_subsys_free(struct kref *ref)
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
