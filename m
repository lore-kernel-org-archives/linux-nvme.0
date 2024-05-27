Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01A6C25B78
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 19:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dLNR3HA10GWpDX+/bjL0V1ehoLQ8rdrpHxx0+1b357M=; b=zpppaYx9gJk3u7y+KUc+Onzub/
	xBzADPw52kme8SlMDz3DvhOD482b8GMbEYOlcH6xJImflDNIN/Ic6iTeCCX1Fi0lZSHK3KR4fhSNI
	BaBtzgDYiirgbT6Fi1ZtZvo+9EjSHp41nhA/YReN2KO0TJiUXeyITZRPqMGRTncmgYO8qs+Milw5y
	baQhjGutZA+FZrIj8ulLbzReVE5j32S7dZaIVI8Jq+XEM67Lb64wr9XHhZqvJGqKPAznk9kyNqJIw
	ksyKHQ8WCEYSzkSFUW8P+DKBuCiist4zPV+YKsnKMhfaJ6sYZXzmE3aKEg6oJB3aNTNsdv8OlmXhW
	odxhGx3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBgBR-0000000GCCF-2LJw;
	Mon, 27 May 2024 19:39:01 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBgBO-0000000GCAv-2b5l
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 19:39:00 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6249e39815so1711666b.0
        for <linux-nvme@lists.infradead.org>; Mon, 27 May 2024 12:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716838735; x=1717443535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLNR3HA10GWpDX+/bjL0V1ehoLQ8rdrpHxx0+1b357M=;
        b=V0xaMetOEfy3w49feQ7TtlBxaRxjUWUzXpHACEHu4nBHaWsS6963btgI8iDzyL38cw
         /L15hzhXGEoUg5evMxUvSZFVuLa8g/vVEq/BJpwGC8jSoDhdXtglbzaf3XxT0V1oD+je
         KQ+ETmEJOgn9a/2KnQeAt/ryGpmTO01bCGEn9NYvc1zAVjQaEGXG/AK3eT0Yoj4hFPbm
         SaK//+OZ+pFFjjVnouZil0tnqk181vAABGRp9ZMy7UJQj0mBM/stXOa8VS2Js+CfWRux
         ttDlLMa1jcOl6Y4cTredQ6GeNL1Npl2S7uMeEJk6DqqI/E1u99uyiCN0jyR2eFITGpX/
         wjdQ==
X-Gm-Message-State: AOJu0Yws/9cYqQNdNelSkbfWiGh9OcAgp5ewx0ov+ZO37uU2ynshzLTA
	+jfuNBVsPNihCRe3JapiarpSLM+ttYgDZA1PrconBDnnP1SWCuJUJZfmrg==
X-Google-Smtp-Source: AGHT+IGZazl5xC9UozMXNrYyE93Ax0CtrkboV0J3Y/r8QhDQ5YQuEzjPBEOydJhfvPFiVUi7e/IAEQ==
X-Received: by 2002:a17:906:6b1b:b0:a59:bce9:8454 with SMTP id a640c23a62f3a-a62642e09d9mr803815166b.1.1716838734794;
        Mon, 27 May 2024 12:38:54 -0700 (PDT)
Received: from localhost.localdomain (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c818139sm527934666b.35.2024.05.27.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:38:54 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet: fix a possible leak when destroy a ctrl during qp establishment
Date: Mon, 27 May 2024 22:38:52 +0300
Message-Id: <20240527193852.252090-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_123858_677652_0C73CC99 
X-CRM114-Status: GOOD (  15.61  )
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

In nvmet_sq_destroy we capture sq->ctrl early and if it is non-NULL we
know that a ctrl was allocated (in the admin connect request handler)
and we need to release pending AERs, clear ctrl->sqs and sq->ctrl
(for nvme-loop primarily), and drop the final reference on the ctrl.

However, a small window is possible where nvmet_sq_destroy starts (as
a result of the client giving up and disconnecting) concurrently with
the nvme admin connect cmd (which may be in an early stage). But *before*
kill_and_confirm of sq->ref (i.e. the admin connect managed to get an sq
live reference). In this case, sq->ctrl was allocated however after it was
captured in a local variable in nvmet_sq_destroy.
This prevented the final reference drop on the ctrl.

Solve this by re-capturing the sq->ctrl after all inflight request has
completed, where for sure sq->ctrl reference is final, and move forward
based on that.

This issue was observed in an environment with many hosts connecting
multiple ctrls simoutanuosly, creating a delay in allocating a ctrl
leading up to this race window.

Reported-by: Alex Turin <alex@vastdata.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2fde22323622..06f0c587f343 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -818,6 +818,15 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	percpu_ref_exit(&sq->ref);
 	nvmet_auth_sq_free(sq);
 
+	/*
+	 * we must reference the ctrl again after waiting for inflight IO
+	 * to complete. Because admin connect may have sneaked in after we
+	 * store sq->ctrl locally, but before we killed the percpu_ref. the
+	 * admin connect allocates and assigns sq->ctrl, which now needs a
+	 * final ref put, as this ctrl is going away.
+	 */
+	ctrl = sq->ctrl;
+
 	if (ctrl) {
 		/*
 		 * The teardown flow may take some time, and the host may not
-- 
2.40.1


