Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1A9C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BG/QZrF/T+yK62BF4hIaXJ89uhpZSpmPzCTogGcACsI=; b=KUfJkqEyU4bM2M3QxjxxuYOK4C
	V32fJC7MZpvGek+rS0T6DURDh91vyLwYkM9lyaiH38PcLqICeuJft0PmhKIVi/ZxLNS9Pxdhm+5em
	Lx/o+/PxxBcWg+2Mitwk6B02FtFyi4zbvw++4cpsX2G2l3bvGkG/Gc/BU84gr9vboyLD2zPBsdrA1
	E8/TsXcfE3FgkKy/fw8TbUti1dxZciRULCE+Yno+E3eSXCCAgV/SKh6pN5YMN9sgJEoYgOkLNCZ3i
	gkFa2/ENazj4FZ6ICnPkLy+BbPe2ndTCd5cIkKXLBW3LzVAXpV4RVStvFmhW1+WrLIycFhhs1R9LK
	RUBGuBTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGqCj-008h3B-9V; Sun, 06 Feb 2022 22:40:21 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGqCg-008h2s-37
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 22:40:19 +0000
Received: by mail-wr1-f51.google.com with SMTP id w11so21693729wra.4
 for <linux-nvme@lists.infradead.org>; Sun, 06 Feb 2022 14:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BG/QZrF/T+yK62BF4hIaXJ89uhpZSpmPzCTogGcACsI=;
 b=YjnixdO3k5eNNY8o75sOQOpN48Ql3T/iYdfyNmUdmLFdv/dytw63iq/q0/CVolI0Gk
 3a7twI/bwsc9sOiiwlENMj+ZGIdz9ig2j/WlYPmy48fznE+MW1BiR1I8BuSQAD2tyO5V
 BpfAfkqx81kPDLvFCTVbAc+zSAipW1pGUMNxp+6uCEDAnZCVT0hTfd6DwaRy/CBIHYgG
 VeIS+KeAalys3NM2U8qTfn2XV++1T1gYakRscsfJUoBAjnPqk8X37le0rbpdI1ack76U
 U90pr1Gnt8aLn3yuPD74x/TtJxdpIyA4LqrNkgxIx/hP/bDajhCcxkOvmRFSNtXNy2q2
 sC8g==
X-Gm-Message-State: AOAM531tZtiUq0Br09rxjBRxIubhLJhAz7ljlg4tmTmOYggnCXBZyhud
 tGvC7zpl1E+trQWVF3to57SF6ql38QU=
X-Google-Smtp-Source: ABdhPJw0jBX9P+aE7uyBnh47XxF8t5ffSSyNItAo6anDBOOu5mDFy57K7zOiQpLrgdEY5D+sdOztpA==
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr628551wrt.694.1644187216430;
 Sun, 06 Feb 2022 14:40:16 -0800 (PST)
Received: from localhost.localdomain (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id 2sm8522598wrz.59.2022.02.06.14.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Feb 2022 14:40:16 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH] nvme-tcp: fix bogus request completion when failing to send
 AER
Date: Mon,  7 Feb 2022 00:40:13 +0200
Message-Id: <20220206224013.771411-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_144018_158477_F8950D4A 
X-CRM114-Status: GOOD (  12.81  )
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

AER is not backed by a real request, hence we should not incorrectly
assume that when failing to send a nvme command, it is a normal request
but rather check if this is an aer and if so complete the aer (similar
to the normal completion path).

Cc: stable@vger.kernel.org
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 01e24b5703db..1096a0b0a268 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -913,7 +913,15 @@ static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 {
-	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_HOST_PATH_ERROR);
+	if (nvme_tcp_async_req(req)) {
+		union nvme_result res = {};
+
+		nvme_complete_async_event(&req->queue->ctrl->ctrl,
+			NVME_SC_HOST_PATH_ERROR, &res);
+	} else {
+		nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
+				NVME_SC_HOST_PATH_ERROR);
+	}
 }
 
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
-- 
2.30.2


