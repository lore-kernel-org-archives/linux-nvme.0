Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F4C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 14:03:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECDB65068
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 14:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECDB65068
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=exnBokQHYUzxUsrj6CtfV7wVxbCYWBEL8MXO9xfFrAo=; b=BgboTVncXxtBxYswKP99C/A5V
	AGae5CC5UEGtcsdubx/jbXPwIHIDl0cwkDZUNOXG9QoGnDdnKNUD4RY90T5efziznfXwjUTDne5By
	UwqQFlNwHmVpwgFAkS3vqwOmOq/sOSD+mtQ9NEYX7E2rJ9saJJ38IqDhob1Sh0WtzhmgWhE3bSvZB
	OlOIn2VYchT7QJ9eQ1AASnZuhWcSl48l/K+Aov5rxtuZS2pzPRuCJUwuwIBcL0hebxJdY8/ZNoK/R
	A1paaD95mauYFyZgfcCTXnBpyn5KkYPFD6saJ30WOLkVeb0UK9OiKav/ewWkjbUeCelOx6RIYm8p3
	tRzohMoBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMAI8-000tfu-CR; Tue, 16 Mar 2021 14:03:24 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMAHS-000tbb-BT
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 14:02:45 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210316140238epoutp0432cc61d4e2ff82773d5bfdbcf647f629~s14sbnM4d2177621776epoutp04J
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 14:02:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210316140238epoutp0432cc61d4e2ff82773d5bfdbcf647f629~s14sbnM4d2177621776epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1615903358;
 bh=QtFMwLMCMBlFlOoboW+80gxR0CXhPEogINbPxqfzfes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jk74dEERICuZdsqmieot3zyV9HYwf7s9e3OLy9+Jc38fhe0MBJm+M/tOkctYnn6RN
 vS9dTl+4cbkJEPQGwLkvudaaL/n349OU4aZmUM2uphTmd3WPsdRAiUP03LVB9b5nGu
 CSENBVmHziTxgBqiPZs+djnJsn6yPxKzG6IKFlGc=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210316140237epcas5p30027a95b56175a643140644c22188f4b~s14rS_kG80793507935epcas5p3N;
 Tue, 16 Mar 2021 14:02:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CB.6D.33964.D7AB0506; Tue, 16 Mar 2021 23:02:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20210316140236epcas5p4de087ee51a862402146fbbc621d4d4c6~s14qlVq_b1877618776epcas5p4k;
 Tue, 16 Mar 2021 14:02:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210316140236epsmtrp18cb05d34faa39ecb868fe9e024c74aa2~s14qkgtTB0307603076epsmtrp1d;
 Tue, 16 Mar 2021 14:02:36 +0000 (GMT)
X-AuditID: b6c32a4b-eb7ff700000184ac-87-6050ba7d43ae
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 5F.54.08745.C7AB0506; Tue, 16 Mar 2021 23:02:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210316140235epsmtip2f21aceaef8fee2ba6e70ad68977c685f~s14o7A4lE1114511145epsmtip2f;
 Tue, 16 Mar 2021 14:02:34 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, chaitanya.kulkarni@wdc.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, nj.shetty@samsung.com,
 selvakuma.s1@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH v3 2/3] nvme: keep nvme_command instead of pointer to it
Date: Tue, 16 Mar 2021 19:31:25 +0530
Message-Id: <20210316140126.24900-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316140126.24900-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7bCmum7troAEg3nd0hZNE/4yW6y+289m
 Mev2axaLlauPMlm8az3HYvH4zmd2i6P/37JZTDp0jdFi/rKn7Bbbfs9ntrgyZRGzxesfJ9kc
 eDwuny312LSqk81j85J6j903G9g8+rasYvT4vEnOo/1AN1MAexSXTUpqTmZZapG+XQJXxp6+
 +2wFJxUqFjedZ2xg/CrVxcjBISFgInH4pVgXIxeHkMBuRonr03axQDifGCVuvjvHBOF8ZpT4
 v2IPexcjJ1jHmY1/2CESuxgl3q15glC1oekDG8hcNgFNiQuTS0EaRAQCJHYd/MwEYjMLHGWU
 eLSyGsQWFvCRuH11CTOIzSKgKjHleSOYzStgIfF5zmxWiGXyEjMvfQdbzClgKbFvbw8bRI2g
 xMmZT1ggZspLNG+dzQxRP5ND4tsvbgjbRWJibycThC0s8er4FqgHpCRe9rdB2cUSv+4cZQa5
 X0KgA+j/hpksEAl7iYt7/jKB/MIM9Mv6XfoQu/gken8/YYIEHa9ER5sQRLWixL1JT6FOFpd4
 OGMJlO0h0bCtBexkIYEeRolJ0xQnMMrPQvLBLCQfzEJYtoCReRWjZGpBcW56arFpgXFearle
 cWJucWleul5yfu4mRnBa0vLewfjowQe9Q4xMHIyHGCU4mJVEeE3zAhKEeFMSK6tSi/Lji0pz
 UosPMUpzsCiJ8+4weBAvJJCeWJKanZpakFoEk2Xi4JRqYLq/xPLJKZn1j97/PntQu6bCc/PF
 p7aHpv6aslLpnFDDUh7jP7p5bdNdDBfs5rqRITQ/62+b8JdYhYoZNQfexv2Ov5C23WjD9c86
 i3NfdG6daFTxaUWUtZp2Fm9BUeQT9t6lcqJ2jlaMrGqZ4loHlJsORHY4+Bg8LeHIKw83Mm3P
 Mt1+xexRzdeQypS4p9kGmyZeeFjdLSQ669xup8M9SydnnNBM1T8/p2D/12PxTbeTRCM/Wd4u
 XL7sy5QiidNxc8z2y2r+zb5q0+1t9Cky07hbt+6fx8PZBUKrsk0fbSgKae/nMV+iHb/mR21W
 XmaqS67PLTeHn5nl7RXuzjzTsmWrxH/ce/fyxCn7iCRnJZbijERDLeai4kQAEuFpS7oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvG7NroAEg5WNOhZNE/4yW6y+289m
 Mev2axaLlauPMlm8az3HYvH4zmd2i6P/37JZTDp0jdFi/rKn7Bbbfs9ntrgyZRGzxesfJ9kc
 eDwuny312LSqk81j85J6j903G9g8+rasYvT4vEnOo/1AN1MAexSXTUpqTmZZapG+XQJXxp6+
 +2wFJxUqFjedZ2xg/CrVxcjJISFgInFm4x92EFtIYAejxIZvqhBxcYnmaz/YIWxhiZX/ngPZ
 XEA1HxklbrbPYe5i5OBgE9CUuDC5FKRGRCBEomveNiaQGmaBs4wSyx+3M4IkhAV8JG5fXcIM
 YrMIqEpMed4IZvMKWEh8njObFWKBvMTMS9/BlnEKWErs29vDBnGQhcT0k5fYIOoFJU7OfMIC
 YjMD1Tdvnc08gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxguNC
 S2sH455VH/QOMTJxMB5ilOBgVhLhNc0LSBDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
 QHpiSWp2ampBahFMlomDU6qBKdlGYEHS0dOmf3QsVh1q2t305cxv7fcqAplJp7c/3PvqdzyX
 5Ls+iex/mbf425YxHf5gcVxULGR709L3X5aJ13f8tkxLvsky223C7Cc7Zif8PlLjucy6kNMv
 f+ucWfEXKhcsnqU7b4FQ+fPlaa/n1nCtUnbP+mDkHSfF8qJGVvTqfe0FyZsSTlov/xya32Wf
 9X7ZuQMHlfl+fDyvJlZcxvqoJFRqtlemy9I1TxewSCs/m5DxtPP+jpsuEgfvRv1aeSRR7I24
 9Dav7YrKVneybBxUdCc4fdkQdfSwe0q59os23ptiXTyvXVKKe0oucK1NvBZZedPinPVZxlOS
 6wsmtkYHChTODni6LsHmkExHjBJLcUaioRZzUXEiABQvSTv6AgAA
X-CMS-MailID: 20210316140236epcas5p4de087ee51a862402146fbbc621d4d4c6
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210316140236epcas5p4de087ee51a862402146fbbc621d4d4c6
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140236epcas5p4de087ee51a862402146fbbc621d4d4c6@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_140243_172345_98D04E15 
X-CRM114-Status: GOOD (  19.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_req structure originally contained a pointer to nvme_command.
Change nvme_req structure to keep the command itself.
This helps in avoiding hot-path memory-allocation for async-passthrough.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c     |  6 +++---
 drivers/nvme/host/fabrics.c  |  4 ++--
 drivers/nvme/host/lightnvm.c | 16 +++++-----------
 drivers/nvme/host/nvme.h     |  2 +-
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..46c1bb7a89f0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -596,7 +596,7 @@ static inline void nvme_init_request(struct request *req,
 
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
-	nvme_req(req)->cmd = cmd;
+	nvme_req(req)->cmd = *cmd;
 }
 
 struct request *nvme_alloc_request(struct request_queue *q,
@@ -728,7 +728,7 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
 static void nvme_setup_passthrough(struct request *req,
 		struct nvme_command *cmd)
 {
-	memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
+	memcpy(cmd, &nvme_req(req)->cmd, sizeof(*cmd));
 	/* passthru commands should let the driver set the SGL flags */
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
 }
@@ -1128,7 +1128,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 
 void nvme_execute_passthru_rq(struct request *rq)
 {
-	struct nvme_command *cmd = nvme_req(rq)->cmd;
+	struct nvme_command *cmd = &nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5dfd806fc2d2..c374dcf6595e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -578,8 +578,8 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	 */
 	switch (ctrl->state) {
 	case NVME_CTRL_CONNECTING:
-		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
-		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
+		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(&req->cmd) &&
+		    req->cmd.fabrics.fctype == nvme_fabrics_type_connect)
 			return true;
 		break;
 	default:
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index b705988629f2..5f4d7f0f5d8d 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -640,7 +640,6 @@ static void nvme_nvm_end_io(struct request *rq, blk_status_t status)
 	rqd->error = nvme_req(rq)->status;
 	nvm_end_io(rqd);
 
-	kfree(nvme_req(rq)->cmd);
 	blk_mq_free_request(rq);
 }
 
@@ -672,25 +671,21 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd,
 {
 	struct nvm_geo *geo = &dev->geo;
 	struct request_queue *q = dev->q;
-	struct nvme_nvm_command *cmd;
+	struct nvme_nvm_command cmd;
 	struct request *rq;
 	int ret;
 
-	cmd = kzalloc(sizeof(struct nvme_nvm_command), GFP_KERNEL);
-	if (!cmd)
-		return -ENOMEM;
-
-	rq = nvme_nvm_alloc_request(q, rqd, cmd);
+	rq = nvme_nvm_alloc_request(q, rqd, &cmd);
 	if (IS_ERR(rq)) {
 		ret = PTR_ERR(rq);
-		goto err_free_cmd;
+		goto err_cmd;
 	}
 
 	if (buf) {
 		ret = blk_rq_map_kern(q, rq, buf, geo->csecs * rqd->nr_ppas,
 				GFP_KERNEL);
 		if (ret)
-			goto err_free_cmd;
+			goto err_cmd;
 	}
 
 	rq->end_io_data = rqd;
@@ -699,8 +694,7 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd,
 
 	return 0;
 
-err_free_cmd:
-	kfree(cmd);
+err_cmd:
 	return ret;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..0254aa611dfa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -157,7 +157,7 @@ enum nvme_quirks {
  * this structure as the first member of their request-private data.
  */
 struct nvme_request {
-	struct nvme_command	*cmd;
+	struct nvme_command	cmd;
 	union nvme_result	result;
 	u8			retries;
 	u8			flags;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
