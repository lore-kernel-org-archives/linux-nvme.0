Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6738CA9EDC
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1VyDhzJgUHMA7Wq9U/IKLESFKx2atIdhYsLlTj0K8E=; b=5G10Q9lqU1OOMAJrV0Rl1fmZUv
	1ZqBA79zBE9g5CNlQOE/cETzTxray4DYVN6cmLEbX9BWFYjS1znddXcx02zSxRRDzgZOFKaRop3Jv
	cHyBeSF5a4q+zumx53ZEPb+JjGa6TUME7GCP5h29dqdM4SRTw8zm9XJbTkXBUuOxIsqVqrdqXEx5O
	JGkex5a3xM06FpAaLtT7vI/T5jlfud0aoa4zcHPIVlFrdju3A++08MeRX8IX3Mbb7MgO34in8vvov
	oVhSWkX8EIrQtR1zcoNa4P7uPcupLMFTb2OcoxtegymWeOfgXOdfRReg3jtbTasjMhOJ48GKKzOnT
	qjyKqMmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGlx-0000000AeaY-1pwN;
	Mon, 12 Oct 2026 14:13:01 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGlv-0000000AeYn-2icE
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 14:13:00 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-48c6f764f82so576766f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814378; x=1792419178; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1VyDhzJgUHMA7Wq9U/IKLESFKx2atIdhYsLlTj0K8E=;
        b=N4UoaZY1OrgpE81rkqMlfJwKXjrhPcGoXo/YdykVXcF9u/hD622J4sVKAMYkZH3uSq
         Bg5+EgjgeZLu48xnA5TUgekoNANR661rJTdMtl3fx1yjo6wkPTRoa404OIhcguPscOMD
         58VrdCKJQoaNYpr1dZFrrM4NLqU5U/yJC3kjX4WKJPM/Pk81lm3YVjYoluhxE25njw/y
         j0/o+eIMXSPYgqYXAU1PL2Ah8QeL6USHK1OZDS9nQOSYWZpCLiwUgFH8f+q5R+A6iznp
         8iKWaXPTMyH8jtaFzPWli4LdbEoP4RadHhLg97ZsC9AiTVxV1kH0dxflLh2MRGzPe9Sj
         FsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814378; x=1792419178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1VyDhzJgUHMA7Wq9U/IKLESFKx2atIdhYsLlTj0K8E=;
        b=o5BLrEWOya8XfEXApyLepPtcLXwIlKbZU9MX72CLS8DpOuJkv4+gm6QKTY9hH97yXg
         SjZHo3tTgjflafQQOHyQybhYyrhNTT2SSsHTgAlmFAOUZeHzafT5tXY+24N8sJ8J+Alf
         j2SGrLKpL+SmsFH7z+yjm31g0lgniBG/uwh02hfWIwaqU6ye4RQBGUtnin84OEMAfGeI
         3Hm4l2u9Oey0fOXT3PO7mOKzMTCGRnqvCwXhcLM9eOyFllikOQQhaE01LX784ZSs+XL6
         qR2V+lI7V0Amzvsj0b34bXDc3ux6wTkgTqzq9K1sZmRlAPShLR7MaJFfFODc2oSoiovn
         hsHA==
X-Forwarded-Encrypted: i=1; AKwUvBxV6GFJ4FaSFsgKeSMrFOCefYs0WM1JBczzEykQ1C5+lZ+9D1sAdBjVrRIWNSxCWy/IAqZzA6kZdn8N@lists.infradead.org
X-Gm-Message-State: AFq9FYJuoP1M1IKPDq5LLNgiAEtXi66i33migjzw3nS2KhIMsm6qBGLl
	IB8zGYUVwJDwBEMufcyjSPGgbjHuNDPxIWq0Ok2GwtHRdu2On8GA95VJ
X-Gm-Gg: AYBFou174dnx6e9b9RBzJT5IEfuhHibebocTgubLEUaHgkG7YVBS08uBEGeisWFCtae
	Hb7UM9oRjdyCaA7hnTVE/u+AhIscEstFhgPJwAN2qTgqfKkdXkbSkYiY//cegrKxs9UzPutbkWt
	K4jBb8rSgLKMSWCO15iFxOpyIBNHMgV7TU/s7Np2MLoOGmZmxpwKiBbbM0oEkLuhXcjPOOwxGnL
	QnDd5AEaKrhqRldGSdE9+gVuA0Bgq9myyZQXIJJpSNhenMf2oxWS+tQHTfHcHO3k3HLbIJu1tyN
	hVANqKDz1SYSsdatUnCu6t/4ZoC+MNlFPCaIk2IzUgK57IBgsjRV1wiQv6SCQEHcR6wDDtFt/xZ
	6vNfsXwfIvQ2jjF8NMj7FU4tti+C5ttqeRfy/4itSqbzY1Mk1wWHSzIMeaKU2C2x0I+75n8ug4h
	nUFINY1oh9i36T33cVSIuuMQfV63hg9dLPORGuP16dWm+creHt2f9fvao1SJABVVE1HIJmUQQce
	Y4YKJFNrra2VgTnqtIuj+Zz3Qz+doxLbfBpfpRJebeq
X-Received: by 2002:a05:6000:389:b0:486:e707:42eb with SMTP id ffacd0b85a97d-48dbacd93dcmr18590413f8f.33.1791814377415;
        Mon, 12 Oct 2026 07:12:57 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:12:56 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	James Smart <jsmart833426@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/5] nvmet-fc: only send read data for successful commands
Date: Mon, 12 Oct 2026 16:12:28 +0200
Message-ID: <20261012141239.156408-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012141239.156408-1-parri.andrea@gmail.com>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_071259_711017_149AE215 
X-CRM114-Status: GOOD (  18.49  )
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

When a read command completes with an error,
__nvmet_fc_fcp_nvme_cmd_done() still pushes the whole data buffer to
the host before the response. nvmet_fc_alloc_tgt_pgs() allocates that
buffer with sgl_alloc() and no __GFP_ZERO, and a command rejected by
nvmet_check_transfer_len() leaves it untouched, so the host receives
stale target memory.

The buffer is as large as the data length in the command IU, so the
amount of stale memory returned is up to the host.

The tcp and rdma targets send data only when cqe->status is zero (see
nvmet_tcp_need_data_out() and nvmet_rdma_need_data_out()), so no nvmet
command can rely on returning data with an error status. Do the same
for fc. The ERSP then reports a transferred length of fod->offset,
which is 0, matching what nvme_fc_fcpio_done() checks on the host.

Tested over nvme-fcloop: a failed read command no longer transfers
data and still completes with its error status, and successful reads
are unaffected.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033a..44bbc7d26f07d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2484,11 +2484,11 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
 	} else {
 
 		/*
-		 * try to push the data even if the SQE status is non-zero.
-		 * There may be a status where data still was intended to
-		 * be moved
+		 * A failed command may not have filled its read buffer, so
+		 * only push data for success, as the tcp and rdma targets do.
 		 */
-		if ((fod->io_dir == NVMET_FCP_READ) && (fod->data_sg_cnt)) {
+		if (fod->io_dir == NVMET_FCP_READ && fod->data_sg_cnt &&
+		    !cqe->status) {
 			/* push the data over before sending rsp */
 			nvmet_fc_transfer_fcp_data(tgtport, fod,
 						NVMET_FCOP_READDATA);
-- 
2.53.0


