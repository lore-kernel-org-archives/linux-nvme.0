Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC327C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 06:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zB7Zvmg0oPAbigvUomwWihP9uTS1AqJkb7qwPu6AddU=; b=YeMXEZxg+oMOHuIuQzWnJADRKr
	4YjJIu0otsr4N6b72jIDBAygZOzo7OkMziCOCVEpVtNgoOhJv0QqWj1emU0jniZ4c5ZHi/2D3fPmP
	NCIC5tK+HCacsaDoExUJiaLV5gAkKCLjuCP8uRACpCUzFUI335FC5gppToZKlMFe4iCOa4enzQedD
	6Uz98YApw8zxu/xD4HW6csaxuEFqvdESvYyU1vV8mP732ohOvjhJQ4JjtsEefd62Erd3DNsIEq9xM
	4PpIm3NlMa2fUG/ciZyMOwRzAUJOcGFTM4+ve3+8RTTEACVDm8nmlUwJpzVJTegEolwr4UL2n+obK
	EvSTrG2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGuJO-0000000897k-3TuE;
	Mon, 19 May 2025 06:49:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGuJL-0000000896l-3vc0
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 06:49:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3662C4A2BB;
	Mon, 19 May 2025 06:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72560C4CEE4;
	Mon, 19 May 2025 06:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747637359;
	bh=ubiPzdhHtwUIKQDyq2HfKvACyXCQ/SQ/l6LCBwa75cg=;
	h=From:To:Cc:Subject:Date:From;
	b=DSZvsSCts6prbFqM1yU2ucRu9Ia2V1LL/ORClyyqN5N2zGsYWOn6la3q1kCJTqB3t
	 TroucpjsujL6SmfdPD+/ZFS+AvUT7l6P1+ReUiLBoZiSnaitzDZ/5/4GOlsgjc+di/
	 2H3FWaKy/I+t1m1GB4dw/nwg5wjUnqIdVloRsRNrqiO2RwGV2C2+zQcf1XdMyhBUV4
	 JLiaKXnOXIH1AYVRniEnEhJx0zgVvVMKOKm6Pka++x8DLt9/8CDt3gGf92NJp37B3v
	 zdz3A+q+SiTh3YnIEzPRIAi6ST3YHMfbCIjfMuuqGnVyPo2Qzf5PUDDvXMQAdGpHWq
	 oBLiI7ah6zdZA==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme-tcp: fix 'quiesce' imbalance for the admin queue
Date: Mon, 19 May 2025 08:49:13 +0200
Message-Id: <20250519064913.114188-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_234919_992902_1B2C88FF 
X-CRM114-Status: GOOD (  11.72  )
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

From: Hannes Reinecke <hare@suse.de>

nvme_tcp_teardown_ctrl() calls 'nvme_quiesce_admin_queue()' before
calling nvme_tcp_teardown_admin_queue() which also calls that function.
So move nvme_quiesce_admin_queue() out and require the callers to
do it.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9289bba54c82..8aabccb782f3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2318,7 +2318,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
@@ -2407,6 +2406,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		/* See comments for nvme_tcp_key_revoke_needed() */
 		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
 		nvme_stop_keep_alive(ctrl);
+		nvme_quiesce_admin_queue(ctrl);
 		nvme_tcp_teardown_admin_queue(ctrl, false);
 		ret = nvme_tcp_configure_admin_queue(ctrl, false);
 		if (ret)
@@ -2473,6 +2473,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
+	nvme_quiesce_admin_queue(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, new);
 	return ret;
 }
@@ -2516,6 +2517,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
+	nvme_quiesce_admin_queue(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
-- 
2.35.3


