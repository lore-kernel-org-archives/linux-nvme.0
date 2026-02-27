Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341641048920
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bC/PSnv7yOwEPTd/AMtRMqWpAAmzjzQLzKujNS/xPPY=; b=pbpZyQF35U3ZRcrgN0XpnL/xPI
	I7vcr1B+6nMtuMODCx3VX2ANRrYXTdEoKJrsvFxtqt4BXiJJ51Xk2pG95xv5+2IlJm19f33yD2/7d
	d8pFFsKDbEplB5mWxnxfVKIDCoeC0kHqw4ICouqg6HObsjvHlzSyF3/7c7Pu38Bzb3fSkl5D1M7/s
	pgU91H5HjmCw9hPUhCMU8uykhl42IFi4a+BOnY/o3TI0ryr/tnDbNfqR0H4RBvBJbVNQkQXLvpW6m
	9j/vJ3zeRlPt11MOewR3jRxvTgfQVhdBRObml82bqW0kBrVxoVfpa930OEIi5/CiupH4AJ+DnHot4
	+M1Oi3HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QX-00000009Dmp-14z2;
	Fri, 27 Feb 2026 22:35:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QW-00000009Dlz-00u6
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 22:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bC/PSnv7yOwEPTd/AMtRMqWpAAmzjzQLzKujNS/xPPY=; b=nXkd59B0oo30ZaPzPlyR7keEnS
	X/zREt6mEU/cbKy3TrfDlnqDQewbAHk1LGp4wtkgQJw8yTitxYYGyD0rdMFIAg9QQGaUkLh/pbhHm
	4A5n9MASDq0itUPTkQEzNdOHpDtvAV8jChbKlKP3fDPwqpuDLiQF72FeaIsF3c3OcPGmmCc96TatQ
	Q95F9BZlZ6ajZRJbEJoTZ3zV+HAE7pVfHo+W2w97IAXs4r9G4pTgHGSG8wCrtUYsyLz90FHbIMQAb
	PAACBwhn2i1kLsKN8z1Dg0oVSWVxwzenhl2HFYuNaH+FF6qQ+8oxiystRIOmqoJ93qZIU/0emRSOR
	ielEtGHA==;
Received: from mail-ot1-x364.google.com ([2607:f8b0:4864:20::364])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QQ-0000000E0gY-2g6l
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 22:35:13 +0000
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-7d4d0760eacso355899a34.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772231708; x=1772836508; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC/PSnv7yOwEPTd/AMtRMqWpAAmzjzQLzKujNS/xPPY=;
        b=DKEXjaFrr/9VOo9ng1hGZasDIKXxS89yEb4nDoB79n+i2gDFjy+Tpt9leWC3eo3DpZ
         hbQ4vL8mPuIeoQn5bEu4GQxMfJq2x2vGzkgLBNOwlAGVnpxkoLlOEeknFsEIFvPV8GRZ
         uCzUM8zDPuLZoS/BMGYL7OUrd6Uc0ElsMQKp3644ntvXWkauv/KkQk9fTq+UTjiB0TUh
         IIT1ttS/Oc3NaOAbJGW+0zWRB+wVM+Y0AaqyoJjkBitmfKgeIDuZCoEID4pJaUqe8boQ
         I9V7Q1ZiRRnlMNFHCUPscQ9q4eY0fKgk5URun44xXySsvSKpQbwrsyspZf/wmgraAo0C
         cfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231708; x=1772836508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bC/PSnv7yOwEPTd/AMtRMqWpAAmzjzQLzKujNS/xPPY=;
        b=M1kgKbx0dSQSMy5eoADgIzSAwDUibvUKXfHzL/4IxGR6xK7Y26TjPo9/wWov8mGA2P
         aSzoZ5zza3F0EqI6C6Fyv0Oo9quit2aAx/2zr7eZuoh29XWo1p10/4WXwcADSpjVdTUD
         Pork/V6p09gdYQq2+oSvRo2x0Jf94cjA7Oz0G5/xHzMuo5Uhpe1Q3Hrk2V+gDVIvCxxc
         aEFwQbydoClJvhn3ejOUcSoxUuJ8KsvSvYJMMog9HJV5c5BOT5Fs9BDUVI3rwFGcaH5X
         fIjhPppxdSfxrC3kiMAm+GAmMZlz+eNnQloa6pBpii6dxnbw1hqhg+lfQXnMjSr0MhtS
         kECA==
X-Forwarded-Encrypted: i=1; AJvYcCWQxziLCSyDtENkmmbmHrgvXJYLd4KR4JfLxJyflJWcH9lvbQTbZCOJojdfpFL/1oN+8Geud7dQr8wq@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0YxZsMllQK6DWINSYbzCnOIKYVOCF0pTgqa/QaRbg52vhKaPM
	392GnxvvxEnn0U7UNiJH9Nb2Wbkr5RxLCyQqtx/mdNTc2yrQjnVsMeIRzNTYLctLH15wA16aU0D
	BVI8CvSkf5V75ljOiZjrpPtJM5E6JMYjzgHI6fnvKjVFExG2m/GWQ
X-Gm-Gg: ATEYQzyom0JdjLckMHkFQQ3vFTZceCjdq8omj1OeDHmLFNaUNFFk0GZWoEQVK4DgmWT
	iK/xcxtiZo3c+hN8MT3Rlq3qx9MCN965iLGL9G2fwv/bdCutwvjiYMjhleskFxraLIL5t84auqX
	2casJnLyc4p/3xRHCeDfC9zdQ+612SeqHde5Mi0FsJ5DitAX1f6QATrnm3KCBJu2zo4Pbv65rI6
	ZEhgsCbOmkx5GSHxY4JgBYAgxti05t7eg63tQszHtJMfnQaHHefemHLtR6d5qani7EtfYXlvvUy
	w2ZiZ7ELbMl/1MQ2ifoWdMfPIZ3KJ+gpm6b3k5I6nS63XhveSvgvZaagpYz4rZJfJtj5MxL9ory
	yeTqd0ob0oWjcjOJAXa4E2n9k3xiTKy4UBXIvrIs=
X-Received: by 2002:a05:6830:91e:b0:7d1:4980:2537 with SMTP id 46e09a7af769-7d591bccd6amr2761555a34.4.1772231708517;
        Fri, 27 Feb 2026 14:35:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d58644a35asm829296a34.1.2026.02.27.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:35:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8A93F3420C0;
	Fri, 27 Feb 2026 15:35:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 86A24E420D8; Fri, 27 Feb 2026 15:35:07 -0700 (MST)
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
Subject: [PATCH v4 5/5] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
Date: Fri, 27 Feb 2026 15:35:03 -0700
Message-ID: <20260227223504.1162421-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227223504.1162421-1-csander@purestorage.com>
References: <20260227223504.1162421-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_223511_204056_F8CA9B2F 
X-CRM114-Status: GOOD (  13.92  )
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


