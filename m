Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B669C4740C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 17:07:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272BB21479
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 17:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NARwQTbU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GM3ofqwQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VfP+5+QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272BB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Iw7wbrOEAJapIS+PNH/ocgsELmzRci2ubOD1Nc6qSf8=; b=NARwQTbUq6CVH9
	Pt3a5HXIijiZx/jzU4DCcCH/bhELX2yCeQxknyMtWNyC4jSL0vM5lbsShFQkizNnNcS3q2Ywzy1WP
	CeAsB/6mK6IgIZObCoJH4g+ARjX/CgM6VQKX+ibqm8qKI00spfq6WJSHzLGgCPKIZdfT/xltfLR+F
	1FO/1pPZOSMsVupo3x3XFMkI891BHLAmOYQZQaj/m+BEGFLINyllbvUMKmtJQ9aMCVxlyUt3MpKl+
	bT2DXevl7cRkvypM0gNESX82mwirLpQq3I+gWVJoPe8b3go70iADqL8Fb19RbIU1bXKn8/z3YcaFp
	UETjLGZZldV4GCSNelhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7N84-0002iY-Sq; Mon, 09 Sep 2019 17:07:04 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7N82-0002hD-EG
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 17:07:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568048823; x=1599584823;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6Rxj/1cKdA3Q/9M+u5xKL/vAOnQCgESIAzrB9C3Wya8=;
 b=GM3ofqwQUT1/xBgecYqbWmLtCzwN6qpOOxNUernC2qPKJUz/7LD5O9io
 p7c36bafKEr+5c5AXkLybUS+VP97sDyG0UU35QXgfN/LkwXL1oIbCxm6C
 YmnKDKMQ/v4tJPDTBKA62ni1jD8pLc2fkbCjQD23NwYrm3f/IhKOv1iR3
 VyTp0lVsS8Y7OjH5XzCm1PGrgqvttdfvnYmSeYCEITMZ/EAayvVXc+Obq
 EiJYe/oVzZftXd9O0QwmlDL2cq29hb2D4ldnNMIj434C/uhqRKGlJNU/e
 j53BxtI7VkHaz34UJ4MSbii6vEBQLspYyVX9ePR4eGl+/lDioT5ka/JTy A==;
IronPort-SDR: S9TURH3thW+G799QmgNnbndWN+JpXa2kWOcyNT8icwLzPW1puUkcuah8oekUaOA0sEhHKPSt3f
 JRyqayqAV1ScupuSe6pqyBz7gRG8nE/um9DbavW89f6TeaJyAvRDqxaolC8MrmaMadEN5dY5J9
 CDv3KGpwlpDWGF0w+nQPWhYI7JFoQyvwVw5c146OpGM0oh1jjPHrxv4uJutlnGkbEqpm8xOLS2
 TjuhdP75y2PCnZkvI6heXeR0nfSbfOayDh12eJAC4r/Ar1pJtxDLMUqs/EiWPUWfbxKYYKnfqa
 tIg=
X-IronPort-AV: E=Sophos;i="5.64,486,1559491200"; d="scan'208";a="122401135"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
 by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2019 01:06:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xme7zAyP+79pr+thoGtn/Bg6Bm43plusbH0eJfNd8o4vfm6Px7xX7L6VQfz47RfJEY960diG6isYlaQyfG57OWw5DRPCvXCI6qKjwHFxzOlXirIcXBf7Tup029ctnQA47yQTI23qVT5KdIJRu0NPRcMuyonl/dCNp0WdPQidvVRwaInlKKM1yfT/ZCw5rfUg8bmTDVa+GukSYlZijBc/IOL34oAnSmiSTDNIuoY2Tm0vNgwtrbG2UIRyRa9JU3dElq6rWtKRD+VqJwuQVbrFPSejz5AMpOeFtq8RY4pTmYm9XqV5VVzVuhMZNnAQKW7B615Ac0jiTtnmQhReUILmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rxj/1cKdA3Q/9M+u5xKL/vAOnQCgESIAzrB9C3Wya8=;
 b=g3Vq0akLDN9bmavO0frwhDWmvEyT8mI1+Py+lJUJr65GYKXiYW7+8OkZPk5vlddh/0Aw/GADXtc5Uy+HN/snHPhx7QGuiPaDpVTfAi+47QOYIGjfjIsg0PUGiAumQyleXzwYuNse7OrRCkpNAhjxHWnmRlnhZxvzIS3P9MjyhYko5nD+2v1HXQ82hxb9gCRHUC/MW6mfsUfxLWyYIHV54dMwepiS+XtJV9pMugr+HuTRio1OlUQtB5Zo+pWFDobhDFIQmBv7KV0NxXyZTQCmnSmitK+BQNOA8RB4/uHh+JME71sn/Uk9ZylXU3tr+8tbcntSDrwPfL+2NehzrKviLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rxj/1cKdA3Q/9M+u5xKL/vAOnQCgESIAzrB9C3Wya8=;
 b=VfP+5+QJUUNgGyeIqn3d9pP7uLfpA+yWiziGn4mH4DneoV0mAr23K1DxcNEOOtTGlSkOcVCYSHJ0gH/eKZ/90TFTTo7XOBimLrViGR6p5oTeyxylhFQGzi48BBt7MrUtoyHYfb02Xyle9bvT9jP/P4RLhPqRQfrjkdDJfGoc7fY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5621.namprd04.prod.outlook.com (20.179.56.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 17:06:57 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 17:06:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Thread-Topic: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Thread-Index: AQHVZBGFOhLove2B20W3iAzHm6F5Cg==
Date: Mon, 9 Sep 2019 17:06:57 +0000
Message-ID: <BYAPR04MB57490B2A63235BD0078D86A186B70@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190905174347.30886-1-logang@deltatee.com>
 <BYAPR04MB5749A3E9B06514AF589FE13B86B50@BYAPR04MB5749.namprd04.prod.outlook.com>
 <7ae33b82-88d7-2fa3-2bc3-da0b262d0ee8@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afd560e0-4fe0-4032-f383-08d735481f68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB5621; 
x-ms-traffictypediagnostic: BYAPR04MB5621:
x-microsoft-antispam-prvs: <BYAPR04MB5621D86587D13E4E5BAA1F0B86B70@BYAPR04MB5621.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(51914003)(189003)(199004)(25786009)(8936002)(316002)(478600001)(3846002)(26005)(186003)(6116002)(486006)(476003)(2906002)(53936002)(305945005)(33656002)(110136005)(229853002)(55016002)(6246003)(9686003)(74316002)(52536014)(66476007)(71190400001)(71200400001)(86362001)(6436002)(64756008)(66446008)(66556008)(2501003)(256004)(446003)(5660300002)(66066001)(81156014)(81166006)(6506007)(7736002)(76116006)(2201001)(102836004)(99286004)(14454004)(7696005)(66946007)(8676002)(4744005)(76176011)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5621;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GhWp+aqwwNgsgl+OS23mAhkGoifopgMDXI+oXAa7fQk9dG8GMK+ZP6waPAkEZVj+Pwy+rdqZrzF0UyA8wKEiJG2RopI3vY+WvPBLs4aTyXVxWYaYicqeAMLdsA5xS3EQkkWGzBAMIED0/LABmxPgXgi0dz62C0RPAjvxICmKFrRfZT12hNMRO9R6tlnTPA8fAIq14Eg9AN4CO/KEtVnbkbwYSlMuRzBsJRt+gG6nDQupJgdJkxnRhvnimXe5wKiIrw6WRLgDjuS0pKDaZ4qEOSTwApuNdkv4aO9vYUXbd6H7aZ3XV5/47xibJY6BnM8uihKkRhjtKkEbdtJtAEQ61uo5NazLlMmouO3YEr4656sVHgN1YCKGsXi/dPip+psPecdw8rCeYI+ZU4cj0UdkCZyPV6s5ZPazf+0n3r6zgfg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd560e0-4fe0-4032-f383-08d735481f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 17:06:57.5574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5bSencciiDN1H1l3EKqZsSJclidPMLR+S26rekVpsNfPSf7W8LQlug7e6jvaG1uX9BlIwh+4YrV5/EmBCtNy+eaCqB+nAZt/iRQaM/tls0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5621
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_100702_497561_CB5673EB 
X-CRM114-Status: UNSURE (   8.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Thanks for the testcase Logan, once passthru patches are applied
feel free to post the blktests for the passthru on the mainling list,
I'll be happy review.

On 09/09/2019 09:14 AM, Logan Gunthorpe wrote:
>
> On 2019-09-07 12:19 p.m., Chaitanya Kulkarni wrote:
>> >On 09/05/2019 10:44 AM, Logan Gunthorpe wrote:
>>> >>A number of bug fixes have been submitted to the kernel to
>>> >>fix bugs when a controller is removed immediately after it is
>>> >>set up. This new test ensures this doesn't regress.
>>> >>
>>> >>Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
>>> >>
>>> >>---


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
