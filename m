Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DECC982DA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AW01tuh8hRVQtK4qarvblwO+ofGvSgZdhu/67l8Xj60=; b=QANMXoCsJjpHvJb+L3Z20L+FuR
	We4MrqWxvXIgBNAb6ovFRC6/A4C5+gvGZrl80VnydS4a/9RwAB05bgfsrjsE7jyFlBk7H+jR+n39d
	c45C1P9go9qUO+0uZ4+ROxFQfUEnHrIDiazyRo88xT/CvBsyJrblgAm07op7ea7sL2EXNA77KRNQV
	ePMw+j+lrPYKBq83CxW6g2FLbzDsRnUY/33SHxjoBNx0QzgzVM3fneKV/wJXZqOIjLYUvz/2+ZrTr
	bQXkSV6QTEICbFH0m1GEToKSoWSTYOiuRB3NIi/f0hFa3VpXyKUZ0N7OUUhY3roV4asWXUn08s9fP
	NichKFEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJN-00000000EIz-1XLu;
	Sun, 20 Sep 2026 18:30:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJL-00000000EEV-24iu
	for linux-nvme@bombadil.infradead.org;
	Sun, 20 Sep 2026 18:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AW01tuh8hRVQtK4qarvblwO+ofGvSgZdhu/67l8Xj60=; b=jPQiiRdHQ3g4uTS7mII0PWwBtu
	Eq+xu4b9Mx7/lHCqSE41XXN0deeUXUI920JxqO1bZ1jgX3CPrx4d98v6yEXfmSqDgPhdTVypouHQV
	lB3JsnYFA5iOhzQHQiwzcs1TQpRRpZDJaix3PrhtU8EvTn20Ib1X/HCIH3N6R1Yg4q+yzuj61fWmU
	UTQeS60Yefpx2HH1O7kmpS/5mqvm9ok3JdOsg3MF0ptHqGkqfMzCTqXroggYil7+rtS5un4AGL9tO
	hi0ev6oTaTlE/dMaL7FHOLlLTDiZtetnnFy+87LSuT9YwghWaH7MRIy9t3QUZWvTUtNb8V7/c7dx8
	sS/gPnjQ==;
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8MJH-0000000BXiZ-1qZV
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:46 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747ed1368so28155595ad.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929041; x=1790533841; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AW01tuh8hRVQtK4qarvblwO+ofGvSgZdhu/67l8Xj60=;
        b=GqqHDqIJlboVkTuswA/K01apcfFF/1Y+Caai+knxXZc14tZSo8ZrnoYxOEuD+ZgLO7
         tI2XMO03GIgqYulvbPJ/5HbNLzssf8okB5qmRg4eUSauA/ynV+OMSjRAIdNKIzgII1wf
         yPkDA+h/YrW/NOPf8HjbUpxuLn86CJ5OAlLTDnus4yejcyVGmv4kPwr9XtG02hQ1YVm1
         czgPa0WbCUpO5CMyasChaZB2zxnDZqEUPp5POdb1AKk6w+ikhby0MXDtZdO6mwQHa1Nf
         adNnkFq+L61bKthPGrZdXZ5TsfP8HzUjhaHgDZ5FRyrhMlMPCBBs0/iuS7NcEsNfIEUV
         TGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929041; x=1790533841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AW01tuh8hRVQtK4qarvblwO+ofGvSgZdhu/67l8Xj60=;
        b=ohAmsngj6HV6Tez0ND1psBsqjouhpujLT8UOf4beyifPD8IOL0mUpzpqZS04wsjGSd
         pqXqT8NlzPt/JID08BOcrD3SlieiYKhHSOFTBzP4L/HF3LeKUAP1AlMw0JpBjYFY9jVi
         DIWuyOdOdUUaPvJFPt6uCGWB4ODC0C7FCS4QjpmnHs+cpTPZ8ntnkug2s87+X+HDpWEp
         FDuvPz6hilut4edRwuNxpVuj8aLZfL2+stSHz6PcW+clA2Lr6VHQQ4lTKZRLj1YtERzj
         iE791ui/TBcD3gqa992PyVZiGqaZ6C9GaBICyn4T3zHgATn5rMCjRetI8n1oOlo+vNKh
         lCoA==
X-Forwarded-Encrypted: i=1; AKwUvBwXk9p2LP16vkVO9tJuQgeTIV/gb4OlzSR7lE0PiqXaMBRpTPFIfoJjmL+1K+eNy1KqNrEd0rCYPf8d@lists.infradead.org
X-Gm-Message-State: AFuF++kL3flcxUChRgJe2haXrYIQxBxRWc+B6FbP5JP5U/ptAtnogsZJ
	9JVOnsJemK1XyBF4oM3Fdp2cLasogwIsEtD6bG9IXmpPYiYpZN1Brww0DBIdrtQI9DA=
X-Gm-Gg: AYBFou0+n30gpvTfnR05JCRAHRBaidZzH37MK5lVmOYxs5Fc9bpEChRXkB6UtePg4/t
	t7isu3HsxIpJzrwXI7NLBX8Nu6mvNWM50yV0r1womWzwnH+DQR14frSCmTl/rf7JnMwYMxXrf1t
	zMMf7VhAvk5bCYaAAMKt4MDjtq4L59f35vHtLHuehnLnyVDvx7QxuUmLFLK6gi4oCtiGVIp20Wr
	zJ4qr0St3aAaTaOUl1gurvMNw6pd0MoUlzwFB7+3bWdEHGGam5ugnBbn8rdv5nB0h9o6x5UAVsP
	QLAJcFv9mXI9gWr6eOfduzLsmwfZoGtcAzzNDacU5hvIfGhsNka/4jymc246lg9x6W9BatVsVB2
	epXa5Us7Ctm8Q4VXjXoXiiMoCLDZTsCzXbhS7IHZs0/iPe2ecIjUho4oVWtoDf4mKFZMAO6CEmg
	l7vJGXkeIQpaKYUFz/A/dGi/G7pdUDXrrLa7VxXTLDOJFn6h7axKUiNX1X
X-Received: by 2002:a17:90b:5281:b0:39e:4c7f:8b17 with SMTP id 98e67ed59e1d1-39e54cf8bc1mr14650246a91.28.1789929040984;
        Sun, 20 Sep 2026 11:30:40 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:40 -0700 (PDT)
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
Subject: [PATCH v6 16/18] nvmet: Add support for CQT to nvme target
Date: Sun, 20 Sep 2026 11:28:14 -0700
Message-ID: <20260920182936.2317916-17-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_193043_580221_860B2EB0 
X-CRM114-Status: GOOD (  19.43  )
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


