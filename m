Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440B9FD8FFD
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=; b=UYYK2qpcn7HfjWuKBjoE/fggV+
	leClILAU2xPPw5Q33SdB6p7Vc2kxbKdqlLZeFHtf/IpXgMd7wIXFwarceSjjuAAzF3k0gEBeenf9m
	PtS1dHI8Or8Ev5nqrlkoJrbs5eJkPj/eA6W0DP9p72PxyDRxj5Fmwu83jxCzRCdxMQ/POlpZXK6UY
	PtOvnZTXFWiBwv3rDeSD+zAtSIYr723To7k+j0bNTv92sSS8/OhEFpl86xxFQN+nx8cB2STEwD6gH
	qaUpyEqHKlP1webTjIW7Gv9Wh6cbcXna4jVQBgPKauBvM+fNhW+MEhG61tqtyvfnYFcMViyOg2rPa
	iUpDqQgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgey-000000070Wf-2V9N;
	Thu, 26 Feb 2026 19:04:28 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvget-000000070SQ-0g8X
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:25 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-2a8fba89cb5so957445ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132662; x=1772737462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=;
        b=IiT3yHXxaPtfnTXDMS4n2/oofdAeH/7O+dMP9u2tncJ+wcF0J54Y4FjGZ5gqY01+IS
         PFIzKgb9snCs5SF6K4kdsJHVljSwUMbfF2jgJL79gjgZ4E6Is9X1dZ4kk2hZA88Jh4II
         Y0MgHHBwZqaGtYYA/u1vphL+Ndt+uP6VsRZgIeGar7DHoGrbohNeKBHHCdgpaZaIQtD6
         PVOI/BzV+fT+LaqpNgUqfKNxtzykdYZqrI5bgFkdnT45rfCU+18HVf4MvPlDVUfG6M7K
         sfGtxEydIKh/xPTmqGaXWK5tPN3RWURari4NXw2XnkyMq67gBDJbrnwtyAF8mScuEOCz
         zcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132662; x=1772737462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=;
        b=GnN/wWE4ToE42e4rqZQHtA3ZUgNgyZ3oRwj8kv1yPmmbFmX7T5g/ACwuCvzjmkzWkZ
         9q+dWIpW7G+PwvIZIAZzy6mK0DEPqxLhktY65ZzyyK0J6i/bc6EDJbLQuCrdQkxcKhYN
         S63Y4IjiKnuEXFJ0plWF0rqklbSpY2sTL6XnNK+YM4LepEf6ojR2IRKZDW1nWaAAKSqG
         RzvpYPDESW1lUQbuJxdQu184hjHs7hXzrFxMq/aTBRHskceTWGLnOApy80ozkZ1oQjJ0
         Xk0shcd+HWeUsG9f4sjM5UBOe4Q6lwHw3+C1qExbrA9ux2S4W5dKMLExwGjCaQIUQfbz
         vo8Q==
X-Gm-Message-State: AOJu0YyV2S6WHn19Zt0enk7uZ+R+SvFdMej7axznmKbSsucaVnNOuc5y
	36RzHCe/j7LcGHMUIjjsO/3atbKU0Hj3/ZKlS7UuxUrWLUKt1BNlYEHu+TX00IAN/Purmx2sz3f
	fBTT2FXFMzuoOVwILqN7UVReFjsjKA6CTGAVy
X-Gm-Gg: ATEYQzx/KBjWGgpxNL9Ca8dbRBmZpDMEsKEzZzPUhGkFmCppGY0cvs4P11gIEFrXJKz
	m+XpwVW1538iq/iyUvccgPa9CO6sSF7PwqyEqvU4qGYmCb3OdzNSX0tR4a75/d19ZhqegNO+mqM
	6DhuQL3MiJoD44e16ixnxc1ehUdTBM0Ymlc4zC04Mp8CSXVkwzGHBvDA+ULMJ9ceIDQXInSePKr
	bdrkJsALMrqW+KFLGdnrCElDWzW3qHvy599rbfe0PvgnqmkMK466IoNth/6fkVpEooNMS+2H+kp
	Lr4DCrQWCWdSIfvjDRupMvVjzq5dvit7qcqplqeOyolFiyG1AEy2/r54l3T4xEnDUoiKeT+Pb6q
	O5xMCpX4X0xJFs0QRU0/vYggZzjnMpHdfVlznhs7a/2GSQjNXSF3mGw==
X-Received: by 2002:a17:902:c951:b0:2a9:5b48:2b1f with SMTP id d9443c01a7336-2ae2e035543mr267335ad.0.1772132661783;
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb2710bdsm3572105ad.21.2026.02.26.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7E3AA342109;
	Thu, 26 Feb 2026 12:04:20 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 79581E41254; Thu, 26 Feb 2026 12:04:20 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 5/8] nvme: add from0based() helper
Date: Thu, 26 Feb 2026 12:04:12 -0700
Message-ID: <20260226190416.297725-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260226190416.297725-1-csander@purestorage.com>
References: <20260226190416.297725-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110423_204074_979991DA 
X-CRM114-Status: GOOD (  11.90  )
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


