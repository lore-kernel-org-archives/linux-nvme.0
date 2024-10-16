Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9375D2F7C6
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 21:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BXptLlLi8/LBU0AsGt6M3UhadzKkAlLyCjh46uIpkZM=; b=cPAeGFJkGe8C2rxoKoR1gt9+++
	MUmqx6OrkCtWX3KFvksCCrjo0O+MTviklF6puZ8dIreovKGasTGhqovWg+H/qXBuUJ063SRRStpCz
	hdv2y/6d7u9Urf8wjpbwaPK/QTzK/dbkXutr4BrcSXpAnx0cYcG7N/pPt3fMuFSLY7YbtKdMFm4Cq
	d+w2iCy3VDMVndlnPyK3R7fGibrltOVPFzC0sXZhO41l0PrPDlgC/nwjW6gRDqxxtkxR2wh0qQshz
	Uao5SCYHBHbzVla4XJGlqK/zf3EvzxGT7Kwfxq/sRZLcqOZi3dwvfj3oqiXiogwgqgPezBqm2QY1e
	i4K1YKzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BcV-0000000D3KQ-2G5R;
	Wed, 16 Oct 2024 21:31:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BcT-0000000D3Iw-14Vf
	for linux-nvme@bombadil.infradead.org;
	Wed, 16 Oct 2024 21:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BXptLlLi8/LBU0AsGt6M3UhadzKkAlLyCjh46uIpkZM=; b=jj1TNQr5ySpZt+YLBwYL89uKkD
	FIvYA4JyCxR/78tHMIWBDiv+0nMP4gTiwy69FSP/EowQoWrVLBzAap9O8DCfkENZu8phiftQCaFNk
	AWtOt9kpBt6L3tp55T3h6p7m0f+cKu3SRCbUV4Bex8U4nnJLbU2bUblqx8MOl9KQelr+MP9nlIjzl
	qlCnxpo/Jcjc9VwfnmUlHhFql1xzi7McrwlrxZhlVvf+f/QFp5ZFFpJR7hgYRogONMDmUWIPmSd3j
	x3R8ytJnn8Nm4HBLKKBMSDiizQ9oBpA7n5GokfjLUu6Z8fxEOXZjlK3nqqAIioPoAOoudKaaB6/fV
	zg5WW2gA==;
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BcP-00000006vcL-2zfa
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 21:31:47 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-20cc1fddb87so2777415ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 16 Oct 2024 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729114302; x=1729719102; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BXptLlLi8/LBU0AsGt6M3UhadzKkAlLyCjh46uIpkZM=;
        b=qTdm4Q2DiMdbu2GakX9dp74/lSLYoCIJxb1Z3qDHkjkc7Lg3SY/WUQwP2+ALs8Mo7q
         an4rQK1v+3MacfuhGH5R7QmbgkDTDcT68ckWW+Rj785kc+ICcuiXlaeCJfA8eITxSz84
         v09qznHmC3vJtZoxmfyAzK83hB7I0wXiReu+iRmE968CoLS97ZgwkW1WxZg8JsXvm4RJ
         ijJm7W5kgPf/7yBJiDj1iLhojmcJ/nJybML7VGP8ORihhZeb3CvPNEVZyDs+lpvXcsaZ
         WRd+KF3FfYAt12JD3MpgbKerueT3akjwNnhOmoC8Q6uUiJSXl7vzTnMd5nCeKIYtQDGy
         z0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114302; x=1729719102;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXptLlLi8/LBU0AsGt6M3UhadzKkAlLyCjh46uIpkZM=;
        b=Kh2QzSNVJpf3lXqy76Sfd7xPdpuO9RyoWfIWasHbzDLjdW7+UaVXmj/OaPSzdNETo1
         P4wLPAl9HilUYZ44UngcfaynPAeaK6zmgIeAwSaXnZsBv5FZU35oKGI0i9CIv4fNof/Y
         GrNgUqWau5rMXi12tBV2UkPE6cDlcx4R2gHjp31Rcj3pAHUUMidcIJXGC6KHSiPny/dW
         Y6UODs41lDsByb78nN2gu/j5sC8jrIXjr88JSFAnfwZZH8GLxuO1uCSmHEvJ3j5MJ/PO
         8DqVLL8XGlFlnQhXUAjCkl6rP+S1jv77YBWXEdWUCsHoleu3YbqZnU8mnokofq7WrhpM
         DPTA==
X-Forwarded-Encrypted: i=1; AJvYcCVVq7Mi9BBdLyj1pAmJ+DG3cikHC6XVj2kx4PWZk7J57raXKcP8F/KL1e5L4b8Ly1h/TR327pfx2Zeu@lists.infradead.org
X-Gm-Message-State: AOJu0YzNlrLfxcOufKE9TOx8SW3k4Xi5YSdX+sNmj0q0tQFNmO6A2Vtd
	DcGU/uKa+wq2BN83aFY2+QCooG1esh3Lfj/iXwH+oTmBNK3xL/nel6fAxMPGyOam6Bk566EC+06
	ng9YOhBail7nzauwcZrMQmC8XFkks6g==
X-Google-Smtp-Source: AGHT+IFBdMmX234DaXsAlmM7MfzNBEwsw8QhZPXDdS8L95+FFk1iKjLmNXEnaw8p45IZR6ap1EgsSyZrMkzymru+d3nU
X-Received: from abhishekbapat.c.googlers.com ([fda3:e722:ac3:cc00:d3:6212:ac13:b90b])
 (user=abhishekbapat job=sendgmr) by 2002:a17:902:ced2:b0:20c:9678:e179 with
 SMTP id d9443c01a7336-20d27ef7ca4mr170645ad.6.1729114301551; Wed, 16 Oct 2024
 14:31:41 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:31:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241016213108.549000-1-abhishekbapat@google.com>
Subject: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
From: Abhishek Bapat <abhishekbapat@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Abhishek <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_223146_123796_5454AAE0 
X-CRM114-Status: GOOD (  17.06  )
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

From: Abhishek <abhishekbapat@google.com>

The initialization of the max_hw_sectors_kb value is performed by the
NVMe driver through the invocation of the NVMe Identify Controller
command, followed by the subsequent retrieval of the MDTS (Max Data
Transfer Size) field. Commit 3710e2b056cb ("nvme-pci: clamp
max_hw_sectors based on DMA optimized limitation") introduced a
limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
(MDTS = 5). This restricion was implemented to mitigate lockups
encountered in high-core count AMD servers.

Currently, user space applications have two options for obtaining the
max_hw_sectors_kb value to determine the payload size of the NVMe
command they wish to issue. They can either execute the Identify
Controller command or query the kernel. In instances where the
underlying NVMe device supports MDTS > 5 (128KiB), the user space
application can potentially create an NVMe command with a payload size
greater than 128KiB, if it fetches the MDTS value through the Identify
Controller command. However, this would result in an Invalid Argument
(-EINVAL) kernel error, preventing the application from issuing the
required command through any of the kernel supported I/O API. Presently,
the kernel exposes max_hw_sectors_kb value through a queue sysfs file.
However, this file is only present for an NVMe device if a namespace has
been created on the same NVMe device, necessitating the existence of a
namespace to query the value of max_hw_sectors_kb. This dependency is
semantically incorrect as MDTS is a controller-associated field (section
5.1.13, NVMe specification 2.1) and should be accessible regardless of
the presence of a namespace on the NVMe device.

Expose the value of max_hw_sectors_kb through NVMe sysfs to remove the
dependency of having a namespace on the device before accessing its
value.

Signed-off-by: Abhishek <abhishekbapat@google.com>
---
 drivers/nvme/host/sysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b68a9e5f1ea3..1af2b2cf1a6c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -546,6 +546,17 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t max_hw_sectors_kb_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	u32 max_hw_sectors_kb = ctrl->max_hw_sectors >> 1;
+
+	return sysfs_emit(buf, "%u\n", max_hw_sectors_kb);
+}
+static DEVICE_ATTR_RO(max_hw_sectors_kb);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -687,6 +698,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_max_hw_sectors_kb.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.47.0.rc1.288.g06298d1525-goog


