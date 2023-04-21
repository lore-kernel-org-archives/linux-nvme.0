Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19FBC77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WN1a9qjYlcYgPTY0hc5IEgjly2tOgQNpSE3+CEiG+wM=; b=RH6vj6WyDUCmiZYSNMrsbso7Ue
	jajs9gOBXWZ7nrSEM6SOrSTX2RdmGYVxK34fPB/mVpP2DkMJLR0lXxt1g7K22s3XhtkYJOEJW9ajb
	n6CObZXJYw6zQrNC2W8iVAUM8cO0ohqERkR5SsNFSsR/xK5KaLGUzDp2azvg2ZtwfKqjA9S+7akZo
	qzvm1DchQ+37gPX+PSpSD+wdVpn5/CKqnseObWB+XL7PVD8N9OxiAWqG0KxceYaJPKE46Qtxzdbtg
	PU41N5+6qrLuv+JO+a3TLH0vSSgHGp/cE9jIBjB83KkuBE6YqrwUr5DCtfP216bL7OE4NKnY7m/du
	xelp/CTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pppEI-00AmGp-0m;
	Fri, 21 Apr 2023 11:47:06 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pppEA-00AmBT-1Q
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 11:47:00 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-2fbb99cb297so1495783f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Apr 2023 04:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682077616; x=1684669616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WN1a9qjYlcYgPTY0hc5IEgjly2tOgQNpSE3+CEiG+wM=;
        b=K7587/om2D9l70wW8MEL7iP7QPcveI0RxStNJfU5Mb5ar7XhrdPcjNNVOsLUlYIqnn
         zp4owqAbcfwQetVHfgs4ohX/gXeX30wjDZb2VF7yVrQNEnCGHSngaSHoGFy8EDcuKc5v
         3XbNANBYWf/qBmJQ/vnWWXscrvWWITfI/mtSJk300JnN38UFzcjbE//eXH7CD1VcKzG8
         8EnVI16ePMxJr2eYiKuwg8N///WKtGT0dhSEDbjkVHo1WfUuHBR4Xxg+icsn/22D8Wvx
         gRSjZJazkvjC4MubhKFxEIdLdKmcK6/g4fRmh7yd8vMd8jnu3icJzjzabJ033hHOk1rR
         J8NA==
X-Gm-Message-State: AAQBX9cS7wKziFdSpcOpkym4Dg0Xc4gxNCM4GWSaWB1Li4YyvFMFSSPu
	ZaPLR5DD8s00rvxNmsyZCGU=
X-Google-Smtp-Source: AKy350bj/M9uE43aCCFw0bdnZTRDagfpxVwl7LnMkodGWH5LscF60gQsvqBCCMPPMYU9UkrWC1eaJw==
X-Received: by 2002:a05:6000:18c3:b0:2f0:2e3a:cc04 with SMTP id w3-20020a05600018c300b002f02e3acc04mr3478378wrq.8.1682077616595;
        Fri, 21 Apr 2023 04:46:56 -0700 (PDT)
Received: from localhost (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003f1738e64c0sm8052309wmq.20.2023.04.21.04.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 04:46:56 -0700 (PDT)
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
Subject: [PATCH v2 1/3] io_uring: Create a helper to return the SQE size
Date: Fri, 21 Apr 2023 04:44:38 -0700
Message-Id: <20230421114440.3343473-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421114440.3343473-1-leitao@debian.org>
References: <20230421114440.3343473-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_044658_495648_1D86B559 
X-CRM114-Status: GOOD (  10.13  )
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

Create a simple helper that returns the size of the SQE. The SQE could
have two size, depending of the flags.

If IO_URING_SETUP_SQE128 flag is set, then return a double SQE,
otherwise returns the sizeof of io_uring_sqe (64 bytes).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 io_uring/io_uring.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 25515d69d205..25597a771929 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -394,4 +394,7 @@ static inline void io_req_queue_tw_complete(struct io_kiocb *req, s32 res)
 	io_req_task_work_add(req);
 }
 
+#define uring_sqe_size(ctx) \
+	((1 + !!(ctx->flags & IORING_SETUP_SQE128)) * sizeof(struct io_uring_sqe))
+
 #endif
-- 
2.34.1


