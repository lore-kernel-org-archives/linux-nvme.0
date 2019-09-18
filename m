Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06ACC4CEC4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 19:30:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CF12249C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 19:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fLgZQeLb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SGHXkV7+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fhhu/Mns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CF12249C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LmHbJgj9ne8l1wDvtBqYuOofmLWHwwQ0C0oazHnH01k=; b=fLgZQeLbfvLVSj
	+7FUxYwReKv2lFD9eq2BC28SXhvVPVUVCim7o9/N91dPZU+LVhlq6vTirrP9o26eXATkbnBDK6E0i
	oozfybxih0Wvlr9VxB47DV8YTRyxF9VKDJTJcQGcID9RwuY1bT/EvdIKCAdRzPOphlrp0C0yoblID
	8S1q2dB0dhtvBCXEfdFF38LcOgbXIwADp3vZicCEB3fwShG4GxZ9kJB41ahcM5OnYZqU+uDzZ3Wcg
	/crceZAGCVhFhrpq97r6XIQDDznK0F5qN8W1zW+Gig1ioNKYcLTv2b1O9ngrEwZWh3bIMzotN/16Y
	19MgJLmcp0kc2/OReaiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAff3-0002J7-Hp; Wed, 18 Sep 2019 19:30:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAff1-0002Ik-7q
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 19:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568835043; x=1600371043;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Mqc2NfR2MrRp7oFyVWe5IitAZn5DPWbsbcJEEJWw/E8=;
 b=SGHXkV7+BLpYVLshLaCz53S1ymvmsal/KobCC7a3fVTD9f+6bH5q4S/l
 0uuQyHHV7lOKWSaMZXfmJdLCKFSLCqlZBZGJ0gei/rOxqN9FKHyRBFnFc
 sG6fv/lTsRFwuMrWTw2UZxoCvKBMYkJlwhTlJ9w2Lqj/2Rg2BVRdJbR1d
 AX4guP38Tplyg6PcCUk+4VecInKhNrV3Qj+dH78CA4UsIO52gACWwV1VT
 DzNRqJ5XS37xQgg+WoIgqdL64zmV/K5OrZxsOWsKrKxucE2m/CC2Ylwi/
 7BH4Y5O/safCcSdDdzWck4oIFMLZTvh+h2NZV/ze1ii4Zs7W9735S+bjJ g==;
IronPort-SDR: NUEF+1ASj90RirBAr9EfBi7RY2MkxHJ5/h2aKdRPTOI67BFeeipeCJqJk7KG9JSYn2f0igfM0t
 zm8MJWG2ZzIg6dRdyOBd8rBH8Rff9a5xRB1KYrVcPX0elkc8/njdCscmN25Olo2F+NxPl4Crky
 ll76u/zvI48VT6u6pdoantGkXbVVt6PJaGBbrwKd+8Rg6iiKPFvu0hygxe5WShXcJ0Hr69Ht/j
 rCiWBWseOT4I2iGbvxBt73+ZRy+e+8gSo6h7i/ONotxm3LTlFWR1uDNA0zBsGOOmrttaEEbe7V
 YgE=
X-IronPort-AV: E=Sophos;i="5.64,521,1559491200"; d="scan'208";a="225387166"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
 by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2019 03:30:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAYW8NfSHz6TIBEArLESu9df/Mh9QyfVYsalk7ikzudOJETPVZu+PXT5w0IShcvbc+SFz3/ZhOAmwWFEpEVFnWUsmvaUgX1iX8R4A3X5eWL2XKg6A4NyfsWb3m6dGtb3IBfUg275AurC+73UGJBX65ZqIT9r46yMF3KYIfp1l8OpsqncFIwBk2e4virncTa7Sto5net1b5f9eGRBdVa9fkFUDHDUnAPrrfNtlhGmECu0XKY3PDnNhH8sAK+0f0A8yOhtWEiFvAETBTefRoV4N6xlJaMZqHVs6LuVvPWS5VP8a3Cxn+ddj4PPw6I9a+SKm9tp1xXcbS0KZzY+YTlC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqc2NfR2MrRp7oFyVWe5IitAZn5DPWbsbcJEEJWw/E8=;
 b=UcRSsa8WJaU8Xo50kza/l6hWUy9yBrRxxKAv+Utr0vYt89koeQZRdSLLyH4vR5HjipMSUGNd5+5+ZfpTuFRjVDmfbZOU1L5vKacI6+6TiSp5FGJy5CTYViT5Mlzo0Y5jD2b3Fr7hs5yZB95kEunWJl6Sz+8LO71Bdey9YdzBddU3mdOt9s8IwG+95vZG/SNw04Jz0Y1JXNQviyfencw/Cj8P6vtqb1wnMoiGB9dNUqSjnSWOnKdVC2pAe37vb2FWYIdW6CZzYHgMgn5314T1f3+tdllUjwC9HfdDSy4qKUL91U0F/5pSy02cNEtxZtfGtag34Z1U68kSqapv8aZcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqc2NfR2MrRp7oFyVWe5IitAZn5DPWbsbcJEEJWw/E8=;
 b=Fhhu/MnsDxn39WMe4Rs4xaqeL9bHNw9YReS9IfoXKgUCt7bgVm70WWCbHarZn2FMrx8HGDn9/Rnn9IHEnE7JmxlJuvaP4dOBt6VFMyNvYyWhP2/kFayMlQy8GRA12F3CcC1u2JjyN9f28aAuZTg+7Ym62vQpjjXDaoU1shGP3pY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5912.namprd04.prod.outlook.com (20.179.59.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Wed, 18 Sep 2019 19:30:04 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 19:30:04 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: John Pittman <jpittman@redhat.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: change ppl to lpp
Thread-Topic: [PATCH] nvmet: change ppl to lpp
Thread-Index: AQHVbYkNAGHpkO4toUiPgIRzGqZLCg==
Date: Wed, 18 Sep 2019 19:30:04 +0000
Message-ID: <BYAPR04MB57499C27C88C0848E657890C868E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190917185200.24292-1-jpittman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed2f9289-45a7-4bfd-0989-08d73c6e9b58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB5912; 
x-ms-traffictypediagnostic: BYAPR04MB5912:
x-microsoft-antispam-prvs: <BYAPR04MB59122654ECAF7520EDD0B42F868E0@BYAPR04MB5912.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(189003)(199004)(51914003)(7736002)(66066001)(71200400001)(305945005)(76176011)(76116006)(6506007)(25786009)(66946007)(3846002)(71190400001)(7696005)(486006)(2501003)(74316002)(256004)(186003)(86362001)(66476007)(66446008)(64756008)(66556008)(2906002)(53546011)(26005)(446003)(476003)(52536014)(33656002)(5660300002)(8936002)(14454004)(81166006)(81156014)(8676002)(498600001)(99286004)(55016002)(6116002)(102836004)(6246003)(4326008)(4744005)(6436002)(229853002)(9686003)(54906003)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5912;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wp9KNCdRRKsENp0sbBsfViGvKHW3ztE1btTUXNl5klmewlBH+it/f5+WSRui+M0hOX84Xg8zP9+ZZY773Wd30c73pBRSw7fdJtYFktu3cmL+QWGUB9Kk53MJMSEa4RWIHv8vDuU/YoMFJ05Kd3A3SEWTF6p1G2Qznz3XE3V++rRyNdiMgwbRTCjqnxCi01n9+y4/Qtg93N0PXR3Z+kN9/WGtfi1h9VRNZEhZ/vwkXe3ifFnPJ+EFT4uWaNmmkas6dm/+8PXggUBA8mjXWX5w7KMD2vtqt0PLaZaBgpwTWgSBnBpGxBP3uLbCACee206vtdNqtqIcQbHCG3nyoPj4QLYup2R/9Wis5+i2bcVazQeAISa27yQAcESP2JjFzZboi1wsd8yUtsV6hWukEqrXFPYMKeLs9+zSBouITbvlf2I=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2f9289-45a7-4bfd-0989-08d73c6e9b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 19:30:04.5502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FsmU5kfpuflb9Oqo01FwL/EjIbyQX+KCBiLE9dIGb7XYFj6Lglyn3gpWWrMJqpnl6wJ5yE2kVUwMgpAt+2vuQdiRK3PfaONGdVE+wx/Ut8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5912
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_123043_293931_2D220C8D 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "bvanassche@asm.org" <bvanassche@asm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for the fix, looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 09/17/2019 11:52 AM, John Pittman wrote:
> In nvmet_bdev_set_limits() the number of logical blocks per
> physical block is calculated, but the opposite is mentioned in
> the associated comment and reflected in the variable name. Correct
> the comment and adjust the variable name to reflect the calculation
> done.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
