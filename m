Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B143DC4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 02:21:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254F320720
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 02:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VnE4VlE3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ssstc.onmicrosoft.com header.i=@ssstc.onmicrosoft.com header.b="VvMdV9SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254F320720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssstc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FKFx1S+60aIO60GexiSG8H+0L11r9le1E3AzdodOwfo=; b=VnE4VlE3u8yHgEaWoGU/vcDg0
	rUfStiUoQhrLoXbej1CLbG3FWrpSKzHyZf+oyziKBW+Cf9Imx/140nzTZO+B8SOBkOM+mzOoomp7P
	HELLOk+uqcfVmEVO64DB+lQKJ8sN0ILTGF7uILr6JIc4puc7QAebwqD8B0ZUUWC4/WMD4Bj/ia4fA
	vwr4BAjQR5NLZSLriDzp1ZlryjCVUEAW0r3u1rlryWZXhEOAEfXc/knuZPOp0hwl5cN8tkvpFBG4F
	ioN2sjJwvDe+iU8Grc2V60L/UzQUbxa6FYkjSLp8YHevgf7FRiMbMmmEA+JAnbOAiKJkikTr4qOEA
	XnFAU8xZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXxYq-0006f3-QS; Thu, 29 Oct 2020 02:21:08 +0000
Received: from mail-eopbgr1300055.outbound.protection.outlook.com
 ([40.107.130.55] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXxYM-0006VP-HZ
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 02:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7jLIXGqViLiFffxc/4gUZD/1N4V0/m8OZ9/k9XruEPVxf2pgXye6JojTlvWbzV9sqCxmWD4gc7dG+FUPRF236x225Kv5HNrLZHjXLk98FGx3O8+TjCs8gUQAZDzPBXaJISW3pTUw+nYq+vxi3s+xMezacAuiPGeaWGc9PK6Pjb8APxNJ20EVULwi7WF995QhaUvopH63JOEvoZfra7lxUcqqokwqxv0OraOUaNNMk+GZJSipDIyjCdWeUf5Dj5QlYg+thj2lLhRvHMNw2+RB7TFcChxqOXO3Ggxgh28rx3ulEeI2oZ0u5GABYswZncKC69A6QSNCuD7TRThNDYXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRr6GD4peYhwBu6TSUcP2ufOONkFko7IdYHT7o8JkJE=;
 b=NUe+OtqgC5dN7lyd5OPJRsXZgTuZgMGG4jKkVPc0kqqiiNQ9Rx8+uq5pP51L5RzT/+/IQeEyBSw2i3wt+T1nnRc0Xfl0MKI83jp7oBU34bNfmRupewy/Knc/ZhfqOynHpWFM/qw1GaIUwiKslc2cU3QrQ0xKIIVzLZWC42RHcPpnmE1+E/QQJAOU2/U5sUGTMvbruhxjkrXc9R3k5UBdz61jNqfs39XucmKdkUqjBJ0k8N7AXPkpxahRevbm/wIgkOyNQrblvR8Z+RhVjR/KiyEE96pjawsQEFRkcRtT0O54KOckVZv+pARCc9bwoqnWALEX7SkDK4iRde4LbLm0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ssstc.com; dmarc=pass action=none header.from=ssstc.com;
 dkim=pass header.d=ssstc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssstc.onmicrosoft.com; 
 s=selector1-ssstc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRr6GD4peYhwBu6TSUcP2ufOONkFko7IdYHT7o8JkJE=;
 b=VvMdV9SJsCJoyZ/GlXCdNCQvK589xKWrVuNIM8ikXenhtFjBTPmrwLzhsqvuqi8mcyZtXXjP7sKkaN7X8tL7z8dzIXuBpDVwtEmJYc+6jrMcKIHASNfwUWOZcHoa6YmGOgtWgSlsjFR1pLomKKW3wJBECaT9ybOcdporVSiOtCE=
Received: from HK2PR02MB4004.apcprd02.prod.outlook.com (2603:1096:202:22::15)
 by HK0PR02MB3795.apcprd02.prod.outlook.com (2603:1096:203:9e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 02:20:27 +0000
Received: from HK2PR02MB4004.apcprd02.prod.outlook.com
 ([fe80::e10b:73fd:962e:1968]) by HK2PR02MB4004.apcprd02.prod.outlook.com
 ([fe80::e10b:73fd:962e:1968%7]) with mapi id 15.20.3477.034; Thu, 29 Oct 2020
 02:20:27 +0000
From: Gloria Tsai <Gloria.Tsai@ssstc.com>
To: Christoph Hellwig <hch@lst.de>, Jongpil Jung <jongpuls@gmail.com>
Subject: RE: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Thread-Topic: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Thread-Index: AQHWrQrF3kKZ6Iwnv0+X+dwLEwfIxqmtQlQAgACXJlA=
Date: Thu, 29 Oct 2020 02:20:27 +0000
Message-ID: <HK2PR02MB4004EC30D14A16B59FD22A44EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201028171726.GA9897@lst.de>
In-Reply-To: <20201028171726.GA9897@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Enabled=True;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_SiteId=5715baf5-0afd-4dc3-a35d-166593a054fb;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Owner=Gloria.Tsai@ssstc.com;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_SetDate=2020-10-29T02:19:58.0026310Z;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Name=Public;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_ActionId=4cf439d7-2a63-457c-8649-43b0fa949cb3;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Extended_MSFT_Method=Manual
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=ssstc.com;
x-originating-ip: [124.219.110.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c5ab13c-06ea-42d9-dcf4-08d87bb13345
x-ms-traffictypediagnostic: HK0PR02MB3795:
x-microsoft-antispam-prvs: <HK0PR02MB379541773C4192237A75A4EFEE140@HK0PR02MB3795.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Am2eRMNIrm4ialqqDm6Lx1GbrHMd8jAQiymoHuv85Tvj2p/aY82csaS6le2VLJKJvPwZvVPe1k3AorJVbQnOEA1Ubj3gBVxf5qBVkp8ufTN0H3u8NwlGaCF/j+oqXQh4fECPMxwEeHSVtY9KbiTGNtuTdOvo6SIMxDvGR8eNCLkLYnxWatlFcQ172/JJi5qjcZu4/OGdDeEjRHK6YmwatPGKSXp3uqnzbb9KLjogPH+dxXjsaeeKk6SrJD2aDQDwaA4C+d0bpOeugPM1z17IKvp6zKYsGprEYGLT00Ku2/kc+HBg6Zftc8bUH+vDZgCK0sTmvrZHdyPNNSCBgjNEiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK2PR02MB4004.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39840400004)(346002)(396003)(376002)(366004)(136003)(186003)(2906002)(26005)(5660300002)(66946007)(55016002)(54906003)(76116006)(8676002)(66476007)(64756008)(66446008)(66556008)(110136005)(316002)(4326008)(52536014)(7696005)(8936002)(83380400001)(86362001)(6506007)(53546011)(55236004)(478600001)(33656002)(7416002)(71200400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: n/StWL8dmz236soAczjLoAPrI4JBebp3ASnF0zX3Fq0vbgjCw2lDQwFjTLcDfHlpMLiBgkwvDOlqLH/Kcdwp515NuVw4sRVpLChtt4GZiWdDiu2vnldjoCGwsqt4DtrZyYdt5um62RLJwU6bMOO/qokQ3HwXmbgJl+SIm2Dq3AJTCW8l3p4KxsJCD9puiErGN/QX6JXGMqtiTKTVFWqoO2IKF6oUvDv5VEbDsPED2gKGgBn9YvSmKf02jkhnU10XZKh8eD0waGdLjZg82eJe5r+NmHoCZklozv+uU+GDzgJ8vTW9B0n7Qhbmwpm0s+Bg3u+WaIPstgTAodLinJYpThVBRxuMmbZMBfpYoQEQOzDaRosHnUlteWcyrEcS5wtS5/bQj73bPhv/6gn+f3sBmkfhPFDAYjw+VfAFxN1bM+WWX5b4wjHRT9r+WJp8CDyjvAjwD1WYZ1Z64yafTo12j1in3NxPSdhOi9OiRxloWoTD8hgwbnrSphd88U9v8M1/5o7YNY8nY/R1CacyhAy13IQiFjUh15CWzmr+QenFSwSzZ2C0MMnuOSY9aWpLtsLxNA+mX8a3TA/bw8zUkb9ej2YHZKh7fEXAC+yc8H+ujoiHBRYDdKz5uKZ6OgfGegZkO/KJ3jiRotocPIgWqF7pcA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: ssstc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR02MB4004.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5ab13c-06ea-42d9-dcf4-08d87bb13345
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 02:20:27.1170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5715baf5-0afd-4dc3-a35d-166593a054fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4uN+bGny/VFLLvX0VwAzbxqA1cMcA9O4kYfIm/DyPh6QmyrU5B8iVbnoQK4/n/rSAdGNRzBrw99SDUQ6nHgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB3795
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_222038_800905_5EC28A38 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>,
 "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
 "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>,
 Keith Busch <kbusch@kernel.org>,
 "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Corrected the description of this bug that SSD will not do GC after receiving shutdown cmd.
Do GC before shutdown -> delete IO Q -> shutdown from host -> breakup GC -> D3hot -> enter PS4 -> have a chance swap block -> use wrong pointer on device SRAM -> over program

SSD gets in low power mode only in suspend, this issue only happens in low power mode. 
As for Hibernate, power off, unbinding the driver or even warm boot, EC boot, SSD won't be in low power state, so there'll be no problem.


Regards,
Gloria Tsai
_____________________________________

Sales PM Division
Solid State Storage Technology Corporation
TEL: +886-3-612-3888 ext. 2201
E-Mail: gloria.tsai@ssstc.com
_____________________________________

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Thursday, October 29, 2020 1:17 AM
To: Jongpil Jung <jongpuls@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Christoph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org; Gloria Tsai <Gloria.Tsai@ssstc.com>; jongpil19.jung@samsung.com; jongheony.kim@samsung.com; dj54.sohn@samsung.com
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW 220TQ,22001



This message was sent from outside of the company. Please do not click links or open attachments unless you recognize the source of this email and know the content is safe.


On Wed, Oct 28, 2020 at 06:14:21PM +0900, Jongpil Jung wrote:
> LiteON(SSSTC) CL1 device running FW 220TQ,22001 has bugs with simple 
> suspend.
>
> When NVMe device receive D3hot from host, NVMe firmware will do 
> garbage collection. While NVMe device do Garbage collection, firmware 
> has chance to going incorrect address.

I'm still lost on what this means.  The device doesn't receive 'D3hot'
from the host, it receives a shutdown request.  And we don't just do that when hibernating, but also when doing an actual shutdown, a suspend to disk, unbinding the driver, etc.  So if the device has a problem with shutdowns we really are in trouble.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
