Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171D1C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 05:00:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986916529E
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 05:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986916529E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WpH1oK35FPPltBUxfSY/+mczmo1wVW5bQJUc7/Rr9Fw=; b=iPmxewXAxG2V0A4sRe90F0M2S
	RE7pOAQIVmaNFo6LzIB8b6GPACu7/+gR2jhmK/HOvK2dQnVE/tmbDgD4ZHqUCT52H78yO2d8gzLlB
	WrW9kv85OaDA2278oXCJo1vKPAw+++AHH9NjxkRjO2/8DxRQwzLG9wjR5vGNE4nLFF2cfeyUD0lgg
	00thuHrpfkjNUrkCJvC1gebf+Jze/OW/3BdNSoLNTa3XBT1FdJ2vWKsC87w+/OuDYOmvSyg9XksCT
	lhFs8K54n8aTAc5xe/mmqkXFzrHq3Bwxp2xHDCdE4DsV/581tm9i/IiiK9dQv6bmnqAmDa2SbBmi1
	DOCf1IT1A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJUTU-003lQQ-U9; Tue, 09 Mar 2021 05:00:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJUSz-003lJW-Ur
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 04:59:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615265975; x=1646801975;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cBfFj0zBuz7k0kH9wbu4YLNh6u7J/B/Tx39bGHWCNmI=;
 b=ic4RziqFIqRhdaw97x5/bSdFmnEqNinVVbxZUFnHiRGZT9LpLHzOvt/F
 GS+/8L0u0hNpu76rAoP9HGuPtcEqqndNjro2WTVNpr+SCvbPmvBsH5P7f
 DlVTQkRJLs0HelVrsYrJGXxZoMS3O17eeNN22No/nR9+YUSeatSVhOqX2
 kwMYcECAQkqS2jfNP9gxbPXerZz5x9w6sCNRpur+vVluvO0SII762s/5h
 OtOl/uEiVTPJI63BS7VhpXg/33arkVEiwOKH3yf9FgIw+x7vSg84nughI
 F3VoE+4MhqwNmyNoDAfIsPJTJw1nkUfvqaKxVyv1iUZmjOphPGW4+aHf1 g==;
IronPort-SDR: 05PJzZrXh5pp628N9rJVgVdpYvUsueGQn7I4jA6FMxRzhkb0YUT9Nar8DT1F9sI6nDuqIp575Q
 Md51UNtvjvEEbs+wfTm/FO98HK0t+Ao8dMYvYWE+Nb9ei9S3F1lgBsgWCGfgccT8ewVxJRfC+T
 vMPD2Is53t1V47i6+fcJV73G3QS8dn9UtJkT5gEwrgL+deOGbn/Mrpuqj65Ou62ucpmSYQuC4I
 M6X9bRk1c5yc4pNHm4V2pMOaRvH867TNI6pwpAreszD5mhOpsjY1a6XAkCQ6IW6NS+zELtmEt3
 wU4=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; d="scan'208";a="162841654"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 12:59:32 +0800
IronPort-SDR: RCmA4VGzOHO5PYyas7GgcWfX0GWiQtm2iwWFhhAJNC6FsLEf30fQM2DnNhzy7h/JNU0nFU+6Kd
 TmtuaqytSVgivDGoLczUUhkMZQsSjWT7yGLYkHASq6Fa8mBrJ0hXxtGhV8u3zDA+fn4Lorr4X3
 7ybrzd33PQ2pEYhpqL3sOklQfmejp9Cq7A8gscJLRxqMKXWBhAy6ygZ1QxaCkl4+enZ3bDdqgh
 1jctcbXS1g9AaxMWcgyxw5Z9lE+rHDwqTT/JxWjhA55ZdUda/OG2HZVptseFNYJSrGkXF8+N2a
 gdFMEKHhTFEF2tCzIEszd9SH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 20:42:13 -0800
IronPort-SDR: 2xRcLDnrhHw2W/nKu8RrVTvcOIiFhaxMBBFGK2DQTzjTm8W5Iub3LUfHgxmI1g9KO9zUJ/L9Q0
 dC7HCmEtuoCx6FGxQ3/YM/ZJsAYR4uN7tWM0O4SPXHuNBw6HkEhjpA9IwZCgvtWkJkEBodDpDz
 2dle6nz/gMif3R8XH23ZxHWknXF1q8qJDdcvhs49wjM+8NtSPCEmwuN9eChaQgbM8mp7M/dQWw
 oW9RyCZYAjdC3w7ZwCJrAexVkGBYURuADE2nPInxb0uLYPp+t41kxEwh52AUNdouLmsoXZEYUZ
 WWo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Mar 2021 20:59:31 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V10 7/8] nvme-core: add a helper to print css related error
Date: Mon,  8 Mar 2021 20:58:22 -0800
Message-Id: <20210309045823.18545-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_045934_640079_E0368579 
X-CRM114-Status: GOOD (  15.01  )
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

Right now there are two functions which are printing same error if
multi command sets is not supported by the namespace in the question.

Instead of repeating the code for error handling (dev_warn() + err code,
add a helper.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3a372db00b9f..93421bb531b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -93,6 +93,12 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+static int nvme_ns_css_print_err(struct nvme_ctrl *ctrl, unsigned int nsid)
+{
+	dev_warn(ctrl->device, "Command set not reported for nsid:%u\n", nsid);
+	return -EINVAL;
+}
+
 /*
  * Prepare a queue for teardown.
  *
@@ -1408,11 +1414,8 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		len += sizeof(*cur);
 	}
 
-	if (nvme_multi_css(ctrl) && !csi_seen) {
-		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
-			 nsid);
-		status = -EINVAL;
-	}
+	if (nvme_multi_css(ctrl) && !csi_seen)
+		status = nvme_ns_css_print_err(ctrl, nsid);
 
 free_data:
 	kfree(data);
@@ -2218,10 +2221,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
 		if (!nvme_multi_css(ns->ctrl)) {
-			dev_warn(ns->ctrl->device,
-				"Command set not reported for nsid:%d\n",
-			ns->head->ns_id);
-			ret = -EINVAL;
+			ret = nvme_ns_css_print_err(ns->ctrl, ns->head->ns_id);
 			goto out_unfreeze;
 		}
 		ret = nvme_update_zone_info(ns, lbaf);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
