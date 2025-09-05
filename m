Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E914CA101C
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SCaQeEoiIyJ+X9I+BeUdEKTAO8qJHTIamDyt5AdyHmg=; b=cq1rR1S+IIYPqDiF4bYfcfNnnv
	T6MdL28ei9UgWDFssFgCSWOBD249OmLf7maMEaBlgU4/TOHg06sp12YOwm5dpBlO3SEn89f8Gu+k0
	R3mSn+HbXkLaN4bYomgL8c1jwC8o7czyVv3GQcZzGgLu8YkpT90trN1bA1E6qw96KNlrfp0rv2zlP
	A4tZAz0QGo+DljZsO2IDDchWnxmMGhleUL+avxjJ8Um0jBsrEHjGt9/T0y9d3Pbk+8JM4aKEU+Thp
	U+sGb3VMXJV3AjsMjzmoWTiW1UtI7udnktbyYR/hufBOFGd0vad3LHw278syiwMBSHssNnSTUH3ee
	pCJ9fekQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUX-0000000GEus-2kZA;
	Fri, 05 Sep 2025 02:47:57 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUK-0000000GEnh-3pd7
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 02:47:46 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1566644b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Sep 2025 19:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040464; x=1757645264; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCaQeEoiIyJ+X9I+BeUdEKTAO8qJHTIamDyt5AdyHmg=;
        b=l3j9Mb4NFJhPyvDnoKFl0m1+ZoNO4KOYuZka4u3xzj/3NUpUHGqp80Zvjf2LlnKYY2
         U2m2dY8v55Lr26XmbUtd7zmlkES1INL6AfW3ojd7mBOp/25QUIyGHUpfppeOeYXuWJPi
         DAc9M80jMi6HHAJ187Tc3VwHGYROZjvXlMWfIWMZY5XawYKrgSmIDbUvat5fz3OSmdLv
         RBID/JmtMgyZT3zy7403mOsOwkUFfRnBcX6X3Zy39NVhdvFaEG290MsRrfF/DZvji45E
         tsun/B9hRTW4PiHxaSp0UMl3ngLmqKRnX/E1Ve4eVXQNFtmEI6LkYSF9dbu4h3fKFgqy
         ZUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040464; x=1757645264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCaQeEoiIyJ+X9I+BeUdEKTAO8qJHTIamDyt5AdyHmg=;
        b=nIo/KcnYvIjhgLeHE2qe/duZYne1ytPcNRsfv2aHCdXkhuS25/treSFMotu17Bb9Mk
         fIqhx1q324kOyB/cdp2wRkbRocfrRXizQlC7/pxrMJCUOLMCYVcgyH7MsusLst40EAcv
         zqMAPuY782lvlBD0xonDPhXPhqC4UMEj3Qj6b+qOXEC7AfrWurrYjLWoHawdx9BXDPZP
         /bYvYE18/UjqFhdyxMj6MuUis8QLitQKZHSwrn4h538Fq+q91S6x/5HjVlXhMnzepOxZ
         Thm3yEHJ8dmBJRl0tFG+rPEIvZLmeWfe2Wh2+5WO1VzNZ3WMid4Yfo3I+NnOYCQJBNkB
         C25Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVJ6Ch0ROUQTc+mk/oR/PUc+zy70P+10jo4GVXZRJ9+6UcLLhKuKPpAYSXS5qkv6ZWN5cLbaXefaOg@lists.infradead.org
X-Gm-Message-State: AOJu0Yygwp00x+F8t9TcFebJHmY30bIn8noWWAdpfIPaDGbiMWGIeohG
	4e3tKYqykgHTA0WrpLScvKNehri9tR/J7Z0618UA/wr62RUdL+vzWZ5U
X-Gm-Gg: ASbGncsIC2ydGpDT4SzrtAO80+bn1EJ3JQHb/Fh2USMLorI18Q3hzpaoBkq7c/QsuzU
	lCpFhk7Ujp6h2JBiO75Q/ccYXVcZzghbIN7MsPgIa5p1Kt546xln3Yu5vKWH/lAZF50KZ2w8/M9
	u0WlB34rKgUtPUegPL+Ax6N0PiFTlU2m5xYgQP1wYBsE6oijH9KKLihHcwxMQquUbQ2TR5QXUlC
	C0R54h6V0HvuTzvwLTBUlE0+Yg2TN10AoG9hftTVp7iBxXVrj/93+E/Xq5xe1AHCSdmMFRj/kWo
	FYsCLtOdna4Q5N7dh2b6CwNwUKd3LtvJ+FymwjBa1HCrUXMrE/XhBRZY4Jxss8YlaiVzbUJAzfO
	EHDPylgCg4bsd2Vdh+7nprbY16BqoJ+ZcW6XXFGzu3pmDurczgu2X/irk+QZObKVroFEkissDw7
	i9kWwuPDyRM/W7gogsjXMoLSbv00r4xtVHbOefDw==
X-Google-Smtp-Source: AGHT+IGyxjGucAcq4/CU7sDyIrxh2LLf/2cgmkqvjOqu7ZTDbk8ByUwUxM4eRmIFb4t/3oQsNifJkA==
X-Received: by 2002:a05:6a00:db:b0:772:6bee:9ff4 with SMTP id d2e1a72fcca58-7741bede44cmr1504866b3a.5.1757040464162;
        Thu, 04 Sep 2025 19:47:44 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 4/7] nvmet: Expose nvmet_stop_keep_alive_timer publically
Date: Fri,  5 Sep 2025 12:46:56 +1000
Message-ID: <20250905024659.811386-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_194744_951753_4FFF2821 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0dd7bd99afa3..bed1c6ebe83a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -430,6 +430,7 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
+EXPORT_SYMBOL_GPL(nvmet_stop_keep_alive_timer);
 
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
-- 
2.50.1


