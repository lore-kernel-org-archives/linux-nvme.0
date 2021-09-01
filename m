Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D99C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 15:08:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFA961053
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 15:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAFA961053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0HlsWOZCpBtLWx+NT0gcgNnRt9Y+d5AwYTyCXPOxeLc=; b=1H57JBj18puAwO
	ix77Q9tSXVLxB8oHmJssqofvpSK8QLr3rie1+WXqzU6oKQs7I3ykgVgjQLJwXaBtokCs//canLtXc
	0i/sczvaGbF7fIh5nBy9XK98kD01bhg1gLKRqPHnfCappnW26FGwVCUFXIrxGX/1tFq0ciODFpELB
	AHQnvrnRGnnsF+VPO7amiKqo+hH6/PSAEXPezpLjIBwNgkV0cPJvHfNqoFkPHp8jj4oEgw0kQ8ZIH
	8o9QmVfjhdgOydUblydmeJLRfw//T5jtR9+vcLSysubX/0z9BxnwmZmILgJY3vHoO0Pty8Wq6iqBF
	Gue8A6Fid1olmfzW61dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLRql-006Lsi-SO; Wed, 01 Sep 2021 15:08:27 +0000
Received: from mail-eopbgr10117.outbound.protection.outlook.com
 ([40.107.1.117] helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLRqf-006LrN-Fl
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 15:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2eo541L0VP6e4bkfUtXvtw+WLdggnYl9/sQ8vgJt8n21+aUIiDBFhufBpe1+fPjPWPDA5lMiNLksXXGW9meO3I8NhS9jFK2CRsup1OFa7nzONQRPAVlWznxaLN7OSwRqAGtCeL1vHjCbQzF1JJpjFU3G6Oljk/FHX8VPBf11fOb01Gry3dlD1Pj80BDY6u6OdwHNSurGxWp/FFQCzl1Csj4FW4wwxPZCLW3Y2gi97uWNKNpqJibMKjZ8quTHtxLobRjzxCIw7iOiYEOw8OveJD7O1cz8UiQ94iTit53N8Bz28L/DpcDqHyN+9zSgT2dRsLyaIZg44/SAxrJVYmRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=7aEIiI4XlXxO4fz06iu2ZDiSX9/7VU2aY6rrE7P85JI=;
 b=fzoPzKac/TAgFLL7lQjsTJjcRafcmgGPW40IV9jRKbX+1Q46ANkuYnTdwm28es/thGZwxbHwhcKwZ/Gz/Z12n0HZLsrX9ZucvFE9g/uCh2rQXpXEnCEdKueDXw0/DPcL9nzSIjsU2A3EDm2T7+MVmdcKtNrv9nfpy4PvIQhgLLyvBvL+eo9UW4dBNWWZewgCKtD2VjBGIDzFMDGSRaCzF9d0EfEWx/SN/m3GUqcYJ3JU0eJfk/s/BVU8VyTih9QY7WiwKmz8SxdcTca0EBr+tMgxyYkiFhpHnvLd8/6OCDz14wInI2LV/z2Ma/+hpJHDB62sTkX+tEOsi0iL+11/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aEIiI4XlXxO4fz06iu2ZDiSX9/7VU2aY6rrE7P85JI=;
 b=dS7ZIwj9SmZIT7PvqH7wz0lVKFirVmttlynvUfmzp/VMzUwvFKvoXJWiz7raHWkTGL3fvw+mQksvSP9yx+qk7dRfvXLo2KL2v+U4+lF5PmJrcKyQrRkFm+JtSLum9hsAXgOozX+dXPgjhBEXkMjrmzbOKJchjOkykjM6qQyv5RI=
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com (2603:10a6:208:c1::28)
 by AM0PR03MB4673.eurprd03.prod.outlook.com (2603:10a6:208:c1::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 15:08:17 +0000
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::149b:9250:f59:b791]) by AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::149b:9250:f59:b791%5]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 15:08:17 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
Thread-Topic: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
Thread-Index: AQHXnm4SW+F2pBQEIUGXFPYlGAQ1jquPI6QAgABCp4D//+CCAIAAJECA
Date: Wed, 1 Sep 2021 15:08:17 +0000
Message-ID: <5FE0FB9E-815F-424A-9C01-2A1062145D41@primelogic.nl>
References: <CA3F5384-4B57-47ED-9DFE-27E80F3D312C@primelogic.nl>
 <07e2bbb2-2b62-f0a3-b845-27398268c468@grimberg.me>
 <0FA43353-7C04-4CAE-9E84-CA0DE6907492@primelogic.nl>
 <733fb177-a0ec-152c-f211-73f1e96dfe10@grimberg.me>
In-Reply-To: <733fb177-a0ec-152c-f211-73f1e96dfe10@grimberg.me>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e35fdac-5920-41a8-e19c-08d96d5a5416
x-ms-traffictypediagnostic: AM0PR03MB4673:
x-microsoft-antispam-prvs: <AM0PR03MB46732BC238C0D964ABC87412D1CD9@AM0PR03MB4673.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eCPeYjcyXWn+nT7k5dmsgtSHBGZRd1Cdt2D9j9jk7yfeNgmG5zbf4WXdtfVBRYAxpf8FCX8D485pL4Yucm4dhiC7RaSoMegmDwZ6M3v8/O6RkIYHXDS2q6NJ5OVbgdmVbq/emN8a0xtdeq5ol//DkAJtta6gJwdtfA+gWsUsUdRsXosQkJla1GQqIG1LV2G+T3RbCEpESnIhiFZ+ourdDKgVQiKD0c8RMXxpaEpjosnf1EnwntKZ2rSOrgLf5kqpgyGBrUm4qISsvlatF1bhzs5lvsbZQg1OV4HkKua3qwvDKKy2kPvOw37wxnmVMxZ0WBUxH3HH5WE4jmS5VLzNAtqnF+y5frgudtxEtzjyNeiS2iPOSjPE7gIM6JXoqTIIP7wzCDfIFhzbvy5pw2qiC3eA0NpxlHV4joHscMlGbvZBTZaxuST33bI77LoFaQw07PmzoEJ5x4z87MPYOyzeHBtyC82pEDlasavKisT11Zg2h800jExNhGMw8qrIu5JEx87mFwTb5pK0AYrdz8eF/maZambNpzVzifrZfQxaPPsXO+9mnlb7cPilqWArKtmRfBqipIx1ta7O7QnLx4V+J/aBye851wQbkRocPa+bdWfhpFsu0slrTIul6Q4Ydl9T8OfCXeiIzoSRRbhdPMxfcXzQ34+wV8+8aZoZEMYp9Rz22mf0rPPOzpRieLtVHH2aimuxATkpBNlM3hZaygSyej0RCNdDkPUpVDD53VLj60=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB4211.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(39830400003)(376002)(346002)(366004)(38100700002)(38070700005)(8936002)(110136005)(2616005)(76116006)(5660300002)(36756003)(66946007)(33656002)(6486002)(316002)(64756008)(66556008)(66476007)(8676002)(66446008)(71200400001)(122000001)(86362001)(6506007)(2906002)(508600001)(186003)(26005)(6512007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFBUYStRcnNBN205L2FuUXpjZjJ2RnI3ay95Mjl2SStLc2huaG1OTHJ4M0ty?=
 =?utf-8?B?cXFrZjk1cGdGV0JSdlhyV08wcjR4R2dlVjFETUQ3WTlleElBSEJHOEpmbWNJ?=
 =?utf-8?B?V3JEdzAwZ1BiUGczdGRJc0RKY0ZVY0FyeFlJRDN3c0NxM1FkS2d3TlZVWVZB?=
 =?utf-8?B?UEc0UG9wb0QvejNqdmxlcWp5Qmhvc2Y4TTI2a0RodjJhNHVHdzJCenN3bHNX?=
 =?utf-8?B?aUxmc2xQMDNqQldrSkk4bVVsZmZ3UmpzeTk2VklNSHdNeE9kODdNQWNsOWRE?=
 =?utf-8?B?dVo3Q2FjSjZIRHh2d1B4d0NkQjF5dTdQZHJ1Y3B3dDhXNHI0MnJDU2FPZWdW?=
 =?utf-8?B?cVNSZnYzNDNCdXRVL2t5VzVSVnNGS0tncnBoQnVhRFcwWENuV2lTMFFlSStk?=
 =?utf-8?B?TEo1aGwxWkhRdVFrd2NJb0RHWWVJdHFiUXNQYnpFZGhMVW5yTUdIRkVIRWMz?=
 =?utf-8?B?cVlqbS81RWNEbVBqSmxPMGR2UXJGcGhKSGx5Q002ODdNNlRDMWU1NUcxMjVt?=
 =?utf-8?B?R3F4SVRuZ05GZkgxRm9HMDJkNy9LaW56RmhHeWhEVkVrWENiSzM5b0V0YWE1?=
 =?utf-8?B?MzlTZW9HTXVSK1NuTVZNYWVMQWtCSVkrME1DNVRnWjBwK0RYckZVSVU3cUNm?=
 =?utf-8?B?dWFld3FvM3pvTGt4aEsreWp5UjZ1RmEwQ3dkejBrbXpMRVNEc3BMc2NONmpZ?=
 =?utf-8?B?c0s3MkdQTHRQQjlQalN2eTRZc1Q4ZjFOUnVBOGhUWU40Z3pINkdReGZJZXhC?=
 =?utf-8?B?bkx3WE42WVFCSDV1bG1DZUtoU0UwM2Fma0xjN0hBRjBvTnI5Q2VUSytnY1py?=
 =?utf-8?B?V0lhZlU1cEMrUnFuVGozdjJNYVpHWkRocExnZU9Pajc4ajR6cnREK0dSdUJt?=
 =?utf-8?B?T0VzSWI5MzdOL0JDU3pBUHVmNmxrUEZheXZXUHlzM2lnQW5xZ2NTMHRtZE0v?=
 =?utf-8?B?NFpTblhiVm9RMjR2RTBHbDFnaVF3U1BQWFBYSG11YXJGUGNyeWpJUnZkK2xt?=
 =?utf-8?B?Q1hvQkpudFhZMkhTbERNTkJSZVNPd05naDMzZmJGeEtKMVo2MkR6UWRySERN?=
 =?utf-8?B?MFh5d0c2OERKUGtlZ2ZFaHI4WS9NS0htdU9RTGRsRXV0YzBNRi8ydEhZK2tR?=
 =?utf-8?B?czlOVndGWll4WloxV0dPZHNhR1A5NjRYUU1HVFRGUmNQYnBDR2E3UUJDMDZX?=
 =?utf-8?B?R3NjRkE5REJ2SHdoamV3ZUdSK1N6Vk9LSTAzT0xMMUc4eTZlbXNWRlpOZ2F2?=
 =?utf-8?B?SHRWS2ZvMUpCMUxWMXJQTWJUUDdsTTZNWWlrOCtQVUpzeGN3RU5SanN4VEor?=
 =?utf-8?B?eWlhcEo2UDB0TlhRa3pmWWY3ZjlkQmJSRDAzd29lc09sV3EwZW9Ib2wvSkN3?=
 =?utf-8?B?QzNkY09ZVm9EL21USUxpOTZ5aGZJZ2dvS2c4Y1FkUkZWcHRyZnczMHVJeWpv?=
 =?utf-8?B?ZU1lQXc1ZFN4QkVDRnB5MlJzTkVuNGJoSkNpVjcvTEtuR2VmUS95aHl4OGJs?=
 =?utf-8?B?Umt0ZzNJb3o5Y2ZyTHZkVG0vRSs4OEQ5RXo0WWhlb0VvUHVyUkszWWhsR2Jm?=
 =?utf-8?B?NU1jcHYreWR1eElPZWFsWmZMMVdYaXNpVUd6L0s3ZU9URldCMkZ6ZGwzd3JY?=
 =?utf-8?B?UHB4cVpHN3hySDlJZmhXUEpPZjZmbzd1RU9GQ0MwdjBTd1RxblM4SmlDNWU5?=
 =?utf-8?B?NWZxV0pTNkFLUjBRMjIyLzdBS1cwU3pzeWhza2Z1M3lZQWpyNktRNXYzdTlp?=
 =?utf-8?Q?+z+1reDWlZCh4lEVlCtTLL/nupK9UAI6JkUnnEW?=
x-ms-exchange-transport-forked: True
Content-ID: <30C34818D6B7FB4FA5FD75740D59DDFE@eurprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4211.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e35fdac-5920-41a8-e19c-08d96d5a5416
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 15:08:17.3226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8VsbAzf8GdCbL+9Au+OS7QZ7inIU5VDSbrXNgxP4XKixyN7ScarhVZd8u2Up8dKIJtWKCst6hluXpcKQ83Ong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4673
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_080821_572568_BC47728A 
X-CRM114-Status: GOOD (  14.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQpUaGUgZGV2aWNlIGlzIGEgTWVsbGFub3ggQ29ubmVjdFgtNiBjb250cm9sbGVyLg0KVm13YXJl
IGNhbiBjb25uZWN0IHRvIGFuIFNQREsgdGFyZ2V0IHN0YXJ0ZWQgb24gdGhlIGV4YWN0IHNhbWUg
VWJ1bnR1IHRhcmdldCBzeXN0ZW0uDQoNCjQ6IGVucDEyOXMwZjBucDA6IDxCUk9BRENBU1QsTVVM
VElDQVNULFVQLExPV0VSX1VQPiBtdHUgNDA5NiBxZGlzYyBtcSBzdGF0ZSBVUCBncm91cCBkZWZh
dWx0IHFsZW4gMjUwMDANCiAgICBsaW5rL2V0aGVyIGI4OmNlOmY2OjkyOmI3OmI2IGJyZCBmZjpm
ZjpmZjpmZjpmZjpmZg0KICAgIGluZXQgMTkyLjE2OC4xMDAuMzQvMjQgYnJkIDE5Mi4xNjguMTAw
LjI1NSBzY29wZSBnbG9iYWwgZW5wMTI5czBmMG5wMA0KICAgICAgIHZhbGlkX2xmdCBmb3JldmVy
IHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KDQo4MTowMC4wIEV0aGVybmV0IGNvbnRyb2xsZXI6IE1l
bGxhbm94IFRlY2hub2xvZ2llcyBNVDI4OTA4IEZhbWlseSBbQ29ubmVjdFgtNl0NCjgxOjAwLjEg
RXRoZXJuZXQgY29udHJvbGxlcjogTWVsbGFub3ggVGVjaG5vbG9naWVzIE1UMjg5MDggRmFtaWx5
IFtDb25uZWN0WC02XQ0KDQotLQ0KIyBjZCAvc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvcG9ydHMv
DQojIGxzDQoxMTI5MCAgMTEyOTEgIDIxMjkwICAyMTI5MQ0KIyBjZCAxMTI5MA0KIyBjYXQgKg0K
aXB2NA0KMTkyLjE2OC4xMDAuMzQNCm5vdCBzcGVjaWZpZWQNCjQ0MjANCnJkbWENCi0tDQoNCu+7
v09uIDAxLzA5LzIwMjEsIDE2OjU4LCAiU2FnaSBHcmltYmVyZyIgPHNhZ2lAZ3JpbWJlcmcubWU+
IHdyb3RlOg0KDQoNCiAgICA+IEhpIFNhZ2ksDQogICAgPiANCiAgICA+IEkgYW0gdXNpbmcgVk13
YXJlIDcueCBhcyBpbml0aWF0b3Igd2l0aCBSRE1BLg0KICAgID4gVGhlIHRhcmdldCBzeXN0ZW0g
aXMgcnVubmluZyBVYnVudHUgMjAuMDQuMyBMVFMgd2l0aCBrZXJuZWwgNS4xMS4yMisuDQogICAg
PiANCiAgICA+IFRoZSBkZXZpY2UgdGhhdCBpcyBleHBvcnRlZCBpcyBhbiBMVk0gdm9sdW1lLCBo
b3dldmVyIEkgYWxzbyB0ZXN0ZWQgd2l0aCBhIGZpbGUgYmFja2VkIGxvb3AgZGV2aWNlLg0KICAg
ID4gQ29ubmVjdGluZyB3aXRoIFNQREsgc2VlbXMgdG8gYmUgdGhlIHByb2JsZW0gYW5kIGFzIHJl
cG9ydGVkIG9uIHRoZSBTUERLIG1haWxpbmctbGlzdCBpdCBjYW4gYmUgdXNlZCB0byByZXByb2R1
Y2UgdGhlIGlzc3VlIHdoZW4gVk1XYXJlIGlzIG5vdCBhdmFpbGFibGUuDQogICAgPiAuL3BlcmYg
LXEgNjQgLVAgMSAtcyA0MDk2IC13IHJlYWQgLXQgMzAwIC1jIDB4MSAtbyA0MDk2IC1yICd0cnR5
cGU6UkRNQSBhZHJmYW06SVB2NCB0cmFkZHI6MTY5LjI1NC44NS44IHRyc3ZjaWQ6NDQyMCcNCiAg
ICA+IA0KICAgID4gVGhpcyBzZWVtcyB0byBwcm9kdWNlIGEgc2ltaWxhciByZXN1bHQ6DQogICAg
PiBudm1lIGNvbm5lY3QgLS10cmFuc3BvcnQ9cmRtYSAtLXF1ZXVlLXNpemU9MTAyNCAtLW5xbj10
ZXN0bnFuXzEgLS10cmFkZHI9MTY5LjI1NC44NS44IC0tdHJzdmNpZD00NDIwDQogICAgPiANCiAg
ICA+IEkgaG9wZSB0aGlzIGhlbHBzLA0KDQogICAgSSBtZWFudCB3aGljaCByZG1hIGRldmljZSBh
cmUgeW91IHVzaW5nPyB0aGF0IGRldmljZSBpcyBmYWlsaW5nIHRoZQ0KICAgIHFwIGNyZWF0aW9u
Lg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
