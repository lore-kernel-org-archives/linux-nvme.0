Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA63AE7718D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2024 01:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K1+07h3cXaJlF+hZr6Lj3ZXwz0fEiV46T7tRQeYWO6I=; b=kU4sPXxO/c7fD4aezSW3WVpPLX
	8H21EiQIZsR2qyAd2Lceq5Ra+OxOxUoLaL0G21+5INh5+Z4XOioGjXz2SuvJeTLXXH+1UY4V5tjmi
	AtB/AiRTjn9M0vYHIics1OM2h6+Y+7IfTZPjJ5iay+edO6vKXGKk6Vsrn6BSLREAxrnak/XTuwn4f
	wEZXnzUg7BCHxXJA5YLi33dc93YaTAHZqj+CIp1yaX75/NbaLhM2DOuHIoGQKpNt2o5SMXeQ3N/5G
	weBNWwj9hIyNqwDBaYV24PlsftS4pepZHukQoMc/gZGEdY5ltawrwRzy1lCtODskEVmYtmtnHYslG
	1upmeD0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPWtm-000000093b1-1UBs;
	Mon, 23 Dec 2024 01:06:18 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPWtf-000000093ad-3ohC
	for linux-nvme@lists.infradead.org;
	Mon, 23 Dec 2024 01:06:13 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so3502398a91.0
        for <linux-nvme@lists.infradead.org>; Sun, 22 Dec 2024 17:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kookmin.ac.kr; s=google; t=1734915970; x=1735520770; darn=lists.infradead.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K1+07h3cXaJlF+hZr6Lj3ZXwz0fEiV46T7tRQeYWO6I=;
        b=Cj9ps7JEmI7xGu37drOcxRJjUYk/oOuOCd0j765qa1twPwCcjzKjWbSS21iXA2W9Q7
         tZ+8i2Tu3fAwK0SvC3hqG687phMUdDotjzjr6Wef/pqmErOVCVKUl7lPOA1InsTJfTDy
         0HWpCuVgkbkfJUMBR4rHz0iBN2zUR1AtMMy5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734915970; x=1735520770;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1+07h3cXaJlF+hZr6Lj3ZXwz0fEiV46T7tRQeYWO6I=;
        b=fvivU2eRcMhGmMQAgiaVlYSjAXPWzoNlugJcDdhthrKU2JcYp90FFQW/LPVlnkwAcQ
         83FeDgOz7Rsu4ZlAtRGgAL+VzASdNkv7uDLe0t167C28LaPgy81fzmS4qLgkWKcr2bQe
         pAH/9BI5QYM7h/aNik++QGhtOqtF6Lo4ResHc5k3Rwm8HNzDPss0s2ADlZ/BB2Wz2j4U
         OfQ403SFZGBXLFftF695sspXcyxGr9pUefUUFxZKSCjJ0+7Fnka9Zg9Vz8s8IC0gHX9l
         KfRcghFBZaUgWzaq4P8RLL4/uCc+lkK4fPRd+DCZWuyaFNrWTvrs8ebrxqZB9D5czvEl
         rBOQ==
X-Gm-Message-State: AOJu0Yy0YbpjB4MDTAGLQpUrFRQlK9hCViRXr4jLfaihLlofaSOeGcCJ
	INmEEhOT4PKNJdevxtqntpR+/3ZFedtlUdukX60Jig48EKpuYOLc6P9fGyMhlaB3RP1+Qw9qBZG
	9W+6mNzpmS3xb1GiSiOgHlf/I1j1GZxGKPuI1uucO73x+1sfMjFQTY0Ad6Q==
X-Gm-Gg: ASbGncvRT1M3bozgEoE+FWMxUKJV59MrBn1vAniQZpu0Zl5/6t+Jwb8sSiz0B3Z4A9W
	vNLJEGbYXN+TOiThSkhrw8Y/3taZYPEXs7ASW4hGiaHJaTqYT7b4fG+/qFsd5Oa95+EzXjCIY0N
	ZStF9sLSDU/hik1maCz8iflJGLGFmAyxZ5a6AQiNQU1PHWy39hDlgRvpOCtbJjCC7hywEJchKGS
	WmjN2TL1bYYarGPfeXBXsLGmnMxP7KGpeEx6QYCoWHjPl7yFRND
X-Google-Smtp-Source: AGHT+IF7U7Bn6etCrmnTFPtx+h5whux3a32aoK7SVPN5IpKO+kOsr3m252Zg8VYTTU0DxkyA6BzQiw==
X-Received: by 2002:a17:90b:2e8f:b0:2ee:b4d4:69 with SMTP id 98e67ed59e1d1-2f452ee5031mr16749615a91.35.1734915970168;
        Sun, 22 Dec 2024 17:06:10 -0800 (PST)
Received: from ubuntu.. ([210.123.42.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970cbbsm62339115ad.103.2024.12.22.17.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 17:06:09 -0800 (PST)
From: Yongsoo Joo <ysjoo@kookmin.ac.kr>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Yongsoo Joo <ysjoo@kookmin.ac.kr>
Subject: [PATCH v3] nvme: change return type of nvme_poll_cq() to bool
Date: Mon, 23 Dec 2024 01:05:17 +0000
Message-Id: <20241223010516.241581-1-ysjoo@kookmin.ac.kr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_170612_266798_E0D563DA 
X-CRM114-Status: GOOD (  12.29  )
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

The nvme_poll_cq() function currently returns the number of CQEs
found, However, only one caller, nvme_poll(), requires a boolean
value to check whether any CQE was completed. The other callers do
not use the return value at all.

To better reflect its usage, update the return type of nvme_poll_cq()
from int to bool.

Signed-off-by: Yongsoo Joo <ysjoo@kookmin.ac.kr>
---
Changes from v2 to v3:
- Changed the return type of nvme_poll_cq() instead of nvme_poll(),
  as suggested by Keith Busch.
- Updated the patch subject to reflect this change.

Changes from v1 to v2:
- Changed the return type of nvme_poll() from int to bool, rather than
  modifying the internal return variable from bool to int, as
  suggested by Christoph Hellwig.
- Updated the patch subject by replacing "fix" with "change", as
  suggested by Keith Busch.

 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a5ba80f1811..79d9b4c42b95 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1148,13 +1148,13 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline int nvme_poll_cq(struct nvme_queue *nvmeq,
-			       struct io_comp_batch *iob)
+static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
+			        struct io_comp_batch *iob)
 {
-	int found = 0;
+	bool found = false;
 
 	while (nvme_cqe_pending(nvmeq)) {
-		found++;
+		found = true;
 		/*
 		 * load-load control dependency between phase and the rest of
 		 * the cqe requires a full read memory barrier
-- 
2.34.1


-- 


