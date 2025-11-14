Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F89DCD4F49
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 04:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7QuDCnWgkqjlQ11BcKbwc3ohcgqyxg31FlUTz0d8WM4=; b=aLUE7nDg7pJqk2l4ZS7ln3ldDE
	mGE/JiY9x5JKj7FQ3MPvE4CXKlYUxRYlFkVqTWpT6gPeuLp5D1GRVb77XHBeZsg8P0y8uST3Mr+Ye
	W+hOD5TRDvE6VzRcpYneHSgj7i+n3TL5b7b5hUNc+83xnEmF0PpPrBPkO1knT4uymp/2bKa10W70G
	koocZVHAzp8bVxBKkziRhK8SGoEWJsF7cVYJl5ksNeZkTR0xvXoLrpEdAALTThzrlNhry5tm4fIwu
	AR40oYm9IB3/u6zmm+k99nEt8LgVaUXNIy8MJCIfUkkIIrUl8VCHohxMxVoAXRdln+Tu27zfbE9RY
	VLnRkh9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJluC-0000000BZNb-3LZd;
	Fri, 14 Nov 2025 04:59:28 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJluA-0000000BZMa-3PIZ
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 04:59:27 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so1802244b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 20:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763096366; x=1763701166; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QuDCnWgkqjlQ11BcKbwc3ohcgqyxg31FlUTz0d8WM4=;
        b=FzOlTF2FtXsXf+AkSWVmTYYT6j+6awNeCi22YrRI13Jyw0A2pbHYa71ooYvy6ewz/v
         DqUbX6/0tyqLfmoVY7rzQTJHUd3B9RKpbuNsi1dWoREBzTXryWrl0xRyCG465rGRIfTe
         WdN2QVscevOepF+ts6USYD3ApK4JvPxIsXQCdyBR8TgKN/5QGUKIuJZ6DkjxdvXW3zWw
         ZXQ7tk/cGf2SYCEQ1nMGVUgk1RJBx2QA1usj1XAmAMQVVDrnG0Q1v/EuabJ0wFqB2TKN
         iP52ywXtPj/MrL4fNdj+3QMNwMLwjcAOWivRbX3RAVXohF7AYinpU0phzoiZPl6Ao8SG
         mWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763096366; x=1763701166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QuDCnWgkqjlQ11BcKbwc3ohcgqyxg31FlUTz0d8WM4=;
        b=pfSk23j7MCaHyzarMgSKk/PGsFzZpoaqnxby1ChlTsVWD1QTVJZcwzrLro5Zu0Qu4Z
         QpUzXOnEbOTMFQwjANAVoidKzCBNDTymwotsKEOSkD9ik82pJen4Cq30zSMtY3tqO4A6
         htrdVDgzf73zfXxblfOTYCCZ/UIYxzQ8nulzDQuf3Qnmj/64uXyJiJJJdSrwTFYbc486
         IAi7Osma/Zr4OQxnaIfCDyalTdAuIHpelNqBCA2/KttDUdGvKAPhddW8tblrvPgBIFpP
         nNARHoGBPhMdfxlZO+iWnzt8ESVdeWBr6h9luwlofgYUO61uVDlAWsFmuItZQBBv7q/C
         ANAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCEQuYtOafgpBI33op/vJUnzO2s/N5Pel+6RkhNvEYioSNkvLp2HG7FACXDxuFSgy+n8L67b36KqnM@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4MEKC3ZrpYUGUPhbTB2/xpSxiKJW3wWdudLJFIIB/bcJc3XFE
	n5h/qpec69y6g0w4aMMBH/Vp3kxf0sjgtHUYL7n4lPKY3l8qSHH493lw
X-Gm-Gg: ASbGnctNbe/2XBvzG2DMUICwEjvDV4JY49/GpUlmDoja+Ims82H/HpeAsLRmrz3PUPS
	wA3gRjrMN96WJOKM2rsO4SDh8MY2mjnkldzLAW1Vw9zn2nuLhKRWMPDvfOxB2WIOS3xv00e+hve
	yTUcADEAPFuKW/Z2gg4EPNTbKvxe6kKiLSQyGXDo5Z8u/NmzeVBNjlxkjDGH8bMTQ8g5zb/0kyT
	Vahg/O6QtFgkwYmDYfTDY1dY3wlIGcy2Rty62G2EKJ8nyHvNXZGEUklpi8EQS0vhCEPfv78EWYd
	tcnwQkU5mTtutsWQY0OsS/wWtwftbWiRvaD1TrtRabzOm68A27kOy0PGwMYibsZzeyfzn7aIDfX
	jvCx613WEk+e6jDQ3HppAJRg5xFDTvARetbDc3gtSxd+TFWkgxRx/Ozz7PVNTGQQEd3hacGRhyr
	Qo0aZbjWXGxiX6f5D/RcIJxktoTftsaPWJgZlRFZLQKPVZVr5du7rPQY1nCSODA3ZqYhs70aBJS
	oFtB/xKN6ht2jFjxHU=
X-Google-Smtp-Source: AGHT+IEr9LojVkj9Ohs4A/YaH2RcnqIElnZyXqqTXBZgVGnVQoeTxkcsfXXhprWw8uH5nmdUbrLSGw==
X-Received: by 2002:a05:6a00:174c:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7ba3bb96782mr2502844b3a.16.1763096365989;
        Thu, 13 Nov 2025 20:59:25 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba438bed8csm1061189b3a.53.2025.11.13.20.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 20:59:25 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 3/4] nvme: Expose the tls_configured sysfs for secure concat connections
Date: Fri, 14 Nov 2025 14:58:49 +1000
Message-ID: <20251114045850.1898865-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114045850.1898865-1-alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_205926_851590_7129E399 
X-CRM114-Status: GOOD (  11.40  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v3:
 - No change
v2:
 - New patch

 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..6d10e12136d0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
 	    !ctrl->opts->tls && !ctrl->opts->concat)
 		return 0;
 	if (a == &dev_attr_tls_configured_key.attr &&
-	    (!ctrl->opts->tls_key || ctrl->opts->concat))
+	    !ctrl->opts->concat)
 		return 0;
 	if (a == &dev_attr_tls_keyring.attr &&
 	    !ctrl->opts->keyring)
-- 
2.51.1


