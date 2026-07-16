Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8C0C43458
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 03:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6TMOj25JJpCf5Zluo1OZGxUqt/l+bvnsxNP8T9/8Om0=; b=fjgk8nxsyAR7NuPmDMq9WsmBR6
	TJiEXbQMYbBWOJCLjzZlBJycPaBGeJ45lec4bSEyouRoQ8ZOp8EN1ZYuC3U4ncEQgaoMdpDo2oVJc
	TojpuSXq2Ya0w73OGE0XhaNnF+5kFQzH75AF6wTHqTpb4sXr5VqF60w6HoHvqa34weB6Hdi0qmGW6
	CvOM0+7a/z4r+8t6Au643cqQexYVDXKw8N5df+OIpKEvviEv26KVGbls3Fkg7GJeNioSA/w2TtwBA
	egGFWU6qZuOd4uAwI02aaSOcfb3PlLe/Ba/PQQcpuhylSTZHBso2S2b7DfplPpElPAM182LEjeqew
	gbNtRcIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkCqg-0000000GM2V-2hSD;
	Thu, 16 Jul 2026 03:33:22 +0000
Received: from mail-japaneastazon11012070.outbound.protection.outlook.com ([52.101.126.70] helo=TYPPR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkCqe-0000000GM1n-0Cbw;
	Thu, 16 Jul 2026 03:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F11LKIbeiMo/8jFieqc3Nh8W+gqukBfK6YJntJYeInJONTti9iDLjGmH2I6E363ElVWxQODa7lCc2ONSO7m2M6PxA3WXI5WsekqOvjMaeVRspsCmZM4djac4VwYetBt024um0xmJ77Dq68DxjiFl6BV/Zrv/AvwNy+hgVkO3U9xSNK96himeD93w8uIVsh4N5rXFLoCKDheNCl+NAjsy3RZmRkDd/N3MekXd9XObuI0OzH9LBs21CrlRWy4ynLI0ewZyT3YihkJNjJsGpIk+4QLPPG7D6qM402/XGD6quOrNEhGvxk2Qld4e2PJOj6ZYgUAWCiHCgKXDl4TgQ9TuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TMOj25JJpCf5Zluo1OZGxUqt/l+bvnsxNP8T9/8Om0=;
 b=igOvnPxUdQWC8+k8rESeyTCYTTUP/oBeP09w7YWDshnRVAb0bmCksuanWj7njlC5XTvzq1QrLvb7JLZi1Ser+/J5/VsxqDxPIk22CyCfn2qBLalF7G2+tbl/bTBNnnNc9d+7BOP04zDoKsOFl7+CZnRtTK5sUhWGdrP7dn4lVsGy5c/zXEy5nhny4j68aJRUMjSxEFO/zzQ4mGZzJfKvSac+31UmRnGwOnVvUfgcD7OpmEbgLliWbhtbXW6EXkcifUlE+pOl0CwSFFLZZHyS5lHJmoOJBe63d72U1biUX9WAIvNTp1gt2ArviWOOQlzdN6ZQZR0V33By335iL/C9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TMOj25JJpCf5Zluo1OZGxUqt/l+bvnsxNP8T9/8Om0=;
 b=B/vNoTQn2fHx8v25tSMyWRuNz1HWiGubEA2+NdAsJg8mB2TPlusRSsGnGQjbchfWxhaAMCkl/y1tesp2iqhzvLYzLjTbQu/GfDxgPvzNOvJL+wMP1NZ7d+jwQQt4Kl1Wsu2iXtco+RfahxGV0drENsWcVNlXGoRuse2w0hDm51dZ2RwuFF7AZyONsJZhQhknbD1wfUnCBJA5mh9KjuzxBpVC6r+L2tz8vOduw1tflqeWyA0aC10/sRSKuh15/Mr42XPo7QJE5FESrcuWyjrx70qXNIAxJK1HZ1j2P/pk3V+XNiDkfquqL1zCNbrEm2BNeuszNQewDRUfZ8iTWB6qgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6033.apcprd06.prod.outlook.com (2603:1096:101:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Thu, 16 Jul
 2026 03:33:13 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 03:33:13 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev (open list:ARM/APPLE MACHINE SUPPORT),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/APPLE MACHINE SUPPORT),
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] nvme-apple: Remove redundant dev_err_probe()
Date: Thu, 16 Jul 2026 11:33:01 +0800
Message-Id: <20260716033301.212797-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::17) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 749bea04-cc0e-48f3-1945-08dee2eaf746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|6133799003|18002099003|10067099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: hWXVpMNqqO+D0n70q5uFwpwlL6ttTfGLazGBVx8fAL7X7EEjh+S0q+LXgskqZpesgBWrHT5gZ+zCBf7KlR98rVexgyPUPMemt7h6owkYF8G3IrPA+zE1ow8mL+uuFAUUlJYGKLfkt6mu4lw6RnplCBxxosUHVCaQ8Q0FQuGngYekg8/ZLybOt+CBrA5rTKdk/5M1axAIKnaUyPTWhssuVRky6FXwkreY8LCSgoZaejlQ1MZKK3rAhXazFoyiO4R3T7xoVPyCX32RBZ5ttmr8Qa5cRxssyoHwSFI649Kgf7ENDr7K9T/tsT46TzAhmzHRglQubJhrQge1EMnCYGUO0P5nuc8+BRX2qg2ghrGXMwZUjWMJW+RhQMhKqlKc8Sk5jw171DtIrwgRgWIyUHwoXucUGKDbszYhaJNODUcitzHAkVISL8coHqqT/Zh+7X60f4C3MFOg1zjueYwuJNQEDoWfwt8CN5nmufPtRy+HDwqSY7R2uVEwZDrwz8HPaWkc/G2Pxa4RCwEX5h5iGQ/GjAMmhwUENtSAnt1TlOWL1yTdPW7nmnYczFsq71teqwDkame8feDmBHX5nn8XNJYZJEHGYAOllmgt8NkVY7MFiBimqpuQpVefvM6Nfx7fAnC5Z6bMlOoQaGZ2gSRlUlngMhsMIZErGP/TYIz6fOglH4Pil1GqvMi8scqogOZVJrRLZ4YFDbShE2bW80ZLBaP3G8IodGeO/Dm2a0IBLoQTB1Z8tIVORw31+NOYccJ0u/mZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(10067099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Mnh/nwJsQG9grdiTEFASviqX9UJsR5yG0ANi/GsKX0TkHHOauV9gIT/oFwz?=
 =?us-ascii?Q?HMM/4JsLLmSrEs8uKIg6GbCLMN8o/gC2x6xf77DWklNYiJvLZ2WH7fC27IYP?=
 =?us-ascii?Q?hNyQ9uePHmCH4KX1UWrc5Hfja1tX4wVQt410iUO/gJsnBwYfl6RQSzZiisZf?=
 =?us-ascii?Q?tBP4VZ4G2EJjJKxmLKlK/1M6+kSRODDZEFCaIIHrCzyFAQwqNPy9c1b5CTfz?=
 =?us-ascii?Q?ouBuYB8g//Fw+1UkIA809pCd/aj0tQAF9wWfjfvwuKcVOg+vw1UJkcyVL1eU?=
 =?us-ascii?Q?PSYDytlRO07hEQQhRI9nAy7vuJdUGoFx1WsuVl2w+P7WDSXRHcCBIHnA/s9E?=
 =?us-ascii?Q?H12UQrSG7p6bzrO+5ATtazi5QAwo/v3tG/rZkIgC3rEO7eeL19A8BQk0gB7H?=
 =?us-ascii?Q?jvHcOU4cLcLHSj4wD7P3dvgtIBN+yg+MpkkHiB44+dcAV8Q5kTpZeQ4JluLT?=
 =?us-ascii?Q?eipjsv97Y3KaEuArm1Bau1asG/0J9TooqYQd+uedfrUNU/iWkcst4g2J+8KP?=
 =?us-ascii?Q?LUziry/BwPpb1kqIf4ibQ3urNFkQkbIYVaL5NyFw8IR1w9pqh6ftQOIZAyTp?=
 =?us-ascii?Q?KdCNRhqDK1cF5p8kIun+EngukYgUHDzCJsRLMzNv7224tUD26RsJnC1SVzMA?=
 =?us-ascii?Q?/o2QbxbLA0Q8OH2cuQsWw0VmbYgMYMQ1Rb0aIOkb9UlX4qjad6UmV53MCgXW?=
 =?us-ascii?Q?6DgO3NFQ+yUFEddMbByQ9MneQtvUBKRdhGpfpoTFWzRId7a+snoSvJNfAFnq?=
 =?us-ascii?Q?7XcOX3Z+qsRel2FpsCuBSThiT8dL1xCnb7nERuilr3OKI7s9c33FuujZ8ioB?=
 =?us-ascii?Q?V5xmwuJZhkBiDTH0jKRt+ncTvmPVs9hrbsFfMbfNbTaU2/LXWyG1TedShPQ8?=
 =?us-ascii?Q?4rTTvE1IiGadzzMnHWXkgYIxNuoNATIRFkeDoREUgseCFgtc1omb0gTzYFrM?=
 =?us-ascii?Q?3lf+SAXd25b/MCPLBKRQNNDF1MCpxPDY1o8WhMkdnjIgwcAQVccEI4S/uazZ?=
 =?us-ascii?Q?vHAvzUUUruKFzWu7gBmO4urofdifnVo/D+Z7JdAWMpHpbpCfGfftplqJqCfU?=
 =?us-ascii?Q?wQH7YCp34Un26paD6kvd3qBuNf60J98K+XCTePWTOoNseElGicN4ywh8g1Om?=
 =?us-ascii?Q?QBUImY9pG5tILbSro1at486LfQjGKlbCfONJC2U2SR8EK+1HGkWE8Z8hC9qb?=
 =?us-ascii?Q?q/gXscxIsOl/38ogvVbrEx/R2A3yOLjAbG77nVvf8gIe8Yt24Vuy0O6rvGCf?=
 =?us-ascii?Q?trZy8C/Tu5PTTOM6PYtMVmVQwYBax9QZMOAkaFn4+aDB5MWSZ7JzISaQz3+B?=
 =?us-ascii?Q?ZSyihpeeH/NdwGSdh/8zNcrk6qRv5fTXSR1h4Yp4RvwZqHCclGQ8888uFKMP?=
 =?us-ascii?Q?w+6WglrrMcIoYd4lLqu2glVWlWCCyavfxLHtAY4jktnr13DMf2InfcP1C4AN?=
 =?us-ascii?Q?XwLxTn16ih/DbH+tnbkpW4LvIc4UHnIoqmkYXsu+1D67Z1wCVlMpvlXGrTe4?=
 =?us-ascii?Q?y73AmhdUUP9+bustQMAyAZxw7b1Aa61x0HoRzxS2RvMqgz7hbrCIftFQSAY7?=
 =?us-ascii?Q?KiJeIS2gtlS7G0itMGlHrh4qyVSLlIEewmzGxWR9sTF858q9dSMJPl553eqk?=
 =?us-ascii?Q?RP62Pc1RnRtACqdzyqIqqFeZw7siufAA75Y5r/7tjaNMYRFsB85yJZSUMlJ/?=
 =?us-ascii?Q?JMzhAefihm2Hel/zEXFslbRbZkDCFiGPFBht0HTbYiyOl46zcgSmZE/bA3WS?=
 =?us-ascii?Q?m1A/j/VX+Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749bea04-cc0e-48f3-1945-08dee2eaf746
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 03:33:13.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or7kj94xKgH/YwyQVX+eJYtQjWIUcIqdm4O0yt3N3ULcX2x9eWnBdVa8/Hv0nlFRdSzzHmKa1SHRk73W0Qvrew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_203320_109867_D04E3B3C 
X-CRM114-Status: UNSURE (   9.44  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/nvme/host/apple.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index be3b91b43ea5..5770fb2657c8 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1567,10 +1567,8 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 
 	ret = devm_request_irq(anv->dev, anv->irq, apple_nvme_irq, 0,
 			       "nvme-apple", anv);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to request IRQ");
+	if (ret)
 		goto put_dev;
-	}
 
 	anv->rtk =
 		devm_apple_rtkit_init(dev, anv, NULL, 0, &apple_nvme_rtkit_ops);
-- 
2.34.1


