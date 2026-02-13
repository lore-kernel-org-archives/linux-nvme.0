Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11CCEF48C4
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 03:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AmRiY+gYv1Yx/1Ht580JCWnZXV60oDsI6NKnjtBd258=; b=hTJYPtnAS/pATFC6gRxszPryPk
	272oRg5a1WIbEr8Rd9FjxKTYPJxxdQMkLc7TcbSFvvHxqngMZXY2iKibRyZRJQkQQ9tZdIVxWzKxc
	dlkU+sdnP+d3afsEHORCcH6P03wHRbaCr7nYZaLZeXbH/Cd9mttpGV5T1h/rEeBWv/zXVVjawp9vE
	VxF+rl2EbqvvNs4nLPxyUQFJfgQ6IYsVxcji5cNyvG6g5pV9dwqflSto4prQ5Ux/xJXwzkZXGmV5K
	tfstoDZ1TllFAZHcK7j/9jsjjV+3R/Y16RBkmC5NlOXpL+QRaFTfi3JrL/0i69mryLLE1CLrWPGxX
	5T8Glm5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjkO-00000002uFK-1t6Y;
	Fri, 13 Feb 2026 03:21:36 +0000
Received: from mail-dl1-x1264.google.com ([2607:f8b0:4864:20::1264])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjkI-00000002uE6-0R41
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 03:21:31 +0000
Received: by mail-dl1-x1264.google.com with SMTP id a92af1059eb24-127148c2112so16094c88.3
        for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770952889; x=1771557689; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmRiY+gYv1Yx/1Ht580JCWnZXV60oDsI6NKnjtBd258=;
        b=V29F89YFl6NdDxIzbb309lqeuFDX166uwnBU9CSeYz8Jr/4MbU1ps+pXYsop498kvx
         m1gMoEinX+H03YD8K57dUuxJEG7dYnDLFljhIfmUMNMjs4ru3axp/NccO6uJsOumFZcY
         YOSqj0sSFpXicJLOYvVPzu7LHGwereJm5GQk9dRAD+bb16fo1C4AiJv+6MRXYI0+dQ63
         KvDaJpsA12AAfiySMyRZDQJE1LzKJFXNBcl7ymUgCE4m5Cnjph6F+ERFbe+OaMbcMEuy
         B0EpQFqT8y+81+30UaKBPQIxGAIhZN1YuXehAmWbQHf+6VCNueZ05zuZIB5D4bEM9oun
         GeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770952889; x=1771557689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmRiY+gYv1Yx/1Ht580JCWnZXV60oDsI6NKnjtBd258=;
        b=fuEaeLilPeII3PEV4UqdgpKInFkmYVSh/NNNWzEynIp5yiYisK2Oav6Fve18mforu/
         1eZUkVBSPIlk0E7KvXFmNjv7I4H6DPigZaw5wlE02nqdKyFgbEI/zL6PtlkbXqKEyigf
         Jpwm+DqSzxP8mo7Vl8BP9wIL7dKdoNWSyLSO/EjffbBeg8SPPXeycVliBqkvY3ETTm8c
         Y56gfhT4ovLyhuw1yrk+rkhteKAK8xKlxqEK8M5LHaMAJ8yNJKzq4RTPaCqcCF+Og76P
         9nG9ed78fjZC07z3xw+s4H30SiOrN3+EciC5uAFEh58F3gSlSM/a5AMElBdPd7JqfKpr
         zAkg==
X-Forwarded-Encrypted: i=1; AJvYcCU+aDu/S248Z1eVligpkGWJeH854avI9j8DWtTjwZDflkQBpcR7+79We9LuPyQ0o4ai7TjVr/xcRvtA@lists.infradead.org
X-Gm-Message-State: AOJu0YyJDC9WPW4DHtHHdTPMoH4HRnH8bXRdG3a9OvhVFNXOauj2dE5R
	byASfcpe2rJxMnkqi+ab46cHINwzHFlUy30yuayOSFxX8yNLM8j7JoNqozWMwyxCwDoRYIg/235
	8RIK+G1JOu/YzvkGXk/JVY0ozTQgAe3hXFeqa
X-Gm-Gg: AZuq6aIYtoM8FKwPv45BC3KkbWueAlFlW0Ki9LvK3cd+X6v0C4uaU7PfRWkKJr1j9yE
	vyYxtLj+KBmCiEfWxM6zaqIHFwqDVfqZFDsqfQ7s71KON4AD5NMhP1XCf7Il4P+FbuErdFhn0qc
	tJs+UHeebSLZN7qBrlEEnsX+nNwhXz+SVn3jL874OsAJ4qxf3HcU/Gw5d/a4AWpOaNVaRcBIvar
	CXFgJKEFSc5oImVi3rCvqj2HKVZ1+NA/+z72nPXq1ug1p6OZgCq+kBgNW2ivHdM5Zoulal3votK
	rZDBKpFzhWN2uMn8hpAmK1xJ3GCrOBY12GYP1wIoeUYBFtiD2h/73GQPp+SCYteU+aXstkKcLNY
	StO+yDHGMnL8EU7/pVNa00PF7EmBtTUczDuMYLxCeWDuGzCtDiBa9Gg==
X-Received: by 2002:a05:7022:6283:b0:11e:3e9:3e88 with SMTP id a92af1059eb24-1273996b276mr248941c88.6.1770952889051;
        Thu, 12 Feb 2026 19:21:29 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1273a0db6d1sm104957c88.4.2026.02.12.19.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 19:21:29 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1D294342244;
	Thu, 12 Feb 2026 20:21:28 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 172D3E41DCC; Thu, 12 Feb 2026 20:21:28 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/3] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
Date: Thu, 12 Feb 2026 20:21:19 -0700
Message-ID: <20260213032119.1125331-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260213032119.1125331-1-csander@purestorage.com>
References: <20260213032119.1125331-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_192130_136875_3C29F06E 
X-CRM114-Status: GOOD (  14.07  )
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
index fb62633ccbb0..fa489c1979db 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -783,14 +783,10 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
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


