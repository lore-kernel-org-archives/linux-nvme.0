Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31C9CFD316
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PR8DhyhbmfM3XR45v/DX3VtwAUQ7pza2V3aAfSC4t8o=; b=TPE87BS/b/6i9gsTGIwdsSkO7h
	zDYJILwDJDx7Trx0rN1kFvzahW/Nysq/i0+iGdRTbnevXUIjOXLM45pi1FCLkuf+CMnVBoGzmxK6Z
	djDYl4I6ASs/7gu68eMcmby29uvO7q4F4As5LEGOJPHR6rKAwjZ0JaBgQ75TrDfBjNCATJLxn2Sp0
	w8TPiHoxDhBTIYlDvm/uw2xMeK78+JYC8yQ9ZuR2Zn/Pc2eVDME8XO0QXhILMSYpzDi0vvFd8fuXN
	kc/9MFqPCV17KX2rmjBEjOQ6aVLwkDxtnEcRAPQ7dDugpuBCG0MGcNIn6gS6plTuhzIB5TRU8uEQ/
	4LpIhe5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvp-0000000Akg6-33dP;
	Sun, 23 Nov 2025 22:51:45 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvn-0000000Akfc-1nCe
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:51:44 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4779d47be12so29010585e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938301; x=1764543101; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR8DhyhbmfM3XR45v/DX3VtwAUQ7pza2V3aAfSC4t8o=;
        b=hz/GnHFyst3fj61b3HOLI5hprs3tNhfQhQ40HGgfvMy4hwZ5pbd1szk10kCt31s4Wq
         yhD9f4+g5P3R5xTsGmL7VFodVwQx8LLyXXEdM1SkJ9Tl/8rqjTvJhXTLPIG69Ajob35Z
         NEmRRYHosK4i9JcSQ1ULAQyGiEr7N3vphWRf4ADjLfmVRyA0cSEcFAdNpBwUgzGoc8Sh
         KZWUNzNOh4tTZky44fYYINoOKq2Y416rIsyF5RPplHdWdl+y3UITNvsmUl9AHQESbtIC
         873rZyU0zU2XPClERd4R1APsbB+hO4qAtbisWjO7o2NRWDgWly/1+OeJAFEujCcDYMvR
         nkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938301; x=1764543101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PR8DhyhbmfM3XR45v/DX3VtwAUQ7pza2V3aAfSC4t8o=;
        b=kpatgE2cr2wpjvmMKpn+PJ6At29OwAnR1eNVHbxm7vRt5vNScC9AwtfnKbQ5D7/Q7E
         4iEK1bs55aDJGxBT0QLPqZIzVahydtGaEIu2bLQhbWZ/J9KErcK4t9nF6xtOV11kulHY
         a3uVccUH/IZskC0Ly6UHa61jSXmTXJsanEZvp+GKjioE3/D1icFmG8pgTrJL6lWxgjyE
         bgoxNdRg6DaiBvhV99EwDQAQQSxIKO6H+nRfLgFpunIzyRWntBUBEzwsyKUuWS/FLu8q
         x4OSjo70pGzBE/D6LPyhY6mknRn0yZ1q6t9CI4xkyLQf4LgBx3yfu+he2CGIQ4moxUpe
         tRMg==
X-Forwarded-Encrypted: i=1; AJvYcCUgL04jUNprvTgY1YCdsKy1ahDclrjuzqAHlMciQ2oDDqjQEiVJRuRohVPSdnANjZrQ8s0HfcQySGJi@lists.infradead.org
X-Gm-Message-State: AOJu0YzUzNdwRvHQPr0E3IZPr2ceODcYWm/wxdfje6pXE/u0tKc2W5Bw
	OR44/jv1FH2+pUM2QAVEQ/fnDeh4wNhnP5ELQ30CHm+cTX7ldcMztgEM
X-Gm-Gg: ASbGncsv7CtCuxinAOT9ph5ItDKkxp5n+68eGkRnM7HWnCTOJo5bqQgr2gMCL3pWhz6
	2utymgHmYrFEVghCNJkh3Uwjr9+wbdUXUlGiVvZWKYB4zEIMITqDkgwii/FDneORe/j+yDA3Ym5
	8wkZbA6mAysTtHNgmqg5IN//2l/3RYFIlb2vkofQyf3SU5ZCgKkYxDuGqwMu4eeHTm9pD2xAVdo
	kelRf5X3lMwOL70/dFRUxnkD5JGu0QazRUuKD06MRO4IhvCh34zzUIOYVZml/oJvJCtpobBi2I1
	NZOUw0K0BQ2hRLzeNQBrnrWhmLKprsiaxDJdHksIyc3LGDWjK7OlXyvKeBjRNJuchfJLBGJODiT
	7zEJqZuv+cqXJA2vgXbvy+DUuuFZsCT8rpKcUjikx3JMYQMezvP+q/b/GWcTAL4YGPqi10Sd3ut
	NEsbH+fJnLx9f9Qg==
X-Google-Smtp-Source: AGHT+IF2fkOx1psmIiI8t6n1UVP6WxxL86e2rgF4bc5zvWBkXEsJkKhYvtgfzcrreOJ89mrZR3pH7Q==
X-Received: by 2002:a05:6000:40da:b0:42b:47da:c316 with SMTP id ffacd0b85a97d-42cc1cc30c2mr10114899f8f.26.1763938301503;
        Sun, 23 Nov 2025 14:51:41 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:40 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
Date: Sun, 23 Nov 2025 22:51:21 +0000
Message-ID: <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145143_480224_3D84F6DA 
X-CRM114-Status: GOOD (  20.83  )
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

Add a file callback that maps a dmabuf for the given file and returns
an opaque token of type struct dma_token representing the mapping. The
implementation details are hidden from the caller, and the implementors
are normally expected to extend the structure.

The callback callers will be able to pass the token with an IO request,
which implemented in following patches as a new iterator type. The user
should release the token once it's not needed by calling the provided
release callback via appropriate helpers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/dma_token.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h        |  4 ++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/linux/dma_token.h

diff --git a/include/linux/dma_token.h b/include/linux/dma_token.h
new file mode 100644
index 000000000000..9194b34282c2
--- /dev/null
+++ b/include/linux/dma_token.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_DMA_TOKEN_H
+#define _LINUX_DMA_TOKEN_H
+
+#include <linux/dma-buf.h>
+
+struct dma_token_params {
+	struct dma_buf			*dmabuf;
+	enum dma_data_direction		dir;
+};
+
+struct dma_token {
+	void (*release)(struct dma_token *);
+};
+
+static inline void dma_token_release(struct dma_token *token)
+{
+	token->release(token);
+}
+
+static inline struct dma_token *
+dma_token_create(struct file *file, struct dma_token_params *params)
+{
+	struct dma_token *res;
+
+	if (!file->f_op->dma_map)
+		return ERR_PTR(-EOPNOTSUPP);
+	res = file->f_op->dma_map(file, params);
+
+	WARN_ON_ONCE(!IS_ERR(res) && !res->release);
+
+	return res;
+}
+
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..0ce9a53fabec 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2262,6 +2262,8 @@ struct dir_context {
 struct iov_iter;
 struct io_uring_cmd;
 struct offset_ctx;
+struct dma_token;
+struct dma_token_params;
 
 typedef unsigned int __bitwise fop_flags_t;
 
@@ -2309,6 +2311,8 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	struct dma_token *(*dma_map)(struct file *,
+				     struct dma_token_params *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.52.0


