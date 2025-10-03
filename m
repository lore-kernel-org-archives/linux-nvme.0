Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5556CAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 04:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=; b=psKDPQaAZKb9u22LGHuVLDIoU/
	Vzh9Y1kTuQrjxuRK4qhX9PmQjvsuuZg0QlEzbZQe2YI2O3JNRrMBzcnLT3vRL8ffsA7EPh4vCZ1Ut
	4wEkqAl3EinYLJYEmc4P+V25hi5GM9EWQbjKBspzRL3FBsJebPhR9ncdzIOxRZb68z1PiMmHNJISW
	NgNvwUIHn+J61ytozICSkvaK747o4dTKvYFyd4uPae/pmdKcokq7+aNYcnk8VeOBhX5cWQrxuDktE
	7J+Wt5zxFGQ1FK5VsACTVDN1One1Q0yL955khHl7MLURVaLzH6nFoOf4OzIWdtHeJkXB1KuYonal7
	lSaPcb4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XT7-0000000Bdyj-3qhP;
	Fri, 03 Oct 2025 04:32:33 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XT5-0000000Bdxd-2iEy
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 04:32:32 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so1403576a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 02 Oct 2025 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465951; x=1760070751; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=;
        b=KEEOa31Sz8lWb5miGg7FPNOYZHORHCl48uB0Y4n1+qtM+zGxW9CEGxnkCTbhdcJH6Z
         378OIGEcEg/Y3+n+OnHqcHA4ra2wVuFBXSPkRjoYJ8W+1sbFnD+A7mP4+XXEIPOHWVLs
         Ntx8ZZydLl4CGGvIhT978C/HcLberWErj87CHkW3bhJzkSeYcrqYRFXAA60LuHQctE20
         g2eNlatoD6TCJA6NCn/Sukuz3Q5sjF1p0MeZbIpnHRPd7EcBbSlwKA+br3U/W++gr/E7
         oFEOUnon/GAwtlMkwFCX2EjxXtTbNaAKP7d6n7SDLbs8Xw9m2EJBT5ajgaECekOgSwx8
         pLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465951; x=1760070751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=;
        b=pfqP0c6JVuNj2K0ouHkoTu6JNF3lZtY87NIL44eVqqIDiZ0PUwTQXpW6nUsOuiMtcE
         M+T0fExUpdqdLC0ik98ViTDl2srGkd1FeeYqvbi+PJOhZ32uRfJF22t0mPClsa63oReU
         rlPfKYGfOBzYd5fCYBPCqYsqFF6f2+LPmgzRPHEE21ajVRsE4oiJuKQ7sW/0fLgkKAYI
         g6IJ/aH5OeajaeByRP2g/fScXRViKPmxwKPhyDCtLR52+7ixTQCyO2DIFPBuHrKwvWBl
         LnnlzJqoNEXMATUifHtEK2OvchhJH2CKItyjuH5ICrJAMsK6itIwJLdyuqudr08xkyxE
         jCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAGcY1yeMM0Oo3zxbxor7KnT/vOdoRCsFW11S/i8cPCamdqhfx58X3FmIvBr2PkwNDefrWtU9N5Zdt@lists.infradead.org
X-Gm-Message-State: AOJu0Yxc9FtqCcrhWcfdr3mPm3tjpJplM8gIRe0oAYUyKAvns+oXoGLt
	GJ91kfsNS1iFqsX4uHDOfMTTi1AOsRzJ6HpA1EaXwCF+TfSSiRtTR4gz
X-Gm-Gg: ASbGnct8OybEL9OIfT0NqZfiLJ9RH9z+0Qhnp/83BVqEjvZm8HC2HfG0nqn/tzsb5Z5
	+ePy/IhbPhbqA52dFBiq2OWhHBlRY5vHxDFfRPFVlKInVDDSyreo+qLRXIzoCgur+uE4X50Zwd9
	QLafY0f2adMkO/TVFGjjT2XwngMfESz7u+vwlVSToYWXJ6vHsRIzeCipa+y8vUPLQDHBt9ee5Zm
	rUAPS4wXCdi75VPt9M2D0qFrMqpOo7gX5mga6+YNtjeEtEe4fYGRclIjYJQt1Glp0/26TvhyqGQ
	HfNOgnltj7g8lIewx4nJ2CjIjBj6Ml4g24EaiU5nQdHHYTluZ0K1JYESqsId4KcPAqhTXe7hco1
	Fc/WvH7kqERL9QquZPR8LjfuG6hgx3+oC26xpQ3XyV5tvqxZptW1sXV4/s1fo9Z8og+/2uY6q6S
	dgH7lL4Z828ne9ynVKDc3XizQjkZ96tTjHsJlMRXuaV8R+rhfYZCbz
X-Google-Smtp-Source: AGHT+IGILMEf9Tw/o2u8qdi5b+EnvPskNraurbyacR0IziRkBvpz30elIe0oEPrEq1mEn5hgoKypZw==
X-Received: by 2002:a17:90b:1b12:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-339c20c099cmr2180806a91.8.1759465950687;
        Thu, 02 Oct 2025 21:32:30 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:30 -0700 (PDT)
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
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 4/8] nvmet: Expose nvmet_stop_keep_alive_timer publically
Date: Fri,  3 Oct 2025 14:31:35 +1000
Message-ID: <20251003043140.1341958-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_213231_685154_322777A2 
X-CRM114-Status: UNSURE (   8.42  )
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
2.51.0


