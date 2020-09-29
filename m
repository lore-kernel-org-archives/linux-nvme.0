Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03A2C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:27:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585822075E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qk3j7MnZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KRb+fpYG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Cn5cOT7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585822075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Q9V89H35CbGKwZxZNOayiKvtckb0oDgMy+BfLytMoIY=; b=Qk3j7MnZ171Ug/ZbP37UcGqmy
	C/LPgbZd39sZkKvnFaZVmDj4QsVzp1qAagqqnibhYBbLXDI8H2ZS9j45b6VHJVxTjvRTPMU6XpovO
	9MSMpQyzaEdly3jFG1INTtytDppozfkjl0eeBz3NPdsc8vnruNODbcpeVE7akwm3CzhmikgQVeKeL
	zp8GfgaCJYj6RsRWOosYYh012mNGjJ3ibE1K9cVhrJehHJsPG2irop1s3/O4RySrDo5DG/49t8dOe
	x4EHT2qHKCiHft9QOxTchkTjIxv8Y+X2fvFuQk4DrS+2b0sVFeSTpToGvC9DyXKlrDDu4WffQ9DzW
	f34LW9ozw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNN9Q-000406-Nt; Tue, 29 Sep 2020 21:27:08 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNN9O-0003zY-Sp
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601414900; x=1632950900;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=vZEvedEblONqvx++CKvSigk0+Ahsyz71IuoAzGUeXPs=;
 b=KRb+fpYGpEAcSBSjH6c5Bk8y7o8a/qTyfZ+m14NDlGJfiRSnt6Xqmczq
 BsUSCt+1IUpp2vDjA6Q2ewY2IqNKGu7z11Qboqe48yT83EClKK+XUE15m
 A/VBrq0aBKosNfiMarjLKLn/QGT8spy4b5BznDhHxPxN5r6/SKkrWXgqg
 oNKzXhYHUGGfAxD97SuDClsKoJ2Fc99eFNHTY111FXcGqQkgRfGCgD15g
 iOxhr9je2Nq/r8Me+vbzl/qc/0D7T5hMULp3mzcZAiE0vwGryrQ6hMjTA
 k085fnvOhRVSWSyVJr85Iblo7FX2s1GMhkMcutvSR9Tyijv1Qn/X9zZMe w==;
IronPort-SDR: C4XxILnyw0IThjn14ObyU0nppSHCtbS1u2q0FKBryELYLjezUaqA52eohi6JZqLoKy2amysF5V
 Q+TzutUimdtvvx2ASYdvYJGKE/JdTcSN2ik7Q+jScp/KFzGnjRW4JpQ1WBaMa6cYTzlqEHX0Ro
 Ug//RXXEQYgpAfNSRvl8Dujit2l3Nr2pUsYkvbIHJ+B12pPtFW9mheR77e4msyfh5RYT3cv3TR
 EtsDm1U/1tSCVtY/vTeAI3KTZbyvu67H3ZjsObfe95PHR3JLkeN7m/d+qiF2DMAJJPU2Ia10fa
 7Xc=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="252000534"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:28:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWnkxBFcqByUeXUL9DBaMDKLfCYF8Y+rUbEy5oz6RXMz7yrq76McFx3rmaKZzUflfjL9toYK6ugCmLz7JjHVsH97W8+VxEBPfYkmUvq//qYMyY1cqvwuCyFkDaUbOaqdd2YhNxBXoNBDIkQ5Mic9TGkgMpeUvBNAkDeGrGSsu1q6M767XE0Y30xYtSGJahVJvp/zMNfJyUvp6zT5K2cjH1KWSvvUowQKjwvDoLTXk0lEFTn6jamGe6hXv9zRgxSxlEvagrHoK9Kxj858Q8Mq2NjnMqnCnfxVKkqhbjmrzjZLHMAdDRAAUFZRbtNKV6tWGzoWgkE6mDIpOoEk+TKDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etkg+JZgbYeRfBt2R5udbAvjgWbcdeI5JxUy+uJ86mk=;
 b=DF0IkZGFw2m4RSaFzjxd0UWZQO9Zj1u6uKAFgey1usSiAI82YkwPwtIIiq+GYNaRkcYAw+dyj7ja29HUcMYKNSN7XNVs8MO+9LsaUHUqhXybZoAno12z7bCOWyfx0gz46se5nxs9BpvHniWm8YLcqFXNpdwzK6Mfcivnpc2aZ0qlFc8hz/mTMmLsyqBeR+H7QPb69XE6Fp3LM0XEqJNIMbM6ViygP4Bqx9poICwL9TOQFQSzEIQN3lyNGPuV7gLipzpvTYd3+9GZ2DKpv/0UagMNvBk8CEBntLByH71FvNO6sOLCpBaw2QBubVjYj8a3Cpijyo1iHwJBc/uBOoAKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etkg+JZgbYeRfBt2R5udbAvjgWbcdeI5JxUy+uJ86mk=;
 b=Cn5cOT7MXA4lGFRGuJ82KDBh/eAf0AtCHmK7kLgmO9j3HcdwOC8xMjpqfGMiem2ceAip5QmN6icBq6GdyGmLkmTaapYN0P+Goo2k6UEd93gjoilm7kQr45DirARhwpYgCFv5119lNEyyzJlORGyMosxKoqz9Fj7C0jXVngrUNKQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6584.namprd04.prod.outlook.com (2603:10b6:a03:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 21:27:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:27:04 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 09/20] nvme: factor out a nvme_configure_metadata helper
Thread-Topic: [PATCH 09/20] nvme: factor out a nvme_configure_metadata helper
Thread-Index: AQHWlZSo32PfPYDBV0eiM+tLxJ0ong==
Date: Tue, 29 Sep 2020 21:27:03 +0000
Message-ID: <BYAPR04MB49654DAFCC68369A6744C06086320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9089d529-b8aa-472c-69fd-08d864be6902
x-ms-traffictypediagnostic: BY5PR04MB6584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB658419C4DD9B7022D98D243D86320@BY5PR04MB6584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6PX9uEY9Fm2+5pTAKKpV8RS9tioAy+FkTxS03Sw/qc7jOZtjOTQdM7+OubbcJVFan1WC1LE8tSELKgUP8GVOsXSvc3Ch7UjowynpzZfdpt4FagTbtY1++5axRFv93GOQo/aH5WSc2/2wdvTILaYYzdRQlA6w8xosx2q9Fvx2MAlDOp41AQUhWtv/EQjAiKAgHRpeHsmohAXADVm9+1DsLw4yJKwQRrd3Ismd9+AGYYqBCPazEV4aAzZGZXcucm115mNIVx7Mei/nUIYfa+qj/vtwbRE+DzXeV8aQ2AyBrGw14BT4Mtt+G/kboeOgIq3r5AnNlQfkAhOtg5Tjn8ywojZKB8S7cGB4fQIZuYVb+vU9BfgWbp5KVP5/RTRT7nz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(66946007)(9686003)(76116006)(66556008)(316002)(6506007)(66446008)(53546011)(64756008)(66476007)(2906002)(4326008)(7696005)(8936002)(55016002)(8676002)(83380400001)(52536014)(110136005)(33656002)(86362001)(71200400001)(54906003)(5660300002)(4744005)(186003)(26005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nK3Pyn1nOJYDlVhb3yQPqo4wBhcrSuA3ufPeS41n4Hov3W6gruLjcr1JwJvALXQ0OBoMgptw8D/1F11TWMoFOTS/dINT5lI+BbPpSn0Dzc++JG+bc4ITFUIaGgZazFKhASopunfo5yrb2I3sR3VQ4q1zYOgRqYGg17P1yx8URS1rs+1xuZmKjRQ3kELEUiAA+92VTbVCL3tE+6kgvDIALf1F7W8AvncM0RjXuTvpV0JsvRHSKJSociGebBuO9u29SnBDZlY+0mNNz14NGJRXn0156SJ8utErPMvD3YuELMrhfI1UBhm7Lb5jFrVtcG2lGH7SlRd+HCdnt6xqZZgAyivlGjFFcR1xvb0113luALj1Qs+6o86FBrlA0QrmtHgyhLzXD7FiPJuF6/6eDF47MNEYo23rSbl5PPWJJ8kzhdmkzu155p5edV8mCo49xbNSxUpYJqDN5xaCepdO9CkR0vmae7AsLGk8T8E2lAbvGku+3slvcYVHMNurLmAY12DvovSs3fX8ml7r+IWExCpxQsTOkKP4sR4peybmcWTdCXAPZgfxCHzho1SpYYcJW8QyZrEHZuSiZ23J2U85V0nbq0c9Uf7xZb2VaaQvG1O1XTszW+oO8Xt0in5e7TvSCWDVF0AovfJdRFkZq4Qqz0czJg==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9089d529-b8aa-472c-69fd-08d864be6902
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:27:03.8706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uoUZgVbjpdMeVkkzhorTiJJ13wPknkF1oAFaW/YhQvvc5EZwcluq7GWMCk5lkRx68zokQLKOB720E3NjVXU3w9MIILbM2gdMTlqhC+OQ90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6584
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_172707_042399_E3629CA1 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:41, Christoph Hellwig wrote:
> Factor out a helper from nvme_update_ns_info that configures the
> per-namespaces metadata and PI settings.  Also make sure the helpers
> clear the flags explicitly instead of all of ->features to allow for
> potentially reusing ->features for future non-metadata flags.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
