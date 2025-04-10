Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A7AC3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s3kBJ88S7fok5n1IJTfMjMJm3xNrGOEru41MivDAAeM=; b=MQKk+x/x+8Nd3gkjxy08iusc9q
	TEMzG4/pHEto+LnHVpGrZpmLp97V2gJ+U9wUAQBDKu4a07WqhidoqbmVYXBY2sL5WyKtAgiicjF8+
	NJX3qP4xu0os8c2v+ElVkMUcZXGqzjbjLAdZwwua43l5TG3u9scqWhL8rWVS+h3WCDKrvZH199pkn
	b3QaVqg0Xi/9vLgWFvSryKDjyMEVAqOQR9IITYZfhD6mnQHw5QrbLA19552iYdo6pJ0f1tHL1sjj6
	1aObY+Rd4LkxjT2YiJ48kX5LSiFdoC0IpkcL3oRA5Sx/Rar2vbS4cbvXbCtv2Xp+VbBKqRD+BvnOX
	Tq8dUHQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2quN-0000000ATPl-0hIY;
	Thu, 10 Apr 2025 12:21:27 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2quK-0000000ATNp-3akn
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 12:21:26 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-226185948ffso6948375ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744287684; x=1744892484; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3kBJ88S7fok5n1IJTfMjMJm3xNrGOEru41MivDAAeM=;
        b=ommjONxGpGbJxULGJLmhnl4GCBki7v0PH0W/WYJHNxC6zhc9/1T0p4A/qWxx9+OcXJ
         lCPOz8X4QA5Kzqiwcgz8qovnn8k3ARz2jSg9HhGGVvEpWneAkrDS72p0Meqd14UulJQC
         e7r65u/bmYFEYq3qheGmUuXHL0PGluJLuWIKe86WsLoI+xgizGQxLmV/n2+EnY1j6Okp
         nKMMwu9NToMcj2v+v3uLRy9Ad1Jc5Hp459ckSNsWXJ9Dg5KPJds36mlLMAGIfo4DgBWT
         huf4icrwxycA+9lTyNb86iMyQnZ6F4+yJGTGUwXGC/+gBTFqwYHsJf7M0xIYvzPhEZ8D
         RzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744287684; x=1744892484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3kBJ88S7fok5n1IJTfMjMJm3xNrGOEru41MivDAAeM=;
        b=kc40KyWI70ZTQEIX/rlAWsF8996Q+KI83lWKq26bebJhxQy5I4BsHz2nJxgz7Cn5SS
         syYJBcBdcRAF4ehAM6KryPHUV7EiKnvh+wE4KOZxz000iUkEwZ5J9O6rDgYC1g5jInZ6
         XpvCEXk2qmJ/wilM5x3THH1etIy+AQpiRGn96BSQlL4c04wztG4DkJQLgkPdotQpS0dK
         PPUwkxbRgnOIgnFBWcDjiLXIWwScjJRbFpYFHXOEYuB0CtNRE2r/V/QjOg1KoG7cyTp1
         XpbSYHRPe/1IPykFN1KINBoPv+aX0jFQmUm4b8AssE/fgXHDN7egJYJ+Lbu6+WOghP/W
         nIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeb79HHafRpi5a1lqkdWCEKTZseMGqkjn0Id8/6i4gJImEO58srCh0nt4S+mavOEnwOWCttcieg5yz@lists.infradead.org
X-Gm-Message-State: AOJu0Yzuj3J/295yBD3Tfy0aSGsM7YG9AqUkNAQczsfD3kMeDJyOfm2W
	vDlKepT6BnRAIfpZM7UiY3hlSBv65rsKscqeOhevA5jJZnlAP8V4nza5wHRIdwc=
X-Gm-Gg: ASbGnctSI1RlCE6hKPu1QYi4mSL66esko7Uk17E6Ph4JQDrUpljUxkyZaY6NKj1Gs0F
	apI3iUDx6GAh1S1theC6Rfn9bq31+MgvfmOm+HFKCqYIJepJlxmQNaHJqNR0072YcnAMrF0c4cq
	LZ8rbB+xovhJur4bwfNrTRtEGcxyKimZ3QTCq0ZSMrNiZawQTTRzk8zA0JK/Yxe00wXNagvqx04
	nCTD079GMUFkLs7YgGapb9KSR0W29eCJUmX4WKWMjYkSLjueDCgMobOEYBBcedBstW0ogqw5D8y
	cXztJh8qeu4tnJqElEVHgPLm6ZRe0OGT
X-Google-Smtp-Source: AGHT+IFMf86i5hdaKmAAPu0l7sixsembd/ooblYjELXcl1e72Z+mST9TxTLcXTJem518z5tIS6z45A==
X-Received: by 2002:a17:902:cecf:b0:225:abd2:5e39 with SMTP id d9443c01a7336-22b2edeacffmr41395825ad.30.1744287683134;
        Thu, 10 Apr 2025 05:21:23 -0700 (PDT)
Received: from localhost.localdomain.com ([2001:df0:a640:1::4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e38258sm3186109b3a.107.2025.04.10.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:21:22 -0700 (PDT)
From: Jiewei Ke <jiewei@smartx.com>
To: hch@lst.de,
	linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	kaiqi.chen@smartx.com
Subject: [PATCH 3/3] nvme: export delay_io_retry_time to sysfs
Date: Thu, 10 Apr 2025 08:20:54 -0400
Message-ID: <20250410122054.2526358-4-jiewei@smartx.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410122054.2526358-1-jiewei@smartx.com>
References: <20250410122054.2526358-1-jiewei@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_052124_894074_128BEB38 
X-CRM114-Status: GOOD (  14.19  )
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

Export the delay_io_retry_time value to user space via sysfs to allow
runtime configuration.

Signed-off-by: Jiewei Ke <jiewei@smartx.com>
---
 drivers/nvme/host/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d31226f7a4f..d3fb39ea7728 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -684,6 +684,40 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+static ssize_t nvme_ctrl_delay_io_retry_time_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->opts->delay_io_retry_time == 0)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->delay_io_retry_time);
+}
+
+static ssize_t nvme_ctrl_delay_io_retry_time_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int delay_io_retry_time, err;
+
+	err = kstrtoint(buf, 10, &delay_io_retry_time);
+	if (err)
+		return -EINVAL;
+
+	if (strcmp(opts->transport, "tcp") != 0 && strcmp(opts->transport, "rdma") != 0)
+		return -EINVAL;
+
+	if (delay_io_retry_time < 0)
+		opts->delay_io_retry_time = 0;
+	else
+		opts->delay_io_retry_time = delay_io_retry_time;
+	return count;
+}
+
+static DEVICE_ATTR(delay_io_retry_time, S_IRUGO | S_IWUSR,
+	nvme_ctrl_delay_io_retry_time_show, nvme_ctrl_delay_io_retry_time_store);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -712,6 +746,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_delay_io_retry_time.attr,
 	NULL
 };
 
@@ -741,6 +776,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
 #endif
+	if (a == &dev_attr_delay_io_retry_time.attr && !ctrl->opts)
+		return 0;
 
 	return a->mode;
 }
-- 
2.36.0


