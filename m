Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84B3C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 21:32:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FBE22B4E
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 21:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IhPQmjZH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CBpSDUY1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HW0/Ubs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FBE22B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cVjwY/4NAQbYPrneWH+QrxH0o5/DQVptPnbNtT24MUw=; b=IhPQmjZH7WHmdITI8NpseTnbE
	DauZB14B7IBMoq/klMU0spaDDa4Vadd2BsxabPkbCSI3piZwm2DkfetK1ppvFC2oFgRsuFI5qD6f8
	xObXmaX08I6Nhqu0MxOR0KQzfiMmPyhtAl2dUpSqL7MxUsf4y+hQMkXquPFWpYrTHXulVtKhd426k
	1JEkpzrn4tI4ySNHDPuT2cVso0egzKokNb1fXd3gmAfc4+Cbsk2/1KT/MEjXh4Oy5Nm6bIalj1tGJ
	OognnshvFHsOBDOdGajbaUbrzUVpYnnUjAnsiiz8Ck5xj6Px+Al9ndi3jNwFkeKsbeywm5ZyPwFtO
	+ywqTb3Bg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxdOc-0001Cv-FP; Mon, 20 Jul 2020 21:32:26 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxdOZ-0001C6-BB
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 21:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595280744; x=1626816744;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=TZhXoFYxP1WlLzRvLsIksv9X8qOfQYwYaSzlf6gcFCY=;
 b=CBpSDUY1GrYxYG41LH/Vp8JTBpBq/IDQV74j892b9/y/MkI9KHkE+xE3
 XhowYRTAA4sd0GGEK2Kdlnc5KWE4DPoqDmbkMhBrbCFsuLtvOyAUTRkId
 SZVg6nRgCrtNzNtCI2sg0j0PmsRZpNUZvXMvtng4QkwWwGnzscD+FH2ub
 NLlclkP/aRTJtPJBrqalFxgf9La1lXh//VF2OrpxwAUpiIc7e3tclQilt
 P1UJF2X2XjjUVDw1EA1UxZuUYI9hPT6E297lQnn6oPMPhzebLj/CShwVr
 Z6VkpJ7/d6zvDxzKSr9IEk30QMHsa4rh3p49WZ5AgCvJlIstUtfJMDVbw w==;
IronPort-SDR: PMfIRCvGS7Rkwkr6QUz4hxeekxRqHZI6hoICSOAsnCooB/AQXRbP0C9S8rS+5o2guKg4PCX52F
 YXg5k8C1o6G5eKPftxBvAfk+++QBjEimo4XZ+i54V8XcoOMulVNkmShd2agWZgdr48ssBtTmk4
 ssX+KAg9EaJcVevUVuU/dzyIoZTY4droCbz/h/FGtH0OozwCNPMJzX6il5rLplOGa6RHYqO3NS
 jevoFqsPUiXVoH6Z2qxXQmM5/alEVCE+21EpPvDmKRkXfZLQQ7BFck7gAXTHQTUUlZU58l5idc
 Imo=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; d="scan'208";a="143047856"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2020 05:32:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksmhK3VgycF+zDDDRVMDbtQxW4XG1jHnqAlHZ6v6gA48I8hbZL0pMfrGXMYZjpuXnSPj3eMFuX6N7T1N9PgIPUxkowqEEV/O70WzSac/3ceKEY8npPAOlpECZk1iaN36BIp5VUJ4vw5/iwdUm78uriM/GLl9PV0I/z4I+Rg21ePrI4EgG8qQDH+VI07ZVdS95ID1+qE7Her1nlXeSKWPF1H0XifwrD9tDIQkHDopvk67vWfcm8yiK0c2FVcj4BwSi8l49VqXUs0goDKgyYwaLriV+ru1KzTIfJ08qFPWm1/mH4eHbZOG8AEIopV966kB5JX/1aZZitXeE6gqQlo8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=120vfGAWo/ZchWAJejULSMH5ZWGj2gMdde1hA+zKXkA=;
 b=Ktq7zHUCDjWhXYHOy4qWYAUlsAGeA4C7p/22AhSoT5gr9W+PKRfOTwuy1T8IJV5AsslzZvO90a3Fg2r2oyjSC3SvO2h+bywZzvzMDUCsPdE7ZegmaLOyAx7R2mfxEsGCbBXHQp7zoJ/HVhGDkbSEtFw+4/z8ergI0C8+8xdCFunOfrDVbZR4/Qhu97rv7x3uwG7tXXnvnbQ4A5dxEvg7b0E78GY876sx5SABU8tLW0cCAftj7OZVGTfmE4y+y11bkSTiziVUkMbDvNm9G6tTWYlJR1lNmzFIYxNxJE8cJVP5fNouZ9BTBgIkF8vVzFt4g80dbEBOJiTSSEIASksvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=120vfGAWo/ZchWAJejULSMH5ZWGj2gMdde1hA+zKXkA=;
 b=HW0/Ubs2KUYCH23Gfj3s1heI2JZMJpDLdHU6uQ3boRAJ+EZX2A/rvqEy1albiDZ62Qm9Ma3WYTuybUew3ngvXLnTxjep59P8GgBwmgT7Tb91HnLxSY76o1BvqJ8p1JPGvCbQ+cecIEjUECMi9dja4mDAi/HKqnXirsO/itHs6PU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6023.namprd04.prod.outlook.com (2603:10b6:a03:e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 21:32:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 21:32:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 2/2] nvme-core: use xarray for ctrl ns tracking
Thread-Topic: [PATCH V4 2/2] nvme-core: use xarray for ctrl ns tracking
Thread-Index: AQHWXkZmXOpHhHedZUyB54Ael1od/g==
Date: Mon, 20 Jul 2020 21:32:20 +0000
Message-ID: <BYAPR04MB49652884A628C23F24050ECA867B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200720033203.11474-1-chaitanya.kulkarni@wdc.com>
 <20200720033203.11474-3-chaitanya.kulkarni@wdc.com>
 <20200720133454.GA2837@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea152317-82f8-4452-87d4-08d82cf46221
x-ms-traffictypediagnostic: BYAPR04MB6023:
x-microsoft-antispam-prvs: <BYAPR04MB602347999007EC31222BDCCA867B0@BYAPR04MB6023.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vnFPyQHs/j9rQw0aCrDO1B9kgC5czrdnPEMI6b4OdFqiROPdkSPjSVr8ON2OwLWcDouk7lN2UAYG89m6Aef6jWnRZznazuFIPvlYnWVTZghAXkwPHfjdX8kVfMTNA5+OBsilWsIppkwquyUTKQS+8iFm8s0IdFf+9Zu0tw8xMeweoWsc7yI1sju9D5R5cN/tFPT57xSbnApEaE1G+wrXQN31gB9PlGXcvWoskVMaDCJ4rYxZm2OImmrbBd0//Clkcahv0HI7YKN7YE74QEp6Y7A6CATzi0pM+eBdwXX4oyIs51AiRqjPRbrIW1Dqk9TV5rZVpL5B0LwNjIgOzCX9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(86362001)(316002)(5660300002)(2906002)(33656002)(76116006)(66446008)(66556008)(478600001)(54906003)(26005)(52536014)(64756008)(66476007)(6916009)(186003)(8676002)(53546011)(6506007)(9686003)(4326008)(7696005)(71200400001)(83380400001)(8936002)(66946007)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: txrWVtIryA9DGuXK5yxkqAdiZvAR5IC72FRTq4J1a25dYuRLgT+l+8664z1zwP8kfzIypxGxrkJh+XwEATOIIhFAtfvO7Tw0s1ZGqgA2GaUQ2dUtIS8YDg2knbu24in4mzHmx0cLtu2sBu+ofA4Pcrr7b9KXp2r7ITAMen4YGPtjOkhP0WnNJIWoCFlKgD9RFK0YT+Ig9g1pEFL/7Un6ztwm1BtgB2Et1Vj/JVknfgZADfzkWsOIOgFH4zqKfEsCf9dbIItf1sGqbFMZX1nbs0IPhwLgYi3PWkifQNvWFh/L9wJG1o9i7UJY8TVzGnipQSsFeHL1sc5MZ1ZCGLZYUFaWSxnGH7nxSXuPqbUjP7fBGL4THhs82bB1hxfYD0qL+HQgFjcpmbGclVtbR4hz4DKa5S3JO/+EFfGInUpcBIPU2nPdPGMqD7qFaesT3/ahdPfwpGhPtw8jrXpKmZkAqlJM2mkahbb1aCzETSYQQPc=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea152317-82f8-4452-87d4-08d82cf46221
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 21:32:20.1093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpXZXTgFSSG8hW2bAzN7et4xD2IfMGCTH1yFGGx1G4xMRt7Ya1Q24f4WC2/iEesCsvCSfQADd40oJ7VE7cSyYd6gdxAX3TXefA9azYh/Fbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_173223_678387_C9734DCC 
X-CRM114-Status: GOOD (  21.97  )
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
Content-Type: text/plain; charset="koi8-u"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy8yMC8yMCAwNjozNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gU3VuLCBKdWwg
MTksIDIwMjAgYXQgMDg6MzI6MDNQTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOgo+
PiBUaGlzIHBhdGNoIHJlcGxhY2VzIHRoZSBjdHJsLT5uYW1lc3BhY2VzIHRyYWNraW5nIGZyb20g
bGlua2VkIGxpc3QgdG8KPj4geGFycmF5IGFuZCBpbXByb3ZlcyB0aGUgcGVyZm9ybWFuY2UuIEZv
ciBob3N0IGV2ZW4gdGhvdWdoCj4+IG52bWVfZmluZF9nZXRfbnMoKSBkb2Vzbid0IGZhbGwgaW50
byB0aGUgZmFzdCBwYXRoIHlldCBpdCBkb2VzIGZvcgo+PiBOVk1lT0YgcGFzc3RocnUgcGF0Y2gt
c2VyaWVzIHdoaWNoIGlzIGN1cnJlbnRseSB1bmRlciByZXZpZXcuIFRoaXMKPj4gcHJlcGFyZXMg
dXMgdG8gaW1wcm92ZSBwZXJmb3JtYW5jZSBmb3IgZnV0dXJlIE5WTWVPRiBwYXNzdGhydSBiYWNr
ZW5kCj4+IHNpbmNlIG52bWVfZmluZF9nZXRfbnMoKSB1c2VzIHNhbWUgZGF0YSBzdHJ1Y3R1cmUg
YXMgaXQgZG9lcyBpbiB0YXJnZXQKPj4gdG8gZmluZCBuYW1lc3BhY2UgaW4gSS9PIHBhdGNoIGZy
b20gbnNpZCBzcGVjaWZpZWQgaW4gdGhlIG52bWVfcndfY21kLgo+IAo+ILYnbSBzdGlsbCBub3Qg
cmVhbGx5IHNvbGQgb24gdGhhdCByYXRpb25hbGUuLgo+IAo+PiArCWlmICh4YV9lbXB0eSgmY3Ry
bC0+bmFtZXNwYWNlcykpIHsKPj4gICAJCXJldCA9IC1FTk9UVFk7Cj4+IC0JCWdvdG8gb3V0X3Vu
bG9jazsKPj4gKwkJZ290byBvdXQ7Cj4+ICAgCX0KPj4gLQo+PiAtCW5zID0gbGlzdF9maXJzdF9l
bnRyeSgmY3RybC0+bmFtZXNwYWNlcywgc3RydWN0IG52bWVfbnMsIGxpc3QpOwo+PiAtCWlmIChu
cyAhPSBsaXN0X2xhc3RfZW50cnkoJmN0cmwtPm5hbWVzcGFjZXMsIHN0cnVjdCBudm1lX25zLCBs
aXN0KSkgewo+PiAtCQlkZXZfd2FybihjdHJsLT5kZXZpY2UsCj4+IC0JCQkiTlZNRV9JT0NUTF9J
T19DTUQgbm90IHN1cHBvcnRlZCB3aGVuIG11bHRpcGxlIG5hbWVzcGFjZXMgcHJlc2VudCFcbiIp
Owo+PiAtCQlyZXQgPSAtRUlOVkFMOwo+PiAtCQlnb3RvIG91dF91bmxvY2s7Cj4+ICsJeGFfZm9y
X2VhY2goJmN0cmwtPm5hbWVzcGFjZXMsIGlkeCwgbnMpIHsKPj4gKwkJaWYgKGNvdW50ID4gMCkK
Pj4gKwkJCWdvdG8gZXJyOwo+PiArCQljb3VudCsrOwo+IAo+IEhvdyBhYm91dCBmYWN0b3Jpbmcg
dGhlIGNoZWNrIGludG8gYSBsaXR0bGUKPiBudm1lX2hhc19tdWx0aXBsZV9uYW1lc3BhY2VzIGhl
bHBlciBhbmQgYXZvaWQgdGhlIGJhY2t3YXJkcyBqdW1waW5nCj4gZ290byBsYXRlciBvbj8KPiAK
QWRkZWQgdG8gVjUuCj4+ICsJcmN1X3JlYWRfbG9jaygpOwo+PiArCW5zID0geGFfbG9hZCgmY3Ry
bC0+bmFtZXNwYWNlcywgbnNpZCk7Cj4+ICsJbnMgPSBucyAmJiBrcmVmX2dldF91bmxlc3NfemVy
bygmbnMtPmtyZWYpID8gbnMgOiBOVUxMOwo+PiArCXJjdV9yZWFkX3VubG9jaygpOwo+IAo+IFRo
ZSBjYW5vbmljYWwgd2F5IHRvIHdyaXRlIHRoaXMgaXM6Cj4gCkFkZGVkIHRvIFY1Lgo+IAlyY3Vf
cmVhZF9sb2NrKCk7Cj4gCW5zID0geGFfbG9hZCgmY3RybC0+bmFtZXNwYWNlcywgbnNpZCk7Cj4g
CWlmIChucyAmJiAha3JlZl9nZXRfdW5sZXNzX3plcm8oJm5zLT5rcmVmKSkKPiAJCW5zID0gTlVM
TDsKPiAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gCj4+ICsgb3V0X3VucmVnaXN0ZXJfbnZtOgo+IAo+
IE1heWJlIGNhbGwgdGhpcyBvdXRfdW5yZWdpc3Rlcl9saWdodG52bSB0byBiZSBhIGxpdHRsZSBt
b3JlIGRlc2NyaXB0aXZlLgo+IApBZGRlZCB0byBWNS4KPj4gKwo+PiArCXhhX2xvY2soJmN0cmwt
Pm5hbWVzcGFjZXMpOwo+PiArCXhhX2Zvcl9lYWNoKCZjdHJsLT5uYW1lc3BhY2VzLCBpZHgsIG5z
KSB7Cj4+ICsJCXRuc2lkID0gbnMtPmhlYWQtPm5zX2lkOwo+PiArCQlpZiAodG5zaWQgPiBuc2lk
IHx8IHRlc3RfYml0KE5WTUVfTlNfREVBRCwgJm5zLT5mbGFncykpIHsKPj4gKwkJCV9feGFfZXJh
c2UoJmN0cmwtPm5hbWVzcGFjZXMsIHRuc2lkKTsKPj4gKwkJCXhhX3VubG9jaygmY3RybC0+bmFt
ZXNwYWNlcyk7Cj4+ICsJCQkvKiBFdmVuIGlmIGluc2VydCBmYWlscyBrZWVwIGdvaW5nICovCj4+
ICsJCQlyZXQgPSB4YV9pbnNlcnQoJnJtX2FycmF5LCBuc2lkLCBucywgR0ZQX0tFUk5FTCk7Cj4+
ICsJCQlpZiAocmV0KQo+PiArCQkJCXByX2VycigieGFfaW5zZXJ0ICVkXG4iLCByZXQpOwo+PiAr
CQkJeGFfbG9jaygmY3RybC0+bmFtZXNwYWNlcyk7Cj4+ICsJCX0KPiAKPiBBbmQgdGhpcyBpcyB3
aGVyZSBJJ20gc3RpbGwgd29ycmllZCB0aGF0IHdlIG5vdyBuZWVkIGFuIGluc2VydAo+IGFzIHBh
cnQgb2YgdGhlIG5hbWVzcGFjZSBkZWxldGlvbi4gIEVpdGhlciBrZWVwIHRoZSBsaXN0IGhlcmUg
YXMKPiBJIHN1Z2dlc3RlZCBiZWZvcmUsIG9yIHdlIGp1c3QgbmVlZCByZXdvcmsgdGhlIGRlbGV0
aW9uIGhlcmUgZmlyc3QuCj4gCgpJIHJlYWxseSB3YW50IHRvIGF2b2lkIGluY3JlYXNpbmcgdGhl
IHNpemUgb2Ygc3RydWN0IG52bWVfbnMgYXMgCmV4cGxhaW5lZCBpbiB0aGUgbGFzdCB2ZXJzaW9u
J3MgY292ZXItbGV0dGVyIGp1c3QgZm9yIHRoZSBzYWtlIG9mIApkZWxldGlvbiBlc3BlY2lhbGx5
IHdoZW4gaXQgaXMgYXBwcm9hY2hpbmcgY2FjaGUtbGluZSBzaXplLgoKQ2FuIHlvdSBlbGFib3Jh
dGUgbW9yZSBhYm91dCB3aGF0IHlvdSBoYXZlIGluIG1pbmQgZm9yIHJld29yayA/CgpXZSBjYW4g
Z2V0IGF3YXkgd2l0aCBhIGNhbGwgdG8gbnZtZV9uc19yZW1vdmUoKSBvdXRzaWRlIG9mIHRoZSBs
b2NrIAppbnN0ZWFkIG9mIHhhX2luc2VydCgpIGluIHRoZSB4YV9mb3JfZWFjaCgpIGxvb3Agc28g
bm8gbmVlZCBmb3IKcm1fYXJyYXkgYW5kIHhhX2luc2VydCgpLCBpcyB0aGF0IHdoYXQgeW91IGFy
ZSByZWZlcnJpbmcgdG8gPwoKQmFzaWMgdGVzdGVkIHBhdGNoIG9uIHRoZSB0b3Agb2YgdGhpcyBv
bmUgc2VlIFsxXS4KCj4gCj4+IEBAIC00MTE5LDExICs0MTE0LDE4IEBAIHZvaWQgbnZtZV9yZW1v
dmVfbmFtZXNwYWNlcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+PiAgIAlpZiAoY3RybC0+c3Rh
dGUgPT0gTlZNRV9DVFJMX0RFQUQpCj4+ICAgCQludm1lX2tpbGxfcXVldWVzKGN0cmwpOwo+PiAg
IAo+PiAtCWRvd25fd3JpdGUoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0pOwo+PiAtCWxpc3Rfc3Bs
aWNlX2luaXQoJmN0cmwtPm5hbWVzcGFjZXMsICZuc19saXN0KTsKPj4gLQl1cF93cml0ZSgmY3Ry
bC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+ICsJeGFfbG9jaygmY3RybC0+bmFtZXNwYWNlcyk7Cj4+
ICsJeGFfZm9yX2VhY2goJmN0cmwtPm5hbWVzcGFjZXMsIGlkeCwgbnMpIHsKPj4gKwkJX194YV9l
cmFzZSgmY3RybC0+bmFtZXNwYWNlcywgbnMtPmhlYWQtPm5zX2lkKTsKPj4gKwkJeGFfdW5sb2Nr
KCZjdHJsLT5uYW1lc3BhY2VzKTsKPj4gKwkJcmV0ID0geGFfaW5zZXJ0KCZybV9hcnJheSwgbnMt
PmhlYWQtPm5zX2lkLCBucywgR0ZQX0tFUk5FTCk7Cj4+ICsJCWlmIChyZXQpCj4+ICsJCQlwcl9l
cnIoInhhX2luc2VydCAlZFxuIiwgcmV0KTsKPj4gKwkJeGFfbG9jaygmY3RybC0+bmFtZXNwYWNl
cyk7Cj4+ICsJfQo+PiArCXhhX3VubG9jaygmY3RybC0+bmFtZXNwYWNlcyk7Cj4gCj4gU2FtZSBo
ZXJlLgo+IAoKU2FtZSBoZXJlIHNlZSBbMV0uCgpbMV0gR2V0IHJpZCBvZiB0aGUgcm1feGFycmF5
IGFuZCB4YV9pbnNlcnQgaW4gdGhlIG52bWVfbnNfcmVtb3ZlKCkKICAgICBwYXRoOi0KCmRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKaW5kZXggM2YwOTc3NGQyZDU0Li41OWZiMDAwMjc1MzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTM5NTcs
MTMgKzM5NTcsOSBAQCBzdGF0aWMgdm9pZCBudm1lX3ZhbGlkYXRlX25zKHN0cnVjdCBudm1lX2N0
cmwgCipjdHJsLCB1bnNpZ25lZCBuc2lkKQogIHN0YXRpYyB2b2lkIG52bWVfcmVtb3ZlX2ludmFs
aWRfbmFtZXNwYWNlcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIG5zaWQpCiAgewotICAgICAgIHN0cnVjdCB4
YXJyYXkgcm1fYXJyYXk7CiAgICAgICAgIHVuc2lnbmVkIGxvbmcgdG5zaWQ7CiAgICAgICAgIHN0
cnVjdCBudm1lX25zICpuczsKICAgICAgICAgdW5zaWduZWQgbG9uZyBpZHg7Ci0gICAgICAgaW50
IHJldDsKLQotICAgICAgIHhhX2luaXQoJnJtX2FycmF5KTsKCiAgICAgICAgIHhhX2xvY2soJmN0
cmwtPm5hbWVzcGFjZXMpOwogICAgICAgICB4YV9mb3JfZWFjaCgmY3RybC0+bmFtZXNwYWNlcywg
aWR4LCBucykgewpAQCAtMzk3MSwxNyArMzk2NywxMSBAQCBzdGF0aWMgdm9pZCAKbnZtZV9yZW1v
dmVfaW52YWxpZF9uYW1lc3BhY2VzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsCiAgICAgICAgICAg
ICAgICAgaWYgKHRuc2lkID4gbnNpZCB8fCB0ZXN0X2JpdChOVk1FX05TX0RFQUQsICZucy0+Zmxh
Z3MpKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICBfX3hhX2VyYXNlKCZjdHJsLT5uYW1lc3Bh
Y2VzLCB0bnNpZCk7CiAgICAgICAgICAgICAgICAgICAgICAgICB4YV91bmxvY2soJmN0cmwtPm5h
bWVzcGFjZXMpOwotICAgICAgICAgICAgICAgICAgICAgICAvKiBFdmVuIGlmIGluc2VydCBmYWls
cyBrZWVwIGdvaW5nICovCi0gICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHhhX2luc2VydCgm
cm1fYXJyYXksIG5zaWQsIG5zLCBHRlBfS0VSTkVMKTsKLSAgICAgICAgICAgICAgICAgICAgICAg
aWYgKHJldCkKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoInhhX2luc2Vy
dCAlZFxuIiwgcmV0KTsKKyAgICAgICAgICAgICAgICAgICAgICAgbnZtZV9uc19yZW1vdmUobnMp
OwogICAgICAgICAgICAgICAgICAgICAgICAgeGFfbG9jaygmY3RybC0+bmFtZXNwYWNlcyk7CiAg
ICAgICAgICAgICAgICAgfQogICAgICAgICB9CiAgICAgICAgIHhhX3VubG9jaygmY3RybC0+bmFt
ZXNwYWNlcyk7Ci0KLSAgICAgICB4YV9mb3JfZWFjaCgmcm1fYXJyYXksIGlkeCwgbnMpCi0gICAg
ICAgICAgICAgICBudm1lX25zX3JlbW92ZShucyk7CiAgfQoKICBzdGF0aWMgaW50IG52bWVfc2Nh
bl9uc19saXN0KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCkBAIC00MDg4LDEyICs0MDc4LDggQEAg
c3RhdGljIHZvaWQgbnZtZV9zY2FuX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogICAq
LwogIHZvaWQgbnZtZV9yZW1vdmVfbmFtZXNwYWNlcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQog
IHsKLSAgICAgICBzdHJ1Y3QgeGFycmF5IHJtX2FycmF5OwogICAgICAgICBzdHJ1Y3QgbnZtZV9u
cyAqbnM7CiAgICAgICAgIHVuc2lnbmVkIGxvbmcgaWR4OwotICAgICAgIGludCByZXQ7Ci0KLSAg
ICAgICB4YV9pbml0KCZybV9hcnJheSk7CgogICAgICAgICAvKgogICAgICAgICAgKiBtYWtlIHN1
cmUgdG8gcmVxdWV1ZSBJL08gdG8gYWxsIG5hbWVzcGFjZXMgYXMgdGhlc2UKQEAgLTQxMTgsMTUg
KzQxMDQsMTAgQEAgdm9pZCBudm1lX3JlbW92ZV9uYW1lc3BhY2VzKHN0cnVjdCBudm1lX2N0cmwg
KmN0cmwpCiAgICAgICAgIHhhX2Zvcl9lYWNoKCZjdHJsLT5uYW1lc3BhY2VzLCBpZHgsIG5zKSB7
CiAgICAgICAgICAgICAgICAgX194YV9lcmFzZSgmY3RybC0+bmFtZXNwYWNlcywgbnMtPmhlYWQt
Pm5zX2lkKTsKICAgICAgICAgICAgICAgICB4YV91bmxvY2soJmN0cmwtPm5hbWVzcGFjZXMpOwot
ICAgICAgICAgICAgICAgcmV0ID0geGFfaW5zZXJ0KCZybV9hcnJheSwgbnMtPmhlYWQtPm5zX2lk
LCBucywgR0ZQX0tFUk5FTCk7Ci0gICAgICAgICAgICAgICBpZiAocmV0KQotICAgICAgICAgICAg
ICAgICAgICAgICBwcl9lcnIoInhhX2luc2VydCAlZFxuIiwgcmV0KTsKKyAgICAgICAgICAgICAg
IG52bWVfbnNfcmVtb3ZlKG5zKTsKICAgICAgICAgICAgICAgICB4YV9sb2NrKCZjdHJsLT5uYW1l
c3BhY2VzKTsKICAgICAgICAgfQogICAgICAgICB4YV91bmxvY2soJmN0cmwtPm5hbWVzcGFjZXMp
OwotCi0gICAgICAgeGFfZm9yX2VhY2goJnJtX2FycmF5LCBpZHgsIG5zKQotICAgICAgICAgICAg
ICAgbnZtZV9uc19yZW1vdmUobnMpOwogIH0KICBFWFBPUlRfU1lNQk9MX0dQTChudm1lX3JlbW92
ZV9uYW1lc3BhY2VzKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
