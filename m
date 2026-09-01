Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91133C624CE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2026 01:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fd3UsNyohAVS0Ve8PPWJ3CkWAxlfnYDi5LuYeHbJPWw=; b=nNcRoZsmb7HZV2jpcJbQ58q1nq
	NXggzXF4eADiTdXKfZGT5rvyZprsB/5qg8pKFQNKWP9uupa37OS06mfo2D1B6/Cl+ElVSbJJ+cfDz
	N5NcXZPEu+PWtLpDriFvXfPaajZPRC/BYP/Wd4t9rc3z9z6i9bmt3SUiNkNSbBRD2EBwt2BOkGRwl
	BFT84AKoi71GRHf+bOz0og5l3m56nBMWvuxLSW/Lr6RJFUDxrckFZXyTSquCeUXetqrJTIC3VlN9J
	Z1RmePuM5PE1uGN6drcD/ZOYRV+E5/lz65w58w52HM7dQzL+laaZ3DKJLeGVla4LLw+/lGdz0Y8hL
	uV9LbEow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Db9-0000000AozU-2cyW;
	Tue, 01 Sep 2026 01:47:39 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Db6-0000000Aoz9-42Tx
	for linux-nvme@lists.infradead.org;
	Tue, 01 Sep 2026 01:47:38 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-934956bee57so573158685a.2
        for <linux-nvme@lists.infradead.org>; Mon, 31 Aug 2026 18:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788227255; x=1788832055; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fd3UsNyohAVS0Ve8PPWJ3CkWAxlfnYDi5LuYeHbJPWw=;
        b=FedVcUDbTGN7p2b8ZlJe3PXGie9cEGSRQsu4AbSUtIPJ2kcDLaeFwIMcpr8WBe3eRY
         iCkHp3QGsJU9S4bx9uq0/QrRJS5wJh6Y1hbpYj7tIlff4gFRvnJad0gPSJTDNAlOsz4y
         oye/oyHf14BNX6raN8+nOpa7xAndx5DXjjCB/yDV44pG+nRkLpQgDocaF2jRj0GwZemX
         doznXJKvpc/tWSHooDnVbFd1WPg5Ol30pGsxiGA0x1ZUat67w3Xc0vtTniYMU8EI6unO
         SgHPCXFs4/QUyUqExc8NgpKJrd1exvPk5TNg0DtZ+xh+KU+W9oK5SfNfXu8Uus+YCj5q
         t7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788227255; x=1788832055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fd3UsNyohAVS0Ve8PPWJ3CkWAxlfnYDi5LuYeHbJPWw=;
        b=nY3mQPbk+T8AKAJqlh2iezhgnNnoaKAaDy2nqsQqGxTVh5UcYCXGsIxmxdJsjqfFPQ
         JVQbBo4nXo9BYkUaGUiDGW2pUA4pW+sFPefPzpy9tyQm4kMzcUcAmyrvVhtiQ1SAffdb
         NcAK2jDJNNpalP+8jcPvQF3mdYCOSXXQMc2rU1tzwF+qt6KF3Jm4WmtPVaCqrToza3Ik
         ghIcmHgl/ygcdzrlk5SBbK+E8g7kK3aZ+v0vxlgeYEaBe552FWKMm3z5r4ibkpMmLLIh
         X5oUsQtDdJKWUJ3sStBYZMkhpSkbZXWE92eplaRHYxNQ38SzSCb9GFSSlXd8EmNnubF0
         pthA==
X-Gm-Message-State: AFuF++lys8O5F70Z3li+D3bDJdTHc5Q5rZ3CNtgtF+OZg1LA3NVatEcx
	RY8vEJZMX9bwYRlAr953YC0c5OK7fth0fw+5C1k58rTD3+nqdT85cdLyRVhdqg==
X-Gm-Gg: AR+sD12wApNFrluTRHRIyuC3+T6UwO4CpYpvnMXn9xxBZEfxcXiFag08mOOW8app4Bv
	hLxRsWsG+3Pb4wi6xPii0Qk5ue7ueyEGzG7iChK1eKkszgoiycbMTWuBjirZZyxe/vU4gpE0ZgM
	h2LUiqoqkZSp9d2qMRf0jZItM/e69GjmMbw58lwG7Db3q/nX/2uSDiZqQzqPl8a1KuXKs4EWm/0
	xpmyp7TTPyfycEEuIQ6HPVkZCAUBlVgcjyxH9kmr+ev4fnpDL8qujOQ8XGh+3Z0boOkoBZfWUm8
	gxeOiUsxARxyyNeqPc8JtvYAxcFHnjTUlSZOtMYUqFfbn9ORMNu6D72aOd+zHLePxn1giHA2H/s
	JNA6hntw7fGc/PHQE+3iqWcYx/pbBSKQIcOaBIOlJBR58llYKN74zQxyvc6jLCWqoyFb8DdJSmq
	x0iv0hnDOc3Cb+DlhUP34zisThrOC2zPPsUSxjfu6yf7K0CzGfiPb9Yaw6IkYa6z5/7eaKdNsH1
	8zrtQVZXFgaJ8EcknGv9//zZQ==
X-Received: by 2002:a05:620a:460d:b0:937:50b6:4a5b with SMTP id af79cd13be357-939138c25bfmr3464249685a.23.1788227254662;
        Mon, 31 Aug 2026 18:47:34 -0700 (PDT)
Received: from shivam-EliteMini-Series.syr.edu ([128.230.213.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939170138eesm929831285a.3.2026.08.31.18.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:47:33 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Greg KH <greg@kroah.com>,
	security@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	stable@vger.kernel.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>
Subject: [PATCH] nvmet-tcp: fix a hang on queue teardown with data digest
Date: Mon, 31 Aug 2026 21:47:18 -0400
Message-ID: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_184737_034980_6037F537 
X-CRM114-Status: GOOD (  12.55  )
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

With data digest on, a command that has received all its data waits for
the digest in NVMET_TCP_RECV_DDGST. has_data_in() is already false there,
so need_data_in() is too, and nvmet_tcp_uninit_data_in_cmds() skips it on
teardown even though it still holds the nvmet_req_init() reference. The SQ
percpu_ref never drains, nvmet_sq_destroy() blocks forever in
wait_for_completion(), and the nvmet-wq release worker is stuck.

An unauthenticated host on an allow_any_host subsystem hits this by
negotiating data digest, sending a write's data but not the trailing
digest, and closing the connection. Each leaked command wedges a release
worker; a few stall queue teardown entirely, and with hung_task_panic the
box goes down.

Drop the reference for a command left in RECV_DDGST from
nvmet_tcp_release_queue_work(), before rcv_state is cleared. A command
that failed nvmet_req_init() never took one, so skip it.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Assisted-by: Claude
---
 drivers/nvme/target/tcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1640,6 +1640,19 @@
 	nvmet_tcp_restore_socket_callbacks(queue);
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
 	cancel_work_sync(&queue->io_work);
+
+	/*
+	 * A command that has received all of its data and is only waiting
+	 * for the data digest sits in RECV_DDGST: need_data_in() is already
+	 * false, so nvmet_tcp_uninit_data_in_cmds() below skips it, yet it
+	 * still holds the reference from nvmet_req_init(). Drop it here,
+	 * while rcv_state still reflects it, so the SQ percpu_ref can drain
+	 * and nvmet_sq_destroy() can complete. INIT_FAILED took no ref.
+	 */
+	if (queue->rcv_state == NVMET_TCP_RECV_DDGST && queue->cmd &&
+	    !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_req_uninit(&queue->cmd->req);
+
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
-- 
2.34.1

