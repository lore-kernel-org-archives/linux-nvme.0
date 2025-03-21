Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513C9C36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVXOFSIvNRMFYjPBLLvsP0Qii/nfc/7BrZwWwlECW8U=; b=P49UrVtbMBgwUSWIJ4MkQceCwd
	QiKG1wXnYFrtgTN/CNZ1UlPkHfdato5GctOLI0y/IT5YpQBsvz+y2MidlJ2pw5W8gYil/u6c/xsZI
	oDXMMai2xHf9e9Xlh8VE3CggxR/AtMG6Dd8PM8YnPjI21f6COjk0hVmXwyYntlM2OEjNyf/n5jFG4
	I7vmWkQhOfEMaTCpcSSgeC7HrcoNpIDfzT3r2zEwISaW7xITZlPS/a3ElQUoLUUHMi301/UrI+m9/
	X4v3nZkwTwjRSLgNYzT2G0MGaYez2NaaGuHvztmB52Joyf3r2QvDaqfZdMw+0NvIr/uTWyLxRfdDF
	FZFoTZVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvhQe-0000000FuSJ-2TTc;
	Fri, 21 Mar 2025 18:49:12 +0000
Received: from mail-oo1-xc64.google.com ([2607:f8b0:4864:20::c64])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvhQb-0000000FuRA-1KJO
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 18:49:10 +0000
Received: by mail-oo1-xc64.google.com with SMTP id 006d021491bc7-601c848abfbso183154eaf.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742582948; x=1743187748; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVXOFSIvNRMFYjPBLLvsP0Qii/nfc/7BrZwWwlECW8U=;
        b=bAVdnZEWY7F32jp+NiTRC7q/BxtpPf/Zqt62LpDt5dJ5NfmwJMH3vAjYzYAKmLFRCI
         UFXcbR2zBuY40hZZS5AoqGy0FuKbcbc42SM/i4xhuPrzX/NvopxPehd+5piGHUa//vFk
         NGF1R2/UgtBSbIsX5zVYpjhSmRzjAIEISO2I8nLoearx0spQzDJ+j8padiNkiIcbWcjr
         hVUqAThAIZwvMzhGzbq+8FrVO5OT10/IQ1dGNBwZbuoxx+N58kH3AwSXBwddHZ31gVsR
         rrH9kGSEnxwyilieqzCntRCTPrG7CixoxRS6dJyX1W2pjCF18ellV/azkrj5JVz25v4A
         667Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582948; x=1743187748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVXOFSIvNRMFYjPBLLvsP0Qii/nfc/7BrZwWwlECW8U=;
        b=EfHV7QiuXgnWzp6D0gHqUdRwxNE7WzbkZIZ3FslFzVyDBE/Z13SNUhIoGovHWzcyJ0
         ePDF7ROd6K+IZUpvDUSWKItvevW1l1Qt/8mbigvJr7tJoWty7e9dZuCq53F9R2T0Yf1g
         CfKkzbKxC1ApA/8L5qsph71WBRt9DreHvBLMN7JEt6NaCQv/7zAVI9MWDXSgCKNnjGf4
         vlsBW0TIXqARKRwcBDJfwSzQzR0dAR0eU8whz7Th/ul5q06bvVxQtRGn695lUWt+9Q9Q
         DVD9T2a/h7f1/kXXTmShipANB3FyBHPmuxgZXOM0OcecRiTpiyj92LZCMgzlUbpdNPSR
         JjLA==
X-Forwarded-Encrypted: i=1; AJvYcCWKuhEFakIfZNK5mcyMgvXiWi7rHrwZEOEb+RPOSkHj+AWNFoYWbStpFtkJEGpBJbPg6qAcPzSSciR/@lists.infradead.org
X-Gm-Message-State: AOJu0YzQW8GuvjlQfruj4nqffJDufkp0OcJmKICoUhNX9wHV7GaxIy2w
	59rVIiFcmSjtrOuNu6X6FgixOvhqyZihAfil/BxM1cvRCYwWvBxRq586F7byMgTOq7QIVe5zjHu
	GMEoga71oJvBkHdqT3i9G1kqCxirRujuWQOBZ9hEtGqS8ByRV
X-Gm-Gg: ASbGncsreRhDnyiA7qK8T3OwSmvpOFMZaVACRMG2QJqIiQpbkQ5+bulZp3wRa+as4Qe
	KKkUr/0ZlH3l72UUEsGl6ZC7kS0vM8NVW/5sEPzlsP2jbq4dAiTYe7OTyTyXQWk2qUU3MCzTf2e
	a1mXw2BtixLEMUsXSDCDcDvE1/Z+rluUD794kES8r3Y8pr8CCNXbXxSD86LfajAfT5D0bL7/O1E
	/r6B8nuxKKTOntKXqTQnZgx8upC/0SmK+f/3eM9f+7G2Pk3NG9+yLlLmPKZ7CS3sBs4m1qKO1NF
	WGGRLTxFnZ/HY4Pz6k5pKoYAB8Xj/UQeDw==
X-Google-Smtp-Source: AGHT+IEqvuOOYMmlzyldh84Pi9ajHdpqofupXAF4kcQ30tohmz/xvgicdhHjnstZUDim0CopywzMBqPAovBY
X-Received: by 2002:a05:6871:153:b0:2c1:d224:bcaf with SMTP id 586e51a60fabf-2c7a3620a44mr159676fac.11.1742582948165;
        Fri, 21 Mar 2025 11:49:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c77ebc0b6csm96315fac.4.2025.03.21.11.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:49:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5C88E340245;
	Fri, 21 Mar 2025 12:49:07 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 52B22E4192A; Fri, 21 Mar 2025 12:48:37 -0600 (MDT)
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
Subject: [PATCH 1/3] io_uring/net: only import send_zc buffer once
Date: Fri, 21 Mar 2025 12:48:17 -0600
Message-ID: <20250321184819.3847386-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
References: <20250321184819.3847386-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_114909_351429_4485FB91 
X-CRM114-Status: GOOD (  16.96  )
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

io_send_zc() guards its call to io_send_zc_import() with if (!done_io)
in an attempt to avoid calling it redundantly on the same req. However,
if the initial non-blocking issue returns -EAGAIN, done_io will stay 0.
This causes the subsequent issue to unnecessarily re-import the buffer.

Add an explicit flag "imported" to io_sr_msg to track if its buffer has
already been imported. Clear the flag in io_send_zc_prep(). Call
io_send_zc_import() and set the flag in io_send_zc() if it is unset.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 54cdcca05abd ("io_uring/net: switch io_send() and io_send_zc() to using io_async_msghdr")
---
 io_uring/net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 6d13d378358b..a29893d567b8 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -74,10 +74,11 @@ struct io_sr_msg {
 	unsigned			nr_multishot_loops;
 	u16				flags;
 	/* initialised and used only by !msg send variants */
 	u16				buf_group;
 	bool				retry;
+	bool				imported; /* only for io_send_zc */
 	void __user			*msg_control;
 	/* used only for send zerocopy */
 	struct io_kiocb 		*notif;
 };
 
@@ -1222,10 +1223,11 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *notif;
 
 	zc->done_io = 0;
 	zc->retry = false;
+	zc->imported = false;
 	req->flags |= REQ_F_POLL_NO_LAZY;
 
 	if (unlikely(READ_ONCE(sqe->__pad2[0]) || READ_ONCE(sqe->addr3)))
 		return -EINVAL;
 	/* we don't support IOSQE_CQE_SKIP_SUCCESS just yet */
@@ -1369,11 +1371,12 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (!(req->flags & REQ_F_POLLED) &&
 	    (zc->flags & IORING_RECVSEND_POLL_FIRST))
 		return -EAGAIN;
 
-	if (!zc->done_io) {
+	if (!zc->imported) {
+		zc->imported = true;
 		ret = io_send_zc_import(req, issue_flags);
 		if (unlikely(ret))
 			return ret;
 	}
 
-- 
2.45.2


