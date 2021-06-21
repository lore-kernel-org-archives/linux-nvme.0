Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DDC48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 02:50:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6676113E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 02:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6676113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=RLvXXZef/7Hb7cVDx+9mzebCegDQOX7ZKpWzVvz9TqE=; b=NFcsD/06vWFkSI
	KNuibJfPJ0vEo7gcZC3OGxsPo/YOYbDMf2s0m/2cbroaS8pBfDOl0Pe3GlnVJlA+/eyeK5KOm16wq
	W7MYwdMliF20/SevLvLH0HBLMiLAHUCbwK6GyuhrL4xvd5eYGhQ4fJ4ORjkoGAKAoCu9lo/pI01ZR
	maFaZV48dd3STSJSSo76vB1a8dJglcZ/0wqnYA52EeRDvl4r7uTHph6+zTF8DsXzQyVK8AXPlP/8x
	Dc7JcdKs2C4sbrQMYYllKZcxTM8Z3j8P+CmJFBQJYK/woK5afki3+mufFrhQhZnDvcp1yOVJWWgAm
	j0372hd6M4B8Is9ySBMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvA0R-001uZq-JO; Mon, 21 Jun 2021 02:49:47 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvA0M-001uZO-8w
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 02:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624243781; x=1655779781;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5SZ01R13VrzBPReF4zcvkSiMX/X0n9OmHAJPkqOiRZQ=;
 b=Af9bTveuyOtYdeYR5Y7gaEWPkQQM/vS3GOcLEFRtQf3q717ZkleG05oF
 8L+KEYoIgjidK3ijV/jG4SIntTrXP4cS7Qp3wVvdMZy2bH8DIY8KKrcnf
 MYTehgngZ92nNBH9ELu9i3A98aLd6jrs+jODahQCrzJ7DOZLrdrT6SOwq
 Zeyitdu3OOuLoN+qYwDhVeUsbi/v/9l8teU8rl3q5nCv2WkTW3IYxKyTf
 fd2RUYciDrYDuraQtkQ1BERjJWYC7crtJKJaIeJPTQNG/ojO2fxBkeyOl
 SV02n8CbZ27RsuEeOo9+mSk9F6rZeanpvCp9/oZEjKDlbePu1x3JHWPuR g==;
IronPort-SDR: fcu6wQIPPr10U0Ghw4Ry8PonejghD+47OLN4dP9rWm9uxA6xnwN/NvkyhievyN9+hDbuyHW8fc
 TZVDpYScR90RpYXmHdo/br+Z8wFLOtIyqqsQBvqVDe2QDbmX6AzX0K+u6zULpP+Zlm2dENVSJk
 NYJKEO20j0EKRJcDI+U+zhk2W2HfW9r/xB7XcfzeGqUo6W++h9Xoc5EPEv/9fu6zN1ZWYkKTGm
 JwkKKkqMjJ1FbKr3BpT0xkLsB6dU3E9FXXxVcfvVwUyfEGtPqEh8doQl85454eOuueXjthhtl/
 nh4=
X-IronPort-AV: E=Sophos;i="5.83,288,1616428800"; d="scan'208";a="172444299"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2021 10:49:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4sTp2UaE0bS11l/SRJwB47ldFJKyPczMSDRGRNrdPPh+fLZGh9XTJjWowXIh9LGjTXyFSEj4/nwj19JQ6EGwauNV6dNTaZsWapx7D2MKGh6YRRDQGrShqTZZHmJ2h84NVp5RmYKhlOCMFvwgVNdCWzdXYnqrFiYnUc5m8PskqFugjjhFLJVMpMR9bR3j8ijH7Ual9QURCR0qFnzJ8AH/vxCsmkTSaaNdP++Ze4mt3eNEKwGo67Z5N59k6eR/1QDeMK55glLfc7Jr1HAsBWr1uCLlo26nlTRzxUAjbsN17yxz7P9yPfsuA35yCjhtvpb6Idr0+mOkT9lRb6yms716g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SZ01R13VrzBPReF4zcvkSiMX/X0n9OmHAJPkqOiRZQ=;
 b=iT6JcCqgWiPwY1d/JTaJ1HNPhsO0vZO/Vm/vpRhqd+khScV1UzLPgY+EltAAdoafC19UJTCMjWavDDfnMP5S0sWeAQ6pgFr9TCXDcLQ/6D3/3SmGdqbPNoKqo9+vj0Ph+19SQyBXYCctpeCs21qKbsr1UKXlwov5tm4yCct8L09vJ/XnDAOPgva+sqOlI/IwgE7KUStcMpMDpHNqZOvIz7Glvn5TXeKEg4mRTYNeDrmuThU9DD6waSKK3QcnXSzde1NkpTbs1JQDN9dvhmk0noLuLmZl1iJ8S93EwfaVJ1qhd+prkhGHDA70Sa9NZrsa5zx8+SG6x1m1zNc3hGM+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SZ01R13VrzBPReF4zcvkSiMX/X0n9OmHAJPkqOiRZQ=;
 b=lr3Sl5s8kwtVCaVPeM5ejLrzPlcADCMlYt2fXB8KMuDwUwn+4u0dMpcjpkY6PyzRMvPWauSPOZSbxtwYaAoD02Z8pPvnA9Cgf7taqGOPwF0vLpkFg0ayEOgaEDagH2NgFIjIJ/cdf0XDntHGQH+PblIE8we+G2toPsq8OfhEGXo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5590.namprd04.prod.outlook.com (2603:10b6:a03:108::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 21 Jun
 2021 02:49:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 02:49:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Ming.Li <mingli199x@qq.com>, "axboe@fb.com" <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] remove all blanks in front of goto label
Thread-Topic: [PATCH] remove all blanks in front of goto label
Thread-Index: AQHXZN+Tfv3RtE1rZ02lAUINrHoKJA==
Date: Mon, 21 Jun 2021 02:49:33 +0000
Message-ID: <BYAPR04MB4965105142E9D0EB9FBCFDB8860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <tencent_B28F4F86583B12ADE15402FA0EBA8CE87806@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: qq.com; dkim=none (message not signed)
 header.d=none;qq.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13db528d-79e2-440f-31db-08d9345f333b
x-ms-traffictypediagnostic: BYAPR04MB5590:
x-microsoft-antispam-prvs: <BYAPR04MB559015B4E35F46B17C45C0A5860A9@BYAPR04MB5590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t82FH8dcjHABLW/StgfqoRYOZG1gkaoRyVYVYK4S+Hs/K1Pa+jW/5pwuzsckZdlCiPKVT+Uc5VbcpGXoQU47di4upzbVpN0IZAwkDSikWMmqOSqyMEVIVMFkNhavRcMPUnP2J360k5DpMG1h4Z/owJsddKqI1Zem8vUKvl3oduB9gRBaARhvvwrEtsVdPM2cZdAQtJgwUVqdmdq5JCAavwAxZHXQ9MBfY+OBV1ZmBpHyDBTFMNnoRVuSogqIE2ZuHFylXrh9nevgJ/j33844HXJyIIe3n0WYbXureyC4JuXs1zY3FF+a/GI+R8OS0bhqVXsjJeNFl7DFcVmPTYRDe+5ssoy2faAbWyeYUixFTceKvmOMFno09tXP9/Wk3mQpdSK2uzhbmQEP1G7WB5kD3Df5PZMHHY0vF8eBsOReEbapfewn8kaRliui8tuoBM08v1ndtL2lONaD6uj0Hp0pdpDmNBwN6dd9/J/6W9sPT30yckzniyD9QYyM0UnzJO3+66sFuhZvwKBXToDT7Ku6+3DHTeyKtB1OMCD2D5mHOGHj5BrmCyj1YAOcYe4S1I29hKfcF+AlSE92YrDlTjlmDAyQD5tzP/1GAw0FVzGrRPE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(186003)(558084003)(26005)(110136005)(9686003)(86362001)(5660300002)(478600001)(8676002)(122000001)(2906002)(76116006)(66946007)(55016002)(64756008)(66556008)(91956017)(7696005)(33656002)(6506007)(53546011)(316002)(8936002)(71200400001)(66476007)(52536014)(66446008)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEJPTG4S7HcYyAb7UCuUR9gSMLydjtzRtBneCoeFKLHxQp0IR/JYjLj3zZmF?=
 =?us-ascii?Q?0EoHr05J55CUkwQhCT5EsQawLb7ARWXkOkvURosPSB+sxN7X4bp7eMveMnab?=
 =?us-ascii?Q?+mf3J8LcGn8MflB4ixsdWPLDUENnUgnXlISTEnas9kLrHexCPLPRCckljTQg?=
 =?us-ascii?Q?iPTT5pN8OJrSWKmpZWlRU/1gO2e/5J6IvoqKkPme8COeCPtBAYJYnBItxIVO?=
 =?us-ascii?Q?KTWZH95jd46DNJQhZhc+SZsnOC20WjSELiYPY5pAyGrgFsyNoF5ovTNlXJVh?=
 =?us-ascii?Q?UXK7KndwxCd+IIl1DOHb1rF8rLc62HVkXhkUaboLhG2/DuXhycmIqhAlUMQm?=
 =?us-ascii?Q?Jl0DkmruKOFlwqQ+ZsptRaqgq9UZklygoDR6b5ftB5DzF6/hh8vGpS+v56V2?=
 =?us-ascii?Q?RJcSsHVF2Tz3xZyuaIY/OBshrYCCvspn/hkZEzNrkFIDii+bOnBu7Uf4hAWn?=
 =?us-ascii?Q?p6ImJnFz06HblgYwzaYGlG/5QnNOeYI3BvezaWSQaqa1qaLmvYIFyJg/eauG?=
 =?us-ascii?Q?EEynhZ8Ztn7Ogn3xtuEhJsm/tMaQ2vkyIQvtWfhzdq1NQ3Sna63GRYBZP5qa?=
 =?us-ascii?Q?6d00SfaeoR+1ubLPhyrxAkLL55TouWA+xNa33BcROChFucajCkgX5f+YlB81?=
 =?us-ascii?Q?uSW9oDZV0jJaaN1dAQX6QB2MMD7dpIEbn0cKE72Iwe+05e+fbhsKe9uxMYfG?=
 =?us-ascii?Q?Xr6gxe92R5tLbpvhB0NungY6pE/96tTWCUyh2M0S/a+EtdcpDv12/BfVw96M?=
 =?us-ascii?Q?EH1D+TMj5NWw6FAdRJgfomB9JknVdfHBkAKMW4EIRvItomcd2EM6ZE+mGVG8?=
 =?us-ascii?Q?YSk/646rEEIWDY7x/4E6b/5L+Z1ljIdq5W3gsehtaYI2ZaOjyMwBdQ0DszYv?=
 =?us-ascii?Q?oZR5fClnePFbAIkXK/pY9iclyr4p2fsPKhlX8jw6gS7WMApQlEFthCAWjG/k?=
 =?us-ascii?Q?sBpwb3Jc0v8nR8AC5F9q88uh2TuPj+t+GXD+7ksVevvGR43UWCz0QcTNJLKY?=
 =?us-ascii?Q?wtk+q/4sdGahf5o5fZd6EOeheCV/DPA6H1dkg1o1nmIL/oYCm2kGodEUiZU8?=
 =?us-ascii?Q?7lTaeL+fGBzK9AO2OpPCnJ46DKpvimMj6rzNg4OV46dsjQX/HNZG8BV581IU?=
 =?us-ascii?Q?eXrhI4g84noN0VzR84VKhtldFrLFaP3QIb6ijJg107GKbAHg8twyF/QQatfk?=
 =?us-ascii?Q?6djbZsfNTL5yQrfuNfRG9h2Ur6Hi8mpwzeuofCw4JUAMFAuNERzHCyvWhGCb?=
 =?us-ascii?Q?+1ZCTiHgOwP8rDY6EqoDbEu8+53GH4ds+qDfu4V9s8Svglq/IqRyyqhwg5xR?=
 =?us-ascii?Q?PMHYfF46gTpI1BJTp09YLP49?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13db528d-79e2-440f-31db-08d9345f333b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 02:49:33.3801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIAT0nZWjeNMmnEWGDx5yT6sFzXeqIH/6C9jsfguUS1dE+5GFUVpONK45+L72x7sfWcFmatKfdkWd78NJkjszz9IDVuXI9xPN1dXSnz6BfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5590
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_194942_459004_8DAA01C8 
X-CRM114-Status: UNSURE (   8.50  )
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

On 6/19/21 00:49, Ming.Li wrote:
> There is a format style mistake. Some blanks in front of goto label.
>
> Signed-off-by: Ming.Li <mingli199x@qq.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
