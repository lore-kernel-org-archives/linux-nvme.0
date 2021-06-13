Return-Path: <SRS0=vQ/w=LH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA5DC48BDF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:04:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D139261245
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D139261245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K7J+sp3LjyLsTi6G2p1VUGtI4o5MIjOf4Bp35AnWb0k=; b=x6Xd6+iV8Me9cv
	unqdcfbe/XC9b3xcS0WF+e0hKst0XfmGBBTHZNYV5CPGC+OpxrzUviswXetTjPjgKaPUKppsN3wii
	8Lve20mprzCP01ThGhkIpRWXXqiH8ZfUpFyRz6Ys5LwoZZhM8v0kbZbENBgOAgUnQ2t/+W7cxbmSE
	FHVmZQ9SOJfaUosBdDv8Z7Hp4YHMoxrVx1YbbqcHbvzzjh0fGj4U9Gmb9ZiUetodo1lUsmWNLUdOl
	v7dNOZuZLJxD9phVXGxOy3wzmb7G6bCQjQCwRQCr3Se2zxrAVRiWtjZ97+5pZmwgxyQrlLt+PzcXh
	/Wde6atVOiRYz/JVd7vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsWKf-00B6n7-Qq; Sun, 13 Jun 2021 20:03:45 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsWK0-00B6hW-18
 for linux-nvme@lists.infradead.org; Sun, 13 Jun 2021 20:03:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623614585; x=1655150585;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QlbMZ0y9GUdD+ZVTbUTenl77gj9MrozL0O0jE4DZqKU=;
 b=hf63KiKZtHGtfdi+b3HarQbsfeacCOUKfhxM0tfb5SiQzd4rGiqvXpzy
 B+rqWDd0WbwJ+nB0dfFniFnuwtppxmRT7jbY23oGGGRLYr4NJtoh3logJ
 bRXJN83BBP8kF/iCZjt7x2cmdR4M+5pswPo08DQo755H+4U0ASo+gFu9M
 qxXjKyO52g0xPff9DxZ9+XsVRqvrmpVDKIlYfPBTozWI7lmdeb0cDgAXa
 5LbxAEyRtiKPSS64Mr/jd/ZvAfZOzvOBFs/ru421yjqbJ3juMSt362QW2
 XNufPMSGrmKwb90Q7H25NtlDlRA2CU+kECrasImqyXER5kFdPwys/ruwf g==;
IronPort-SDR: XFSK4Km6a6AO0T27c935rICp3vZYRJqc30tSQIqFYQ5YZdlePup/nZKi3ZN4bX2a7DRf3glejw
 tI/E3N9OyqX/IyTK2V86DfRA2Fj+eEUtLZJTClQHe9r61+iuUL2A2ycFlWNePUAdNMshSAnu4a
 zb+vOAT+AX/CMAwNPpodG4zQ5SM91buIhJbX9eUm5/Nt101xebBsbQOpNzW4KDcA8WReIPMkfu
 0foosDvVaX5wh0TNECCz7+oxkyqYyNTz3DF/ZWCmsHqAXm9X33DS4eveW0+w6LllZzE/nZck9/
 yFE=
X-IronPort-AV: E=Sophos;i="5.83,271,1616428800"; d="scan'208";a="275545738"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 04:03:05 +0800
IronPort-SDR: zMxnEfoxBas+SdeudnvX5pQrJ0vl4AGl9Mh1rVzbVvrMwzl/fPY4d++O7u1aUIZf94ObKKG4Uh
 15Q6iAq1qtrv40Fdgy7QRJ2z9zlWIsb8Z5ZDWy46OLBJyY9vRgsExC5NL2n6VCJL9I9do01MMW
 QCJRHlEL5m9vd7EqDzO00tdZJiSXdmjAXPfxHK8kbvPCVkD5gAMroFuMG3u1BvVnKOmpQOXyfl
 jpbuYNZzjd8v+nZ0vfsWc5buvJKu2n4qGlOwx6WvhtDJFYz3vhMUGufT7dEG3HsMcN+513rAGE
 41SWRIV96x5MUmBA1vvt1TFC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 12:42:01 -0700
IronPort-SDR: SQmiulPDHSLosXl2KZCtxs/uST7bwdjpg08M9qBmWDp7B+ekpPBYC6EzNEBpVh9DYXKkGpOJ9g
 wvhsRXXuaKeTctFx9QS2cyf3MA1NWF4KVuRfIGAlpO1WhQUuAVqAuajrx4/wtgJggL8QeTv73v
 6MmHEpRgjqBnD3AsBcE9AizppNMEJQweTTn1Jra7d1f8iFQBp9OWIWG9te38cOPjQCbm3p/R6o
 PmIbWXjNylDuQ+kdRSAKQPpGkmLn4ThGNoCeBykbtIu0Ge/JJxxizezOX/siI47TaSZgYRHSin
 JVk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 13 Jun 2021 13:03:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, dwagner@suse.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/3] nvmet: don't report subsys with 0 namespaces
Date: Sun, 13 Jun 2021 13:02:52 -0700
Message-Id: <20210613200252.9167-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_130304_154547_4325BDB7 
X-CRM114-Status: GOOD (  11.72  )
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

Skip reporting the subsys from the discovery log page which has no
namespaces.

This is needed because we don't allow creating a controller from such
subsystem from previous patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/discovery.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 7aa62bc6ae84..03a34ad3d59b 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -158,6 +158,17 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	return entries;
 }
 
+static bool nvmet_disc_get_log_report_subsys(struct nvmet_subsys *s)
+{
+	bool skip;
+
+	mutex_lock(&s->lock);
+	/* skip reporting the subsys with 0 MNAN */
+	skip = s->max_nsid ? true : false;
+	mutex_unlock(&s->lock);
+	return skip;
+}
+
 static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 {
 	const int entry_size = sizeof(struct nvmf_disc_rsp_page_entry);
@@ -210,6 +221,8 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
 			continue;
+		if (!nvmet_disc_get_log_report_subsys(p->subsys))
+			continue;
 
 		nvmet_set_disc_traddr(req, req->port, traddr);
 		nvmet_format_discovery_entry(hdr, req->port,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
