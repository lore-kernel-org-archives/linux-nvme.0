Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153FFEDF17E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6Jiwb+wqf39+Dhp+Oi0BJKLILh8l4FLgFLnd5UIyDU=; b=1iDRHwoqD0mPFYQhNI4C2MHrcJ
	LhbfuZbXHXZY97que1B1wL1ilxEeEm+w1VUL8U13Z8H+z+51Ok/Yc97sLeaAVkFnzLUdp+niRdd3t
	MPOyVL5u1f1S7d61Sth+XdhB641SYIpWfhdYOJU0KxY2XTY76JmeqseHGxgO5eMIYI/fCrUPHNSHq
	urGbHnSVcQ0WWiTMZW7166//TOfc8Sij1HN7TKb0sK0M5qzWXKtWH05uSAalNf4woLQ+cwdGJJDgj
	NQecB4mQ6BiSO9MCjSTwdDdTHZGScSoDLvKdkb+A0EW6aBhtC1sZXEzVEZbCjjkShrZQBXmwJBy7W
	nkweaZMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gk-00000004F9H-3uZa;
	Sat, 14 Feb 2026 04:28:34 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gg-00000004F1R-0zoX
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:31 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1270adc5121so2322011c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043310; x=1771648110; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6Jiwb+wqf39+Dhp+Oi0BJKLILh8l4FLgFLnd5UIyDU=;
        b=UeCUDsoIWHnq5IP8rvcOXKqkgf04frWvFgenBxMKnoexebrbaPOKlDmxb+7jaKjyFv
         GhXQ2zX4XEuEU6HHUyQ+tBGzo6KLm/U1JbLO87WSsqNnoOWIVfEEjPbq/Gl4ovFVXZCP
         ZIfwzl+Nw1TxtCiLNROQM/p3IQVzqEs+Wmyd1PWhB/KlXUUZLH6jl6gnXNLGONy5buOn
         L3yD2NDP4+2IhABE1xYVE1biK9xAVET7TMBnURs4Xtb4zx24m+677vcvETAROiycuTZi
         iGTOLW5MeyiZuAXFr2lNHus8cdPC0mf5BhSxQkM9Fe0GqqhGoQyIEmzK17rMzfsVAUc0
         wUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043310; x=1771648110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6Jiwb+wqf39+Dhp+Oi0BJKLILh8l4FLgFLnd5UIyDU=;
        b=HkLlYaslbZeT6WUAjH4Zw2uXBec9ndvZj3unknJwhsAVi+Od7HwSCoYVI1DS95ChLn
         8bT5Sgch3G2tCrxqjL2oVFAasr0zxFl/k5F8lYonAddwbccwW8iDLYYIrUbGf7qT9NUi
         lUajaSHTUhf+1l75dIn7UPskoHxqhWQ3KeDPhilXQK+bdoVCxNsziSGbdevEpftH2axq
         wv4Ych17N4M2Awz4UDe94dqtLjx1CAkSZXunZ9v+8HrFNgDypjsMkL70GxBSgDZ8Gd+J
         c26qlgnjN3A32aR2ie3iDbyFofdxU+R1MQm0QjOzCqwrtQcTGRMon8t6OZnObX1c6CXn
         DdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCURpU+OhNksEsxxh0CfWSxpBOn6YX0YY15iSyqtIDlbr36ebN9JwrVo5vrISOFJZMaCfiqmHqvef8PO@lists.infradead.org
X-Gm-Message-State: AOJu0YwhUpRNmdGOx4K1cn58a7rozgAGnWUzpjOmRjE44faOHhGgugrG
	iST1PKZVl6z/+3CFuKhMcPNXlwV7W2jNVprH6OlhTpiZVmyig97WKqfXkUX3ny3MDiE=
X-Gm-Gg: AZuq6aIATeVhKbzWk5rJFDX3rIe1V+hZgRxN8Cr5Bn0Addv6LFgelCGnlaFCY1BSqOE
	WNKCJTn77bxBjg7Xs8zmNpBGWPE6nKo+y/XEfyHPCzIUaj06EEmoRyQNZI3OwUS5tEDpECG7JX6
	3cOdndeL8P9wCsisFpNFXo7ck/sbxJpMPWr6wugedZXcR9zkZeS4rfoWRza5mohtdU2pdWmrnd+
	QZ63f0zOnVV8ibJjHDmWQYG5Hu0C8ntmL6OtE5JDHU8qBX7OV5kx3pXqEJFlVh5HJGFuTHY863C
	Wv0CyzFOAUqUWoT3gcpw5fULmvJT9hSjP5aCxmquEID1KzKKc34NeGTS31bH3iJDR1JtZY7yhVT
	F7OPdmL+0EtoWAuve01hCEfFrqJqAu6OEfmgpwoUq2C6I4hUXUQZArfxODyQQ6W1jW1kP8XsuZq
	SHVBs2VA/cv4XeKe9SbDtvUu6rNsxDjcvpp3LGg9bVQVLxQw==
X-Received: by 2002:a05:7022:6191:b0:123:2ee9:d1cc with SMTP id a92af1059eb24-1273aecf0e4mr1790771c88.48.1771043309383;
        Fri, 13 Feb 2026 20:28:29 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:29 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 10/21] nvme-tcp: Use CCR to recover controller that hits an error
Date: Fri, 13 Feb 2026 20:25:11 -0800
Message-ID: <20260214042753.4073668-11-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202830_287012_1CAAAB60 
X-CRM114-Status: GOOD (  14.46  )
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
 drivers/nvme/host/tcp.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..229cfdffd848 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -193,6 +193,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -611,6 +612,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 
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
 
@@ -2470,12 +2477,31 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
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
+	if (rem) {
+		dev_info(ctrl->device,
+			 "CCR failed, skipping time-based recovery\n");
+	}
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
@@ -2518,6 +2544,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);
@@ -2643,13 +2670,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
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
@@ -2904,6 +2933,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.52.0


