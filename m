Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CD3D10C0D
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xzQ35Fu9yrSqqcl3Rs2gEvKRbDvgnBO0l4rn23dBsEQ=; b=j++28bNKSD2bMamZGYIBTgTQBh
	nX6MPewzcSOcmNYnYtgnjgdLXjqyzewP2+Di2mwg+2VMUvDsl0XdqCsDcfbkotsR5JHGVr0QtdBH/
	43Zts8dl/DkxhdAYz6s5sBH2/AyWrW3YNYG9G5eIEr6uvFt0MOJ0nAaoEFTVAPxorfYnEUvlG5oXw
	VoWjSSfCtxprzePioZJgqWzmh4OCqgFt+caAlxHhm/wDje7NN223I8lcSgiUmi72G+L7xltxCqXvp
	GcQ4RQYcDxWFkEoKZw81n1gJRsX2cN7J1sp9y8jdPkibylXcixs/DpeleIYho+VzA83qhJ+miT3hE
	7W/nAkkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssq-0000000D2ho-01ig;
	Mon, 04 Nov 2024 08:56:24 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssC-0000000D2Sh-0r9W
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 08:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710542; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xzQ35Fu9yrSqqcl3Rs2gEvKRbDvgnBO0l4rn23dBsEQ=;
	b=RPM1D45UsLRRgBfYS3iBMzmh7S16f0TriYUiLk8PLSwRt95T+/jQBDkhoxXtpPcWHNJDg4ApkKWMCQARh8zUL+Pc/IWEf/driCZzjLL0xhVeGrvKNd56IvWkNv/OrETb9LOMbOzSlK0I8a85GT4hBV9OHDgK0unMWvhUI8NJ1Gs=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIdoI3x_1730710535 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:55:40 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH RFC 2/3] nvme: query independent identify ns by default
Date: Mon,  4 Nov 2024 16:55:01 +0800
Message-ID: <20241104085524.118221-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104085524.118221-1-kanie@linux.alibaba.com>
References: <20241104085524.118221-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_005544_420134_A108F067 
X-CRM114-Status: GOOD (  11.24  )
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

Query independent identify ns by default, if returning fail,
go back to sending the "identify namespace data structure for the
specified NSID or the namespace capabilities for the NVM Command
Set(cns = 0)".

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eed41d4d2599..563abc0cb4a1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4018,7 +4018,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
 	struct nvme_ns *ns;
-	int ret;
+	int ret = 1;
 
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
@@ -4034,10 +4034,9 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * data structure to find all the generic information that is needed to
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
-	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
+	if (nvme_id_cns_ok(ctrl, NVME_ID_CNS_NS_CS_INDEP))
 		ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
-	else
+	if (ret > 0)
 		ret = nvme_ns_info_from_identify(ctrl, &info);
 
 	if (info.is_removed)
-- 
2.43.0


