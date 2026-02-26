Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3236FD8FFA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=; b=zcNT6ywe73AM7UP05lA0RR8w+9
	X4vei7oJpi4nBIpfTmlCQ0fwlFLz24bNP9/9Vet2KM9uD7CZX/q3pgEhIeLzzWfo31vBAHQ+mlZZI
	3+B0uBZoSHHkK9cisg0rrm3F5l0ApH8yALqoAa6b61tnN2zCNLEGJquk4DDo67CLUonM1Irt4JFMl
	YfL2NIYtSgaHqEJIl5HkXyAmOSpqRfX2ykL4FpeSegMAweiSn4kGd6++U+0oLaXsOzT6ZEcgjMHKi
	5ZZ87nDfEDD39tM5HXuRsiKSsqMXq9RMpTIPP8eOzK5IK+oKuw+6zh4ikSYDeguFSNB42e1kxUZ+/
	xaGYEsWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgeu-000000070U0-2fJH;
	Thu, 26 Feb 2026 19:04:24 +0000
Received: from mail-vk1-xa63.google.com ([2607:f8b0:4864:20::a63])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvges-000000070RB-0Nx0
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:23 +0000
Received: by mail-vk1-xa63.google.com with SMTP id 71dfb90a1353d-56a884505f4so26524e0c.3
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132660; x=1772737460; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=;
        b=d6NIT8v6eWthkocR7WKPthNn1n4OGYcXt+qOLwB3ZoDspR7o6XpVAORHDVlCj44e/I
         3W87oAQLrtkRrvHLra9JMWB+RIUGLhiVKzmtxnRA//wlXSr19MwQ5j5RRDJM4wZ7eyHw
         l/hXvhj17Jk+sbVFueQlaQXnb9YNd1plbG4jg4YcNfNkeFx0qdcIdVhJjDtBpWo0BRn7
         Qp0eruOJDNJWzPTvdvf9cJFFiRKom9aFMhGpOCU1LV5es21hiMbHxAPDM+JPBjByXwHj
         49wupbSt/Tqq2EZZxwYb8Vs6MNuOv5xfHjek89Fv/KWMVpXV4c9SzRnk1Egr5tP29HIM
         +eXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132660; x=1772737460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCPUB5YteTwm4Su/ndU1zpliegenX1WCgWKjuq5aUfY=;
        b=ZaGmuVbpji0tzpItsHBFEpeMF0JYtT69oVVZMlzHYQXRGDiTl9Ly8pHOgVlWfps+TU
         0L7iVBYmNR4gdiXCxj0Fmq4esY/+enIH88+Zd6TNv88ZB2ZhAA37MyBZSotd/bm1Lric
         h/8gX2Gpnt/sPDYoJMllLfdWGb60VVhMtrNJ26FvAFeSgu9m5Wqbg3oKfqaI/0ZuVtD6
         pHgdOJdoSUbxj1tcohOWnomB4N8gpQR2cm5MTSzJ/rV5E9tmhOflADZyGQucCE3kmTKM
         R51/q9e3VHZo7MK2AH1ov87TKkKRRgzFMcMOl9fwA8vcU/EHPeyP/OCxvRwAWbe5SElp
         HpiA==
X-Gm-Message-State: AOJu0YzQsR+SvkXsBp5Kie4NBZ2DpdMRe1DQ/6vI/WkoHpURAmWS6O4y
	dxJYBRL3M+wepxA1FeOMf4wmAutJ04K8rzlhUHgfGtE/gpTgvi6ufzKzo4TGb/1ilfpZqlZVYFR
	p6QCuL56JVy0UpQBgrKsa9w8fKeBnYnS57RpL
X-Gm-Gg: ATEYQzzAHiuv0yScCZ6mVCDDCd6yavnvTTC+JUBsn2wqJBVEvuIJ5WT4jU8IYuXiR1O
	uyMyNV1B0BjBqXrxx7uDzIz5URBjRD8kh+NTEWQERDV8ddsC7kbmwYHGHzCdUypXynl7/Mk7S9V
	8QHu4d4HWYKkwP7PYRdWQvrWXPj+fO2IUjInbIZxS5yFW6GmqgoSpeCibwFZplyvIHZBwVuA5hV
	QTvhFSH94jhEEAB7nihYd44EcasRkT623TouvlkHUNcuH4v3JG95AzHbJVWmbh1lBOCX2KhZTNU
	qYJljni77TwUWd+GaXdap7aJu3f2IHXQkwqnG4CNVDaKJKOwRXpc3SI5Fg0GwqRXFtGfxpJyHH/
	lAfSyGYLYHkPCVb03mzXmN8qKDp9DLp8b1NP7XnHwAeFgmDUlAKRH9A==
X-Received: by 2002:a05:6122:6b19:b0:56a:9e65:3e30 with SMTP id 71dfb90a1353d-56aa0ab35ecmr60618e0c.3.1772132660358;
        Thu, 26 Feb 2026 11:04:20 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-94df6577f7csm242838241.8.2026.02.26.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:20 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B53A73402EE;
	Thu, 26 Feb 2026 12:04:19 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B00A6E41254; Thu, 26 Feb 2026 12:04:19 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 1/8] nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
Date: Thu, 26 Feb 2026 12:04:08 -0700
Message-ID: <20260226190416.297725-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260226190416.297725-1-csander@purestorage.com>
References: <20260226190416.297725-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110422_126580_B07C0577 
X-CRM114-Status: GOOD (  13.08  )
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

A subsequent change will use the NPDGL and NPDAL fields of the NVM
Command Set Specific Identify Namespace structure, so add them (and the
handful of intervening fields) to struct nvme_id_ns_nvm. Add an
assertion that the size is still 4 KB.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..1134e6bf2d5c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -511,13 +511,20 @@ struct nvme_id_ctrl_zns {
 struct nvme_id_ns_nvm {
 	__le64	lbstm;
 	__u8	pic;
 	__u8	rsvd9[3];
 	__le32	elbaf[64];
-	__u8	rsvd268[3828];
+	__le32	npdgl;
+	__le32	nprg;
+	__le32	npra;
+	__le32	nors;
+	__le32	npdal;
+	__u8	rsvd288[3808];
 };
 
+static_assert(sizeof(struct nvme_id_ns_nvm) == 4096);
+
 enum {
 	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
 	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
 	NVME_ID_NS_NVM_QPIF_SHIFT	= 9,
-- 
2.45.2


