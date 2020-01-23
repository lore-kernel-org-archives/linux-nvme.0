Return-Path: <SRS0=16Sh=3M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E79C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 14:23:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017F020663
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 14:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JMea8Aeh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KBXTR9L5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017F020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KMwYAb4wqaXyzNFJdfkdm6L9ueDLTNDx9sNFw8RYmOE=; b=JMea8AehGt0xCwYMJQJkVCQ18
	78xZxMGmpLynOcuAv+nqr3gLHPpzYvcdec7ER+ucDzY4ElmuQ/7M1z8cWYi08rXrsS62lnuf/Xmgw
	EQwAsOyslulSBsmAYa984rtaUG/LQ8kqrVuUWwCG1TfQCltCDh87TiGjsFHENvwp4Z0B/sv/9TSxH
	NhMINKZWHW1Nr2VWaoDHdqbAi2Nr4mZjvQOW9XUBW9LDD8H6LN49g1p/QkBbDEXavP0gSWWmr4cGc
	sCYRczYDg5Kb7P9tj9jO/hHIvp28swXFOOI9yNrOvFfo8C9lp8JGyUwbiJxcKaU3SsgZmkUMq50aD
	szusrPAmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iudOZ-0006gi-4V; Thu, 23 Jan 2020 14:23:43 +0000
Received: from mail-eopbgr130078.outbound.protection.outlook.com
 ([40.107.13.78] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iudOT-0006fP-RL
 for linux-nvme@lists.infradead.org; Thu, 23 Jan 2020 14:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQVmVuoxcGdKQpBCREseXx9BAQJKJ124NCeHKb9qU/b4vzWjiGwyYinhYrR2nMZn8NdL2LUlVfLyETWk1e0MUZVqGvuv78n6hG8smRKMQEd3ouRjBdtP58BHH55CtF9R0n08EwoZu/VOuWUvC+OOay87/hM4wFa9lHj7l4Hy4gwF85LMi0gsGSp0NE3X9uQmlRvM9BM9yayMO+zrgDSSQU41EwnXExICulC/XZ0JHXz+4ehA7/5v3UX5qHcm+XniigJqsv8Uek6rQn8USMiqrehdp0YgGw8Y0DbozACC80MkZ7PRKhCfgAPw4DcCW4E7pTrMWZIIjz10GkW/AFpj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKjmFb8YLNvgm+8EL7NzAAyX1G9e2hJsQHSXChVu1EU=;
 b=GD11Lh6sX2Tx0XHbdsIHdAriCodxTu6dTgD3irFktRnqHB3r6J/ysACL1xO5M5aEX+GTCqQkXXVYQYnNFPOTXwS5lqSogM8if87tLqYQzsyZTzGxbubHq/Qse/W7e82F9Uj7+2ENFpWAR+y3s3KpjgJgimey/fDaO9YY+2gs31YZsIL1HThe3XyYFKECYdRdAXupw0PM6W2IWnzF7Co1UGQewEL7e3KF4exozFR6oxPD2OMFROIhGukRkiqcJK155+164e7DkkFfSj43RALD5easY963i9uFBkyEqh7S2aSJmhhNbyISzttbmzBX/YykhehUG7vyUOvT5hYo/f9roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKjmFb8YLNvgm+8EL7NzAAyX1G9e2hJsQHSXChVu1EU=;
 b=KBXTR9L5dr6x7i1Wxh3DjAniDwD2M6b5b6fxCZ3Dc7h+ylLZ7XNq3J+5eiFxDe8gHOSVSNlH7WaZs3M3TcYDeH9PTsBCyydhjdOh6VjTCDyURInTwsFboYb+vmVydDsM7S2BUc3heTjbiABRYw8zkHO6lGySvRug51OGjQqKg70=
Received: from HE1PR05CA0236.eurprd05.prod.outlook.com (2603:10a6:3:fb::12) by
 DB8PR05MB5897.eurprd05.prod.outlook.com (2603:10a6:10:a5::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 23 Jan 2020 14:23:33 +0000
Received: from DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by HE1PR05CA0236.outlook.office365.com
 (2603:10a6:3:fb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Thu, 23 Jan 2020 14:23:33 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT044.mail.protection.outlook.com (10.152.21.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2665.18 via Frontend Transport; Thu, 23 Jan 2020 14:23:32 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 23 Jan 2020 16:23:31
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 23 Jan 2020 16:23:31 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 23 Jan 2020 16:23:30
 +0200
Subject: Re: [RFC PATCH 1/2] nvmet: add bdev-ns polling support
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
 <20191210062557.5171-2-chaitanya.kulkarni@wdc.com>
 <2c5f45ab-7ac1-b904-bc7b-1f272484b845@mellanox.com>
 <DM6PR04MB575431D7764F7D4BB98AFA5B860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <03494a32-b31a-432b-870d-7347f5cc9596@mellanox.com>
Date: Thu, 23 Jan 2020 16:23:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB575431D7764F7D4BB98AFA5B860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(53546011)(81156014)(31686004)(5660300002)(81166006)(30864003)(2906002)(356004)(8676002)(8936002)(316002)(336012)(110136005)(16576012)(16526019)(2616005)(186003)(26005)(478600001)(45080400002)(70206006)(70586007)(4326008)(966005)(36756003)(31696002)(86362001)(3940600001)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR05MB5897; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0896f954-4e22-4139-5ad0-08d7a00fd39b
X-MS-TrafficTypeDiagnostic: DB8PR05MB5897:
X-Microsoft-Antispam-PRVS: <DB8PR05MB5897C3FDF36C32C73A0815A3B60F0@DB8PR05MB5897.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 029174C036
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUzvCPPJ7IVPS6H82mcnhFnXCs2Nn2aYJ8Jdiz7nnUeykeMRBzbyR00/PwD3qxgPAoRmypU1A7IGxW9U3Lk3ONoXWe3ShIZVPyiBaMOkDWUkOVExGEvsZHJaZL80EQpPa6I+YCZmorV8pO1+AAtOnkdKP11MmUcDB6J+n/6hv5XY7N4yrlvTcgqyJ00NT5lNN8K3oDKbmvdkUXpGpJZ7wmDBYNxDDhQVgI2KWrnGo7dp1+/qOVKDyOECa270ZqyBAjJTu7f7mheJRGCI2pEw/bzkQ0hELriuT9BnpUT7T1lWKZj/ls9BySytJsHu4k0/UXwTm7/9Yc60RlEREOzW3qOdjotTdwhnaWg8x4FgFJZt+vzkpjIlBQy84Y9ntx2kfBF2dSI45EDczlb8k9z3MecfaduYBbR2pavf2Z2CoeVNBMV2qc+bCg1wcinlsy80qxGNl+erU5B6A7ZiloE2PIE5WW2rpSzU/urw7HxuXXAMM1TwLGOD7eEi4Ln9ve+kxH/4fzreLXTBVtHo9+732vYyHDgtGxBLhUzMmMpF7zl+hoaEkodpotbwZfnr2ILY
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2020 14:23:32.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0896f954-4e22-4139-5ad0-08d7a00fd39b
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5897
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200123_062338_314919_67730068 
X-CRM114-Status: GOOD (  19.35  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/21/2020 9:22 PM, Chaitanya Kulkarni wrote:
> Please see my in-line comments.
> On 01/20/2020 04:52 AM, Max Gurtovoy wrote:
>> On 12/10/2019 8:25 AM, Chaitanya Kulkarni wrote:
>>> This patch adds support for the bdev-ns polling. We also add a new
>>> file to keep polling code separate (io-poll.c). The newly added
>>> configfs attribute allows user to enable/disable polling.
>>>
>>> We only enable polling for the READ/WRITE operation based on support
>>> from bdev and and use_poll configfs attr.
>>>
>>> We configure polling per namespace. For each namespace we create
>>> polling threads. For general approach please have a look at the
>>> cover-letter of this patch-series.
>> It would be great to get some numbers here to learn about the trade-off
>> for this approach.
>>
>>
> Already posted these numbers with QEMU nvme-loop here :-
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fpipermail%2Flinux-nvme%2F2020-January%2F028692.html&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C9308e8badf9f41ec4faf08d79ea733ae%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C637152313279111655&amp;sdata=RM3%2FcVeRcp8hgyAUFIM%2B7wbZ0cw2xvhdsfcVp9FuPm4%3D&amp;reserved=0
>
> IOPS/BW:-
>
> Default:-
> read: IOPS=52.8k, BW=206MiB/s (216MB/s)(6188MiB/30001msec)
> read: IOPS=54.3k, BW=212MiB/s (223MB/s)(6369MiB/30001msec)
> read: IOPS=53.5k, BW=209MiB/s (219MB/s)(6274MiB/30001msec)
> Poll:-
> read: IOPS=68.4k, BW=267MiB/s (280MB/s)(8011MiB/30001msec)
> read: IOPS=69.3k, BW=271MiB/s (284MB/s)(8124MiB/30001msec)
> read: IOPS=69.4k, BW=271MiB/s (284MB/s)(8132MiB/30001msec)
>
> mpstat:-
> Default:-
> CPU %usr %nice |%sys| %iowait %irq %soft %steal %guest %gnice %idle
> ---------------------------------------------------------
> all 1.18 0.00 |60.14| 0.00 0.00 0.00 0.08 0.00 0.00 38.60
> ---------------------------------------------------------
> 0 0.00 0.00 | 32.00 |0.00 0.00 0.00 0.00 0.00 0.00 68.00
> 1 1.01 0.00 | 42.42 |0.00 0.00 0.00 0.00 0.00 0.00 56.57
> 2 1.01 0.00 | 57.58 |0.00 0.00 0.00 0.00 0.00 0.00 41.41
> 3 2.02 0.00 | 79.80 |0.00 0.00 0.00 0.00 0.00 0.00 18.18
> 4 1.01 0.00 | 63.64 |0.00 0.00 0.00 0.00 0.00 0.00 35.35
> 5 3.09 0.00 | 63.92 |0.00 0.00 0.00 0.00 0.00 0.00 32.99
> 6 2.02 0.00 | 75.76 |0.00 0.00 0.00 0.00 0.00 0.00 22.22
> 7 1.02 0.00 | 57.14 |0.00 0.00 0.00 0.00 0.00 0.00 41.84
> 8 0.00 0.00 | 67.01 |0.00 0.00 0.00 0.00 0.00 0.00 32.99
> 9 1.01 0.00 | 59.60 |0.00 0.00 0.00 0.00 0.00 0.00 39.39
> 10 1.02 0.00| 62.24 |0.00 0.00 0.00 0.00 0.00 0.00 36.73
> 11 1.02 0.00| 62.24 |0.00 0.00 0.00 0.00 0.00 0.00 36.73
>
> Poll:-
> CPU %usr %nice |%sys| %iowait %irq %soft %steal %guest %gnice %idle
> ---------------------------------------------------------
> all 1.08 0.00 98.08 0.00 0.00 0.00 0.08 0.00 0.00 0.75
> ---------------------------------------------------------
> 0 2.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 1.00
> 1 0.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 3.00
> 2 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 3 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 4 1.01 0.00 | 98.99 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 5 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 6 0.99 0.00 | 99.01 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 7 1.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 2.00
> 8 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 9 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 10 1.98 0.00| 94.06 |0.00 0.00 0.00 0.00 0.00 0.00 3.96
> 11 1.00 0.00| 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00

with all the respect to nvmet-loop, it isn't a real use case, right ?

Can you re-run it using RDMA and TCP ?

what is the backing device for these tests ? NVMe/NULL_BLK ?


>>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>>> ---
>>>     drivers/nvme/target/Makefile      |   3 +-
>>>     drivers/nvme/target/configfs.c    |  29 ++++++
>>>     drivers/nvme/target/core.c        |  13 +++
>>>     drivers/nvme/target/io-cmd-bdev.c |  61 +++++++++--
>>>     drivers/nvme/target/io-poll.c     | 165 ++++++++++++++++++++++++++++++
>>>     drivers/nvme/target/nvmet.h       |  31 +++++-
>>>     6 files changed, 291 insertions(+), 11 deletions(-)
>>>     create mode 100644 drivers/nvme/target/io-poll.c
>>>
>>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>>> index 2b33836f3d3e..8877ba16305c 100644
>>> --- a/drivers/nvme/target/Makefile
>>> +++ b/drivers/nvme/target/Makefile
>>> @@ -10,7 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
>>>     obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>>>
>>>     nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>>> -			discovery.o io-cmd-file.o io-cmd-bdev.o
>>> +			discovery.o io-cmd-file.o io-cmd-bdev.o \
>>> +			io-poll.o
>>>     nvme-loop-y	+= loop.o
>>>     nvmet-rdma-y	+= rdma.o
>>>     nvmet-fc-y	+= fc.o
>>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>>> index 98613a45bd3b..0e6e8b0dbf79 100644
>>> --- a/drivers/nvme/target/configfs.c
>>> +++ b/drivers/nvme/target/configfs.c
>>> @@ -545,6 +545,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
>>>
>>>     CONFIGFS_ATTR(nvmet_ns_, buffered_io);
>>>
>>> +static ssize_t nvmet_ns_use_poll_show(struct config_item *item, char *page)
>>> +{
>>> +	return sprintf(page, "%d\n", to_nvmet_ns(item)->use_poll);
>>> +}
>>> +
>>> +static ssize_t nvmet_ns_use_poll_store(struct config_item *item,
>>> +		const char *page, size_t count)
>>> +{
>>> +	struct nvmet_ns *ns = to_nvmet_ns(item);
>>> +	bool val;
>>> +
>>> +	if (strtobool(page, &val))
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&ns->subsys->lock);
>>> +	if (ns->enabled) {
>>> +		pr_err("disable ns before setting use_poll value.\n");
>>> +		mutex_unlock(&ns->subsys->lock);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ns->use_poll = val;
>>> +	mutex_unlock(&ns->subsys->lock);
>>> +	return count;
>>> +}
>>> +
>>> +CONFIGFS_ATTR(nvmet_ns_, use_poll);
>>> +
>>>     static struct configfs_attribute *nvmet_ns_attrs[] = {
>>>     	&nvmet_ns_attr_device_path,
>>>     	&nvmet_ns_attr_device_nguid,
>>> @@ -552,6 +580,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>>>     	&nvmet_ns_attr_ana_grpid,
>>>     	&nvmet_ns_attr_enable,
>>>     	&nvmet_ns_attr_buffered_io,
>>> +	&nvmet_ns_attr_use_poll,
>>>     #ifdef CONFIG_PCI_P2PDMA
>>>     	&nvmet_ns_attr_p2pmem,
>>>     #endif
>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>> index 28438b833c1b..d8f9130d1cd1 100644
>>> --- a/drivers/nvme/target/core.c
>>> +++ b/drivers/nvme/target/core.c
>>> @@ -510,6 +510,18 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
>>>     		ns->nsid);
>>>     }
>>>
>>> +inline void nvmet_req_done(struct nvmet_req *req)
>>> +{
>>> +	if (req->ns->bdev)
>>> +		nvmet_bdev_req_complete(req);
>>> +}
>>> +
>>> +inline void nvmet_req_poll_complete(struct nvmet_req *req)
>>> +{
>>> +	if (req->ns->bdev)
>>> +		nvmet_bdev_poll_complete(req);
>>> +}
>>> +
>>>     int nvmet_ns_enable(struct nvmet_ns *ns)
>>>     {
>>>     	struct nvmet_subsys *subsys = ns->subsys;
>>> @@ -653,6 +665,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
>>>
>>>     	uuid_gen(&ns->uuid);
>>>     	ns->buffered_io = false;
>>> +	ns->use_poll = false;
>>>
>>>     	return ns;
>>>     }
>>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
>>> index b6fca0e421ef..13507e0cbc1d 100644
>>> --- a/drivers/nvme/target/io-cmd-bdev.c
>>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>>> @@ -49,10 +49,11 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
>>>
>>>     int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>>>     {
>>> +	int fmode = FMODE_READ | FMODE_WRITE;
>>> +	struct request_queue *q;
>>>     	int ret;
>>>
>>> -	ns->bdev = blkdev_get_by_path(ns->device_path,
>>> -			FMODE_READ | FMODE_WRITE, NULL);
>>> +	ns->bdev = blkdev_get_by_path(ns->device_path, fmode, NULL);
>>>     	if (IS_ERR(ns->bdev)) {
>>>     		ret = PTR_ERR(ns->bdev);
>>>     		if (ret != -ENOTBLK) {
>>> @@ -60,16 +61,21 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>>>     					ns->device_path, PTR_ERR(ns->bdev));
>>>     		}
>>>     		ns->bdev = NULL;
>>> -		return ret;
>>> +		goto out;
>>>     	}
>>>     	ns->size = i_size_read(ns->bdev->bd_inode);
>>>     	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
>>> -	return 0;
>>> +	q = bdev_get_queue(ns->bdev);
>>> +	ns->poll = ns->use_poll && test_bit(QUEUE_FLAG_POLL, &q->queue_flags);
>>> +	ret = ns->poll ? nvmet_ns_start_poll(ns) : 0;
>>> +out:
>>> +	return ret;
>>>     }
>>>
>>>     void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
>>>     {
>>>     	if (ns->bdev) {
>>> +		ns->poll ? nvmet_ns_stop_poll(ns) : 0;
>> can you please use an "if" statement instead of the above convention ?
>>
> This is just as RFC, will send out formal patch series with all the
> coding style fixes.
>
>>>     		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
>>>     		ns->bdev = NULL;
>>>     	}
>>> @@ -133,15 +139,39 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
>>>     	return status;
>>>     }
>>>
>>> -static void nvmet_bio_done(struct bio *bio)
>>> +void nvmet_bdev_req_complete(struct nvmet_req *req)
>>>     {
>>> -	struct nvmet_req *req = bio->bi_private;
>>> +	struct bio *bio = req->b.last_bio;
>>>
>>>     	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
>>>     	if (bio != &req->b.inline_bio)
>>>     		bio_put(bio);
>>>     }
>>>
>>> +static void nvmet_bio_done(struct bio *bio)
>>> +{
>>> +	struct nvmet_req *req = bio->bi_private;
>>> +
>>> +	req->b.last_bio = bio;
>>> +
>>> +	req->poll ? complete(&req->wait) : nvmet_bdev_req_complete(req);
>> Same here for the "if". Lets keep the code as readable as we can
>>
> Same as above.
>>> +}
>>> +
>>> +void nvmet_bdev_poll_complete(struct nvmet_req *req)
>>> +{
>>> +	struct request_queue *q = bdev_get_queue(req->ns->bdev);
>>> +
>>> +	while (!completion_done(&req->wait)) {
>>> +		int ret = blk_poll(q, req->b.cookie, true);
>>> +
>>> +		if (ret < 0) {
>>> +			pr_err("tid %d poll error %d", req->t->id, ret);
>>> +			break;
>>> +		}
>>> +	}
>>> +	nvmet_bdev_req_complete(req);
>>> +}
>>> +IOPS/BW:-
> Default:-
> read: IOPS=52.8k, BW=206MiB/s (216MB/s)(6188MiB/30001msec)
> read: IOPS=54.3k, BW=212MiB/s (223MB/s)(6369MiB/30001msec)
> read: IOPS=53.5k, BW=209MiB/s (219MB/s)(6274MiB/30001msec)
> Poll:-
> read: IOPS=68.4k, BW=267MiB/s (280MB/s)(8011MiB/30001msec)
> read: IOPS=69.3k, BW=271MiB/s (284MB/s)(8124MiB/30001msec)
> read: IOPS=69.4k, BW=271MiB/s (284MB/s)(8132MiB/30001msec)
>
> mpstat:-
> Default:-
> CPU %usr %nice |%sys| %iowait %irq %soft %steal %guest %gnice %idle
> ---------------------------------------------------------
> all 1.18 0.00 |60.14| 0.00 0.00 0.00 0.08 0.00 0.00 38.60
> ---------------------------------------------------------
> 0 0.00 0.00 | 32.00 |0.00 0.00 0.00 0.00 0.00 0.00 68.00
> 1 1.01 0.00 | 42.42 |0.00 0.00 0.00 0.00 0.00 0.00 56.57
> 2 1.01 0.00 | 57.58 |0.00 0.00 0.00 0.00 0.00 0.00 41.41
> 3 2.02 0.00 | 79.80 |0.00 0.00 0.00 0.00 0.00 0.00 18.18
> 4 1.01 0.00 | 63.64 |0.00 0.00 0.00 0.00 0.00 0.00 35.35
> 5 3.09 0.00 | 63.92 |0.00 0.00 0.00 0.00 0.00 0.00 32.99
> 6 2.02 0.00 | 75.76 |0.00 0.00 0.00 0.00 0.00 0.00 22.22
> 7 1.02 0.00 | 57.14 |0.00 0.00 0.00 0.00 0.00 0.00 41.84
> 8 0.00 0.00 | 67.01 |0.00 0.00 0.00 0.00 0.00 0.00 32.99
> 9 1.01 0.00 | 59.60 |0.00 0.00 0.00 0.00 0.00 0.00 39.39
> 10 1.02 0.00| 62.24 |0.00 0.00 0.00 0.00 0.00 0.00 36.73
> 11 1.02 0.00| 62.24 |0.00 0.00 0.00 0.00 0.00 0.00 36.73
>
> Poll:-
> CPU %usr %nice |%sys| %iowait %irq %soft %steal %guest %gnice %idle
> ---------------------------------------------------------
> all 1.08 0.00 98.08 0.00 0.00 0.00 0.08 0.00 0.00 0.75
> ---------------------------------------------------------
> 0 2.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 1.00
> 1 0.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 3.00
> 2 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 3 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 4 1.01 0.00 | 98.99 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 5 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 6 0.99 0.00 | 99.01 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 7 1.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 2.00
> 8 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 9 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> 10 1.98 0.00| 94.06 |0.00 0.00 0.00 0.00 0.00 0.00 3.96
> 11 1.00 0.00| 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
>
>>>     static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>>     {
>>>     	int sg_cnt = req->sg_cnt;
>>> @@ -185,7 +215,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>>     	bio->bi_end_io = nvmet_bio_done;
>>>     	bio->bi_opf = op;
>>>
>>> -	blk_start_plug(&plug);
>>> +	if (!req->poll)
>>> +		blk_start_plug(&plug);
>>>     	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>>>     		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
>>>     				!= sg->length) {
>>> @@ -204,8 +235,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>>     		sg_cnt--;
>>>     	}
>>>
>>> -	submit_bio(bio);
>>> -	blk_finish_plug(&plug);
>>> +	req->b.last_bio = bio;
>>> +	if (req->poll)
>>> +		req->b.last_bio->bi_opf |= REQ_HIPRI;
>>> +
>>> +	req->b.cookie = submit_bio(bio);
>>> +
>>> +	nvmet_req_prep_poll(req);
>>> +	nvmet_req_issue_poll(req);
>>> +	if (!req->poll)
>>> +		blk_finish_plug(&plug);
>>>     }
>>>
>>>     static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>>> @@ -330,15 +369,19 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
>>>     	switch (cmd->common.opcode) {
>>>     	case nvme_cmd_read:
>>>     	case nvme_cmd_write:
>>> +		req->poll = req->ns->poll;
>>>     		req->execute = nvmet_bdev_execute_rw;
>>>     		return 0;
>>>     	case nvme_cmd_flush:
>>> +		req->poll = false;
>> should be done in some general place for req initialization.
>>
>>
> This needs to be done here for better redability, since it
> depends on the 2 factors with backend support and user setting.
>
>>>     		req->execute = nvmet_bdev_execute_flush;
>>>     		return 0;
>>>     	case nvme_cmd_dsm:
>>> +		req->poll = false;
>>>     		req->execute = nvmet_bdev_execute_dsm;
>>>     		return 0;
>>>     	case nvme_cmd_write_zeroes:
>>> +		req->poll = false;
>>>     		req->execute = nvmet_bdev_execute_write_zeroes;
>>>     		return 0;
>>>     	default:
>>> diff --git a/drivers/nvme/target/io-poll.c b/drivers/nvme/target/io-poll.c
>>> new file mode 100644
>>> index 000000000000..175c939c22ff
>>> --- /dev/null
>>> +++ b/drivers/nvme/target/io-poll.c
>>> @@ -0,0 +1,165 @@
>>> +#include <linux/blkdev.h>
>>> +#include <linux/module.h>
>>> +#include <linux/sched/signal.h>
>>> +#include <linux/kthread.h>
>>> +#include <uapi/linux/sched/types.h>
>>> +
>>> +#include "nvmet.h"
>>> +#define THREAD_PER_CPU	(num_online_cpus() * 2)
>>> +
>>> +static int nvmet_poll_thread(void *data);
>>> +
>>> +int nvmet_ns_start_poll(struct nvmet_ns *ns)
>>> +{
>>> +	struct nvmet_poll_data *t;
>>> +	int ret = 0;
>>> +	int i;
>>> +
>>> +	t = kzalloc(sizeof(*t) * THREAD_PER_CPU, GFP_KERNEL);
>>> +	if (!t) {
>>> +		ret = -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +
>>> +	for (i = 0; i < THREAD_PER_CPU; i++) {
>>> +		init_completion(&t[i].thread_complete);
>>> +		init_waitqueue_head(&t[i].poll_waitq);
>>> +		INIT_LIST_HEAD(&t[i].list);
>>> +		INIT_LIST_HEAD(&t[i].done);
>>> +		mutex_init(&t[i].list_lock);
>>> +		t[i].id = i;
>>> +
>>> +		t[i].thread = kthread_create(nvmet_poll_thread, &t[i],
>>> +					     "nvmet_poll_thread%s/%d",
>>> +					     ns->device_path, i);
>>> +
>>> +		if (IS_ERR(t[i].thread)) {
>>> +			ret = PTR_ERR(t[i].thread);
>>> +			goto err;
>>> +		}
>>> +
>>> +		kthread_bind(t[i].thread, i % num_online_cpus());
>>> +		wake_up_process(t[i].thread);
>>> +		wait_for_completion(&t[i].thread_complete);
>>> +	}
>>> +
>>> +	ns->t = t;
>>> +out:
>>> +	return ret;
>>> +err:
>>> +	nvmet_ns_stop_poll(ns);
>>> +	goto out;
>>> +}
>>> +
>>> +void nvmet_ns_stop_poll(struct nvmet_ns *ns)
>>> +{
>>> +	struct nvmet_poll_data *t = ns->t;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < THREAD_PER_CPU; i++) {
>>> +		if (!t[i].thread)
>>> +			continue;
>>> +
>>> +		if (wq_has_sleeper(&t[i].poll_waitq))
>>> +			wake_up(&t[i].poll_waitq);
>>> +		kthread_park(t[i].thread);
>>> +		kthread_stop(t[i].thread);
>>> +	}
>>> +}
>>> +
>>> +static void nvmet_poll(struct nvmet_poll_data *t)
>>> +{
>>> +	struct nvmet_req *req, *tmp;
>>> +
>>> +	lockdep_assert_held(&t->list_lock);
>>> +
>>> +	list_for_each_entry_safe(req, tmp, &t->list, poll_entry) {
>>> +
>>> +		if (completion_done(&req->wait)) {
>>> +			list_move_tail(&req->poll_entry, &t->done);
>>> +			continue;
>>> +		}
>>> +
>>> +		if (!list_empty(&t->done))
>>> +			break;
>>> +
>>> +		list_del(&req->poll_entry);
>>> +		mutex_unlock(&t->list_lock);
>>> +		nvmet_req_poll_complete(req);
>>> +		mutex_lock(&t->list_lock);
>>> +	}
>>> +	mutex_unlock(&t->list_lock);
>>> +	/*
>>> +	 * In future we can also add batch timeout or nr request to complete.
>>> +	 */
>>> +	while (!list_empty(&t->done)) {
>>> +		/*
>>> +		 * We lock and unlock for t->list which gurantee progress of
>>> +		 * nvmet_xxx_rw_execute() when under pressure while we complete
>>> +		 * the request.
>>> +		 */
>>> +		req = list_first_entry(&t->done, struct nvmet_req, poll_entry);
>>> +		list_del(&req->poll_entry);
>>> +		nvmet_req_done(req);
>>> +	}
>>> +
>>> +	mutex_lock(&t->list_lock);
>>> +}
>>> +
>>> +static int nvmet_poll_thread(void *data)
>>> +{
>>> +	struct nvmet_poll_data *t = (struct nvmet_poll_data *) data;
>>> +	DEFINE_WAIT(wait);
>>> +
>>> +	complete(&t->thread_complete);
>>> +
>>> +	while (!kthread_should_park()) {
>>> +
>>> +		mutex_lock(&t->list_lock);
>>> +		while (!list_empty(&t->list) && !need_resched())
>>> +			nvmet_poll(t);
>>> +		mutex_unlock(&t->list_lock);
>>> +
>>> +		prepare_to_wait(&t->poll_waitq, &wait, TASK_INTERRUPTIBLE);
>>> +		if (signal_pending(current))
>>> +			flush_signals(current);
>>> +		smp_mb();
>>> +		schedule();
>>> +
>>> +		finish_wait(&t->poll_waitq, &wait);
>>> +	}
>>> +
>>> +	kthread_parkme();
>>> +	return 0;
>>> +}
>>> +
>>> +inline void nvmet_req_prep_poll(struct nvmet_req *req)
>>> +{
>>> +	if (!req->poll)
>>> +		return;
>>> +
>>> +	init_completion(&req->wait);
>>> +	req->t = &req->ns->t[smp_processor_id()];
>>> +}
>>> +
>>> +inline void nvmet_req_issue_poll(struct nvmet_req *req)
>>> +{
>>> +	if (!req->poll)
>>> +		return;
>>> +
>>> +	while (!mutex_trylock(&req->t->list_lock)) {
>>> +		if (req->t->id < num_online_cpus())
>>> +			req->t = &req->ns->t[req->t->id + num_online_cpus()];
>>> +		else
>>> +			req->t = &req->ns->t[req->t->id - num_online_cpus()];
>>> +	}
>>> +
>>> +	if (completion_done(&req->wait))
>>> +		list_add(&req->poll_entry, &req->t->list);
>>> +	else
>>> +		list_add_tail(&req->poll_entry, &req->t->list);
>>> +	mutex_unlock(&req->t->list_lock);
>>> +
>>> +	if (wq_has_sleeper(&req->t->poll_waitq))
>>> +		wake_up(&req->t->poll_waitq);
>>> +}
>>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>>> index 46df45e837c9..ef2919e23e0b 100644
>>> --- a/drivers/nvme/target/nvmet.h
>>> +++ b/drivers/nvme/target/nvmet.h
>>> @@ -49,11 +49,22 @@
>>>     #define IPO_IATTR_CONNECT_SQE(x)	\
>>>     	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>>>
>>> +struct nvmet_poll_data {
>>> +	struct completion		thread_complete;
>>> +	wait_queue_head_t		poll_waitq;
>>> +	struct mutex			list_lock;
>>> +	struct task_struct		*thread;
>>> +	struct list_head		list;
>>> +	struct list_head		done;
>>> +	unsigned int			id;
>>> +};
>>> +
>>>     struct nvmet_ns {
>>>     	struct list_head	dev_link;
>>>     	struct percpu_ref	ref;
>>>     	struct block_device	*bdev;
>>>     	struct file		*file;
>>> +	struct nvmet_poll_data	*t;
>>>     	bool			readonly;
>>>     	u32			nsid;
>>>     	u32			blksize_shift;
>>> @@ -63,6 +74,8 @@ struct nvmet_ns {
>>>     	u32			anagrpid;
>>>
>>>     	bool			buffered_io;
>>> +	bool			use_poll;
>>> +	bool			poll;
>>>     	bool			enabled;
>>>     	struct nvmet_subsys	*subsys;
>>>     	const char		*device_path;
>>> @@ -292,9 +305,15 @@ struct nvmet_req {
>>>     	struct nvmet_ns		*ns;
>>>     	struct scatterlist	*sg;
>>>     	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
>>> +	struct completion	wait;
>>> +	bool			poll;
>>> +	struct nvmet_poll_data  *t;
>>> +	struct list_head	poll_entry;
>>>     	union {
>>>     		struct {
>>> -			struct bio      inline_bio;
>>> +			struct bio		inline_bio;
>>> +			blk_qc_t		cookie;
>>> +			struct bio		*last_bio;
>>>     		} b;
>>>     		struct {
>>>     			bool			mpool_alloc;
>>> @@ -442,6 +461,16 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>>>     void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>>     		u8 event_info, u8 log_page);
>>>
>>> +int nvmet_ns_start_poll(struct nvmet_ns *ns);
>>> +void nvmet_ns_stop_poll(struct nvmet_ns *ns);
>>> +void nvmet_req_prep_poll(struct nvmet_req *req);
>>> +void nvmet_req_issue_poll(struct nvmet_req *req);
>>> +
>>> +void nvmet_req_poll_complete(struct nvmet_req *req);
>>> +void nvmet_bdev_poll_complete(struct nvmet_req *req);
>>> +void nvmet_bdev_req_complete(struct nvmet_req *req);
>>> +void nvmet_req_done(struct nvmet_req *req);
>>> +
>>>     #define NVMET_QUEUE_SIZE	1024
>>>     #define NVMET_NR_QUEUES		128
>>>     #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
