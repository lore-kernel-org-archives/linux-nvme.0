Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D944C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 05:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N2OUE4XFPbIApySv4cd9+4/cmn0pHnKsOVRWx7UtEcY=; b=fslVWWSCcparQMn+2FXmuMc4pp
	hFeN0BdRNYokJZuxXCHhptZDRHCeMchWFkXz+s0KSAhEqunEI6tb2Dum26NgQKrR9fJDqvCdEV46g
	P/YtGNa0GDfiqwSY+NXvnUwzSDFQtXP0VIvObH6Lr4/nzSNwLYCRedGK+D+H1np+3OC5hlE9IityC
	7JM0sh7/N9mIywZ1rB8ok0zxD2CeMuLDI3LConAjeUSyLf6zdLTroxtE1aXkr0YUluLbpdUT9rTYN
	J+ecDcHF9vDCHrp6sNsn2za7ZF5lLWrSsR/c1/uh+On5buQEBODp+NvV9GTchn0z5IalTxVPYAkld
	PGfUAqLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wox7g-00000006xk8-470I;
	Wed, 29 Jul 2026 05:46:32 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wox7c-00000006xjJ-125P
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 05:46:30 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ceaf8a1265so7253005ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785303986; x=1785908786; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2OUE4XFPbIApySv4cd9+4/cmn0pHnKsOVRWx7UtEcY=;
        b=RCcDa/04ns1OCble7+Vui2Ax6VXLKHz9lC40CBRC3EfF9vJaSkx1154P2It0IiyDQW
         STYy+CvoHlDDYVue+cE8JSwSAO3zrc3kJyKzftcW8XBF+G7+zoh+313fcX1Ua0MAEY9F
         If0zBo9OEFrF783drt5T394aGVyQVBEjHAsA/sP+Vp+VSx/IUYmXE9yoj4LbO+cjRdDz
         ufMHWVMrHbH+SsrtPr3/2N1McPb0COqaXDT0RcdIpRIdIkUtB9TXt/1NHXwL2ypCFjbK
         lc6EaY2vOdSO0B5hN2+wCXoE5s7KI7IxqJmHCNvXN8+6cnlrvXxP5RCYo/6106iPtcD6
         cc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785303986; x=1785908786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2OUE4XFPbIApySv4cd9+4/cmn0pHnKsOVRWx7UtEcY=;
        b=Vo1zBqYn4Z7U/EHLrzQKyHUBi+iRes3MlnP6vk1qdE6yxqGx4KYSxD+Ocu0tMLjlZI
         MZ98XwoOZZbhKjND1JAWAs+4U+AnZOViX8Iiq/tzfdHlalTnUoLzVXz3mh1ea8pcQg6I
         zrT1AJvNK6u2Ag88gQ/nSGdDPz6vWJVLaCnuCAKjX7Gdq/VY2LWccXW2ROU20tFUEYu3
         GTNtBiTkMT06pjBf/2XOnlhh9qKHoBNNVpQZgfxddPEgxqFiBmPFKquZ2Hk6YEob1dL5
         TZBaZOG/XpMArnj5IZtlrtmkZ6Nf7vBnJsoo/UNnClBNk/m+WgoU8HgwIMcDz73oQ7vH
         IxBQ==
X-Gm-Message-State: AOJu0YxoHzAbejt+5eIahR0x1ifpOO4tl8YI210QzJqN+Blc95hF3mDX
	iCTK/2dWHKqEI6VpsZOSMwbVYWKiHLpC5RYVqyZhO2heNc7E2N4AF3+C1D+QCgJ6A3K0CMGmCG0
	Yv7azY0nq/Q==
X-Gm-Gg: AR+sD11vzi568wWiWqKKDsnotzugf4wV4vOuseHSc3+XJTxF3ic0FSwcLSC/cRkyqBm
	o2SXL5HRoqFZGTE7RjjSmSDz6bZHowOoX/8gxnK9aZCZ6jw12eRp9/vThStSf7xhn+WE09OknmN
	yIm9mb5qQLQGs956MB+YEcvC7c+kGVMeHDkLoySlSzdRbr3GVXwjKcTWqwJhZBcNmbIpl7z/O2S
	w9y+8kVENkeCqnZej1H57wGxJs1rrWFh1q6yyAdlwuebb6V+G+5hgKzoD19K//REKWe+ZdYUuOB
	9/R2IiiINZOQlA3sV8DbcKs0PVy8nrN6EVcUaTIVXp+E+yBY3SGBB8sYtuVVru2EJtymUQtCpoV
	MKcJ1LrlYHhVpN6RyLdMqV4scUQZqEP3l7f2XD2ekT77+E/1kxqA58iJBDd2ti4GTl+zn6mOMsC
	BKD+hmD+77xbZMwk9szNZAVVEK/6fn+OiIBT1pU0g6nyzEwIIOYdPBOF2w6RBW2EDRXRtiXqJuo
	5mnKRk=
X-Received: by 2002:a17:903:2d0:b0:2ca:bb7e:29a7 with SMTP id d9443c01a7336-2d015ec9f0amr61452225ad.41.1785303986436;
        Tue, 28 Jul 2026 22:46:26 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a45979sm5817845ad.18.2026.07.28.22.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:46:25 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Roy Shterman <roys@lightbitslabs.com>
Subject: [PATCH] nvme-tcp: fix host memory disclosure on R2T for a read command
Date: Wed, 29 Jul 2026 14:46:02 +0900
Message-ID: <20260729054602.1237120-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_224628_383911_0B146496 
X-CRM114-Status: GOOD (  14.67  )
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

nvme_tcp_handle_r2t() does not check the direction of the request the
R2T refers to. A malicious controller can send an R2T for a READ and
the host will answer it: nvme_tcp_setup_h2c_data_pdu() builds the
H2CData header and nvme_tcp_try_send_data() sends the request's data
buffer. That buffer is the READ destination, so its contents go to the
controller.

The command then completes normally and nothing is logged.

Against a test controller that answers every READ with an R2T, a 4096
byte buffered read returned all 4096 bytes, split over two R2Ts. The
pages contained stale kernel data, including an array of struct page
pointers.

Reject an R2T for a request that is not a write.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
c2hdata has the same gap - nvme_tcp_handle_c2h_data() doesn't check
direction either - but a write's iterator is ITER_SOURCE, so
_copy_to_iter() refuses the copy. It does that with WARN_ON_ONCE(),
which a controller can then trigger remotely. That seems like a
separate problem; I haven't looked at it properly yet.

Tested on v7.2-rc5 with a controller that answers every READ with an
R2T. 68 of 68 H2CData PDUs came back with the read buffer before the
patch, none after. Writes larger than the inline capsule size still go
through the normal R2T path.

 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..07cda97ffab6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -745,6 +745,13 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	if (unlikely(rq_data_dir(rq) != WRITE)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t for a non-write command\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	if (unlikely(!r2t_length)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len is %u, probably a bug...\n",
-- 
2.43.0


