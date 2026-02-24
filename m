Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BFDF4BB62
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=; b=AoehWEZ77BcXMYk8YLN60XBqR+
	e0OgV/Gz9Ezi7KJLyjmBhyvboQe7zlz3pocCB4vfd952HUEUZkDfJWopO7gfDrCx5lv7ggfYideBp
	i89zjKg5GJM2vU7qteX2I74yL9CNTaV1SKTUtXHLd/AUzzJ9AtSy2oOJ3qgTzu2HtKbbhKAzDRA1c
	gHvP56HEq5+OftSK1HMCyPYSW4+mPfDRNZGZJFbXbDxJg7TjD/8hN6HiXOfYQ+hH3MspApxVZv8/q
	fb2hVI40o7iWB1OfrXTHP9qv34OT4z5kc9peRDstswrtSNo2LSO2CdP4RCnaWGh0vV0jkv0mKqIZT
	+34sdt7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw06-00000002SKu-1c1w;
	Tue, 24 Feb 2026 17:15:10 +0000
Received: from mail-pj1-x1064.google.com ([2607:f8b0:4864:20::1064])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvzz-00000002SEv-3nYe
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:06 +0000
Received: by mail-pj1-x1064.google.com with SMTP id 98e67ed59e1d1-358edc54276so35355a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953303; x=1772558103; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=;
        b=MhDlAmj8rru4vySUY0grWjJfPMKBNw/8GcAZfa8N8h47+WSEk1Vy7XKzV9FoZ9MWlf
         w/UsBC6GGLSoWilkfWT1L7HKNiJeML99bFe3YhedBiP94rFHbYCNwqg6V3oWE6Kcu2nq
         iUbpRbr8U9n2CFQndmoXtInpY0n3Bmu61hd3QxO35Jo81ReODcaS5oI08py84XyJGibN
         1S98tQPBoA4d4JYfdTNiaHzQELRbhfpDA9KV7oSNsqtQx1h4npUfkCWEG5gKRhwYbtpb
         o4QE9iIu5QLKLXYch5sqaGQC6avYiFWdyI3PMGEnQO5cpY1sXNruEPVm6sS6/sqKkCmN
         0Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953303; x=1772558103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=;
        b=Q3W4D1riHB0JL1PQlT0GzZaY3CHz5yJgHi1WVdUYkIsR7QemiBrTVagq8OrXYL03q3
         Wt5wgr+t7HxgDdSyyES/BBmJUd9GPE1vXb2JEnxUcnR0eA+7EQDXg1ADtEgjrt7/3bdE
         5UDSaDre9UF+Zg7p3xkIHT+bBYweHmvoDZ17fcMZOPk0kOoQR+ymyo5wiLHxhwMIMu/8
         SXfM/NzxXfnuzACmKWCjtNYHkWZG95v9NWFPP7zsFw/vUZuKqu34ipigdhFIOzyx2f2p
         rCRZu2EAV3RNJNqn1B0Z+8w/45JABImrKMcztP5lVzziHnsKHVAD2Sj/st2Vbwz1aaeB
         FPHQ==
X-Gm-Message-State: AOJu0Yx81lRdLVwAYhL48QaOL5f5yPK8BsC9hIV+OmYHspKnHMfxxG/I
	+uuLEohAwypYoQQh16oRNMOpnHhAqIEN+3CLQoFDp/Zp0hu6nSIfEoIPUNWQS9tU5K8VXDIqeQo
	nQDDdm4bJetFpMhC5mLdqxMlSvJy4US6GzGGb
X-Gm-Gg: ATEYQzwTl9Ql+b+tfw+McjbsAYH/xzUilCow08Ncb5LqyW/OgedkHnJmYaBW65RJ9nm
	7iuePn+6pNfJkII4dFmM5eA4yBl+oVO9p9DfD97QC8cLujtfmK9usXMWfoWsjYhyfeAkRb2bfGi
	Cr6rQv6hZlywI7mkmb0wlsrz4G5bThhR0LibFksau4JGbnean9gh7HEU5VWSZNt/7+za71kNCWL
	Rd427fmyF/d0O+ODoiy5IbP6t6JjfS0U3mndHsg/bYyzxr0nBuCdL2/Y3Dx/RPu8zf1qsMimGJJ
	q0DibCnkSqToSf+wN56OSbjaNikYkOwhwtpj+GdAVrM5DsZsADxQvo71V1pSqZPVNEHXiFsL1KN
	sySWS9OtRY210FwjJrJyadMQBl+aEPty+5ZnKikiG6BbWxJaIbc0vnw==
X-Received: by 2002:a17:90b:3842:b0:356:2c88:1e77 with SMTP id 98e67ed59e1d1-358ae7c0e88mr8453615a91.1.1771953302898;
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3590203cf50sm56444a91.7.2026.02.24.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A6FFC3421BC;
	Tue, 24 Feb 2026 10:15:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A2C21E41254; Tue, 24 Feb 2026 10:15:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 5/8] nvme: add from0based() helper
Date: Tue, 24 Feb 2026 10:14:34 -0700
Message-ID: <20260224171437.3175993-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260224171437.3175993-1-csander@purestorage.com>
References: <20260224171437.3175993-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091503_963060_C7EB2798 
X-CRM114-Status: GOOD (  12.01  )
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

The NVMe specifications are big fans of "0's based"/"0-based" fields for
encoding values that must be positive. The encoded value is 1 less than
the value it represents. nvmet already provides a helper to0based() for
encoding 0's based values, so add a corresponding helper to decode these
fields on the host side.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/nvme.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9971045dbc05..ccd5e05dac98 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -760,10 +760,16 @@ static inline sector_t nvme_lba_to_sect(struct nvme_ns_head *head, u64 lba)
 static inline u32 nvme_bytes_to_numd(size_t len)
 {
 	return (len >> 2) - 1;
 }
 
+/* Decode a 2-byte "0's based"/"0-based" field */
+static inline u32 from0based(__le16 value)
+{
+	return (u32)le16_to_cpu(value) + 1;
+}
+
 static inline bool nvme_is_ana_error(u16 status)
 {
 	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
-- 
2.45.2


