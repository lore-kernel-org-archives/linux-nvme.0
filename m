Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B2CC83013
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Te1jw7j483sy759tHuE76cyEE4rw44hR2ayhqjLm74=; b=wUYbozSRycgJ1Fai7aad6jyaMq
	vjKH6XsZcWa+G77Iv5PZr7Z4QtaseN9YZQ3HN8DICKbFf3CsQl66gXK+xB4C+aLFpQmXeV5bsDVDu
	a2q9J0pKK/XgdVLFGc2iu2BFMmymAJu+C1/b86JaivL03Ifr/ogl8RczeeTavtODPRzBC744x5rOJ
	NhoclSALbGmNoDIbZvWzgvewgsIclWvzzbo5G1B2ObPirSnK7pcaeI99iXnD+yd6l3Bw/Kre4AJXB
	NnPK0A7zMW8Z9F/zNronS0RTjjXmZJsSe3ILH+wAaJziS3uBXtu145hoUZ7RguhD4MNsUKlRjp/gO
	y2kgGsjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAvD-0000000F4Ko-1sNR;
	Fri, 27 Jun 2025 15:23:23 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhp-0000000F16N-0ivQ
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:34 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-ade5b8aab41so449916366b.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036971; x=1751641771; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Te1jw7j483sy759tHuE76cyEE4rw44hR2ayhqjLm74=;
        b=QhSNCq4YZTc2QH2l4ooxlGzfqccQdQI46P4sLRI0GJEyaTqR711vpXnMIFX7mIhmUk
         q05b/4fgcd5G73MzUVHv1lxEOL3tO/Gt1PPco5s+/lb2V9qlxcHVG7pUDkmWCSdHWDXj
         gk+65q8s/3Awh6huog6bUgVvVdJP+RtoIVPoBYGEqrNSzfBTlr0ImxN+vRRLxS6sAFHR
         boEOuA6HNSSNbi0+zxLCHhv9MF1KofDlM5ee/r6JrmV2tBuf8705U1ga/dDgRR9YyQd+
         maNyHOmZP3OyrdaIRSVcK7CeqwNa2X8IWZ3XB2KeSAQEW5MHIFslh3UNSRsZ4okzbzLz
         6fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036971; x=1751641771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Te1jw7j483sy759tHuE76cyEE4rw44hR2ayhqjLm74=;
        b=vRVC6tObft0rb4gjhbR01FkmXh4+GUzN9hidgpfntqSSsyqkgEL88doBnrrzTtCLJO
         jKRmYP0zVxIbhPyN9ZwJxUiHhmEbeFM5Kjd4xL5d6LM9TzrX6sNIRFPg34x3FhbyCPXt
         2J/50PFrnUp3BgQJZd3BgvGfEiHMMxV7fbnrGe/eJqFcnzrgqkLwmpy1PGDfjBWEO3Vz
         qm0SpvNyXaKBmL4QiCPwN4FKJspcEc8uyHXaXzu2j2irsYUcuFpjxE4p+W/vtmGVdPxS
         u/MXSzEiGaM1tDicHqDYUfWmUEssQ94/IEYZTY3PH+esW3XtyfZb3LVBqofX5HlTQstS
         klPA==
X-Forwarded-Encrypted: i=1; AJvYcCUSX6IkLYRegHTrFoXSQS67povWuN0VeyCJa5fLBb+bG9uCM604bZfkY8k5zpQMUyu2K3yZ4Hs92lps@lists.infradead.org
X-Gm-Message-State: AOJu0Yw14mbGCYIhtPe0ymWStpT5kXDH9tKtJc0Hbe5lJWPLaoMLewl7
	9/eCCRh/TL5DUaMRtMJ37NSiziy0D98GL3pUaIoOrn/l4TS/WpKq+nZR
X-Gm-Gg: ASbGnctWjpNdIMYmwqEMN665ygvxV04yW76XFDNbB7x8u5j+eh0iVX+rOSCmQ/5aUsS
	qfTjbDSuK9tM4YrpWCUue8GhYrlcjoRxC81ajSVU5nrMrFMgpRLDV3muyEYA5qj7HutkO4Bigt+
	u5tJtc+4j/OZjz0jdXuGghjK83gAarJWAhZua9YrOqV4FTaqqB8J5SlAGL6xfshj0Aw2ffD2q3v
	M1jPNvKbo1c4rfKEb7vuj1vZpIm0zQAxhN8+V89EupxmOAzhnAAh6wNyUWytPbWaeY93i0xGV5B
	ASqKiqM4sjpFTE1eOx4FlGhJczzJYIVUNiw/BX9JX9gbxwioA0iouFGRE2Sc1CV19oRG4CZ0b3c
	t
X-Google-Smtp-Source: AGHT+IFaT5DW/2JEJLqmIAIFZpMMjsyw7WUr4bt/1UbUHg6LAPcXCFf1e2Lm3tP6AQM7KwFTHt2+kQ==
X-Received: by 2002:a17:907:6d19:b0:ae0:b847:435 with SMTP id a640c23a62f3a-ae350129c6dmr333687666b.49.1751036970977;
        Fri, 27 Jun 2025 08:09:30 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 08/12] io_uring: add basic dmabuf helpers
Date: Fri, 27 Jun 2025 16:10:35 +0100
Message-ID: <a4307ea944f7c8453165c02cb05839674f150b5f.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080933_250208_131F2C3C 
X-CRM114-Status: GOOD (  17.59  )
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

Add basic dmabuf helpers and structures for io_uring, which will be used
for dmabuf buffer registration. That can also be reused in other places
in io_uring, which is ommited from the series.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/Makefile |  1 +
 io_uring/dmabuf.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 io_uring/dmabuf.h | 34 +++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 io_uring/dmabuf.c
 create mode 100644 io_uring/dmabuf.h

diff --git a/io_uring/Makefile b/io_uring/Makefile
index d97c6b51d584..0f5a7ec38452 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_EPOLL)		+= epoll.o
 obj-$(CONFIG_NET_RX_BUSY_POLL)	+= napi.o
 obj-$(CONFIG_NET) += net.o cmd_net.o
 obj-$(CONFIG_PROC_FS) += fdinfo.o
+obj-$(CONFIG_DMA_SHARED_BUFFER) += dmabuf.o
diff --git a/io_uring/dmabuf.c b/io_uring/dmabuf.c
new file mode 100644
index 000000000000..cb9d8bb5d5b3
--- /dev/null
+++ b/io_uring/dmabuf.c
@@ -0,0 +1,60 @@
+#include "dmabuf.h"
+
+void io_dmabuf_release(struct io_dmabuf *buf)
+{
+	if (buf->sgt)
+		dma_buf_unmap_attachment_unlocked(buf->attach, buf->sgt,
+						  buf->dir);
+	if (buf->attach)
+		dma_buf_detach(buf->dmabuf, buf->attach);
+	if (buf->dmabuf)
+		dma_buf_put(buf->dmabuf);
+	if (buf->dev)
+		put_device(buf->dev);
+
+	memset(buf, 0, sizeof(*buf));
+}
+
+int io_dmabuf_import(struct io_dmabuf *buf, int dmabuf_fd,
+		     struct device *dev, enum dma_data_direction dir)
+{
+	unsigned long total_size = 0;
+	struct scatterlist *sg;
+	int i, ret;
+
+	if (WARN_ON_ONCE(!dev))
+		return -EFAULT;
+
+	buf->dir = dir;
+	buf->dmabuf = dma_buf_get(dmabuf_fd);
+	if (IS_ERR(buf->dmabuf)) {
+		ret = PTR_ERR(buf->dmabuf);
+		buf->dmabuf = NULL;
+		goto err;
+	}
+
+	buf->attach = dma_buf_attach(buf->dmabuf, dev);
+	if (IS_ERR(buf->attach)) {
+		ret = PTR_ERR(buf->attach);
+		buf->attach = NULL;
+		goto err;
+	}
+
+	buf->sgt = dma_buf_map_attachment_unlocked(buf->attach, dir);
+	if (IS_ERR(buf->sgt)) {
+		ret = PTR_ERR(buf->sgt);
+		buf->sgt = NULL;
+		goto err;
+	}
+
+	for_each_sgtable_dma_sg(buf->sgt, sg, i)
+		total_size += sg_dma_len(sg);
+
+	buf->dir = dir;
+	buf->dev = get_device(dev);
+	buf->len = total_size;
+	return 0;
+err:
+	io_dmabuf_release(buf);
+	return ret;
+}
diff --git a/io_uring/dmabuf.h b/io_uring/dmabuf.h
new file mode 100644
index 000000000000..c785ccfe0b9e
--- /dev/null
+++ b/io_uring/dmabuf.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef IOU_DMABUF_H
+#define IOU_DMABUF_H
+
+#include <linux/io_uring_types.h>
+#include <linux/dma-buf.h>
+
+struct io_dmabuf {
+	size_t				len;
+	struct dma_buf_attachment	*attach;
+	struct dma_buf			*dmabuf;
+	struct sg_table			*sgt;
+	struct device			*dev;
+	enum dma_data_direction		dir;
+};
+
+#ifdef CONFIG_DMA_SHARED_BUFFER
+void io_dmabuf_release(struct io_dmabuf *buf);
+int io_dmabuf_import(struct io_dmabuf *buf, int dmabuf_fd,
+		     struct device *dev, enum dma_data_direction dir);
+
+#else
+static inline void io_dmabuf_release(struct io_dmabuf *buf)
+{
+}
+
+static inline int io_dmabuf_import(struct io_dmabuf *buf, int dmabuf_fd,
+		     struct device *dev, enum dma_data_direction dir)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
-- 
2.49.0


