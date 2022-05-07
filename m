Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3F9C433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  7 May 2022 06:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QReXyHcN++8ZnG2EAL0MCJ6b3jaE9j2fBL439Rjlnbw=; b=Cc6jsKVrMknzeXApAFT/g05hyy
	5wpVUOf5mgIaZT2ueWFbaBhff9WiCyYnv/ii45wAvtXgAhlGWlGqHs3q7+caviGdQAtijyr9pRsVh
	Kk+nQiCGFYemfhiOUAcGxcairW7LZ7qAEmf7hPhO8x/nDhR4GJrRHzp0KIZ5YLAmAFHz4wXIjMBNq
	xsEaUllEIq3wpAqfck6NZ3R716MQLZR0vp6JcYXJKibwDJYUxU3t7Zl24NGTXZX0P4fLPlb3STiyx
	2Svtqesmjx1bNCkAE7SS51sU34f/nYCKEiI9uQFDg55T77Ey/ESawkJ6lBexIiPDAnH1jZdaEnszx
	KBLuTulQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nnEKv-006IVy-1z; Sat, 07 May 2022 06:54:41 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnEKg-006INv-3n
 for linux-nvme@lists.infradead.org; Sat, 07 May 2022 06:54:27 +0000
Received: by mail-pf1-x434.google.com with SMTP id i24so7995339pfa.7
 for <linux-nvme@lists.infradead.org>; Fri, 06 May 2022 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QReXyHcN++8ZnG2EAL0MCJ6b3jaE9j2fBL439Rjlnbw=;
 b=s+YUi5RX2rfgtaYeELXxYjzxZHhXeqAlxqYW841Loi+QpDbMl5CvQr20fAZ0/+sGh9
 r6ZG2cvgzgePuBm7irTI6/W4JXSG4flFw2g2YtS8llhCdlcV6hjxybpSsf2Rff8VPgIP
 hL5wmIWP8rnKLApA3ZG8UcxzrGJg4iZd8vslmn9fq2xxX9+TiquMWpEVtVsfL5w6WVrq
 zCC/RLz+12TAFjewEH0u0bzgkVYRDGaLF9qGmGHCeTqhsX5iHZwBIR2LoQxEdMH+NqT5
 QWLsDOP2R5W8aOSmStQhtxsen1knaqqEOFNxHVD95UR1vx/5yxQneV9RvWzvVnoA7edS
 WCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QReXyHcN++8ZnG2EAL0MCJ6b3jaE9j2fBL439Rjlnbw=;
 b=5M5rI8baMmUjzPANfmb/UZAhVGnK97N+JZ4iQJmSIHT0cdUSEC54JckCU0nnkbDOKU
 6PSoDG47tXiuNtDXoVYDsxTQJ4IbRZ/GloaNGH0+ovWhzlLdiKGHey5pJEBVEWL1KI5D
 kUMWA8321OidUTSN0Jjc++85nbR8P9NSn6X8z5FmKYWQ3mBH6bP9RDQmrYlNmvlBMa1r
 a3ZXmHQIipBFtXGnTmjPGJKE+AfdRLoDf0y9EosNa8lwD2knBocbzBT9sT//DgCdWGeV
 /WTyLa7Plv3CWTEkd5p6F6QKxiJBZofsM/rDNEfPTjPixklrzOByivNZERliaHcc5StP
 xvuQ==
X-Gm-Message-State: AOAM533FZ5mZ3yPl1WXl9gPq7K5RaD1VNb17ZrJs3nVUva0AJxBlj4PN
 XhlzXpAxZ9S3Y0QDeWErpHERAQ==
X-Google-Smtp-Source: ABdhPJw6SAxt8Mk4xZLntEaQck4s/Gg8DeKj51whay6UwZPAno6fleXHlqMOPIazxWlobmQT4EEXyA==
X-Received: by 2002:a63:4d1:0:b0:3c1:630d:b6b with SMTP id
 200-20020a6304d1000000b003c1630d0b6bmr5767272pge.623.1651906465566; 
 Fri, 06 May 2022 23:54:25 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a1709027c9400b0015e8d4eb1ebsm2905162pll.53.2022.05.06.23.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 23:54:25 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kbusch@kernel.org,
	hch@lst.de
Cc: sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/3] nvme: introduce bit 5 of smart critical warning
Date: Sat,  7 May 2022 14:50:24 +0800
Message-Id: <20220507065026.260306-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_235426_177520_705B8B63 
X-CRM114-Status: UNSURE (   7.57  )
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

According to NVM Express v1.4, Section 5.14.1.2 ("SMART / Health
Information"), introduce bit 5 for "Persistent Memory Region has become
read-only or unreliable".

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/linux/nvme.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f626a445d1a8..882ad7523127 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -662,6 +662,7 @@ enum {
 	NVME_SMART_CRIT_RELIABILITY	= 1 << 2,
 	NVME_SMART_CRIT_MEDIA		= 1 << 3,
 	NVME_SMART_CRIT_VOLATILE_MEMORY	= 1 << 4,
+	NVME_SMART_CRIT_PMR_UNRELIABLE	= 1 << 5,
 };
 
 enum {
-- 
2.20.1


