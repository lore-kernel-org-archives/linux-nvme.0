Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A8DE9A059
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=obCm5pzMRQ/8I1Vfr0khOkZYqQ5KtFU6UC00Ngu3CF8=; b=fSd2Lyt+vSNvr0lq43yZ+QzVgW
	9yHKKkGZCfj5HQouuSbrwGcFMJWvg+Bk7XH5MZLRkUjEzJWKvxFxw+rDzfzgSCt3+BatTe4Hqu0yv
	rtHxeBT/con7FQ9iN80R2y/MM4MA9CSPxparo8Y+MrvOl24nTrgf6jGFjUQoGvc0FYmDiAjJ8j/0Q
	j01a7RcknH5L+XhJ8Ii3CroexwANZUUgt+9sx8qAHnNUaa2EgrvvBmJl1Aci2uH8zCytXNPmzInYg
	dyPpnzmR/kOlNxOuXqkOIhzsdP4oh84oGRTKZs6GNDpWU6cKP7jjegS7uXMb10x1/CqBilgkNGsyC
	shgvVUfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7k8-0000000Bh3a-0H1K;
	Thu, 19 Feb 2026 17:23:12 +0000
Received: from mail-oa1-x61.google.com ([2001:4860:4864:20::61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7k3-0000000Bh00-23vx
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 17:23:09 +0000
Received: by mail-oa1-x61.google.com with SMTP id 586e51a60fabf-409525fbebcso45063fac.3
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 09:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771521786; x=1772126586; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obCm5pzMRQ/8I1Vfr0khOkZYqQ5KtFU6UC00Ngu3CF8=;
        b=PxgIVJk+6sW1tKirlUI+GpVsryQrO0lb4wrlL4qOPmc3cPp8OHDZu7wDIZ6iGlVrrE
         GwCcGkPuX9C1NUSS5WRbg4rzxzlX88SaD10XyNsMFAouaQM8DF83OUPUm++pydh0B3Gf
         d3Gj3BjYouTe9YmMRD1QnRM85aMoVbdjlfJsOtFHEotwNpCLuhJ6a+zC1R+72xBlGYkh
         7lZbzfzA1iXENrCnnLv9aDp3JwSV8cwe3L+ZGzapynXtkTzCTkCxK2xARnLe+CkcH1x0
         eBFjFCRh4GTJpq8cnQj5pdc3QzcWacbydwVv+5q2rAwgmLIVAcmqC5jHviK/yeg24Zjt
         rAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521786; x=1772126586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obCm5pzMRQ/8I1Vfr0khOkZYqQ5KtFU6UC00Ngu3CF8=;
        b=Ig+azF74PmZSYZKek3LmSNxcxGe9F2k/XpxFktzkdz8wCj0k4xiGEzEExMIsGtbjDt
         OZkHkEZckUNpyHqOvqwyM3+9N57I31aKMP9rMjsMzzfXoqo3raBj288dgZiDDGcFu2jT
         uAjqmJhPgb8LaSqyHLkKk1526SKClkVr802t25bWwYKxgL5NauTKD5WMTNosZetfac3X
         gVrslmkbZ8M34XKvXhCx7H2wK9gM52Pu0F0GA401XqCWOVjvX84EF5003tq5LpJA/tv1
         Ztkhe7CFgY9nBCXag1PECSXT+REL7th7sdVq3caY+SJuCZROAZ66oDvOvQhb6acayj5d
         JMaw==
X-Forwarded-Encrypted: i=1; AJvYcCViGkqxMZXIx7cZANac44VKHH9gMzebOwXfk1SbVg8eI8jZ3+Ab0bffWN/KsquVoIOqQe5dy3fIMw99@lists.infradead.org
X-Gm-Message-State: AOJu0YzDxK+uew94ttQCZwlnZkbhkxXz9/5X2V55bCkf2omo0GI5Onhj
	sRakkOYKY+P2an3Jc0yVgVYr/mIVMkISsqTNRechlVjNnXQI54a8gCG2mAxPlwieJIGxLbrXsqW
	B37yGdlZTloIHs7EFneAZIM79bnVKBBK5mTGPk9sOW815NGQqSpCl
X-Gm-Gg: AZuq6aIyUj9fQ2wYc4Utng3iFGResWbKDpkGyUUHK1d2zZspO7XA/9vRb4mxaEYVWvd
	di/kbLP8w0SwrOpnt1vMWJsSaZfpcpcy/z8syn7aUt+yIeQFg7oQp9Pn8uyxgffLm5HTwhJSY3a
	cgOMLpg1siinCJEt330/qWdbH+vvrzGdi4h5nfjLB8JZFLQihkJOsdoYUseYYa58KYBXsx0BmzQ
	XLNPI640fOXGzejQtx7VCaB3ZXsD95VZvEQOq/O5U13erAVA1DxCbPKiOja00COMU+fofHncr8a
	epl6AkIDDENJA8fHICy8/LcAt3igM7eCKPgGl9uMZSVDp3CZr6lUXrSfcKwFONhCQKYTJADpWMP
	KzOAuK6Lk1Bu+rw1YFV+DhoitcYzwhCxIf1e8lPo=
X-Received: by 2002:a05:6871:7387:b0:40e:a686:aab with SMTP id 586e51a60fabf-40eeec921cemr9445158fac.8.1771521785894;
        Thu, 19 Feb 2026 09:23:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40eaf0f0a97sm4297650fac.13.2026.02.19.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:23:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 63475342224;
	Thu, 19 Feb 2026 10:23:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5D2C1E41AE3; Thu, 19 Feb 2026 10:23:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anuj gupta <anuj1072538@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 4/4] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
Date: Thu, 19 Feb 2026 10:22:27 -0700
Message-ID: <20260219172228.429479-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260219172228.429479-1-csander@purestorage.com>
References: <20260219172228.429479-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_092307_532962_C0D9B955 
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


