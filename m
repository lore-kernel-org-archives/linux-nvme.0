Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7115C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 23:22:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8380E610A2
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 23:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8380E610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=SMKOGkqjggpAj0aTrjXwNLYNCekeHllzIis99uXBgEs=; b=d+O4F36bFXl4+qbVEW2+7i8nu
	7w/LZR6zSM6uX1FiXyJPYvjakfTTbA3NvW3TbwTCByhFwC0WudJJ+3c4PupAklJtih/LKjk1e4pSZ
	PrQIVm5gW/j3w+oR6HiHR4HjqWZpBxiCPhpwRA0DMCo/zoPye1H1XUipV9cJeAX/apyoTk+fKsNtI
	q9AivbywfqB9+l2gOVWWDcsQVCij0GnImT1XFeLmVN1UWJkwshAHKTlH0FBLF/p1UpqDae6eu2W/j
	8H9ZnYL93pZSgKvP47GGiVeqby9vaJJAyKaCVVv1F+coUbRxEzRMAj27qMd3nejV5U1ZgkdvS8I7V
	Q8LCsB73g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldhsy-00F1Ao-HM; Mon, 03 May 2021 23:21:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldhsv-00F1Ae-R5
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 23:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=IcN7QMWL0KbEPYwOzBXDN2nToOqKiaV7P1Zw94ehRHg=; b=HI47AYeVOfzap7hiHs9MzgjmfL
 M3+8Jkkmx5op4/aI8LlyhAUaCySJ+ZBD+HGg+7rM4ozhMQppT+osnQpHiithdQ2TXOLrwVKHhLGRe
 Wd9VX46XFo64unQBcB1H3I4ujrjbAVpS0HbFy5vw3JBSToNRPzQYySkXYVnRnKD9Ndo+BRglgBwNd
 rW2+ZFnxqqgu6p5i03Pn8FdL7V1CuFZKHYYfZ//iWtT0x9+Idpgn/NnHcllhKbpfSZywMnEPIGypL
 EAb74vcGsitawMogI7EOMYUi2Zel/uTvJaXfCzGpBp0p18kig707kFqBnAINKhGmLGXWxLAnwpjwN
 ooTCed/Q==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldhst-003Y1p-Cf
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 23:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620084122; x=1651620122;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=IcN7QMWL0KbEPYwOzBXDN2nToOqKiaV7P1Zw94ehRHg=;
 b=RdQR8UvPpNKDWUQQphLlo6cu9piM5NbIefJSaW1Li6o7Xhr66BecD5ER
 7pVG5o2tzQPZFqa0ula6lrofO3THKP6HFWT2pVD/upGTifoTbpQXPEk6E
 8mTHIb12W9yLLh7N2YxUrcYwWVBqmSnSfzkbZuCqjlS7jb66+6sWnSRXp
 CPWdxqE1NrniANLmevRlkYIAhWyCb9YjMbBFVg/eHvx81K2AGYDgfKbzC
 UtGqfWjXQ1M26izkSBb02maES/8/brlNLa/Sqr3cbH2visO4glYsjQYX9
 pytPOqejySBeaDNozOuG903FHQ5djDETCGQUnlo9YgM6GNrOjs8hARE3J w==;
IronPort-SDR: IdYJGvihnVdRTC+cjRKOIuJCobfYg+RtN1Fo7p9fCqlX0aCeTsRLNYHBrHAshKu1VS+JmkIgbU
 cYP0+z3rsI9iXKzOpSL2VTr1X0LjTJoTMWro8j3wG8JuOvqEI4xigWYHS0qT75kWBl3oqoPaQb
 YnaAr4bXExz4rnOYZi8ySBERM+BDfIwQ59fGMXmKmzV8bSXOkfuPYhW+tsQod3XUZKiJh+NGZj
 R873QWcu0LPFX6dQpSoDdCVbIR5UDT26jvvN+38zm1nS9Te1jllZfC8hc7E1zp0dMd8Rz3p52s
 MEU=
X-IronPort-AV: E=Sophos;i="5.82,271,1613404800"; d="scan'208";a="271014915"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 04 May 2021 07:21:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNce7S7DfSTsPbrF6BD2JRMD/xkeFdYO8vrnvntDcw6trEnP1A9DuS/RsfrWPBAVPBUbRgQtqjlK7hvbOAOeUkAtJVWVyz60+mxwIF9v++MgIc4KfEOTDyCWaw3czxelkToiTLiSsGcRAiO64ZApGtkieAYzOaAp4nh7Q7Z7BLSSt66w9PNtWFA38wBxXUOW4mjWOioy6KRBbKdWvY7gGzKw5Iq/nRqkp1uQ2Ym+SG47iaK6P9ltoAJfPKfTJvufCIWa02+PV7+Ph8zoB0IWkIJikh1ECkWNoMVMXaiJHXzqZ8j1DNd6DwLDbxieCPw1xDjwtXwBu0rIa9EseiSPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcN7QMWL0KbEPYwOzBXDN2nToOqKiaV7P1Zw94ehRHg=;
 b=SVw2EQkuoxJ8TaGhCI2Nmi/++qiigYBrHMFielYqb8sVNAxLfp8cMjVlhgSsafH2Vi4DICVsC9YaXfe7i4EbVVxzvIIA9yFRt2hrqHhgtAAgTLvcRNSviv9EziG1hQRN7YP2TOe1Ny7CRCUjFAHv9GRCmRpNiRQA0vocCfjqz2OfzUv49zNPFmQ21eEFnV3FxFvkJNJQlNGXDKWLKaJKssl25H9L3mHVnR7+b+1lPBGYh7R0kysgTFR7Kq+DX7aUDS2Mltc6hZUal6ltEHdr6oTsxXBPyoiFTKlsIRbW3KrNXSX9I62MzqsjpA8OmYNb+Y0if+S3kWdYNC/MGpSxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcN7QMWL0KbEPYwOzBXDN2nToOqKiaV7P1Zw94ehRHg=;
 b=fqTxN05PF4+bYx0FqcvgIhMK1Cq0S3VhUxc8z50Rt4T6IbXXyYevLjjV/Z2qTjecyAtHskAmhd7ABF9e1fUS2YnjO2S4/Ii6pA+6rKHpt6pCDK82ge9xb+cN4E09SkbTupCrpQ+0FH2b1damOlKtL6nhXlspF4L2NphkO2i7I5s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4039.namprd04.prod.outlook.com (2603:10b6:a02:ab::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Mon, 3 May
 2021 23:21:47 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4065.037; Mon, 3 May 2021
 23:21:47 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Rao, Vinay" <Vinay.Rao@dell.com>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>
CC: "Belanger, Martin" <Martin.Belanger@dell.com>, "Hayes, Stuart"
 <Stuart.Hayes@dell.com>, "Tarikere, Madhu" <Madhu.Tarikere@dell.com>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPG0XeEN+DoD31UWTKCt6MGrgfw==
Date: Mon, 3 May 2021 23:21:47 +0000
Message-ID: <BYAPR04MB4965C4F33AC9A888930DB272865B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
 <20210503065235.GB32627@lst.de>
 <BN8PR19MB29290320440FE9740E699BAC8F5B9@BN8PR19MB2929.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68ff19cd-aa86-4768-db74-08d90e8a38dc
x-ms-traffictypediagnostic: BYAPR04MB4039:
x-microsoft-antispam-prvs: <BYAPR04MB4039D311A8B0B2E7AB8A7CEA865B9@BYAPR04MB4039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDjqamkgNKtvU8AJ5GYvzls2ZnO3LRKznyWShVhoXnK4HBpbKqlMboFpeWskvD/dMKdJPI6gkJOLi5XBEFBAgu84hyWudR/8pfJ757XYd8P8cALD4x9siI1V0OQGeF8xBu7+0Y+nwj/+a+k6vvG7dPpzjrATsBnBJ/r5vzra/4b9mNmQO9h7Xf7D0nbGXczth67FKeUE5V7tI8V5P74Qk76Q6jQHSgqs5U716nShg6LbOl/mOzwb45SHMpOo3g2MbZ0BXLo70cG4/sL1/7AxK3PEoqZVByJFHgMlrvPACtTTXfyon+cBY1G4ZAOxG/qzxnItqB/fzUAuPh8UDNtAKOnqXNwUdr6tDnpSz6sDW0FkR4L76Gd+BLohqSlM3tUZbIt0n4Xai/vYxfZZXUyjjK33L13aP+kV+KAYKO3BBchkeFU6HBK4i4yVtKQ35Herj29jtWpC3xMpW4/xMUmzN2RGS5OX8CfdUBftMdjwWa7uWYHeScKaoMA5bFgrioUsQf/BwH4HNzfjc4zFc2lGXp8YoN27GQl905JwR+DkvRTR1PICPNYMzxfEGPdda0LHOZ+HKJHI1SBXt/qCFD68Gr1aioVyLZPdcP8bsjNLH7M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(55016002)(9686003)(8936002)(8676002)(33656002)(76116006)(478600001)(52536014)(66446008)(5660300002)(71200400001)(66946007)(66556008)(38100700002)(64756008)(66476007)(4326008)(122000001)(53546011)(26005)(6506007)(316002)(54906003)(110136005)(7416002)(186003)(7696005)(86362001)(2906002)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9TO+QINxydKIO8jQ7nO/SiEFniwHBSHEwirFw1fOXkXlOM7Cs4BGxRxRRZf6?=
 =?us-ascii?Q?V/l7Y9SvVe/GTEAJSrjPvrzNgoeE5Xmt+ytppvTNNlwmFTSogXl6tS4iDEL7?=
 =?us-ascii?Q?7ZS39ELnAHbVGMcm/NQekOyL3YEafJYvaY4ZVmkOFvYrMShEiVKikGTWS3ha?=
 =?us-ascii?Q?y4Cj335vgbk9YD7KSi2wI8Sm4xZIn1xf0ZzC8d1I9Wd3gGl95RzeANvkkr0d?=
 =?us-ascii?Q?J51u3n5Hg5IEX/8+X6dMcWvWncZtzMblsTq5wDFZZqePOk5cglXic5253eDp?=
 =?us-ascii?Q?Fd3mdQqmzuregq5IgBhj79pjFjxzm0uA57Eisa7YTSHu9WGjQ1qOoNON/gg4?=
 =?us-ascii?Q?VKHYcdE+i9HvH55Q2Z/8UP1tIUs0RqS2sJKlVR9GRRB6w/I4po8TbNFWPEVO?=
 =?us-ascii?Q?v598WwZIV3jWksm13H++bww78apNlJnWdol28kq+yln+QGkZgv8msKlj6Ths?=
 =?us-ascii?Q?QZ4HD5fT5PuoB/YXb9SB+BK3SmMIEzkRWK0uXsC9gzN/OeXSe38cW7ItLzKy?=
 =?us-ascii?Q?NKIS6Dnbwe81WS3kZP4Jc6l/v4fUUytPle3CFct7+QJ+ZfsiWLt9gHOyx0QL?=
 =?us-ascii?Q?B6DUQDWM/uBDYgM2CxaNbeaw5nNLTAOwYvTUtYwtDS5VMSU+ttYjk7HO19kQ?=
 =?us-ascii?Q?wjl1WuJqiEPQv9Af2DvsLsFkNUhIP5Gp0v+AY01YXMwL7gIy6FxAcm+S0whW?=
 =?us-ascii?Q?l1mSVJjXztE4q4HgrcJ4LAxVY4oIifoFczGf7+7q2hBRmw0fxgJDRe294yjf?=
 =?us-ascii?Q?klUxAh0YQZ97KZmA8nfIwqvNuie7FJWyzI5+9ziTOix0OzvegCam5HqSPofc?=
 =?us-ascii?Q?HWlmksTbKSiQkVy18lLEkGhwotvvSLuml9uyXnPPo/GhB1MO+EqmHedWfwAe?=
 =?us-ascii?Q?8Y5936dSygTU+qBtY4c1SlNnavhaCmaocM47sDXOJN9zsM8TI8U9r1Qha7Ro?=
 =?us-ascii?Q?JJJs4swNnXZkl4VY3EsTYZkkDMeUxug3XiYytQpw+xu8qzMm7xt9vzSjhjUH?=
 =?us-ascii?Q?PEI0lWaYJfjx6EhpggIGg3RPT57wbaX/R3pQZQHwpd+WofALM0I5UKR2azcN?=
 =?us-ascii?Q?AzLBNioVYiA76akoHC03l654xs/4dD8sSkUJzqkEcP8yn1FxbNUAC7OeaYtq?=
 =?us-ascii?Q?l+lvuZBM/Q3rAVjdDdFMs5le0MHQ7xaesnRTIPPdIMRgi93cW/Xq03oR8s0u?=
 =?us-ascii?Q?PmExVtQQPSJ4zaVtARMkhT5nOByFgGr+4q4EUTNshoPrYDszBA3dmOCm3yxo?=
 =?us-ascii?Q?hNY4+ZORTnOPpx7p/9zpDUeE7ayqgqXyZGSfPzyUMME/rrJ13Vi97GzOFouk?=
 =?us-ascii?Q?bOQq+hyuii8yv8gKsoAxOnFH?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ff19cd-aa86-4768-db74-08d90e8a38dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 23:21:47.0210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+nvPBQtWpPj8My++T1VZDJkokOSGN0Nx2AzeFCm0mNTxh//On5sLk/w8BK23YNWJMX7UAb8HJqbQY9CM9NgqwekTLML2Y5H4Bdd4KniE7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_162151_518575_3F6964DA 
X-CRM114-Status: GOOD (  12.08  )
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

On 5/3/21 00:21, Rao, Vinay wrote:
> Forcing RAE bit on all the log pages that kernel cares about is one of the option.
>
> Can we also think also think about an another mechanism where the kernel would generate uevent after kernel does a get log page. This would make kernel always to get the get log data first from the controller. 

to read empty log page ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
