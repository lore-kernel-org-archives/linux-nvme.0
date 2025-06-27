Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42697C83013
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x3nCWT1NcldcDc8pq8FE8F+xw71Uaz4QUrkXi441nE4=; b=Ai3yxUgdWGZZ8G7OUhqUu8mDWX
	ZGFl0oSmFNh1U3nKl2Jhs/1eyCOK3nc+6EnfMYH7Npv2pWEvczJm7+CU9ZRm7FIMI23eeEKv+5pL8
	rud8kPD2bqLPRIu9Le8TiKX8oCD+/S0M7KkMElYhIpWcOjK0WkZ+svFpS3kkiRHb6VPNTT8D4pTX3
	/8JWxVdOKv7TNgDVL3cHKtIfHuUXg7i390Z+Clk61tomv1uKBBu3j4AqvsM5OH24FA1lv1Z7s4k8R
	ENkNY3qdkYnedaoJshYt98e9arHEydQmGq/fw390ElZIdpR+38hrFVjaQp7vAmBc6YLBSQVKv7NLJ
	kQFF2uzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAv7-0000000F4DB-1Wza;
	Fri, 27 Jun 2025 15:23:17 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhd-0000000F0vk-0xna
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:22 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-60c63a9bbabso3926215a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036960; x=1751641760; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3nCWT1NcldcDc8pq8FE8F+xw71Uaz4QUrkXi441nE4=;
        b=NCUuncgH4p4wfFKpDo41czPMoGmrRkMfJibjA7r6z1SA1sjljtsfEwn2m82ptoEVtc
         gB7poUji9RGCmK4N8VDV1zF1e4gv49xYK1msl5acAKPbhLy0UMRwNJ27Wa2oz+GVzNey
         Ga5EBgATk+hogqBogc6aLWX3adihpKUkwkMBOCYXfdO5BnryIMcQvlfR/PmVJff1LlMM
         mvWUol0PAK8RhfilFJaPGGBVjvC+VvxwjxSb9CjhhyNSFHWbXYiUTzPq/qW+N6AHuto1
         CI1GRoPMWKSRqMzZ3VOPh94tGtiB1UrTE8lY9gIUSGNfV35oLl9X5HEkchOwFxStu80r
         2kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036960; x=1751641760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3nCWT1NcldcDc8pq8FE8F+xw71Uaz4QUrkXi441nE4=;
        b=bz+pDNwStJtDevn6lsFS7O6RK5dCsddkvegqGVfMbsjd6A5kB1KP+2AIX8BRFSk2QJ
         3LW2zsE3FdeI0AdtBm3Ly4huV2tcq/eMvC6z4tIQA11gPMKsPaTWyF0GKsIEx6ChDGSq
         XeOADBawlJocqplTmdGZY5P7mksMCneGcWpGsJ+vFgmXWW206m2niHK+WUhvy6TUAXje
         NsDC1OdokRfxSgSrttbUxxrGdJWRYvCN7HgrvwmirsyujVVCJMjUys9GVuUhRXw8ffEr
         1qt9U4amuLq4IY8nflrBRT2IBb1KCIh9lRLmzjopVrb9MVqa08hKWwsRCCrxPbF4WpQp
         Qsjw==
X-Forwarded-Encrypted: i=1; AJvYcCVHHKROcboHkrPUH0+Ieq6CihnSpfMYRw4woV6qsqUzl0q7vNDo/F8XqUPjAExN02ej7BcmXi7GCB6r@lists.infradead.org
X-Gm-Message-State: AOJu0Yyc1onZm2kj7j8nwUsRW65Ht9FEIH4JG8TMIulp45poee9/Pt/U
	7sn1avTGNOdOSPDQSes9pI8QEoZbkP7iZg1TrewvBjYEnTqbgn7CIZze
X-Gm-Gg: ASbGncsiwF9ijNXfydAhWjdAEgG3JY7nzAJ/a2TiX+batanfgkZbuRJe/oPqHYLll8j
	1EKiT6Dob/8W6Ypt8GIiiezOspbzpnZVcvJxvSK+26nZHDs6IP6KeMcR6RNmyHvin9T81mZ8qbE
	maZSnVpxi2eGEZXrnymHc4vbk5/0fkDXy+YycGbBgclKFLWJyhDoSYQXdffYYHw8PMIJHQGiNYB
	H25S8bqnBECxD5tS51sXODQwAfMNXTd0aEYzyTWP5pPD1OlRm7LuHzAfwxR5Mwd0hLwaq+XAc7I
	+wNiHWJuhsGxviJ81Yvy1PjZvlyqsfIjPS4pG5eg8yr9F8mqtj4qER9ROpJ1UUUBGcCN6QxYoEP
	x
X-Google-Smtp-Source: AGHT+IGmvGAQOzgfukcAiQmiXttQr0NA0dvGdxOdGJDKKIcTaii3K7x3hkWnoKCC5+pogFtMy6rD8Q==
X-Received: by 2002:a17:907:94c1:b0:ae0:c606:78d0 with SMTP id a640c23a62f3a-ae3504c8ccdmr293381966b.23.1751036959167;
        Fri, 27 Jun 2025 08:09:19 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:18 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 01/12] file: add callback returning dev for dma operations
Date: Fri, 27 Jun 2025 16:10:28 +0100
Message-ID: <4f8aabdbbeda098424556259d69932200464a526.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080921_265956_53DF2D0F 
X-CRM114-Status: GOOD (  11.25  )
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

Add a file callback returning a device that can be used for
dma pre-mapping buffers. There should be only one device per file, and
a file should never return different deivecs during its lifetime.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..9ab5aa413c62 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -82,6 +82,7 @@ struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
 struct iomap_ops;
+struct device;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -2190,6 +2191,7 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	struct device *(*get_dma_device)(struct file *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.49.0


