Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EE9C982DF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEWXTR1kghd8H69+9xfipKsLZLRrTMB1ZhrH2/JIMpI=; b=uPD4Hgu5McjhFjPPYInMQu840N
	EZqusASFs+YvZJOh0xGb13F8XCpXU7VZQGVvhtSOGTykxzV50LzrtBB8DpizuVziGmlOBgdbNAH7+
	OMaGBmYkniK1OvGDbV9OsV2aWyNnMPtROKuSsDuaiFQAVmXx95dBAefNmCWrzCNaebMLFOc0TzCxF
	cMRyPoCN9ZI6okGsY6rzctxAhe8zfAkxRlyUJzoIVPnebPLXeDpUgj1fnRitDnj5sTVI9/wvhQgoO
	66TtT3FacNFhEySF+Ir+q44nP/Qw0Olxd7RF7NNur18HjJ/i2CwhvdQ96IlTrWkXg9FAQvgxlB7rI
	BhZU1o7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d99-0000000FHDU-2PF1;
	Fri, 18 Sep 2026 18:17:15 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d95-0000000FH6C-3Pvn
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:13 +0000
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4c3304784so901981a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755431; x=1790360231; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UEWXTR1kghd8H69+9xfipKsLZLRrTMB1ZhrH2/JIMpI=;
        b=G+oVB3Q+IrJIl1fFtRPFzLkPocpQaM17tH+Pq5Fn7jkscrfs4f4Sia0XAO0iRHp0uV
         xG1QXdittP6mau9h+srXe4g8l6v000dgs9uy5+8bHsXlCz4rZYXmCcbZoP3wczFkduBl
         mZ17y8Y+iLJGR9Dn7mRllvWyXhkV3GH8phEphe2dQ6eLTyOQwV0FgSzJKPDQJ54j2XLv
         4htdU5YXVARF4G6ETaTZ7ytytX8DN7daCFY3ZlaS89uZHQTyhfoj4upS9ZRYm+fOqaPQ
         AOQLT+UGHqpgaG8YqNbremOXc++wHn2f8q1NjskILgO/LfHP8KbsNxERuZZvpEVGcxVf
         Qecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755431; x=1790360231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UEWXTR1kghd8H69+9xfipKsLZLRrTMB1ZhrH2/JIMpI=;
        b=gXRbIt6jYFWLh3yAx+f0I1jdW78xdUbGFN8cREU+fzyD+GbkJPVe1adKIPbA4Vh71p
         WY8+1Yo5FqxsXAAr+ZxvUE+SSIw5Vpf9GDhn5SrEnKWYqsaQt1sIyJ/7wVecIgF4xRgV
         Nd7ErqHx+Q0tDkhrETsq0R/JEQ2N6fOI3sjykQbWXCaevadd7FLvMScStOfJYcus8HTn
         ICkvqa/Nq9XIEnXUnH56ylO8bzcwCUNb2EdH6e7XJevYCV5oR785ia5BaqMUPApJu91j
         FjxKJlK5X2rwJRhopUpt6O43Qwj93B3RvQNU8Hed7NE8ilr86LajeEVz1O7k7KTJ3djj
         XW4Q==
X-Forwarded-Encrypted: i=1; AKwUvBx0bINxF30DSGkUjwKqRJ8PKHDzbP4JG1Z9EucE17uJdpOSraTar3gKjxrQXfxM48h4QsXkwtZxRfHl@lists.infradead.org
X-Gm-Message-State: AFuF++lVpvc9gGZDAWG0nEQx178zYT5Gb3Qq7NUEugTFjaYybxmCfGPo
	dvqmEPtj+Fj4tsgifGc93iOoeQi5y+pP82ABoJKcOz0YLo4FzBK+j7isoOxiX6QzZuU=
X-Gm-Gg: AYBFou06wxNLgYByvThkmX7FxszhSkH+3JERydS51bNSvqBROm3Z6uVqEh1kErThzdq
	GIoBlWABuP6g2lMU0DmoFhpYosidz6oE6KJvD2PHEeO58lcwFRNJZvYMmFnaPAgjeAlA4oDhwHs
	XJWN/lMknaxDmRo2raTr6aC8VcW96CT1gJVJjADH4mOhwPrA4uUwFThmFVDlpvv8926Z1+DjeGX
	Za0XHdpKoWXStDDILqd7sV83aEmlMVZom+VVewQ/qdFnEWE1DNCjyShpOjDFCPFRjvdud+KcXTp
	nO9/ptiz85l/er1/A2GiqNTJr6ZJ62btdNYY1+6DwKTcuEj4gAoXAhMcm37+weoYYPXodlsdCPi
	/JXglLgXD2wJ6s5ozavG8dacJaVZW5kSUBIh9XtJySCAJkqCXaovo/LisfQ4CUZbdL7DeQ5wunn
	gVmTm1W1TsRutWgGt6aioRYJNOmSXl8h49QQ9WOptFkuHlnnWkprVP2TcV9W5dnTx8RRqNu+845
	CpnBM/NsTN2s5YhWYW/pA==
X-Received: by 2002:a17:90b:4cc3:b0:39e:6a7f:eeee with SMTP id 98e67ed59e1d1-39e6a7ff08amr1968530a91.19.1789755430699;
        Fri, 18 Sep 2026 11:17:10 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:10 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] nvme-tcp: Use CCR to recover controller that hits an error
Date: Fri, 18 Sep 2026 11:14:10 -0700
Message-ID: <20260918181614.3947933-11-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111711_862472_2C06389A 
X-CRM114-Status: GOOD (  16.37  )
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

An alive nvme controller that hits an error now will move to FENCING
state instead of RESETTING state. ctrl->fencing_work attempts CCR to
terminate inflight IOs. Regardless of the success or failure of CCR
operation the controller is transitioned to RESETTING state to continue
error recovery process.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b..febbe8954473 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -167,6 +167,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -616,6 +617,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 {
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->device, "starting controller fencing\n");
+		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
+		return;
+	}
+
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
@@ -2558,6 +2565,22 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_tcp_fencing_work(struct work_struct *work)
+{
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
+			struct nvme_tcp_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
@@ -2633,6 +2656,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
 	flush_work(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 }
@@ -2731,13 +2755,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_command *cmd = &pdu->cmd;
 	int qid = nvme_tcp_queue_id(req->queue);
+	enum nvme_ctrl_state state;
 
 	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+	state = nvme_ctrl_state(ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -2996,6 +3022,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.55.0


