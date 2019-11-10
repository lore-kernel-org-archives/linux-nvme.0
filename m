Return-Path: <SRS0=U9tF=ZC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59599C43331
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 09:25:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E4D207FA
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 09:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PPY6SXom";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ahl5hNEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E4D207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ttSpBx0uCqeggjW01MOOHOtNhQ8tINEXTFJE1niJZYQ=; b=PPY6SXomGBuULqlt4jWwFBXAH
	2yReIT5SNQ+GcwzZ5sHuSejgsmHjjiXPIuifvfX4KPavrXt7Bm9JrxgU4DZXTdbs6CoGnU+XnRgut
	0L5kHtOsc+9FEFx4Yf27x6BQe418MsXVC4VBE896R26gNjcr/qcjCqmf620ZYVJf5UPmihK1Zq1ZB
	j+apnSOWr2FId2keydUDUR6CIRxe4yY3PvE7txbHvB2PJAejA2/kUOgnQXBSAvmHvZE847E8lrVbP
	aHPq6Rbrq68U2ZUIpNECD+pzAHeyx7sV5JF74BEP96Op0G3HypITqI3GfLtpfeE/xItLXvOuGQ77a
	zBpFpmmhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iTjTJ-0005Ho-9r; Sun, 10 Nov 2019 09:25:25 +0000
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTjTF-0005HJ-SH
 for linux-nvme@lists.infradead.org; Sun, 10 Nov 2019 09:25:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGxEvbsUiKTd3zBf6DcNBWgP3i2gpzAC4k5KE6ExZiuHHTPsAwNbItRQvAMpNGcituEBYIu0jk33Ey0E8ARN6NYNbkZvaFZp8G9SOHKkW2x1u7S2oGYoY1ev3kL8qMGZnnGwybzZdtgPk5i0ny9+n+hfLonOW1xRdjOEJEGN0y9BjgOGm4yeePidsIgz3yz/ThacKRlmSDwA3R2roq7pJx7JkUl5tp2ijl65s6/20a6fuKt+WEUisLQABdExLPjzfX54JbCEcpJw2RsTbHB/Ofwqyku5BButengQRFy3Jr9jVPiUSiZe5tTzkTKA3NARzVzK9W9wfrTSJfdzKKDoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j5KjHj3Q4fGYmQtEeLol9sH7U9LqTEWUy1jdC1zD+Y=;
 b=gyEPlGHUsWNpvhzKsiF0qNsjj/oPRGaxyIWQk0ak6XN4IVEnHrle7958bgyEu8Ch0izwjH4v225hIIBAqehaRTOqAAa384JffJyT5BGKzx90hWzsn678C56L67frm9zO0757uoojdoN5FpIcsjDrc/Xd/4MTfSlgStAHTHmxSJqkYiuH7INwUAApxX4dnXEuE24hi4+P383GOOKNrnJ2msiL4/IRM81bix+tdnhozPnDxD/jUX6tmkdkouGshZmls9n9xR8YHgyrC5PhHMVOfJJZBfyGRC65ZOcaDm9bF33pw9nILnCD8MowrEBwcFDClXmsvoYhagyrDN8wwLisvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j5KjHj3Q4fGYmQtEeLol9sH7U9LqTEWUy1jdC1zD+Y=;
 b=Ahl5hNExLgGSg7PL3UHLmMmqs/WgUpA63Z0341a7rFgLdqy6ye8yqSLGU3eXaVZLuA/f53pXf7It5Jx+ZSzXDOcfdWwfQq83WOMyMO8O05UOtG5zEqDv++hkvBWEW7POSJI6r+GF/QtMvlp60Fka+wRnDOhhdRpDPZW2okfIX+Y=
Received: from HE1PR05CA0376.eurprd05.prod.outlook.com (2603:10a6:7:94::35) by
 AM6PR05MB5317.eurprd05.prod.outlook.com (2603:10a6:20b:65::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Sun, 10 Nov 2019 09:25:14 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by HE1PR05CA0376.outlook.office365.com
 (2603:10a6:7:94::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Sun, 10 Nov 2019 09:25:14 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT018.mail.protection.outlook.com (10.152.20.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Sun, 10 Nov 2019 09:25:14 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 10 Nov 2019 11:25:13
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 10 Nov 2019 11:25:13 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 10 Nov 2019 11:20:32
 +0200
Subject: Re: [PATCH] nvme-cli/fabrics: Add pi_enable param to connect cmd
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-2-maxg@mellanox.com> <yq15zjwza2y.fsf@oracle.com>
 <ed926da1-1466-edbd-6fa3-fb828bf455cc@mellanox.com>
 <yq14kzdx182.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b3670fb4-7782-d4af-a9a5-c30b6d1db6f0@mellanox.com>
Date: Sun, 10 Nov 2019 11:25:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <yq14kzdx182.fsf@oracle.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39850400004)(396003)(78124002)(199004)(189003)(2486003)(76176011)(230700001)(305945005)(31686004)(106002)(23676004)(478600001)(7736002)(54906003)(16576012)(50466002)(316002)(36756003)(58126008)(81166006)(81156014)(6246003)(336012)(70206006)(70586007)(2906002)(6666004)(47776003)(126002)(3846002)(6116002)(356004)(446003)(86362001)(65806001)(65956001)(11346002)(31696002)(476003)(2616005)(8676002)(486006)(53546011)(5660300002)(4326008)(26005)(16526019)(186003)(14444005)(5024004)(229853002)(6916009)(8936002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5317; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f357e297-11bf-4ed2-eff5-08d765bfe4a7
X-MS-TrafficTypeDiagnostic: AM6PR05MB5317:
X-Microsoft-Antispam-PRVS: <AM6PR05MB5317DE7D880A832DCCE06E73B6750@AM6PR05MB5317.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02176E2458
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWIPJk6rmpaPDMhC6c3yJTAtRfCMP+Ys9ENzqJarapvHyytVxYH3yRNfcL/tFGai0Pm1tZObY5BbwryF/jO3xUMGCkfzJZbclwjDqk7K0yVYapjl5dccw8TkOXREl9ueAk1KBjVgokT/QczKERLIbQBpnBfxiky1Bdq1r1NU98kbwoMpg4mhDc8LN5EE+uMOh7uDSKrwgEUzn9crBHYls295nVB6m5H1xCWktdpg2fR0Y5avxR+xQj6YfrU/YONrlNweD+WroCoILm0Su4dsxJlsIXR6S4SK/3+yXU2qcxx/dRCCTI53wkGcz+XaASzzswRQzFlrD67kYva46xXLRC1/F5sDWvvwsT7+zOM+82jvQJVlEAQjo5ZFf8HDtoXyIzQwCSFmcMxLU4VeJxqdiEw6HwxaLHOmRO4Yfk/HSf3m91AZAtSEPDiXj+ggsOOP
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2019 09:25:14.3693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f357e297-11bf-4ed2-eff5-08d765bfe4a7
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5317
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191110_012521_992911_1F6665A6 
X-CRM114-Status: GOOD (  17.79  )
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/9/2019 3:55 AM, Martin K. Petersen wrote:
> Max,

Martin,


>
>> So iSER will create a signature resources for every capable device and
>> connection without giving the user the possibility to distinguish
>> between needed PI controllers and un-needed PI controllers.
>>
>> We don't have a format command in the fabrics so this is the best
>> option we can think of for adding flexibility to users.
>>
>> I spoke with Christoph about the module param possibility and we both
>> agreed it's not the way to go.
>>
>> Let me know if you have an idea that will enable flexibility to users.
> The way it works in SCSI is that if a user wants to enable PI, they do
> so when provision the device. So either a format for disk drives or by
> selecting an option while creating a LUN in a storage array management
> interface.
>
> There are some knobs that can be twiddled on the initiator side to
> enable/disable PI and/or DIX but these are meant for test or buggy
> device workaround purposes. Not as a means for the user to select or
> deselect the feature.
>
> The user can decide on a per-device basis whether the block layer should
> generate PI on write and verify on read. Those are the "proper" policy
> knobs on the initiator side.

The block layer option to enable/disable DIX is there, but there is no 
way to disable DIF (wire PI check and generation).

Fabric storage doesn't support formatting a LUN/Namespace so we need to 
give flexibility to users.

Why we need to enforce the usage of E2E PI for all the controllers if 
the user is not interested (because lack of resources for example) ?

Maybe the application has some kind of QOS, e.g. protected namespace is 
ClassA (expensive storage) and non-protected namespace is ClassB (cheap 
storage) and they both use NVMe/RDMA initiator...

For example, we do it for TOS feature.

>
> When an I/O request is received by the SCSI stack, we inspect it to
> determine whether we need to allocate one or two scatterlists. If the
> request has a bip attached, we'll allocate a separate scatterlist which
> is then used to map the protection information before the I/O is
> submitted to the device driver.

For an NVMe/RDMA controller we must allocate a pool of PI MRs in the 
constructor function in order to support E2E PI (and it's expensive).

We can't do it in queue_rq function. In queue_rq we get the needed MR 
according to the namespace format from a pre-allocated pool (PI_MR for 
PI_namespace and REGULAR_MR for REGULAR_namespace).

We can go with the module parameter approach but it will be very limited 
for users and wasteful.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
