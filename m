Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6918FC47087
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 01:57:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB0F613F6
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 01:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB0F613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=QoF+gIkSC15Yl3Uvw/FrWrzmqPQFjIt7sOgzNLKieUs=; b=Nd3woE5MJ3e7+E
	bhJ4Q2F9QmtW75nZ3l+gR3p7N6LoPi2875KbDND5emuwDmMD+sT9ZHxUy/w1y1ipCz6e2O7ldujA/
	Yh6XU7Ey7NywWxVffftRy+XLAiFFg3HVU92VTjoqbUONMyqQFRF56RvWES7kyoch50A7SvMGditDO
	NXXnEFqeoZRgKJXCUqNplYGfLqV+3ytqWi1rMQ2JG4rfAMqPDxRax3dTKrIdDvycnAzga6f3pAHG6
	Jzc7GwYbnAPXeEJ0PXAHSAAZvDssPrlnwC1zk9vcqEbX9XPZUF5WarFdi2xfupoYHgKw3gkNeKGf/
	P0WdncgmWIBzKqE5+xbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llinH-009x2u-8i; Wed, 26 May 2021 01:57:11 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llinD-009x1P-Uc
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 01:57:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621994251; x=1653530251;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Ik2YFQwYpQOJJgalz/Jpi38vi/1sUB7xqSZsGn7RIUI=;
 b=Qew8x/m8d+V7fCpyVYc+12ljanLUwjjoWDecIvZyLrivDr80sCAdQ16H
 uh5jQ5fmFpavoQqq6PKWVOl4LiF541eciIyAdZCkroNlbwZUxvz2HSpM1
 GutMR47v9yx44+r4cM+2rlvyD7Unj33VJgspQ9jNzkGQ/EVK9Z40uvfag
 K31FXj/Bvfl/4g2nh2rC2AoDqnl99oqNDoabPT2M3wu2/KyLyxfNx7gBK
 BcpGjbv/Ecn/9YEYdkk6m63cmYBUUHrviTnc1aXNnUEIIf8uC7QA5ddNJ
 +/ib717gvihOgohK4/DDR/x1gLRyl+W83NUUPVVekzhTRH/Ft2hwq7jFA A==;
IronPort-SDR: aW2OlPUUGnMQUbjkZnUJ7YR90A67LGi3loHk52dDYC7enbxU2ixkrZCMLkTes9WSmIJBoLP9AD
 L1SEwQNCC38oPUWUUl2S8myZCN271G+keAeaund5VpJCN7eSBeYpJgoUEkjWoIhLMmUm8g4W69
 sJfipK7tp2tiN4BreEQaLt453kaj2tWh3ZDZ1euvFZeH0HpwzXl45drkOeOx/QjKDv8yVh977e
 zZTFIvxfgk6nW79DdkgEchDZuZbYMGN8fPYQbr+IOHnDJzNRNCXu9waE7t6GE6IgZKnUFoax5k
 9n8=
X-IronPort-AV: E=Sophos;i="5.82,330,1613404800"; d="scan'208";a="273339194"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
 by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 09:57:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5f2zBWDbry3DZL04ZUDz4uFa9v9DSz8dgryxsvcZefAL64lvXWW6KhmXjJQwGq5Y7gNgKyixtXYrmtpnXEG5/eXlblogYyiu67DUvGPLX29UE1i4ny9UB97JRhwSLK6jYH+WJjWBH2iqPWNHFXsFSg7m5GZQqdWo+ZxazwAggnpcCBqf9Q8QXNfMbFMzPRASNHaYNqmWD2tp5W6NgMbwsbcGi9FPU/sdft1vFH2K+qf2UlWMh7UxgSf+ERBoSAMYcK7JIYmeRzp3UJ8RH8ohSJtXDxs89M8lr6QBlkL2LG3XXqALhvn1Fw2W/JXs5NixPUS3kntSUXr1Nv/zJkfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik2YFQwYpQOJJgalz/Jpi38vi/1sUB7xqSZsGn7RIUI=;
 b=QLFDOFPbriPRdEVQgAg2YBV/gFejZLi0CI9wfulQ030Uy6HUkIA5XrTn81f0u4gdtaufQdY3J3w8gSXbeu6dYbjClLlbpv88TZbd1sqaHKZNicMzz45ZexLj492/yrZEmymg/hmjhu2zqFnlvNv0UPML35CdlNDCNHocz1YYQiotXLepoq3jesUHT6aKQjm3VcSc28vDN5gGBNoTwuJjQL4llhuUaUvBI7dxVxSTt5EuTNJ2x89sgClRcZpQ/FSI/vRidj4VlW0opjbam9w7JRrIgKr7KsQ0m2oEbPdDywrBNYvh+ZXQg3AXqz8HVh2dBopkwIJvvdNoSSqwYTci8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik2YFQwYpQOJJgalz/Jpi38vi/1sUB7xqSZsGn7RIUI=;
 b=sWvd0LJCGnNLUGND+XKYJE8QcdvA7JaVYe6Xk0dN+Y+0vj3MInJYi7WaghE2UM/oc15q7HutLLCmx/GC1AsDZUI34RGT8m1RAWyBxdVR2p1u5Uhe3i5WYRmMZjvmhN807suGNpJSO9GiW+19XUKMm3MSjt7fLP/oS19u9Z6g4SY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5030.namprd04.prod.outlook.com (2603:10b6:a03:47::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 01:57:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 01:57:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet: fix false keep-alive timeout when a controller is
 torn down
Thread-Topic: [PATCH] nvmet: fix false keep-alive timeout when a controller is
 torn down
Thread-Index: AQHXUYRZXXhydzeiAUqy/kJG9h9OvA==
Date: Wed, 26 May 2021 01:57:03 +0000
Message-ID: <BYAPR04MB4965B622E2A1418C2A189FA186249@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210525154905.2245888-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 705f9cb8-80f0-4230-aaa6-08d91fe98edf
x-ms-traffictypediagnostic: BYAPR04MB5030:
x-microsoft-antispam-prvs: <BYAPR04MB5030F5D2C5AF376AA611151F86249@BYAPR04MB5030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4n5NjOaLy2cRXImGQKkD7bBkqL+H1TP7Mkqc+MCj9jtnTwKRWKgjIdRYqxouoVEn3Y0tOxFtfCaLloW+i4NXCn1gXy3nA+KMt8Paz3s0M0vQUiOXh66CagSXgMAX6IrMMpYq6e/z6PpwM/LYXIMBW+uwx8wqkftigqjn73Bt0HNy20S+hKi9u9MBugP1loJEFOyUIvdQ/UoE7SSjvEurL4U0RPsQ+sqGnG3NCZDHPc8118jFdlwi9zw4Ct46cAh83G55uy3L/G5Ukk87ruRIpBwAi7xBDZ+2C5hyXCo7E0dHBcN6CJrKAkaTIIjjInOikN5qayAbCjsgr5yLu13KnJDZDorgqAvKTLvmVDckwHuhuRrGwis3Pg23x3VYEkzCgNVdEtlYZq6Wmi7qNJTwOV4v8WQORZYqLKp8ZdfjYEPCt0TLtFkQ7+cPeHZFbhNfl8Lg6axCghbWfjWWcAcrZu/rJuaoi+P2m/+4CgrtPrIs1L3AKqS8XLyCdepYSxs3jEYxVdQghxK2uPd9CLlp+5TebodKCXeIn1nIVJI0biCpDe75jAY188b0NNpdsuq+RhQCgvBcpT202FwmYJDZusq7vmsMJYrK2k5R1muYt8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(66476007)(4744005)(66556008)(66446008)(64756008)(52536014)(76116006)(71200400001)(66946007)(478600001)(5660300002)(38100700002)(122000001)(6506007)(53546011)(33656002)(7696005)(316002)(110136005)(186003)(9686003)(26005)(8676002)(2906002)(83380400001)(86362001)(55016002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0B/iJ2Mxrl074o3Goy+JzlD6eMOKUxy+HNwhlQRy197moeR28pvCfEOe9Yvn?=
 =?us-ascii?Q?HlqGJEkqPG2eE4dnqIG1zhNwvtQhpg757W3zYOYzErFqlA/WqP4LJLFXRwLc?=
 =?us-ascii?Q?6gmvAgL+i89LGEUbW2Kej13tAW8loahtC0o3uqXyL5OIpDEc+hFu2eXpM2LP?=
 =?us-ascii?Q?l62FfzlVDYIixM5NqX6SpK4+rv08dYBfGFhuUIglXWnuI3jgamX6dNwUH8sr?=
 =?us-ascii?Q?wcRNf1MgOFQqq3C5y2BTp9oPDxClkhsGvI4Mv0qlkC8CLeIPgctvZYQzw2sF?=
 =?us-ascii?Q?t6UT+Yifvu35h32riQ7SDaTc+xOcrp2aShPZgMvtZkM4amRoVL+AgiCFDZxD?=
 =?us-ascii?Q?nsVN3pPJddaCueO1wh5c1WpZWK9CaJrJtegSLVG42rlIqeH0RQdURTxf7QJr?=
 =?us-ascii?Q?6kBnWoXScGg/v81X+c7rD7u5tOcVXQpgvHNuOilGFQvOZ9iPxl6tJIN3sSes?=
 =?us-ascii?Q?H8KMbImy04l8rUxrYsMWftTU9lu3r8s/Zeq7zgvyxJQCPeqboBkK9kZd6FRr?=
 =?us-ascii?Q?10eqq/k6n7vUWxQCOrA183Ui+aVgw1u2llms+QkphAqTKV2926rTRkKly14G?=
 =?us-ascii?Q?L0BG8thdJtBan+Klo8IzxYkQe6uyNGk3OyTliXMKa5kcQ4c3Qpvygzkz0XtA?=
 =?us-ascii?Q?e4BSwyTnAcEiA034fDmsroonIpr6uMspZTbEaBrKy+4Vc5whHU1sWdrJtyVH?=
 =?us-ascii?Q?TVFM38uT9WUOScBkuXBcSzV8jqKzUjPa0Osi8gmxc008jKu8k/M1aiAN1cyR?=
 =?us-ascii?Q?7IzXiZwwxUJddGz0p7AUJK0t5CleiRl9zRI8jE2CeE9aL8mtK4iEhWb67F7p?=
 =?us-ascii?Q?11L5aszh72nbBDKH3AGwt9hUA1nNDSCgd5gbXAAtznOAwuShnbp+Ow/MLwXw?=
 =?us-ascii?Q?exBfDVzskc0XrQyx/D2I5Z3TdeburC4efcmAnwxnHTr6snnvnRGqKjR5gZpg?=
 =?us-ascii?Q?9n3RuCIWaHdKmqj8GT9vqq1IoSGTirACsvtBiSdnUomZZvYjrZxaqRfY9Htz?=
 =?us-ascii?Q?3b9i5T1X3R8vLyP0XyevtOJx1eEIEA75WaVhjNdN8XZKsKwONCehotqgY36p?=
 =?us-ascii?Q?juPiayzVOra5gdXKcYnxBdS/aq+sVK/tFC5WXimBmJy3jDlc5E04e5rJrNYf?=
 =?us-ascii?Q?Hs92LHdfEGUOlbnip9bmXOMzDrMighE707Zo7wRt5MURN3NbaCJKLKJPOl2G?=
 =?us-ascii?Q?94apfA5W3GiS59xHr95MTr4/4/r8HBQ8W4UfizG3Fwq65I2W3KU7WhpdASt9?=
 =?us-ascii?Q?1FFONART407Fg/a+Z1gCsOX5m3W6w9nSNB0aLe7puAxZ9i6mOcm6qzfNJlLy?=
 =?us-ascii?Q?qfClynsUl6D41Gnysa8pEtXr?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f9cb8-80f0-4230-aaa6-08d91fe98edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 01:57:03.2480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q98eyoMB24JkVIazXUYC3mWhGyVyuF0d3FKp+t1FFNCRhys0/axMZQ7B0H6OKRe4UFrZBB407gVArl3ZdQYSmhg2rEd0q8+Lxbic2kllWMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_185708_093024_23EE5350 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/25/21 09:38, Sagi Grimberg wrote:
> Controller teardown flow may take some time in case it has many I/O
> queues, and the host may not send us keep-alive during this period.
> Hence reset the traffic based keep-alive timer so we don't trigger
> a controller teardown as a result of a keep-alive expiration.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

With nit fix of comment looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
