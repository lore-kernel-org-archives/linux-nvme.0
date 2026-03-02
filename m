Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611AFEB3628
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bC/PSnv7yOwEPTd/AMtRMqWpAAmzjzQLzKujNS/xPPY=; b=eAUZsJlgOz7jUghWaRit5jvcgg
	srqevZ/q6AamEroMxz6dRwx3f3W8ZKlVHOGA5IFi9cCSI6bQWG2y34Xxw+GgRyWBYT4xqHjNL7IPf
	j4yOctJfe+3cl2m7o4aG0R3Y8odnWo5YLKirewL+EABUElGTHL9hfd+gix+15/wwNqvcvNMQpVuj1
	XwRqEAOys1aRinWFeZbwpXiK3/tjA4oO4XCp4fwyNOoXfe6Rw8jRbNHjm6sQzy+0ciMyZKI0gKNvn
	0GR84OwH0frrEjGHl7gxgv8YkEqNjYbrXiU9F9TZPxGUyeWHjYlAJolitFyGvr473vzEIQxCyXroF
	RdI5eglg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75E-0000000Das1-20pE;
	Mon, 02 Mar 2026 17:29:28 +0000
Received: from mail-dl1-x1264.google.com ([2607:f8b0:4864:20::1264])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75B-0000000DapS-25Nn
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 17:29:27 +0000
Received: by mail-dl1-x1264.google.com with SMTP id a92af1059eb24-1277863a912so404439c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 09:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772472565; x=1773077365; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC/PSnv7yOwEPTd/AMtRMqWpAAmzjzQLzKujNS/xPPY=;
        b=cB/CDMEDQGyw64F+xmb3NanmEZFTPwxNh0AB+wp6cylg7N+c44Uy7EImKOGPg+ANUl
         DZ5/FuGkq95w+eW+CVPNUz2QNCcUNRSdqA8gfrI7f2w6Yi1Vje2QD+bEJFwXgdwXQEaP
         kSEXCpy6xR4I6DkN4918U+d3DActjp7zkfdot2EWua0ivVWWoxd1rS/+175GVKieRQnU
         gvMIDUbwrTu7rIV6nR661hE24+K+8VPwUXBlofpBWgxtAZzZK05P4hhDwEjbUYddnIf0
         i7c/lH43aETHAWAxBtw+ynCCbySLR9XL/06K1WiaCq6mYZ2WgLEFeCsDWyEwMJUzWHwz
         KG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472565; x=1773077365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bC/PSnv7yOwEPTd/AMtRMqWpAAmzjzQLzKujNS/xPPY=;
        b=W1z6G121jHPzywFit0rVA8eNBJ9wTamWGz3VHPfkFPtqCdAzv4m7wNcYKxHMJCx1HZ
         fYh3H001ALUV6sh3PONCh0vwyTBOW4Fn5nozoSP2OuhX+XRyr3D3Mr/g6rLBkzYqpu6v
         Uf6yVjuOhYDjg+WMMJpo1fx8uLjNHTAr+nsNMULwhKvd+vgweimbah17Ew8VkGM/Pmb+
         7OOutXLXuKHN+PRQSNwXnwaj40aNk69XDEX3Qe+M0nGXrBKTA9uInezDEu9Ny7QBJ/43
         NFmYjGaY8Dpj0Xkh8NnKFjOGrJXl43VBktTakV2KyMAvEEkfNncLryATP2QR16wNxlHd
         1JgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7GgsdUSWViL6fORE/kC5VkkxH23KA/Hng7gi6keKXIJeFcZL1oYSFtgt4YkzBZWhrGqyEVrHHIY8i@lists.infradead.org
X-Gm-Message-State: AOJu0YyRMFi6aabje3IUQaBne5xwa+iFuUyGXGlWE8k6SqMyR8deWpT8
	LNt7b0suLV+tMbe+cflh2OD3R33UYrksp3eDENoEtycFoC7grl1e3AVs+suLZ/x0McenVkzm0VG
	BIzO+V40jzvQg/wCi8IKSmIxTNlumOR3WC7HL
X-Gm-Gg: ATEYQzxvDjdS4jA7eN8wQiyv2Yfn4f9ePgaU/dxPdW1L8kkQPZLdtmxvm5H6sjJsUIE
	zTDukf7ftEUDkpClVCGYqkZP/4R128DSMpFEGfBvUur96EBUhoggxpVF92o/lr0xUIVFPWh1/P+
	s2MbHVy2wRn9rENHa8jmqt6ED/2fcfjKv9uM46Hyi7AjxfV2FQekzvBsN+i1DIUagTbVQFzcOxG
	fN7m68a4JiGH+1iLYaUpnX2L8dy/iMnnMO8iNADycEOUxhIKerkHYRsxBpQ8fAB1QdWiLMqoHq9
	gBYye4gzgbWmqKYxvv1qXFd2fnQAZKzWjkOjTPWsVIpEr4aKGD3W1Rxy8lytMWKBEt+OevZc4p0
	m4PnWaFEqkleSFQfobkTtpCSAJC1wKJm2KCqgjmtRBI3z9ySJBTz6wA==
X-Received: by 2002:a05:7300:724c:b0:2bd:db75:c28b with SMTP id 5a478bee46e88-2bde1e90dd9mr2349446eec.7.1772472563561;
        Mon, 02 Mar 2026 09:29:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12789a20cd1sm2213499c88.6.2026.03.02.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:29:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5CDAE3405ED;
	Mon,  2 Mar 2026 10:29:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5A1E8E41FBD; Mon,  2 Mar 2026 10:29:22 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 5/5] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
Date: Mon,  2 Mar 2026 10:29:14 -0700
Message-ID: <20260302172914.2488599-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260302172914.2488599-1-csander@purestorage.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_092925_943526_B1411399 
X-CRM114-Status: GOOD (  14.41  )
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

nvme_dev_uring_cmd() is part of struct file_operations nvme_dev_fops,
which doesn't implement ->uring_cmd_iopoll(). So it won't be called with
issue_flags that include IO_URING_F_IOPOLL. Drop the unnecessary
IO_URING_F_IOPOLL check in nvme_dev_uring_cmd().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8844bbd39515..9597a87cf05d 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -784,14 +784,10 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 {
 	struct nvme_ctrl *ctrl = ioucmd->file->private_data;
 	int ret;
 
-	/* IOPOLL not supported yet */
-	if (issue_flags & IO_URING_F_IOPOLL)
-		return -EOPNOTSUPP;
-
 	ret = nvme_uring_cmd_checks(issue_flags);
 	if (ret)
 		return ret;
 
 	switch (ioucmd->cmd_op) {
-- 
2.45.2


