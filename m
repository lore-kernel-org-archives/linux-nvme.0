Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13523C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:11:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD53864DDA
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD53864DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=LUUBmjeAQkr16preEI/cw0G+z+gn/GtuA1HSnmJAJwI=; b=hdgUcke5ACwCCd9l4DQC1nXg/
	Hj+zsDW08jItdoF8yq0eeRAvVwQ9Bg0V0089MnLNpbbOHznFsnfppQyVdho9t7x2opXh469sS7Zi8
	aebpURu+K5RkzKrTg6hGk95ctMRJsGQuonnxhcvuVdoQjlt61WL9tUvG2DTPGNlA8s3NR3rrCYQ49
	LSmVySM/ugzz+ltb0BbvjP4WjvHazc7awM3oUgV1+sNEBRcAZD4pHX1/cf4FI9XtEXNe2b6s0qvCq
	sxjl6miAWbiFjd340ZRv9Psdxj5QbBpQDPWlbshEpY5IduMfBqJy7Bn3NrFlxVXsxZpFSgrF290zp
	8YgREdpCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGR5-0000UR-Oi; Thu, 11 Feb 2021 18:11:27 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGR3-0000TR-E3
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 18:11:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613067085; x=1644603085;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BPEVwclPfdpA+uZDGKchbf0Uk+ijKGLQOLX0HhkSirI=;
 b=ITDU2HS8cM3JLs5/ZG8XfB2zfQDbr1iHc2xgkdUEAb+ouuGYhN4t0o7i
 x0MwIOxR0q8GH6hqkjj4foiNzc4mvOwbvDRoFLJQuQozMBPkY8eeqCd70
 o0NmcUguS+IAZ6abYY0sigegM7ZgW53UBIcHgYpcCVwVy6mRmrDZWiTfq
 NBsl99kumFfDx53T8+8qaHMFvEN1xDl/TxEUe6UYKqD5j+HeDPwQRhN2Y
 15AeD6CN5GG2YHyi4ZOJw+OchBNMPa2p2/tWrW9Bk+xLuIS4BtoMGWXlV
 Vax1KG2L37NRUoK0/XQnAn6IWWpfocVZoD5kOJ4BbpOBdR3zY6FRE+Atr g==;
IronPort-SDR: 1ZIp7P4ADVEgW+3SWpfLFJ7GE60/UmIJG7uGRJvFQS+s9Y036A+vUzPoEUqrfW5EVAT5RnsbAb
 lVcM+nocW8IVUTWB4zXMpmGKTdkf4oAV9XhaywsNjdxHv2gsdAiL3wICQL2tJfes0R1e0W/Idy
 q/EfULQFuoZUZpFpdEg+ANuijOuoqVGEPaYjUAVZ65HsDYbgRCOvPEYASBRluO6gcGcYATmNsn
 autdUQ5OXvULrHOFR+W7oCl+mdCMNkEzMouxpa6RCqQFMC84zDjjlDXsX37b0tkUEqflJu+JOl
 aAI=
X-IronPort-AV: E=Sophos;i="5.81,171,1610380800"; d="scan'208";a="159766475"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2021 02:11:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr5ZCc8bMrqNVpcZbXXyNh+/Nmzf+jcNUnbfDDWMptf9JOeqeO+qI8cSCz0zXvAYPNylsM9b1TF+M4dVpvWYcNxhsUxGLxlMye7K/GGaAV2Xa3CCYtt/6yJfujoMxxjTyeSSYFepm1nYR/nqy0MvYk12lHSQtTJoB8r+l/TH0a6KSrfdEfx3b81a6g45iizdg+7YhNZZCcMa1b7A31KZCwT2L3lRUjMvRsY0aL6mQ2b5bMuniz24x1KoYeTT8CGdJ/+FHRJmtwExl1c7zdRImXEAVaAgJdFiqbTPOBXKH0zunNi2nBHbuQaszmIBcNlvLYL2h0qqUZ3AYgx6AfvECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KZO8jsSXngvD1v0Bz5fCYQQYAojOp4V1KcyylhVm9k=;
 b=g4dIZ2Yj7CAPw2Zu5+Dui/iA7r6gAHBQRNWyY7gu8V5aO+8Rt+aAINvGF2HHyrejzX8FbOsq6AEs6lOsVuvUP/4yKOmUKa2XWGklFT7RGSDMzq9GM7NsdWFR+8BDyiuE1tikvnfwPfeDnw0uE+S6Bs7FGNta+i2h0EdzIr0kwjneOUg3kppoI3VRmli0Xj7dMDaIpm+tx+qTGzkQydQ/tplDJsnqnvA9kGaMYciIuzzEkuXHd0AVVn1t+hl9tmGak555QOBIddzuIeER7kLm54EEpS53f1uCbEgjfKW1ghr9TFHPRSExVTFSxJe2jEAmyGynvTKh5IpCNaYYd8zxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KZO8jsSXngvD1v0Bz5fCYQQYAojOp4V1KcyylhVm9k=;
 b=X0sZJWi8q639FMP6lBrTnBu/Uhms7e2TZ7dh6ZSNRWuOrtidr86Pegs5QW/ajSt4XuplTYBSl5Iw4Nc69MMBu5oSR1bQVu4YLkUVqvjU41+Pt371pDJSE11AfQ3sw0Qoaov6skI5G9YgYMo3m20Rjk6PCt5nt0Q4S2eMiZw1LfM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7744.namprd04.prod.outlook.com (2603:10b6:a03:32e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 18:11:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Thu, 11 Feb 2021
 18:11:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes
 command
Thread-Topic: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Thread-Index: AQHW/qFWhMgmVmIHi0+62c2Fpd6hig==
Date: Thu, 11 Feb 2021 18:11:19 +0000
Message-ID: <BYAPR04MB4965C95C3F826D7222EB3176868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <YCOxjZhBTBchOq0n@infradead.org>
 <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
 <20210210131557.GB29904@lst.de>
 <BYAPR04MB49650A271CD1C1B3EFA72F3D868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210211070748.GA13852@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2703:6e00:a1e7:39ad:c095:f42c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5f65a3a-5009-4575-9996-08d8ceb86e6b
x-ms-traffictypediagnostic: SJ0PR04MB7744:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR04MB7744B2E5593B4E1151CB57F0868C9@SJ0PR04MB7744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beITwLdAXr4rcCxQIENkFfj5vCH4Z2jFQgqfGef4rLtbajGb2jf5DqzAh6EDVucODoZGVq4x7nd7ATVXL8W2Sez/P7SmaL5GSJWdP8GT+gwGFlmwdGXM6Rgeex+URvHJEn+uwY2LSN0S3+7SjHvw/9cw4rs7JbqmlBVDn68dBytmdDRzVZ5MCl2sMThxZz0EhROr3+mrX2eXwWqs0exlKGFZw9iwepSRKfaFQjxUBzLhtsnpcfkiXSJN0P9qYgyhEKp5AOX52NcbzZnV4DYq38QvNlOuqWBjgx9uLoEkNDFbJzXxPIzqToZPm5oHSFBKwFtftX4ealkVDcy4gRbbFURv59jGjK11Iv9heZuNMHx8PCziPkGiBDlgw1IpunssZjluI7cjlzlVrEMN9kVYW8dgnnmHD4wQPC2aaM0A8MH6odVzvWoT2MD36sqoFmrl2vKRWwCz9x/76/Y6Q5HYkGpit6eCEpUPeYDfqhgluMspvIsMz89vgl+codjxfpzgIMe0PigJXvoJPuuKqU+dfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(33656002)(55016002)(71200400001)(8676002)(4326008)(6916009)(9686003)(8936002)(53546011)(6506007)(54906003)(316002)(186003)(2906002)(7696005)(76116006)(5660300002)(4744005)(64756008)(66556008)(66476007)(478600001)(52536014)(66446008)(86362001)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?95vWd+E63OW9qGdmkiAJpFad1oeIQjJ16RJDvSorzw2kIZi+g1z/xXKmlzR0?=
 =?us-ascii?Q?xfd7NTho8NJkySA6X05T/TuLF/7i9ffRzNbq80Ia6+x1czz2SC7h5b0/sjpQ?=
 =?us-ascii?Q?Rc/MAo48iTfofj257rgTzgwJtDvktXlZHBYWV4T9MoT7yMwDnpTb6f8F8Thb?=
 =?us-ascii?Q?WGNxhYsMqivWIFaaQ3y/vUC4k6Y+Xa8AXk3NuneCfcUBzJeeDtLgeIwjuDq8?=
 =?us-ascii?Q?hHQkqwjCTRpLo2fo9E1KrWJTF6DN682Qcqudw0JpsOMgViAdk2UpRusOGnra?=
 =?us-ascii?Q?iYkMj799gh0KshZ/9vi3yOs24opous9QAt/FtY49TWkczaltVpN2NnRmEORi?=
 =?us-ascii?Q?ITBVIqgseFzQWc545jKknJGvRDrPO4Q+9wc61jVamBsNTTOF/E3RSnURx8DD?=
 =?us-ascii?Q?xT8aa82aKp19JspOS25DztZj1q+wCvIcPQbYLBtBgOAKXx8AY6kvphdpvtmR?=
 =?us-ascii?Q?6F6+MUj3Y8VmfH2bByfx2zqQLpqaYEnbmMUahhN1EOizLS2QR0GFLQtZutvI?=
 =?us-ascii?Q?TpRPEZRtXVO7tNkcCx9iKOQpsX64AnVDp35gB65962gKuiRAi47ouriGLbDT?=
 =?us-ascii?Q?0u3QdvMb5EjjL9LI+z2BupfrnBkY89SsoO04AEUfBJn6r/TfBqdcvyi/2c3v?=
 =?us-ascii?Q?de2suwegiWjsKWNxQfRaf/JJ9C07r7Ev7XSUfbZzkUcKHL/+2AgOk8dWYMaX?=
 =?us-ascii?Q?t++lqYQ5eDZ5u44mQvnP3dGep5GZYCN/LR1uzzvxqe6Uy0DmwsiCLXjzj8nY?=
 =?us-ascii?Q?4ifFe74tasIgTLw65Ze7PZlfG6NqePecpjonrS/OmMzXc4zVhtu3/JZPPHlZ?=
 =?us-ascii?Q?76kCS/GhmbNhAWZP0H4KieuWeq2WZ2Uufl5xZq3pEiqudY2AFN7hkAWRZtRZ?=
 =?us-ascii?Q?fgmn/TDBoiwxwdW254x/CIgzzQgGgGIVHOdCnrTfSEZGAl6WRW/3toy1b2Yp?=
 =?us-ascii?Q?erM1OQMNG744Ht5VUYrNCuTnZNteQ2ol+4Y9HfV6Kl9kwo0+RWzGpRxs/EIV?=
 =?us-ascii?Q?ckxoIV+7rL0myEyK+pW7N+K5BSPLm1EASc8HYTjrzi4O5J4ECDNtZqNcDFZG?=
 =?us-ascii?Q?uO2Bn/qMNSodeXm06e404cT0f9L2YFq/h2WVmyXefZLM4iOPLmo2HY6a9Sb3?=
 =?us-ascii?Q?PAGho39//O9rtkrucvJTfad3oPS5ZN2uEisRchn67tLrx8EXW++3nCU2xcwo?=
 =?us-ascii?Q?msG4QcaVYWmAMLFWKBp4pwtHr6F4VE2sH+hOLGeKhBV2Kj7QK7cPRiWiFV0t?=
 =?us-ascii?Q?05dsdnPfnx10nVWgjNAbyoxKPMWDPhEt5GeytJ+7Q/puBu0ei2AcKhaES7E9?=
 =?us-ascii?Q?1s6W46kRGKXXWegeH5jJDYie3hNM3QIyUcX3zj5aRq2qh0jm113f4xUmBd8C?=
 =?us-ascii?Q?XASYkGzpoRtjA6GvTGv6SN4JHccI2TzZuRTuPL4O450OyZm1sg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f65a3a-5009-4575-9996-08d8ceb86e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 18:11:19.3675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjmZ9jzovRRcSH9h6eLf0ge8H0kXvPz9vMbfAeWlNQ5Jyd3B4LyJ0rXEBWMZM65Wb1LuqVdTcZEZutx0XxTkJ5iR4VUa98HUsBsq0Fa20Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7744
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_131125_600974_F42AE30E 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: "hch@infradead.org" <hch@infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Gopal Tiwari <gtiwari@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/10/21 11:07 PM, Christoph Hellwig wrote:
>>> I'd also love to retest most Write Zeroes quirks with that in place.
>> Do you prefer some variant of the following patch (totally untested)? OR
>> something else ?
> Somwhat.  As said I suspect defaulting to MDTS with a big fat comment
> might make most sense unless the new WZSL is set.
>
Okay, will send out patche(s) soon.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
