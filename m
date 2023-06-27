Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C19EB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yl4IHJHVzxqEdSj07h4aGRWDLvI2XKyiI/siK0cNyw0=; b=0YHQDCC/DO9IMQfZX0r8R9QCem
	QphBGc4UYouTTMYnEaJmvj15mVNlZq31DNc4ay/Ulc5vY1o+2b9y/ZIpl9BDTNORZJctya47F8yRJ
	u7duGUH4UHI+rDWCDbVTeYlGzEQgwBZIugQbMN0ECenex1VTPTpeP/3YsHEyMsdY7obFUdpEcXhXu
	u+85G5YfV2AprEBsdhi+pMKZHKWdS5GC7UiC0quTmlYlIP/a98fjIyyANBAe4+M4tnL3BAmMkYlCH
	MROPtNSktI9gsPIfVi0C19nrBbe5+QApmgPGN6mCnZlGpwhBpxMY8v3csU5OlJVCdmDuQQ/bMGyCM
	tRYN0eqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qE5XB-00ClPn-1I;
	Tue, 27 Jun 2023 10:02:53 +0000
Received: from mail-he1eur04on0720.outbound.protection.outlook.com ([2a01:111:f400:fe0d::720] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qE5X8-00ClPJ-0G
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 10:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDyEJTdFKP/DbXlZWJ0FcIbQ31B23rhTniQH85p+xJTbqQF/bLiTcSvI4ieevtaXEBN+c/tWiY/UnGFyh8x0WjA/fJg9ehJ6mfHLo2/qIxsApSf7Bc9L+l52MEKWwClYDKXZLtxeBEe5GCLHgzFIn2KJHaWMBqKJunGtQZbyqdaHWB4dibIgs1n666a8fCLejpmGubPvbttoTVxupd716s+mWxbC68bXlFggs9fBRCqixrQdgkTNYewXg9r049Z3052xVNLKauMpUUFyM6tu/bql93xlhBtCNwm4zYC+MnuVvN2N/5tNy49aGo1zgf3vqDcJA23gnVKRj3viXr6oBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl4IHJHVzxqEdSj07h4aGRWDLvI2XKyiI/siK0cNyw0=;
 b=k/rV8XlLCAaCKejBXBJyJrXQuGKXOya5iHFgxB6Bsl8Rf28bsYNDDdJUPHFZncNyEpAknmpKIPHCp3UdlCRu2mlwb/5hedHpOI+RR+fHMFkjSfvYsIVpLG9dWnzOCvagAwpdTKRxOPE2SC7naJ9r8NPJyBDLRCuIuBsfdMDlxl51Da18wnAMSdp1sAXOvGMEH+xsFapLL/egQb55fVIIu3LcqmoYW5JWv4SXL7dMyvm9nf/zw91B1Ryw3UlBNWz1HEXZRPpTDp9Cqvx9qRhms4xT+dEVvVDfBJ/eXNibBL2DeYqWMZ+fkfm7bzMbyNAQms3bT/PlO3LucseX/vudqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl4IHJHVzxqEdSj07h4aGRWDLvI2XKyiI/siK0cNyw0=;
 b=eK7tObyinYYo93g7LVyPuvn3qvR1bNPgM2I/Rjyco0FRqQ8y16Q8+ky+fL1adYOf1eCCuvtKe5/x1Ph0Ri0NC10kQzJhU3oEkaqDDXBMHA7s5UNVhoxvCEEkVVX/HOMXyL5x571o293LBZGyztjz01e0LvnwUs2oMaRcaRu5UD+3chbNwo6jO4pruop8dMTOu1Ed1YCe84jkmEHrDwkAm1f+AW8BBa9POmNT62y8dsLCX5MRQbXA8WaxZ70OrCDgllCEl/IHC7WaNWugEpGC73iMQ70ZJ2SDRypBXoexeKuSVY8ytav4APsS+rwoMw+T5eOn319hPQvwQder22ZtHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from HE1PR04MB3227.eurprd04.prod.outlook.com (2603:10a6:7:1a::16) by
 PAXPR04MB8287.eurprd04.prod.outlook.com (2603:10a6:102:1c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 10:02:36 +0000
Received: from HE1PR04MB3227.eurprd04.prod.outlook.com
 ([fe80::2e7f:1eff:dd5d:86c7]) by HE1PR04MB3227.eurprd04.prod.outlook.com
 ([fe80::2e7f:1eff:dd5d:86c7%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 10:02:36 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: linux-nvme@lists.infradead.org
Cc: kch@nvidia.com,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvmet: allow associating port to a cgroup via configfs
Date: Tue, 27 Jun 2023 13:02:15 +0300
Message-Id: <20230627100215.1206008-1-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0218.eurprd08.prod.outlook.com
 (2603:10a6:802:15::27) To HE1PR04MB3227.eurprd04.prod.outlook.com
 (2603:10a6:7:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB3227:EE_|PAXPR04MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a8199a-5de3-4848-9a7f-08db76f5a1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cqfp+HOGDf01xwysRQ0t2Izy+Mqg+rkqOF7FKwhBGCWWQqHjaaVvXfkpq4nNfOVAPtgWJFiUJD6/Shz05jWaHD1cvNRKwIhagEIVk9c4YVHx6DYMeWlJeFRbsvDDPErRnStTdGwIH/k9nydzJcgAMxht8s9to1pXiWnc3mZSQCDduW1aUWTfsIOQL3hWp+ajB3Oa8ecCbFqfG6I5ttkeRor+WAV93T+qyKnMpb0m4HZsOo298XS3l+rAUB89+eGdASX2iz/EN91ps0bpCW1FbYE5L9btG6FBqZRnTAeu7NKKl7VvuDRemFo90dceDjbd/jtGv+MRctkSjRZk46kqvnUucUkDoDZxpjUkojbxaI8TqcAmNtsbz4BwaIgvcolfI9IO5NLpXEfnQVYRonT5EQdnYoP0cT1RCw+i/GqchlQMqQTLUaOXgtHaKfEVVGhk6feVRpcvghv4ob+f0BMReHrH3pBdthTq2RvNMhNBnxkdWgOdhTaJijT6LLUuPzgrxFukiDhNrI0VYW6Ij63tmgrwkzDBIMs5+IM597hhLRpcYwGlkubS7bh88uhzXCgPbj763pBvRFUSjTNqQkJLdxR5TQYtzrTmCOmleGadBf1GMUhw4k+4eHMO2uYUjfm2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3227.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39840400004)(451199021)(66476007)(5660300002)(2906002)(186003)(26005)(1076003)(38100700002)(2616005)(38350700002)(6512007)(6506007)(55236004)(41300700001)(83380400001)(44832011)(66946007)(66556008)(8936002)(8676002)(36756003)(6666004)(6486002)(4326008)(478600001)(86362001)(52116002)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62ed+yFEUHLLEOCNLUP7PGFAeWwsL01qGZU+3BURQPW5Ncbp53d10u3De7Iv?=
 =?us-ascii?Q?Nxmo39AEZt8bgPHitkh4ca5lpYn1ydCN7hMQfmup/FFfhKhavUSetTeSRYb0?=
 =?us-ascii?Q?EAfgdkqnOOgM0hEz2V3K6MCKG86cKPZmVDyrNC5TdgF2ZHUQ8QoJt0Ne83Wc?=
 =?us-ascii?Q?Br9qxdDlEdTRrA16angiltt0/mGGr+VZxd+BNTVxNXFSGGrfVS7AmtR/XjSh?=
 =?us-ascii?Q?Q44WYLhyfiCULk/AB72kgDMNYvHXB+/JYE+VF+N9nxZ1RRENa36qGGaaHw2D?=
 =?us-ascii?Q?mnK9z329QWJypMzDtwaQH4AnVyHv9GkiYvUHHz6Ioue26VVf8iW3kyxd49k+?=
 =?us-ascii?Q?oGSlR5V3MH7FLPdKf1N7SAkGvic7JwUtTgxI/M0m15GRGix24H5vppo7LgsB?=
 =?us-ascii?Q?n9/j+a7KZoL+5iyN1j3U5h6Aqbq/u2fXg+wETxT3cxaawpcp10PBXeaN5rse?=
 =?us-ascii?Q?BfZmiNW6A1oV+vHKOAcjmN2mVR5cazycUiknBDPWi8cBi0rlxulPFDxI5KEA?=
 =?us-ascii?Q?sjG2tYjVciL48xGO/OIra7h9SgzB+qnSIhbk2hOS/yw1mUzYu68zSHEDEV4n?=
 =?us-ascii?Q?tbk09XSIVLx6dQRRDeSqU2bYP1/kB0g1+yXOXTUz1HefMt717cqCxMFJ2GzG?=
 =?us-ascii?Q?38C8kwX6tf/dHAL5XvgeimNIFk/bNvVXWqDn5lipY8pIj+MZpnT97OX/4VD2?=
 =?us-ascii?Q?B1EsavG8JWMpR/JoicTOVPD4sMHnCmL18oJIKDRZAYQT86LYdxJapeCxD+8H?=
 =?us-ascii?Q?+FXBgbdtuwTTzeoan7/pLK32RPBJqa0zYvVKfchQQ4i59up8veKHq7ehyx/0?=
 =?us-ascii?Q?AYJt1uC+y0lQA+tu+OqblbpokHdF35p6QeALTAidoDMXOhQd8S+A6XRJocta?=
 =?us-ascii?Q?KuPadFI96k5ZdG/9w8TlBlBwjv2tzXcFICHEeOt80keWS+cYMpOilm68nw+7?=
 =?us-ascii?Q?+NJ8cCg3LPN9eiDsgCFeVlmnq+fuAH3SWNnkCsklCkvWLrESbFH0pKKH7Y0C?=
 =?us-ascii?Q?oAh/PQle1oGV3FEmCGBm4b+8hp9C9qN1rggJFJ2EksaNByh5Tx/1kww0na3k?=
 =?us-ascii?Q?i62PH834lleaZuzdghU6jjRJunP2Fq5MDY0mfm18X7tgG2lMMYoROXPEuGJu?=
 =?us-ascii?Q?cQ03zgldkWcsvSeqx3uMXk3flv5PFBpJ/em1vUxBN02OHbBpo1FqqbF7DpnJ?=
 =?us-ascii?Q?bOj5P0bf4aSPpG1eGibUHQLypx45a7IQIEYYja8iqBr5yfa7ayIU/k0A44qV?=
 =?us-ascii?Q?fPA71ULXTnI3Jn00pK6QIgLhnAbbuUpEHRZZZURY6C1lDXijfu76q74w/Inh?=
 =?us-ascii?Q?STM5HhEHpX8YldunTFPtJzEJBToZ5c53iCvhihUf+fS60u4dShDw/hYAEv1O?=
 =?us-ascii?Q?qKHsjKS5b+38Qqk2APe2KL2727+3nH65nWeGV6Vn9SsK7BCyXUWnl/w/bk+h?=
 =?us-ascii?Q?sR4WHJkmGT2QF9ctbvcUPBgDsT0L4TR5kt2V+X1At50zdFkS7PuPno8wf4zg?=
 =?us-ascii?Q?TXW1v0NOjw4LhG1FyCkh1BwTN6R/yh5hsUC9lal5XkchdZe3jaDglP2nawQZ?=
 =?us-ascii?Q?a2rHOSThzQNxZv+TlnPv87GecJewYWQ0H6apsVMw?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a8199a-5de3-4848-9a7f-08db76f5a1e4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3227.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:02:36.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy/iJ9bnBnREMjxPtUpamhT7eZr/6vY2ER3QuKr6koiLd3QitYpT15iJyni9VUuNpCTfKhTJ7RkUHHlAeJTTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8287
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_030250_542225_A084EAE6 
X-CRM114-Status: GOOD (  18.44  )
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

Currently there is no way to throttle nvme targets with cgroup v2.

The IOs that the nvme target submits lack associating to a cgroup,
which makes them act as root cgroup. The root cgroup can't be throttled
with the cgroup v2 mechanism.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 drivers/nvme/target/configfs.c    | 77 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  3 ++
 drivers/nvme/target/io-cmd-bdev.c | 13 ++++++
 drivers/nvme/target/nvmet.h       |  3 ++
 include/linux/cgroup.h            |  5 ++
 kernel/cgroup/cgroup-internal.h   |  5 --
 6 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 907143870da5..2e8f93a07498 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -12,6 +12,7 @@
 #include <linux/ctype.h>
 #include <linux/pci.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/cgroup.h>
 #ifdef CONFIG_NVME_TARGET_AUTH
 #include <linux/nvme-auth.h>
 #endif
@@ -281,6 +282,81 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
 CONFIGFS_ATTR(nvmet_, param_pi_enable);
 #endif
 
+static ssize_t nvmet_param_associated_cgroup_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	ssize_t len = 0;
+	ssize_t retval;
+	char *suffix;
+
+	/* No cgroup has been set means the IOs are assoicated to the root cgroup */
+	if (!port->cgrp)
+		goto root_cgroup;
+
+	retval = cgroup_path_ns(port->cgrp, page, PAGE_SIZE,
+						 current->nsproxy->cgroup_ns);
+	if (retval >= PATH_MAX || retval >= PAGE_SIZE)
+		return -ENAMETOOLONG;
+
+	/* No cgroup found means the IOs are assoicated to the root cgroup */
+	if (retval < 0)
+		goto root_cgroup;
+
+	len += retval;
+
+	suffix = cgroup_is_dead(port->cgrp) ? " (deleted)\n" : "\n";
+	len += snprintf(page + len, PAGE_SIZE - len, suffix);
+
+	return len;
+
+root_cgroup:
+	return snprintf(page, PAGE_SIZE, "/\n");
+}
+
+static ssize_t nvmet_param_associated_cgroup_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	struct cgroup_subsys_state *blkcg;
+	ssize_t retval = -EINVAL;
+	struct cgroup *cgrp;
+	char *path;
+	int len;
+
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+
+	path = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!path)
+		return -ENOMEM;
+
+	cgrp = cgroup_get_from_path(path);
+	kfree(path);
+	if (IS_ERR(cgrp))
+		return -ENOENT;
+
+	blkcg = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
+	if (!blkcg)
+		goto out_put_cgroup;
+
+	/* Put old cgroup */
+	if (port->cgrp)
+		cgroup_put(port->cgrp);
+
+	port->cgrp = cgrp;
+	port->blkcg = blkcg;
+
+	return count;
+
+out_put_cgroup:
+	cgroup_put(cgrp);
+	return retval;
+}
+
+CONFIGFS_ATTR(nvmet_, param_associated_cgroup);
+
 static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 		char *page)
 {
@@ -1742,6 +1818,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
 	&nvmet_attr_param_inline_data_size,
+	&nvmet_attr_param_associated_cgroup,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165048e7..b63996b61c6d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -376,6 +376,9 @@ void nvmet_disable_port(struct nvmet_port *port)
 	port->enabled = false;
 	port->tr_ops = NULL;
 
+	if (port->cgrp)
+		cgroup_put(port->cgrp);
+
 	ops = nvmet_transports[port->disc_addr.trtype];
 	ops->remove_port(port);
 	module_put(ops->owner);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c2d6cea0236b..eb63a071131d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -8,6 +8,8 @@
 #include <linux/blk-integrity.h>
 #include <linux/memremap.h>
 #include <linux/module.h>
+#include <linux/cgroup.h>
+#include <linux/blk-cgroup.h>
 #include "nvmet.h"
 
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
@@ -285,6 +287,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
+	if (req->port->blkcg)
+		bio_associate_blkg_from_css(bio, req->port->blkcg);
 
 	blk_start_plug(&plug);
 	if (req->metadata_len)
@@ -308,6 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
+			bio_clone_blkg_association(bio, prev);
 
 			bio_chain(bio, prev);
 			submit_bio(prev);
@@ -345,6 +350,8 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
+	if (req->port->blkcg)
+		bio_associate_blkg_from_css(bio, req->port->blkcg);
 
 	submit_bio(bio);
 }
@@ -397,6 +404,9 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 	if (bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
+		if (req->port->blkcg)
+			bio_associate_blkg_from_css(bio, req->port->blkcg);
+
 		if (status)
 			bio_io_error(bio);
 		else
@@ -444,6 +454,9 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	if (bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
+		if (req->port->blkcg)
+			bio_associate_blkg_from_css(bio, req->port->blkcg);
+
 		submit_bio(bio);
 	} else {
 		nvmet_req_complete(req, errno_to_nvme_status(req, ret));
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dc60a22646f7..3e5c9737d07e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -20,6 +20,7 @@
 #include <linux/blkdev.h>
 #include <linux/radix-tree.h>
 #include <linux/t10-pi.h>
+#include <linux/cgroup.h>
 
 #define NVMET_DEFAULT_VS		NVME_VS(1, 3, 0)
 
@@ -163,6 +164,8 @@ struct nvmet_port {
 	int				inline_data_size;
 	const struct nvmet_fabrics_ops	*tr_ops;
 	bool				pi_enable;
+	struct cgroup				*cgrp;
+	struct cgroup_subsys_state	*blkcg;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 885f5395fcd0..47e2a7cdc31e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -562,6 +562,11 @@ static inline bool cgroup_is_populated(struct cgroup *cgrp)
 		cgrp->nr_populated_threaded_children;
 }
 
+static inline bool cgroup_is_dead(const struct cgroup *cgrp)
+{
+	return !(cgrp->self.flags & CSS_ONLINE);
+}
+
 /* returns ino associated with a cgroup */
 static inline ino_t cgroup_ino(struct cgroup *cgrp)
 {
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 367b0a42ada9..8c5c83e9edd7 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -181,11 +181,6 @@ extern struct list_head cgroup_roots;
 	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
 	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
 
-static inline bool cgroup_is_dead(const struct cgroup *cgrp)
-{
-	return !(cgrp->self.flags & CSS_ONLINE);
-}
-
 static inline bool notify_on_release(const struct cgroup *cgrp)
 {
 	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
-- 
2.39.1


