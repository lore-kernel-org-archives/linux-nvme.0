Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9118CC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:18:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4040420786
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fx1GfNSm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fSGTLuEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4040420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/UqYoWw4CtqDqCCkP218dJj1GtX8HG1GmVEM4lOww+0=; b=fx1GfNSmEVRPYcvO4MqXdq6fq
	zAgDEKJo7BarpGjd76tdYgruoWDR+0WeLn9rvheEEsAYW2GOqlZ0yzI+d50MnJ+YzOaBTgBOHeUPk
	qG+FnlI+X7Q3y/RxK9U9DcaS4I4fS2DA9lnSiR5VaBs0I+JWLgxw2M31UXc/G5dWfLz9Bpl/hLW+v
	AYiFDmekkgrnlgxBBA8LM6j8O7fpxnkxdHXT230ucrVG/U1YABHpdn7Axxknke1pvr9oZZAzQdNPc
	icXuJN7bwiS0+rmHnz6x1kBK0wqMOUD0Klak35nBETKH/tcxiynniKunKfHTDDdM81xCMV9V4QwCE
	j6DQkKzzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJaU-0004nU-V5; Tue, 31 Mar 2020 16:18:02 +0000
Received: from mail-vi1eur05on2065.outbound.protection.outlook.com
 ([40.107.21.65] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJZw-0004Hl-J1
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:17:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz87L70jv0JeVV/qggGp0CyH1+fqavw1e5aGcjOs+dKNAmVz0px80HfxtrQHHd4PXJNWOBiCkf5pcXz5AmclAXKKEF9ZnYon1a7kFNz2aPf8PEulQCrg/0DiBfnhuRvW+eulBISuaYz2q/UVVZQr3xwL2wvn3XAKApzHjYqRcvAmHirwlHyQ8y5yRDSrwWlgx0+YOr7WuH/eA5fm0ba77kX6uXsxxIfFCV1Zd0lHg6yLjOS4a9myHxjcxDQ7iEueJh1eckyMM0gEDMRFFe0IDgtBZqoyWN6/7I5HpEFDiITGXa0ZzgW/AgY/AxwzynOdBiUVIZnfgbz1iqnbZCiQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8vocpwFgU1t2tk3ZCmr+t3ZTR3KRUE2PzDy9XTU7ic=;
 b=VhQ6Nni3l7N0rdZ+C9ck945kO1Jb7P0x6jCbcKMJcyBua1uh5aZIOuFrpvhXw/9xkMOJwEmvPLlzUgpV+kcVnmMYngWBz4mtLSjIRBUxBJdFswG+KHGedBL6ztQr05ig09PxkZ1cxDQzpOjHakDcoqAfESMpGmFN2uuGmNR26OEdw9ZgCG+SZuv6fDJ3s89C6Bt2HIiizlTQBLwRg3spOCylsMPXO9cY3ZOOeBF5dytHkepV+WqyB0Z+Hz1fJtbS5hXdzQEYUZuj5wWdI87OplRYl6bvEbTx3g0RKt2JZiqbKnVjRNR8hbMqiOkpYpJqxknNgp6RY9X2FeeQSljiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=acm.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8vocpwFgU1t2tk3ZCmr+t3ZTR3KRUE2PzDy9XTU7ic=;
 b=fSGTLuEb7rnkU3YHkQv/5wRFd1ArMsqHCIYK5Zv7R7UMSUy3hsTEyQw01nb28wsG+ggEIuAeEqIFBV8yjMpRIhdRMrnqpoAdpcP/ZN3SXLjqns8cujdia4ul2I+vV071/mfXZfSDiNsRXKNPtR+yvqqA0ceY6FEyQnQY/L4yIls=
Received: from DB7PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:10:36::26)
 by AM0PR05MB6771.eurprd05.prod.outlook.com (2603:10a6:20b:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 14:43:15 +0000
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::77) by DB7PR05CA0013.outlook.office365.com
 (2603:10a6:10:36::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Tue, 31 Mar 2020 14:43:15 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Tue, 31 Mar 2020 14:43:14 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 31 Mar 2020 17:43:13
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 31 Mar 2020 17:43:13 +0300
Received: from [172.27.15.103] (172.27.15.103) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 31 Mar 2020 17:43:12 +0300
Subject: Re: [PATCH v4 1/1] nvmet-rdma: use SRQ per completion vector
From: Max Gurtovoy <maxg@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <kbusch@kernel.org>, <hch@lst.de>
References: <20200326181512.58053-1-maxg@mellanox.com>
 <80ff5951-caad-1130-43d4-6239b9f6a143@grimberg.me>
 <6149129e-eacb-7b16-0540-13166dc10e8e@mellanox.com>
Message-ID: <9ce666b9-d4c1-ecff-36e3-d20ea8e3fe0e@mellanox.com>
Date: Tue, 31 Mar 2020 17:43:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6149129e-eacb-7b16-0540-13166dc10e8e@mellanox.com>
Content-Language: en-US
X-Originating-IP: [172.27.15.103]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966005)(5660300002)(70206006)(54906003)(16576012)(110136005)(31696002)(86362001)(26005)(82740400003)(186003)(81156014)(70586007)(8676002)(336012)(316002)(47076004)(31686004)(2616005)(8936002)(16526019)(558084003)(36756003)(2906002)(478600001)(4326008)(81166006)(356004)(3940600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ab580b-4c21-4175-5358-08d7d581d819
X-MS-TrafficTypeDiagnostic: AM0PR05MB6771:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6771235E1E9CFF7DF78F3CF1B6C80@AM0PR05MB6771.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0359162B6D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCwOBHUjy7z38Il69AFDdcGPsQMtju0cf2CNn4SJpda9cZ1q7iTQRPvvrE5bFrKmiQqZqPKJ/k633FYunxG70w2pnoKMC2yigwMWKcqmKnwzVgvX9O/z6UNQYjYU63XtYEEOb+q5vm+uvjePYW40Z03Y4AxgfxZ4xZARm/S7YOqRq2oe2dJupKmnRflh9OyneP8r0db//PsL/ArCkWls7h10ZkqRSo9rVr9yI1WF0KzF6QtAoGz+jeFq0+Fdnx2uQNdsUkgJSqOCZQTA7f2803a94Ac7YkgbnFUv5Ntlvkur0RwKT660OFz+srFU2ZOgj8sxwnI1D/v83zhBpVKdZOsXEr0IYLRfjdgXunbtigbF18wKlpDVOxlOwN2rkkJod7ZyR1En99fWaBoxUdQF/6wxiEYx+EvwO2bb+uyC3Mo/u5BWYrKZq8Xj1Y4j8JhjAJ6TDT6Q8AaELR2wgVHI7ivl85Ws3zg2GD/w+YaQvJi4JvZji33LmeOay/vP2qaOlRO8MRiXHF9cet0zIj+s/i+kWMfoPVZE2Ivj0qkXhwM=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 14:43:14.7288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ab580b-4c21-4175-5358-08d7d581d819
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6771
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_091728_710353_1B9684EE 
X-CRM114-Status: UNSURE (   6.95  )
X-CRM114-Notice: Please train this message.
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
Cc: shlomin@mellanox.com, jgg@mellanox.com, bvanassche@acm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi/Christoph,

>
>
>>
>> Other than that, looks good Max,
>>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
Can this be merged to 5.7 and we'll progress merging T10 support to 5.8 ?



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
