Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC33C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DA764E15
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DA764E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZRUeEnD/HJVOPcuqn95icD8MwBRd2ItnBEdQOMGVl+w=; b=LgkKXKMWpECCVcNRtM6FMUXPO
	2Ptf4ha6hLacCQYZ9dhOlfwXoAO6Lq5B5OhNEa3/9PDRghfh4EljIJUuoTgqAHjzeewsqxhtZjBSg
	qTE6lRLOiDkQm/BJzrgCU5L/sZvoz1OF7Ti4FF5k5HIJKIcM68lF1pfBbZc30HrOZ4zKycQMnOkbK
	o/UntFdQpwbl6UwkMIs1sstW1iYUwj1psiLbYoO9YNhJR8+Hwgluxzzz6HBX+X+jQCW4vPs8Kt0p0
	fJXGlLIDcoT38rtjV9g2bQx3ZNXAUVXRR9Xmr/30NgEJPomBHN3EWngHxMxGe/uXnoJSZbTaG7pdQ
	xnz9yBJlg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Ryb-0004ti-W0; Mon, 01 Feb 2021 05:42:18 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6RyZ-0004sp-Vn
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158135; x=1643694135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N2bYFCt6/d2cWKgwcHR1ia0AlN1yr2TJ8Lj+0lx8KaM=;
 b=X24OkpyrHmh0e4FD4VbC4rORsRsaEsMWwO5ICwSIfcIMzhQ7qbgFC2Z3
 wis1MRaLSMpj0oqZMR2XEZOL+Ih/K3aTGDETrdzIimPiQzGhPL3rHEdPq
 sVgqEJbdc+ySH/F68tp8hbo6EtoWUkf3sdEc1MNQnu1TG+lo/1E9X0uhX
 UiOfWLU9EQSUDr0AQbUAp7qR9gBPRPJBEQxCTpTj9BvhmPoS17mgjFLQR
 WZT735Jy+X4YOmy9FMDTx2dTpvdbuVPZHjGvD4/Wl1gFC3fxGWRLi+q96
 ASPsgnR62T5vKMPV7MriBCRsLbD6h6L1ujZLtFHPFoN/hLRm4g7KM5YOY g==;
IronPort-SDR: X2pXx+vwhr1IEd0ANw4RdDP7K7wyl/heVKkgc1URGn7pRJ7uLuUQ1mVRWyjPp+ySkGXxgTfejD
 W22utndEWj7KDTr6HrWBXtNR9MT5QzPlSfmQ2c53d/3EV3WDICJ0GDpw48K0vU5HDeyOuaJFji
 cDDhUFDsyAOg4EURlP+ViRn4Cn9U45tnp7befwU/1E9H4Vt+EjwCISmaxg1w6952tXvHzGBmCW
 juMhnrzHxRrIa/RUg+oQQM7UTqk7kgT3SzlLyLyPXnT0+76AHoLEdNHsEFviurbiMpMVWrgYH/
 IOg=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="158785508"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:42:14 +0800
IronPort-SDR: Dy9RMYXA/kA4AluOwUGwLzul5c5PFbl7dXA5KZ6izD5i3X8Hbc0IdG7PahvPauD4bxITLYZZNB
 OIQJMTvAHQNlHUq0inaee91/ipmbW479n6QkdRXKv9yBfcQ4GXkZZqhafebNbLTQaPBl/XYWdo
 7U9/94R65SFhI97oW4/aNEyqDpSytQqFRjS7Hcugbk04duU6yXvjx+dnjtvw2rywIMW9cMW4bc
 co5slfM0PE3B7gWVg8UBlDSTaTyNpLyISJ0t+3s1l+FkxQsyzqra+ZovHftymS0rQPGV2RDzeh
 yO18MTo0Fhn01PbxYfBZlIIf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:26:28 -0800
IronPort-SDR: mTBkIuk749yXWr6rThmHt116DXC4t0/Fbnt5haAP+L1tS8J12xejfKYyHC6AHGWgxK3VTwJ5OK
 GKnan/WU77zp+71M7En/UAd0bf1b6eNf0Z5eOxPKah8S6GRU07i6FVo8R8UpDbrSAF5qAKWiqr
 0OJATeGHzjeQVqw5nEXYKTOde3iPzaF9HyqLSqiWLdwElNXC8ugDPNavGKyX/JoFWHPw3ltqPL
 WxJpRDmBp+GfQR6l78tXwenrKXL+lko7EH1qInrLzHL3DegEj6HiBGDeMUfOpVeJSm2pHo3OsJ
 Bh0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:16 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 04/10] nvmet: remove nsid param from nvmet_find_namespace()
Date: Sun, 31 Jan 2021 21:41:32 -0800
Message-Id: <20210201054138.34324-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004216_147948_5BAF8D5D 
X-CRM114-Status: GOOD (  15.41  )
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

The nvmet_find_namespace() takes nsid parameter which is from NVMe
commands structures such as get_log_page, identify, rw and common. All
these commands have same offset for the nsid field.

Derive nsid from req (req->cmd->common.nsid) and remove the extra
parameter from the nvmet_find_namespace().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 10 +++++-----
 drivers/nvme/target/core.c      |  6 ++++--
 drivers/nvme/target/nvmet.h     |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index fbb5fe18f2d4..ec64218db03c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -77,7 +77,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	u64 host_reads, host_writes, data_units_read, data_units_written;
 	u16 status;
 
-	status = nvmet_find_namespace(req, req->cmd->get_log_page.nsid);
+	status = nvmet_find_namespace(req);
 	if (status) {
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
@@ -475,7 +475,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto out;
 	}
 
-	status = nvmet_find_namespace(req, req->cmd->identify.nsid);
+	status = nvmet_find_namespace(req);
 	if (status) {
 		/*
 		 * According to spec : If the specified namespace is
@@ -611,7 +611,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	u16 status;
 	off_t off = 0;
 
-	status = nvmet_find_namespace(req, req->cmd->identify.nsid);
+	status = nvmet_find_namespace(req);
 	if (status)
 		goto out;
 
@@ -695,7 +695,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u16 status;
 
-	status = nvmet_find_namespace(req, req->cmd->rw.nsid);
+	status = nvmet_find_namespace(req);
 	if (unlikely(status))
 		return status;
 
@@ -798,7 +798,7 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u16 result;
 
-	result = nvmet_find_namespace(req, req->cmd->common.nsid);
+	result = nvmet_find_namespace(req);
 	if (result)
 		return result;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6ebcbc637265..9c6683f8e790 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -417,8 +417,10 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
 
-u16 nvmet_find_namespace(struct nvmet_req *req, __le32 id)
+u16 nvmet_find_namespace(struct nvmet_req *req)
 {
+	__le32 id = le32_to_cpu(req->cmd->common.nsid);
+
 	req->ns = xa_load(&req->sq->ctrl->subsys->namespaces, le32_to_cpu(id));
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
@@ -863,7 +865,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvmet_req_passthru_ctrl(req))
 		return nvmet_parse_passthru_io_cmd(req);
 
-	ret = nvmet_find_namespace(req, cmd->rw.nsid);
+	ret = nvmet_find_namespace(req);
 	if (unlikely(ret))
 		return ret;
 	ret = nvmet_check_ana_state(req->port, req->ns);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 80811fccb431..6864fd916bb5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -443,7 +443,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
 
-u16 nvmet_find_namespace(struct nvmet_req *req, __le32 id);
+u16 nvmet_find_namespace(struct nvmet_req *req);
 void nvmet_put_namespace(struct nvmet_ns *ns);
 int nvmet_ns_enable(struct nvmet_ns *ns);
 void nvmet_ns_disable(struct nvmet_ns *ns);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
