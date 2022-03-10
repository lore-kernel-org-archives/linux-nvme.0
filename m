Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B77AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 01:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1QXW3sZqeJMoaJvb9AwEfEQU8acvgvaJgUpheO9wkOw=; b=ENrqbPrTANWRXn/4Cxskt+nezM
	OIeym1XsRltCFmhLUE2b7UxAS6OYgV40gZ5SVJu0gD2v+/BNIIRel2IXLzCdiDTcrfNgQdny/pOHn
	75IKDLh4H2dgwrwwc97Dl9Cf8m98Xu7va2MjTtkSuC/DRwY7LVHCzoAAl14EH6Ye+yvnoeGZ2f47e
	L0Vw5Bp+Yq2KQZ0Kon0hC8Dv3YvlKcZMZEUHUHxZv9J9/WuC670FVTlHpVCNIE+97+Y+aA2CvN7+o
	rvhQRhzAWPP4XbVKQ4ONkKAHQC0X3WkxMepNwv/jligBHrYa90Ds52CBclzZ/vysCxLikbcVie9pk
	TMCIgTWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS7YV-00AxhR-8J; Thu, 10 Mar 2022 01:25:27 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS7YS-00AxgG-5f
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 01:25:25 +0000
Received: by mail-ed1-x532.google.com with SMTP id b15so963981edn.4
 for <linux-nvme@lists.infradead.org>; Wed, 09 Mar 2022 17:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1QXW3sZqeJMoaJvb9AwEfEQU8acvgvaJgUpheO9wkOw=;
 b=Rp27Zx9UuwlbKpTTTXoUIbDtQFRmI8rezTIp48C8rDO0+d/rUEGpXP7BB7M8/KwEcT
 TzdEtD5TzShy0k2kY8wfPS++QMiVvKowMsJd/nXnsOkcFMuHVuF+1Yjy2G02veudDshJ
 VPOrSRZJDf9yYvvxuQmpuy78yV3w2c0lLWzsGp2/qZUpf1tdY7H5vlzP2SThoMITHi9s
 gIjfXestwUhy3Ru0Dq9XKfkkzduWt4lPcg7BgDQ3kxAM3mgzduc+jOzXDERWanKdSmKS
 QLn91MzbFI44RqPrkc7K+3tsx8mOTbsHk1uVBg3BHeODi/sw3YoeRowb1oOAIP9j4mU5
 1CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1QXW3sZqeJMoaJvb9AwEfEQU8acvgvaJgUpheO9wkOw=;
 b=fwnxuTCPbXufTaNYh7Jd267J1/oxm/AXj2UJ5owJP/NHt1Sn2BBgC+Vh550I032UfO
 lIrE+ssWHKqfa2PHuHF2qT61vKj5uRp+68f29uUj78bY5K6zmrmtrzfzqenBr6M2e6vH
 mlqgx7M6uJqecYG9cCCXLs8PaDLK6a0yVmESayfyRYqJHSsbqQ07CsFhg8QcJiwlNi97
 5dwyQzIVXJNLCkD1cWmxsKMjtEzf8s0R2r+TsLVZcgPmghgoL7zuezR+Oqwe7F5M+J+B
 +5SSCqrmiy4PowVa3ZL/HcgECJ+W7wYEW0V9ZOvYFpk2xZQl1EiPJN/LMu/x9oPN0mNC
 H+5Q==
X-Gm-Message-State: AOAM531aHAz5Shq2f/JICSS9iMPPL7EUHBsDiNt8V2QfEUaFkE+0xmlR
 cBB4bnew8mxhj6jn22JCJnBGKjfi8aKHiw==
X-Google-Smtp-Source: ABdhPJwJGkP2VCXyKAo2ElGVHJSSBMn4fLL6ISzt4bMFpspRdzg99Z1q0Bc57SABXiVOPpq6OYYYWQ==
X-Received: by 2002:a05:6402:d51:b0:416:5f17:990 with SMTP id
 ec17-20020a0564020d5100b004165f170990mr2061704edb.239.1646875522421; 
 Wed, 09 Mar 2022 17:25:22 -0800 (PST)
Received: from nlaptop.localdomain
 (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
 by smtp.gmail.com with ESMTPSA id
 u5-20020aa7d985000000b004024027e7dasm1438323eds.28.2022.03.09.17.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 17:25:22 -0800 (PST)
From: Niels Dossche <dossche.niels@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bart Van Assche <bvanassche@acm.org>,
 Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH v2] nvmet: add missing locks around nvmet_ns_revalidate
Date: Thu, 10 Mar 2022 02:25:11 +0100
Message-Id: <20220310012511.82536-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_172524_247963_DB7D5189 
X-CRM114-Status: GOOD (  13.46  )
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

nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
held. The only caller of nvmet_ns_changed which does not acquire that
lock is nvmet_ns_revalidate. The only 2 callers of nvmet_ns_revalidate
which do not acquire that lock are nvmet_execute_identify_cns_cs_ns and
nvmet_execute_identify_ns. Add a lock for around the call to
nvmet_ns_revalidate in those 2 functions.

Both of those identify functions are called from a common function
nvmet_execute_identify, which itself is called indirectly via the
req->execute function pointer.

This issue was found using a static type-based analyser and manually
verified.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Changes in v2:
 - added sentence about how the issue was found.
 - added missing &

 drivers/nvme/target/admin-cmd.c | 2 ++
 drivers/nvme/target/zns.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..6d1f5e02d27b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -511,7 +511,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto done;
 	}
 
+	mutex_lock(&req->ns->subsys->lock);
 	nvmet_ns_revalidate(req->ns);
+	mutex_unlock(&req->ns->subsys->lock);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 46bc30fe85d2..56e650a84bfa 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -123,7 +123,10 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 		goto done;
 	}
 
+	mutex_lock(&req->ns->subsys->lock);
 	nvmet_ns_revalidate(req->ns);
+	mutex_unlock(&req->ns->subsys->lock);
+
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
-- 
2.35.1


