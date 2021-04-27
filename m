Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74229C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 02:35:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7E561289
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 02:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7E561289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Ip+RzergMwoSRS8yEsNf2WK9uweHoshNbKx71/zVNJU=; b=FwnaQ55roiODfsY6feYEr/4PY
	JjyjbzF72d8tTBylE75FhvL3K/JmwqqbsJjDAfZAE1LEm+B1BXS5GdU4jBrUrZP7zYYPFItr0QfB/
	3UWyJ3uQvsPlgXMBOB033njwGfcxzaeFoNVeaTX3d5gUbfNr9CwLPLOiqfvV9Bb3k1RgX+X2R8Uh+
	edMJWwTBCHHtc6/Sunfc0dN4K2YIk8BssJF+P9FUCE06Fbo0WyVaRUUA66ozyDqG3oA8S+F3oCH8A
	/F2VbMK6tB/yb1b4H6kcdh1mN6TU5MDzG44Pwa6GZkWtxpyFL9OIp59gkXXKC+s3qgONDZ7bleF7s
	PO+t17IBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbDZ7-000Ty5-T4; Tue, 27 Apr 2021 02:35:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbDYz-000TwG-9C
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 02:35:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=nphBeCTs373vzum75E5v3KiJ2hVbGIu36uNUuqCyi3A=; b=ykguxL/QGD7LP3MuvOkWdmS90S
 cjsl72C22iqeJ57Xnx8NLdHkX43o2fhBoQ/SJABflVRZh/q3upx94RUFfmP4f/hT2QFqlXqE6jBZ3
 xNfjMdIN7axjZBMFwJmTqDMI+6gZE3SuJMzvivaoChnuWqy43xh0isK+0jYtfWkKgJegSIcL+zL4b
 EwDdQH6BCdtlsdP2TXq0xyOg9zfwvYGl0OgAxJuNgU8NUxo1zA8OrWqvbeQ0bIEGMK72sYbgl3h9s
 XkM7SvuDWvfykLT2PaPMz+wU2K36KbBlm2vL1LfFmIhNu/p0iMCvl6vKNsOoBxC2CxXWnNdQJYZDD
 yoxjlRQQ==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbDYw-00GO9v-Q2
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 02:35:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619490899; x=1651026899;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nphBeCTs373vzum75E5v3KiJ2hVbGIu36uNUuqCyi3A=;
 b=dB7FL336zdAKWk9gaBBVJX+ErMmKot08N17vakKMyW+4yTiShvDDtv3F
 9nVcint+10Ba6wxvQQN1l+74MAMbhGEy9E2E6cETOcxKx0p1I78zDRqz9
 yKNSYZceyckjfLi1v70EFOT2TJq8q0FI0xC01mh8pt/jxE0mDiRF7Ibee
 XCuONjn1FsizR6DSSQqA72szTtfH6LPRE3PRJla57f1lmG0diPWUw7qFU
 Wn0xwbOfB5TnibLg2f7m1Gsw0C5EYeGyDAb28czLmvdDeDysqIO7kQLyJ
 jV2gTMsYq5kJcAM6pHW1MqSp+dSfj4srrbCFIJJbUCrTFoBexDeWkDJIF w==;
IronPort-SDR: lqj7xs/I2UvXmi5RyqE4gCrpeqwcntfQ/KNegwJaOFLrM00uACNaQ1NuGZHbMm8e2QyMa7SPEK
 +PLQmjOcvjP73eCPmfQBjl8lAt+BLDe+wzdh1TxGKvHmKUiMUo1cmc8XDWipRgK/kzfJPQzvK3
 dcMCkYOw5UzvUhEQ8kzMihK3vBZ2SuGc1N95AHXsCmpn9BsRi2wYDMnFwUqebJejhvH79BOad2
 vyDBgNN3vJjWQbdWDMzI4ILrDruqbHdIKm4pe4rFkEDiZgWb1GM4KRFnzISzA1wTFe6xhT28Od
 8h4=
X-IronPort-AV: E=Sophos;i="5.82,252,1613404800"; d="scan'208";a="166894365"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2021 10:34:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QomWWxHtiJBU26eOzQEQlninL62yufKIkD3Fge2FQp/a1ujGlwDQgcyKWu/LZyGRgG3LLcN4A/wnkpDQIcMnCAvHiBbSPSNxWuoXqNtLzEAbjSuQnVZ9yCgS602ShNxXlY5kf3rgefPj1YmTackXe1XvjqbFoAITpO8b0KWH2ZtRtsKAEL3V6V01OcR5nUt+m6SvXduVAsrBSRbTcntAOmCXgIrmBG4f6lNZwl7QP/K6y3E1/fXQp0QJJ/9xNexL/ORjbrA47wKDn7xnhCfrACAZzJwnimIzmlr686VI1jmHastl7lZXD3YK0AwIDKBDQXSipl8FamPX4lwwyFrsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nphBeCTs373vzum75E5v3KiJ2hVbGIu36uNUuqCyi3A=;
 b=BRwognblcyrrAYRa4q7QzxiXkhGgynWVjr4Px8PXOLxIDKQFtLWXFVvpLRVQo2RuuJLTYnA4NP2D1MDkwz/2OAo5nPbKp54Jkg7CoaAkt6Ue8Vh5Y5l1N5sAHHNFCFsZCgir5qDUeLDdBpDDWlGnnaXqUpZzJ1lnVi6aSfXu93flq/0vQcgqiBP7sOr51w445+fcRSgLFlON4esDyF1ChdLSSnhbalrFRu1GkNWQUPSWQWx02HYKNC1aWU6OzmFFDt6jGqBZ71CZ6YgaRBTD6bt8K29aF5BPv4RekPOnCUMFr0R4HcPSufuhFL9HcEqNWhEohoYa9UTlfdL2L0bnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nphBeCTs373vzum75E5v3KiJ2hVbGIu36uNUuqCyi3A=;
 b=SRL0wgYroSzvE6et+Ui0gq60UByCak76DTtyN8Exg+wXFIUSfapbhqo1Vy/uaNmXKPlRLU95Szv+JO/LvYCAzaVeWcHRDbyUQThVldQtf+kCfZ+1vbM9n8VGEAPOqFYwLLGZMDFDTzr9qnjeHbw+9g3EqAbx3WQGr6XvslCwl/c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 02:34:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Tue, 27 Apr 2021
 02:34:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Martin
 Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH 1/1] Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] Generate uevent on namespace AENs
Thread-Index: AQHXOtyJpVaoq+y8XkGj0nRxvGy4XQ==
Date: Tue, 27 Apr 2021 02:34:53 +0000
Message-ID: <BYAPR04MB49656A4930E8A4367DFD9AC886419@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210426202842.42096-1-nitram_67@hotmail.com>
 <BL0PR13MB42914E1160F96F3EEFE518009C429@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hotmail.com; dkim=none (message not signed)
 header.d=none;hotmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acba4532-aafa-4eb0-b692-08d909250a2c
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB6884D896D08E9455D3DFF27D86419@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFqAJCG1fPWpbYkdBwEUXWVCtmGKUMTY4iO9IxTExqsVoLfLTy7XyzyDKWXzkmCRzCN1Ano0k4/AGgV9PRv0XXnmoVQ5Xk9La6ytYCxcGNGQ52Zvi1+Z1pwycABN3BNfXAqbQSLK4KyCDhnQwK3WvMJxORVhMJLwygLGrsPt/Sr2ISqKdKLC+yDWA4+d3KNk61WgER7U/jZ4rF2gWJx38Pb94o0YtOvmGwEjuIgY5of2+Hoi0biog8RreQsHSFMRHwKuLSN2qcGrXLHH9860IvS+x5caliAXlXXzKFnWX7JsrKZWhrmSWvcjHWMg0tHgtxkg+Fo6GM+oavc+lSnfCLSFGJhiIV9SreEWVt2GFSzjZjD0G7M2/DNJtjDmrDiLRdpne8bYYPDKInK8kWwtC6k6o1Cu8Zq5FrnbwG/L+4dI851kT4GYMy6Wva4hfF46bSxhSIfhN7hEBnc8orcnvvoH/4wr8UjzJUCiOIvlLirNflQkPI3V2ET4cMIDDyyW1F73vXqhnKeJSfZIZA6/+iSZAIdTw2S2M7Jk+ZRn13GjdiDZMlbnDsnVi2oAQJ9wPX0COM9jkOtfln0Ur6B6KZpUM00QUm0MBa6b91KZ2ps=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(55016002)(66446008)(52536014)(9686003)(26005)(186003)(478600001)(86362001)(2906002)(76116006)(4326008)(110136005)(53546011)(8936002)(6506007)(316002)(122000001)(5660300002)(558084003)(38100700002)(66476007)(8676002)(71200400001)(64756008)(66556008)(33656002)(54906003)(7696005)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lc8XaywWDuIXENALccZRiqwzsuAvCTzIcKXgEo0mfK8vprfpcNcYEuwwvat1?=
 =?us-ascii?Q?PI8c/1+aK7C9oO5W+LOzgaiZEyR3SqTDsbXbZqgwgxzOXrjdeqZHz9KZ8FAH?=
 =?us-ascii?Q?MbKcYB9SZte8NZMluqAJvj3PNWL8duITcUIViyAm26XP4iEwpdQPr7vZ01oL?=
 =?us-ascii?Q?FP3YnuJlMgvy+hieK76pCNojqWc0IH2uqDSG0Q+WLGilMxCvX154QD5N4IwX?=
 =?us-ascii?Q?DhRJ2gB4ljki1i/6Mqkin6jEJEprA71VjLAUNiBa5+Y/Hfsr2BqilxBVJczv?=
 =?us-ascii?Q?mdUMzHWIndswDWtkS+hRbg470xo5Dncb/bXVVx4LrCofAicBWoXPG0AyBfJR?=
 =?us-ascii?Q?NZ+t4onb7RP9vCs7Mj06wNlnq7ZvRyQjhjq2YOwj1SfHGN7bYdi+rcijH8i7?=
 =?us-ascii?Q?aOhgYVyOlxHxnC91HMB/TLPfpKLlaB6xJG9L2zVyH5lAuTggKCDXo4NOiu8K?=
 =?us-ascii?Q?dHH6YTfZ4IQKbsJrVC8xWsaonTXLNISK6IDGDTlEOCSPdCnzbCnb7+n24jW1?=
 =?us-ascii?Q?go5fROGMGWPhlfCyErRoCzyfthziqHiLuwn1XzFpQ2ENP/Ahkf9Qwly8j6OF?=
 =?us-ascii?Q?fwSqrInGbcn2pIBSx2mChBBMQMBLUqko1KduNZ7inMxSVqkx5fOKoD8IOmcF?=
 =?us-ascii?Q?skhd6+DffUeJD50M/bSmvxkaHqRtOmDfv5pcxI6A2EkULh1kx1O/VmD4W7GY?=
 =?us-ascii?Q?8EB7VH22n7YLaeGe83uNaIjEVs0uiR5zhY27z2wuypvrYu4ocjEx38NQuPRu?=
 =?us-ascii?Q?hFk6dFCIIJ20OQjogaa4d47rEww19fccWbBz818x5xBgPRYTGjV1Jx3gZolv?=
 =?us-ascii?Q?dLYK1ptHnjxvVnN+PjOn9hKNm+Lum0edzS1xQoBmLqkXEk8wH2kaRbQ5G9Si?=
 =?us-ascii?Q?TC2c+DoohdXS5CSXzPVD6Znm2LudgRMQz7PnSt+kehws9trEowueBEbpU5Rr?=
 =?us-ascii?Q?xgWIH0Bxne+sqh/I5Kth3e2Jh4Uvc4oTTEQXL1nrZk4OraXW0V/gvFLZWYsQ?=
 =?us-ascii?Q?lSZfc4LXdEjSlMmgtnjhtASqym0bWLGKmUYN/FAxNr5l/Xe6u9i6d4R2op32?=
 =?us-ascii?Q?hYnPJyasghohw5TlwniqtpPbZuH6td+HptINng9uhwifiD1Cemd9cZBHiXJi?=
 =?us-ascii?Q?YTkR2SP9tgl2wGl6QhAlO35MeTwuPb063GRnjISJXMvd3l2nWTmnkOgq6TK4?=
 =?us-ascii?Q?u90mrqL/OXz6CPXFpegCeUGBJWtujCDsqqopYLuEo815ibPFVjQqCB6fX5nc?=
 =?us-ascii?Q?k0LyEuHDFySfaG8anmtmMcLNQhQN3eSdcK9NGAVItJwTeXo+NdNGIMQiPYQn?=
 =?us-ascii?Q?AvlQeJWoMi5/sEt/4D0FT19f?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acba4532-aafa-4eb0-b692-08d909250a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 02:34:53.6799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZhVVy7d3/Mx7jRO99f/dlhd3aMMw8eZ0Gq4RVbQvDkqJ3KUpm8b2ByQXRhxu7b7HezBDmvRJtCONK8C1sMPLMEzhcjX0XTg7uuAaozCIfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_193458_927950_396F0A46 
X-CRM114-Status: UNSURE (   9.78  )
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

On 4/26/21 13:41, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
>
> ---

Please resend the patch with proper commit description.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
