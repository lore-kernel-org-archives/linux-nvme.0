Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E2CA9EB5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 14:05:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB20218BA
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 14:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NNoItrUW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rpEy82Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB20218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F2C+RJRi+HRkwOwn04i5dMMzEuvfOFsGQoJ1CzzQz58=; b=NNoItrUWgzaxmpS+olmA5CqwB
	y2crZlvuIPFwna5/9+pp8DqBr8nyZPrja6/KharfTHX6yoJTt6WLjOBT4zMUVnFs967i5kNboU2kP
	boMQ/wZoJjq7O5LqKecl5v2EgN3cnL2hI3ENsFcbhz1bj8kRVVACQ50FsMfJ0QAzJVSZEX+usCAlG
	QFRAo5MVW7fd6olCfm48//v2UxrinCI+d5j66srsjulENbqX/DazLTb6siU6Iv6fV0Zz1ThVQY0GI
	kpky2tjhVjV96XwWFHbKR4QVM94+sQBXSgeKZrnG8jDlTTkJd4TfEn0NElcCLx+YNiQnJLvtHHO9/
	lTw85QFJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRcyZ-0007LY-Rl; Mon, 04 Nov 2019 14:04:59 +0000
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRcyU-0007EM-5s
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 14:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adt4YEaI1Iuae4ARIvFZv+nx/cs3/6bZLSJGCLmNrjtNzVYpskkUS0ornzaHxrfuZ/Y432rBQh6kJLqTvHpD16DhlzhrV9U4wsUOUw6oJkIqasrtcEjVTPopZDkwPsrdCl3X9ncfnc0Uaqqt5cgdt6aksqpyCPARKiHRoxraZnVYSiUmdnRR8vXGWwHbilrwGNZ022XaX33SA9T642RSwHSOUdP4me3A1hgCheXkhWSepNwn0MEsedlSUNEwj58IMixcx7NThHFo1A2Oh79L0HzO6lsEMAYcEkoOz6H+RQd2eOY6+DfxlBYxVQWoTGOuF0RkeCF0LiiWx0f6jdUwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsRrDWs+mWHWZRyLqI2m+sIRwkulJFhd/PkA7JdW1Lo=;
 b=InX5wNv3gOEY/AcTryxM9LL1PcqE/3N4WeSAP//rFKAmRFptifczGiQqClGaSORybkUeFTo0WG9CNSTWUsNHlpjzQg8FjbhxwX4ziUvy7G2+wBMzoS4BX5YiBWDzt0sJ46zWeA3TrK3DoTz4gDEm0J58vs4dEsFTsizh7fF2Z9HQ0VtH190ZwqJEmbBysPZRrtTineTbyO9zHoCmBWu+jyOokMvyHeL4C7q8bXjMkbQfJkNoCrc2Xa0WDJOp5KWHZlb+1h+EGU8f5KfdDwtai+qTR2c2Dqc1VQRirJQaw9ujcE4NHsG4gyjYZGCIzewe75+tp1jBsRmOCIg2B7s0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsRrDWs+mWHWZRyLqI2m+sIRwkulJFhd/PkA7JdW1Lo=;
 b=rpEy82EzHu5CY4clTQOuhdBN1TVcV+QKIsduuBNNyYxyjl9dZoYeHILUHctafhtgu0fam7zmyBENa0xXCpWhNnB9iMmPZoNWE2Cjzin1wi82p3X9kfb8qGWJu3ZC6kxUVFs8LrpxcN/deybS41QoJMi5kfvQPnNMDqyvzLR1WrQ=
Received: from DB7PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:10:36::15)
 by DB7PR05MB5035.eurprd05.prod.outlook.com (2603:10a6:10:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 14:04:49 +0000
Received: from VE1EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by DB7PR05CA0002.outlook.office365.com
 (2603:10a6:10:36::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 14:04:49 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT056.mail.protection.outlook.com (10.152.19.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Mon, 4 Nov 2019 14:04:49 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 4 Nov 2019 16:04:47
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 4 Nov 2019 16:04:47 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 4 Nov 2019 16:00:32
 +0200
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
To: Mark Ruijter <MRuijter@onestopsystems.com>, Chaitanya Kulkarni
 <chaitanya.kulkarni@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
References: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
 <409804f3-158b-cc3e-9b04-6499bfe1638d@mellanox.com>
 <3381ACB3-3ACC-4124-8925-09CED68BA11E@onestopsystems.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b79e612f-4b49-a80f-bc34-e672ae98c1af@mellanox.com>
Date: Mon, 4 Nov 2019 16:04:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3381ACB3-3ACC-4124-8925-09CED68BA11E@onestopsystems.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(47776003)(336012)(5660300002)(230700001)(3846002)(16526019)(6116002)(2616005)(476003)(186003)(126002)(16576012)(26005)(23676004)(76176011)(2906002)(316002)(7736002)(305945005)(58126008)(8936002)(36906005)(6246003)(31696002)(110136005)(4744005)(486006)(86362001)(106002)(70206006)(31686004)(2501003)(65806001)(65956001)(2486003)(8676002)(81156014)(81166006)(50466002)(229853002)(36756003)(11346002)(446003)(478600001)(53546011)(6666004)(356004)(70586007)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR05MB5035; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b2b8961-2cfa-4425-9029-08d7612ff4cf
X-MS-TrafficTypeDiagnostic: DB7PR05MB5035:
X-Microsoft-Antispam-PRVS: <DB7PR05MB50355A525866C24219864DC8B67F0@DB7PR05MB5035.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0211965D06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERdQaWF8pXluDWjjamp5zaamyZb8mB4q9iEmuGukHjRAnKTyZniJz4aURy1rh2kbJPjCTHIekviwDgsBu2F79cPAu+jgyuJfdL/i7iLjvjPjt4l/J29WXTZO4Il94LdFbURWa9NruURHxAlV3tx9vst5gRnnkGFGVwb7lB7Q5tLJRiGluaoodwbKnTN9nYTjrXC+bpF5xJXksKfEJK7LXG2Vv1QPbQjTG7DiqjkBVa2iOyiAv+7wIEA7hFnl3gb+DClJBnAURcEM87Z7wsbhrokjW5wHdChi7hAQ4qPEVKhIkltHFQ7LsbsYcJ80BSyIMA8sjbVsybqk7BLvJODvYEUk6qqAO+LdYDStgToYd4HdjQDOsG0JWlxj+fIt14KCqSdd2hyQKo1xIDYaWT83er/GTxlYWiNmMaohrpUmrq3sP04N23u62DrR7xiMyYOx
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 14:04:49.2903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2b8961-2cfa-4425-9029-08d7612ff4cf
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_060454_302537_FF786A59 
X-CRM114-Status: UNSURE (   8.98  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/4/2019 12:45 PM, Mark Ruijter wrote:
> Hi Max,
>
> When you create a HA cluster using two nodes exporting the same volume the controller IDs can collide.
>>> [1122789.054677] nvme nvme1: Duplicate cntlid 4 with nvme0, rejecting
> So the use case for this change is related to HA setups.
>
> Are you saying that the suggested solution to this problem would be to force the user to use the -D option?

can you try adding an address check to the condition (ctrl->opts->traddr)?

let me know if that helps.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
