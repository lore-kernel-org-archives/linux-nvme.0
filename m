Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B23C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 22:31:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1832067B
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 22:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aVq1sE1b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gEvDzhwA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R2JkJ/eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1832067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8TwYTWqkLhIvFmso1FBvTJMN4oLuQM99/sZqyP0ABI4=; b=aVq1sE1bsanPg6
	KTHetBndj2vpmsya4c2rg1MPXs+mG2ZjUsFhTCpm6dXUOmN6jJ/6oDhKIK8Ln188qDdMKctXool/b
	QR0FeJujZYtDvIZRRpAaLu+217SS+yj6OanJHscdKqddboWGGNqbm9Kz3pyxKHB3BG7C09NscSdGu
	x0EQLlByov0SIX/Ok0lwCMN0BNE4axxCqEeFjhzlzOdlpOwsuJO63nVc756tLEsjCGeygKICc/QRE
	DoKOwsvCNNvvwnDyxdod0nrhrghhZV8ac28kcrzhNQPPaENZzN7hPXITiiAzYR2w6e0wJ2H0ddW+t
	oEgDzsPCUsBsECnVQC4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgbuo-0002qr-TV; Wed, 03 Jun 2020 22:31:18 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgbum-0002qF-6z
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 22:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591223477; x=1622759477;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=45eXXRnCAD442CPEK7IMsIe/n4nOmN+3leW8jw1XwX4=;
 b=gEvDzhwATiINvvw8xPnWKajgcEcqmbbevXkrja5MHu+70yPE1N1mdleq
 06NtuQeSY3jZTGnCF64HQnNyZpWpc2l4RLxuZ+Wchepv29kwGvXARdm6b
 TwSxG2E6GcdNbmGP/cCpE3xT3iJylOocE6MRzSMrw5muALoWV8efNVAmJ
 1p8ac27YtUQEKnxqIv5HWwfSnjJyswRC9riTahsJnquOvXEyrLnnbwGDK
 eb9T/Wv8ts9Zmw+lxVlT4b5AppPyC2MaM2fRzczni8Bn+0aJgh3/9YiNX
 A1thmR4QXB2rAfVJbyP6nWcfhAt71vlus6OW8Ax7qkGC3RwEckGOWhn+V w==;
IronPort-SDR: TiuQUg2mWnlqYXYd4VrrXxGkDd0Pbl1ZkuTBYBvc7rcI533x3L2WJSdi6Q3syoyQtG/QcRT4bz
 sIjE2lI/fhrjftInzVTOqBlheRevRKAXhbsfvWwirZZy24bn5xXMSzXtWecQKH1lH1dXeA5BLP
 0Kw46Jp6jEqaWjMzAws8DpnsgNdvCtRgkDSnmhItfIT9dKcp0ExG3OQi2SFUWckPyuMBHLIvOr
 gcnObEJVMMmOLr7noIQzg/M+ZzXIAiq9bKxvSQWXx9U0Tb8WbASuSAKZ1Kzf9Cg7ftsmtEr8te
 gWs=
X-IronPort-AV: E=Sophos;i="5.73,470,1583164800"; d="scan'208";a="139463738"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 06:31:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9mT79dE105VMNBeQNwGIH7Vd70/eBmEYUIJPNLKDwfQu9JIUi8CcONFG7SCirHXpLNwp1t35+Ec8q3CuLRlzR/RFSfrUwuBozT4HGd8qsZ45HyzSzposO2bd4jTYAv4Yid36sMGS/NAEZLLhrD4PdYLfOzS5+pZtMOyrKUU50aguFRdrJ7DaCca9vYQrgTHoDi3dwUb/7/HLQDMTxMwjVQloQduIDNUcM0pmxCZi+6fIDUI7guH2fC4+wlXs21pL1cmcxE08gH618Od4RrORT4v/zgnxhXF5WhiBjkW2yJASjCLZ/GOKL3tEW2cDgfwU3QaUANQhN3P1nYnlzBfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGzMjPjsd75sohMhTQal4WzNa4fh2y7QV/AiD13KEoU=;
 b=ARwdrIR/jLI/vow+BIYq8qrLyioVe1xg6o2FRU/jgkcQDIqoikng51kmmo321/S1wSHxDCx6uh3bcIquBFb90nka5nY91jULtvOh30Si9PraLRj8CoYgAEL2GIbi8FknVex1GpJQ5JxpCkBS+rKI98H879t62m4chC28Emk7clUhobB2+h3FzcPdP9/fF/txjmZS2jt5smYmyuj0ffnExLrkO49iHi5ZVjXJRt2LcOzogR/WR7GvxBFcZJgAllfrwir9T1mYGZ2x/mGB+gJsPoeK4wW0PJmQ0okdPjrmajyUFlcLTV+OZ7XOR7GEef8ZLFt6tHUGyhij1xKrAQGKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGzMjPjsd75sohMhTQal4WzNa4fh2y7QV/AiD13KEoU=;
 b=R2JkJ/eJxux+l58i6nnxabzdTxAHNDU/y63H8Azu5eSwEffdeafbvPVMyPCdMD5WWReqScCO3BC/qGbGOyCLs5D+gJlAOEgThwnd0W2o8zdN1/Xo6c1cJIRMMZm93q/8vnj++/jSMLtydremfeKAy5ZfI31MXWLXkcl8BVH0ba8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4792.namprd04.prod.outlook.com (2603:10b6:a03:12::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 22:31:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 22:31:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] nvme: code cleanup and type fixes
Thread-Topic: [PATCH 0/4] nvme: code cleanup and type fixes
Thread-Index: AQHWOIdPzQJepE8mp0OoIBlNz22o8w==
Date: Wed, 3 Jun 2020 22:31:08 +0000
Message-ID: <BYAPR04MB4965FC25A317331BE29B98FB86880@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
 <20200603130957.GC13511@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90b16d2c-8508-4829-b346-08d8080dcfb0
x-ms-traffictypediagnostic: BYAPR04MB4792:
x-microsoft-antispam-prvs: <BYAPR04MB4792E55EEF3E8683A3EFF1C486880@BYAPR04MB4792.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xmp2eG3qp7VtfE7N7DBcd8ZXc5ORbwI4Ukc2AlopU2opO5txwwTxajIumzKVs6dPBydAwxKs07mEjGdQtRDQAXDWwQhIjHvqYole+u8vl4b3yS2Ax5yxRZoilDLcQg3VkSPfzAPffsRK2meSCwTn5J6PlqGJY122CEE3v+Evp22ctRWlGMylmFxJqBBVtOmyI5dg6vZLtKStfL6/4lmOcNHpI9Tq10YKXTe4pYnfywM/tgRHBaHqtBIHMLuIyk+T1ueYPWFZMCrwz//RbUE5typcXxnnQODAsbXAHxave8WYBkFVtJZUCTFBCfWkKJSXNbgUdWUEBKehJIj9gCRdHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(66446008)(64756008)(66946007)(66476007)(54906003)(66556008)(76116006)(4326008)(71200400001)(52536014)(186003)(6916009)(55016002)(558084003)(2906002)(7696005)(316002)(33656002)(53546011)(26005)(5660300002)(8936002)(478600001)(86362001)(9686003)(6506007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: mYRMAaOslxwPWMC+8b1QZQFDrlpbGqR+KHQuSuTVfcAbr4VjGqckuIPjbrZwykLtqo6hl4qjjp7DlBXMek3MDbvjklH4laWiA5EKQJgae4zf/O/FxJNymDpapDLZLNhcC1WxccsPQpRB1LSgPsOUgxQyBEuJDVTaID1GTwYmogtyXC9NWwi8TfD0Mj/wPOun+s8is98GW3oE4mXMSq5hHJXwnteQY7LIZHD+GYxyqyQX4YH31HdERQ3clhZa8+zgV6g1LPCN+nJ2jWC+kqarrYv7EetYAoyn3N5XGaJdOL1JYbOsaGIZ8XM9Zzn4KbIO2noouamFTUV3ejn5rPgb9TiKBBYEzUPNUTAlO5NMWa6ZRFcs7PAPltkQZmbpXqi2XqoO78VDtI82axreJ1v3yZTMAhRw8WfCj7uKD1/zXTde2HLaezbpS4VMszFvmSe8NNcBmoa7gjWNmQYBHCgsofiKlJglmjLNBA7xUFgY+nY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b16d2c-8508-4829-b346-08d8080dcfb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 22:31:08.2637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1wccm9fwI7AJS5yAX3Qpbh3qp/ihjUXlLVSiw3OsgoD+EH39KwBbk+yO1ADUBREQ5vCMLbJAY6mb+OLSKMDubAAY0syyRwJIuEgsi5uU/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_153116_361306_AB30CE7B 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/3/20 6:10 AM, Christoph Hellwig wrote:
> We're done with the 5.8 merge window.  That being said the cleanups look
> ok and they can go into the 5.9 tree.

Sorry my bad. I didn't send this seres in time, thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
