Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E119DC19F21
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 06:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g58vfnkiOqWa0Ry2/65NJuZr9xR9ldWJtf1fY9NM0y8=; b=sLtwxCt/cqUOamj0qmROexLumr
	xgji+8FYEabNDuujwOq+KcZ/hwnDNIVD1bONzSVayuKYN2zXxskYZZfJ1Pq0X/pXWtTqWk8TQI8zN
	IB51phBRkYhG/13QF4Oh1A5CH9X62c+X0yATvBjP6JUsu74e8+L0S/Jl45GBb/j7IwTrHhRba5x8B
	Rx+Kh0c+Jw/P7uXugUhBNaWCv2d6URh1qYdWlW02Z85jQ7jDgkPgegcoLPElq23IWzgOBWpxE6NxX
	mzlAHgCbaiFxGOP5Fx9PXYo89bqgZQ/lACWm6lbBD3vrADejfA4b0BPX+jxFEpz6yv3SlDvYTD6rF
	uUeva8Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGaGz-009oXW-IF; Wed, 27 Jul 2022 06:11:57 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGaGw-009oQR-R9
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 06:11:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 931D6345CB;
	Wed, 27 Jul 2022 06:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658902306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=g58vfnkiOqWa0Ry2/65NJuZr9xR9ldWJtf1fY9NM0y8=;
	b=CUQy+xr8WGAw7uYz5hg3iiyOo/42xTUB6/hPF9BFksaZYAyX4i9Ok/LrV5mCwPNyCyaX5M
	ESzeKdKR9OhZI0/p+TUZKLmMuxKYycjAW/rinSAeXB7GREBvc/iuZ3O8+zDJdb7WdPlSMH
	d3qEdD8g3G20omqLTp2xxhmDpnR0N1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658902306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=g58vfnkiOqWa0Ry2/65NJuZr9xR9ldWJtf1fY9NM0y8=;
	b=G7avAJV3t+mC21QuLhX5Dwgzwmk3AtGiR/XwrQzqYomZVmZJ0Q3lOcV4T556fB/1aAvZzf
	k/PSlSMzDNIPq7Bw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 6C89D2C141;
	Wed, 27 Jul 2022 06:11:46 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 55B3251A5DB6; Wed, 27 Jul 2022 08:11:46 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme-auth: retry command if DNR bit is not set
Date: Wed, 27 Jul 2022 08:11:44 +0200
Message-Id: <20220727061144.54203-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_231155_072243_709B086F 
X-CRM114-Status: GOOD (  13.37  )
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

If the cqe returns a status with the DNR bit not set we should
retry the command; otherwise we might incur spurious failures.

Reported-by: Martin George <marting@netapp.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 9 ++++++---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c4498..18f3765a387f 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -53,7 +53,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	struct nvme_command cmd = {};
 	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
 	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
-	int ret;
+	int ret, retries = nvme_max_retries;
 
 	cmd.auth_common.opcode = nvme_fabrics_command;
 	cmd.auth_common.secp = NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER;
@@ -67,13 +67,16 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 		cmd.auth_receive.al = cpu_to_le32(data_len);
 	}
 
+retry:
 	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
 				     qid == 0 ? NVME_QID_ANY : qid,
 				     0, flags);
-	if (ret > 0)
+	if (ret > 0) {
+		if (!(ret & NVME_SC_DNR) && --retries)
+			goto retry;
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
-	else if (ret < 0)
+	} else if (ret < 0)
 		dev_err(ctrl->device,
 			"qid %d auth_send failed with error %d\n", qid, ret);
 	return ret;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2429b11eb9a8..21f0fd5e1ce7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -54,9 +54,10 @@ static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
-static u8 nvme_max_retries = 5;
+u8 nvme_max_retries = 5;
 module_param_named(max_retries, nvme_max_retries, byte, 0644);
 MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
+EXPORT_SYMBOL_GPL(nvme_max_retries);
 
 static unsigned long default_ps_max_latency_us = 100000;
 module_param(default_ps_max_latency_us, ulong, 0644);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bdc0ff7ed9ab..ddf42cdb19a7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -25,6 +25,8 @@ extern unsigned int nvme_io_timeout;
 extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
+extern u8 nvme_max_retries;
+
 #define NVME_DEFAULT_KATO	5
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
-- 
2.35.3


