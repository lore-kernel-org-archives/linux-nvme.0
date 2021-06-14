Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B30C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A1C613AB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A1C613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3p3iKKJYdvBvafntaFxCiZ+W8o/5SgJAOvynB9nX88U=; b=lOE8JyP9sIh5uc
	JLRBWK+w+MVWb3bjBhc1bNzexEyox1rsiO6zMokXah1TARy3HoaL5LitoJBZ1EXu3dBwWWN6xcety
	S2wtgtvjq4ouLvQNbT1/FTqMOsuJYAKmEIhzkynXT4rTD6ixTnLewrWR6k7zocRz9JrFqV8iWKQf3
	UVia+w1q3wGn56/7dAwYNpkRyXe4OsG3FtBsdB6uP16ZJ6BuzR4phZyscYkB9DJHLauxo6a9Dwz7C
	jhaxBeDL1pv/BAQQk3vxQ07nLDb0/AMN0Tmpe0aHXpfihLXuglfP0JETvkIntpIQ721rGfDbfEX9V
	rldNiozKQoM14k5BHhMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbtG-00Byzf-JQ; Mon, 14 Jun 2021 01:59:50 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbss-00BysO-AN
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623635965; x=1655171965;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9XWMzp4cFc7xyMLXdWYopuX0t3D6x4L9stbcEeFpYrU=;
 b=UpHIQGANIeInvfEPU9qAfWFCfOSTu0EmOBKppZ7/G+402TAHg7J4FeQG
 51tnwcLGYNVP6BWj//HSTGxUq7dglaBHf7+UfhjJ7sQ+/jYTyh7+qJCzU
 dXV4pZPBtgA89DBE7htP6dSeEwmX7SDBkJI+Mk9/BrYxHwlvYxqyk0WVh
 4huKmz3BqgxU1/fRoeWUqzjpcbAi/A5csrvxY3Ma+4YImShd79K5ZhnAf
 XL/0YC+62xCR3kctzOOQGZYmtBJWsQrz8bYFz2P3iNOOsqRVGlJZq3YLM
 ECQp/Ex6PFZgTwqQznWxP8ojyEieVR7uaG08egmeIGtSvyAOiULLjb9A+ g==;
IronPort-SDR: eMZU6dE9toQR3Y9r5VkhmG8BG3T/fjVBcYSusN6a2idrF5rECrVKFE13++LkfvTrVxLrYc6dU9
 6ga3htShijyoEOFghh2SdN5uGXKiMRb7k+61HrMMibfDl923vOAOHDzDrk8qIYQfgfhyC6Roft
 oRI8Dya4LDrT4n5jawKOcJnTSaJLGbG9WtcqZAvSmdAiqra1uDYdjmjVawFN2YN7S/rPw/y+Nj
 kyA/x691LDFexhQi1IUHc3Y3d9kua8oW3C9DzXDO6GBv89MhLQJVFu0aJ6OJXhMF7hxx9sjsGz
 wwk=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="171776453"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:59:25 +0800
IronPort-SDR: NqIJreKCLoTYJ4j4U3+szuLwxMxHWloUNQ+j5m5HCpA0FpsBA++EDRfc1WMxPS30aAz6Fp5VV2
 ECLSnJBqiRUN4aj82CsCMhAGcSuuCTiejvmFINPGOaBOifbMUO3TfEQaJn9UsNZHqy53k1Urdf
 JGgmMZlVXC1adp2vsw5eFLbhFbEhUukjMTO/2O6VxrkuW1pu/s/0DQGCUWwNUjrZG2NbrFEZOT
 I4+MVwkKGJwlap7/GcRCqhhjzaiKPpa1VujZrpphsZJDW4aAJhmbcOQdIwR+SLInNW9/9UEuDT
 +JQv/SaoZJzzbC3QpT3O6RtC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:38:23 -0700
IronPort-SDR: M4SHeAMaRuS/9TsG56cOT/qjN7jSO35ArKIcal7caXir0bRv/zd2MPAA1ifuoufD0UIW4OoxIg
 bm2xW5gXuhL52SJ3dLMHX6TaVbjn6zvrLt3Xzv4xTdAAFXigZS7Ecv14PjkYiH2GqMNCSiWCUb
 1N8BlIkB26WgyeGroz+4ZnAAqzVrllyV+6kV9GYga5Rndn4uWbziw0aux87AqFNaRS43TO/8Kk
 pBCBnZxQ5c7C11jjJrBxNRgsfTvEE5FFV0ocAgoleUs+WRUwNRE42xlZtTXEdrGuFr6jlySxKP
 o2Y=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:59:26 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/6] nvmet: use u32 type for the local variable nsid
Date: Sun, 13 Jun 2021 18:58:49 -0700
Message-Id: <20210614015851.53925-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
References: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_185926_404495_F15E87BD 
X-CRM114-Status: GOOD (  14.44  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In function nvmet_max_nsid() we calculate the max nsid by iterating
over the XArray and store it in the variable nsid that has type of
unsigned long.

Since the value of this function is stored into the subsys->max_nsid
which is of type u32, change the local variable nsid type and the return
type of the same function to u32.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 146909486b8f..8494a132da35 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -122,11 +122,11 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 	return 0;
 }
 
-static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
+static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
 {
-	unsigned long nsid = 0;
 	struct nvmet_ns *cur;
 	unsigned long idx;
+	u32 nsid = 0;
 
 	xa_for_each(&subsys->namespaces, idx, cur)
 		nsid = cur->nsid;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
