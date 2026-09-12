Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A533C88E45
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2026 05:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qckB9LNa3JhbaBuwM5JiRvIMbAmzkycMcDwtsjXKuIQ=; b=FlamtHE3AbWPItCtftMrFJBQS8
	7JFi7U4Abv5NWkB4ZM//0rv5zCtk8pbCWQZD7yB2hCTTI5OhL3BOQxBdpJaRl5JT/DQegE2gHv6X2
	yIrAZA/uxAq49PiZWVrf0mc2ROKnesSknxftP3EyhCSXpoc2zh/JS8KQRg50okcNux9aUieMCe8S4
	R2xHC0AraQh+ESmp5+18AMZdTOfNYGfsuSX3873mo2wv7kW8b9uYrX+ZnKU/BZtcP94I63p12P444
	2mAStJ3wlCXUXUs9SO5YGcfHsHyYkF7GODPvtZuWpCG93ZBZuxmb6IRo0A+917Z2bRPftx7c9MKxr
	8JKezKYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5GSi-00000000YpM-0jGG;
	Sat, 12 Sep 2026 05:39:40 +0000
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5GSf-00000000Yoe-2wYT
	for linux-nvme@lists.infradead.org;
	Sat, 12 Sep 2026 05:39:38 +0000
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-52fb766bfd3so6768321cf.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 22:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789191575; x=1789796375; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qckB9LNa3JhbaBuwM5JiRvIMbAmzkycMcDwtsjXKuIQ=;
        b=s5UFkjP4hUoFd0O/X6k1OOrWXSMZewVMT5u+7xdVTwGH6a9+5vfdd51ZxDvIe58B+y
         oAJv2fhFy4yK82QLt59htPw8idOiYquShjRex++kUvQJdqlPoL6I9sstizYlo4qfJnnL
         5LiaFL6aLLGfgAL2a+1tXh4fjCO5Yn/g8TEPqL9oFrK6rYA59mfRt0Uq0edoWnlHQIFC
         XTZPT3RcYpnkCq2RGLz9A9FfrqNJ9hN+XuIXj/+9aHOkfzGIYjJxD7sFmqpfQiAZlY3F
         40VOtAjZGO7dZ9QAPIUgpwo8S8ZGZMF7b27OJLBPrp1/naxYAAgFqaMIQ3Hvz/Mq35U7
         Jd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789191575; x=1789796375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qckB9LNa3JhbaBuwM5JiRvIMbAmzkycMcDwtsjXKuIQ=;
        b=QQwVN4Q0ewfBLV9LoAKD0Lv6om5cWQW/4aytD0ogL/09MAmbamyiNe7wdWftvPSLBX
         2puWXEm6e+heCvXH5p1mTlSnek5TlbVcAhcbMyA4OTdO2YXk6aSqcTaYuMRghCJzUZj3
         jZOCj695I6BfAopVm5pA+kpXz8XpbXuz5SpeiW3KiQ35oGdNF6yoeWk3cPrAe9hGAWra
         Q69pKT42p8k+kiZDOUZV1CcfCcZcHgDbhMKgMkUpONCgd8CuiNs6xJLAXHTENkvxO6c4
         oKlGDiNuQ3Cr8nrh2QwisRFK6d2YfL2lhqbfYYd8PQYFFkpuuCiahbzzKh55hE0aTig4
         /UvA==
X-Gm-Message-State: AFuF++k3+jiurVrjtw/6/LW2jn3oevh/HkNDOPyQwMYNMphC5Rd1qFA6
	cEdTtkQ3skCYOZuk1G0B2nUBPXJoqFglHEETXpPfuO3cQJdDY10qXj9hzFu5Xw==
X-Gm-Gg: AYBFou28nAlO5DdIDS/pGIQVcCqWUGubiTgtB4HzN6fStLOMJNv6DDWQN4BoY5tJQ99
	TVxKiDnCEFT3ASHyLPwILdl9wNfXeas//axN+Yxq7AYkqt1CzKgDJYbt24m6nq0LZK6BMl8hqtN
	TRJhliQ+JwFjEJt157bOm1ekfepqn3vYP9B9wBwC7z0j2RLCagDpdLa2U8kS7bAlQg/hTEf7yyg
	pndwnUp/m5i0MHvLW3gNzVtPuBpOs2nDHnNViGbI1FodTcl6G+l7NanIfAOAF8eWKld8Us6l+7+
	dpT7tmPAfm3wVZqHVsOQ+7Rl7pxFD8970KQST93HICmQo7HCjSATBhqlqtCQrrrMmFl7CjDg0Xq
	2olz7nbXRlrbNyF3HCKBrNVHibnMugCm/609DGYkRfcpq5tOblmXuR/Rdpnv48uWG4RoA76L5cY
	Cyh1pui4yCCrFCnW11VulYYbf0LG5IbRgVYrBNb/U2kTFLCqny5i5d+EUmlmE4VGP+z8rvXOtgY
	Uvwkbidg0Xsw6E0W1zzN2HD2zawUPp8d2+wa+GqCiyvoE6Wmw==
X-Received: by 2002:a05:622a:449:b0:530:b2e3:86c3 with SMTP id d75a77b69052e-530c878a9c0mr125432321cf.53.1789191575466;
        Fri, 11 Sep 2026 22:39:35 -0700 (PDT)
Received: from shivam-EliteMini-Series.tail1fee36.ts.net ([128.230.213.33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca47efa2sm38400961cf.11.2026.09.11.22.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 22:39:35 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Greg KH <greg@kroah.com>,
	security@kernel.org,
	stable@vger.kernel.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>
Subject: [PATCH v2] nvmet-tcp: fix a hang on queue teardown with data digest
Date: Sat, 12 Sep 2026 01:39:21 -0400
Message-ID: <20260912053921.49151-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me>
References: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_223937_748532_78EA32C6 
X-CRM114-Status: GOOD (  13.92  )
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

A command that has received all its data but whose data digest is still
outstanding is stalled in NVMET_TCP_RECV_DDGST, where
nvmet_tcp_need_data_in() is false. nvmet_tcp_uninit_data_in_cmds()
therefore skips it during teardown, leaking its submission queue
reference, and nvmet_sq_destroy() then blocks forever waiting on it.

Release such a command in nvmet_tcp_uninit_data_in_cmds(), and reset
rcv_state after that call.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e59810175262..3bf344b184e8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1608,6 +1608,11 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 			nvmet_req_uninit(&cmd->req);
 	}
 
+	if (queue->rcv_state == NVMET_TCP_RECV_DDGST && queue->cmd &&
+	    !nvmet_tcp_need_data_in(queue->cmd) &&
+	    !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_req_uninit(&queue->cmd->req);
+
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
 		/* failed in connect */
 		nvmet_req_uninit(&queue->connect.req);
@@ -1636,11 +1641,12 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_restore_socket_callbacks(queue);
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
 	cancel_work_sync(&queue->io_work);
-	/* stop accepting incoming data */
-	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
 	nvmet_sq_put_tls_key(&queue->nvme_sq);
 	nvmet_tcp_uninit_data_in_cmds(queue);
+	/* stop accepting incoming data */
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
+
 	nvmet_sq_destroy(&queue->nvme_sq);
 	nvmet_cq_put(&queue->nvme_cq);
 	cancel_work_sync(&queue->io_work);
-- 
2.53.0


