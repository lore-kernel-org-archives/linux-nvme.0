Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6AC606A337
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y6/nOxe4;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSPBEVeR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=y/CSr2p4t7NA8azGyJyEsJVHe5AoG66Qz4YwmmzIT4Q=; b=y6/nOxe40t+21Kd0c94qgQ6kRD
	pCe+hHiW5ZwHS3vf+ffiLFy2+2ROxv1P+g+xm9C9VWopM7J66TCZlGuQb1xwZagQzdxmaWWcn57dn
	HipjodkwIXEAvv2IZOY79egIxRI6dLT4uw79co0Blq/iL+r5SkwEIzosi+IsW/wKKsH5NRUFWEfHd
	L+A3qGQkW++H3ZwZJ3IEDaEYYRDRCn/jLeyngaNMxQCMajSMYXaqRiMme4iKYlRLyCk3lvug9ulep
	w8ZfYAtiDcUQ43krLWmC7PzYn0aImj8MjHaHqvWwrAVvLX8qxQBpQXvvHjxL2keOPDdGfLG+yH/EE
	RN/dzkuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWBaa-00000009jsE-1F4K;
	Wed, 25 Nov 2026 11:55:04 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWBaV-00000009jpr-2In7
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 11:55:00 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2802086eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 03:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795607697; x=1796212497; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y/CSr2p4t7NA8azGyJyEsJVHe5AoG66Qz4YwmmzIT4Q=;
        b=fSPBEVeR6aXzYQTPjNrQPnCLqNJY4pgOonXJRTULGta5zO2wdK45T7mux5G0Jwud+q
         qDJDZg0QN3Qk9nNotaSU52a7EmJ2FCKEvS/dwpe9NEDP16iuG0wOeLmT7+LmyF5KhOHa
         8SEcq/xG3yFllRrdzHjOens8udw99t4Ia5ui7PF556wX7WlVDlAuUOB6ahwl69baVbIT
         QxO/ksfvR72hZIqrdLEpZsTJoYKShwhIII/BFCiE58FhEDrH8CasNrh40Bv8vrfPzAxy
         /1vvpC88JwTCffhJj9DkA7SFunmz/+WpmNMMh4wkInBKCBa7TGVdXgkzuDiy9nVVrghf
         OuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607697; x=1796212497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/CSr2p4t7NA8azGyJyEsJVHe5AoG66Qz4YwmmzIT4Q=;
        b=WmbwyWQ3vj/MtFBB7zUltjA8FSy++Xz7hhK0qL2hGeI2US1ejVSvmOOzN31yukj2DI
         0p5t5MCA7ZtMp3smOnffH0qOTqTfk/86BgfPGdjYiwU4iqkaHlO/BseoSvwtNKxu8yl8
         Zrsfcm8PKu47niNzj+/Xf4eN6V31SMn5RfNx75WLsA6HJ62gJWR0+PjY5RP+vxgO0enn
         XaqQ7G9dVH/Rl44rBc041KkIuc76GgB85JtfvZi1eUZpFcrsZaFE8PEAzdqeKlBlP/N8
         NI/t1Kr5UtjtTCKOmZUtSWjYZWTbGuTqQIe7MfF+7ou2T7AEDFVhvr5K/D2LuBGF/EF/
         6Onw==
X-Gm-Message-State: APuU4Z9d48aFk6Ug9IdA37UwMYBtsLvWpoPyeDJN+5NrjzZNQEIorXkZ
	G/6b0pwHKFwpPILTNj+CbzNZRxpwAP5CDY81rLrIWvOMd9yRN2PpEA4Djpv908ao/Usl3+GxUOs
	=
X-Gm-Gg: AZFdTZdFMeTTLEd5X20+0k/HpDVxruxbG8bqOFsl7VVYnm9CflQ5fYj/Htob8zpMmvt
	gaOzh2vrodQBtMOMS1kX6CAY5a5ivwekiIN3o55Q8mYbE/Rua9K46ip8E3IrQb+18X5wSKjZE5J
	/1RmOIwyWtbOkMomg53G8f7GhFt/i1kvx0QxPq5vDKkUvPlSXi7j1lL4/ES7QwoTyxWJ4F6Yhmq
	tkD1vi7C27AI1Y/6vqGGyczcqyb32/Kt2xUJN0AISNnrHItxPNjNYkWLjsqJ317jMFr3vI0lkcb
	neBlW/C/UAQhnQAPmHjEfOyuDBKl94UV48A4rzHL9dkuHCrdpr+bqdjEvYWtvMZ2n8cpmwqs90J
	2+PLREAINJlbNmso+6MQwExzs8DEbHCSq2uPAN72HYG9HKbt8mk8jP0aOJomio6dBs1X3yrDl2p
	ncQZexUlsxyiqdye31EPS3qjgVUAL5htT/1JLPEnKQGghUBFZkM6svMKG5KBEQlluFU02i3SXf+
	ojEG9eR6vy94XbQMS5zdLqYHZFCZ8L8WAhc/UAcNbUEoeghMLqFpoOM5hFLV4eFVJytX2tj8G4C
	nohP4SkBCI6s+PMn/wcVDaC1tsC3OBa18wD3FyXOe+8vGQGqU/SctBFsNC0sEaHF0s4aBT3LDk6
	ll8/tTYx9lX7xeQ+c4vyvzMvYve7mSTPeEMy8nRTYjA10vJGPXjxWxuOCBw1Htogp+IEKRAqNdG
	75kBbfmtvQBYSsye3PKzT7RJDPkQxZm+k0MEuc0rT/KF8F+B5icAZUZAO9Apmux+8B
X-Received: by 2002:a05:7300:6da7:b0:384:5885:2f81 with SMTP id 5a478bee46e88-3856c0c7c06mr49790eec.5.1795607696665;
        Wed, 25 Nov 2026 03:54:56 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-47-129-125-69.ap-southeast-1.compute.amazonaws.com. [47.129.125.69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm27393841eec.18.2026.11.25.03.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:54:56 -0800 (PST)
From: Bin Luo <luob87709@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org
Subject: [PATCH] nvmet-fc: hold queue reference while freeing FCP IOD
Date: Wed, 25 Nov 2026 19:54:44 +0800
Message-ID: <20261125115444.783-1-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_035459_597881_2AB8C101 
X-CRM114-Status: GOOD (  10.06  )
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

nvmet_fc_free_fcp_iod() drops the FOD's lookup reference before it locks
queue->qlock and accesses the queue lists. Association teardown may already
have dropped the owner reference, so this put can free the queue before
completion accesses it.

Take a temporary queue reference before dropping the FOD reference. Hold it
through queue/list accesses and deferred-work submission.
Release it on both FOD-return and FOD-reuse paths. The deferred request's
lookup reference stays with the recycled FOD.

Fixes: 619c62dcc62b ("nvmet-fc: correct ref counting error when deferred rcv used")

Tested: v7.4-rc1 KASAN_GENERIC x86_64 QEMU with a test-only owner-reference
injection. Unfixed baseline reports UAF; both patched runs have no KASAN.
Signed-off-by: Bin Luo <luob87709@gmail.com>
---
 drivers/nvme/target/fc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 5d6c1c7..0b3a448 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -733,6 +733,9 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
 
 	tgtport->ops->fcp_req_release(&tgtport->fc_target_port, fcpreq);
 
+	/* Hold queue across the FOD reference put and queue/list accesses. */
+	kref_get(&queue->ref);
+
 	/* release the queue lookup reference on the completed IO */
 	nvmet_fc_tgt_q_put(queue);
 
@@ -742,6 +745,7 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
 	if (!deferfcp) {
 		list_add_tail(&fod->fcp_list, &fod->queue->fod_list);
 		spin_unlock_irqrestore(&queue->qlock, flags);
+		nvmet_fc_tgt_q_put(queue);
 		return;
 	}
 
@@ -774,6 +778,7 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
 	 */
 
 	queue_work(queue->work_q, &fod->defer_work);
+	nvmet_fc_tgt_q_put(queue);
 }
 
 static struct nvmet_fc_tgt_queue *
-- 
2.51.0.windows.1


