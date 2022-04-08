Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6F8C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 02:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K58Oqd+e5zL29z4oDHOfkYYBAZFtWQD1OxV4zwQOQTY=; b=uK1FgFJBceAFHGl8d8NF/pETm9
	Rk1abOTaYDU0+vxH5+10WAORWXkhm72KnnjdDgZiLs22IxriMtSzKr6Hz8xDNBuB4slixgvDG+xzF
	KrQtKKBhFSmZ+rL1E7vXdB7QLTKWC8VKU7mVZ9C7GOjIESNOGq5ebwHtu7twwPcC6SoZxQ+f+L0U7
	q+7s6S786s6tMPb0CaDOvgEHtNrOoR9F5YPVYkdxNH/J5VNCuWjFfuX236JkyDTHeO2mdMACHOUY6
	s0YCBe7nGm+J1aRtB2lNEB5tFMR1kk6OQAqYC2kOnUHsUCy4DM2MxERmzeP+WcseQMzjmyHuCgSEE
	nALvmaEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nceoU-00EiJq-I0; Fri, 08 Apr 2022 02:57:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nceoT-00EiJG-0g
 for linux-nvme@bombadil.infradead.org; Fri, 08 Apr 2022 02:57:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=K58Oqd+e5zL29z4oDHOfkYYBAZFtWQD1OxV4zwQOQTY=; b=Jjp11Ep297dSqk8lChFTL7AvUQ
 91ecFm13x2IO2SkZVFgM9ZWmGFYNAdFN+lInl2xGOMIp/ftBoN6A/I5PjelATQLLtq8TJvkkQmWDD
 kZOSkCigsE4yGI6WUKq+sBQ0FnVtig34/l/aB0vxs9hqTr7MvJ6sJunpsgnJ3lNnQKWb6EvBGyGoo
 CCRGzOr2YquQ5Jj1+EtopfF4L+QY2VfJXRyS9Xh11dWy+NTQSUadkl+UeTs35kst6v/Dx/ectkvh7
 3kcr9OZ29WeZVfA4pUENJhyGD/i6W8T3hqa2trK1inOG5yfTgvwAUTCvHYQa43vLKBja/JxKcUhZB
 lnTwDiWQ==;
Received: from mail-m118206.qiye.163.com ([115.236.118.206])
 by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nceoN-002kLB-6k
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 02:57:26 +0000
Received: from localhost.localdomain (unknown [171.83.117.87])
 by mail-m118206.qiye.163.com (HMail) with ESMTPA id 925C5BE43CC;
 Fri,  8 Apr 2022 10:57:06 +0800 (CST)
From: me@kingtous.cn
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 kingtous <kingtous@qq.com>
Subject: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Date: Fri,  8 Apr 2022 10:57:04 +0800
Message-Id: <20220408025704.6352-1-me@kingtous.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQU83V1ktWUFJV1kPCRoVCBIfWUFZQk1ITVYYGEtKQhgaSE0fSU
 xVAhYTFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Khw6MzkBS05DChYPHzEJ
 SyMKCgFVSlVKTU9CSENNTUlMS0xIVTMWGhIXVRYeOxASFRwPFA4IVRgVRVlXWRILWUFZSkxKVUNI
 VUpKTFVDTFlXWQgBWUFJSklNNwY+
X-HM-Tid: 0a80071a9eb52d28kusn925c5be43cc
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_035724_146903_7F34ADF2 
X-CRM114-Status: UNSURE (   8.32  )
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

From: kingtous <kingtous@qq.com>

I've encountered the suspend issue which causes NVMe SSD cannot be detected after reboot from Linux or wake from suspend. 
I've tried almost all popular Linux distributions like Ubuntu, Debian, Arch, Manjaro. None of them works with my NVMe SSD.
I changed a brand new SSD but it doesn't work either. Originally, if nvme_ns_ids_equal method returns false, the nvme ns info will not try to update and namespace suddenly be removed. This is the issue I've found causing my laptop SSD not detected after suspend or reboot from Linux. After removing 'goto out_free_id', the suspend issue has gone, everything works.
When nvme namespaced ids are not equal, we should also try to update namespace info, not just skip it.

Signed-off-by: kingtous <kingtous@qq.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8..89c6a9598 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4056,7 +4056,6 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out_free_id;
 	}
 
 	ret = nvme_update_ns_info(ns, id);
-- 
2.35.1


