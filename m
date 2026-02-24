Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB943F357C5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=; b=n47eB0JcZEy/zqpkNLpaWC7vgC
	IXtxDlC/L8Vh3M1bozdf1PPH1QkHs6cWBZQrGQ2Ux4x5a+CNSx9e0mQE1a9lJRXb+jXmUC9S9eDaA
	Ifs4xvE7ISpmczV7r9YwbkrjVA4DRbfk/nbfRvbb3Iak45Bf/95qJ7HJdW/vcDol/aiB9+VVP457B
	9OulSuLyr/lUjILq4eWOh37n6buHE5WNVomsmaP/aVwRz8y8Qi5sDfEy4rUMy+ZFLDAjXRfSdxJ/F
	l7kwyftu4yQ21DVjRm0QKfpfzLma50UMLuC9ZGEiavG5I+0gxsp3XBR1yuoN1Sb/txCJrdYQyzCDj
	ZLYhYD7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw01-00000002SGu-0TN6;
	Tue, 24 Feb 2026 17:15:05 +0000
Received: from mail-vk1-xa61.google.com ([2607:f8b0:4864:20::a61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvzy-00000002SEE-3jX5
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:04 +0000
Received: by mail-vk1-xa61.google.com with SMTP id 71dfb90a1353d-5675de6eab6so183852e0c.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953302; x=1772558102; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=;
        b=NFkyf6tRcrXMYyBVq1PV1T+Uj29ZGafydXZHIw9+6ivt+WNY3Yb4B39lP7bNO80cF4
         MEOwW34yCPHO1725vyfBJOrr4xdXQj1HZeJm/lBxMHWmYvPaBExDSAIfFuIiRXbx+5Mg
         s3GptAoeSCHVxttGeUZ/iwM3hoW1zKFc7jSKtMc1j2HvZKijApi53b8wIJp2cnEzyKsz
         qkKxjXSkhU+YQh6g4KgLYjeIZAW1Jwk4BPFFZMl2rM+9apOPe3MRnf/DJG5G9Ub9KKCA
         cYgOXL23FiBS29NFImKnnLeDg8Tdz8OtidxU1+Y1CxBEWycTZgf6e8/8utKJmifus75u
         b97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953302; x=1772558102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=;
        b=ZfDCE/rIdz+P+UbyfdfKNvMu88rT0QqWuDlsFKk0U3lrIivd2uNK/M0ym3WNBZVLwq
         nEkgosSyBCzC4MGvEsrXtfOP87Ueg73DZlpNPtRzq7ofwmHydwZ2xLITw5zqpgBl6hrd
         4Yk2oa80dzdsGptWC1zIAqtBZsnhLKDmpvD3jJ5r/DNGRhonAHvX/PD/evuV6G+2kaS7
         xogTH1y9gkN/qCT5JIR5b4pPvSaIdLhkvlX3Q4Sr2Z09TJu+myHgqXngnT/Rgw/jKZMo
         eUlkTijZbpyOxWMNy9gpJuHomjjUP8JTuRG3LNvu816kbplhXKK/6qOclgUUtvYRex0X
         oI/w==
X-Gm-Message-State: AOJu0YwyO9ELXnJlOpqQvZvazaY1LzF8+EZzxz1npZZRLgDAmsMnhvK+
	2pwDuQaGcJHiLSB9p8Zqv5iH4b29ADQomFSIa96omBjvZwdZtMPHW5CxMlFru/tblIx2u7T/Vam
	OT9FP8h/aZlxPEoiA7Lv56w4mWiZADA5M6HBHaWzqWeiLbEyge/Ul
X-Gm-Gg: ATEYQzwg3gjtzJpQdpjScX/1JlyWxK4fdK51SVPWfPzB+CxcL7uwBPWwbn9BKbO8iTL
	53J5JPqPRQkS5A4/UEIIfDBkrJn2aBfMVB04/yBZU/qdgVnOvSZb8z5w8d92v8qzvHjOl0aGVyo
	2oP5XIeLeZfSF+yX2OirJknBcR/d+c6Dr9T/doMtzOqDzDe65rhOZ0g9hctlUCFy4Cr6JWJ3IgO
	CgQPl/yGT8f3KhxZuOJ0hWMXZz/+SpaxFTwOS50LEG8LlQiHNObsOX7YoHuD7YnpunO+ySvCgm3
	ANM2Ywuj/Op4EVGw28SUAJGVgcVkpmF/+p0J+SekzJrNGmt5WZazjamSGYeYZDkCluc3B3vWeFh
	Axbvc1sztmTHX72p98AdDm030izTKrqNKhE/aakQ=
X-Received: by 2002:a05:6122:498c:b0:567:190c:1624 with SMTP id 71dfb90a1353d-568e4885d83mr2152145e0c.2.1771953301647;
        Tue, 24 Feb 2026 09:15:01 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-568e58a4261sm1897823e0c.7.2026.02.24.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:01 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E3805341B66;
	Tue, 24 Feb 2026 10:15:00 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DEB7CE41254; Tue, 24 Feb 2026 10:15:00 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 1/8] nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
Date: Tue, 24 Feb 2026 10:14:30 -0700
Message-ID: <20260224171437.3175993-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260224171437.3175993-1-csander@purestorage.com>
References: <20260224171437.3175993-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091502_956230_03BBCF13 
X-CRM114-Status: GOOD (  13.22  )
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


