Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD25C19F2C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Aug 2022 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/dN2ATetE+L4z2/QgsEeCCQ6YKizJ544MAq5Uq7wkhM=; b=cS89IuIpAmOH37rtExTRtBIVCq
	ZPKZ40x2kHY053iNZS/pFMjjzKcGpxEOwVQtER4t4bKAH4I2G3aYBkSfdurUhclcq/dzamQvg3NhD
	EpA61MX9FZDddGotalAsIRWF07j61y5h4Gsp/hX13whv5tjXLSt5urP7w6Tl2Loz01haRjyIGRDoU
	KqyVadYsoFCacf2MCz5mpMB4wqJjJy5Jhw6kTMd1UYuUJmVsb/qqHhZpEdNA5OASmqTK9VFN9vUti
	WdQ9IywFxl80kMfW8KaIienQvdyxopBNSScPfnpEUY83/kkHJlF8WYhcaJbUIILjNCf8xHVzmRho7
	WkSq1J8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJVgr-004FL8-BC; Thu, 04 Aug 2022 07:54:45 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJVgk-004FE3-SI
	for linux-nvme@lists.infradead.org; Thu, 04 Aug 2022 07:54:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659599678; x=1691135678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/dN2ATetE+L4z2/QgsEeCCQ6YKizJ544MAq5Uq7wkhM=;
  b=L9STzWSf3u6v/qsCGzvGtJIPbfhyN5GSRU+SjsKcmNkWwBhZ9SkHwz6I
   EbaUjhVUHEgVnUhsuDhlvSvS8CANqyIXBEbjCzXZDx157HyctW9dKkE2y
   Pgi34AvC8IXai5rI0cF/nDC3FQU3ydMvVRhYxd5+cFdB/jR3VVdjC9YTQ
   20v+GYQ3XLlQV1CiqxDyiv0GlwRm/joF4ojxdmmmzYMNvwV/hmGsGClGi
   as0u/FsWchWjCM4aiiHsIcyzkG5iBz6oQiaazwvzYDjgmI9uxUCoqfuGO
   hz7qliU+ZqYogP6pX7nQ4+WkU5O7/7jCXPk0WDY4yY4yAZzDgPKWBsOZ5
   A==;
X-IronPort-AV: E=Sophos;i="5.93,215,1654531200"; 
   d="scan'208";a="206334403"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2022 15:54:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDB5tp6OpJ5AYH+1uZbQ5+W2J4dOMktQpkTMmMmiMCotzR1Id9OY0jp025Kg3U4cCQpl3Hmcqgc+VPD+7cRTfhlDr/mk5dFivKkPX57qPk3yPyhQF7ju87o45JcE6lsqjXTWK9gccwYu1TkJRyzmS9CdeteQCbjFZx59rME+USqlUcnqoWHbEvvSSD0/Yo5yrEXcTsuwDiAOEJovRMGhb4N0W49EzTbUTja1fG7vwz/LjLqbvomndUNPz/MfMMoViYcqBC04XNrv/Z/MsS51xF2QsRvYQdEQ/pA7V390lBuEMzUlb0Ypnhh1g9hrDD3NIUUd3xEcLNu9kWB/TXPQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dN2ATetE+L4z2/QgsEeCCQ6YKizJ544MAq5Uq7wkhM=;
 b=CCL7/gtxch11ChZC0/MRfGcIkcRq6x8c48HC+OHsNuUEYqFMmRY2ZQ8kA5Xs/7te8ImVf6sr94HwRoZMlePgRLl86nswnJOnc/BYCdKZC8/16hMVI1t8PQ+YW/8qP1m3c9JA5aNsBqHF9zpRJp78SXGCnx8whhlseW8a4HAZRS20emw+0akHmox/AydM9CFJcAiUEV7tQr59Vu+JkhB/1Z9xNdm97ZdxtX0OUUkcX8wdgAJK5hMxTMIxYLvId3U0FF7A5dp8B/xZYYC2D03SzDeupAqVPcYEdJaa1g2qYMIeYguwxkU2dTuhri/jZpH1oLXJJs8l5RrWVUe8G/COng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dN2ATetE+L4z2/QgsEeCCQ6YKizJ544MAq5Uq7wkhM=;
 b=XntW5LfxawGsnHMxFQamneum8JK5Yah91AE9X8/ZCF21nutjK/c9QzHkMba4dkxTd3FqN1HYBH8W2RvIEgpUgI4bSb8dU+6b8/sqlGRCSoMulNykQVN0mIPuRn/DocuO0Q6U8QH06RzZBRGdUK7ZptOhXjgnh02sT20D85+dVA4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB5299.namprd04.prod.outlook.com (2603:10b6:408:3f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12; Thu, 4 Aug 2022 07:54:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::59dc:25d4:781e:2a89]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::59dc:25d4:781e:2a89%5]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 07:54:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests] nvme/040: fix write file path
Thread-Topic: [PATCH blktests] nvme/040: fix write file path
Thread-Index: AQHYouBIsQSsPz2wk0O91u/5qZDi262eVkwAgAASxYA=
Date: Thu, 4 Aug 2022 07:54:24 +0000
Message-ID: <20220804075423.uvw3p3eimusedjsk@shindev>
References: <20220729001505.1489933-1-shinichiro.kawasaki@wdc.com>
 <d7371c19-5586-4182-9f7d-268aadd0024b@nvidia.com>
In-Reply-To: <d7371c19-5586-4182-9f7d-268aadd0024b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10de3102-841c-4c5a-6ea2-08da75ee8c35
x-ms-traffictypediagnostic: BN7PR04MB5299:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nXEerUCY/1WcL0DWKl2Qe5XcHQgJxKiXy/U/GL3yUERwQ09Q1uDfkPh7su3x/Ud4mz63mPYXniM7zvTECjM0KsDePauu5x8/Mi4dIyeKcmuEb8acNNgILADlmSvvs6ClGWeoMnY8VWe0+pmQGU3xzs4YCs8nbX5mNHHjKv6Dand1f1O9mZKxWWN2KkqiI5TjbMtpHmnAhJtkOfY1+rKJiXVUdmfj4hEl67EZeUAP6tpeSB9BqQ/M42ZOoVQ862WBopr7JOmQRU47AQ9ldlLYWwiZIraAggiPvt1pRpxHLw2W/HkAxB8y38VhC7zWsSkDk8bVAi3FCGm68BFKCdU7zlRulI16cnXKTeGk2yrAThfdojuwfOstUbtbue/sUZvzCLlDV6J5OJZ2X1rV4jMkqgwqh0toQb0mHRLI9J/lP1HDZRPy+HHYEQYjYQJ1TCFPxoeJYCOmZpDJq5wlhAurtNJSaKbh1nzxRp9O2u22T/O5K8NBSI/8nCRKghLVaIHAz7HoWucLq1lV1abAPW8VXHFkzx91Mjyp4w04SI9BpxEemnh9rzq8EMyICzN9Xysq4B3lfZ/Ycw4SzMsDclUpsqXdKNIPFhjTFRZyVubxRsws6lOXmJjwomvGm6QxqL8KIU+Az8swDgMbVI7168FO/RXxEJ/hVQtsbP8wsXDP7tFNNS5O2rzxbe/CLY1oCxWKXNVoApOYt+YGSyGVUui/HgRYN6UgldOHGMVJ00+F1d09mNqOq28nFl2I2QNkl/JPVINk2rLPzhFbK5tpr8gdDOuw3/dc91+SXzg1KKfBkP//5EoosImPQ8qsl1C6dYqn
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(346002)(366004)(136003)(376002)(9686003)(82960400001)(4326008)(8676002)(6512007)(66446008)(66476007)(86362001)(44832011)(66556008)(64756008)(91956017)(76116006)(1076003)(38070700005)(6486002)(8936002)(5660300002)(6506007)(478600001)(53546011)(186003)(66946007)(4744005)(54906003)(33716001)(316002)(6916009)(122000001)(38100700002)(26005)(41300700001)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?ZOgP9VBk3bajK/AnUnxuNzDXMmNGMxtqTUvf2qjO5AMuuvMU1YzI1o8fpdno?=
 =?us-ascii?Q?PNbytu5MPit5gwK6GQx6igZfSpaibqo+db19Qdb5HoztF3k6nNJ2mdsea8MH?=
 =?us-ascii?Q?rQMa3C3ABwhEFuiuUuDbpdyn0/YMP9Ea+bnikrKLnMVO86nOm5VXpvfbTyzp?=
 =?us-ascii?Q?IfAcahNRORGBvtNKDteMc4Tzixp43I2UHbAanGHdzZUHv92MshEcuzO2h5TK?=
 =?us-ascii?Q?NmJp004wT5gLijNkNkBA7w9BPhxoBMIhoWtRkUxo0sVMoHMTOYVTRd8LMObS?=
 =?us-ascii?Q?t+XNVmVnPXD+Ok1UKE0uswOaQndAMG0k55ruKW6IZ7EmHOXhP8auj6IEp7CR?=
 =?us-ascii?Q?AY7n8reg8qH8S3kplfjI93trtjkYfgUj8pfqnSekYxAgoSg/HhEpIfYIqRE+?=
 =?us-ascii?Q?DiH9TvtMMSY3ajdLi3UuOvWU4i9Agw8HHaqllTOI/WUG8xRo7OSjBXj78w4C?=
 =?us-ascii?Q?TNEHLCW/cZe3n3+CSW9HE7GcMrKCvn601QrIoLHpc/zufXwkZCGYkrG3+wjP?=
 =?us-ascii?Q?19XJu5uJVMY6sKZBN5c+OrRK8aCdQWqSv+giv5Zv6Din9+HdiLNCoZhc75jH?=
 =?us-ascii?Q?FO4hcUerZKSm609XK0ROtzcl20U4luy9B5aI7sIPD7ViyT+UwKoDF7XkTDIa?=
 =?us-ascii?Q?8ZjEL1IBRC25KmledY5n8uxXSkglalKqKcVEB3Q+DN7rYH/jlkQN6o9V8ccY?=
 =?us-ascii?Q?OhLBU4soRiRwTaVtnnq1kfwYRJO+TWOswohnMnODnqABQQvNJYgCul7DXpE8?=
 =?us-ascii?Q?cRiw868im4+/kyWLCV95ES4+ri++k0nA1hOCbFqgBYiqV219quFjY/3Lkiw1?=
 =?us-ascii?Q?OsocjRdoG0Itz9q9GIK+A3+KR6ufxwxWyUbkTC4XGcvSJ4FHYjZN8TgsuDOu?=
 =?us-ascii?Q?eXI2Ao9HIaPsSKl6C9TExcLl9GI3x5UsM9k6sm60FqD+SGGwwfc80ZHWp6Ha?=
 =?us-ascii?Q?+DfV9uPJ4QGwXx0r4Ugy1opPVOx2fSD/8Blrjez0EG9oTMaKeyVUNr/Dbdkh?=
 =?us-ascii?Q?TgbjtDYJTJLTp9j1Vutm7y8zMFrxtcc5MD1SWobyTBgy9qZskF/8cUHKmRaw?=
 =?us-ascii?Q?CcVUB9CmFWVv7u7aeG6l8jWOaW0F04q2dvKuRIumk/VQ0VHfYrqnVVuzS3aw?=
 =?us-ascii?Q?W+TGcSbvaCSb1+n72gk8fjwzLNzLEMPp05HdYw7YipOU3EuKwJM4Uivu7tdB?=
 =?us-ascii?Q?3zgWfAd+0Jynn6NS3nVsr8/SNw1f//ewzXtVz+oy/QXtng+uI6oLPy30YPrn?=
 =?us-ascii?Q?4/GaeJpEPnmjyniy4LhjtmVgmczeM9JJ9zPZ51yCBm3O7eU7PTNjaM++gZxO?=
 =?us-ascii?Q?S+d3xp32AcZxLhHSVEEIGktFFeFBONgN5yNY1/Sq83WKsVXw9sydTv44Vgw+?=
 =?us-ascii?Q?D6Zg/NarhaegQjUWaSRISjzW65nwVRSc2CIcsUyvoKAOcY0LBQVCqZJAmfyn?=
 =?us-ascii?Q?DpCbqRgu2/799ljdZeXb/lxAFdJqefxzyTQxoZ83ooaowjNLRE9OYDdatgTO?=
 =?us-ascii?Q?ieCD7jQOJA3GonmeJ/IByTcsjw6saHH0fEthoGICjwJf6dY3S/COdDdJCige?=
 =?us-ascii?Q?abqrhqn+ELMyFYlgOFUDGRqeWH29FKsXGCgOYO8nRvI7avZcP6haOBcwOdFS?=
 =?us-ascii?Q?/9DEFfef3R+ctoOhuuRNpWY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE324D546BD0F7409C7E64010EB8F17B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10de3102-841c-4c5a-6ea2-08da75ee8c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 07:54:24.1168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r30ELljcZ5M3kyZkCF4dHksYCmNcf8molWKE64ZlrN9mFAr3MS7uc4znMx7yWykvxHF/RMUlUh9+QQs7BZz01zGwaN6RV7AtslSiILSbg24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5299
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220804_005439_039267_BC61F8E9 
X-CRM114-Status: GOOD (  14.65  )
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

On Aug 04, 2022 / 06:47, Chaitanya Kulkarni wrote:
> On 7/28/22 17:15, Shin'ichiro Kawasaki wrote:
> > The test case nvme/040 performs I/O to a nvmf device file. However, it
> > specifies wrong path to the device file then the I/O is done to a
> > regular file. Hence fix the path.
> >=20
> > Fixes: ebf197d1aea4 ("nvme: add nvmf reset/disconnect during traffic te=
st")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
>=20
> Looks good.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks for the review. I've applied this with an amendment in the commit ti=
tle.

--=20
Shin'ichiro Kawasaki=

