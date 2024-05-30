Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D98FC25B78
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 06:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wpBJyvKLbB0o8FQO4pAtrdX8G0ep4WWIcnh4ae7d1ZQ=; b=zCVQvZIKxML72KQNNmDrj1GCTF
	Hj1juuuI6S9qE1CJ6hMH5qzP9r4Yj5uFWgvT+7/dNn6K5FGJttM3Lk5gQBFVxRTUUoCKkaEt5JmDz
	sJPjk+TZnUL5Ii4Lr3g21dYbdIp629j3QL4nNXMdigE+20593freEMQQnRbac2sUKElEKZMmPJuau
	RY2Qn9KrxzcnoDjsQ2p4i9NhBxElGC1+HnPW6EZtdnnU7IFCHsE0CGFd8GBbg5zV3hhe46T9gOEx7
	+EYj1MvRcPrDVlVzVnpQFSfPLcd67TlD7zDZrF0wiqUsf9gcPRIrU3jHb36MWQFFTIKKO0M2gmrzG
	NomsAvsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCZ77-00000006PZz-2Dll;
	Thu, 30 May 2024 06:18:13 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCZ6M-00000006PYu-4AXr
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 06:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717049841; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wpBJyvKLbB0o8FQO4pAtrdX8G0ep4WWIcnh4ae7d1ZQ=;
	b=sDct1tpWBaKZgPbM1kKGeN46rOzjvM7am29vUHyNOoAxaVNi74wlZgjgOK9ymfzCERJ63m9jxd5ojEly3xH8VcWXMNdTyXLfYTOolYR5zMXbpPVPPFs6jk4ZcmAeLGEY8orQm8Ux1E7qWShHpD9Q5jLXvk8rKu8lzWdMRvwHdIU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7W2FBh_1717049839;
Received: from localhost.localdomain(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7W2FBh_1717049839)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 14:17:20 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Weiwen Hu <huweiwen@linux.alibaba.com>
Subject: [PATCH v2] nvme: fix nvme_pr_* status code parsing
Date: Thu, 30 May 2024 14:16:46 +0800
Message-ID: <20240530061646.52167-1-huweiwen@linux.alibaba.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_231727_935164_97610667 
X-CRM114-Status: UNSURE (   9.15  )
X-CRM114-Notice: Please train this message.
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

Fix the parsing if extra status bits (e.g. MORE) is present.

Fixes: 7fb42780d06c ("nvme: Convert NVMe errors to PR errors")
Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
---
previous version of this is sent as
https://lore.kernel.org/linux-nvme/20240529122300.92377-2-huweiwen@linux.alibaba.com/

 drivers/nvme/host/pr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index e05571b2a1b0..8fa1ffcdaed4 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -77,7 +77,7 @@ static int nvme_sc_to_pr_err(int nvme_sc)
 	if (nvme_is_path_error(nvme_sc))
 		return PR_STS_PATH_FAILED;
 
-	switch (nvme_sc) {
+	switch (nvme_sc & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return PR_STS_SUCCESS;
 	case NVME_SC_RESERVATION_CONFLICT:
-- 
2.45.1


