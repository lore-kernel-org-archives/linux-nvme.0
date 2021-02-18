Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A0C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 03:17:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF97614A7
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 03:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF97614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GE6jB2JkXXf367q0D2rqkf7XSyH45ATZNlveapnusMM=; b=cwNS1lrQJ1gzdzzAXOU3qhSvyw
	VRw5uk9/hQ+HxvqcpR5JtUqW94ScVhv1f4CJie+XsEFXBkayOOWhlu71fbkf+8JBEgBDA8DDEJAZU
	9t6yakpuYgnpzCTJnLnUQuBAxIUtolrevAZ6CYgdzXHYkTf8HzdlZLqhxVIuPq95wabZLRwT0ouiT
	WgWqoYp/bcYjfBjPWVv4OfEshqVG5UepBzA/sYheRuCdyv3zXi3khpUA5u8AfnOroUOzxmcawJVIb
	ydvEnFVizttnzbqFayF0ZbADDWu84c+4ClzbYLlWSJFHa75lSA1ZBhy4xTAXs9YDhmqV9PJyfAK9v
	hOWy5N6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCZoE-0004jp-CD; Thu, 18 Feb 2021 03:16:54 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCZo9-0004jA-I5
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 03:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613618209; x=1645154209;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4p0ECSFEz3lDAI9AIumcR6A/8mf+SM3HYEVQIlAzC8s=;
 b=Vz8h+tK/OlhgTNdWaa6fqQ96tYZnmq92wh/wrKl2FbjgJmAEfalMzuej
 wFDOML2X0RGXG/GcG/gUyppuUNF51ox1IbaSORQGoXruJ2gFNQEU9Vxky
 4/p6PoIgpwbsXqGUxEmAyj3P/U2fJe/jCWZZHBlo0Cneeq7u7Suizj0BU
 YuSuxYnaPaiE3xq6hfDtoEYWHF+6Rsf7R+LI2TRBLvvC1+r0gPr+ds9QB
 Hc+AZiaKeinNwgZTZIq3+5qPA9dMaXAOGs//ufkJJ/pWOIS6WSFA3rTVP
 5BZzSXZvaXhylPQwzysF72gfNZGfTxNw4eUlSJm8aB1hmij9/4AZ56BqT Q==;
IronPort-SDR: M4DwvtLOJVBCDWy/J2Xl5GrIAFYlFCmkwngYwzh3ECvXe7RHrwo8Vlpdx3Mehzb9pJ95F116Mm
 lOAx3VUUplnPJDEeT1d0ozsWGF2rcStRoWG+SrqYw7684mMXabt+5kmAWXvame79QJqnrqWTqM
 cBcgdDSt9nt/PQJIS98tPqvPcvC981whCetqG6ZP+CbXLc+sM7BdV9XDceReaZCbyNY/NLJsXX
 sjmXwJseWc6/cTboZo1zxju0XJgbrSeDif8/IDuCT+ra/zHTKWM9qB8EpHjBWrkRawalHB7VDK
 eRk=
X-IronPort-AV: E=Sophos;i="5.81,186,1610380800"; d="scan'208";a="161397005"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 11:16:46 +0800
IronPort-SDR: YoZ9w2umufyHni+Sh73c5fBc6AloLrVzKXH/7IbyzsdmI7cFPN4ProcB0/ppNBhcKZO3oBOaL4
 At/VxTCYrVkujrvtYTHkrT/V4plewdeI5UAopvh+327NuFxHjzxaaTKcm7+oHl5uqrKfLm0fc8
 LEY1nX5HClSfxKAky8uOVDBoz/WozABHtWtVPCbRTR2oq6rb2XxAanpnbnOOouSirbGsRdLPVf
 6Z/7Wd+SxlzOKE3gTcjyrU+sw49GncPTNKeCCXMiQjf4HYzIvbeSs+VLfsP5HskfzMNVzMxU5H
 bPLXleKfhJ09XSOWQv4SIjBh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2021 18:58:29 -0800
IronPort-SDR: cqw+BML+gQNciA9qLJIBhsEU1sp11xshYe0cR4PZ2iK1Psms3MLDWS9x5E1286hLZb9MqLtcbh
 zRF3fX816uUVQViSsSJchmTRxG4PHeS0qY5yS43qvlSNUltoqo9HG9VhIpJ3Z/iuKSvD5kX5Tq
 Js9xP0yjpXI159P47/HSkSTSxvrQOkDPHMWMNcBnzlP99zG/fIvHng7ZOntsHXV2yJ1IQOw/my
 az4Mlme7ea/caDVZApx1C3eUFa4fFye7Mh37vjADL4JZubS8Vgm688ZCFwRJOyeoNOz9esfpcN
 TMA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Feb 2021 19:16:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: don't change model_number on live subsys
Date: Wed, 17 Feb 2021 19:16:44 -0800
Message-Id: <20210218031644.12476-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_221649_820886_B7F8DAE8 
X-CRM114-Status: GOOD (  16.62  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When subsys is connected to the controller(s) right now user can change
the model_number. Add a check to make sure subsys is not connected
before we allow the change in model number from configfs.

Reported-by: Max Gurtovoy <mgurtovoy@nvidia.com> 
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---

Without this patch :-

# echo  "transport=loop,nqn=x" > /dev/nvme-fabrics
# nvme list | tr -s ' ' ' '
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme1n1 d86964f000f47541 Linux 1 1.07 GB / 1.07 GB 512 B + 0 B 5.11.0-r
#
# echo "NEW MODEL" >  /sys/kernel/config/nvmet/subsystems/x/attr_model
# nvme list | tr -s ' ' ' '
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme1n1 d86964f000f47541 NEW MODEL 1 1.07 GB / 1.07 GB 512 B + 0 B 5.11.0-r
                              ^^^^^^^^^
                               Problem above.
# nvme disconnect -n x
NQN:x disconnected 1 controller(s)

With this patch :-

# echo "transport=loop,nqn=x" > /dev/nvme-fabrics
# nvme list | tr -s ' ' ' ' 
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme1n1 decfcb968deb004d Linux 1 1.07 GB / 1.07 GB 512 B + 0 B 5.11.0-r
# 
# echo "NEW MODEL" >  /sys/kernel/config/nvmet/subsystems/x/attr_model
bash: echo: write error: Invalid argument
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Don't allow new value for the model to be set when connected.

# nvme disconnect -n x
NQN:x disconnected 1 controller(s)
# echo "NEW MODEL" >  /sys/kernel/config/nvmet/subsystems/x/attr_model 
# echo  "transport=loop,nqn=x" > /dev/nvme-fabrics
# nvme list | tr -s ' ' ' ' 
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme1n1 decfcb968deb004d NEW MODEL 1 1.07 GB / 1.07 GB 512 B + 0 B 5.11.0-r
---

 drivers/nvme/target/configfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 635a7cb45d0b..e0140a793d14 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1138,6 +1138,21 @@ static bool nvmet_is_ascii(const char c)
 	return c >= 0x20 && c <= 0x7e;
 }
 
+static bool nvmet_subsys_is_connected(struct nvmet_subsys *subsys)
+{
+	struct nvmet_ctrl *ctrl;
+	bool connected = false;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		connected = true;
+		break;
+	}
+	mutex_unlock(&subsys->lock);
+
+	return connected;
+}
+
 static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 					     const char *page, size_t count)
 {
@@ -1146,6 +1161,9 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 	char *new_model_number;
 	int pos = 0, len;
 
+	if (nvmet_subsys_is_connected(subsys))
+		return -EINVAL;
+
 	len = strcspn(page, "\n");
 	if (!len)
 		return -EINVAL;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
