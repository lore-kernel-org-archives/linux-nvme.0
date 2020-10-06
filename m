Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A91C4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284E02087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tLzwO6s5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k6pPmo3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284E02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z8eYcaHo6DOi3FK6ayWfDmE6OgEK+XKTH40BNZhID7U=; b=tLzwO6s5Z6/Pp19pQJw4g/OLA
	v1GW752iQJG2rW4SPyRVOYKP3E6eZj56R2FFtnBfp1DwAtKp4Up+zC4yZrgd+1Uqs7XiGmQiGCWEV
	Q3MjHYkHNxmWOsiWUZc7kL1kpmbzcS1Wi9v69s7U0muPD/KlSMI1R4nJKZHSwuQgn3m1+s/fy0Dkp
	LIn3NtT5iLHnNvL+HZTAK2so9Sc5WlMrUaxlncNL7qsQhJRzevuTXFkLpESgwIWIcLjTEESlyAo/e
	vkC/mG0Ff4438b+AI1F8CvC/hUW3uZg7a6r8Q+IRDQatqVm7I5RWrh0/sg/bM/Ii2dr8ASbEX9Png
	QkmcRvGMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwQw-0006Ny-BT; Tue, 06 Oct 2020 23:31:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwQt-0006Mt-Lk
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027207; x=1633563207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yAtSoLeUVYsyFy94Z6607DPF0i9V7xkAiBEtrGkF7rc=;
 b=k6pPmo3ZFNNc2WHeMpPQppI2AOd25j9BxhDvMIaStQjE8Um9K/nUN61g
 CbKDhVF5yN8fK75PV68rynxv7o65G6EVQgfn2XjWR6XOkmqV+7/x3qowK
 JWUQVLZiRIfBA2VYqHPC9FmVyBZOp16DqBnpnltVByE2s5Q6w0KQYKzg9
 RRwM2HFk6/ipQV5iHLD8KoIR6eAL2wZSTh4DPsKqRs0gc/TADqiuTvau1
 8LPypMifW5qxlwZeLQ0mAvMyKbPS7ss5jySKQ/UazoTTp9J6NbQGKpzju
 eNHzniJj93toj6ALmqeZ8bNsCo0kYDPVChrlGdlUQfbiK5OSkaP2uVnGA Q==;
IronPort-SDR: QAb+PadecQolPER5G+xKgYV13BMFAWjZy065P8kzPpX5tS7Ek33pW9vCsYd80A9tijXXePXg0v
 BMN040zUqSDlRJRF7vkBti8XXmfOJRY1nJkaoNe1WpgzKirUcz7n9PVai6jctrkGiCxpr6ROwX
 usZihL1jQME6PExN0ZqNds8DgR31h1no3DN6TN4uGlgBRWfL3IgPBhsi46rRnfXxz4pZ8nDlm9
 wIjIl+df8Hx9TEoXozuArRZdbd5j2c0SzL3NFJ3TTBwq+hd8tE1ivhfxXpVeBt/UxyW63tD2ix
 bBw=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="252647666"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:33:26 +0800
IronPort-SDR: rbbzxVPlRXuKO0UK6xMW1FLr52JqJ5Pwm1QMBGyJ5vMBzRvEA9F7oDwfUG2T0xD+GePUEtC3eS
 172ik82HLa+w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:17:37 -0700
IronPort-SDR: b3gmRw/BaZ7OfFwsSFPhOr/aDOOdyVy1EWTFy4kC2Dss0dk1gYnoaTUCoK/UKca0+bNjoPKudZ
 n3EtL6WsBNQQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:31:47 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 6/7] nvmet: add passthru io timeout value attr
Date: Tue,  6 Oct 2020 16:30:48 -0700
Message-Id: <20201006233049.55458-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
References: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193147_847213_9835D0C4 
X-CRM114-Status: GOOD (  18.65  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe controller in the passsthru mode is capable of handling wide set
of admin commands including Vender unique passhtru I/O comands
(VUICs).

The VUICs can take longer than default NVMe commands, that is for
passthru requests the timeout value may differ from the passthru
controller's default timeout values (nvme-core:io_timeout).

Add configfs attribute so that user can set the I/O timeout values.
In case if this configfs value is not set default to NVME_IO_TIMEOUT
value.

This attribute setting is only allowed when ctrl is disable to avoid
rcu calls in the fast path, in future when needed we can always make it
fast path friendly using RCU.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 32 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  6 +++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7625f8892fb5..5beae49ba6ad 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -767,10 +767,42 @@ static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
 
+static ssize_t nvmet_passthru_io_timeout_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->io_timeout);
+}
+
+static ssize_t nvmet_passthru_io_timeout_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	unsigned int io_timeout;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	if (subsys->passthru_ctrl) {
+		pr_err("disable passthru ctrl before setting io_timeout\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (kstrtouint(page, 0, &io_timeout)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	subsys->io_timeout = io_timeout;
+out:
+	mutex_unlock(&subsys->lock);
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
 	&nvmet_passthru_attr_admin_timeout,
+	&nvmet_passthru_attr_io_timeout,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a0c80e5179a2..2f9635273629 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -250,6 +250,7 @@ struct nvmet_subsys {
 	char			*passthru_ctrl_path;
 	struct config_group	passthru_group;
 	unsigned int		admin_timeout;
+	unsigned int		io_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 253ca2b6ed10..2039ad7cbbab 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -216,6 +216,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
 	unsigned int admin_timeout = req->sq->ctrl->subsys->admin_timeout;
+	unsigned int io_timeout = req->sq->ctrl->subsys->io_timeout;
 	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
@@ -243,7 +244,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
-	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : admin_timeout;
+	rq->timeout = q->queuedata ? io_timeout : admin_timeout;
 
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
@@ -545,6 +546,9 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	if (!subsys->admin_timeout)
 		subsys->admin_timeout = ADMIN_TIMEOUT;
 
+	if (!subsys->io_timeout)
+		subsys->io_timeout = NVME_IO_TIMEOUT;
+
 	nvme_get_ctrl(ctrl);
 	__module_get(subsys->passthru_ctrl->ops->module);
 	ret = 0;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
