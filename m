Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0013EC7EE2C
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jqqLRjeuedEXywHhHvcHNePSNl1IRUPkabkNw8gPEAc=; b=37NwlxnEqq8lkDHtDrDpwq0M0h
	/PqBJjYJRm+vaNkEfRrVIMBOtFhkwG1/mFhXmVCJtRWYlhOSViLaetqoo4uqH78VMdebAM9q2P/PS
	geI1FYwGSmuiSwazbPOXjA5+b2gwsTOVxN99qOJF0f5es5BS4MdFe2Vd9l8Mg3OQjtSw0jQwunQEp
	ptSK57GDCla5Vxo8q94XHblI7RzLNny22Xhp0bHB36qF7xe295f0mXqIOswZnqYRrtxcIXGZUCpib
	iq4GkUUonaa8xf1l/uKKavtcXAv6fBg6wApqt38lgPHQJ+j2aP20cOOFDeiIb88Y/VRSfW3w5vzSd
	6etNyS7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzlq0-00EJeH-24;
	Thu, 18 May 2023 22:11:08 +0000
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzlpy-00EJcj-1l
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 22:11:07 +0000
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6abeffced6fso1910693a34.3
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 15:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684447865; x=1687039865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqqLRjeuedEXywHhHvcHNePSNl1IRUPkabkNw8gPEAc=;
        b=sMIguDWeE4sNha2i0oUcurBlB+Ttig4By6gW1KCb1DiQf96tL38VHOt9cU+ZKzIXdW
         J3x8EXLFYp01cF0HgDWBp9vvnB2s5eEqk+HEsXh8sl3gy3hnGm/rP/G+jE94QUQtvec7
         Vz4T2pE9aT+nxTWawtGNMpkdtDlyvkd9Q1RWGDkyK8hdWbcJL0AaTB68zXfohZSG29Wj
         oaNL/aG6UODvZXBIARuYhzWgKgUDtsj9blFf956Ze/npfMemUiXHkXtK9E7R1XPRKaVT
         fhWULOG4vzcz55u1pQL2PXc1ZSKUz2NB7Vb5OpetnyuaDN1+Q68nknpmXi/TT6HgaU5q
         kI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684447865; x=1687039865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqqLRjeuedEXywHhHvcHNePSNl1IRUPkabkNw8gPEAc=;
        b=QZ0+jGeITrTnbpDTfZLoTlX1TabFkFbBP/5A5fiUXmmRMDl8Nc8AUd2Nx77WfeCev0
         sylegMT9YGj7VXZn/ywyIhKfCWc042Jjnqrri/OVZpQFghOe3J2dEb05AnRAcbuUhrzp
         eWF4Cuzobh0ghwiUyflwpR7S5EkwxyILAaHPkafaap/QrPWT/fiQ/Srf5ye+LANfUFlA
         r6OOW9Kq1iJMtWvaehStxXbZpQxrrS8R/OLO65wG/jeC9tmU7Ku5a99pdBrIGK7n9OUo
         DKJspehNW/AiHdrkJjvv58lw5n7IqDHHKBzb38EuL/Caf8Im2Pdyd45JQ9o6Y4d8JQzt
         QXDw==
X-Gm-Message-State: AC+VfDw+apn8iZHh67XDJsZMoF4UF079KgMolntYaZ9Zlu3DPb3bR0Y3
	7kNWbZEAvZCiascs1zByFPU=
X-Google-Smtp-Source: ACHHUZ79EimEhUGGVU8MbPRsiyw4g0UXAl3MS5Ch3lAD0vDGGZxS0Ntj6e5yvFh/yE4FiuqxQjhExA==
X-Received: by 2002:a9d:65da:0:b0:6ab:14a8:5452 with SMTP id z26-20020a9d65da000000b006ab14a85452mr14685oth.20.1684447864729;
        Thu, 18 May 2023 15:11:04 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.195.153.187])
        by smtp.gmail.com with ESMTPSA id p23-20020a0568301d5700b006a42e87aee4sm1092262oth.32.2023.05.18.15.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:11:04 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 1/2] nvme-core: remove redundant condition in nvme_ns_head_multipath
Date: Thu, 18 May 2023 19:10:53 -0300
Message-Id: <20230518221054.56378-2-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518221054.56378-1-irvincoteg@gmail.com>
References: <20230518221054.56378-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_151106_584973_36D9FF0E 
X-CRM114-Status: GOOD (  10.67  )
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

head->disk implies IS_ENABLED(CONFIG_NVME_MULTIPATH) (c.f
nvme_mpath_alloc_disk) hence the condition is redundant.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..7820e40cdce4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -453,7 +453,7 @@ struct nvme_ns_head {
 
 static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 {
-	return IS_ENABLED(CONFIG_NVME_MULTIPATH) && head->disk;
+	return head->disk;
 }
 
 enum nvme_ns_features {
-- 
2.39.2


