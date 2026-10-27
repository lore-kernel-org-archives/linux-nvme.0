Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33921606A322
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U82rJs93;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CGVth+qG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=eMqLobo7VkmEKx6VZ6nPHT3O1QdYzqTpUBW8kb9AOmk=; b=U82rJs93807+GTXx7pTg//qjxn
	gjr3zijUIW+7UTkLKgzSA82CkDDJtSsPgFIS1yveSenll+qxguLfZFZWR3WSpBFsXagg8mbha2IaE
	w8sVwDEYD1bf2ijy6cL1m9QjbgOHwSanDoKRDs56JcCa9la8zAW1z2TN6wMSDHULVQpqtssl3o8WW
	6++a3XfuRyq47T46u0T3rPDYGDhR69Dt+xb+DoJ+Cc0QPSzPvj/UEOSWP56ya9ixOVBS7WIwbvzxf
	6G1P3szydBxZHyZ6nG2AwsDHtPVGsk24znGMOUN5dVuaf0a6DkaJKvfURyBQ2UdsIIFoyWVWtBAB5
	5DUk2AXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLiPE-0000000542N-3aZZ;
	Tue, 27 Oct 2026 14:44:04 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLiPB-0000000541f-3fpA
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 14:44:03 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-15dd124bbe7so2691729c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793112240; x=1793717040; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMqLobo7VkmEKx6VZ6nPHT3O1QdYzqTpUBW8kb9AOmk=;
        b=CGVth+qGJ2G4QxaC0pW+3vRuRja0M0m7r2+EubUjblBw6tdp0C8F/qBdWXL0JnAMbb
         ZsYSpYZh1UB3hRp29VZD2oLrKovXorTQZ2scO1qNXGDC5pt7hT1f921Eyxjp4hzwsOkX
         2kdyWedZ3GTIC+B3YI6NWGjJwMgjIxp1ugiEVW39rWIiYgSpFO5pPtyn9cfy/AUZI3Ql
         aG+uJ+5usvCEO6pssI2biQUQa8kmxIOuCxNcWNmfKn6uuSq8eBDhAbs2WmFy/P+YZfi9
         hpkx9laxGc4pdA4j/siuIqOcXuqIRC5WYcZJErMTxvViXJxdNlgabG+1scCh0/XOQz9o
         Io0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112240; x=1793717040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMqLobo7VkmEKx6VZ6nPHT3O1QdYzqTpUBW8kb9AOmk=;
        b=lBYlDAfDbsEx4MPHQA6oSCat7+EpoM+GADrgtWV96kJxF6J9cssMNvYJ4zqqJA7lov
         4CmAKwuOBeyqP8wbgLXMq2Cz5pWAB6EHgXaRzy+GA+YBmWS8I16eGUFn+9Bj57fh0348
         QQYjup87UR0xb7S8r9zXN3RQg0L+3WZ+26TIPo8p8Ur1it0jGQxwgjendOxQ+8SxbEYE
         wm2VqMFENF154i8GGL4adkY2VKUKufJB2+78MOkObIGbevxveRwdwgQe2pBjAppLTESI
         IGdpGFk9t7iziU9OWMMr/RSHQPtuiTcrV+rKrKr+U3Uw+COgiEI4ekMT+wvQaqp1zML1
         vdnQ==
X-Gm-Message-State: AFq9FYIMVJzyuKF8gkebKU5spaik93m2akquBstAWuJt+OYZIQkaHcvb
	Axwnms6y9tW8CXCn56sdf5BHqoKb+A/bZrbSm3N18TaqFyAv+av0RiLKjhqbsp2B
X-Gm-Gg: AYBFou2jfCDFWVCNnJvQ0dv+t1SconbJyDrDFPjjot//oztlM0rqYXtLNoiTG3MphPg
	6O2BHk1MKNv/HlaBY31Twb3N6GPjM6A2ZKK9tkhOhS00U//QxSq4mOzTpD9qfGqumFTzZLEHUxq
	Y1sLTGErf256n6fM3PovuVaIROI7CXY8ciXhUw5dR9JAvdaQVLvZK93cT+ePqoQQEjwGENucTT6
	F4MSU3/xCR5EpDiiraBu0qfHCwfsNnCYgH1nOHFFJwKqv6a7M+pvp6mBJNOJwbb3Z85Q06SpYPm
	Wg9vmObH9HNj1CJjMrC7/dlodBQ/7Y6OtyieOobAivERNs8w8xGV37C/alcfq3LFKkhk7O9JLmw
	QpOBZWihm7Xd5AwevbCPj8C/Ay0JJ/Ds+BD3pwlMfNnHEGPUcik/AULygUIymPRWqVI6uQvOSjn
	MVzNuaSD5rCoGpahgeWLousd1yMEnhJ261m8Ki9uSlitdQ7QIuBMvfDzPcXJ8hOQRxtQFMiCbnh
	m6QUsjoilkKV/Yhu7OSpzo9wPpas3kgsQ/Y5CWMWpMoOiNleXtMMD8XrewU96JlhSGz0Q==
X-Received: by 2002:a05:701b:2902:b0:174:cf1b:235c with SMTP id a92af1059eb24-1993f6d2389mr13877306c88.43.1793112240015;
        Tue, 27 Oct 2026 07:44:00 -0700 (PDT)
Received: from yocto.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm33804482c88.1.2026.10.27.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:43:59 -0700 (PDT)
From: paritoshpotukuchi@gmail.com
To: linux-nvme@lists.infradead.org
Cc: justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	syzbot+df0058a8d0bdce7c4059@syzkaller.appspotmail.com,
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>,
	Ravi Kumar <ravi.kumar3@amd.com>
Subject: [PATCH] nvmet-fc: extend critical section in nvmet_fc_remove_port()
Date: Tue, 27 Oct 2026 14:43:04 +0000
Message-ID: <20261027144304.1177203-1-paritoshpotukuchi@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_074401_915702_0FF5C022 
X-CRM114-Status: GOOD (  11.27  )
X-Spam-Score: -2.1 (--)
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

From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>

Currently in nvmet_fc_remove_port the critical section starts from
the call to spin_lock_irqsave(&nvmet_fc_tgtlock, flags) and ends
before the call to nvmet_fc_portentry_unbind(pe).

nvmet_fc_portentry_unbind takes a spin_lock_irqsave on nvmet_fc_tgtlock
again, to execute its critical section. The problem here is that,
releasing the lock before calling nvmet_fc_portentry_unbind, and then
retaking the lock inside it, creates room for other threads to possibly
enter the critical section.

The solution proposed is to extend the critical section inside
nvmet_fc_remove_port, till the point where tgtport is being used.

Reported-by: syzbot+df0058a8d0bdce7c4059@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=df0058a8d0bdce7c4059
Co-developed-by: Ravi Kumar <ravi.kumar3@amd.com>
Signed-off-by: Ravi Kumar <ravi.kumar3@amd.com>
Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
---
 drivers/nvme/target/fc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033..96d8aafb9f56 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1271,15 +1271,11 @@ nvmet_fc_portentry_bind(struct nvmet_fc_tgtport *tgtport,
 static void
 nvmet_fc_portentry_unbind(struct nvmet_fc_port_entry *pe)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	if (pe->tgtport) {
 		nvmet_fc_tgtport_put(pe->tgtport);
 		pe->tgtport->pe = NULL;
 	}
 	list_del(&pe->pe_list);
-	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
 
 /*
@@ -2922,7 +2918,6 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	if (pe->tgtport && nvmet_fc_tgtport_get(pe->tgtport))
 		tgtport = pe->tgtport;
-	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_portentry_unbind(pe);
 
@@ -2932,6 +2927,8 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 		nvmet_fc_tgtport_put(tgtport);
 	}
 
+	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
+
 	kfree(pe);
 }
 
-- 
2.55.0


