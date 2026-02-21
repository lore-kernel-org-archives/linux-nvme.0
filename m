Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03957E9A049
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 03:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=; b=BSQyEuskGveYuHy4qc0inLLz5a
	2Aerdi3n5sDUKAEkdFm6DDY+r9QaP7rJNeSNJsmIOkvztcf5Ks9frYGhtl9STdBv3ok0KtmLQ9T0f
	OZpVjz9OwBsfKFfC7MfIjHXjOriwyvx12ih+m7wlNmnX0BcQkairXetOefZuXmiULiCMDmdlCtibX
	jAMnbCfB6rReZ9ZcfHnx4yPOsE5arywQLM8JhCaaiWVRUTQ90gF1JDndZDpnC7o4tDeEVlyKYgqXJ
	aRhPWpE92OdMONyz8/pfe6LJfMzWJRR/dXKW3Eaik5IJCCCC05KRjY8ScimzA4AWyyu0JhLKTGQXB
	NpnsUFug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjz-0000000FnZp-1crS;
	Sat, 21 Feb 2026 03:33:11 +0000
Received: from mail-qk1-x762.google.com ([2607:f8b0:4864:20::762])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjw-0000000FnWf-0nRO
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 03:33:09 +0000
Received: by mail-qk1-x762.google.com with SMTP id af79cd13be357-8c711951be3so11597385a.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 19:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771644787; x=1772249587; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=;
        b=T0CF46H2iwt87N8wY2NRGWQSGj+debRBYCqayOu28goF87VodpLW/et5R9iOZUM0RL
         O6KKEQXnvy5ZlUvPiA/Cd+0Yo8wcBmuCfcdVndxNd5QwvA6E/pk7Tno6jt69Il27BoN/
         6NycgPsqVbatzaDog8gpXex3ml0ROXuv8viFftNqgg3o+erkw1xo8xamrJN38Oj6j9u6
         LwUWXqVlK/tjxvHWLMlWnoffNDj2Fx3g7QYfx7EecIAEe1xnReDKJiRrn7I3qKsXirCb
         Lj5GBo+tHIfyvl0nhTwYFRMR4os33czXLPKvEByBSuh5Dc0nfJBGNriZNjCc5noZBXkS
         uZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771644787; x=1772249587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=;
        b=BrpxfEd7FqA9IFODsRv0uMPRGJFRmrKDAeCkxObm+fMt5/xnJNVE3mM40Kzo2e2XWz
         uHZW2f79LfUKVvFLXHkSrxobXuSBfovVFjY+/KJIAizLHOZX3jd2S9mupgdUA3HWe1iq
         rSV+AUaSXkNKmFlulvVpF2MrYWh8Atzb2Lgmk5tptfkv+Q94KShu/qnTSLlbAo22t6GH
         l/lTUUy2UamnfkG1NWzSnlIrLf2WZl4ATgwax0CtZzLkIvsOHVANyePjmgLPL8+TQXkJ
         dO2UXjwfHtVsymMu8GxjjTDkDlgULBC+I9jBiqzT/c+Q8Q9j6vbSRlPBpRbej9H9t8U/
         fugA==
X-Gm-Message-State: AOJu0YwHLaXGkVioqQjayWjQUc8lftbKDhksoQ50U4FpSwCcKlKzO7BS
	ILHCFFgV6kEiLaFlcQsAN2ny5UBU8xLTgJOqrBw03btt4fGZP5PNUgqdwKDAfTo+v7nNyCmZpJF
	NIZBie4DY0u2GkQ9adZR4Z3mstzVp91MnQxkV
X-Gm-Gg: AZuq6aJfoHWekbWj5kYNUgALddsXZuiDNdribWjWJ73DBXFrY750OOvbkoexSXrGPpt
	PTslyjN/CQ5/XmcvDibMK/arNw4E8ZKvVs/J+5qzsaS5absxyZgZ2YSu31armCRNF86dib3OGmL
	mBhUcidkAcMz2hng5yLRB2Y8+PZxPiuhA7RgEK5eSck35X1BUwB4DfYrboEXzVHTOiDNCgeg8kL
	94ufsUVZKnZr5IsrG1EXR5XBFwz89ynj8uzLuEV5gJWyDa6ZeZrdhPFjZS1CxuCVfyNBU6DUcFq
	+ODQLVjRLtt9hOkiSKL9iOTl0KBatQG6HGrS4oPZuPEAYUbXYyfrnN8nrAuD3VF0LnQmbGT+L4R
	QDHQdFfG/AD9Ag2bjEZHLe5M03kDn+8JKu2S5QtcUeoQZpzPEOOC1Jg==
X-Received: by 2002:a05:620a:6910:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cb8cabef31mr182110685a.7.1771644786585;
        Fri, 20 Feb 2026 19:33:06 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8997e637562sm1338636d6.26.2026.02.20.19.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:33:06 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 46FA9340686;
	Fri, 20 Feb 2026 20:33:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 40A81E427C8; Fri, 20 Feb 2026 20:33:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/7] nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
Date: Fri, 20 Feb 2026 20:32:56 -0700
Message-ID: <20260221033302.1451669-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260221033302.1451669-1-csander@purestorage.com>
References: <20260221033302.1451669-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_193308_231389_82FD83EC 
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

A subsequent change will use the NPDGL and NPDAL fields of the NVM
Command Set Specific Identify Namespace structure, so add them (and the
handful of intervening fields) to struct nvme_id_ns_nvm. Add an
assertion that the size is still 4 KB.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..1134e6bf2d5c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -511,13 +511,20 @@ struct nvme_id_ctrl_zns {
 struct nvme_id_ns_nvm {
 	__le64	lbstm;
 	__u8	pic;
 	__u8	rsvd9[3];
 	__le32	elbaf[64];
-	__u8	rsvd268[3828];
+	__le32	npdgl;
+	__le32	nprg;
+	__le32	npra;
+	__le32	nors;
+	__le32	npdal;
+	__u8	rsvd288[3808];
 };
 
+static_assert(sizeof(struct nvme_id_ns_nvm) == 4096);
+
 enum {
 	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
 	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
 	NVME_ID_NS_NVM_QPIF_SHIFT	= 9,
-- 
2.45.2


