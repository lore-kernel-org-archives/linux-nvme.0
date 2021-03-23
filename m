Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF25C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:32:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCAA619B2
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCAA619B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ULgBpSSiWa1XlN6A3x1P9bbFUZJ4WO7wnjanc0jeSck=; b=eve4nhP0Dv/azAr277QjjXv3Hr
	iuvnT8QyRdiHSrw0Yj43ZUAUb+TOkPmv/l8j4DxQgfkKjhEVlqyw1Sbu3BZOOKZlJsZJm3ryPECmE
	Mrp4QE2OCxdC/MLc9Lr3JVxVQaLLELaOsdora6OBxKC3nsHZf+oBtjstp5uzhrZEQTSK6a77wm6qE
	B+6cuLvWQyXNjIHmsV8CCIk9L3yp5BI+dH1CO/+fdnOLu2NGAhRlaxi/D0hAMunKNfAHWd96tYlOU
	aEVxTylvYutLcOgdApzpGJfipXtkd2q7CleF8gpSHN7FNFA9QMg/C47pkVgFmfOas8E+W96ZiZClg
	eDpKywTw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lObWG-00E93G-M9; Tue, 23 Mar 2021 07:32:05 +0000
Received: from mail-oln040092255016.outbound.protection.outlook.com
 ([40.92.255.16] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lObW9-00E90g-0g
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 07:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhopC9bKs7Odrf/jnz+t72RFR0fuGMPGXBHeXiOfxsJ4byzfSVSfGUTutJa9uzKIbN3UG0pFff87uMQPmCl4mDMwMFSST2fGaPueB5Pr4YCD5UsKo/YnQRHsvRsByf3mJHZ+BYqiwiknOCKQFCsFkCJXr/TIK4EUieIll8uUONpsiRsZSkv78DAKdLtHm620+bgD+aALYjCYagH9DQ6wBr6AaTED4ZMJKGQkAX8P7ohq+6Z5ZXMg32oA7TCM2n/pozMp4ZxVwwGA/ujNI6zMyaRfKBqLeBGgpLOI3r77M/RmeqsssWM5NL5xaKIUHVnV7Pm84RmMG3m70j2K7zIGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y93WufzirjtaHY3QpEwPFeftx8GWdDk23ih8WUX08MQ=;
 b=L7i8cbVcS8T6+b78rWfjBhwRT7Jc17d8h6MxGK28yoKeRLTHgy2SzZYljeY5irguWyVGfoGMjTgyUXekoh31RcZ//waNvPLdgeVXTP5TuPNpfKxbkFXsgyAhw/Oq57t7U4IPQ1WjUo2t1Dba3WwI8+1w2AhijI8IQnS7ryTS8dBAz1iWZfxSZBrenAlj1Mp9v4C+Ssmm6TziAIubr41xTpWu8lsRmqgaYzKHkSgYSisf7z8wb3DhsZ8+V7kF2LySZ0oOb07/WgLJ5pN5dVPMtT/yueFpkBQdWGMuGLoAYqT5YmjYI3SKzydQhhjvLjz4e04nlv9c6D0iJkuHZKRyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y93WufzirjtaHY3QpEwPFeftx8GWdDk23ih8WUX08MQ=;
 b=DAaAYmwllA+y8ok7zBfCblSkwrJN2MH/JlkrySC6a30pDs3juoQ5QJP6vL1FrcDYDDzrr3p2uVFNy9FXGJH7kXLHOILqWcGDt3WjsTRsHCUyCEF8T3HS+J/RoSFoErHpylHA85tp4pJThasWYW5Rvf32nWzqTSy4YFLKYl33QV+DBhjZPyjK+AE48zNSnSv1+nKf6ewx2uLkPD5aCygs8D1j7gwMa7YsaxOXK2EpcQIl+L3pPnFURBnyWmvkEVvYgJlY72TaNuHkPlPEu2sKa0DAHntiZbA6MdjDS/Q+1qbhuJLh3tqTO15+gJySh3wOTpFBthwFIIpvggYjenHOWg==
Received: from HK2APC01FT037.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::52) by
 HK2APC01HT165.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::439)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 07:31:50 +0000
Received: from OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM (10.152.248.57) by
 HK2APC01FT037.mail.protection.outlook.com (10.152.248.223) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 07:31:50 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:CE54EFE253E0AD67E6508925BBB00FB5397652917E78019D725290A4E41C7302;
 UpperCasedChecksum:99CD452CF98A1155A42D561A253A2B04A0C385C5C9F9735D61ABA704563AB7BF;
 SizeAsReceived:7258; Count:45
Received: from OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85d:99cb:f802:3c27]) by OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85d:99cb:f802:3c27%8]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 07:31:50 +0000
From: pngliu@hotmail.com
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	Peng Liu <liupeng17@lenovo.com>
Subject: [PATCH] nvme: fix APST error for power latency tolerance
Date: Tue, 23 Mar 2021 15:31:33 +0800
Message-ID: <OSYP286MB0181647E6B1C99AF64C0803DC6649@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
X-TMN: [qh0getdrPHuQr+PE9Y459yedVfXr/r2O]
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:92::16)
X-Microsoft-Original-Message-ID: <20210323073133.27328-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (57.197.58.19) by
 HK0PR03CA0109.apcprd03.prod.outlook.com (2603:1096:203:b0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 07:31:49 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 8089c005-a300-494c-ea69-08d8edcdb8cf
X-MS-TrafficTypeDiagnostic: HK2APC01HT165:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlQirgYYG4ibDoJox658xcLNxJ9ZIGSl8i4kuhkrqSuOWRX+fNfS4Gp7FrgdUYZR9f8hqYRvsvKUhbq11/oWOaBMfCGAMpHKVRmtuRvgE/HGtfTKrmxWOHeRVWDvvkcxtq7/+Lt/DUT74LKWiWku0SFghVqpZIoxh8QQaF/dUJWSF0XjLut+p5VqZtpHfAio3wSvDMGlQ33ZxhZCd6pSo9sjMr2wP/dSObrAp5EqYRYxeLpXory2WEsNk5MWEPrfNJlpM7diyVcGAh0TYL9ZvcLNxf3rjZxfOuvziVEeGsaoQwUncyADhKTZ/YhgYTaO2qAIT7IEX0MCPZtFq856jh2tr8CX06i/qJS6uah+jsgcUjXiudAI+AZ8dTgHsAQcU+qD9Pv0P54hxrBYWkRkYw==
X-MS-Exchange-AntiSpam-MessageData: rTmrhI4nQIP/oLmYoZsCaWdj5DTXph0c86GywVI3PpMHK+1kZR41zQTaiQWBSNEnOgf5VfROapfFSlBX24H3OrfV6CU34Dm2ovokRGDx96LVmdkOdUStbgTrkAZ0BgZXtRUogwMF4zpSamN6v5/97Q==
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8089c005-a300-494c-ea69-08d8edcdb8cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 07:31:50.3203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT037.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_073158_350110_6982F572 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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

From: Peng Liu <liupeng17@lenovo.com>

Clear apsta so that nvme_configure_apst() does not execute
nvme_set_features(), which will fail because admin_q is either not set up
yet or no longer available at the time of nvme_uninit_ctrl() being called,
and this leads to the error message "nvme nvme0: failed to set APST feature
(-19)".

Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..413a33c67655 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4475,7 +4475,11 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
+
+	/* clear APSTA since admin_q is unavailable for feature setting */
+	ctrl->apsta = 0;
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
+
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 	nvme_put_ctrl(ctrl);
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
