Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19246C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z44ADW6e7xTpu7oLktxjLYgq6NA2RaEU6yHsndWzJn4=; b=5DKJ5OyiEBRwTcRaHwHjsvfQxy
	O2Y5lws6UmM/9rUF7U+kdvW8XC9md2CJ0A6364AxkTS0R0wsLqcS8FbRW7FExn8bzqkypNbdJ4Tt+
	LjkZnxBYKSs9gxxiZPCUzDrYnAGMtpyOrGFeVNxWFI4RDrrjRlBjIXaJvdEfq1vIuBbucpttjFmWl
	Sg4aIQi445lVRhasCYg0Oq5v92ovSNoouXxdECzh0O5VBNkYCTB0d2G6IQI6qe+3SzpY9l9ApAXhS
	7RKU4w+6kBVF3rqm5LY3ndBi4aFqo3pwZYwdc7fcVKH55EOwvoEYSb/EhSAHIs9qCg2L7rurGbPgZ
	tpWN9IhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHWG6-00FQWM-Uh; Tue, 08 Feb 2022 19:34:39 +0000
Received: from mail-dm6nam10olkn2080e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::80e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHWFs-00FQR1-K4
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 19:34:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cga1Mjw2bwhVpkIkYZ6vPNddN5/R0JiAh/XqPfoxd5/8ckwDaquxmkcjKLGYcJcQijYq62S5hsH0vIOa9W8o0h5Cjz98rNeg8iA7DNfBnM5xIwtg+wA1Po+g5U2GOItGawPqLIdDiFfAT2H1gjyyqAgpHeGuOXuebUtozQ6/Ac7RZ7J1u07Nng70dCfkqr/OWrx3/Vu+/v+Q3kbKFq87fxe0bXC2smjMAziAzPju1+J7kq+amCG2GpaPs4dY9hiU4o8kbgE10PIDKhS4w23OnORGjDlvPEU71GZxX59Jg7c11BJD3F8/0mQLVHrt6CVIv4PpmtoKu29Gfj0gxwKF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z44ADW6e7xTpu7oLktxjLYgq6NA2RaEU6yHsndWzJn4=;
 b=hO5s42bziq06GavNW8fv4d8XD9ZtedmarC2ksKdxmkBKhNqlDUNW/AkhRy4I7QaGos0/iMergFE0P4/fO4tYSq/ClNomt/XC4wfDcjGFnqBMIT4Jq9PRF2yXhpAurBkx0gWm2xYxlYW/Aif/mjrMglN8NMc63HOA67I16mx13d6qSLptnIe90OcnAmpmGhNiKrSE66QwWUol0pfSjRPcsqWHatN53Gd7HbFgiUBD30H59qyN4f1KFiGbMRtqusVL+lXSf54dqOpzv8JekNeIBrt27EWaT5Osn3uw8keZ9RnRh2WR1ek1ze3Wu6lNyC7gvuqtdsdkHPuEn41VWhdTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z44ADW6e7xTpu7oLktxjLYgq6NA2RaEU6yHsndWzJn4=;
 b=Mne3aa3ZLMbxipVZw5irBpFzUfcpuG3tZ79Yz/5Jgzx7cw2OXQVBD55GYvlHzgXoC9NIGsmz4KwqLoBieJWED9kyn44jNHRga6m3M7KfLvKhGb/EX3FeQ6DNnLonjp4NnaBkvpCLsJ7te4ZLIvVpipiXCB+1fdDb/BvObvWywOe0oPHYKiS6QiRuLTszXM3Z2mwy9jkEqdg2XC8cOxt4n9mfHtFc16J0l974oXCmIYjii0bP4wi1p01d3Rh0Dzd3MpAuFdF4iQXrpnklmOKKjV1Ctw43x5oHGoDEavaZUUe3b8pbUgbiji/TIt3DeD1opBzGizXDvNcOaNphoWhU9g==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3805.namprd13.prod.outlook.com (2603:10b6:208:1f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8; Tue, 8 Feb
 2022 19:34:22 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4975.010; Tue, 8 Feb 2022
 19:34:22 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCHv3 1/2] nvme: send uevent on connection up
Date: Tue,  8 Feb 2022 14:33:45 -0500
Message-ID: <BL0PR13MB4291421C8BC621EEA559A88D9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208193346.22580-1-nitram_67@hotmail.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wN236zTVCy0R0WB+0bh2QI1XxnHkeSYv]
X-ClientProxiedBy: DB6PR07CA0195.eurprd07.prod.outlook.com
 (2603:10a6:6:42::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220208193346.22580-2-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13264f5d-4c22-4276-46de-08d9eb3a0173
X-MS-TrafficTypeDiagnostic: MN2PR13MB3805:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utnILhMfad1zzlZkDDqrs64wKGtqXGW9MZ5D4hPAuIg4Q58CN5ISTzrd+NG1SFghnbZACWm6SCXX9qVulA/JkDqIYdZId5a7fvzQxI5DhxB4OPsaPiRyTSovZ+cMJKTpojmQUT2iqOmxx7h39xlE5ZlPKu9sRX6V0yVGZQEvDKQ3iTwRfN2fAi4hu9Js5ItrorILtympqDYrjzv8qiLPuagVvqWVbfbF6lcx031MDW9U3F9xCO2KF3yxCOAQKGOedzKAxvg0P2DviGeIXPUAOK3CXNRq6XzPbxtzcZAakkOZ+sLCNGiFnH6xMDsW51buAjcu1kwZTCCHa61buy73pTDHzMHOBUVhV5dRCGrrZgHEbNGHSPaMDNsiwUta9Ol8QwIXKPjgN4UFprXEAmDere9MNeIbOg5tDWI6F1R62QK7Ni35RuHkB4ke1LFOqJC2MpYW9ZjHei/yOqE4yvnYpugfNj1/DHBwByxxSOL7gY/bXliTk1/7bH0zZKxCNOBg71IptubFaVAJTFRsCL/8M1/aYehv8Y/ZSxZvh7bVzSySCCSAagF73MaiTrvYR8R1vFzh3SU5x5sX6yTYliKY4g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FpgOzEYiR2+a5XND98cJll8vtQhCBJsFlWo4RQeUApubiP6iHBOJxoSBsi1I?=
 =?us-ascii?Q?Rk590f8MzK7jZr9souPW1wUxomgLvDm3oapT+/7p62CsuiXYpCavkdRu8GpG?=
 =?us-ascii?Q?LuJhSGRkf5WP6+WYZzAhsC/xV6vsHtqTG5M0B2Tmyzmg6z4imXO0Yk4kk9RH?=
 =?us-ascii?Q?iPPkgIRVM/SGC7Fc2AGvDf+iXXY2RWI8kUEPoMUlZlZ1LA/GrvUYv1bToBQD?=
 =?us-ascii?Q?wgIKjc0HMjqF1jouyVIyYhMng9JXJHXMEgWJSftkXSz/l1SF8+ibgA56ULr5?=
 =?us-ascii?Q?6zNdwAeXk5dQ1q9/qP9cS3/LH61HXEw12yDXPJa5n8akGxzBNqlM/RNodfi6?=
 =?us-ascii?Q?iELShL/ooVob5fNHav0DCN7dEpxUhb4NP4hRLI2ACCnyUmD8aQxMABYA+t3U?=
 =?us-ascii?Q?J/B8yFYPEfrZr2TwQ7XgcPSbAcMhYRFUf5CVfnoDoRDqhv9Qs4gZc6oxuob6?=
 =?us-ascii?Q?Y2NU3CyOtBI0FqiI9yre9/8EV8zV5EpKEoAez8590OwywOvGmntw8YkiqH9u?=
 =?us-ascii?Q?J6ngXy9eeMEP78xY88Xve8C6AERlVgWf07uUH2Pl2Xv0XB/DTAqgLGg0RUUp?=
 =?us-ascii?Q?bfF3EYgU2w7tShCSbv/lUSO3Q0fcq/p4Y2e8ceRlquDUbQCTe7wQOyklU8as?=
 =?us-ascii?Q?tVc4vD03gClJ4yJ+tJjeJ7Sp2BS5zSqlLHNr84hymyPd5wJEEpT5lEykD5iw?=
 =?us-ascii?Q?/x5YEYghXdv+MtSXdHEjGIVF7ikk00dYBO+HAdP4VxhWzP86edu37DtSErvk?=
 =?us-ascii?Q?d8W8dzy5ge7nCDn5KMYFRwwtx3HwN5z92Oi0i7hha1OfhGGOflgrVWXh0iHb?=
 =?us-ascii?Q?ku/29egrmy9wkUVodGScu7YUEsM7CR4FtCdaJUl6E38mWCdz1fkxq+oiAYOr?=
 =?us-ascii?Q?iNg2iHB0zOx3haw1o6jH9cu1JC/qYuvbBau79HjX91qx7nAOl2kDVpUDIUQ2?=
 =?us-ascii?Q?HXWJY3gexsunDDIe/NZfuQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 13264f5d-4c22-4276-46de-08d9eb3a0173
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 19:34:22.1160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3805
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_113424_703975_D8AC3EDD 
X-CRM114-Status: GOOD (  11.87  )
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

When connectivity with a controller is lost, the driver will keep
trying to reconnect once every 10 sec. When connection is restored,
user-space apps need to be informed so that they can take proper
action. For example, TP8010 introduces the DIM PDU, which is used to
register with a discovery controller (DC). The DIM PDU is sent from
user-space.  The DIM PDU must be sent every time a connection is
established with a DC. Therefore, the kernel must tell user-space apps
when connection is restored so that registration can happen.

The uevent sent is a "change" uevent with environmental data
set to: "NVME_EVENT=connected".

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd18861f77c0..b5e452aa3c0e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4229,6 +4229,13 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return ret;
 }
 
+static void nvme_change_uevent(struct nvme_ctrl *ctrl, char *envdata)
+{
+	char *envp[2] = { envdata, NULL };
+
+	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+}
+
 static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
 {
 	char *envp[2] = { NULL, NULL };
@@ -4396,6 +4403,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
 	}
+
+	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
-- 
2.34.1


