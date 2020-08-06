Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325D6C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7042173E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bw/a5sYo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MDUsEN+d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yNnCXwOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7042173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=rJmRZ3RM+PCJmnFki76FecGuum2GuateDkmmiRNu5jc=; b=bw/a5sYoA93wSifEna3SKzHUp
	x3swK1XwNOU7Aw3YjaHTEz15VLYl/68vIGboKb0I+G9JzrRQPe7cE1AZvX9GVJqiNvT9DtL9qR4xU
	0u96c6p5WgiZ+yM9Y684lsAApHaK08JiGXmWdZPvQpigoFb8VApJ6M95c3mGQ5SmOotI2g3HDjN9v
	sRCDHRFeaqUCvGLMQfaLak3K0BHTidDSfUqkV+dh2KNTafFxpf+44iKKg6M6kz0b2KHdwO9Qja0wX
	NQrmwFp+4C95GcY0BdJSW2YQZK88WPsRi4BYBtpc80wCVsOH9DADP6b3z834E0D97Y4qx8/h1+nSS
	bbgoJmwbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3m1K-0002Yd-O0; Thu, 06 Aug 2020 19:57:46 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3m1I-0002YC-NF
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596743865; x=1628279865;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FEv7y2QVsGjMH5Na2INs2UyHp9Zjh1+IH5aBKIxI2h4=;
 b=MDUsEN+djj9i60PSlU5A/OD8VgwBaA6LZJxoXIeO86a6KnkxW3LIsNj/
 5CRvOzqK+Q2EdjgE6y/WrxFASNKgdpAcVYWHMiyIl1b0LZ4eOl2iJ5Jg7
 WE8SZWtlq/T4cNuc9zOFYBwX0caXohc2Xod+NvdilELHkd2jmnj/PhTFa
 tOPScbLmCJBtbddFTpp/qfQ4YcRofdI1EM6jObdrCkgb2rB29LUl68VHr
 mTH99qlOrTcaeSyXuN3yg/rkM/oRMnjD+cR1dthNulzf08n7QvJfjr7P7
 SAkXKnp9zGXwC3RT5tuYaYNn0utHeYIhozSbeR5+5W7uLImdk/wYQAmF6 w==;
IronPort-SDR: mnVESk1F+a++MD5JzKkgJM0j4GoVC7PsPP35lugOBILTFUIvo381+pdeYJh/gtzOKIuHmXg7gJ
 TA0mkA0CGyGOgAiOnmKVHAzEv/FRBRmuTL68QSkq35wOsJp7X1V0QGAcKwWNTiNqCPVAPwPJAQ
 wSwXqzZAdeWvgTKDkt/O/oMrOuHcdcbA68Mwon9aECjIxLWF7w/RedFb4UmmabJ8JiFTNJxkFa
 RjqXf1fvlL32EKc1klYEeL9lHSOdeooEMPBH05ZmMBBIhuan2ZBB0xUS47XkmT/RfaVPgoOft8
 8Pg=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="148645660"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 03:57:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXs++tSq4mHvGTKZSUgmPFo4Ayv/XHhSsxqhrJ/mBZGwrSAUWvmUPik8oLB20ANHsRz6E05GifanlPLyiNgkGY/rK5Q5toubWCSQ/lTKcJ+lxTGlfOf1cXi4RqMTHurCqusTxWRk/Zh631aDXRk78mNJ8nyTctkFVAqtRlBG2iHUs6R4AWAmOn0ZIlLPLup1a4X3UkCll/hkQNfqf6IvBBEdpI88zg5eO2yUU5FuGB/qR0dkpit3CDbTSuotn4XhFbmjVMJPRkw5s4MLqt4VuzGR4C4h3D/SJXDL05bkk8JU0UE82KU8k4T8fxNlI1AAka6Axht4ruWu1m8neVDtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEv7y2QVsGjMH5Na2INs2UyHp9Zjh1+IH5aBKIxI2h4=;
 b=fYyoBxcAKNc/1QkuDfwENThWqZO7EQhzTwpZ8HECnlWRxQFupya0Xh6aMB3ubKyKwF699OWYm4JsZMx/k4XiYOMCge6RUY56Y/IYs77Ocq0sQAUnJUYcIdPvr4vVBv3VlrmcccGdjwYYofyZsDdQecYCnaT8tBMQiCUTTDmOLTs69BbEb3AA0jOz83M6igNJYSGureUdburYce/srMM0oFSHD9DlhiV4iIlGs0EV56TwykU9UZz/NvWiPVQOFC3oEcLJtJGNIWgGcydr++aoaVDrmxS8auPaNALQZJe+TK4ZKc0RAQZQZwPV+0EQoZhGDHgW6aPAQkUiz/9BwqXEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEv7y2QVsGjMH5Na2INs2UyHp9Zjh1+IH5aBKIxI2h4=;
 b=yNnCXwOrbcxEjrb3HiwYln8A7GXvvORL6UbaCJo47cEQ4dmji9kCVx8QSzORXL+DX9vB2w6nWyHAN4KvSh4R8cv014fIfCOP7ykWGhrEw1P/jyXs+E1WNnXhvbrKu/4VkR9eSl4yKMZFPh00lryU2KiafLaf1q+DHisSqJaZpHE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4136.namprd04.prod.outlook.com (2603:10b6:a02:f3::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 19:57:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 19:57:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa8OqKK/52UoSzkecfpDi4eSGxA==
Date: Thu, 6 Aug 2020 19:57:40 +0000
Message-ID: <BYAPR04MB496536159E418BA64D034A2986480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <20200806162602.GD3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB49654162034AA3CBA2F4E49B86480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5dd8cdbf-8864-ecd4-928e-daa74a9cd166@deltatee.com>
 <f6944200-35cb-e38a-b799-92bb4036698e@grimberg.me>
 <dfe9e93f-ceff-d666-c857-a0b7979e0673@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d987a5f-7e90-466a-fde7-08d83a42f9ee
x-ms-traffictypediagnostic: BYAPR04MB4136:
x-microsoft-antispam-prvs: <BYAPR04MB4136F371D3EAC29813D3386A86480@BYAPR04MB4136.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsWcyEr5+NmRLCC20/eZeF/p5LZpZJvQKDCpSOxj+1RCYwdlO2q8M57HhdtAg5CDuB5ET2t6RsV/x26zJBS/XbbSE7Pm4MxyOE/nFO2/wdyZmX9S4L9iHBstlkdQrmA+Ub482U5yyglpTd9ZNP7oEF8DGTUnGXHj1E1Em1Rz0AnZMHEXYS4iXuFad3+HBwZ+TXd9vktHwCVfxS7g5esuzOfw5tksptZz2DWtYZ0lXtyX3rIT9kbQ+y5Tn58jiWvha9CQwapcIzYixiYVm59gh8th8g7Nlm3pXV6RGZujWDA4o+969lV8DuTVXfiFlDR7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(33656002)(66556008)(52536014)(66946007)(66446008)(66476007)(64756008)(86362001)(5660300002)(76116006)(8676002)(71200400001)(55016002)(478600001)(9686003)(4326008)(110136005)(54906003)(6506007)(26005)(186003)(53546011)(7696005)(8936002)(558084003)(2906002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: OTPZttS3/8vrAOcjgnjfdmmW3TyZl+Io4Gb8jJVjEBlDuxTvXmqAY2mvnmHxsW3q9OuV0ClL6oiCnDHMv66XWJo/cB/G3ObGrwETJvT4DKnPOudezwGogekcgKzfPGan/uR4l1iYskG2HCjVXnnsSjIQ/Ka9aDilM20KN2yo9yE64yPwza1QQlWwrWPrH64WsmdD+REChXm0dpINuq3Swgrv6ThnFGu/UBOmgMbiRlMRgrt1IdIDtpOW2O9SganSprHZXHtkc6yCh0V2H6tP8hI+y6lh/PAb49o0bLmLKjTEz6wI1+BzoZb+zaN9BQ24RLmdvNYv71D3lA6raC2nsqBeh46e359RUCqFHFmDbQoI3ztF2W56KjCW/rQNuHyWaTv43ee4FeVImcVnjFSxdBGJY0khuLtlpNvl/ZQCeGpDToDsE0ZKtz8UuvpB4vBauHOF38J/A7EKYsVYrLq1kFN8SnuJE62kdHFc6AA4DydcjEr0Eg9Gp5POhPTJ7At4UioMwHYjGo7gnVhyQflgfOl6TEm7WH70C8fM2QpgRp2nFiSJHCCIte2Cb1sWl0hFmhLGT4EnxWHqabRVY3AXz6J6qIbXrBOqZySFFLNCqv16+pSZPKwF6d2adiDl08se7+LWRRFGECuUOeoYziPORg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d987a5f-7e90-466a-fde7-08d83a42f9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 19:57:40.7087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26EWVhMfLIA77IqTKrMM0WBWkf3Eqr2u9e00P9/Nu25AfpXDOVfBfkpfpFqfxI+pMYy0Cx0OFt20kXWp45Hea0ZSGP9Dek/ImC+w/iQ4HK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_155744_914791_2F7C099E 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 12:55 PM, Logan Gunthorpe wrote:
> No, because the ns is only conditionally allocated if the queue-id is
> non-zero.
> 
but ns == NULL?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
