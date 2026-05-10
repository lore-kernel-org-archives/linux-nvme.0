Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CEECD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Sq0ZW0C82FUqMv9f9cG2mNwSDTVCt9g264/44xhcs1M=; b=tUIK4PmExwH5c/
	FanQ0W5JsU+UM1AM8lmUFkRB8VqqaEqLTwEIadxC3Yn60+Q1lwmR+GOhrV/ucxgm2KqdSTnTwfvYW
	l+FCwC/v0TVcIg4kg2J+1EZoMuwZ/Xamivy4SFafGgTTHAwy+RvYWwa78Xq1nThr6q6z6QeGNV8ly
	pTWz4VRhnkVP/Z730dfHEYVbkqsWEtHrow2yPxZAZ93oieUpM4VdNx1AJZekoiVYv31jJDHDjuOCC
	clbthR3CDJYlfpgFDQ7LF6T2u9cfFLDcws1vMGbLs2diUHoEmwvBGZ7KUifQ56kVePb3Bv89DcL10
	spcJO4IyTqI0oSpieU0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMAnU-0000000BZwa-2yFP;
	Sun, 10 May 2026 20:30:44 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMAnL-0000000BZvs-0Pcf
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 20:30:36 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso34350285e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 13:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778445032; x=1779049832;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sq0ZW0C82FUqMv9f9cG2mNwSDTVCt9g264/44xhcs1M=;
        b=GKLGyPkrejjIey44vD9ZoxtURSUJOoMFhgPB5q5t86KpEKWLSFiCpZ301XeUU7W4Uo
         ziQNPGvozvbIDzgF8AtG3FDoPC6CF7bNWPmoHzCFS34uXYFbbse/yoBsp9Hgq28D2D0q
         JUeDULLHCsmjBodrJWFZKmM+QLHqHMNNIRAj91y/+JAb0QnX6FyUlk/+MEDNkOg9yRbR
         bDiDE7VQba51bmeAsOrMMLcjXcn1s22w/koXWgUOsBkW2fqxsNURTEhleseZPVdlrlH6
         59FqiYktbNkszfs5P1F5kTdl0My/2ae/De2BiDhC737icWNjX5HObof1xmTfHIRZjiok
         FkCg==
X-Gm-Message-State: AOJu0YyYyffc/xulXC3j5HAzX/kWDbpocU0e3xp95X48vz+4SwM1x8WT
	3pY3r+BGD2YA8nRLq8ssnA/ghcu5U0gJKL2w2mrQJ7hpb8Q+bsThvjzy5ugebw==
X-Gm-Gg: Acq92OHzr2wGKCYKohVcWi1gyGjlasAWG4CBVLAJDTwZ+uJtaQLA6wSJ4j8+cmLUGOl
	bKm9DGhUUWjcwiL3JVcfU7L0oUA4BfTZfIxvugBfVDebnN6VrrikJXNYE2nU7ULHsVlyMWMQ1Nh
	KXsH9LQM1MVF1nTOCMAfbC76dBthwM8uLxMHFbddfclG5RJDaQcU6T1pZolnpfdqI+Re+5FRVbr
	1uDGTaLQ59oVkevV228YFkeZmu0ic3KueqkJwnUpZGVo66ez/4cImSg6wQhkzyChGpjFWyhr5yo
	dhFc+DSZyIOd6jHfNcQY7Lk4BYJCv6yUqt0mGveONSbbRObqdNOpXyubme6A6/G6v7xRb8SbK13
	jX5tuFMRyyTWlcr5gmzD1DsLV0hMGB0HqAHjDqp6esh0zKsi+2Cj9mZi56a8O/tkNqHYmk991mq
	qQ16KJeEwODe5g6QbCzcLhsaeK3dzyS3bE
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr228380235e9.2.1778445031847;
        Sun, 10 May 2026 13:30:31 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702f407asm138841315e9.13.2026.05.10.13.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 13:30:31 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	security@kernel.org
Subject: [PATCH] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Sun, 10 May 2026 23:30:29 +0300
Message-ID: <20260510203029.119712-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_133035_144272_BDEC786D 
X-CRM114-Status: GOOD (  13.84  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Shivam Kumar found via vulnerability testing:
When data digest is enabled on an NVMe/TCP connection and a digest
mismatch occurs on a non-final H2C_DATA PDU during an R2T-based
data transfer, the digest error handler in nvmet_tcp_try_recv_ddgst()
calls nvmet_req_uninit() — which performs percpu_ref_put() on the
submission queue — but does NOT mark the command as completed. It
does not set cqe->status, does not modify rbytes_done, and does not
clear any flag. When the subsequent fatal error triggers queue
teardown, nvmet_tcp_uninit_data_in_cmds() iterates all commands,
checks nvmet_tcp_need_data_in() for each one, and finds that the
already-uninited command still appears to need data (because
rbytes_done < transfer_len and cqe->status == 0). It therefore calls
nvmet_req_uninit() a second time on the same command — a double
percpu_ref_put against a single percpu_ref_get.

Reported-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..20f150d17a96 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1321,8 +1321,10 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED)) {
+			cmd->req.cqe->status = NVME_SC_CMD_SEQ_ERROR;
 			nvmet_req_uninit(&cmd->req);
+		}
 		nvmet_tcp_free_cmd_buffers(cmd);
 		ret = -EPROTO;
 		goto out;
-- 
2.43.0


