Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2698C3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ObOTNoyTWsXvZUF6jlr0urnDeARjrWOwitNTbRM7B/w=; b=dYR8hSRCn20MPnvPAw8F/CLX7y
	/vjT89e/JWIsiOUqyE5DYefmMgGXWb1pZ/+nt2Gin/PODLBlBvlQ2qQ33WHHzw5yOwrYRe3ajdLBz
	WLN/UsJiFMbC2RgZ3O9y1X6yXYKsen+vhjY/gij2M/y9wsDfi0ixKRU1MOe5mUlSUCCqNzdUwwFHi
	73vHo1kRsrl2eOVSBkysiKXcXcwp1zEKsMhyF6k42ZWy8JvN6SFTx9X02l5nb9AnAWGifoG6plV36
	ZZ6BRcXCVUXoS5HbAWvXT69qHXKCALONJZ9/+J//rNn8eh/2w3PIXbj/+SC+c0q1sGgQoGoN33BBj
	tbLVzqfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOto-0000000DLel-0Uzh;
	Tue, 20 May 2025 15:29:00 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOmD-0000000DJXF-0St2
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:21:10 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-ad53cd163d9so695121866b.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747754467; x=1748359267; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObOTNoyTWsXvZUF6jlr0urnDeARjrWOwitNTbRM7B/w=;
        b=STKDzNQWvBtHehD9/pPsVhR3GZFXizlmOoloc0TcSuPzN1BJMo0TBD05cykrVfZkFj
         n8MKwqMHWqOM25P6mSoAyt4PDo2rP/fEK0GpgMeyfjfwl/g1tUruG6EYtqfh/UmBArHV
         DFsgSHk6yp0mM38cePA49b/8TqrFFlHqfUgxCiqB7hixwSxjmJ/9tLJEKmVSaCCFnUcA
         RJ/lj0T+NRe9irEQKEEbjJ/IHQdzPxsXLHuKXq+fUj2HMMsJnd3CHatgUpF43FDejcPt
         /BxYy3RZZCvI4ulJ7ETLTnctqQ1LJYUGpynthHNXgecbsn1+RwQLmWR7H8U9RAhDuqux
         Eo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754467; x=1748359267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObOTNoyTWsXvZUF6jlr0urnDeARjrWOwitNTbRM7B/w=;
        b=lRF05ryY07kbwwtVM3iguv2wO9dWWFGbbqtJmCKRTExMQtu41GU7Xr+w0N/jbM3yvC
         3AnipftmZxEd8HKed0RMj2k+eg3vi316E+/IaZkOgXTQSHFDn3ASf7O9+INd1Fp8kyGw
         Up4GkBlz6uKMGlnM4Nbz2jdmdsipiS7asBc/O6cGVqX3dBfuzdczO4CwJKDtFnhwuuXb
         p6L7NYmd9p38S7jA8opuY31OOqZqAO5JNcNGRUXfpcXB/v1lV6jEqBzobf1nm4dfdl9t
         A8UuYMreF73AZMJY6jF3mevPCmP3a4DCWb4zFkm+x9PobkxomLwIOdufxAC2Tyw6EWSq
         wwWw==
X-Forwarded-Encrypted: i=1; AJvYcCUUL5cNWe52vZER9cRGmcDccs8Cg0hyDiHgefAIEkuRgJW2vdHsmjUmJcTmnOYfifhmsvcx6gJIb+My@lists.infradead.org
X-Gm-Message-State: AOJu0YxEdRan6iIf2L9TbMd6oJkRwwzxaNMLRsNTb0iuueWsHmxo8soC
	V0vdkMNyPxZKAJZkmxC7/+XQ2r5XfBvRXJyme7Jrr1+EeT8iC4131CWY
X-Gm-Gg: ASbGncvtbz1TrnXXvte34n8lDMVO8pS8SFHE7wheNs/XylC0zv98Ru68lL2VC7IyY6Z
	vzM8NMEnZr1Wi+jZbzDrLbd+CnBQS5jikuiWIOeiimlWXrPogj7rmN/0zdIP8Bc3027KuOuIiEf
	FFOqHjyrekmFwowRNPoGHQBo2r9kIvXMMXBOyQiUXGS33GzItYMx+veUEPGZPmXBHHHxG3L7XOl
	yWAu/RQSc1N6yPcyC/0e5V3hVNP6F7Zq2h+FLJdyvbCCA9BaWff1yHbgCvxH1p7vimQpGxblOso
	6vDRE4IelEqF7mGszo2JxpTu7wDnYmc=
X-Google-Smtp-Source: AGHT+IEAOdYMred8415gGJotgYqJOVGyKlRHAKIKZM295HNb5AMABYxKqtT3rx86Mv494Bwi+AbdUQ==
X-Received: by 2002:a17:907:7e87:b0:acb:5c83:25b with SMTP id a640c23a62f3a-ad52d42bf0cmr1689804266b.7.1747754467164;
        Tue, 20 May 2025 08:21:07 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::bfe])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52cb1abc8sm738044066b.0.2025.05.20.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:21:06 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: asml.silence@gmail.com,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	dw@davidwei.uk
Subject: [PATCH 1/1] nvme: enable vectored registered bufs for passthrough cmds
Date: Tue, 20 May 2025 16:22:18 +0100
Message-ID: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_082109_150545_4FD7B6C2 
X-CRM114-Status: GOOD (  14.69  )
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

nvme already supports registered buffers for non-vectored io_uring
passthrough commands, enable it for the vectored mode as well. It takes
an iovec, each entry of which should contain a range within the same
registered buffer specificied in sqe->buf_index.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/ioctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f29107d95ff2..0bfaf5d75461 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -493,13 +493,15 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
 
 	if (d.data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
-		/* fixedbufs is only for non-vectored io */
-		if (vec)
-			return -EINVAL;
+		int ddir = nvme_is_write(&c) ? WRITE : READ;
 
-		ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
-			nvme_is_write(&c) ? WRITE : READ, &iter, ioucmd,
-			issue_flags);
+		if (vec)
+			ret = io_uring_cmd_import_fixed_vec(ioucmd,
+				u64_to_user_ptr(d.addr), d.data_len,
+				ddir, &iter, issue_flags);
+		else
+			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
+				ddir, &iter, ioucmd, issue_flags);
 		if (ret < 0)
 			return ret;
 
-- 
2.49.0


