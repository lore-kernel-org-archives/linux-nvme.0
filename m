Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F4606A31D
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Bp5gGMg;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=L4S5w7Qi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=4PuUhSHvezLBSZJFINC4++j3AbiYAFeVh5nQiEi2aiY=; b=0Bp5gGMgTmHb5zL1A6a8H7I48C
	GWoWaqhLqFosaGVsO+XRPbB0hJzL5zsf3iYOxOHjaB1JHdYOqgMOHcr/GKdUO3KMtqY5mL+5Jjo92
	T8cpjHKgvzHATu+Lln6uR2pkdS9F7Yd8Iy8CsimexffhoTYQA7fIczhZuIMfC1PpGDpbhs1GSb4+a
	5Hrozta0tRXngp42vckiQiY1m1OwTCbERA0V3QmQxkJWDAF4qVSqzJZdTzpX64w7U2eXufvIgLFWc
	JddH44RM9FKvZTJtrNGm/WoanUstWwBxEXe65UKBzSVt/jqTlmuPjU01NJeT9MDZ8lUgL5oxCTXRr
	NGgy2u8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMiGI-0000000B9Vf-2cj9;
	Fri, 30 Oct 2026 08:46:58 +0000
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMiGE-0000000B9Ul-3JZT
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 08:46:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793349985; bh=4PuUhSHvezLBSZJFINC4++j3AbiYAFeVh5nQiEi2aiY=;
	h=From:To:Cc:Subject:Date;
	b=L4S5w7Qi2FmqMOD8kKmxAWgmKlf8cTCBypUncskB6R4EGOBtwsE6lvcE74LrkQJZC
	 mmgaKkHc9Wz6TF5Y8CGYXVBlgXwDdEViYH8YguehTyZPioK1sPZwLzClSRHApzP8iL
	 B7eK+pcLHleEiPZGA0dNfLIifL24qrI8wf7exxvI=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:5510:213f:594e:6216])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id B969DEA3; Fri, 30 Oct 2026 16:46:22 +0800
X-QQ-mid: xmsmtpt1793349982tvc9gdgie
Message-ID: <tencent_E7828EAC883D49896E2EDD4FCCFE653E9909@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7PMhUy8UoGmObr45+JzSl81wouu51VZczr6ixFLgDWGSHohfeK9
	 XOxNdZsBgHpqdJXoYPrw08Jo5IjDOrcTBbKT/VTB+osBD+kFMQkIowzwd1xfOiSV/7OrnNG7xVha
	 jI6S4hHBKZq0SnivF8SKd68OLYh4G4+037zXIhMvUtDofOaWfsQ6E8T8aCWMhA6+9y8AzXsgLGlC
	 hl3Xd79jZ4mOXv2gjXdQ3fvVw/a3dEHKRQbBnI1/Vl9OLokoB3MiidkkfE/rLnPhc6u41rvW1Wff
	 mEdC3krQC/ArtzcnWt5oG97Rxesq5f5piVfyU9VV1rY1e5mx4CiUt85EroYjmgXSKPF6CuTGfCNq
	 62v/v+xrsMUiZsmffMjcdAHPC3D2Cu5wME/oP7SOXnX3/vEVZHzzGXjuI5gkzbQIW7pGw3WcsV2F
	 CSqyrpI0ZZjnYzusuMInrorS4PpzVDgYhoPn3ZZWGwYzcjJ+DDpSEDJ5nVIIRrbUERDk7MRFZ5Nb
	 o+BNz5JAlrVdy3ND3XdPik+VrrSCzTylxwjTvVKPyKxckx7EbMuMgwipYdS3eTEhnQFg38LFLjfX
	 eJEfVRLNXF3EGJFOx+/7/3qKaYwr+vNIamsRqvIVk9HV7C0qU9qHTUGJsnAsbchnD5vlzlSLhNkx
	 2tjpOEfPHBajr+Bxqn7TwM0iX3cHqnU+u5oZoIJKhWk7Lx3/12ZllUXDRe56LXLw9sjHCfh1VIKy
	 3exeEzwQtuANFB6w2LdDV4lpNDWIQkIYxypC3ySXrUdNvOiWbAqK//6JuaVKTLvPVXOSov5f2ilD
	 7JIoObL4ACUOCHP14P1OBSDnhWy+GBZRxfEvvkM5idKOU/kZ4oCkJCLpP4EeOaUBJW26Yr723e9V
	 vABHlb87VLkoVgC7MdZ4/o3TgA4vd8AsgaBjOc25ciWd7XXw9CorzgUxtkNPWTyheqdEA2X4OHN8
	 CyGAl4FnQRXUQ5cpvGRjdD1S29SzJMsJSljkx0uznkt+CsMPfJhTTjHdjMG3qfTT2zyGyUejBbPi
	 VusrFDAgw1RDswkGYSvaBkjHX5t9nSSOSlhOGCYX/tjuH45/JWkrbDE1UZRBtJMCTxGbFFy/UmUL
	 /fCYI4wExGT+xRx96s1n0pzYrM4A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Yingjie Wang <1075151112@qq.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: reject keep-alive timeouts that would overflow
Date: Fri, 30 Oct 2026 16:46:22 +0800
X-OQ-MSGID: <20261030084622.2485816-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_014655_376546_9FBFAA47 
X-CRM114-Status: GOOD (  14.83  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_set_feat_kato() and nvmet_alloc_ctrl() convert the 32-bit
millisecond KATO from the host to seconds with DIV_ROUND_UP(kato, 1000).
The addition in DIV_ROUND_UP() is done in 32 bits, so any KATO above
4294966296 ms wraps around and rounds to 0 seconds. A Set Features
command with KATO 0xffffffff then succeeds but disables the keep-alive
timer: Get Features returns 0 and Keep Alive fails with Keep Alive
Timeout Invalid. A Connect command with such a KATO creates a controller
without a keep-alive timer.

The converted value has more consumers that can overflow. Get Features
multiplies it by 1000, and the timer paths multiply it by HZ in 32 bits
and arm a delay that must not exceed MAX_JIFFY_OFFSET.

Reject a KATO whose rounded value does not fit all of these. Return Keep
Alive Timeout Invalid from both Set Features and Connect. Validate Set
Features before stopping the current timer so a failed update leaves its
timeout unchanged. Round in 64 bits. A KATO of 0 keeps its current
meaning.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++++-
 drivers/nvme/target/core.c      | 8 +++++++-
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 26028be8fe4d8..a06cff8304db0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1227,8 +1227,13 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
 {
 	u32 val32 = le32_to_cpu(req->cmd->common.cdw11);
 
+	if (val32 > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw11);
+		return NVME_SC_KA_TIMEOUT_INVALID | NVME_STATUS_DNR;
+	}
+
 	nvmet_stop_keep_alive_timer(req->sq->ctrl);
-	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
+	req->sq->ctrl->kato = DIV_ROUND_UP_ULL(val32, MSEC_PER_SEC);
 	nvmet_start_keep_alive_timer(req->sq->ctrl);
 
 	nvmet_set_result(req, req->sq->ctrl->kato);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 956f9a552e70f..9b30a9b7a0b71 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1612,6 +1612,12 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	u8 dhchap_status;
 	int ret;
 
+	if (kato > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		args->status = NVME_SC_KA_TIMEOUT_INVALID | NVME_STATUS_DNR;
+		args->error_loc = offsetof(struct nvmf_connect_command, kato);
+		return NULL;
+	}
+
 	args->status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	subsys = nvmet_find_get_subsys(args->port, args->subsysnqn);
 	if (!subsys) {
@@ -1684,7 +1690,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 		kato = NVMET_DISC_KATO_MS;
 
 	/* keep-alive timeout in seconds */
-	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+	ctrl->kato = DIV_ROUND_UP_ULL(kato, MSEC_PER_SEC);
 
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index bd13adc72f671..9ac599d90b413 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -7,6 +7,7 @@
 #define _NVMET_H
 
 #include <linux/dma-mapping.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/kref.h>
@@ -712,6 +713,13 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO_MS		120000
 
+/*
+ * Largest keep-alive timeout in seconds that can be reported back in
+ * milliseconds and converted to jiffies without overflowing.
+ */
+#define NVMET_MAX_KATO	\
+	min3(U32_MAX / MSEC_PER_SEC, U32_MAX / HZ, MAX_JIFFY_OFFSET / HZ)
+
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
 

base-commit: 89480d137bf0d943a82c64f86ae2407a15276b5e
-- 
2.43.0


