Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71363C32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 10:38:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411A520673
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 10:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U1eu6zK3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="JWHjHHZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411A520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eLhskOmb0dPpAVHRNDKr/dWLYc5pUxlNUha3zksM1x8=; b=U1eu6zK3RZTIE6IYgkqAfDR7f
	jfjzwNfduES1ThRG3CwyQF/sU6Kqp1XucLIUAIyct8l5c0wDVzAXEYCQJMzfKThRKsEJHTumJY8/z
	HOfOI2JxTqWza5iarIatXEL91qX/GOe3DQX643Gm8u44V1NaMDDW/irphTvAc/IlIC1JgziNEzCMg
	HYd14sD98+TsAJ8HTeR6uS9PD/a3U9/kFQnHEPQA9FdKVyCCcwoSCA+MEGL39LTQjP1T4wa7leN1q
	P8DpCzFbZSF7Mcb05P73NObmtcwoCnkfPBGSD5zWH8VzWWsy0Qhvlfg7fG2DHOvcVO27Anzv/fCcG
	qooEunmaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipVCg-0002pa-KY; Thu, 09 Jan 2020 10:38:14 +0000
Received: from mail-am6eur05on2041.outbound.protection.outlook.com
 ([40.107.22.41] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipVCd-0002mX-Ss
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 10:38:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS0PFX0mDejalsyIkn/mJIurRjtfkXyb0wb/sWI51Bf7RxufDJ19D3RyAZ5O4AA0OLwZYZMtGMiYM1AWY9+niksA2FiH+5eYyv0uqkiRDp47j6E4CsBM5PEnExp6pjKiv9VdUcBrl4utAh7LhI32dLf+canuRciez9urexRwXqGzyKZg2LWPlWdp4Fbo93JNrQ+LXwoa03QG+ObbrRVMW9eKlbDW6M+ucAJ+64id6QPu0qkN3zXCJvrMeHUl/O7ZoeAdICZ/4HVslHdXNszgnH4b8+kaFGnj4G+j1jWNkOW9reco89AiGQYh/Z5iEHMZq2vTl/d+EoBQ6qnF4lT1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf5YV1/HaYu0J5hyfMgVekleIr7hFZqMucG+EuP1WVk=;
 b=ZuY8VPO5AmLi2PB8jH3HlbEJLCkBGqtsOz/fJmH+IPL6+38cjaHyGJUa/yRPud5YOwQqETBgI1/YqYotdyy7s1Z+8cfYJ1gaSZuPA2Ai5eW+H0mLrC5uvY1k60o4aiislnpW9Ojx6FtqpDGTzG2FU8V6K/ibFfbIsWPMOZEyA1S9YdZik9YoOwUMBOiZR5mBsuAOcnEhaTmhsY2RmKBRWCepdRZrPrrt7KeOUytsb9XvC52SMdfM+PU1gRYNlgzHIkPpwusWl1CgLEujyYc5/R6xKAuC9y9RJ7tTh2CfINFs9V3zE+qf38wKu7z5ZyAAZJtWplkcZ0+Mp52Gp3m/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf5YV1/HaYu0J5hyfMgVekleIr7hFZqMucG+EuP1WVk=;
 b=JWHjHHZwm/95OOvCqyLjvUEYJ386xdfX1ed5U5z/litkk1Y7F99fzxwYoECSyTk2Mvq6rs/beUyo8J+PgoDgw2K1u8o8PNYadK5kPzp7sYQFb5z4I1vxZe+M44pxXPiKeg+bKNSHWIJtSFqvE+1PV3MyzJxDLU//klO6Kmw5+Zk=
Received: from AM0PR05CA0076.eurprd05.prod.outlook.com (2603:10a6:208:136::16)
 by DB7PR05MB6169.eurprd05.prod.outlook.com (2603:10a6:10:81::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10; Thu, 9 Jan
 2020 10:38:08 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by AM0PR05CA0076.outlook.office365.com
 (2603:10a6:208:136::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Thu, 9 Jan 2020 10:38:08 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2602.11 via Frontend Transport; Thu, 9 Jan 2020 10:38:08 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 9 Jan 2020 12:38:07
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 9 Jan 2020 12:38:07 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 9 Jan 2020 12:38:05
 +0200
Subject: Re: [PATCH 01/15] nvme: Introduce namespace features flag
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-3-maxg@mellanox.com> <yq1imllz5l4.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <87553ee2-74f4-8eb9-dd07-552f2637dab8@mellanox.com>
Date: Thu, 9 Jan 2020 12:38:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <yq1imllz5l4.fsf@oracle.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(107886003)(336012)(5660300002)(36756003)(70206006)(2906002)(4326008)(53546011)(6916009)(356004)(16526019)(54906003)(16576012)(8676002)(70586007)(31686004)(86362001)(186003)(81166006)(81156014)(8936002)(36906005)(316002)(2616005)(31696002)(478600001)(4744005)(26005)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR05MB6169; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b572f681-92e8-4e1c-eb44-08d794f00490
X-MS-TrafficTypeDiagnostic: DB7PR05MB6169:
X-Microsoft-Antispam-PRVS: <DB7PR05MB6169561107A1EE6069E3D36AB6390@DB7PR05MB6169.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ev7y5Qe/NJxLlXSE4mR7mtLKwuifmiDK5tHt54YhRqu7UlT6Uf6me8odLktClYMFHphMm7JkA6oFa0INKLF2Xxw6WeGJ3HVrBamBuqil6lxkjF0KK4ijnlUkv/GZHqukZqMxNzMo8emmj7RIlB5mCryo40vsn+U6L7Xc5Ez7LGzBAhK5Gn2XFtJY1VxM2xzkqpqJ4WBllprpBnqDKLmmtL6O9X4k0F6DPO02g8GjJGxs66McshuiLKHSvaKyd8bz9bDMm9tD8Jske6Nh2hDhXFusFQajKoZNztfIgftSLBXNMiRDTiSM/rOR/1WaKOu8OOAWLM2CnWbChTp2h7Zm5aweov2toTy2wcohWdxlRLowNAOe+J4RHiEd7zd0M5gUy5g0KYGss+RvOoq9jyfJTRJtqVhiKt0RZrPg+9yetnTR5werKy67VY2dkp775Lc8tA6DpcPkniAL5dhmiLDSYrZ5tFYd8stVgfoKxlKvVv8+Kg2Fyny3tHrebaMImnIA
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 10:38:08.4241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b572f681-92e8-4e1c-eb44-08d794f00490
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB6169
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200109_023812_031070_FBD61F22 
X-CRM114-Status: UNSURE (   9.77  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, vladimirk@mellanox.com,
 shlomin@mellanox.com, israelr@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/9/2020 5:11 AM, Martin K. Petersen wrote:
> Max,
>
>> +#define NVME_NS_DIX_SUPPORTED	(1 << 1)
>> +#define NVME_NS_DIF_SUPPORTED	(1 << 2)
> Not so keen on the DIF/DIX terminology in this context.

Martin,

how about:

+#define NVME_NS_PI_HOST_SUPPORTED (1 << 1)
+#define NVME_NS_PI_CTRL_SUPPORTED (1 << 2)

>
> DIF as a term was obsoleted long ago in T10. The proper term is
> Protection Information which you also use throughout these changes. We
> have lots of DIF references in the kernel for hysterical raisins. But
> let's not create new ones.
>
> DIX is a spec I wrote to describe how controllers could exchange T10
> Protection Information with a host. It's specific to SCSI and although
> DIX is referenced in the NVMe spec, it would not be accurate to describe
> the NVMe features using the term DIX.
>
> So I'm in agreement with Keith that this should be named using more
> descriptive terms such as NVME_NS_PI, NVME_NS_CONTIGUOUS_PI,
> NVME_NS_SEPARATE_PI, or similar.
>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
