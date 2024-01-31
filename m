Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AF6C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ub8oC5as0a4pxT2pmrANtrCZBM+OFTEuyvBahsV4K28=; b=z3CcoSoPzNMcUfh+dtWwYgymIj
	6GWYl1FArJ84FIPrYXb6MrkzOiFzYj2sYvyN5nx4iKUa7M9ydldUTLUqnfvIAZWJOeaUZqm1nRoDd
	sVoHdsmSGdbHK3X9U3cWWjyWZOFyTyIwC5GA/a904yVWxO4BO8dE/xkMXuM01nNHlqUfx0wsnbGbC
	c7HyL3nDbpqBo3mLI68Q3q9SX3sIwmxtGDKRYfb1D2djXrgr/Ks2v2kfwRsHEKg8oVCsJmKfNcy/f
	IMgkTWFttiGEL/QL+BOgPeIsPa9xZBknwi6ZdI2XjNK/8wH2yc1+dHoZyYbJbpz1wP1H+SuwRv9pB
	ZhrDCoHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDh8-00000004azm-0tMF;
	Wed, 31 Jan 2024 16:44:14 +0000
Received: from mail-io1-xd63.google.com ([2607:f8b0:4864:20::d63])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDh4-00000004awQ-0inx
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 16:44:11 +0000
Received: by mail-io1-xd63.google.com with SMTP id ca18e2360f4ac-7bfd0e99154so216381839f.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706719449; x=1707324249; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub8oC5as0a4pxT2pmrANtrCZBM+OFTEuyvBahsV4K28=;
        b=Vdl0QqPheh6j7zchf37LGO86Dkhh10Ajt32ZAC7bEA9qcP6C0ZYF97qXYJJGwBCAfs
         8psWXEjDV6hWChZovOyAuroiN5o16NjkhpejNZUzYoaBATCD6XiTe/7xpbDOweurlfLW
         jL9YBCfDI1n2aBR5/a+Di+32OO8gFcPKN05CYHtU5nXE1S2XmtALg6dhcAjHhX1jAonf
         ox1DLlDHeNcD+qlpqlE7ZrfMSohT37bDIAVnfkNgIb3CDv6mGNwTN580LhTkEmioACXV
         SO/dXE15FOeRb5PxBkVrV3vddPEldsm4wGyf6B0SjFo5Pu7wJtpLGpA+b7GFqE/qJOqF
         liFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719449; x=1707324249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ub8oC5as0a4pxT2pmrANtrCZBM+OFTEuyvBahsV4K28=;
        b=TbF+UgdJSwawF+DEfgG8x4pN1p4rn+fgGvAgNjk9RtXKyNgwyp4iSg5NHoH6JIRukv
         6RwpQjlfP9QjbYFZ1kSfASbrYY5pRmvOppYSfTROs85Jf3RXlkymz4EANH4BPFkkwHWi
         EujWdadjk59gK9KDBjwoS2ZrGvbKSoos7JU3ocTmUpTBJohq6P5ZuRKW6mVH7YhAw+lg
         cY0HzqUi8dawOJpolTOGnkSPheJX+GCKdvW78vfIp2ojLzHpJxiswg3N+Ghi2Rc0hQqH
         NVFHgxw5ZC+ddyanENvLb4N+R5gSFru4nfS1GT0MVkg5VkFIQWr5bIvCieS9D1cCBeb9
         9zzA==
X-Gm-Message-State: AOJu0Yyr0WtS9rhlQjMxgKAdlKBbKUn4eXxOYzxieYdvwjpb3wmCqYZ6
	ljchRfL35GZWcVmGznhAoM4XRyiGzYxzHUarTV3ii6qJJ+v/epF7BL5rxeI8E+AaY7lxnrPr9Td
	XoNb4wUnn2ajXSudRgnFcoMy6vrcz3tYh
X-Google-Smtp-Source: AGHT+IEagVvCPfO+HgXDZZmvSXDEa+bhNI+ldo20AKrLCEUtGea/t2tKMJGfzt6g+NUgAJak5Ea6lgwomMzG
X-Received: by 2002:a6b:f10a:0:b0:7c0:2598:5b6a with SMTP id e10-20020a6bf10a000000b007c025985b6amr1593389iog.9.1706719449559;
        Wed, 31 Jan 2024 08:44:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id i20-20020a0566022c9400b007bf31e7a1d0sm202928iow.22.2024.01.31.08.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:44:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D87AE34071F;
	Wed, 31 Jan 2024 09:44:08 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D3B34E4FE75; Wed, 31 Jan 2024 09:43:38 -0700 (MST)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Cc: Caleb Sander <csander@purestorage.com>
Subject: [PATCH 4/5] nvme: split out fabrics version of nvme_opcode_str()
Date: Wed, 31 Jan 2024 09:43:14 -0700
Message-Id: <20240131164315.160042-4-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131164315.160042-1-csander@purestorage.com>
References: <20240131164315.160042-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_084410_252192_B8F7EF0A 
X-CRM114-Status: GOOD (  17.59  )
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

nvme_opcode_str() currently supports admin, IO, and fabrics commands.
However, fabrics commands aren't allowed for the pci transport.
Currently the pci caller passes 0 as the fctype,
which means any fabrics command would be displayed as "Property Set".

Move fabrics command support into a function nvme_fabrics_opcode_str()
and remove the fctype argument to nvme_opcode_str().
This way, a fabrics command will display as "Unknown" for pci.
Convert the rdma and tcp transports to use nvme_fabrics_opcode_str().

Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/nvme.h | 13 ++++++++++---
 drivers/nvme/host/pci.c  |  2 +-
 drivers/nvme/host/rdma.c |  7 +++----
 drivers/nvme/host/tcp.c  |  6 +++---
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 403df30fc3cc..a9dcd3ffcc18 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1147,13 +1147,20 @@ static inline const char *nvme_get_fabrics_opcode_str(u8 opcode)
 {
 	return "Fabrics Cmd";
 }
 #endif /* CONFIG_NVME_VERBOSE_ERRORS */
 
-static inline const char *nvme_opcode_str(int qid, u8 opcode, u8 fctype)
+static inline const char *nvme_opcode_str(int qid, u8 opcode)
 {
-	if (opcode == nvme_fabrics_command)
-		return nvme_get_fabrics_opcode_str(fctype);
 	return qid ? nvme_get_opcode_str(opcode) :
 		nvme_get_admin_opcode_str(opcode);
 }
+
+static inline const char *nvme_fabrics_opcode_str(
+	int qid, const struct nvme_command *cmd)
+{
+	if (nvme_is_fabrics(cmd))
+		return nvme_get_fabrics_opcode_str(cmd->fabrics.fctype);
+
+	return nvme_opcode_str(qid, cmd->common.opcode);
+}
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 25eb72779541..e6267a6aa380 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1347,11 +1347,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	opcode = nvme_req(req)->cmd->common.opcode;
 	if (!nvmeq->qid || iod->aborted) {
 		dev_warn(dev->ctrl.device,
 			 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
 			 req->tag, nvme_cid(req), opcode,
-			 nvme_opcode_str(nvmeq->qid, opcode, 0), nvmeq->qid);
+			 nvme_opcode_str(nvmeq->qid, opcode), nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		goto disable;
 	}
 
 	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3f393ee20281..6adf2c19a712 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1949,18 +1949,17 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-	u8 opcode = req->req.cmd->common.opcode;
-	u8 fctype = req->req.cmd->fabrics.fctype;
+	struct nvme_command *cmd = req->req.cmd;
 	int qid = nvme_rdma_queue_idx(queue);
 
 	dev_warn(ctrl->ctrl.device,
 		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
-		 rq->tag, nvme_cid(rq), opcode,
-		 nvme_opcode_str(qid, opcode, fctype), qid);
+		 rq->tag, nvme_cid(rq), cmd->common.opcode,
+		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
 	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4393cf244025..9f8dea2e2c7d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2426,17 +2426,17 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
-	u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
+	struct nvme_command *cmd = &pdu->cmd;
 	int qid = nvme_tcp_queue_id(req->queue);
 
 	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
-		 rq->tag, nvme_cid(rq), pdu->hdr.type, opc,
-		 nvme_opcode_str(qid, opc, fctype), qid);
+		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
+		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
 	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
-- 
2.25.1


