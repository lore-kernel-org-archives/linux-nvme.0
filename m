Return-Path: <SRS0=CmHT=BM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76EDC433DF
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2020 22:54:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3552072A
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2020 22:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dB9nysSp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pJ5LXAjO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ORQ513IO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3552072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nt2HPTBClEkxUYqyFLlwD3RHkj4yPWvHkjvzdx3IBZo=; b=dB9nysSpwQn1JWocYhdOO/zdV
	qA19dJo6zNm0VYHFvg/mD5vRDArsf5/4bW+I/CcyYg9UKSW1t4GIg7sdBXPVQlhYIqpD8qu23ib5S
	bIsqEU7Wudkxxcz/x6kkktbWaUf9ltipUEtjywN9aoZhFNI0hT5W/4Wy17JCHRFXb14PzCg7UPDwK
	ukMz6edZfSQvxr6FR1AnZJJPj4TBACHzoLp5NAMzQaseWpaYba4Znn3UsFiARzZ0IXh7XIFhGXtBj
	qzkwu9gcVwwJ/Cz52gEA6lxLRosQs34pbtrUrEM3kQn2ZSWZyWhpTwmn8Krvc0FY7allumlozdWMv
	EmW2i1FbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2MsZ-000148-JF; Sun, 02 Aug 2020 22:54:55 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2MsW-00013V-ML
 for linux-nvme@lists.infradead.org; Sun, 02 Aug 2020 22:54:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596408893; x=1627944893;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=38KtaqXSFng6jLn2sPIZ0nnrIVSyMxRGlox7P9LTs8I=;
 b=pJ5LXAjODNm8aO9SF5O0udwKM1v2XZxgl4dgJzSl5Do2232ukWluBerx
 q9DNeYtGGkLGxbXGEdeyyJSPi7QIDoVZo4PaCMQdbjtT2vS5RZv9JvTZN
 rIzJFNO+MvslT6gCVVcQ+Pvfv3SMh/6UNLQ0uI8XHXSUzcgFSVBTT/nlf
 hyJVYzMypHxBDQwJiKzY1meiIfi7WIabZZZHITqdOdvuHsROny7Q5m/ay
 r1r6E2nilncHrpuXqCTrN+X+Xlfkr2Xf4gIWiFaaytvt135hVG0PEFKyE
 9ZuicUPAPnv+UFEVsiF/yGECOz1Nu5Raa01KJ99Zo281r/EWEyNCcKHvY Q==;
IronPort-SDR: 3XKu7bkHrS3akBOMyYba7+w0oCgIn2E3aPN7K8cX87Rpkcn5qJIl0jEEikeNDc8dYs17fmqPjZ
 5H9J/hHThD7R7lU9xgciQdRyEk7ZLU5LJEwlheDk/KtfrXMk1CKL3hdhuREjrG1by+DAFOHaos
 Kw0lPbbrmqRiCOjZcl33LJUheVkefSCpZcrdmWSMi2vFeNO+vJv5Msak/2zJQEBNqVOdcVtT0w
 qLWnSiiJ5/T66cvGUY+3Al5apu9dWu0T5cKMTzl1levkQfdzmvk6TI8D0YgK7Of0zXItKYerQ0
 uS8=
X-IronPort-AV: E=Sophos;i="5.75,427,1589212800"; d="scan'208";a="148277463"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2020 06:54:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2QSlLsIUw2g1aLr5an5SGAPYut9ZyxaiZcesgh5rFg3y7Q6ENRzUlGUKxhdJwba1OdpKfq3uYTutcp0RRl89eaxnv2MuQD/wHUF+mhb3DI0sFH1Xg3/GQxFKpSlnhg5zunBjaNaG2C+7N56lZdaXgNN4HQ/2iMdR6+Tb4k3A/YJs6yNAgTmt/jc8q92wvKPnqyo9T1ltM0qd3Swj3/F3zRZuGPllRneI8tav5JENyeJ4u5lshgavlfFT2t1VKGEKlxjRRG+M0XoKkBHVj3oxYvfOuZwyl7f9SG/BbL5cHlMxxaGt2M+adJo3e9B9YDvvDRsjwkU3pOa+6gjwjTZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38KtaqXSFng6jLn2sPIZ0nnrIVSyMxRGlox7P9LTs8I=;
 b=Yoc+C+yXy85bemzLYSp+21lkC0PvBYPtqVbAOo8xf6hXqtxRfvqGXDpP9YxWH8zwaSEft/0WlmN/SlLgzo07AtfaSukm+oup2aibyqO1zRGvHO2vzgXnNHkd1dYdNHppiPkNzrEnjS+Bc2L+BBlIOe55tVfK/W5hYPSz1eSjzZU8xvI6RLTu02ilHMKxzL8H4set9lYa1hmyBDv+gbBuxzfsXBRhL/Og1DMfHiLeFoDPN+axz1igeIIXlTLYZJ9YW0uhpD5LW/IDLa8r8H9KXRexk1bHw2Mifx56mdQvAcLbowgJhil4K5PnbgCpav97BSpWc62pAl0jyeUEWhrKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38KtaqXSFng6jLn2sPIZ0nnrIVSyMxRGlox7P9LTs8I=;
 b=ORQ513IOtbgJrXBIww8OzbVYBfybOp5sq5q9xErjtdJWii3pIoOjzVOYZuMxomI72CyJ9gjA987Uhdx8Uj2BxYLYpHX9d0eAiWv5azkY+/ePHn3B6Kzeb8Lninf495pkSiH8FASE+4o9OVCVM4LBSrqqnJP9C34Im747RKWFgAQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4038.namprd04.prod.outlook.com (2603:10b6:a02:af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Sun, 2 Aug
 2020 22:54:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.021; Sun, 2 Aug 2020
 22:54:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "jthumshirn@suse.de"
 <jthumshirn@suse.de>, "james_p_freyensee@linux.intel.com"
 <james_p_freyensee@linux.intel.com>
Subject: Re: [PATCH] nvme-fc: Fix wrong return value in
 __nvme_fc_init_request()
Thread-Topic: [PATCH] nvme-fc: Fix wrong return value in
 __nvme_fc_init_request()
Thread-Index: AQHWaL8mFLvfhLKbFkmZZIl4kdfgNQ==
Date: Sun, 2 Aug 2020 22:54:48 +0000
Message-ID: <BYAPR04MB4965A8EF12A48FF2418B6D92864C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200802111545.5566-1-tianjia.zhang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be6f7988-e869-4ef2-21fe-08d837370edd
x-ms-traffictypediagnostic: BYAPR04MB4038:
x-microsoft-antispam-prvs: <BYAPR04MB4038571B57AB753F06FBD623864C0@BYAPR04MB4038.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0TGJFwSlwkwGa6IhmUAvf13Uo2g105d18YxLeGQnk1PkG7wIb6XH1oCGWwDA9lC2o/IcK/EUZ3cHL7OwcIf2z95whOEDP8t49sArJPcvtqzoZw7uLL9ugfW9BCJbs3lycwc02aYUBBGXwCMr6Zbqvg9lHUrnjhgb2iLV7iBO5IT42AO8X8wKvkRn2He8cB1/474OYi/zWRDJWGnsYcRJw4DrTJ89JkcLkoT1VQB0qv896lKPG/yIbEXiOOkm+VodTa/RT1o3bMNR2zbZ1pMIdKr7sF135Bt3kQSJw4kleuFOFe9qYM3iCEc05WpUN0q+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39850400004)(346002)(136003)(366004)(9686003)(55016002)(53546011)(478600001)(2906002)(26005)(186003)(52536014)(6506007)(71200400001)(7416002)(110136005)(8936002)(66476007)(76116006)(8676002)(316002)(66946007)(7696005)(5660300002)(66446008)(64756008)(4326008)(33656002)(54906003)(86362001)(66556008)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wcANrUiwe1++v/cpNSRKT9HOvs6DGhCQsGOiV1zcyexiD+LNJ/qJ6MBL4Wx7QGGlDsQ6ktYIgfxwMhp01OKb6ROAePtIdTu1JOL+l5JXfybodOoSS1y2Gle2onSNuTZMwDFwH1c4arot5ThFcUt/Q10Mjskro9e3iS3i/M1S38n0D8iafQPPz0J38A/80AIw4ZpYQGZ5mgDjqT9EPbZi4S/0Nqpbfd7Nffr598oLVIV7UfD1eOEbJAUJzDvelCTYWo0Th5ZgWxKKtwoQsh/0sbIA4yxWlKtoU0J3+Emyq7op8bVP3EIzXXL2rnY6QaxVQejg33sj/sUwU0H44JFjjy3G7OvafHynkDtdVsyQAHbOagQ6UjTEM7fSWOw9KliXePXvVA2TiHwJIJZMxyBS4BUl0eTy8fUHmNuUp0vivovGa/q9tzrOX1WlP08w/yfMqxODa9QirfoagGrIJK3ukqGU8i8LOOAU+cMeAijqz6vnRn8CB8QKU6P8H0byq6zcxaFoH2mjVbzU4a2+9U+FZiIhc6qG5pEsaXtjzWaEaCAEumTf2ddRfjs+3rmu/WMtD1vksyjeCcynxxOUUCDSCqGS6iConXgEyinm/tQr+VODGOLCvCdDU5PO7GGohuBB7ZHSKNOWZNL3/LLaNKr82w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6f7988-e869-4ef2-21fe-08d837370edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2020 22:54:48.4263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiYQzqQk7TaWadOF+PPdiRIBLSsoVk+sD/mEI/nAR+zOh/QVbhIpGLQkPyTvMx0Uyyd7UEr1NIwuA/115joWJQD2qxHCx1oRv0tJgb6eWLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200802_185452_879416_F4C68E9D 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: "tianjia.zhang@alibaba.com" <tianjia.zhang@alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/2/20 04:22, Tianjia Zhang wrote:
> On an error exit path, a negative error code should be returned
> instead of a positive return value.
> 
> Fixes: e399441de9115 ("nvme-fabrics: Add host support for FC transport")
> Cc: James Smart<jsmart2021@gmail.com>
> Signed-off-by: Tianjia Zhang<tianjia.zhang@linux.alibaba.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
