Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87B1C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 18:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i+EPxDn3Rd3QFmdJVOiuxxbsqvTAz4LQKiia8YhTSPw=; b=veEgTs69JkOotLd2A6B9PbIqmt
	OsYUvckomaTdCBi49FLitC4hZER4C8LYr84NJSbWBA07WrcJMsjBY63skvqhd1BZzl/RYJXLFYtRB
	f1IjdYXLn8cOa3Ll3tPmrB4Hc9Waoiq+gXNnc9Es9rsGNug0hBgfUVtn/GugHs/bMhJvSWiS73AgA
	b6ttyl61Amsw176Koa+OQQ/RtAi2RKpMESesiBYSy8+RY57ZVfLd/h4noz32iLqyWfMb2fx/FIcm+
	bMl3qXgIMyaHQ/XlXsA+Y7nwYw//fRa83y8bkxXqcLgbAuAYga4A50xDCEx0jbEp5bRI4cvYG94e2
	haO9c1SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmdHE-0000000EpYy-46pJ;
	Mon, 24 Feb 2025 18:34:00 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd5S-0000000EmhG-19Kj
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 18:21:51 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 51OFDOmi008781
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=i+EPxDn3Rd3QFmdJVOiuxxbsqvTAz4LQKiia8YhTSPw=; b=O4GiZCUtgdDU
	4ypJU4X6uxd2ulXy4+pmdncOhJkDzlnQsOxF1LyN+QntCHILei6krwTt1ixoeSjQ
	j1deEwPRDlmPh7FnrFFKEHNsyYBPWt54eC7NQsLTCe4jpTbon9xk2DzWoGle1WDh
	qRTMIl4KCwxyDPKN8AALgyygsk1YOaqjxlVmQ+bn5v4AsilyYWAxvzfoFxtpPsNE
	AXdwP8NLqflNtTPdFuP5oHf9cIOoMUCPdd2/ifU3Hf4kDW/MU1IyJu/ZL/lL1ArH
	HOcCDFROBKctOPruKVJfpdRcGqe458BhZynpw6tQnsre9TPsYb5BxoqUzmWqDHV8
	KJA3lY+giA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 450su1a9xs-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:49 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 18:21:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id CF56E18678FB9; Mon, 24 Feb 2025 10:21:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/6] nvme-ioctl: common user timeout setting
Date: Mon, 24 Feb 2025 10:21:26 -0800
Message-ID: <20250224182128.2042061-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250224182128.2042061-1-kbusch@meta.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -FCig5dszDZkY8IHol-ceewSMigHBCHx
X-Proofpoint-GUID: -FCig5dszDZkY8IHol-ceewSMigHBCHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_102150_434777_93232760 
X-CRM114-Status: GOOD (  11.09  )
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

From: Keith Busch <kbusch@kernel.org>

Most of the passthrough paths repeat the same request timeout setup, so
make it common with the request allocation.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3da014ccbe550..1f28fc4b341dd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -101,7 +101,7 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval=
)
=20
 static struct request *nvme_alloc_user_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_opf_t rq_flags,
-		blk_mq_req_flags_t blk_flags)
+		blk_mq_req_flags_t blk_flags, unsigned timeout_ms)
 {
 	struct request *req;
=20
@@ -110,6 +110,7 @@ static struct request *nvme_alloc_user_request(struct=
 request_queue *q,
 		return req;
 	nvme_init_request(req, cmd);
 	nvme_req(req)->flags |=3D NVME_REQ_USERCMD;
+	req->timeout =3D timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
 	return req;
 }
=20
@@ -180,7 +181,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, u64 ubuffer, unsigned bufflen,
 		u64 meta_buffer, unsigned meta_len, u64 *result,
-		unsigned timeout, unsigned int flags)
+		unsigned timeout_ms, unsigned int flags)
 {
 	struct nvme_ns *ns =3D q->queuedata;
 	struct nvme_ctrl *ctrl;
@@ -189,11 +190,10 @@ static int nvme_submit_user_cmd(struct request_queu=
e *q,
 	u32 effects;
 	int ret;
=20
-	req =3D nvme_alloc_user_request(q, cmd, 0, 0);
+	req =3D nvme_alloc_user_request(q, cmd, 0, 0, timeout_ms);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
=20
-	req->timeout =3D timeout;
 	if (ubuffer && bufflen) {
 		ret =3D nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
 				meta_len, NULL, flags);
@@ -297,7 +297,6 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, stru=
ct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
-	unsigned timeout =3D 0;
 	u64 result;
 	int status;
=20
@@ -324,12 +323,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, str=
uct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, flags))
 		return -EACCES;
=20
-	if (cmd.timeout_ms)
-		timeout =3D msecs_to_jiffies(cmd.timeout_ms);
-
 	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, cmd.metadata, cmd.metadata_len,
-			&result, timeout, flags);
+			&result, cmd.timeout_ms, flags);
=20
 	if (status >=3D 0) {
 		if (put_user(result, &ucmd->result))
@@ -344,7 +340,6 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
-	unsigned timeout =3D 0;
 	int status;
=20
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
@@ -370,12 +365,9 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, s=
truct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, flags))
 		return -EACCES;
=20
-	if (cmd.timeout_ms)
-		timeout =3D msecs_to_jiffies(cmd.timeout_ms);
-
 	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, cmd.metadata, cmd.metadata_len,
-			&cmd.result, timeout, flags);
+			&cmd.result, cmd.timeout_ms, flags);
=20
 	if (status >=3D 0) {
 		if (put_user(cmd.result, &ucmd->result))
@@ -507,10 +499,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl,=
 struct nvme_ns *ns,
 	if (issue_flags & IO_URING_F_IOPOLL)
 		rq_flags |=3D REQ_POLLED;
=20
-	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
+	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags, d.timeout_m=
s);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	req->timeout =3D d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
=20
 	if (d.addr && d.data_len) {
 		ret =3D nvme_map_user_request(req, d.addr, d.data_len, d.metadata,
--=20
2.43.5


