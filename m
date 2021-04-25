Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97467C433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 22:30:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5886128A
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 22:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5886128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BqcFlCDsl7YJMunf5vHZ+0b3QppDxIwkj25RUK5BOJU=; b=G+v7oG+Grq19+9mg3lCz7N6Lh
	xb5mT6EuohcUNSgmbtjNAqpwP41j3em34wZY6eykoIG2wW2CNRJ5aciFZP2SXeSET+svsu6FlHqux
	fglTXTWW5SN1uIdeI0FrddRzjgttJdGSrxMErrdVbqGpXssxrdlhcawKSeFGSq4WRfUjQBx8siokB
	B4ebJegDy9FbLI3Q1e/Nbh1r3FU/ay/sR3O54aywTPRmFyB1stBdaP/ffKFKDM67bTmgCE4EtpS81
	wPjYmteOtWjY/IZQQnxp5rfHQ3uKZn+Hy6Hk02/C6pj68lNmocKGa+xtKOlR1HASvuvqsImjl6UvB
	gUA0FKXRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lanGi-006OpL-VE; Sun, 25 Apr 2021 22:30:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lanGf-006OpE-E4
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 22:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=sqodD/97xLzDf81bj3jaKumVep8AcaLQxd0JTtfLtNk=; b=BJ9dLSFYs229yDoEgx2C885o1V
 fbRl25H3JLGZalrfIKdf2KlWlu0zB0RdehbWbC+LFY9NVkTzbvc4lA8aZJFinZYGwjIXXBlF97VNl
 IAGDkfuu90ajzpAznxVXcjaiANGvd1i9hu7w6gwhD3YH1C+klx3KbKggDGjWQNaZ8B7O0pgSnwRth
 wudJErZANJ9K8oN+U0u3RNjAlP8KjdkeKgJ/ByK/APEzAwQAW0U6yCJL0+gYxdSgZ3qrUXgBh5mt0
 XcZTgE7uUUjGuODZFrMU3PvQ3lg0A35jdNKl2TasjzMF0uQPw3Pa7+lvlxeQUoCIi34fHHTco5dEG
 FGHx4Iyw==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lanGb-00Fcm2-Rr
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 22:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619389817; x=1650925817;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=sqodD/97xLzDf81bj3jaKumVep8AcaLQxd0JTtfLtNk=;
 b=odchzchASs4FRb8qx2o224BjEUcP2i9JYpUhYQmvmc4hTB+ZIZdJn0xN
 6vLTKWxo22F7NgujKK6KI8DLRuz9EScl4ockNy8I6ily4WUfZPvn1qmH1
 qjGNmpl2e5JS/wYDRyv/bJRx45e5Rw54mv+duLJuKt4FHt9w7ArlJ1w2v
 yV9W93GhoSaJSOFd+HWcRcxZDN2krOXZvrkVebGCABWMQaJAOSL6ARqNX
 Y6DCMNbh8Cg1pGSFdr8OAXsZArOVkyun90+mg1/GEYBke/8MxwswnX2iN
 RpUqt/T2wnl5oLeO7hEgrUMzqmiqfi7dQJxkFXsCTZKKEwsnhHcKhGyTQ g==;
IronPort-SDR: Whh3HRocMrQSvFb8U9g8JLYm5fDEcSB+VOdjd+6DxpNT1m8/9DUhU+1rU1Vs8KTLQ69JgHDaxa
 u7chaIZLDAvOtb2L2sYD1wouaqhVmW/6eyGbLS2liV64JYSTzWIGYhMkW14doUyIkbWe+idM4V
 rwNyfmhsOwI5Xp0cyExu3uwbCyI0yPkG3Q6yyvpWbfHZrZ1ze/8F4nbaiLvxCmaKlU2KW+oAbc
 EcuGd4iyFMMDx4ICW/ojp/81IneT8NV8FDQhNagoDS0cVqg8oCEvjmrCPsIeH+0UfP5qn1iAEY
 rq4=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; d="scan'208";a="165574504"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
 by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 06:30:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVWHG6y6VaQ3ffc922a2oAEftbF90XkNa5ogglUpI8sLEVPQQRv+st4DYi4XTXRzOBhhsvLG8kX+U5w4/Gdz6Ed/fbg7CNsna0uKJm8Eq8pRwe7BfEye1OpFd7Y7xuj+HBkjC28ZYxekvTH3if78wKJ93zAKBSyRfkoxSbGF2ssXqzjXO8vWyEVWL+Xigo0a3RozLg1gkh5N8KWS7I4+30iucKkOaYyPDp49IfMfotyMbjpgPY/NME7k0Wz6+SDj+HJC8PODmTK5fewJbVc4Zf03MbkKy4SOAJ3kIeSuEgd1bxQm7kbB2jHZqLFhKqZwZt+IDfgTwzX+plrDg99i7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqodD/97xLzDf81bj3jaKumVep8AcaLQxd0JTtfLtNk=;
 b=njqreOlCPhhPZSI4MH2ZgAdt8o3LkbSVzKs7U6GE+yU0mIG5VBuBzrorAEmoCclWEEZdBPtWHLYcvaTLRSCfvij0inbIza1dgkezJ3vbYorjvQtjSnJlbjzvebqPA1Gs2H5AX0BjdfR/XJD9jhDEBW6EVJznhLX97T7TblDw/IQlqqXUBhldomMB8KQBMN/LEJW8dKCk6Puw4+NZnESAUdU87VTZee9LYRq6+usUhqYBTRsn++e81TmQmf7+hS66tp0uNBfUm1v7VYagBd/5/bF1SVYWbbe0eDH0cQY2nDBUk43PfaQjtJFLer+M08RiV6gATlBC7hRJ1EUGGwyWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqodD/97xLzDf81bj3jaKumVep8AcaLQxd0JTtfLtNk=;
 b=EvNHoeWfL3XmEBZZAi0gEPQb+Mef3OEgsk/JpXd7jqlWIc0QKTtBoAwZLQC25eHSL9QOa7lZCDNJJMHm+e7cCh/tqEXzuWWMZbV9+3waF0HUVkKvfs1fDbzeB4BliNAh2Bj9OvwL7iP91XVRMqp1EFl6Z92Q/5fpZx0HAmBOK+Y=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7744.namprd04.prod.outlook.com (2603:10b6:a03:32e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sun, 25 Apr
 2021 22:30:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Sun, 25 Apr 2021
 22:30:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] nvme: avoid memset for passthrough requests
Thread-Topic: [PATCH v2 2/2] nvme: avoid memset for passthrough requests
Thread-Index: AQHXN3GYdCtgtZrzI0KgTNPNft2VDw==
Date: Sun, 25 Apr 2021 22:30:12 +0000
Message-ID: <BYAPR04MB4965F8DADD708379201E19D386439@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210422115427.63636-1-joshi.k@samsung.com>
 <CGME20210422115548epcas5p319a909cbe43a627aa4a5ad5490fa810e@epcas5p3.samsung.com>
 <20210422115427.63636-3-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aefadced-80d7-43e9-fcef-08d90839b13b
x-ms-traffictypediagnostic: SJ0PR04MB7744:
x-microsoft-antispam-prvs: <SJ0PR04MB77449C5ABECE258245EDA76086439@SJ0PR04MB7744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRD+clywxDqKEv27uHSoxAIpdBefSdrGT5K0Nf0x76oXmVIi0ed0T0rMIH786JT2kYn0tCvnU1LvpO8YtUVs+6vtiWRMRI1V0Uf+KbWq0m3xnuXVkB5U/JKOi8dS1bt9MIbDJwBxB9sITGf8MqpxMUzjqU0XTvWZcF9Iqzc8BU0vdExh581Q5c93Isrz9O/7cWN7nbCEJeNy67mHD3faRiTxmhJU6kMHx1j5Y9uhldIBFyu0ANmyXQdD+l6gI4on9aZCfqxJcgfP7+FqtYSaQz/UelJoVxY7B2n2nBoEPVTUS3t5Xf9gxuIsus81T5ZQm13sCvX0rcGXfnT4JLYQ+UL4o0ZRW+bOt5EDG6WwH0H9dykRjQci5EyX+TYcJJj/CgKgHU0kONF8ejw4naIPpbbLyeV6yT5qaePJI6vR8SnQu29TtQ/fjqHpSvEpa+es5oLZYpvfRzV3KyAEBSlcWL6OfTeGlFq/3EILNxv9LeQahH8xDy7tQQ+RYZtONNZ2F6KGKLuGkrviAGMzfFpgUSELigFfoPTPe6YrOhq5pbmZlHjPTchslciTVI/6rT/itChx/WjUy0ifZ7fn6VcqkQ7LReqAmKg3E8indNTo55U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(7696005)(86362001)(8936002)(4326008)(33656002)(8676002)(53546011)(122000001)(38100700002)(6506007)(2906002)(6916009)(66446008)(64756008)(66556008)(52536014)(71200400001)(66946007)(66476007)(478600001)(316002)(76116006)(4744005)(55016002)(26005)(5660300002)(54906003)(83380400001)(186003)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lYiMVGqsDuV8+2R8X+md1knYRNoijjEnOKk5wzxD6YEYgktPFzrZB4BDqbFl?=
 =?us-ascii?Q?sPrWXv8of9HNhncni1qU+FeyMh5cBW0BKDT+e+te9qia4yDX1rijhyEE4RIz?=
 =?us-ascii?Q?/Qr7HJ7dfbKfR0q0OI/TukXlfilrxVnvfTdG3EdmYi1qiPkbh+JtIkYY+w2W?=
 =?us-ascii?Q?OF+LIVdcJsXNlt0Ztr/IctPNl7+0b6yeGs29Q0A4FZcIn63cJCzjIcnnIXEG?=
 =?us-ascii?Q?f7fJm95UJb+9X7HG4uKtM7wKJ11lvbmWLTxywO13G9MQtsS7iA9dDWcl6B8q?=
 =?us-ascii?Q?Qycn2s5up3VGeLGZpQuT8tBlcii4KK+K/nKRCqh4Da9aPqRxy0I7LYata5Qm?=
 =?us-ascii?Q?VtngXhuoRYFLT9bptTIEmqwbe7JYnFOAq+6TeGBuy6i/i0Pn0trugiBRIFxZ?=
 =?us-ascii?Q?MSF3MuVb1Uaks3ztJ5d+HZTr/Qa2RmUqiBhJpg7+cKNtDnbe5JjsPtujVrxw?=
 =?us-ascii?Q?XusGjbHdfUe28H48Eq193ZMCXDOfNR8qok5FXfkvG4zleFQimX9x6TNLpAqW?=
 =?us-ascii?Q?t4h2NuLp+lUadU6KyVjtlhd0i4S+A6+Z7f+jwm1SDXwJgUkxIwq4fuTdSmy3?=
 =?us-ascii?Q?ECfsmjA24UEgw/IgfP0J/9pbVA6YYwc5muV+c29pti+sQmKeDjSHIO/7QMfT?=
 =?us-ascii?Q?NxJG6i4KKtRL2zZyX/uqRRskPvmYqV3etJgfppUisHQtfBcrJd2sgsjP1wRL?=
 =?us-ascii?Q?bsSN74xb69SqJwp2/PV3KfRFn+zso8I/gJ8dUrfEpePgdVB98PDsWs2aSHOw?=
 =?us-ascii?Q?P6kQfaTTtccnMv9a49gyytihgFNRbDZVk+t3LWQB8H+ZyJ0YS1qWDKu3DygC?=
 =?us-ascii?Q?EuE/u4qVQgANYlgPPAQNHRXRhuWKJW/QvhyV7fMf0g4aOkcM7zAhmlr4dwgN?=
 =?us-ascii?Q?SP2HzC9ABV/6CIGlyKmTG7V7HelRsYq77e4ENMloiGtgsL5eNGN0/k+6pZrH?=
 =?us-ascii?Q?JNnCOISy9xMakTn6ukiADoe5Qo/zlKX37UgviQBFDfk6PgPq4c33xqtw3QI8?=
 =?us-ascii?Q?7JGePszZa9XNe4vxl6lL7bhYxO8otNpX9uDT6hf344b9ksiKFrmPN5AiMCi/?=
 =?us-ascii?Q?onP4Xj+9lxT8t9h081MIElZxFWuqJPdFALMLkM7xGVKM7Gx6uK9Mosb/r9Rw?=
 =?us-ascii?Q?bni/kEJyfP+KC961EP0LiLsGmxkDOdyqhDtjX+FneMRLNC4Tb4CojIUyVeKs?=
 =?us-ascii?Q?aLPe9vZnGAgnnBplRAeeqVMG12168tEYU57ZIzBiwpSR8IaBTilhgcu3grxe?=
 =?us-ascii?Q?PKtripkqBb2UO7rlTX6/I6HIgZ/7mCaU4tmDRgdyfbzeA3+BD3A1vCFq798P?=
 =?us-ascii?Q?ydYEPJHnLhpta4cyIa2rifTc?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefadced-80d7-43e9-fcef-08d90839b13b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 22:30:12.7433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoy4ER2/aT5UtKI9RJteViGU+2ZNVgM/1Ah2fxcA0iGFrXY8zQf5Aa/5PWKwfGim7+TnvIgcg5m2s2GPWusZ3D57z62GDsnPa8koU6UR+6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7744
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_153018_087373_4557C626 
X-CRM114-Status: UNSURE (   9.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/22/21 05:18, Kanchan Joshi wrote:
> nvme_clear_nvme_request() clears the nvme_command, which is unncessary for

The above line seems longer, please check.

> passthrough requests as nvme_command is overwritten immediately.
> Move clearing part from this helper to the caller, so that double memset
> for passthrough requests is avoided.
>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
