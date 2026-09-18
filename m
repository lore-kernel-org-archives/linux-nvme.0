Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E89C982DF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AW01tuh8hRVQtK4qarvblwO+ofGvSgZdhu/67l8Xj60=; b=y1SVVL0OePx/mWnfdsfS9okUxN
	FoDUPDT/yzAqT1t1LDb2E7ovjowN1yr9Vh6N+pPNi99c/HzJj+i0TtzaY6/DGmkVDKdeWMSeBeYbU
	Arl0gWCcswq6y3cJWLfcXLcsxP7GX9zc/9Os07NFs2HU1751F4bkINmOLZHvCS38Cnwr9riLU2Nb4
	FbqBw1n1AqXPsrh9PTCo4FyI0Oa6rBO1tliBhsQ/9XeLPZ80eYszAYYC9o7IJhYgoWQtcExvDXAJ4
	5ivpEOP+FV4VWQvrmJ7r0kq6QEEJrLoV8GLksLWo6kSZip/od4FDGfTGjh2jQyavV6FGigTiyT0b4
	ooTTY1lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9F-0000000FHRS-33UO;
	Fri, 18 Sep 2026 18:17:21 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9B-0000000FHH9-29dJ
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:18 +0000
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccb65437so926355a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755437; x=1790360237; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AW01tuh8hRVQtK4qarvblwO+ofGvSgZdhu/67l8Xj60=;
        b=TkijiJuhERlu7dCJgQ6SG/wDhipKiSru2pWna1FKrzTljMvKTMYtalnaRF6TvmAal4
         3LrK/lVwHhqV6oDQ4a+fpOy9gPGw7IecFYkr8i9LCp/Osk9WWoJLH7wyDEzHgGth8TV1
         laqeEKns6x28kHCTGmdYkkTu1BmCrg4gEg0J6NBN/49vnP0VIwu2dhnvPJMH8R0lDf6A
         0rf1V56dMFdQ1rnN5qxrQ9q82QOv+PKb6KibXjnTiBtBQctRvv433bCRqHQSHF8t8t+O
         32yVHEZUcqfnZco1MQyR+/CQE9b16kn6WDvhy90LR5G0bw/7r/9cmFhkFPWKCxprFNKZ
         ZAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755437; x=1790360237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AW01tuh8hRVQtK4qarvblwO+ofGvSgZdhu/67l8Xj60=;
        b=BGVrs7mGGRSF59EprQha0CklG51bQt/2eE9ur0TBXB0n9K3jM89vkHx9IzTi3Y/m5G
         cEqjRSWeytXeylRgrXSGDM/Yy1Nz9ZveRBoFAlIhmn5lkjRf3YTJ5MzDwzLYb24SZeK5
         M8ap51K5/oa4NY52L5skGbDE4fNckizef40P/0a0CvgbEl4rM+kCMGerphuaaljSLpoS
         vsRQMXwuUonQDpg1SkracqXuOm8M+ePZo3A3W9qvuE9P0UJkXSRFQjuMW09r2Du92AJQ
         hY5XYdvQyuqcu+Fz0oF6imOiik15FYLO00cnabUfc0Npppipt/l6AhnDsuFRVrKRlCMB
         RDlw==
X-Forwarded-Encrypted: i=1; AKwUvBxaibOJn3Pl6UhUI2HrWurkDBtxtWQSm00hE8r1SHMg+Go6ZrOYlgUoLZn5MhRGJN1e4PGghr416xvx@lists.infradead.org
X-Gm-Message-State: AFuF++ncFEGpLOUEtqjHwCR2j9XSz7jKRXXFABkD2alrdIwvMIcXrAR+
	aIQNBUojXzF3GvFfgQ3JqPTpoiEHkoxUc1KK1A7wZ4R3KtFgxtkM40lS/WqK88zM3og=
X-Gm-Gg: AYBFou1E58KJRl6Vlo2agVssR9o4epUNlKx1Ina/Wm6Ts8CCNXn/EYGZczQ9cyyMunR
	whDf3QLdldpQJnCoSJfvMm99PHUYEvA2Tt6fSpji+cDD4OKAQF3w+/yg8bXoKlgkTBvBEqpLFXP
	AqPjq6DrBGaqlspx7NTnDqTOOqAwH+IMMTRBSJaI7/TS7+ST/1hDujpdCLjD3Pc8iBvwK7Gc/TE
	fpG3wpITq4vrqSRTImlEhyHq6DV9LwMcnrdLBqSnUPH1pOEphbUzOhGGeVG4Ey5J6wo/46P5sG2
	I5XLX+gyjaT2cjOPhKhreRSC6bZoMiwDocHLmIqIwHoopDo/nagahWbpFOUGyRsrubiIeuTr3xO
	hTxOAGwt2kQs8QnIc1K628Ev9QMuOO4qiB5JakhMAkXrAzxI4lPLoAsIK+hR60MGNlPnPa10gS+
	PUHxTuI83knnlKb8jV0USpM1Ni3zL9OquEQRProYJVYVNUEliCO0IRHVgHsAeBZZfHO9K2sLw+l
	31FlvkE6+NJFEKsprhwfw==
X-Received: by 2002:a17:90b:4ac7:b0:39e:6c6a:4b6a with SMTP id 98e67ed59e1d1-39e6c6a5812mr574016a91.52.1789755436728;
        Fri, 18 Sep 2026 11:17:16 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:16 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] nvmet: Add support for CQT to nvme target
Date: Fri, 18 Sep 2026 11:14:16 -0700
Message-ID: <20260918181614.3947933-17-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111717_569797_91FD704B 
X-CRM114-Status: GOOD (  19.71  )
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

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
time limit for attempting Cross-Controller Recovery. CQT is added as a
subsystem attribute that defaults to 0 to maintain the current behavior.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c |  1 +
 drivers/nvme/target/configfs.c  | 36 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  3 +++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            |  5 ++++-
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a60b2f271e98..c0cd233048eb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -739,6 +739,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		id->cqt = cpu_to_le16(ctrl->cqt);
 		id->ciu = ctrl->ciu;
 		id->cirn = cpu_to_le64(ctrl->cirn);
 		id->ccrl = NVMF_CCR_LIMIT;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6286e38436dd..88a59ac1e93a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1663,6 +1663,41 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
 #endif
 
+static ssize_t nvmet_subsys_attr_cqt_show(struct config_item *item,
+					  char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cqt);
+}
+
+static ssize_t nvmet_subsys_attr_cqt_store(struct config_item *item,
+					   const char *page, size_t cnt)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_ctrl *ctrl;
+	u16 cqt;
+
+	if (nvmet_is_disc_subsys(subsys))
+		return -EINVAL;
+
+	if (sscanf(page, "%hu\n", &cqt) != 1)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+	if (subsys->cqt == cqt)
+		goto out;
+
+	subsys->cqt = cqt;
+	/* Force reconnect */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
+out:
+	mutex_unlock(&subsys->lock);
+	up_write(&nvmet_config_sem);
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cqt);
+
 static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 					      char *page)
 {
@@ -1703,6 +1738,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_vendor_id,
 	&nvmet_subsys_attr_attr_subsys_vendor_id,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_cqt,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
 	&nvmet_subsys_attr_attr_firmware,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 69491e8e52ba..a93cf7e3a704 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1753,6 +1753,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	ctrl->cntlid = ret;
 
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->cqt = subsys->cqt;
 		ctrl->ciu = get_random_u8() ? : 1;
 		ctrl->cirn = get_random_u64();
 	}
@@ -1980,10 +1981,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	switch (type) {
 	case NVME_NQN_NVME:
+		subsys->cqt = NVMF_CQT_MS;
 		subsys->max_qid = NVMET_NR_QUEUES;
 		break;
 	case NVME_NQN_DISC:
 	case NVME_NQN_CURR:
+		subsys->cqt = 0;
 		subsys->max_qid = 0;
 		break;
 	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 88fa11aa0587..ddf88c772938 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -270,6 +270,7 @@ struct nvmet_ctrl {
 	uuid_t			hostid;
 	u16			cntlid;
 	u16			max_qid;
+	u16			cqt;
 	u8			ciu;
 	u32			kato;
 	u64			cirn;
@@ -347,6 +348,7 @@ struct nvmet_subsys {
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	u16			cqt;
 	u16			max_qid;
 
 	u64			ver;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3757d11ffea3..0b69ed53f347 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,7 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_CQT_MS		0
 #define NVMF_CCR_LIMIT		4
 #define NVMF_CCR_PER_PAGE	511
 
@@ -368,7 +369,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[34];
+	__le16			cqt;
+	__u8			rsvd388[124];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
-- 
2.55.0


