Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA15ECAAD1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v69ia9+Qq+66O0yla8u7te465MhQTuDEeMX5gmxAvCQ=; b=nIeLZSSsp+ACsPDT6LzFx9Rm5/
	4F4TLWCa7tuL5o+PmL7H/q47ou+nOq6zazYjTsME7l96sH0PJU7M4asxzU6A0eBa6nLBzFVv2ooUq
	h/Z2e0P0dG5HaEQAJ7cA0aSYFUonhcdkSPPFHlODtRPw6fURIzSEa9AC+3Bi5oBw2ZZ0SfvzIZL8O
	YzhYwz01YkfPtZrUFCzeX3szY6umgaVQdoND8VPrlP4ynmjEqKXYBAWAI2zzJ02rxdb4NRlWlwVbe
	MG1eKsD4UqAL/Y+7BHOFOF7tC0cUcjxJVLVQfFZoAPgLN9v6VXzIGXQwqzkWPpHZwAIgIaiv+gR+4
	RDr2QyzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTSnr-007gNt-8M; Wed, 31 Aug 2022 18:51:07 +0000
Received: from mail-bn8nam11olkn2010.outbound.protection.outlook.com ([40.92.20.10] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTSnp-007gLl-04
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 18:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIXZp4v1nD8VjTvoJSLBU+6qdl1O/d/f7geavbTyGmW3RjKqEHIgJVuFN6R6fmJo8Sadkri88SfVTDR5L+hyyBm2J3nq6CbayQpLpTlx3qbaqPyboYG0lmPyz9V6p138GrJXXE3RAec5dBm2ssLRsm5Q6hFMNDeyLBFuyCgKqu7kZ9St5oaZ4QUkzIgDOpoIcRFnNxHPulUAjrKkRrhnif1iMHfFjBkHO8WfJsG/EF3LgV//ByqaxcmEOi0ovatRF+YUTF2RxBENCeNWXcgqd1evMUQJ81mwWPQ8BVP5hJtqgSljEMk+gQIfNC0o/uh40Y+frAGDrzjd6sT3bjd3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v69ia9+Qq+66O0yla8u7te465MhQTuDEeMX5gmxAvCQ=;
 b=haNI3hOzdZuwTV+IS1AtfYfxuk6laUKyWltD7X9SrE1aIo7t12cg/PdbYHLQHJCzHbidi+XuGY23yETKUtTBmoo1DGkbll061Ojy9TFOalN3Q95jezYmEHDdtna4O93cOpg2pbnwrc7A5WJLY5ztJJLXPBSxb02g8+VBRuujlflqzXpnceVWX6SAWKxPzyE0ArNSsL6szkYLSFl0EYpiSH6sMtIcHU7E7kJN8cLfTGb3kDdH03AN/Ls8f2kD6L9z9VrL9jAZZIeya+q/Y+1y1REU28I/9GSg9tbFCmudrj7FOR9UNJ1tqjETqskVSDHSAn65BDKoSnRdM66eWhuh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v69ia9+Qq+66O0yla8u7te465MhQTuDEeMX5gmxAvCQ=;
 b=cQXYzqGaMQvX7vABicnMi1nxRnwJS1YL4JjsfTaAB193ZCKpULVmPRe+cZL3RHXMgN+IypscR/S8ys3QybVIP7HW0jw3zpjKPYUWirlJGuGQ37wiTYTtV21mKhb8fBVHVeN2DAcOEz6ATYnFAMRzL71z8AylP1yj/b2TK5EQHC1rPwebM2qtlIbpxpjCZc+vXFRrjGTG7dyth7TpcssZGwQ/g/19YVlWhmdaxMp6nggdj//TENphIanD+PIsbKiL9gS8vCfV6k5kTzbQPoyxEu0TS3SCxh4+ajGGfqvCOHjfke6zITsbGzSd6Zzz3dx5MErXAATbR58osK0VK+yIzg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BYAPR13MB2231.namprd13.prod.outlook.com (2603:10b6:a02:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 18:50:57 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::99a0:3364:b3a8:f5fd]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::99a0:3364:b3a8:f5fd%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 18:50:57 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hare@suse.de,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH] nvme-tcp: Print actual source IP address in address attribute
Date: Wed, 31 Aug 2022 14:50:36 -0400
Message-ID:  <BL0PR13MB4291FE38A1741F311081106B9C789@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [avhzLENTm9lKBGwTdk+QBw+bDP/ChAAY]
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID:  <20220831185036.31860-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63e9a7a2-880b-42da-b712-08da8b81bccb
X-MS-TrafficTypeDiagnostic: BYAPR13MB2231:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	yk4SJmUDrqTVX0NSd1sw/k4Fcp0COxPDt8+8lPYb7xoYy0WmyhRucZnQ9lMX6fKGSphVh3v2s0JkWcZijsMnGVoivwME0D8pVIQIYeyzBYY+HE9tSj+SZyGuVbtYMYRHzQntCIq23pMRhwVX3HOzAftiHdC3iMc/4m3FB+tFwUmgeFDv17SJ2lb22QSiUX4RJ5PUF7L3GDT/wk/1LzpxCnv581dhQirXFJvWyLe/fBlRizk/6FJZU6eW+JXCX31as84EM/HF9eO2wVRCINCIQdKPa/WyVrnf//3wJlhamsBWs28qM0Gx7oInqG/pOWmMpD4TK4HlvhEfJTDJN++D5u4p8tY9JSycCW7jIfNK3Dawszv9Rq0pmNf5GOL+r2eB5Sa1gg5757IUtqX00tO/G5+ExImkKwvCTUDt4TiTTuWONmarTilS59/IFPX42iU3vusMGz3/N4HQiTi7DJjAwDfP1xe/AXnCUXNJAcHchfceAEKVNDlP98UDpvs3WIuO6OZCrVTcR53VZOwbGC4jzUsrVf7+cdShJXC658x9hDWu2dwqhnYGorjk7rEkVypzWcuSJIyHbJR1mtARvZPaAmQzbPyXt0bUzmaXZSO0I14kyrZsTnCuV2RLVfYUh9EZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?Xh3/7HNs6CwzQxw5F5G4/c0wgoYqdj5VvC3B+G21OqANI1a/Vb5cimLi80h1?=
 =?us-ascii?Q?Vlcxs6xeBndZoJ8CFmDgbXuqVkmnc/No3e+FuCJv6LUhREOijIjHosMtX7YC?=
 =?us-ascii?Q?vRhNfonjGyOFvt+cXa1hXrTy/6xYhBPzxYhW7jlE/f9TiwTsnlBICv61UAaw?=
 =?us-ascii?Q?6mp+NLe4LZRVKHvAVeKUmzUli3ausZX/MMe4mEZNTJ1dQC19YicRq2nTaeOS?=
 =?us-ascii?Q?E5pepAdmF184+sOL15XchIF4+IfRBNTnMcEhS/GPhHv0KEAhNwz5A39O4CI8?=
 =?us-ascii?Q?AVEVvmdG398h3LgV8eoSj+JZOpOS+6OS+dY8Iz5F7iptN/m3xX6BLEy2APfc?=
 =?us-ascii?Q?HWlTWR0yYv7Gkb6KzSyPcNVabIocU1zLoZ8UoOmb66MWSKXNWgOeb3ti2w3G?=
 =?us-ascii?Q?5rhdLqucUiUETxzzZnH+H9Vr56FZujUdZiyMSt33HzF/Lkcr7ltAxh46oGXr?=
 =?us-ascii?Q?8B6TW6muQUsa/Vb6isjByMLrOYiHcqXicBub5IySkY7dzngyjuyaz2JnYBYQ?=
 =?us-ascii?Q?DEqst8M25ogvf8KfeRlYiTt0xfFvSbibDs5c/XSjgjylMyqT7wOLwh/sgjlO?=
 =?us-ascii?Q?Zvfr9Y8PZREXnHbUPnOLFEaMmDv25C+bPk36/YVCotRKPMBlsGoEMhVfnAkw?=
 =?us-ascii?Q?dQsUR2YqIpIzfnJxvRgjqxUOXcg/P6Xj4Paw0Kqxp5uy8KrAVVu1dd/EZ9Bq?=
 =?us-ascii?Q?nS86PDSkGB4zZpH9v2cO1r2w5r/nWtbWrE5iRWeu2l4y0eGQbiugGPq4IvkW?=
 =?us-ascii?Q?NKHC9JZwpjSnYk44HefPN+5PvdpCsM2MPJDiz8cis1iWIZkl8ldLuPQBeYd4?=
 =?us-ascii?Q?89msVFqtqqeWa2m75+jhs6BWeIO04PeEHzjLTdWJYs1KIMUPH5t7lD1clx3V?=
 =?us-ascii?Q?xTbVYmU7SlhPE0BM1yPCsJhyUopA4XdFAoU9aUUqlzuvW/l28v5IeRIQIS0f?=
 =?us-ascii?Q?abf9jBxyxDd1HGL4vPRu60URPkDM4KMqLbcsyLXLZHuVDCiQj6anie5eZkaH?=
 =?us-ascii?Q?OjVh4eBx1jYuqd6H9Z1tmiAVFv98ThG4Qk9gDSxMo35EnR0xBX9RLlVjXmBD?=
 =?us-ascii?Q?RmIhcsfDUvi3hbLVOwkVFQeciOMs8yIX6c+goOZk4RELQsTwASs9bsMtIVMS?=
 =?us-ascii?Q?EZ8YzveExXHh0SGfqSUst+ZKGsKNy2xiOXGqB1X2pV44S1Qks89uc+vFqi2D?=
 =?us-ascii?Q?k66bi1h/xhNjauOjeBK2H7mb/vCXOhY9rNzzFcjf8GpADhTvKhhXI/bmu3wo?=
 =?us-ascii?Q?pqxiPeAe04VEXfYnYoxpFLSU9o7eCuOOL2tPE+8leQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2231
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_115105_161540_8D15B144 
X-CRM114-Status: GOOD (  18.40  )
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

From: Martin Belanger <martin.belanger@dell.com>

TCP transport relies on the routing table to determine which
source address and interface to use when making a connection.
Currently, there is no way to tell from userspace where a
connection was made. This patch allows exposing the actual source
address using the host_traddr field of the address attribute.

Why is this important? This will make it possible to diagnose and
identify connectivity issues. With this, we'll be able to tell
which interface and source address is associated with each
connection.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 044da18c06f5..adbb76483a74 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -165,6 +165,7 @@ struct nvme_tcp_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct sockaddr_storage addr;
 	struct sockaddr_storage src_addr;
+	struct sockaddr_storage sock_addr;
 	struct nvme_ctrl	ctrl;
 
 	struct work_struct	err_work;
@@ -1597,6 +1598,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		goto err_rcv_pdu;
 	}
 
+	/* Retrieve the actual source address from the socket */
+	ret = kernel_getsockname(queue->sock,
+		(struct sockaddr *)&ctrl->sock_addr);
+	if (ret < 0)
+		memset(&ctrl->sock_addr, 0, sizeof(ctrl->sock_addr));
+
 	ret = nvme_tcp_init_connection(queue);
 	if (ret)
 		goto err_init_connect;
@@ -2532,6 +2539,31 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return queue->nr_cqe;
 }
 
+static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
+{
+	int len = 0;
+	struct sockaddr_storage *sa = &to_tcp_ctrl(ctrl)->sock_addr;
+
+	if (ctrl->opts->mask & NVMF_OPT_TRADDR)
+		len += scnprintf(buf, size, "traddr=%s", ctrl->opts->traddr);
+	if (ctrl->opts->mask & NVMF_OPT_TRSVCID)
+		len += scnprintf(buf + len, size - len, "%strsvcid=%s",
+				(len) ? "," : "", ctrl->opts->trsvcid);
+	if ((sa->ss_family == AF_INET) || (sa->ss_family == AF_INET6)) {
+		len += scnprintf(buf + len, size - len, "%shost_traddr=%pISc",
+				(len) ? "," : "", sa);
+	} else if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
+		len += scnprintf(buf + len, size - len, "%shost_traddr=%s",
+				(len) ? "," : "", ctrl->opts->host_traddr);
+	}
+	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
+		len += scnprintf(buf + len, size - len, "%shost_iface=%s",
+				(len) ? "," : "", ctrl->opts->host_iface);
+	len += scnprintf(buf + len, size - len, "\n");
+
+	return len;
+}
+
 static const struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.commit_rqs	= nvme_tcp_commit_rqs,
@@ -2563,7 +2595,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.free_ctrl		= nvme_tcp_free_ctrl,
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
-	.get_address		= nvmf_get_address,
+	.get_address		= nvme_tcp_get_address,
 	.stop_ctrl		= nvme_tcp_stop_ctrl,
 };
 
-- 
2.37.2


