Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD42ECE564
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YrN4LtIu/GTIDIR2JFgXWyv3VXGQnruCjrp87i9urmM=; b=kjR4Yh1nMG/j1W4tAcUjGS0r6z
	QwphttsDRZbl0BIvW8qwUvCltaeuvdPOIdMu5vuDWfA5Ddu6kOor0ZxrGXndZC46D3+pQUesV+Hxf
	MEQ62XtkH+5AaojGQy84D8kvaOhlpDnF1u87AfzZBSAwycmS2UVfRSjTbv48uggHr9uhVHxB6WaZl
	MioqbuhaZYQzi1boVdbFBrCmRu0aGuGgVHi8+7XO79Rhf7LiA9P4jg8tDMmj5qlSn25QxbP5zhVcJ
	KILZx2eZ9Zt8jJLYb2kcWjEsv8WrmKEsw1F7rNiNKZTOeyTqzQfkeWpjlIPiX9UDZ02c6M6pB1ZDU
	4PMsEcJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snxWV-000000056Xg-0fV0;
	Tue, 10 Sep 2024 09:50:59 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snxVn-000000056OD-3627
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 09:50:17 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-717880daae7so540295b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Sep 2024 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725961814; x=1726566614; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YrN4LtIu/GTIDIR2JFgXWyv3VXGQnruCjrp87i9urmM=;
        b=MYphQ3RPs41sAVra8SHaAIoCFBjGu6m/ESG7WJL2u70+uXiwkKa6lM6oFp6cT6m/ie
         9clCl7UWLkSyoQW45VlPlPzru5iORrGDdgYd3Xx6jvV0xJDlFT/AUNfzEVATnB+ss/ii
         UEFHnct0wg5TYkABmniMcTI85E3cSd7sZ4wPMERd4oy9Zp5UNYfhGKUJDs/9P4BcX/Dh
         QntQADqn4dJRn48kzQUylXkWy9VgBzYy88EEyTq/KY7kZpyOc34YK2onRkrfAG/p4e8E
         7iTnnXjoqOu/HVsHfE85VzW/igV5KNLDZX62Vtca4bSakKgUQy00E9e5BwWicFgPVvbC
         rZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725961814; x=1726566614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrN4LtIu/GTIDIR2JFgXWyv3VXGQnruCjrp87i9urmM=;
        b=ZbgftgRbzwlpOjaBR4beiZ7VMGMqwwOUTUfaWKT0THLwL4ryYO/+lg2khvzC+V/5Rz
         pdi+JJytqOMRbfnvcqNnm0C4D/Bj0ClxLUcTEkOcabGBorBvM7vkxCNC41HG2d/QJkWt
         UwhCfPJgjSlH4pwIDUZPeJ0h7DPg1lfbXWARgEm/2PgEl3L1k6bMRLjx5LevhmFS8LMT
         EMEN8U4CQuG+S8fJRifsQeM2nralNcPMcu9uOvwddMIqUgJdh1SWAqSF5eI4VGSllIQm
         BYaYgSuQl36MTQNH9mpD9D34Xos20hYe5POoxPHk5XCI5FcWBktbrb396FdT38yvVmoz
         nVjA==
X-Forwarded-Encrypted: i=1; AJvYcCUlRwD1sm+xBHPwSlyfpA3dEM8KigtjADEiPsX2Sw1MXN1CUO9r8CGrL0+lBwYzqvcHsBheUuZPdrF0@lists.infradead.org
X-Gm-Message-State: AOJu0YzK9/5qWmKcCL/IVCBOfDYia5bL6sPGyZBqhAN3cEjQg6a4kV3V
	S49aShM60gXVZ/yMNLH2ieElOX5Ea289yPz/+3ky4rjdqJhIWgbH
X-Google-Smtp-Source: AGHT+IET6iNyaS77CBTpY8dfIkYZhLZp4/Fzf239I6gPNbNi4M059RZ2fGZfWvtN9xONI3XosJW/mQ==
X-Received: by 2002:a05:6a00:b87:b0:710:51e4:51f0 with SMTP id d2e1a72fcca58-718d5f5e710mr7460171b3a.4.1725961813980;
        Tue, 10 Sep 2024 02:50:13 -0700 (PDT)
Received: from localhost ([1.202.249.90])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71908fe2636sm1034308b3a.60.2024.09.10.02.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:50:13 -0700 (PDT)
From: Yihan Xin <xyh1996@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Yihan Xin <xyh1996@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Force ns info updates on validation if NID is bogus
Date: Tue, 10 Sep 2024 17:50:06 +0800
Message-ID: <20240910095006.41027-1-xyh1996@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_025015_801785_37BCE3F8 
X-CRM114-Status: GOOD (  15.01  )
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

When validating a namespace, nvme_update_ns_info()
would be skipped if nsid changed. However, this
happens everytime the in-use controller is
reattached if NID is bogus, causing nsid not being
restored to the previous one, eg /dev/nvme0n2 ->
/dev/nvme0n1.

Don't skip ns info updates on this circumstance.

Signed-off-by: Yihan Xin <xyh1996@gmail.com>
---
 drivers/nvme/host/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1236e3aa00ed..c0875fb93b8d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3979,11 +3979,24 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
-		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out;
+		/*
+		 * Don't skip ns info updates if the NID is bogus as it
+		 * changes everytime the in-use controller is reattached
+		 * to the bus and thus the namespace is recognized as
+		 * another one.
+		 */
+		if (ns->ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
+			dev_info(ns->ctrl->device,
+				 "Ignoring nsid change for bogus ns\n");
+		} else {
+			dev_err(ns->ctrl->device,
+				"identifiers changed for nsid %d\n",
+				ns->head->ns_id);
+			goto out;
+		}
 	}
 
+
 	ret = nvme_update_ns_info(ns, info);
 out:
 	/*
-- 
2.46.0


