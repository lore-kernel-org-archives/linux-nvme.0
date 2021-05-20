Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B57C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 11:32:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68F36109F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 11:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68F36109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8s0DiXT7WQbj+hqpfoLLPbE3uk7oOhquOxkIppdSn54=; b=rWEctgOYKuXan69sg2a7FAp7Cf
	PIS0vjGAdkEx42JCfINyhD+Bskhg85kZ9P6VmInUpzBqYFn4MminY94rbnPhYhx4/mFXDVNnK+eee
	/ULDZOe/jPVjcnj9WYLVmGMw2B6LSgPH5KhpKkpaCHs8wbx4jNxdMp8xPxD/P2ovHkCjpkes9/Po7
	Yh2GlsEFYCvtdgCz4mPcIQF3z0DaSDFJ6gK7bdvpkkkShl7nk8xGBkZ53+X25Q6gBt03LzskRx6OX
	eqZoMIoCn8bz+lKghiD1EHV+s3mf1pSMyY71hJmXMY+XXhN5JQs++Io4+Bi9MOVU7WMQTg/fF6ZxK
	OC4Oe4OQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljguA-000UUd-CK; Thu, 20 May 2021 11:31:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljgtj-000UMv-Vx
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 11:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=YuxRI1j45hbt4wRZUBatLhNK3igtwoQ0HB8xhWbIlR8=; b=S0AW1sHZHWolAoji+5w4vahmVK
 037CekOB84dLrLdPMAeQUyWoAd1cuSgreBTDKMhQxhrra4UavjwZ1vZFZXhefcLzHl6R3S21b24Sg
 5bz0tqeYpwfvOfChmkOc/w7/ow081wl4EhVk+s8m+x+WoKP9eq5CRyXHM0e3DVHwsBYxU0e00v3Gi
 UHDHDVC/2bW2qQmApX8NTfXbg00GlFUBQrZCXxW6GqkKnvSBoFtgNA2CHywYL2RJ9eUoaVi/haJHs
 1cqevK+toDkmlUD7ElbhI2TIwBvP9CIksjS2EDfquNNnWLneD7tt95w/Z6L4BkMwRD+zlCPb5PXaU
 E8tAoVkA==;
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljgth-00GFas-AU
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 11:31:26 +0000
Received: by mail-pl1-x634.google.com with SMTP id 69so8857769plc.5
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YuxRI1j45hbt4wRZUBatLhNK3igtwoQ0HB8xhWbIlR8=;
 b=ajLfJmEDIDeK4cdaZ7L25i0QazJ237a6XfdEKQa3u+33APUP8hWA1qcFun+fJO463q
 XBwjR34bOD6VhycJArEQ48OzklpeX32lMuyoga30nhcB/Kc4Evx8NofTqTB84zsQFqmG
 cR9LcXecHLUncn3rSjavnc+1/NFvx+ebQwaKiXCQzdbXD6W7IdAoz0S+CIoHfHb3lVqI
 TE0vR7s20oABRzq30XSxp47pUVFYNX7qIG4lDMB0KUsJtt8lRBopNlhunwLvnGLgmPsJ
 6Cn7T2Gy3gv9gSD2L1I7gnmTZ52zcstEOPWcrx07VTTpzFh5QMsK3AsK3zKgxzs3STHQ
 a0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YuxRI1j45hbt4wRZUBatLhNK3igtwoQ0HB8xhWbIlR8=;
 b=YWHshc1JGtcTxWlTfkUVcCUgIAwT4R5XPhhxxa96CdMwnUX/amolPSfT642RJX7fXB
 3U65xIgaasdDo+efd+/aIlIMjXf5MGw9YnnkR2X4t9IjnF+Zc8TOPt9KrPQdt/6bqicR
 Ekqxk8LdoMdpjr3HXh+5PvTxKH+pYF6pv9hBpoDmbGoSfILtElswnmO9t3gwy2c74OjG
 XJVxdvH/cBxzxpQpM/g1+STMkHGFkrb6UgnK0/GUmu0WCxhbIjWFSg3T9WHL3VlGMfXG
 QYq7cJnGYdGKVNnmxUcnlffHkdz/39W/vmCjPEumVETjefrQQdNGNlf5aCjbSLJOEsdb
 sM4A==
X-Gm-Message-State: AOAM533xEve6wWk++fspXrbiPWCZ7RDdcfXYSH3YYKwRicb7itGIerlF
 0Ffl6yVrIpACJiL+Dm+Wq1o=
X-Google-Smtp-Source: ABdhPJyqtWytdqCp25I+3Y0We/DX3rKMu7TyanppgrBZlFUtrI3S37UHt5isrjmuMtsyLU0klaEUWA==
X-Received: by 2002:a17:90b:1c0b:: with SMTP id
 oc11mr4415487pjb.156.1621510284834; 
 Thu, 20 May 2021 04:31:24 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id i197sm1917443pgc.13.2021.05.20.04.31.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 May 2021 04:31:24 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, houpu.main@gmail.com,
 larrystevenwise@gmail.com, maxg@mellanox.com, elad.grupi@dell.com
Subject: [PATCH 2/2] nvmet-tcp: fix connect error when setting
 param_inline_data_size to zero.
Date: Thu, 20 May 2021 19:30:46 +0800
Message-Id: <20210520113046.27821-3-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520113046.27821-1-houpu.main@gmail.com>
References: <20210520113046.27821-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_043125_382451_2771855F 
X-CRM114-Status: GOOD (  19.81  )
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

When setting inline_data_size to zero, connect failed. This could be
reproduced with following steps.

Controller side:
mkdir /sys/kernel/config/nvmet/ports/1
cd /sys/kernel/config/nvmet/ports/1
echo 0.0.0.0 > addr_traddr
echo 4421 > addr_trsvcid
echo ipv4 > addr_adrfam
echo tcp > addr_trtype
echo 0 > param_inline_data_size
ln -s /sys/kernel/config/nvmet/subsystems/mysub /sys/kernel/config/nvmet/ports/1/subsystems/mysub

Host side:
[  325.145323][  T203] nvme nvme1: Connect command failed, error wo/DNR bit: 22
[  325.159481][  T203] nvme nvme1: failed to connect queue: 0 ret=16406
Failed to write to /dev/nvme-fabrics: Input/output error

Kernel log from controller side is:
[  114.567411][   T56] nvmet_tcp: queue 0: failed to map data
[  114.568093][   T56] nvmet_tcp: unexpected pdu type 201

When admin-connect command comes with 1024 inline data size, in nvmet_tcp_map_data(),
this size is compared with cmd->req.port->inline_data_size (which is 0),
thus the command is responded with an error code. But admin-connect command
is always allowed to use no more than 8192 bytes according to the nvme over
fabrics specification.

The host side decides the inline data size when allocating the queue
according the queue number, the size of queue 0 is 8k and others is ioccsz*16.
The target side should do like this.

Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/tcp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d8aceef83284..83985ab8c3aa 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -167,6 +167,24 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 
+static inline int nvmet_tcp_inline_data_size(struct nvmet_tcp_cmd *cmd)
+{
+	struct nvmet_tcp_queue *queue = cmd->queue;
+	struct nvme_command *nvme_cmd = cmd->req.cmd;
+	int inline_data_size = NVME_TCP_ADMIN_CCSZ;
+	u16 qid = 0;
+
+	if (likely(queue->nvme_sq.ctrl)) {
+		/* The connect admin/io queue has been executed. */
+		qid = queue->nvme_sq.qid;
+		if (qid)
+			inline_data_size = cmd->req.port->inline_data_size;
+	} else if (nvme_cmd->connect.qid)
+		inline_data_size = cmd->req.port->inline_data_size;
+
+	return inline_data_size;
+}
+
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
 {
@@ -367,7 +385,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 		if (!nvme_is_write(cmd->req.cmd))
 			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 
-		if (len > cmd->req.port->inline_data_size)
+		if (len > nvmet_tcp_inline_data_size(cmd))
 			return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
 		cmd->pdu_len = len;
 	}
@@ -550,7 +568,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		 * nvmet_req_init is completed.
 		 */
 		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
-		    len && len <= cmd->req.port->inline_data_size &&
+		    len && len <= nvmet_tcp_inline_data_size(cmd) &&
 		    nvme_is_write(cmd->req.cmd))
 			return;
 	}
@@ -907,7 +925,7 @@ static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	int ret;
 
 	if (!nvme_is_write(cmd->req.cmd) ||
-	    data_len > cmd->req.port->inline_data_size) {
+	    data_len > nvmet_tcp_inline_data_size(cmd)) {
 		nvmet_prepare_receive_pdu(queue);
 		return;
 	}
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
