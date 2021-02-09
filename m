Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03FAC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8632864EA4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8632864EA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=c3/HR6/wonigRBhnm0ZdhAPcb4kdsmPV0F4gzT38woQ=; b=kFHK1vKXqGbbLZTkGMsFVIWc1
	ISNkq5GnceO87vtyzY2m1npccojZTNTQSpnUTCM9wvHrdQ0oAslBOgdLjfIqA8YOROT0/rXgWhprN
	I+de4f++4ua4o6nCuTT7Yc3zbmLv0QfV73cthb0AsoZp6IcOQ8RdCukjOPM0DV0GHp7tu8rYbyB6S
	kDqIZM902CL5Rb8lvUWCPXEZaXYTpsRUIBE0KT7X1FzLW4Zq5sRju0veHnhxsOMwz5Md1grOsT4wt
	S70x9eSirynKpDqKSgqqBkn1I3eH5BtFbO//8Byab4ITehk7to2SCuS4ylKIo29mwT8xoh+t8KlnQ
	ULajXxVeg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKd-0002uW-NC; Tue, 09 Feb 2021 04:08:55 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKY-0002sC-8m
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843730; x=1644379730;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5+0h3Q+e6iV3Kv4SQ8lfD8Ptm6OEAuE6+CDYR2PgpT4=;
 b=ceY1Q07VXsjWv0l8PQu/q6Gfcf/E+RxQOH7m+M/ZuUEDtw0Cste79TwN
 zvP9P+q+B01n5PIk7wvXU5o8WxMXoUzccu3ME01JpVH0hiW/YCFfYPLO1
 g+CH0yPtaFcOymxtUm74tPVKkalztvyD3lDuCKdfEV5MihTAvRPMrJReL
 qLzsCv+sTeEWkAUMKamD7iLtxjJG/Qf3BTs3MnXX3xkl2ye4XFqZ7vc36
 HTJbbiwsmoX31L6kRohMJSOt1vjfdvU1rt2a9HlM/0ukZwU9Iz2d7I9y2
 KAoNddN6y1CX5N2KriRnE185lYGT7Wc6ob9kBZQnXMLG9H3GbRxFkNxnZ g==;
IronPort-SDR: WQbAJ6sjsMAIKhNjOQxLzpcMZPULpLleLwT1zJUBJm9Fa994YzDpRBZaRqo4AwRcRWcaUCJN4d
 /I58I7e/5mj6E+ytAI4LX92iZCKGewb23k12wI1Cy+FQ/cAHo6wp77Hx/AZi9AAjPbeSvE2DZN
 SxjBOZPBdKi4abFlMwYzTPFSkNkNhoTxUdqBQk7L+u6qJpJpyDdMVzacdxLBzzyqIWp4w+oL6Q
 pe4Q4ve4Kway9x95M5zDTcQCG/N5G6VzD470DRUyZ3SyiAe+nYZ93rDR4aEH9svAPqQRqdR/k5
 zvE=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970518"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:49 +0800
IronPort-SDR: QFvBCuqd5K1y9HqErNZbsLaATOmgh/KaoOJ4bDyOJrCNYQVnzosa00R/aeQuOF8G0UJLjCBmpP
 1DveoIlAo74DzvZtgdvUN6fgb6mauuU7NHB4mC/SFiGn28Oy2VH49ee337rofNefPbbRLfH9Nz
 RXEKRBAp3hYA7u1M7CWofHUGagPrd9gbugon/yk+XnUIiRNh564QJQc8+7w8FQ2e8jgStmZ9Jk
 xdZrPLm/CPN/b3/S+wF9rapOxzSo5/tw8r/yspnVbRsDnZxmvkRz8Ca9gQrWL0ZmWAvdpXvasD
 cGq7Xy590Snn6r3ALUqfUFEq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:44 -0800
IronPort-SDR: uqqs/+tQ0YfY8NxjZvsLlKTAx5ohEt4iglQ4K1anxC8spNBGCr3Uvn+iIWkwqF+Ba5aD9sJF5r
 FwzItzI3DCEHT3ZCcU7fanpZtnq6nEs5tNMKZB3KtrVhgUZGcUX3arkaFfi7sMUgDqBjErX/qF
 qsq2VOCWkoWr2F+qNF7+wWxu4qX6m50egmP4qZjYvGbV0ZF1Eews1EGiIfgJX0o7+nBaVkxFqk
 HKWufBPDBih8aZRgoezY8N609+1dua8zO3cFxpllM4LggWCcZGpsagtnZuM3/ZFSXSTNJ4Wc1G
 p5s=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:08:50 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 03/11] nvmet: make nvmet_find_namespace() req based
Date: Mon,  8 Feb 2021 20:08:35 -0800
Message-Id: <20210209040843.45572-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230850_516339_8BA9C68D 
X-CRM114-Status: GOOD (  18.50  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The six callers of nvmet_find_namespace() duplicate the error log page
update and status setting code for each call on failure.

All callers are nvmet requests based functions, so we can pass req
to the nvmet_find_namesapce() & derive ctrl from req, that'll allow us
to update the error log page in nvmet_find_namespace(). Now that we
pass the request we can also get rid of the local variable in
nvmet_find_namespace() and use the req->ns and return the error code.

Replace the ctrl parameter with nvmet_req for nvmet_find_namespace(),
centralize the error log page update for non allocated namesapces, and
return uniform error for non-allocated namespace.

The nvmet_find_namespace() takes nsid parameter which is from NVMe
commands structures such as get_log_page, identify, rw and common. All
these commands have same offset for the nsid field.

Derive nsid from req->cmd->common.nsid) & remove the extra parameter
from the nvmet_find_namespace().

Lastly now we associate the ns to the req parameter that we pass to the
nvmet_find_namespace(), rename the nvmet_find_namespace() to
nvmet_req_find_ns() i.e. :-

Old:-
struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl,
				      __le32 nsid)
New :-
u16 nvmet_req_find_ns(struct nvmet_req *req);

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 47 +++++++++++++--------------------
 drivers/nvme/target/core.c      | 24 +++++++++--------
 drivers/nvme/target/nvmet.h     |  2 +-
 3 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d6a3ecf66262..787e41d48a92 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -75,15 +75,11 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
 	u64 host_reads, host_writes, data_units_read, data_units_written;
+	u16 status;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl,
-				       req->cmd->get_log_page.nsid);
-	if (!req->ns) {
-		pr_err("Could not find namespace id : %d\n",
-				le32_to_cpu(req->cmd->get_log_page.nsid));
-		req->error_loc = offsetof(struct nvme_rw_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	status = nvmet_req_find_ns(req);
+	if (status)
+		return status;
 
 	/* we don't have the right data for file backed ns */
 	if (!req->ns->bdev)
@@ -468,7 +464,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ns *id;
-	u16 status = 0;
+	u16 status;
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
@@ -482,8 +478,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto out;
 	}
 
-	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!req->ns) {
+	status = nvmet_req_find_ns(req);
+	if (status) {
 		status = NVME_SC_INVALID_NS;
 		/*
 		 * According to spec : If the specified namespace is
@@ -611,15 +607,12 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
-	u16 status = 0;
 	off_t off = 0;
+	u16 status;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!req->ns) {
-		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	status = nvmet_req_find_ns(req);
+	if (status)
 		goto out;
-	}
 
 	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
@@ -699,13 +692,11 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 {
 	u32 write_protect = le32_to_cpu(req->cmd->common.cdw11);
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
-	u16 status = NVME_SC_FEATURE_NOT_CHANGEABLE;
+	u16 status;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
-	if (unlikely(!req->ns)) {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return status = NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	status = nvmet_req_find_ns(req);
+	if (status)
+		return status;
 
 	mutex_lock(&subsys->lock);
 	switch (write_protect) {
@@ -720,6 +711,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 		status = 0;
 		break;
 	default:
+		status = NVME_SC_FEATURE_NOT_CHANGEABLE;
 		break;
 	}
 
@@ -806,11 +798,10 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 result;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->common.nsid);
-	if (!req->ns)  {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	result = nvmet_req_find_ns(req);
+	if (result)
+		return result;
+
 	mutex_lock(&subsys->lock);
 	if (req->ns->readonly == true)
 		result = NVME_NS_WRITE_PROTECT;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..95b58d4b1af2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -417,15 +417,18 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
 
-struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid)
+u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
-	struct nvmet_ns *ns;
+	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 
-	ns = xa_load(&ctrl->subsys->namespaces, le32_to_cpu(nsid));
-	if (ns)
-		percpu_ref_get(&ns->ref);
+	req->ns = xa_load(&req->sq->ctrl->subsys->namespaces, nsid);
+	if (unlikely(!req->ns)) {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	}
 
-	return ns;
+	percpu_ref_get(&req->ns->ref);
+	return NVME_SC_SUCCESS;
 }
 
 static void nvmet_destroy_namespace(struct percpu_ref *ref)
@@ -862,11 +865,10 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvmet_req_passthru_ctrl(req))
 		return nvmet_parse_passthru_io_cmd(req);
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
-	if (unlikely(!req->ns)) {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	ret = nvmet_req_find_ns(req);
+	if (unlikely(ret))
+		return ret;
+
 	ret = nvmet_check_ana_state(req->port, req->ns);
 	if (unlikely(ret)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8776dd1a0490..954b3d8451f5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -443,7 +443,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
 
-struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid);
+u16 nvmet_req_find_ns(struct nvmet_req *req);
 void nvmet_put_namespace(struct nvmet_ns *ns);
 int nvmet_ns_enable(struct nvmet_ns *ns);
 void nvmet_ns_disable(struct nvmet_ns *ns);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
