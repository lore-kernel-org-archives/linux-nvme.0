Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D25C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 21:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iED/UrrlW1UHfs3oj2GWFXsStWqPaZcpHym7M8WKaMA=; b=vNa9k9CZRLDXIcr6sIjrLTJiT2
	2GgsS/9rXhrlkT5p3GLRjEwRa9Z1Sjmz3gfP6+de4PEdcGOQ85lCo2gC1sC/KVFIzfaYyVHyLi7TB
	eWkZS/c61iQOZdgdfMSvFA7Twtn9mBajpxFs2/k5erjeBWcS1nk02Ygaw85WWaBmAiru57DudQFcE
	9xaLrKbqoD2+8xXqjybT6Cw+jPONXLVH/8GhdtFZ1FC1o/CHvrjRRynbTFfjKYaejHtI6V8Fjvz6z
	hmwNYgJielZojdso0qoI+tMrZ6MahbdENvndbtJUdY5V9crZeg+WKGnocW5z4+xNfbDY0DnXltM74
	dncAnW6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFNI2-00GveT-Lx; Wed, 02 Feb 2022 21:35:46 +0000
Received: from mail-co1nam11olkn20803.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::803]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFNHs-00Gvc1-Fj
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 21:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+eBlz0IJVoswAgQCTgKUIj7BLTKT8PLnH5TM2g+Cq70O7Rd4U9LYLHPFGLEStUktEqJlW1rFIOrqvk3V1B26B1HcUINl9KLjW5CafnWLbK9lD/wZxfDUNsiS0kVbqHzDvQ8R26VCYmbq3smdBo9DlU7mPXhUPMuA16mju7hRP1BhFI9ErEpyewv7oTRETD8qdUx8SyJlPNLnpjYACDHa3yXNaBezRZLYBHo1tIqp+tMn4Gr5AlOx6KB9nKq8qvfe2ud+ZXBYmTQGKBVdm5nP4JbDeXj3me4eVmmhtuYVNALp+INiGNHYhV2V3zhYxI4DaTRm/oNWRXYkwxsSRPoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iED/UrrlW1UHfs3oj2GWFXsStWqPaZcpHym7M8WKaMA=;
 b=WBEZ8Q85nTyOuR9EhQ4YYdvaWOsPPpScobBrAF6rf72KX2HrvRZW1nqF/UgKFvqa5k+Z/mPusV6oQ0Y6Srqc+QIaRwCccdtrn2yPAnaXr1u4BVMG0kuLqOVA84e2poIkwuV3iVPUCfnHXCJqE3SMHuANr2EzRqqYVgJRuHwL+7RelB6VtK3RsYtfeTwCOhT/UFYkzddQ1QdK+g2E6rvnDfl2A+2jvuZcpwspMm7PrjukttSLRITB2xl9k0WRvkcgPFYHzPktLup8yKA05Z8lmyN00gpBDGLNy0UTbkJpRhH/o9JsppuhxskpOBeWv8G8Vn5zPzuMpoC7qxRvW4bmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iED/UrrlW1UHfs3oj2GWFXsStWqPaZcpHym7M8WKaMA=;
 b=IaPoJD36IwMDAjJqxSiw27UPDNm+V9NkyXQcZ8DpwAkWard4GLosYX9PVwbtY1RJ+r8qTf9KzztOEGwBOe68srKPmRvYV8nsEaCObuJdfhTEZ6GeIFdbuH8mRLUFG4AozPbykONluqMrPd7+ufWzN6SeXsQYVoo6lPNtv9Tx2MAGW4RmPJUhEKBeUqJExzUKuTJmk2lccv4HZuigYw6aF2A9+OS/A9cCHculQ2HWdrK8PaQ6s0cf/DIxYuF11J5ljDhmByRmojkZkvlr9eartt5L3VXJwY7ZCZDU/vibcxgkGRP9HMVczLjNOVUzOC+sZ60lDOIyYRfWzeGSv+jrtQ==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MW5PR13MB5560.namprd13.prod.outlook.com (2603:10b6:303:191::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.9; Wed, 2 Feb
 2022 21:35:34 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 21:35:34 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 1/2] nvme: send uevent on connection up
Date: Wed,  2 Feb 2022 16:34:50 -0500
Message-ID: <BL0PR13MB42913A07097FA13CD1B0B1089C279@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202213451.33599-1-nitram_67@hotmail.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [K+Mvl1qsAFhzHivHSpTjHbNnYqH9Zs3A]
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220202213451.33599-2-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dbb8191-cdf7-46ee-abc9-08d9e693f187
X-MS-TrafficTypeDiagnostic: MW5PR13MB5560:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwrAwQuzo/2hnq2DmXormDLJOYnU8Y1MaNHo9scH1/GY+8jYoFbU0RJxrD3ZN6aTcJXEuTD4MX31i086lc+jiyZOTqyqMouiNkP6dtrCQN6An5+5ZZtBkflt4diD0cCkfbznn+4V1o27xEa3mHAUEBPJUg3q4y++T1AgrLnPiV1/qbLfuxkXEwdzF2HkWA6MPjo3KikAohACKj3RBHr7sriy0duPpro3I2GajI1vX02jFQfK7NxbMFQ1iVEpOB909F50k9g6sRG+bf7mHj9Q5YXnBc3rSAklRJTtYL2g97KaRHi4ovYNO9p7ksXeONSqZLqYrcPBEAj3a7V3RaGCsi9HnLA8bCRsr6GusN8uy3BHHaE+vjQW36LScTGGJLhSgFEbDRBysgAlFCISF9hyzTaGC8W2zhN2re+wTU9erfY8FaqqpxmQmYEUaaooIgwno747FS5N5GYha6HLUF794UogeAH/9C4ZGSdhPIP/UzZOYoQyaSDkvNifX71Rvx6aHvjb00wPo90oglx941hNb2nb7omZLVTyBQ8uGvEJatCdWv8IuNc9TSXly0qM/WO9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9IzUTJmDkpPH1cVEXMs06QZEDucFVQDQut3vrM1n9rhRU/vR+z41ybNH+A5U?=
 =?us-ascii?Q?xB+wYQdi4hDwYjst1T94aRSJwD52shXd0wl/DfkGS6rYsAEjMLZdRHSqKcbm?=
 =?us-ascii?Q?NXzJPLW5rwNmuZeMIkqzNv+eBRG4nn/qu2llh6Vn7phO818CnGK3jNwVZDyJ?=
 =?us-ascii?Q?TJrCXV4re+t2srGRDHrwZ57bk+5OFnnZYM/pv3+kQk7djN3yYu7KR1HYNR/M?=
 =?us-ascii?Q?rC6xsrS9tJkvu4N+lu/yXMjRS67dJ5lP04bQOXD0uCcBRNLyaJhNJseqp/cw?=
 =?us-ascii?Q?m4weRjB53Ij8gQU38iXITJMz88n3MV3Bgrk3Rnr3efjr7Var6+banpCopZTr?=
 =?us-ascii?Q?07rThN9fwEy+A51Z9f9vAb11GM1OqobVizV1Jnjud1pDvoqwU7g97txClX2a?=
 =?us-ascii?Q?skLEeL7P5LJDSQkigC1XLhCb26r/9C/JTlgx5Zt2yacSDL2ZfEI6yhhrNiIs?=
 =?us-ascii?Q?8pDGWRjK/TtaFQo1V5h7ISrW5H0L/LWEkyMszcD9FBCAlDPJU5piS2X3j4AV?=
 =?us-ascii?Q?K+pXedElgvuV6h40jIcO9wCgIR+KRL/SmmiBr54YfydXEFUj/tc8u7uwgOtq?=
 =?us-ascii?Q?wTlcYgPc6O3GaKbn02YB6V13k7RxHq0G/JqZ53ECf7fI2qZEsJe0cKJyoDux?=
 =?us-ascii?Q?BiVFfrQrgqTN8VRAfXRGABHnqm5RRNXng04HTIHwKwk1EonfWaRy1B8WYV8e?=
 =?us-ascii?Q?+evxqU9yrxALWQfvYF9jIpVLh66CUSdOfrn2QfokgYz/9q12+CW6coc5Tm2v?=
 =?us-ascii?Q?ScvucXorDTg+fqd301504i3KyJfF+ttTFUJLRIGI2fzFpWSl6/Jcvkk1BZoV?=
 =?us-ascii?Q?MuWh6j2PquB0UttVGhrgN7ILXTQKd2dFcnxGbEyN7DwmlTHNoFEEt6iHtpTF?=
 =?us-ascii?Q?7110v2HAu6cPnIbsHhLBZ7LG4s7IHka59XVuZFVT5URYIGQR4Q14LhfC9bTA?=
 =?us-ascii?Q?RyyVL1+ITr9ILhluxpodWQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbb8191-cdf7-46ee-abc9-08d9e693f187
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:35:34.0635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5560
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_133536_555023_7DC0C8E2 
X-CRM114-Status: GOOD (  12.56  )
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

When connectivity with a controller is lost, the driver will keep trying
to reconnect once every 10 sec. When connection is restored, user-space
apps need to be informed so that they can take proper action. For
example, TP8010 introduces the DIM PDU, which is used to register with
a discovery controller (DC). The DIM PDU is sent from user-space.  The
DIM PDU must be sent every time a connection is established with a DC.
Therefore, the kernel must tell user-space apps when connection is
restored so that registration can happen.

The uevent sent is a "change" uevent with environmental data
set to: "NVME_EVENT=connected".

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 961a5f8a44d2..872c389dc6d3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4231,6 +4231,13 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
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
@@ -4405,6 +4412,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
 	}
+
+	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
-- 
2.34.1


