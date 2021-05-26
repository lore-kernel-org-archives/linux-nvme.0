Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D4C4707F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 01:47:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5766128B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 01:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5766128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=JXVIl+mYBVomIickO96LjEwNJAC0ABpIlYqOOvedpHY=; b=GpNMMncy5qvm93
	1HSopJFwGKgIq4VUeASpfXTEMT8+W6+jgjOYR2BF0xEoq9ByHFeXMRTT83tZ1OXSuR27bNG/MPRH4
	FVOaPMeVDrq3AXNYLOC45HAUAtiTdTUTnf2Ce9UPdjloAwWNhwxtFma2eWY+F8ACg+MVnkR/yFSOJ
	lW1stkKElrBkEdIat6m3lEPcvFiKPrIWO5VGJhVphnhxJ6FCv9li7OH9m8yr8upOCjByhBnaXVU7c
	3yOTw3g+8LARaHXunh/i+iCXzdDmMGhWmGnxoddrhnwVI2edxSw0rMMleNxKaO9jixH0ILae8kKzf
	hkzaxbTtxoC0YAKoELfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llie4-009tlu-37; Wed, 26 May 2021 01:47:40 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llie0-009tjK-Qw
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 01:47:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621993655; x=1653529655;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=m44IfoqtfAn2JKIvGKXVWuINRyaNFUGmrfziXDDdnpY=;
 b=IJJByYwLsxFScnzWvHbFbc1ITGZxBHWzMq+kH/TIqbYqLe+eVhRgz+9V
 tNcWaEX/v1BEFLQgDcBFqBv2Yqfmrz66eVCvmos4yznqOuNqhDgwRZDpI
 tjY1ReToENqw74W6C7axEftMDLdDGP0LsWd3JgVpN/ILLbEEbnJrs7Rnc
 v7CuBJfXUhnCdEMHYsDZbRagqd1+exY8uBSPj6QdWnA+xiIXsSGk3Zv+K
 v0o71xKFAO4PhgGstSzL0k7s6jBspWQXI0MtLzoSgId6Kou7UPc4OYDrG
 niH0Z0J2XRefHXr2gzKYhcCrhuQ6CYcBEtDA3OW0XL8IDRUYAT86KP2Ta w==;
IronPort-SDR: 8WxupWK7c4pH0/wJgvNzC76V50IIoWm49mu39AKIg0u58FWVQQiQLZwCBuLx6qA7AA5OT8Zyk9
 OkecSWrgnvcH8uyCfMMRuhQkVZODJiDPw9ImYxDWVOK5l4whP96RAHQnOq+8wqxyLLyX6ce4jP
 oiGeGmV4T9mBm8yW+VeDmVvP1I8z/UVj1Qorv6edTcUnOXhvz5+GONsYoco06vrUWjK6hwj99i
 aTadhbU5CUeCcmQNYOD6lAczYlZzOUWX7sjDYDo0YkSKHE4567JRcXOSTY//8VRCP5I36PnWlA
 ABI=
X-IronPort-AV: E=Sophos;i="5.82,330,1613404800"; d="scan'208";a="174113344"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 09:47:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsxpAbRzmcqXX2N+GRcZ03DKqy6qbtFF3Q0iy6kxXU1KSse38mJu4twXipDzEeCrVMw07KamG8pgff6OcBlh4ePvXSDmiVyilPDXRJbUENz1GFZHPziO24W1DeLR7rk1QRbqhVHowySsxDLOAVU1iVHiXBAk2vX5y/PJrNWMLXfLDJgeQV8RYJ0+8M50gPm0L4AAPRHzgvztztYlETUvt+k7KiS+E0ACwVpRb+e/7vThhuF3t2krlIqPaF6jkHmOTHAb2zEVdBfj5YSUKAMb/zxx5/6/xUDyfL5um/p2s9oxV0m9BxJJtyOLMSmOa7eQWPZouBsLbonIGzWEmJ+ZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoe9H7PMT2GAlzbbFDZKdIn8cZAeZQlIc1Rj35+Gt3Q=;
 b=fYTWRZWRlxPW2maxWNxl5MluLrroVUA/TdfsYg6R96XvA1k9jvpquFeS56ch18j8tsXluCDixyPyZktR43MwVwXvjcCKWk50tyBuThrTUCGWPn1L8Kkq5T+RAqCY4UOBVwvlWfsU+oA7b0/mqwEm2lXMJ/pfaOhK2LFWvS/QzZET9NWS6cpA7/IEe4swU/XtOHnrsh2W368jTSZ9vuNZiyRzGAeOCSGUqCpreP2aajLYWwk2/qb1iva8+osFh7LcG2XEgTC3o8g300PG56yHKYW8Vj6OIVg4GCvzvjrjCWAlsTQvMsC5wF/PQoV2MwxKuqbU22dZl34t7fMvqX2o8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoe9H7PMT2GAlzbbFDZKdIn8cZAeZQlIc1Rj35+Gt3Q=;
 b=lkRu8jqlldEtjizu1Fl25clV+3K4yD9XEwp+rqVew9cBcEk4eavoQ5veHgngxcsXURHFoEKIWUSr8ug3tI67DF6jnecpfrG0s9xsiCABB5kUfwldYm7DPacjBhjLObV7+kcvf2ESpgHWmk/ZqJe9wgAi5XKsSECoA8dro2ZoxFQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BY5PR04MB6642.namprd04.prod.outlook.com (10.141.249.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Wed, 26 May 2021 01:47:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 01:47:30 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
Thread-Topic: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
Thread-Index: AQHXTNfEhybe0F8v0kimu1L9tMkkzw==
Date: Wed, 26 May 2021 01:47:30 +0000
Message-ID: <BYAPR04MB4965873E107F598F6BD95B1386249@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-5-sagi@grimberg.me>
 <57030aa5-976c-8d0c-b6ee-7c69fb5f807c@nvidia.com>
 <20210526003900.GA3704949@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69a9ec1c-da34-4693-3c2d-08d91fe8394c
x-ms-traffictypediagnostic: BY5PR04MB6642:
x-microsoft-antispam-prvs: <BY5PR04MB6642078A2E44000F5F80B75B86249@BY5PR04MB6642.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjxskMZU1o9ITe43bbazpHzyvM4qCQk8L5x5bO/NnuhlM5r0aQg+iFkdUOQ3gniH4Ssr1WNDePZ4PzPyZLzrAXcVG2Gr/tx18dQ6G5fc+4reXWfuqLiZ24mxYlsJDuIdPvO1rqwHjSdz0W9s9CVUljXqvkuhWw0/WNRmlAb2CwExGOJxySTHpimYP/OuYKBcnxXU8W5SD8BthiGRlJS585YCyErGrt0qabGiyOGqPCxIjrSyA9kmN9YaNfKNFEYVCsevpeWz+DeinHANNoZdVpIHlOfdmZSBwZ//jpo0dBIT9HR1zTU4XYXMS2/y6Qmw84ZHyMO3GH5F2hPaDxmchoojp+Tjq7OaqobqDD6ch1RpvZ8zvag2L2sWH78w7ylL2wHNaq5cSkgLDx2mWwu79bGu0rg0N9Is8qUHYZz1w1bTdlCB/XH0KD0iyGcKi7Fc7zBJsHWFCcnkJJzKbeGQNxPeSp6K6sTBJLHht0c3CSOu4DWO5CXONo1D5oCewA4Gj8Jfk7UtLkx27tMEVF9SkyfjzMryO/MD40VisSK3I2JKmqOeLSyV9iZcILFtnxchAqvj7oZdzax9wffTxHTZt3Eh/5ZxufFxrSOHf1bbixg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(53546011)(86362001)(110136005)(2906002)(6506007)(66446008)(52536014)(122000001)(5660300002)(38100700002)(7696005)(33656002)(316002)(71200400001)(4326008)(8676002)(76116006)(66946007)(478600001)(186003)(26005)(66476007)(9686003)(66556008)(64756008)(8936002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QaatWtGxYVOrDawo8EigsgGVoJOm77Xyb3FV9NgsUxydlEAOHPxGUvsgs8ng?=
 =?us-ascii?Q?z3pI2PRk5OT7mAO2u+JXYJGJp9NhtJZSVka9KRrfdq7WHAt8QC3+Z+7HDJSe?=
 =?us-ascii?Q?+Xc//RPJBSFU1fhScsyzyIHkwd4qxeWpSIMswx89uK6oBFauPFXcQ3r0aYKO?=
 =?us-ascii?Q?9xZ7MmceE2R1/0Jvkua1o+Sk0JbrUkSYd+IqWqx/sdT6hHoDEVlKM0IBPeFw?=
 =?us-ascii?Q?Z/bR8HNPIxvXqcHzwdhldCkIKxlK9RF0cNlZOaHnHYIvMKhUZJsrYoxYFITq?=
 =?us-ascii?Q?LLnfX1wBfr3Xt2D+X/v88sv7FAQDJvyUji+CkUyeAInN5toMHCfKx+cL2D2G?=
 =?us-ascii?Q?ZOHtUOaaP8E35n8iiIjQlQ8f6p5IcxeW/Mst8pxJ4BwvwubAvaVJufFpoewU?=
 =?us-ascii?Q?6/hwQk5vJQ/dE0Hhe20tOUVkLB167aQZXPqWPS8qescQj4wJsmCqhwb+JOu1?=
 =?us-ascii?Q?QRsG+noL/DGJbA3+YPCiHYu9q4YrhSeMevZwB/XRPkX8LMhYAe3E4sLtNb+i?=
 =?us-ascii?Q?e5fchA79bqqQLlqUtLhwGeeXMm5+40t0tG0WmwGaZRGtAtMDGqTG6khJsF6b?=
 =?us-ascii?Q?Wa6aYqE0kDdEOe7RK2ALC1bT9VlX0rdIT+CBGzs911NEHkiK3RtMgkpddQqh?=
 =?us-ascii?Q?FciSUDi+jUg/L4d4KcAWHXIQ+UjotWm/13UlA1KGMiawRU5zOmArRa9XbySS?=
 =?us-ascii?Q?qrXYyss/Bq/vDU3XJGgwEcZ/5EJfrRS1Ab607+c3qMBfUGD4BmgJqYkYW7tP?=
 =?us-ascii?Q?d4m8IRhSQ/4liyUP9+0Ab94FuQoO/5YohXx6GYOBUfp3le2wJTYhfRl/Crj5?=
 =?us-ascii?Q?NRZqQSgXWDDa+pMeTg5OMcidnsxiFSYRQa+D1DBnhtCSautcI2037x37Tpat?=
 =?us-ascii?Q?Y7f6V/Q5zzLjmzhoqvCsE1S1Hks1qdZJoFgXdJQa6qJ81GpuzT8bPgLM+XJZ?=
 =?us-ascii?Q?0hSxXmR+PeJ23Pq/2LPIGG9dCTEhpAtkDxZkN7QwyqiWJk0SviQocX8inWgL?=
 =?us-ascii?Q?0jxdqyR3RQBXwlGEvS37HgvUghC7tHDrJVQ87IK6QfexdHFf6RsZRuFcLLuJ?=
 =?us-ascii?Q?n8es0rM/vBQXp2nye6cROurL4t8fZk4xs8WuJIh9Z0C/JBYz0v0LYtLAdcdb?=
 =?us-ascii?Q?xJTQfa1HMF5O7t6OegzPAuYC3JMMrkOwgF/bBrLK0EXnt1AUDtExewQYFNFf?=
 =?us-ascii?Q?Kq0FKzMX+g28tsjNHNLoHqAAT7oKQMPjIQLCvJhRUbNWv2e4DABxte8rYVs/?=
 =?us-ascii?Q?nRw1VuasxhowUXXSBTMsMLYN1VX333oz5Q01duAqdTMJcswgM8LtnbVTcyrR?=
 =?us-ascii?Q?4qzRgJYKm9HI5qG0h5tCpiw+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a9ec1c-da34-4693-3c2d-08d91fe8394c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 01:47:30.2157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uC9qlnN3bAgwqr67WIG0IRmr1t9uGVcKfDMAi94YnB2+PqYzZRBzDHXRn6bXLBYXS0W3M0C9gl9oxAegRmbyoIRLBILkv3Ddc8RBvN940Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6642
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_184737_000374_2272C48B 
X-CRM114-Status: GOOD (  16.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/25/21 17:45, Keith Busch wrote:
>> The bad controller should be fixed.
>>
>> In the past, I've sent patches that check that sqid match in nvme cqe to
>> protect faulty drives that might send
>> the completion on a wrong msix.
>>
>> My patch wasn't accepted since it added an additional "if" in the fast path.
>>
>> Now we're adding much more operation in the fast path because of buggy ctrl
>> ?
> I shared the same performance concern on v1 on this series. I haven't
> been able to test this one yet (only have emulation for two more weeks).
>
> Hannes says the bug this catches happens frequently enough on TCP. If we
> don't catch it, we get kernel panic or corruption, so we defintely need to
> do something. Sagi correctly noted this type of bug is not unique to TCP
> (or even NVMe, for that matter), but if there is a performance impact on
> PCI, and no one so far reports such an issue, I would still recommend
> this type of mitigation be isolated to transports that actually observe
> invalid CQEs.
>  

Please do that if possible.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
