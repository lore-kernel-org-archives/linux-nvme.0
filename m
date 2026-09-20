Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146C8C982DA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEWXTR1kghd8H69+9xfipKsLZLRrTMB1ZhrH2/JIMpI=; b=LqAoDbGd2gAvXlBxhlrTnnGJnz
	MM0BgIDbphgHOTjlOo1pby9Ppfs4qdmW0QlIvAKBtnj2WAkQdrQaLzH1Pfu9W9RF5+PP28wnnJV2r
	YQYTgOPWaLP/Ww4N+ZdoKMsbF4pVTrO8kHMtbMON/Jvq6s4zvNT3GQtbWLaN/cv1+rMTn1uBh45pB
	3u+UmA7dJ1r8FTpFZJDosaVFWPDeny4qOb2uinwRv/AbHfqZZAQ2PkGyd5A2tv5Ya2wbkCWK4aYYX
	v71mShCH/0hsJq5QGrr7VzN+PBnkU8JMQ13xT/ry+t0yt9FD+CAsaI+JjEiMpozIu1oH2JYnj0s7M
	AmkUbHYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJC-00000000DyW-2G6U;
	Sun, 20 Sep 2026 18:30:38 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ6-00000000Dso-2Cd6
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:34 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so1547221a91.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929031; x=1790533831; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UEWXTR1kghd8H69+9xfipKsLZLRrTMB1ZhrH2/JIMpI=;
        b=dA3Hr1Hm92zhJQVgtjGQ/3LY/N8WyiTekGtpjWTQ03wAP8mifYXOvfXyiKWXvJqHFL
         l/Hv5hEOU6Bdbs7qmY8OBHeSvJIzXDaaOceR19hmBHKUnnMl+MHstmTL0TGwa+QyWZgQ
         OM86LE5AYzlf/Y9BOqlHouFCaBauGi97hf/I5WW/hxuSvq48hYvj+54WjlkemkkbQBG8
         F5Dzh7ugDzCxO5SbK3LxNoWjm3pQ3d1j4bcLbTqHRzgUBHUcMuvnS6HMhuoknnXkaqIf
         zLmsGoTDBXct2zIxwJCaY2k3n40UERFIuIeqhK655F18r85kgbJ+dD/tBmP1m0BmOA4C
         TTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929031; x=1790533831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UEWXTR1kghd8H69+9xfipKsLZLRrTMB1ZhrH2/JIMpI=;
        b=uu5N30tcq+PGSGLzy9vfRmypSL0EcCXG2EZTsvoIfFIs5IS91anPE3oAs3azrxhVl2
         QkacNizivUwhqOj+5+iOwaG9QPgLQ9eklFyIDqZxf8I7P0hJIFFdMVD0zT+zJk/XMY8+
         +qOHq3Tddw9eiEiiOEtt7bTyju796pO6kOc0XlGh1UtAQP8fHEurbWSoIYx3eWqrcWeV
         YRwekH3c+q7ILWKEw/pqyizHrKhLfFxbL0ua6NNLpKiNfUD9I2UjESoIrLVhugPG0avD
         Jjr06sNu+ka4gclZ6Q12Lcrrq4GlciU3fN/pvx3gggj52jU2azOtgZuw6vnFU5uligED
         OkgQ==
X-Forwarded-Encrypted: i=1; AKwUvBws4laENZGeoSdcGRqQyfwHkUhcPdtdC0iycg/pbPcvL9dNA19o5+VkQ6rjeRMXJnZNgs+FZCw8qAdM@lists.infradead.org
X-Gm-Message-State: AFuF++nlmWFDs3mFJeKYavfCiF7z0D6bVuehj/8cDuPOgjyvzbsXYQBU
	HVEB1zBmgf6NQ1+6RfVnNVch9DyNB1kddKPPJx/LH6wSXwMykgEt779U/hYYMGhnkww=
X-Gm-Gg: AYBFou0qkd+I8Ug9YTJ5xkPcDe8nfn5nacuMySmwrucYVNhAvwGKebu8H+dROkqMeWX
	Z/34J3LECaMvoRF7PLQikBOaeAvvUirIfOPROdLd0BxAqDlwGm4BE0WmJ8Os6isyl6Hhl/D9hKx
	BDcX+eFelUiqEgPVsxaKmmwLsISx1YJxBTIyqezR+wqaY1ckTmlf6oJ+LgvQkp/RP1SVN9TPtp/
	K5FFl68OQKLeleE4+1DebYQ3bzMLyRBUon32WlocsIhxNBaf8SmysLZJ+C6lAnmf0a2icNTtVI/
	31AfOTgWWN5226q6Op7l81hSZMPQbBzIWzGlKemhJJpqmCmgLG970yeicFW2nbUEf7fqeVDReff
	U0HRfPrOl8NFC4sA1hqgvXLn8mhf4BL4ytFvhUqozxVYEiD4X3sqZAc8BqPPXQx3/hc+mM4l/S/
	e0BD77czvhyi4GbQNm1YJzzFGJYzKC1xgFy89RJgFpEYmhSERaU5Y+3X1KihBd8x73Hi4=
X-Received: by 2002:a17:90b:37cb:b0:39e:6c69:f46f with SMTP id 98e67ed59e1d1-39e6c69f52fmr8051148a91.46.1789929031381;
        Sun, 20 Sep 2026 11:30:31 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:30 -0700 (PDT)
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
Subject: [PATCH v6 10/18] nvme-tcp: Use CCR to recover controller that hits an error
Date: Sun, 20 Sep 2026 11:28:08 -0700
Message-ID: <20260920182936.2317916-11-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113033_639011_6C464A5D 
X-CRM114-Status: GOOD (  16.29  )
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


