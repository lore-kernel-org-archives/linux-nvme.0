Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521C3E9A02C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 01:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AmRiY+gYv1Yx/1Ht580JCWnZXV60oDsI6NKnjtBd258=; b=AKus9tltq9SnQI/BXERKkhku/a
	Oy0xgcXh3et72aRHI7ouUa92MvzowoXBN17nGvWraNDoW+5YvCnq/nNpZtBXuy4GXEmTSgv3TCjOj
	wjpHX578QFLJTGvEGgE8sImIIRcE+cFmCGikHyGloIfYSy0cA74sQO8/puLTkCveKwqq4NJcQPLX7
	M89DjTQN5tYn4CivY/33dyURh7w6QfRGjuJmL3WJnko9RwCeEeP4an4kruuvNlN4xuubeyYfbusb4
	B7xBf0sDR6XRYHgME6n1x+AAkMV0rsDJju+midEYkAGq8AGE+h3wpMlRuachB6EJX8KrRIDM8zjmm
	FjmHvAJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vst54-0000000Ahbt-3hIO;
	Thu, 19 Feb 2026 01:43:50 +0000
Received: from mail-dl1-x1261.google.com ([2607:f8b0:4864:20::1261])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vst50-0000000AhZa-1ciB
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 01:43:49 +0000
Received: by mail-dl1-x1261.google.com with SMTP id a92af1059eb24-1273c690e5bso35233c88.2
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 17:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771465425; x=1772070225; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmRiY+gYv1Yx/1Ht580JCWnZXV60oDsI6NKnjtBd258=;
        b=cCTypFT99LKJiRYNdGQMUsbF6gOKA3b+fEFBOb7LpeHUrLXVp96v/WiCXZsCUHsge+
         uRyR98RScdcPFNiLKC9BITk1r/onGoy0COZoRt64Sq9TXW4Q3mZzEa5y2nFO1IDgbO1/
         IW0YPVc+qM+PdIpBz8d5GgUKYTptysJdG1inFvzRc6qv0GE9oSIBtj1QqbaQzYznhVYY
         fA6A+onxGcr4j5kZ6p8D4T9UHC8TUiIBwZEzboxgGV6qNB4HTDgR4bVt33vfu251sJTj
         K6QJ6HTyHBpo+FTX556KuY6H+BR1man03N4sg6lhHx7967VmuKxGSUboklwKoqs+UQ0O
         7e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771465425; x=1772070225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmRiY+gYv1Yx/1Ht580JCWnZXV60oDsI6NKnjtBd258=;
        b=lFYottdeZi5Ss3S5WohEtlCTV+AxSm+J+elOTVsjP+8nFtsR4y1f0olAB3JLH9N+Cb
         XmvdcoE1la4sRa2tSXLZJQeh9KLToZQdo3nWlJ5VB+Ur9UqVTvl8NJa+3jZkvJUKTzTW
         j4ayH6U+3DR+/RZhbhaUeQ86exUMo1RsuhQkZ3oXQLkXyxj3bZ4DlqlCAPK/GX2iXZ5W
         ARRyfl7PdkZKKhsy1N5L0WIIJi6erDF2nPigC1i7F1XqIky+9PMm7WnaDQRi8ungu1XF
         UCm1Hfw/U2qb7ic1eD6DMD0YuxdmIVXV5wKl0CsRqWkCF02I27ZgM9O7D/8fuJD/Rr5X
         uJJw==
X-Forwarded-Encrypted: i=1; AJvYcCXu0TSOj51Rxiss8xaFKor2ABthh+tfXoov/ej+H7ZycsgOP98lnfz9wNUipL29+2rfX1S88EfMpWG7@lists.infradead.org
X-Gm-Message-State: AOJu0Yz54Lq/fWoZ0Z2I1tEm+5QvspQY0GD3OEY+z01mu0E6ksBbLyj9
	YARMsUOquB6byOjcWV6M41OWoeHz9xsvx0cC5LHrg1rEe17tSmBuUV+fIKIAoKAkSClleF+k1ZK
	4atFSoY1Q+hzAHnEz0wzQOzycSAxDXJpcaduV9PZZ8Y6rxoAds/Ch
X-Gm-Gg: AZuq6aIwKozinGJVOEMpfxx7CUueuO8rUP0rRo7XJyh+mYLuHUqBcSpIJkxfgN3CIFt
	+nlCsRQ2qhp6oMs1Oe2NuH+iNuhxAghPit46cQoQ28SZpamshL0D+39Wt4z/T4FowkFW+Vxdl9q
	SI4kxVZZv6YOvHo5/uLN/kraMNCzOWg8aC3vhYo9P8AAI47af4jdZmIfN/QeHlQcRMXuNmcYGwf
	OSabVLtY4eHp0StBBW9s6Sm/Z9ZKmyybpiaLK2JnrJ4i8+pFY/hJIRlBKDSvTUBlOD4TZbAmHo8
	NF0GAT0CN7txv8Moou17K4hR+yAwvipKtFxxCAn3SWOY3/iLQf4k7xcoWbTCRHes4acpAyiiRqv
	YE9lyV/CE4Q9fJZ3upcIlRsipMxFJJedXzJuTp68=
X-Received: by 2002:a05:7300:3b04:b0:2ba:673b:e328 with SMTP id 5a478bee46e88-2baba13781amr4428856eec.9.1771465425201;
        Wed, 18 Feb 2026 17:43:45 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2bacb64f67esm1955371eec.11.2026.02.18.17.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 17:43:45 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4019C3422C8;
	Wed, 18 Feb 2026 18:43:44 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3B4D1E41D2F; Wed, 18 Feb 2026 18:43:44 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 4/4] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
Date: Wed, 18 Feb 2026 18:43:35 -0700
Message-ID: <20260219014335.9061-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260219014335.9061-1-csander@purestorage.com>
References: <20260219014335.9061-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_174346_425063_E3CEE9BB 
X-CRM114-Status: GOOD (  14.34  )
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


