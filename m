Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F7CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 09:28:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A432B61874
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 09:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A432B61874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ogNEFwmmshoLZUDCoYUcmpyMfVAP/5v9BCvdkH3fqaI=; b=Zb7tM8dYoaclD7swzzHcKs3eq
	zJ+dcwHP8k+lxJPzPyBZNXS+HYeA+XuOQ/doB7V9+s0JKDrjRIsdFHSab6R96Yc+XLJYd4gEPoj0l
	f0+czXVyyX4L+hfn584qWCuUrJZkkQEsla4+rozLQLNmahZLkNp+TLL5Bt5IuV7Eq1mwDSIhC1ceK
	ggYVdv4EHr6hneLNwgl5c35F34XD4XrOmF8cL/R0U1MVIKCERJz6hVt6jUlrPC5C9LO4dSPpnetZo
	v9MsqLevezqqysqmOSbYBNMKYebME/FecJRsQeLeqRAzTc+hlwTwwW2Yu7JdNeyYfI1zb2RitVwDQ
	grPn5qoUQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRX9K-0068c5-LF; Wed, 31 Mar 2021 09:28:30 +0000
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com
 ([40.107.100.87] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRX9C-0068W8-6U
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 09:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFvYFNvzx1zEqJl1L0R7SrQ8jYu/cxpWg6Jl2poj4bERL1cSTIFHFCIl1Q2laimIvc6QcAPz3vUvLfaE/0y3Q8vw5+4qbDsjF4dTBfH7dCA9Yj36qHRMlZL46kBxkFXSwzHLPbUFdAn3KCf7KT0CuG1Tgbu9bKreG7usRklWNjKQ+kQQlNqlMWvwvZikfgr4kgmECaQYh7rb8f9nfC/ibt9XkEZh1EZZaQgr6yiFbQ+5fTTPXg1JK+bcT3M7IJWGUQREZdDSdHWArWmolbLvZm8LqO+JjJ+Q+BTrNhFFB6E9OK6yjgs27O0gyzTKRC9+aUKHy4am2uvk9e0wa6B3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4+DL2CkHDIdjI9TbK9qMmuzBLorr5V7RXt2pl78yac=;
 b=XboFPZvcX/0FBqz5ydBkw40hn7aA/MpF/Dpems06pQQ18dwZyC/r4w+Uj0QYi6my/AGkGri+9MEGQY3v5dRDI1634ybvNCurL0McDonZ73ZwQKIRdETnLdoNy/66KOTnAJqatqT1qLdLirI0j7tZWi6LAcYqPvJmcu9MsmFvHnySbEeo+MyQSwvUNgStVpgJGViVayKVZs0E5zIgWdFvstVUSrgNHY7thPprPUumBNu75f+LoZVA+CHG62EqFgjbsgIex8NfoP3Sdr2cgIdP9lHzP27HVmNMFqxkIq4o+4DrFmqAd6Dls7BZMjSR8FSQftHmS/N0zby0e28yNwFFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4+DL2CkHDIdjI9TbK9qMmuzBLorr5V7RXt2pl78yac=;
 b=BvA0JzkLORW9OS76DGNfXDVIFzrC0u90D0oYTJR/4H6wzNLGeEnh//YOngBEjuRT+iIU3sphLeGc6gi5GPMHyvk1H+TDky9xVjyS2LF+L4zb7OTuPiESwnFKZgx6cY2S7Lg3qLuOmzIibCk4rcL61ex39qCT2lhGuiGyEROWc7q5Cq3CpWf816c7Ok1gtZunlM5ChRdF+rV/ax6pc8rCZ40AiSSNPW50SxOgmi5uMP4KsC4WQmjWo91xrqi8QUWa3lBgie4l5glPJrizN7GanKqtCN8EMKYmpm10VGlxx0l42sxt8gcqmEhtOzPHB5pmArmc/PytPnISeeIw+X9/XA==
Received: from DM6PR07CA0064.namprd07.prod.outlook.com (2603:10b6:5:74::41) by
 BYAPR12MB3317.namprd12.prod.outlook.com (2603:10b6:a03:d8::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Wed, 31 Mar 2021 09:28:19 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::7) by DM6PR07CA0064.outlook.office365.com
 (2603:10b6:5:74::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Wed, 31 Mar 2021 09:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 09:28:19 +0000
Received: from [172.27.14.204] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 09:28:17 +0000
Subject: Re: [PATCH 2/2] nvme-fc: check sgl supported by target
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "jsmart2021@gmail.com"
 <jsmart2021@gmail.com>
References: <20210330230120.268671-1-mgurtovoy@nvidia.com>
 <20210330230120.268671-2-mgurtovoy@nvidia.com>
 <BYAPR04MB496516848BF2ECE9FAEB32D7867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <11f750f1-c805-7d6b-b8cf-d713f918f61e@nvidia.com>
Date: Wed, 31 Mar 2021 12:28:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496516848BF2ECE9FAEB32D7867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4380a2b-8b88-4019-728a-08d8f4275258
X-MS-TrafficTypeDiagnostic: BYAPR12MB3317:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3317F8D15111FA4EE107E4EFDE7C9@BYAPR12MB3317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntUNqZyJWWlh8A4iTI2y9QTv8gN5631bIb+zEcSmKzbvEHzzGLTDfJkykzM4NapV5dJOKkHxZOzI2+N5bfe3R2kFk5JHt8d0kf07tavh4QaxBz3nKTG1AxqjH0XXXZj1kBBerLD3tF32HvkqwaDrL1OeN2WT/6UZc1ErQujXN6G/Z4SHDc8f7WJx22Q7TBqnd9n7VLl0rfmJnGn30tUtNGxJr4eksq4Eski1eiXfc6g3D5wuUh0wJ7v18bFsEdiN78YCCUGoP0WeJzg2/ONnNAb31svjrtIaOTbip4j7CPXW3RR/Sx5pOr4ANpUoS08YJ1H6XrZIdu+lGHh4dOCCe6Ob8aYaQ5OLu2JMbWIgygv/EBySolQZyjCtNHihktcUcx8lvfmrG+w5hqFTUcKTJDoT2g0BLK7XXd9dl0D8UNXSLeA04uPPT9heYiRLNHpc7obYT7fr+0iCy25YZNOGBciCUJPP/5Px9E5I0KPLqNtdhHcG1g3+id42RQ+BRpMk/jkWFUIeXX6qS4qydIM46YxBCMAP9x9L5tuODsLbEjwAHt7KKhi9wyF+NaRM9VvvSmqTP+JzK3iKqElfN35UMlvXokUwSoiQ0A4gL4e3m0m2U2QqSY3XkAjBwRHS+FqO4WLcV3qXID7zFw0y5brV0CMI5cG4SVkvgZPtVP7PFWtVMbU7gVEaIyeaO4T+lLYX
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(8676002)(2906002)(8936002)(4744005)(5660300002)(70206006)(16526019)(82310400003)(110136005)(2616005)(36906005)(86362001)(31686004)(16576012)(82740400003)(31696002)(478600001)(6666004)(47076005)(356005)(336012)(83380400001)(36860700001)(426003)(53546011)(7636003)(70586007)(36756003)(316002)(186003)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 09:28:19.4335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4380a2b-8b88-4019-728a-08d8f4275258
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3317
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_102824_905312_5977D946 
X-CRM114-Status: GOOD (  10.21  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/31/2021 2:42 AM, Chaitanya Kulkarni wrote:
> On 3/30/21 16:01, Max Gurtovoy wrote:
>> SGLs support is mandatory for NVMe/tcp, make sure that the target is
>> aligned to the specification.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> s/"NVMe/tcp"/"NVMe-FC"/ ? if so that can be done by at the time of
> applying the patch, if not just ignore this comment.

Good catch. Yes, this should be updated.

Thanks.

>
> Looks good.
>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
