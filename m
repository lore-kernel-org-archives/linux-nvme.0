Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF4EC36005
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qRnlnXa062Pt8IsZFpPDsC1SEIO6IbPVYGDPK4L3Ww8=; b=vCBjDet8HUMmrBqCrv4Ab+M0q6
	Ooa07NaXowKf6KmoDRyhZDZJ4E+FdiB70rUueoNXwfyD0MBN9+uYgWhp8Ya3sc4QK4ejjmvvOW1F/
	IMqTTEWXhucb3grFodxDbJ3jMj5FaO4kgpbI1qNSMWqzQ3xHtaI8bBrVaFatGktjNMKo0V0J7YDB2
	53BO4XQXzyG3vDRp3Gqv9/aRAXJIZ8C8jswbH1PwwxV5XBt1d98mONIPML8zizdgtqw+b1MgclNbu
	RkCsumWkgRzWFkhgxwlcjVBALoqV1y/UWErTQUrQ6sX4bMkLB9CDi+VUP8RwGZUhZzWR8HCzs8CH7
	UaKq1HRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvhQg-0000000FuTQ-3WAl;
	Fri, 21 Mar 2025 18:49:14 +0000
Received: from mail-yb1-xb64.google.com ([2607:f8b0:4864:20::b64])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvhQe-0000000FuS0-1FtS
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 18:49:13 +0000
Received: by mail-yb1-xb64.google.com with SMTP id 3f1490d57ef6-e643e6222c7so276503276.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742582951; x=1743187751; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRnlnXa062Pt8IsZFpPDsC1SEIO6IbPVYGDPK4L3Ww8=;
        b=VsLbh1fkpQEO0hWBjesQBniAiLLva9Oz+6nNgza3o6TnQWFG5msEr4h44FSUUDTn+I
         QDI/TPw5S7gO4gthxUBCwTQPzTYJH6JNME9QxAXKVdl5YkL4fA3fRNtt2UsP2U6Cbndr
         I58iVG18prp15dBUYUVs8Hs1Zw54vQXQA0FYyT1A4SaDH53wQVqQ7zDx1c9yS6waA7RG
         qR2L2a7XsmkOVDfvGx3NC3iooTvgsYy4MENWhfqWR1mkCsI7OSwN5jdiFYfDx0m/jGKO
         cchGQiTPN88Kf2TXNwfer7jtHQuWQkcj4QfGZydtGOXbbfztnVS5JA/3vfDgwIYFKcBQ
         UvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582951; x=1743187751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRnlnXa062Pt8IsZFpPDsC1SEIO6IbPVYGDPK4L3Ww8=;
        b=xJ9Wa4e5H/pSgM+hUNv3O6KaMG/mKn68Kfc7rVVtvXcqtcRjzjc1S13JQgJ2Qv2Lm3
         WzYp3q9ls9uXPpMuZVYDi8aDKJjSXLFok+SpAS0jHuOpIr+id4LSWsygnILPXrMWnsAa
         AH02+zVX1nOA+O8RozqB/6unUUe/gkxfgIVzcjoRb5iY1eErKvu2i07otlucBZtSnGgn
         qRdx2dhAOjo5o1VVuVXINTnH1TqWokYJg7ls2eug4FXsE7R9PLqPnIk8b3DDBXy+YhEh
         F79u2G07Lp1Had1064ddCywbYVbKsCUZGdgGJyBfEP3WWYVsZ+JR6E1C1PZPBoBU0TnB
         irOw==
X-Forwarded-Encrypted: i=1; AJvYcCVjNO2giZkP7aD9HKYRhj5GHhGXND457Dw23gtOU9668E+lC1fyBRBo5v9uKB4++7YK3d2oiRxCiBWX@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9QJ1lxTytca61Qg5Qw1stX3XZVANq5Nv0u09pT9M3TzqN+JQi
	WVujR5NY3Qm+yB4XQaPd06TuLZAm9yiui8ZjrFov0MKSkKyi85vLBopFdnSw5Mss5hg/vGVxbOJ
	Hb7Re2jn4f8aZVodrO2+8iDoCpvOmnbd1TAxoqG+55ADzj9nb
X-Gm-Gg: ASbGncvNxa0ov2IIW+XbRVqm4SxMCokHP6Ah6nvKe862ApO6yKB/zH59Gx47r0PvNSR
	2U1npolvoYtF+hpI5b1aj1/qAL+Y7ScvFxDtaWW9OpSz+gBRHlylEo03UPnuYH5rH0IZ05Mtp1c
	l8KtFf2fSmaoCkKgRtu1rET5D2kK5BZOZo7iZqd5tI98XlxaIGeEFRuhPbfaw+aU9qne6E/yMcg
	oCR45hgYnOBq6FgU07b8bEnvYqZwhk7z/0Fxj7PwfES1msZCZmtebr2PeJP79DnXvBf7BaRgHan
	nKD0qRyyVz18l1p7/Vo6q/bbZdfj0U6g3A==
X-Google-Smtp-Source: AGHT+IHA/F7ZUbUO8zzTMyUKj0OJFpa6I44qHvQ3vYuRPzv9/KJDLKWorZS1G/3i1I2rbpGBvsvGgFxESclq
X-Received: by 2002:a05:690c:ecf:b0:700:a4e1:630e with SMTP id 00721157ae682-700c73ce4ccmr12634927b3.0.1742582950805;
        Fri, 21 Mar 2025 11:49:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-700ba739011sm864927b3.39.2025.03.21.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:49:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B6AA7340245;
	Fri, 21 Mar 2025 12:49:09 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A7758E4195A; Fri, 21 Mar 2025 12:48:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/3] io_uring/net: import send_zc fixed buffer before going async
Date: Fri, 21 Mar 2025 12:48:18 -0600
Message-ID: <20250321184819.3847386-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
References: <20250321184819.3847386-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_114912_371320_C6B9BBEF 
X-CRM114-Status: GOOD (  16.68  )
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

When IORING_OP_SEND_ZC is used with the IORING_RECVSEND_POLL_FIRST flag,
the initial issue will return -EAGAIN to force arming the poll handler.
If the operation is also using fixed buffers, the fixed buffer lookup
does not happen until the subsequent issue. This ordering difference is
observable when using UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the
fixed buffer table. If the IORING_OP_SEND_ZC operation is followed
immediately by a UBLK_U_IO_UNREGISTER_IO_BUF that unregisters the fixed
buffer, IORING_RECVSEND_POLL_FIRST will cause the fixed buffer lookup to
fail because it happens after the buffer is unregistered.

Swap the order of the buffer import and IORING_RECVSEND_POLL_FIRST check
to ensure the fixed buffer lookup happens on the initial issue even if
the operation goes async.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 27cb27b6d5ea ("io_uring: add support for kernel registered bvecs")
---
 io_uring/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index a29893d567b8..5adc7b80138e 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1367,21 +1367,21 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(!sock))
 		return -ENOTSOCK;
 	if (!test_bit(SOCK_SUPPORT_ZC, &sock->flags))
 		return -EOPNOTSUPP;
 
-	if (!(req->flags & REQ_F_POLLED) &&
-	    (zc->flags & IORING_RECVSEND_POLL_FIRST))
-		return -EAGAIN;
-
 	if (!zc->imported) {
 		zc->imported = true;
 		ret = io_send_zc_import(req, issue_flags);
 		if (unlikely(ret))
 			return ret;
 	}
 
+	if (!(req->flags & REQ_F_POLLED) &&
+	    (zc->flags & IORING_RECVSEND_POLL_FIRST))
+		return -EAGAIN;
+
 	msg_flags = zc->msg_flags;
 	if (issue_flags & IO_URING_F_NONBLOCK)
 		msg_flags |= MSG_DONTWAIT;
 	if (msg_flags & MSG_WAITALL)
 		min_ret = iov_iter_count(&kmsg->msg.msg_iter);
-- 
2.45.2


