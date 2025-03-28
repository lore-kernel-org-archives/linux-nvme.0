Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1815C28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gt+Qb9IbUDqMOWgjJF/41cbBN6cQ8nnHS3i+KThbO6c=; b=ZBr2R9gsCcVXo4Bvs+RX3TjpLX
	E2+DUG7zQmNP5O/pw4ugxEMTsLxMcI5HKhfsjIoNBT8QJ8mFLvOwii0XfWAfDvaBMWQt31UB6oaHF
	D4vbIshQSr/JIKCS5hFfuBivHmDN8MeKMAnFEDUZNcPFAWV0XMm345avHlZsCHWJxqraR2sNCeLh7
	tiV00lDuRmtZa8F+8l0d6JG/2u6tg2oaAQioz18pzf8ceG0rLzsVs708j75DpBPwsfc/wSd01YMwD
	nzla/5sOD8BldTNaVfsRu3GQ8PxbF7KAfKmdNWWhB+Vod2bjGHI6xQjBgePakIGv3nnGvKVsrJ6pj
	N1oK8H4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyC2N-0000000DpGB-18x1;
	Fri, 28 Mar 2025 15:54:27 +0000
Received: from mail-ua1-x961.google.com ([2607:f8b0:4864:20::961])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyBvQ-0000000DoB0-1YlE
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 15:47:17 +0000
Received: by mail-ua1-x961.google.com with SMTP id a1e0cc1a2514c-86e48652bd4so106461241.3
        for <linux-nvme@lists.infradead.org>; Fri, 28 Mar 2025 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743176835; x=1743781635; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt+Qb9IbUDqMOWgjJF/41cbBN6cQ8nnHS3i+KThbO6c=;
        b=fekNApuqUchhKLTfOp5McW55/mVDA0wVLGwizgy+L2UB70HvU0+x+5nF13kmsTVhlG
         Fq/GeTob6SRPmNgeSU+GwiriwEgImeEl7ArqBJxCHsIhBISKqEWdKsbWGKBQz9ovtgDp
         i2IKScj6dcV767gFdAFVlT5LyWfXHoiEeVnAYFpgzHDSeaaYXLTjLqeycrs2H9nV/AMK
         K9AORl3rmGTrlIpWE/vp4EYZYeI4MzY2UMkUGk0rnMhhwVKNKHMiDc3xkBkg+Wt1cm/R
         qiKk2S1+/TYEoPeivYN2MsahdbrXWoUNSuNQ0+2Jf930msb8dCj3OJQ1wjzD+vW59CN4
         MxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743176835; x=1743781635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt+Qb9IbUDqMOWgjJF/41cbBN6cQ8nnHS3i+KThbO6c=;
        b=UtHwmb7LYwvHTu2zjZsCileCUlYtHKVd38t7JOvq9iM7QygumBuPITIXOb44A2Vsh5
         WSe6mxUiAf8piNsmuTBeRc5hOIHtku8h1JQgRxlc1SEHljvKrsmoTcHBYR6fV6UHIwCo
         3ZFNC40PkcgPEq5Snd5yba8fmcWLh+ukQbVrxk2VXgyerPTorpNAvf/P4gI4IbGdFREH
         iAv8pBZnKoF0awmrKV34klpqRQrJ/jJNDv5371EuVe2AAcsEzLisxZBNfQXDm8fq0/3c
         aguqNZKqb+kctvxO6G8iuLkNhdcDx0a7YUELshxjaT8bCTkWdbiImK7l6Ei6ed+Be4Pv
         8VDw==
X-Forwarded-Encrypted: i=1; AJvYcCUiKhRTDnY6pxfOQpci5EpDLMzZ/GD1FIuVDlcYnivha4TLVskPzpvoOi33Q1/EV3OypvLE9wIo+1dH@lists.infradead.org
X-Gm-Message-State: AOJu0Yxqiqz4+ZNI0LexUE77P6O5sLiZ0jp7no7ozoD3hS0fbFI3o2sr
	BbR8j4J3YsNc1T0MF9KSpghDq8+BY0e14RUU1uWrO2SD6dfooxEoBCE5MdQnJbs+eErJgxRvYoX
	s2dxDlWrzk+uErA/N6LAneK5p4CcSc8FCEB2pui9AzP6jg9vP
X-Gm-Gg: ASbGnctCuav2DatWgf35UfTZ6eWHx6d4ehb9yS9yKQlqyUZoQr7m5MqIU20pYdp/ndK
	CrdYaxmfvGqSdlI4Pg1Nq0XzH0QQqxyfscbvc6rPdyg+/Ac761H+7IECVRn/Ci9DW1/kKyjVAnJ
	CDAPJ6V+F0nuymnvFI4cxkhyuU1L8ned5WbfJLy23AqaGNNjgUrNLmDRQx62c0rQ8qkXjIXR/QO
	MbT+ez4eDZAjYZD41BAQehrXtqPzfi29aCwpPWTsNCVIyhrAJYgZKzv8wd05OMYocRp0xRIfVVp
	qs1SZb2s4dQjcMjoNLS+5ZRuYZnHabtdTA==
X-Google-Smtp-Source: AGHT+IEIEYPcBdsJZpKh2cvQEk66b3OVfAq5JkqYNBmXLDDWmMZLlGArepCBDdYK+K0T2LFBmFbzQDs9f1sI
X-Received: by 2002:a05:6122:348a:b0:516:20fe:d5d8 with SMTP id 71dfb90a1353d-52602d93fb3mr1803006e0c.2.1743176834950;
        Fri, 28 Mar 2025 08:47:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5260e9baa77sm190070e0c.9.2025.03.28.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:47:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7169334018F;
	Fri, 28 Mar 2025 09:47:13 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6F39CE40A9F; Fri, 28 Mar 2025 09:47:13 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 1/3] nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
Date: Fri, 28 Mar 2025 09:46:45 -0600
Message-ID: <20250328154647.2590171-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328154647.2590171-1-csander@purestorage.com>
References: <20250328154647.2590171-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_084716_411668_89CAC900 
X-CRM114-Status: GOOD (  14.34  )
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

The vectorized io_uring NVMe passthru opcodes don't yet support fixed
buffers. But since userspace can trigger this condition based on the
io_uring SQE parameters, it shouldn't cause a kernel warning.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Fixes: 23fd22e55b76 ("nvme: wire up fixed buffer support for nvme passthrough")
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a35ff018da74..0634e24eac97 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -140,11 +140,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+		if (flags & NVME_IOCTL_VEC) {
 			ret = -EINVAL;
 			goto out;
 		}
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd,
-- 
2.45.2


