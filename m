Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E2C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 14:57:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEBC6128E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 14:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FEBC6128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=x/+8o/5hV2HnTwxpMtOakBf0dLEUFxC8Blhpm2R6oQ0=; b=TRkVBf7igzy61T
	b9xA7JcHevF45ByOjMjwhRnEgGiaUgepQuTotPW1t6zLJqo6yPNMjuzPHFK/x3lg+e05AQohxQbO3
	bhpLIRLUviwAcuLMX2bpDZp0CIEi02Ifid9V5Rql26D8OmHkC6+SRf75PPTctda27UAu+TtSoM9Uq
	2M+AcZFfHz0KSUIIUi4bRRsG9ZUBXrt1RtGnM7ra+OTcgUcwO+5ziwwid5WTK9q5ay9Qn84mDFcL/
	an4HG50dWEKrG+mxtrZ/kJmNh+Zn0bfGCcmWp6qvM3wykl0Y+/TNMFGmyXGoJvuowqdBJQynoqssf
	hjFA9BRxddCiJFFLhE6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVxUt-00Erhn-Az; Thu, 30 Sep 2021 14:57:19 +0000
Received: from mail-mw2nam08olkn2090.outbound.protection.outlook.com
 ([40.92.46.90] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVxUq-00Ergf-RD
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 14:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3842UvEkrqamVwKULIvbBRFI9+ih1JN3TI3WDCej+IP89W+J2C0nStkqmZPaj+DNc0GROySjcr6dwtWR/wCgkNR6wjncstu9nR/LtX6ksAHSagp0RJGWlhqc8xcPg4n4MsVa7uul9ZrFVl6sYjmk0f5Sa0lVgGCQDdKOsAcBxvbaSG8bvzdiuIMWUr8CJPqKOAxBhTZq2s7Bq0WMEHJuEcfOJ+z0fumTRlv2XnHm5CCkj6PK4vcykiPvJA23PYXnigN7jFtJrsMesciDktv8x+5uOjzmpoL3IkTeOaQtSDEFj1hMmtUzdCYlqmxnJPbwCNb7oQjogis7kW5xeOi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUkNWJPq3OA6RH4a/aSP70+QLGjMKfO4onaOxWh4Y1s=;
 b=OCdacNSXUVSaXG0+tt8G4rcKEeKa0qX9MXrUsjaTPTyBr9sek/bTIb1E+bKE08UFY4zQ71xQH69gGgcR52SgC2wQXxtyiC6tMBM7vnLkaZlbc9WV7OTszAbmRHkRFohE6y0RTlZczVeHi/3iBkdpXp3rESXqukI5cMxL68yq+ZOrI51D5I/oXEiCNB+3bGMHSKi+AEZ0Y4gYZCsU/s3Cy4qw1qbWrzzKHL+KmknAxqx87WOHLfRLH/IfCiI++dLtysPGfWl+AVSEm9ndrXjRW56a+KV/KvofCoRPAwX4MFt9+Rl8PeqoBpRXl0FPr5vpZvtnjsOclP0bVLooG/B5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUkNWJPq3OA6RH4a/aSP70+QLGjMKfO4onaOxWh4Y1s=;
 b=Ht1L1RIMTdkGCNmhdTrAtA86tohz/LV+UIAiaXJB3Pa+GiUyDoR6hWrALvkMNTzhUcc9kYhPxe+R0UIeyE/xKhqnFEy4QxUBjrfM+bGK/9FxFnVkXVCCN4Q5/ESkne8QglwK59X7UsZEmZQM1Ii9bcurpaC65C1Q1bBz6Tlh/S7N3XhD97qV4Iia8rNZzCWEQkXoSWixOObUDKO43noXmvt88ki2lzf0EGhj91rpqVYOUZaprw9k4z0frGrxxUU8pPbsdrpiv2SQf/MMwacPpYDEREKBhCuRBYdF6fWfgZXoPKFcbWQiRRRekRpYzxaP0BSdv+4itPnoHe9ur24mRQ==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB4366.namprd13.prod.outlook.com (2603:10b6:208:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.9; Thu, 30 Sep
 2021 14:57:12 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::b504:e6a9:7b77:e348]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::b504:e6a9:7b77:e348%7]) with mapi id 15.20.4587.009; Thu, 30 Sep 2021
 14:57:12 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH] nvme-fabrics: Use shutdown timeout on disconnect
Date: Thu, 30 Sep 2021 10:56:34 -0400
Message-ID: <BL0PR13MB42919DA26E7A75E9219F62DF9CAA9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [sULMYKa+8b1yr/ws1iG8ZfQvJALU2rcl]
X-ClientProxiedBy: BL1PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::35) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210930145634.30816-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (71.217.156.225) by
 BL1PR13CA0090.namprd13.prod.outlook.com (2603:10b6:208:2b8::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend
 Transport; Thu, 30 Sep 2021 14:57:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2084d27e-8fac-46cf-ae76-08d984229520
X-MS-TrafficTypeDiagnostic: MN2PR13MB4366:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7GshItyOkQkQUurzwHzjXnQKV9DM/lEDfO8D2cB2UV3HYoBvCtgvpCAj+G7mKKXGCx8qj9r0KIUqBVQVggBVcMK7S7uyFE5xWcqAsDMp7Lqdscd1Ux+mmlIS21h9vh4UTBbp23iS5IytUzn6REhjHhfkGn7TrvVi+yTVa8jyEmIwPABjHEWFs99w+jUIqzfONMqNCpBNqx0w/T/KEnEY+sw7kJkDqcHZe3Jv9hb3vsiJfMW0v6OqzFg3kwaYIkHppNOpb1zQCqaXeEUZ149AWuV9mzAKJXZAuQuT5pNtNsmh2lfPc7AgQQEvDDAWaled9xeQhXlZR+OI+WQO793hhgmxQpTqLobC7CItXrpz8UG+6dWUaG+F0rUYA3s2cak8amJ/9dHCgvpCVrnLW3bMuyVtRvIU8JzjF4pYvdzd3arwvmiHmcionOcVjeg4CUC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5RAAxGWzp9qQUnAlQ6q08vEXJPM5AG+ePuBu2jKa9s7kgqLwEyL/UeIgCd4xv8UpQvx1mSDauHM6calvwKWVpM9afTONwhnwT+LweVxKI9+kipfPQlODyTu8yr1sLDWp0DrWHEPaJbphOCj1Y15thQ==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2084d27e-8fac-46cf-ae76-08d984229520
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 14:57:12.7360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4366
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_075717_037773_1787B843 
X-CRM114-Status: GOOD (  18.25  )
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

From: Martin Belanger <martin.belanger@dell.com>

Before disconnecting from a controller the driver may send commands
such as setting the NVME_CC_SHN_NORMAL bit.

However, if the controller cannot be reached (e.g. network down),
these commands will block for 1 minute, which is the default timeout
for a write opration. We should not be waiting for this long when
we're actually trying to disconnect.

The driver already specifies a shorter 5-second timeout to be used
during shutdowns (ctrl->shutdown_timeout).

This patch checks the state of the controller before performing a
write command, and if the state is NVME_CTRL_DELETING,
NVME_CTRL_DELETING_NOIO, or NVME_CTRL_DEAD, the shorter timeout
ctrl->shutdown_timeout is used instead of the default.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/fabrics.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 668c6bb7a567..fa1ef8b5fd02 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -237,6 +237,19 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 {
 	struct nvme_command cmd = { };
 	int ret;
+	unsigned int timeout = 0;
+
+	/* Use shutdown timeout when the controller is being deleted */
+	switch (ctrl->state) {
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETING_NOIO:
+	case NVME_CTRL_DEAD:
+		timeout = jiffies + (ctrl->shutdown_timeout * HZ);
+		break;
+	default:
+		timeout = 0;
+		break;
+	}
 
 	cmd.prop_set.opcode = nvme_fabrics_command;
 	cmd.prop_set.fctype = nvme_fabrics_type_property_set;
@@ -244,8 +257,8 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
+				     timeout, NVME_QID_ANY, 0, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
