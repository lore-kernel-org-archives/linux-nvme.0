Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20171C77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cjooBvMCNJhlavL1EbY+Mb4+Vf8+MK1I5YGhYcyjWY=; b=I6n7obRvGuJGnZ7NQyvXqWOvOV
	qtvXObnpceJdFskL4+VKpnV6bCz8U+jBc75EzvhL5dlC4M2qXTY4395QWBNhScCq/OxkRNZRBUaTG
	gpjS8zmTJztx/3swkjrQUxYNduJeJjU+dIREFbuJat4zQDMfa534AOaPyUYI7/tMql+TyF8VHfLJ8
	BxpzJ21HqIzUrfV84VVDu9nsOK21qbKjvHRFdrTR0ep4OS2XRTQLUgbTRYddSPYFUFTwE+XORoam5
	4HCzFTVja5r0siNtVF/008Miy9wtenFVMRmqSJGcToctdOL90cgTs5ccfHBgkPL3yfGzb8xb1Doaq
	ZYhlSMOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp54T-004wTs-1Y;
	Wed, 19 Apr 2023 10:29:53 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp54O-004wOz-2X
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 10:29:50 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-2efbaad9d76so2872703f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 03:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900187; x=1684492187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cjooBvMCNJhlavL1EbY+Mb4+Vf8+MK1I5YGhYcyjWY=;
        b=cpp+ZINDwMskJRuyst6KEEeTCeuDEg8fNUu7Air8Q+zRouMB6cTucWAvCE41/ytYdQ
         IcOb7sIVAN8nvrEi9rRRFEejNvPxVdh+NP7CceLW96wHam8Bto5Sd9dCsH7aqfbUq2it
         wIquSD4UZnEBq+XdPQf4qmbT+LH7WP+M0542kbFBDXHsmraVBtXroNnswGAqOLxa9Clq
         5TXWXZxBEtyRz8gTjnVbR/UUl4qWg2acn4XYokBjyKwKg6zPXtSx4ZhFlDvJmYPfEqRt
         Erf2ZAot6bQvZKzLdx3UeK4Kw5EZl7wqvEal0/LQkvaFG8F+l4sG4KRlriXn6gdwy/IN
         9C0w==
X-Gm-Message-State: AAQBX9eXoczm7l8MClFh37ERJa9YA4uFZ/nCf+fMshGphq9Hlk0+0VzR
	MG5hTZBFvEItg2u25e08Zks=
X-Google-Smtp-Source: AKy350ZrF9+PU5wlzZyJvzaoxWd8IqaVJy/LdD8KdSkMSbZ5FuQTzjQ/kFdz1vtwzq0yJtgJRJNPWw==
X-Received: by 2002:adf:e588:0:b0:2f9:2fb0:c46 with SMTP id l8-20020adfe588000000b002f92fb00c46mr3516652wrm.68.1681900187024;
        Wed, 19 Apr 2023 03:29:47 -0700 (PDT)
Received: from localhost (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id k25-20020a7bc419000000b003f1736fdfedsm1783916wmi.10.2023.04.19.03.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 03:29:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	axboe@kernel.dk
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	ming.lei@redhat.com
Subject: [PATCH 2/2] io_uring: Remove unnecessary BUILD_BUG_ON
Date: Wed, 19 Apr 2023 03:29:30 -0700
Message-Id: <20230419102930.2979231-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419102930.2979231-1-leitao@debian.org>
References: <20230419102930.2979231-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_032948_824135_060BBE1D 
X-CRM114-Status: GOOD (  12.37  )
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

In the io_uring_cmd_prep_async() there is a unnecessary compilation time
check to check if cmd is correctly placed at field 48 of the SQE.

This is uncessary, since this check is already in place at
io_uring_init():

          BUILD_BUG_SQE_ELEM(48, __u64,  addr3);

Remove it and the uring_cmd_pdu_size() function, which is not used
anymore.

Keith started a discussion about this topic in the following thread:
https://lore.kernel.org/lkml/ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 io_uring/uring_cmd.c | 3 ---
 io_uring/uring_cmd.h | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 5cb2e39e99f9..fccc497bab59 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -71,9 +71,6 @@ int io_uring_cmd_prep_async(struct io_kiocb *req)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	size_t size = sizeof(struct io_uring_sqe);
 
-	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
-	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
-
 	if (req->ctx->flags & IORING_SETUP_SQE128)
 		size <<= 1;
 
diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
index 7c6697d13cb2..8117684ec3ca 100644
--- a/io_uring/uring_cmd.h
+++ b/io_uring/uring_cmd.h
@@ -3,11 +3,3 @@
 int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
 int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_uring_cmd_prep_async(struct io_kiocb *req);
-
-/*
- * The URING_CMD payload starts at 'cmd' in the first sqe, and continues into
- * the following sqe if SQE128 is used.
- */
-#define uring_cmd_pdu_size(is_sqe128)				\
-	((1 + !!(is_sqe128)) * sizeof(struct io_uring_sqe) -	\
-		offsetof(struct io_uring_sqe, cmd))
-- 
2.34.1


