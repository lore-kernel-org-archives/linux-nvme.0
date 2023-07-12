Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353B9EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hDKCicLULOso587BMmlw43A5fl+CvMB3t3AJlMmFiyI=; b=NV9hId4oJ+5ggZO9NtIXjFW3X7
	SBzT+kR15YmMEj62aUCKHxfuwmalHfV9dOS1ymtC3b6ciCVP6g0Mj59HqPMT7/F/OGgXqG4PlRtC/
	8BOJw6TlpOr680CWGdEEkRTMUm0K2m2bucz1by4gw0R4ynUNjFYNT54zVx+jwuEZ8WkHXYKvVaeGd
	wJKTuv8SZ9OAeGTzilY+QllJOhjxH7dvff6fHzOj+hZ2CqelMW6GTUhPmH65jX8MzvczpdJ+sPtNg
	QfI5Jegi7lWiSOd+wODvICwWwlDyZOjA2EBjBNTGh0NvFS0cnYDzUFmp8ij8WjsS5VkZkiTO2gOrh
	/ULlnBMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJXs7-00HNyN-3D;
	Wed, 12 Jul 2023 11:19:04 +0000
Received: from mail-tyzapc01on20706.outbound.protection.outlook.com ([2a01:111:f403:704b::706] helo=APC01-TYZ-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJXs2-00HNx0-1h
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 11:18:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpBeSBYgpWWf0mFQucYkLejweR1wlHYUi6Aw38U7t/zKvqj0UpGYILSMiTiscTypORuZjtugxQO9UeSTmDk88K10vVS6MzT7/I5kTdO57N3cHqKYktmrNblkxIAtHS7ajjTNstUEG9cebRZhn/IAYpngyCOqD2SpRvjNIPunAd+9lAgyTJwtUUJ3JcMe1wRSxTDMCxjQEIPRS1DFJJIbMoMxMA9QW0G/Eikd9exgLdtITRB6SgUDIEhN2kDGJL9KvDSMzWs5Ws1uMa2YnU7a0J3jZR3jiD/PoZzVTXBtl1qCcsrBSK/lVN4E+fjysdkNTkX+UgD9xvfRioItHirakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDKCicLULOso587BMmlw43A5fl+CvMB3t3AJlMmFiyI=;
 b=JMq6vD1t1Sxew2FXlbX+3PihecKubPJVPdLe5SsOAl7lUtH6x3GnzbPftoJvDgEeTEbIvDFKEz2oilhuHVoLDQjZDgpXnbkDdBMQq4ZafcMQ/sDPBCEcRPeeA+83CbslM4fcMDlsRqCRjdhWJAIWhmGTjUVU8LaP3wLbghCDvlok4WvN7/XdcBfaHeWQiwgNeIAzQXLPSEBpT5J/sseUv6RQpU3U7Zgjahp5Oauf5A531HuVZCpdtzpOPkpL0eGHT05QwRCrSNRDxJ/XOy1qeq9G15B2V8Rkh5rWQFavKfqgg+MEZIRMFmtEzxY/uKE6Vtck8i9IYlmUayQusw5Xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDKCicLULOso587BMmlw43A5fl+CvMB3t3AJlMmFiyI=;
 b=YEfsLyV05FAf5aBmJ13Zo0t4az3tcyoPOajBcLFapbMIyJl/LI2gQLNFpE9ELb/yYXLEnqqQmRUhdYY5h/V96pK3GJttrEibb+G9yyIT0wCuNiU3+ds1sNa+wYQ1yTFPmusurURi22hlIN1xYh8jqpKeqo1bHroZbdGbs1cCs5mKHYIzmdv6oFKOfZjZzOxU5I5a4bUbnsrr6SDfAlZgllzJGunDWizZlfbtD8iTPg3khSrfaBpm9XKhA2czjnSfMIfjiE8n1pwxE9CqgkmuFboIRs+P6UFAnVeha1Evt3hFfbg7fopMDQnFlW7W3QJKvnZs928bvS9Lfwr1vmJ5TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYSPR06MB6544.apcprd06.prod.outlook.com (2603:1096:400:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 11:18:47 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 11:18:47 +0000
From: Minjie Du <duminjie@vivo.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: host: fix parameter check in nvme_fault_inject_init()
Date: Wed, 12 Jul 2023 19:18:37 +0800
Message-Id: <20230712111838.11923-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYSPR06MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f364131-5524-4cc9-c724-08db82c9c265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xa6Nb1iQRAdGZad3wAVNXqfW8a1UrM4jVu1zvx9m/qV1hlIJ1/+9nywBUILaWNHa4fRHtAxZHNmvgTHli0KXg2XRT8xHJ8GUpXfkMnZny1oXNWga+7p0sGF4sGL3gQKfisEBsRAzSMTHKw68b08DMi4XdNClS+KAvE9OWvceBbJoKqkGxMCXj5E6aBLD+ieE0U8ngkp4drwU6Y82OurTcvYeQa9fVRYdR+bIbHCr3vbH75Yauf7gMEDlzPqQqgdqI+gxArgQyIY/tqt2tleOp+V5b29XBANx8FqtQSXMc7bUtfryQE0p7R56w2JIB/hJsuHhczAMyE2oxzgtry0Pa5WAPYdFEFr2bsU33uoLJvBKYL51Jg6qAL3WHe5lEkfIW38lwrfu30hTFaGPprNTKFSjdqHDGL8DLnv87OQ5AkacbvXhn+6mbUIyl8WKWvyscAk9QXKtN7s0trO0xItE8Spw1FQvi7NvaCG5f3YgTVBnbaWIraXlKBl3e/Gc3JkaiBtH6XiZB1sG89BKBghVq/OxQaFsA3S7RwvG0iaGmjMrHeT5C7jICR0lZjVm7fIaKwEI/g5pizxxnzNTmsmn687Z35320Aphvi6XSCz5+h4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(38100700002)(2616005)(38350700002)(4744005)(41300700001)(316002)(2906002)(8676002)(8936002)(5660300002)(66476007)(4326008)(66556008)(66946007)(6666004)(6486002)(52116002)(6512007)(83380400001)(478600001)(36756003)(110136005)(1076003)(6506007)(107886003)(186003)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xmgZhZsHlPTlwlxtnEzpsQKnichNpbWqolWyGcT6k5oPc8sODE0jewcJlkTo?=
 =?us-ascii?Q?GSkXhAfBsfpnxoqpeND4tZQbKj2PkN6p/Zgb+wubDkfjD9zTgkIIqIhRJe6Z?=
 =?us-ascii?Q?1eHESGvTZS+Ffl6cZuUnvnShL/26DmE3dtePKK4rht/MRB8RXCsH66HFucHT?=
 =?us-ascii?Q?iwALhEjWpGhbRgjhKdPeQTc2EQ5N0k3erD128aKN6tgWjTNQMxg3FHhEPRan?=
 =?us-ascii?Q?9BnY9a43M33x9D4g1M1d+P3ft4UiMt/e0e3ndCrOcADLQRa7AuMSeWachDvD?=
 =?us-ascii?Q?T8+YzDUT4RIKMlSiHmPoEL48qHRLgFcO5RQzj9y6gpgukBQdc2zqb4/eVuBI?=
 =?us-ascii?Q?wQuXclSvQAhTkUKUnkRWPlAuofs/WCVoZrRJzPautQ9gmx7HGkUs/OF3gD87?=
 =?us-ascii?Q?IHS9RfB9/IvBtrjyDk2pBVb6zW4IvzM7vX85+VkRBP2bcVOgHkBtoW1Dyfk/?=
 =?us-ascii?Q?CP11sl2KscmnzbqhlK337WyROx/9Zm7+uCj4JA7L3459mNVF9mHpT8q4JRio?=
 =?us-ascii?Q?HJUJQGO6QOlMvkDdgfOc+s2pB23dtFCq2m9PtbWwAUUQ4pjNk64M/lDRyR/7?=
 =?us-ascii?Q?vw/wVGZ4H4KUaJik55r9J8WNV7i4bSch+stqm1p1fknGABHHYZXP91p4KNEr?=
 =?us-ascii?Q?McWJQ8zJmstrpThavyeoosnJLU8gD6hZ0F+UsIQzHwsVjmMjZOtlTT6HoqyI?=
 =?us-ascii?Q?+FFjlDfEaxNpetDvfa7zgUyY02Oaw8bO6SC2Btea+8LmG00xUUdEhnEzjRWx?=
 =?us-ascii?Q?+pSCoAVlijXS9V1tdWoy7Tc74QZh41qYAlVKEqQtib1HuWzkIfoSuBi5M+X4?=
 =?us-ascii?Q?AnfgunobcivtPJ+rFhFSks7i04EMHBIImklmwPhi1eEwU8HQLld4E8HzvMpl?=
 =?us-ascii?Q?v248VryFNp0qcvpnuZg68nDT4318xhu5nLywzq6G952zGH5+QEDuY2oVvHNV?=
 =?us-ascii?Q?JW4zLbhxlZG5V/vIVw6tQfnrJQzVbInegsEwaQq1BcyGYo2BcOniF3uG8k1z?=
 =?us-ascii?Q?ECb8Z62jciL54mBxgFDkUjsuOE8W88uPBJUqGZNG8yKp2md6Y6aWJOhJeTes?=
 =?us-ascii?Q?gomAqZpT6n/vMAHU7YOg6i/7cu+xtFMSWi1ZyOGgEDg9qJoB3HGksFKd7N6S?=
 =?us-ascii?Q?CiHx2kGQiXiM58y9XbgH3rFGZtnjvosxI6cU4KWV+AJwnhg6ke+usGBAoiY8?=
 =?us-ascii?Q?rGY9akTFiDdHJ987zHbmFbZfPx+ZRL4AAMO6M+VVO3w29wRzitgD3PqrFv3i?=
 =?us-ascii?Q?0ex2UZa91kXDA6pHCaMu6uxu1D80juriO6cDu0H6rLBAxefjIhF/2y8HZYRY?=
 =?us-ascii?Q?EgWnDJoOkFM5+q5zmp/0OZeq7wW3fC6R4AysBtxMzkh++Zh4Arwn0j0ndQ91?=
 =?us-ascii?Q?qdxqcD5X48kxM1MrCZJ5gb0wDb9o8Fm10nMLx41qUF4xSDH+tbnF+yaVSPHo?=
 =?us-ascii?Q?5DBvKoMaS96MDm4EDu29BBTSVfKcmugSXBzzk0v36OeigqZ69SG19vt4IKi4?=
 =?us-ascii?Q?xuKQc9uIWnn0d+Ifsq21BUWGGRSrFSwRMZOtjnjkh97YHj80QlYqtUU/ZFZD?=
 =?us-ascii?Q?bKmr7hTXTlMj+8ludiNgLmrXl4JpHssZoGZpME77?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f364131-5524-4cc9-c724-08db82c9c265
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:18:46.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZN97aoClfK41Rq5XrlBkqGypVPHE8v35GzCU3TSxCqySY+5hobKjnp6WcSkMSEi/WIJha+OzHbbm/1e65UOlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6544
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_041858_567591_5BC9C776 
X-CRM114-Status: GOOD (  11.80  )
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

Make IS_ERR() judge the debugfs_create_dir() function return.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/nvme/host/fault_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 83d2e6860..1ba10a5c6 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -27,7 +27,7 @@ void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 
 	/* create debugfs directory and attribute */
 	parent = debugfs_create_dir(dev_name, NULL);
-	if (!parent) {
+	if (IS_ERR(parent)) {
 		pr_warn("%s: failed to create debugfs directory\n", dev_name);
 		return;
 	}
-- 
2.39.0


