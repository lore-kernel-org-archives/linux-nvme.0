Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67221C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 23:41:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0782B20735
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 23:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNN9KHfU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YmIV0R60";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LnpLQGR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0782B20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3VqC5SWaBRj/DBtMbg+Ad0OXqGtJAkkX+hESX4g2y50=; b=HNN9KHfUBvTnCB
	3huZ4G6Xeh6r+xlhW09sgI/jP52/XrWXUx1AK7/6owp/5kOPnHchG2EAust07iKFePW9kjkK7mL0P
	FF+YrV/wELuI3KyXHd6Q/T5D+o8ZmGE5bZZE8IE6Ai/xjXF5xQjEm750NkeX2OaJIBC6fvnRrqhyt
	i5+VTdEVKPDK2LxWhBha+JHDT8tqkm05lDIvi0Jg4WgNMwy0gkSlzffeka4m171SCLnFHH4KNVRGD
	MdaBZQjzlLNvd+v590Ff6cArS1pGLHRI0m0CGM90FSNMm0iAVvnhB4AuD12PJfGJlTZZcyev8yWso
	PcVNuChLTxYXhQMImDlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWTfX-0001LO-DJ; Wed, 06 May 2020 23:41:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWTfU-0001L0-5z
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 23:41:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588808504; x=1620344504;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=QSA7pL1SwQCTHn3GYhPbUPfQ4JQBsMOnZgNIykX/VBs=;
 b=YmIV0R60X75y89diCm4V1y73dBr+7r7WFVbdkZ5tGAyWHF2KBILmK2tM
 eANOm1u2XD/Tp0/pX6np1xw5gFsFsfkchdeSaj/egpsnU61CL8RV3XWcD
 xqomf1ac2gIq/tbKkZlReJzfwGDNGkJ0RSAX3cFMfzjuBxJQ77irepVsV
 CrYUe3LzlTHcSyA69TOPDur3EJFmIYyAEklRkABLioKncWu6/2kAECNQm
 pAe3uZrHabe39kyMmYd+bIb3Y8TCFvpDk4n0aZMLSGR5kU3Od7XKvcSh8
 hBbQhGsXvPNzqh2OkXmLR33/xVBMUayBQxwHOf1FSxThs4siXy8MNO7Pq g==;
IronPort-SDR: KdHpuDPgVKA6N80/n9eEVuioBDg1lYFSTHODcSh499UgLfchT7W7k0rYguU8QOKhf1cctwCEMI
 6JHUKMuf4PA7z1y0AUngEanqdUyBpBy8MhewN90koGIR/xDYFQhmc+gEOvs98GIyWEiTXJD79t
 wCP7q3snGKSQwHl6u4szLvjsUdZjm+ZsWCHFrRx3ggZyk8XcIukhKq9/kj+YIiU1Jb7/YDBasW
 nGZ0DQwAw44bBFNSNXN9KdHYPLqD4cK/v5PQ+5+OKT0072bH70Tj2p6UCOefq7cc6sq/57k3ZP
 Ysc=
X-IronPort-AV: E=Sophos;i="5.73,361,1583164800"; d="scan'208";a="239720656"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 07:41:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpIbXflifUqapbD6Rt7OO5xZITH1Asut8eJIhE/QsVUg8XGRrCf8qBle7mI0fQkNfeZ1R3K6wDqqJGadinUSKujFTRz0TOymTfjDOrTTHJwBxcUJ2ieg+omkhl6oKakye3+EWj6FN40ZJjJZveyDwqrNJh/lN1pQm1Nhw+a+Xx3GvuAgxYdxX09ur09QFiERBnVHhlr2OFxGVCG2FMSW7gX3O4HULBpWzvg/KF8Ug6NdMi8J8e3PxJw/tn+bKyos+X5CwFWJsKVWKXODCddAZB+rZXYVOu2v5r3f8/bo6sE6Tc+ljxl75/sfufjh4x82zIu4LaZx9YSwSw6BYNgd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXJMQoFSwqJLyxitxsBX4FCOxqKZ8SVatpfpynNqiH8=;
 b=ez8ARcbVUr509/7XErlgTT84a2Oa6zKz16+pYPXknz/PbyX+x/JJVoT0C53PH9TE0BLYe48ZZOH7nSc9FqiF6fmWzsYf6WI+D/LPtKYlWDtaaY4KO9NB3C1LwnRKrR3YHgQiDFlKSRLJ+70FSu+GKqHeL2iAE1q7TyBUSpfR47M+oTuQidQZd/q7JL+HlvFigMgj+iESWhbSIB5U1nkUbvMKxm9TrNm8wHJFdMrJDNDHDSgWJ2NUDEjzEjtHpLpSy3POz+tndaZOXlgsUzEFtev51keYJnJ/pvFNFir1NL8ymXFaP+pkTERoryQrwnd53Pt0xphwnZPiu3r0RIgtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXJMQoFSwqJLyxitxsBX4FCOxqKZ8SVatpfpynNqiH8=;
 b=LnpLQGR2kdo9TpYxCD6/I4xL3btgo18i6spBw29QR34tlBAWvLlY6HV2fbatF21jYt/tGU3/7EvmdDBzOI4hwTQSSVEnBMNBqDrqEzIu3IOOtwMMFaeasv2L1B8jVo/mZQi3kF/WT7cFtpHjGzveDwURri9AXID5tVbiwPuDtOs=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB4138.namprd04.prod.outlook.com (2603:10b6:5:a5::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Wed, 6 May 2020 23:41:31 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae%6]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 23:41:31 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] nvmet: add helper to revalidate bdev and file ns
Thread-Topic: [PATCH 1/3] nvmet: add helper to revalidate bdev and file ns
Thread-Index: AQHWI0hCx561ErBnDEu/z4L0Dw1HGA==
Date: Wed, 6 May 2020 23:41:31 +0000
Message-ID: <DM6PR04MB4972ACBF9D991195431DB2E186A40@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
 <20200506014629.39509-2-chaitanya.kulkarni@wdc.com>
 <20200506071118.GA12145@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db484b3e-23fb-45ad-c002-08d7f2170161
x-ms-traffictypediagnostic: DM6PR04MB4138:
x-microsoft-antispam-prvs: <DM6PR04MB41387F85DFBE97A6E9FE2AFC86A40@DM6PR04MB4138.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OliwDnF2djhroaZ9JmaCZZlGNajYSCAS2lCom5ujhioSNX6shY2qyf2IWZwIKqff4Iph+iqGdiuzeZrT/eZIXex1aqdqhpcZfx1IWILjazzalAVTFbGzJ9kKOr4IJEajrxOuvkjlF59yNHr4v4ebncX2LlCGUEGKaqfALCqjWnOLeOQnq91xA9L2vW/3CtTr4E+Olmp66mFFOL2grUINTasFbMDWJKOX4zm777J948Ky8a4FUjViK13ex9O2B2UabnpDnJaSZShLG2xPN8XydGXTXpiDnFNrfIkqWaH1cQwMjTShbphEQUAYVnDbpB0U6OODK2BecNDmRnSLN25qbxTxhmABcHqkEZPeD5rBz7C6jDYjmiy3v7LMzwTFe49G6qxkeoY2lxPXpGu8hDaDUtpOPAU6PCL1LozfjnUIVMpoDuOigUa1QOLW+ncFy9LQh/KnkeORl2/wJIfKd74Jz4XAFLfcPL8OobIkvuxLGMij0tacDeVrFtc3vAQ9asAFDkngAuqY8sB9J+t02mN4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(33430700001)(558084003)(9686003)(55016002)(52536014)(86362001)(6506007)(53546011)(2906002)(26005)(33656002)(316002)(33440700001)(91956017)(76116006)(54906003)(6916009)(66946007)(66446008)(66556008)(66476007)(478600001)(64756008)(5660300002)(7696005)(8936002)(186003)(71200400001)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AIdRMG53/00kOsQmw/fcZ3EqXv4KWfeF415uqzmH8GORPYy/JqDkX1DM5SWoI2L5cLHhXp9venyAb16axL+Ju5ARnDSAito9gLnadddPw/iQR/zzCS+AN5aMAvCNsfrkjhzhhwgaBd8jfhPreUAQBPDa7ABXaLsy7j41GEUA0Z87ld41iwKEsDIgskL4o6mhy1ZYYkovnnT17RjplGg6Y1ZfaBN3CQExL36yr8fJbKCJAYfIdKe+7w8IaPHZXPa9uladv2hmBCgX/EqsDWZVD8f9/VjXZcIvnVcwl4bCaZuREy5N2TABw0FYHT5l/DeKI2x4MEKOkexYsguzw/wpUmnSECp07rbTdmTTxBBENaNGsxgrFa9xJthGzJVqmNvIAjgT+J4SFlbBMGRtZzrni1iNkqe2MuLTszxC45qICe017sgk7HOBcbFJsKEnUbMYDHkDXcZoeXHXR/TAntJNiIvU5WZuXCCOk5IH39BfRBMzwvfp8/HAJ3cE/jTwYgyu5diWdSW8s5AnW2jCgkreRyy8427GKMDcYSyvm+20nd4gCht9lzzOGpUmdWpS9zL70zDrn2pGgcFFWKiklHH3bYNt5L/2BExSfXNslOzI1dVi8141agXhe1t1NCYemUJV9RvKE3cNqGLwrCm++J7nLFq4PX2m9LXsiALa/OtvBiiOO8gBI5CN8TARdLm99F5YyrK/x+4RoeA0oA/2mLi8Ao63zUjapf6wTGLETe4go3X7ILNb6fv3WpOri6vJd4q9JK4hJNJp5lmWRVqGtUF7mHUuif8K6MPhW+bB2EXw+ls=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db484b3e-23fb-45ad-c002-08d7f2170161
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 23:41:31.6448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsKFIHhKjvMdVbrUJKF7fWH/tLHZmrCKz3c6Ej17Om2cnCyZJVvHkGHnAUBowREF7h3cuZlxYPqQ3ceXZxrei4FEviYztejFpwmjhqYKNGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_164136_385607_C24FA086 
X-CRM114-Status: UNSURE (   9.76  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 05/06/2020 12:11 AM, Christoph Hellwig wrote:
> I find the calling convention really weird.  I'd always return the
> error over the bool, as a bool *size_changed is a lot more descriptive.
>

Okay, will fix in next version.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
