Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D18C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=svqTAfavA43kue7EACsKBIgH8T86m32qEJ3P4vNJk2c=; b=1ezE+vFqXN54WHaUV9MoBV6iFs
	b6Y+QdxcAbbMZSvw/iv5uTzlKxJjX/pgEtkmrUkTWDkna4SdWmcfNdEeqfl1zN1fpAG+pXgWWS8Wi
	kzVSCiw4YPIiQzsXdFQRfx06nR8KEy0H3XqpPaPcaRiGw4mQp7ZgZEW1nYjrqZ0iJZDypTOyZjemE
	sY+cvnY5ej81GQnn+vle1f17oMtT2MnGXIbz2ZL4PYHBgzgfQi5jDQA6aTR9LYDr7z3/aSzh3FKc5
	m7i9lfa6QvIXUw+6ks9HYAo/EkBSC3mejr1QK1ykFRbYfouFdwb3lvXAPtidNK3TyomNeO883+GRL
	GJNk+SUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCNJF-008EX3-6t; Tue, 25 Jan 2022 15:00:37 +0000
Received: from mail-mw2nam10olkn2079.outbound.protection.outlook.com
 ([40.92.42.79] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCNIy-008EVu-OW
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 15:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Xbu6iv4ZMqyL8+xgDt3jK2qj7K0JwfE4NOckegnpSGXhxL+JVgSJWV65NdO9rmjeohwCS14xDYZd1Ir69QeUtou/WvGIf/Veq3OldhuHT1Q8MTSNqU/gBKaKNeoB1PRSFU1jqhAzNG777p/SZ9yNT9L3PfYu5lALmTKQzJHW3X+K2pcqUWn/t/kaneYopkERz4HNSeRwnEv4IeehkLeV6W0RTHJr2W8DIzA8QKz0yRQq/j36/DfaBhmP17jRCCuBRklLpsO353fxdRmRYUbhsNCx+3VKILNo8hGLaMuw451ATKPzGXleXfsQ6+WMHwNLru6Revy7VUVa2T8s1VCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svqTAfavA43kue7EACsKBIgH8T86m32qEJ3P4vNJk2c=;
 b=ar3D+w2YXCyIOdnBJNmJ0qc58SHn41ynwH38Q1EUqEwoRtYIcj3QvOMAcQbhVsg1gVxOYiSSQw4hy/euhGcPecD0S+Fk1aVN23jALv7oq9aW2qXpljfuKk5OqdotcIxqWGquqFa4Pco4s+hT5wWnLSeqYnsJMXdFsqtGJjJDI+uOIFxVQ9RMZyP9DJEVMNi8tmo2Wk4gsn8jwvLCcal1dPG2tEQp6xNnyTTS6gbxSSnBl6HlUjzYAXGkyNCP1YLw3G8+dgtdC75ylSoTmFcrdJP3MTu+DghhyBZPV11vrweZyku0gv7nxofeSIUywF6KL8cD5SWYHPOMPUVJFZjYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svqTAfavA43kue7EACsKBIgH8T86m32qEJ3P4vNJk2c=;
 b=V8XJ3tQfAuHeXcwgQVuyA0nggqULIJQrkU09GDc2UOXeIha+mpst5mRq9TovMkTWXenZ0ljwzTFtUIVtSFDnB8rD2n/aKzn3Z9BXcnNIWMpona/IHr77gDD4k9sdGcWca+A+Wk1eL7Va76j96eUYiJtljbw86T0+Jo52Tyfj5ZBmPPaTQzaUsNWxAormE/l12Dqxu8ALRPW1WvsNco2NS4Titrb2Ged0/AQk0HjuWhWxZgw3YAx88Rppthay8p3t/Wd+iObNIRHJaS4IDelEg+Sck271qVwKxOZbHUHrOOCPPyfGI0aPmcDnWdaoFA9s+Nwk2Z3wZ5AeE8t5sW1b3g==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB2590.namprd13.prod.outlook.com (2603:10b6:208:ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Tue, 25 Jan
 2022 15:00:12 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::8078:8a78:bc1d:43f1]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::8078:8a78:bc1d:43f1%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 15:00:12 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 0/4] nvme-fabrics: add support for TP8010
Date: Tue, 25 Jan 2022 09:59:52 -0500
Message-ID: <BL0PR13MB4291A64C165DCB6AC710A1989C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NT3IeIkWOt52BtF3i52DHeV+2q+UR4VY]
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220125145956.14746-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3abded08-effe-4ebc-6511-08d9e01362e5
X-MS-TrafficTypeDiagnostic: MN2PR13MB2590:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWzeXYRGbALLP2gpQMYcUkN1GiTyBwP4BBllKTsAqMJeSBlqLTgEu6YY+CZCeT6mtPYq7TxrFVhVLphgKxIVhpv/kFNhgZVLvazroVr5CrWLZ4eqTylfVYuINUWFvDF69ljvmFA5640gIg384ZiCVkLJjGIiuQRDdGdPjPo0kZDGeP8I9btgQn+pywNwHzo8TiQiPabOAG+aIDixsmz/VcDpanwOgZLZN8Rm7MX3SWn+V0cxmhek9OrsYqozyBC0unNW/zteFzE9LIDIYKCb7i+cGVGexAe8p6280CQOjKPUCWArjXRookYH2YpahEmxooAtXegJHZOIOV/MdPkR5KdqavYtiqNN7/801FTXGPC0ERl5ex0ZtDFtPBQi/M2e4CN/1bT/pQgbaY9b0+r3MjKXoYxEzHhNVZoWCo6L1cTX04oktna2kanK5ZIaMBgcWGUTPVlkAXq6KCaG87DqgKXI9H03as88CMF3DYRyEOxqkSmCuEolbZhB1V6r7HU0HmT0caGgWrWWXhi0y4b1L2Nq3adjqIevRRkrsfStcjWFSmyitSache450Tkh6G9E
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gp7qtKx+PGXsXmGuya4oiJun2w2+vk2wUd9tcwblFUJcRnlLLsaj3L1XphAb?=
 =?us-ascii?Q?s23PyfrMAXWI6GCOxK94rwlM9nh7+dYbdzmfCrikzG4u9iKM96XdOb6QZRyW?=
 =?us-ascii?Q?6Fyq/8gXgjP3PhaFzlU8psHf3tkheHrVs0zvzJpBsqezfzXAm+banqM1SAhN?=
 =?us-ascii?Q?9H97h0+ZI+oc5W6M03j6/2d7UkfZVvBFL8YedFaUidacslE2Rmk8Rp6XE0Lc?=
 =?us-ascii?Q?QLK8SJ2niUWQzJSMYEuZUIg2AxlT7lG2Qn2VZ5ExjcglNNHF+d4T2LNveIHA?=
 =?us-ascii?Q?V1AFs65vSn4v9V++CKa/CC5g01HAraSMUErkIJ60+bUVMHXL1LIja4ZdLMEK?=
 =?us-ascii?Q?zBNo4WTDPba33S7EjfwVmoo9Ko7BnFK8gqXX37Q2ikoLogwsEXdSCGMBVc2N?=
 =?us-ascii?Q?DpRCMKnpQUKBvO1sQqb5rfB5LMqwprmtRbcCguq4wumUPGanSu25BQAPG5ea?=
 =?us-ascii?Q?hTsQAZJLxZ7reKxXGclC90HWqldRWrzgwu2RYh5FLXc225FgIshGJrtiqy82?=
 =?us-ascii?Q?q7tBifzjGuRM/3C5/R8hphuZO1LbfldgN67gCs6DWXOfhf97LPVSw+rU50cD?=
 =?us-ascii?Q?NvpyKJRaYCNi2DStj+5yk55FJUmagprYqyW0AryCH3fxU97oZTESvPoMWYNv?=
 =?us-ascii?Q?tt9LNslrtsseJcoDKP7EU/SZ4u+bWfF9Eu2KQ9C6o4Y5qYPSN/XTBFfn2rJU?=
 =?us-ascii?Q?aKJUp1O/5qrPa3FFVM05SESU0DjiQk7qtC5Ml7Moog+il9Ahl1b7gYrJBrFX?=
 =?us-ascii?Q?hxceAozWT7w+2lcEQCsqVjE8ehlVz4neP0pG1CV/oTKrFE1lQQDjzhW9CZLk?=
 =?us-ascii?Q?wxbjAZ7jk2uKNEpy/tAUuQrP1IbxYANgE7ppFWPcEO4swP9HrjVjPxHaR3aQ?=
 =?us-ascii?Q?U/NdscT5ZD4JFkO3ej4tgKxK8yIcJ8NL4mLF+Ga8QIMs8A8XC4LtugED0m0a?=
 =?us-ascii?Q?/1zhHnJ15bEefut3udZaXQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abded08-effe-4ebc-6511-08d9e01362e5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:00:12.1274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2590
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_070020_972908_5E07D3B5 
X-CRM114-Status: UNSURE (   9.84  )
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

From: Martin Belanger <martin.belanger@dell.com>

TP8010 defines the Central Discovery Controller (CDC). To tell a CDC
apart from a DDC (Direct Discovery Controller), the Identify response
now carries a Discovery Controller Type (dctype) attribute.

TP8010 also defines a new Discovery Information Management (DIM) PDU
which is used to perform explicit registration with CDCs and DDCs.
This new PDU carries extra information such as the Entity Name (ENAME),
the Entity Version (EVER), the Symbolic Name, etc.

This set of patches adds support for TP8010 by exposing the dctype
through the sysfs. It also adds the following two new configuration
parameters:

1) "register" - This is used to tell the kernel that the user
wants to perform explicit registration using the DIM PDU. Without
this, the driver will operate as it did before.

2) "hostsymname" - This is used to specify an optional Symbolic Name.

Martin Belanger (4):
  nvme-fabrics: add discovery controller type
  nvme: add host symbolic name
  nvme-fabrics: add tp8010 support
  nvme-fabrics: add explicit deregistration on disconnect.

 drivers/nvme/host/core.c    |  17 +++
 drivers/nvme/host/fabrics.c | 181 +++++++++++++++++++++++-
 drivers/nvme/host/fabrics.h |  11 ++
 drivers/nvme/host/nvme.h    |   2 +
 drivers/nvme/host/tcp.c     |  61 +++++++-
 include/linux/nvme.h        | 267 ++++++++++++++++++++++++++++++++++--
 6 files changed, 524 insertions(+), 15 deletions(-)

-- 
2.34.1


