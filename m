Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BBBC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 18:15:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D4E23B46
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 18:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D4E23B46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VB2AAtTxDWDtAHng8Jbq3Y/tdBpa9G+t2ZY6EVZsLg8=; b=bzYpCMRxkpPoNCpRUXjXIavxR
	qrbIwnExxJ5ggDp7dXw/SOasiLyI37UoYXLu0gWXoUic8VSHiqU2h0azk/e82uPNfqC5Qy0eWv5yQ
	ezsnsgnpgeK2IdZEbu69lvhMsymTAcmOZUSomrAYAbIuZzINaOAqPf2++v0UTVB+6eKABhELMxb6h
	UuJZMyTW84QMV/+FPssykNvRQHWVU/CPZj7VrhXO3p45fBGPUrRzQZsdOo4LmTRYXqiSMzTAh9ddt
	qgBlkdNZIwTfzsjKI9Qxs+XMzTJXr68+DMx0HO0EEQWc9q7jvzS850XeG9McjUcZwbbHtTAsneXLA
	9kv5vcQ6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmhW9-0000nS-SA; Tue, 08 Dec 2020 18:15:17 +0000
Received: from mail-eopbgr750075.outbound.protection.outlook.com
 ([40.107.75.75] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmhW2-0000lq-VQ
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 18:15:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRtHKNkf03FCZVht0wEARYeAynhSQQ8QkgWpFc6eiruNS1wH6HdclfU205hAwEGINuicmmSS74y/94IQvv0N8giTiZuEnZ/hPTz6F8Co97Rc8HwukXKPne0e4ItRFsHqGNKQj1TuvHUEd8gZhnA5vvqaCUUjhP+tRjalCCvrXcjjKNwblhwf9Oq1HV15meIAzA8CH+y0eBExweF2iEbydjmR6wkwaauXvgwUY6OaXDd0yQj1erRzW97S9p5zkiE5LvSho2fJ4vH0J3LCOryjMISlsyz8WjntCKqqrqwsS2GlJpSzVs4MTPDRnKVbjBBGPcS4SqHy4Jv25k0NgZ/mGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXmnZn4l0r0kYP+rlo6qnS1paaA2uzussz/0PsuPUfM=;
 b=Z11cNfjTYCRLRcIYLvDrq16edyl0l22xXQ+wBFkYk20Ti0WDc6Vp3ZDD+XyF9prPFIB9w1jGRc8e7KhUh/AhGfO9hFnuqKqm5RmeXNpY2bOLDG1sCoeR0bDWNngEwrIt+Jf9jpiX56BOSf2xUbZKmyI+ka16Hiwnbj/NvCK7Y3+Ha+V2CDXiuAMMLSZIN9kbL9nbPvr4i8lKpP6R9OWyWFhFeC6SauyGx9JRHXIWEG8Qv96LWqd+lwwCzq5H/tZmVYSg08fPK5WeYG1S7olRYFeNKCZefSHFgZkFpM8DT+cHTeYc9MZIVDI2ooalFKi0rlknkla1m6wJFngoGvw8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXmnZn4l0r0kYP+rlo6qnS1paaA2uzussz/0PsuPUfM=;
 b=ey2vnzEcCy6Rlak7/oCS14XtovwLo35Hp3HslAmiL44O+7My7rf6LcsoUwyqD3GUSrQsNVOxn9TKcZsMA6rynS5nhyqQPCCTEyXOTDMsSI4Q6gm2BH/R1tyGKO5LTLmlT9flDiRBRKAuntXInAYpsRu1BXD95iH81MfNe5KV+8J6mTAVEwtH4hAMkh2VS76kskheyYcndJUyHCQ192VTFH+168nULKAZtsrQjw7Iryqbz51oVX67vwH8fN2rL7DwicBp+uzllF73LOkLeMHr71mJXI2K5iZwo0A0i38vazxSXnW6oPf2wlZv6eUhcpz+8+7jw+Ql8FrJQGE5j3p/VQ==
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com (2603:10b6:4:7f::28)
 by DM6PR06MB5659.namprd06.prod.outlook.com (2603:10b6:5:3b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 18:15:08 +0000
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610]) by DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610%4]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 18:15:08 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQgBYJ9gCAAAOmgIABtGiAgAACP8A=
Date: Tue, 8 Dec 2020 18:15:08 +0000
Message-ID: <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [2601:186:0:56d0:5cd3:ab9b:a8f1:b122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 948e9e43-99b9-4732-9737-08d89ba53201
x-ms-traffictypediagnostic: DM6PR06MB5659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB56595F9F4ECB9AFD2A460C8CF1CD0@DM6PR06MB5659.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VO7xU3mQULRVvXXU3pl1rnOg9Z3vY4eRXFtvpLNYHsWO24cSh+Xi/JGV99WvMEzINaQTvFdtoIQD5hZuWT6N/hr97fNK6EMKdnHxcr85Haf28FO2qhcO7ZLYYHq5YArcEVMRrF/kSw6Fz3mrJtxyv+r3W6TnwamC8QrrR2HoTNrXDbLwfdOjGegkIPI2xoL9FAN4L7w19vJ2bJtWyFpidCKq8L+A2M2Ff1o5I+vs28RlXPHHyjO55KZnUHYZH4ctpOiNmtOkUF+JzIw8KpohzNARUw+J3yTop/7HPX1iVqPwTgwGSLhHKkSDo/Sx3ngxPV65DfFfMub99DtOjD0ffA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0601MB3624.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(7696005)(186003)(6506007)(33656002)(53546011)(9686003)(83380400001)(508600001)(55016002)(66476007)(52536014)(66946007)(66556008)(66446008)(5660300002)(64756008)(76116006)(6916009)(71200400001)(86362001)(4326008)(54906003)(2906002)(15650500001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TjRiYUl1eXhQOEU2MWJIQ1prdmV5aCt5dytKSG15eTFrdWlYYWk1dTh1NWdI?=
 =?utf-8?B?NTM5TmQyckJzS0hTK0hZeWkwa2Z5YWdVZ3F0NzZuVmNNaHVOWGRKRFdIU2lH?=
 =?utf-8?B?V3U4d3BFNDVKWm9udVBhVmFaUklOdi9lQlladXBZZndKVS9KK1A5SWF5Q1lJ?=
 =?utf-8?B?amVWOFQwblMycGZuM0ZVbExkNjlWKzV0cjZlVmtibHZ4SW1WQXJzcXhjWE1B?=
 =?utf-8?B?VEFVNUtkZHVGMnR0QjZoRWxMNHM5NkdhU3lMZnpTdzl0ZGNiRzRtQzVBQU9D?=
 =?utf-8?B?bFJuVFhITmY0VzdmZXlzd1B0ZkNHVTArV1MvZ0dLYUF0VU8yWXlXbmVTZGph?=
 =?utf-8?B?Z09ISzYwSlMxR2pFRWtlVG1iZFIzUU90MkNPaXNia0JvYU5uYmVJMWR5TFpo?=
 =?utf-8?B?VFhiNHRxeWxTdTRxNWMzclNYVGFWUlY1TEF4ajNvM3RsRDF3VS9CbDJmbzhO?=
 =?utf-8?B?aGJLdXpuTXVuVUN6QlVMY3NvM0JiS0dudHFtRWdqZkxKT1AyRHlwdXB5QWlx?=
 =?utf-8?B?VXhueG9ZdG5BWExJcTBBaVIvVHhKVC9DSUxkcVpzYnBJSklJNlB2MFR0SnY5?=
 =?utf-8?B?MU9maWdRMkUrYTlBWklJS05hNk1QSXNKdmNXTUdjSjRvSE1ScHVKT1AzYURQ?=
 =?utf-8?B?MFptdmFjb2phRVhJN29YS3pVVnQwMmRmMytBT0NyQyt1T3VZTDdweWQrcW5B?=
 =?utf-8?B?cDhLT2JRbkd6REdsRzhLbnJuM2Q4cEN5K0VWR21DZFE4OG9pNDQxdFg2bDRY?=
 =?utf-8?B?L0NSZ2k4eHE3c29oZzFabGUwZ3JRVHgwVytnSzJ1RlNsckwvUk9GWit0bTd5?=
 =?utf-8?B?M3ZjbCtVbkNaaEM5eWdYUmJadUdmOURnUnp1dEcwaDNYY2k2NDNTd1lzRnll?=
 =?utf-8?B?MFEyMW1FRjEwRFpZRGk3RTdtZjMzNVFUZnB6U0lJVDJtS3A0SmdnZ0V2QlAx?=
 =?utf-8?B?SStBNEZxOUYxSTVTSWNKdEo0bFBSYTRrbWN6TzVnQ0xVTTh1WTlCNjJ2cDFr?=
 =?utf-8?B?R3hJSjA4OVZ0c0RGaTJIR2RDS0hRT3ZCenM4QzJvemM3T3dHRjJ5YWdORVFx?=
 =?utf-8?B?bXQrRllzNmd3MUpOQzdjMjZIODhEYmNtdFEzVmdSUkhsTW1vcU03TTRHYjBj?=
 =?utf-8?B?dUxINmg0OWFtRTRHSTlOb20yNGtGRUpENksxQ1JwdjFsWGVvd3Z3SjZZT1pn?=
 =?utf-8?B?MFMzV29Od1YxVWU0dHY4aVJheGxaNjhVT2hGczJBdUlWNHlJemVvbTErY2Ev?=
 =?utf-8?B?WEcybktqTUl0WDZGbmRsWldsZEoydG9XR2FpZmorUGp3MGdQR09PUEozY0ZW?=
 =?utf-8?B?Z1RsSU1pNEg3d3ZzV3JmQVhCWDdRRDRkOUkwV0NtdHBMY0Ryc2NNSmFybmpZ?=
 =?utf-8?Q?q7o+uvO91wuiTHg5C1GaMRLlOm7568Hg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0601MB3624.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948e9e43-99b9-4732-9737-08d89ba53201
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 18:15:08.0941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YC1U7YUABO7ib2amOuAvZtRu3pBiRpZXIJo6LjXpRtXjb7gJp3O14L/PV0Wh5XR4+j3BxjypVO0HrDcOOzehsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_131512_033539_D5457FEF 
X-CRM114-Status: GOOD (  25.56  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2UgY2FuJ3Qgc2VuZCB0aGUgQUVOIGlmIHdlIGNyZWF0ZSB0aGUgQU5BIEdyb3VwIGJlZm9yZSBj
cmVhdGluZyB0aGUgbmFtZXNwYWNlIC0gYmVjYXVzZSB0aGVyZSBpcyBubyBhdHRhY2hlZCBOUyB0
byB3aGljaCB3ZSBjYW4gc2VuZCB0aGUgQUVSLiAgQW5kLCB3ZSBjYW4ndCBjcmVhdGUgYSBuYW1l
c3BhY2UgaW4gYW4gQU5BIGdyb3VwIHVubGVzcyB0aGUgQU5BIGdyb3VwIGFscmVhZHkgZXhpc3Rz
Lg0KDQpPSywgaGVyZSBpcyB0aGUgdGV4dCB5b3UgYXJlIHF1b3Rpbmc6DQo4LjIwLjMuNglBc3lt
bWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgQ2hhbmdlIE5vdGlmaWNhdGlvbnMNCklmIEFzeW1tZXRy
aWMgTmFtZXNwYWNlIEFjY2VzcyBDaGFuZ2UgTm90aWNlcyBhcmUgZW5hYmxlZCAocmVmZXIgdG8g
c2VjdGlvbiA1LjIxLjEuMTEpIG9uIGEgY29udHJvbGxlciwgdGhlbiBhbiBBc3ltbWV0cmljIE5h
bWVzcGFjZSBBY2Nlc3MgQ2hhbmdlIE5vdGljZSBzaGFsbCBiZSBzZW50IGJ5IHRoZSBjb250cm9s
bGVycyB3aGVyZSB0aGUgY2hhbmdlIG9jY3VycmVkOg0KYSkJaWYgYW4gQU5BIEdyb3VwIElkZW50
aWZpZXIgKHJlZmVyIHRvIEZpZ3VyZSAyNTEpIGNoYW5nZXM7DQpiKQlpZiBhbiBhc3ltbWV0cmlj
IG5hbWVzcGFjZSBhY2Nlc3Mgc3RhdGUgdHJhbnNpdGlvbiBmYWlscyAoZS5nLiwgYSB0cmFuc2l0
aW9uIGJlZ2lucywgYnV0IGRvZXMgbm90IGNvbXBsZXRlIGFuZCB0aGUgY29udHJvbGxlciByZXR1
cm5zIHRvIHRoZSBzdGF0ZSB0aGF0IGV4aXN0ZWQgYmVmb3JlIHRoZSB0cmFuc2l0aW9uIGJlZ2Fu
KTsgb3INCmMpCXVwb24gZW50cnkgdG8gdGhlIGZvbGxvd2luZyBBTkEgc3RhdGVzOg0K4oCiCUFO
QSBPcHRpbWl6ZWQgU3RhdGU7DQrigKIJQU5BIE5vbi1PcHRpbWl6ZWQgU3RhdGU7DQrigKIJQU5B
IEluYWNjZXNzaWJsZSBTdGF0ZTsgYW5kDQrigKIJQU5BIFBlcnNpc3RlbnQgTG9zcyBTdGF0ZS4N
Cg0KU28sIHdoYXQgeW91J3JlIHNheWluZyBpcyB0aGF0IHN0b3JhZ2UgZGV0ZXJtaW5pbmcgdGhl
IGluaXRpYWwgc3RhdGUgaXMgYSBUUkFOU0lUSU9OLiAgU28gdGhhdCB3b3VsZCBhbHNvIG1lYW4g
dGhhdCBhZnRlciBldmVyeSBjb25uZWN0aW9uLCB5b3Ugd291bGQgZ2V0IGEgRkxPT0Qgb2YgQU5B
IENoYW5nZWQgQUVOcyBhcyB3ZSBkaXNjb3ZlciB0aGUgaW5pdGlhbCBzdGF0ZSBvZiBlYWNoIEFO
QSBncm91cCwgYW5kIFRSQU5TSVRJT04gdGhhdCBncm91cCBmcm9tIDx1bmtub3duPiB0byBvcHRp
bWl6ZWQgc3RhdGUgKG9yIG9uZSBvZiB0aG9zZSA0IHN0YXRlcykuDQoNClRoYXQgaG9uZXN0bHkg
bWFrZXMgbm8gc2Vuc2UuICBZb3UgcmVhbGx5IHdhbnQgYWxsIHRob3NlIEFFTnMgZXZlcnkgdGlt
ZSB5b3UgY29ubmVjdCB0byBhIG5ldyBjb250cm9sbGVyPw0KDQpEaXNjb3ZlcnkgYnkgdGhlIGhv
c3Qgb2YgYSBuZXcgbmFtZXNwYWNlIHNob3VsZCBiZSB0aGUgc2FtZSBpZiBpdCBoYXBwZW5zIGF0
IGJvb3QsIG9yIGl0IGhhcHBlbnMgbGF0ZXIgd2hlbiBhIG5ldyBuYW1lc3BhY2UgaXMgZGlzY292
ZXJlZC4gIEl0IHNlZW1zIGxpa2UgeW91J3JlIGFza2luZyBmb3IgMiBkaWZmZXJlbnQgZGlzY292
ZXJ5IHByb2Nlc3Nlcy4gIEZvciBzb21lIHBlcmlvZCBhZnRlciBhIG5ldyBjb25uZWN0aW9uLCB5
b3UgZG9uJ3Qgd2FudCB0aGUgQUVOcyB0ZWxsaW5nIHlvdSB0aGUgQU5BIGdyb3VwIGVudGVyZWQg
aXRzIGluaXRpYWwgc3RhdGUsIGJ1dCBhZnRlciB0aGF0IHRpbWUgaXMgdXAsIHRoZW4geW91IERP
IHdhbnQgQUVOcyB0byB0ZWxsIHlvdSB3aGVuIGFuIEFOQSBncm91cCBlbnRlcnMgaXRzIGluaXRp
YWwgc3RhdGUuDQoNClRoZSB0ZXh0IG5ldmVyIG1lbnRpb25zIGFueXRoaW5nIGFib3V0IGNoYW5n
ZXMgdG8gIk51bWJlciBvZiBBTkEgR3JvdXAgRGVzY3JpcHRvcnMiIGZpZWxkIGFuZCBhbnkgcmVs
YXRpb25zaGlwIHdpdGggdGhlIEFFTiwgc28gSSBoYXZlIG5vIGlkZWEgd2hlcmUgeW91J3JlIGdl
dHRpbmcgdGhhdCBmcm9tLiAgVGhlIHRleHQgZG9lcyBleHBsaWNpdGx5IHNheSB0aGF0IGlmIHRo
ZSBBTkEgY2hhbmdlcyB3YXMgZHVlIHRvIHRoZSBjcmVhdGlvbiBvZiBhIG5hbWVzcGFjZSAtIGlm
IHRoZSBBTkEgbG9nIHBhZ2VzIGNoYW5nZXMgYmVjYXVzZSBvZiBhIG5hbWVzcGFjZSBiZWluZyBj
cmVhdGVkLCB0aGVuIHRoZXJlIGlzIE5PIEFFTiBmb3IgdGhhdCBjaGFuZ2UuDQoNCkEgY29udHJv
bGxlciBzaGFsbCBub3Qgc2VuZCB0aGlzIGV2ZW50IGlmOg0KYSkJdGhlIGNoYW5nZSBpcyBkdWUg
dG8gdGhlIGNyZWF0aW9uIG9mIGEgbmFtZXNwYWNlIChyZWZlciB0byBzZWN0aW9uIDUuMjApOyBv
cg0KYikJdGhlIGNoYW5nZSBpcyBkdWUgdG8gdGhlIGRlbGV0aW9uIG9mIGEgbmFtZXNwYWNlIChy
ZWZlciB0byBzZWN0aW9uIDUuMjApLA0KDQoJRnJlZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPiANClNlbnQ6IFR1ZXNk
YXksIERlY2VtYmVyIDgsIDIwMjAgMTI6NDEgUE0NClRvOiBLbmlnaHQsIEZyZWRlcmljayA8RnJl
ZGVyaWNrLktuaWdodEBuZXRhcHAuY29tPg0KQ2M6IGhjaEBsc3QuZGU7IE1lbmVnaGluaSwgSm9o
biA8Sm9obi5NZW5lZ2hpbmlAbmV0YXBwLmNvbT47IEdlb3JnZSwgTWFydGluIDxNYXJ0aW4uR2Vv
cmdlQG5ldGFwcC5jb20+OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IHNhZ2lAZ3Jp
bWJlcmcubWU7IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIG52bWUtY29yZTogdXBkYXRlIE5TIEF0dHIgQ2hhbmdlZCBBRU4gaGFuZGxpbmcgZm9y
IEFOQSBncm91cA0KDQpOZXRBcHAgU2VjdXJpdHkgV0FSTklORzogVGhpcyBpcyBhbiBleHRlcm5h
bCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoN
Cg0KDQpPbiBUdWUsIERlYyAwOCwgMjAyMCBhdCAwMzoyMToxNlBNICswMDAwLCBLbmlnaHQsIEZy
ZWRlcmljayB3cm90ZToNCj4gSXQgaXMgY2xlYXIgdGhhdCB0aGUgTlMgYXR0cmlidXRlIGNoYW5n
ZSBpcyByZXF1aXJlZDoNCj4gTmFtZXNwYWNlIEF0dHJpYnV0ZSBDaGFuZ2VkOiBJbmRpY2F0ZXMg
YSBjaGFuZ2UgdG8gb25lIG9yIGJvdGggb2YgdGhlIGZvbGxvd2luZzoNCj4g4oCiICAgICAuLi4g
OyBvcg0KPiDigKIgICAgIHRoZSBOYW1lc3BhY2UgTGlzdCByZXR1cm5lZCB3aGVuIHRoZSBJZGVu
dGlmeSBjb21tYW5kIGlzIGlzc3VlZCB3aXRoIHRoZSBDTlMgZmllbGQgc2V0IHRvIDAyaC4NCj4N
Cj4gSXQgc2VlbXMgY2xlYXIgdG8gbWUgdGhhdCB0aGUgQU5BIGNoYW5nZSBJUyBwcm9oaWJpdGVk
Og0KPg0KPiBBc3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgQ2hhbmdlOiBUaGUgQXN5bW1ldHJp
YyBOYW1lc3BhY2UgQWNjZXNzIA0KPiBpbmZvcm1hdGlvbiAocmVmZXIgdG8gc2VjdGlvbiA1LjE0
LjEuMTIpIHJlbGF0ZWQgdG8gYW4gQU5BIEdyb3VwIHRoYXQgDQo+IGNvbnRhaW5zIG5hbWVzcGFj
ZXMgYXR0YWNoZWQgdG8gdGhpcyBjb250cm9sbGVyIGhhcyBjaGFuZ2VkIChlLmcuLCBhbiANCj4g
QU5BIHN0YXRlIGhhcyBjaGFuZ2VkLCBhbiBBTkFHUlBJRCBoYXMgY2hhbmdlZCkuIFRoZSBjdXJy
ZW50IA0KPiBBc3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgaW5mb3JtYXRpb24gZm9yIGF0dGFj
aGVkIG5hbWVzcGFjZXMgaXMgDQo+IGluZGljYXRlZCBpbiB0aGUgQXN5bW1ldHJpYyBOYW1lc3Bh
Y2UgQWNjZXNzIGxvZyBwYWdlIChyZWZlciB0byANCj4gc2VjdGlvbiA1LjE0LjEuMTIpLg0KPg0K
PiBXZSBDQU5OT1QgZGVsaXZlciB0aGlzIEFFTiB1bmxlc3MgaXQgaXMgcmVsYXRlZCB0byBhbiBB
TkEgZ3JvdXAgdGhhdCANCj4gY29udGFpbnMgbmFtZXNwYWNlcyBhdHRhY2hlZCB0byB0aGlzIGNv
bnRyb2xsZXIuICBUaGUgY3JlYXRpbmcgb2YgYSANCj4gbmV3IEFOQSBncm91cCAod2hpY2ggdGhl
cmVmb3JlIGhhcyBubyBuYW1lc3BhY2VzKSBkb2VzIG5vdCBtZWV0IHRoZSANCj4gY3JpdGVyaWEg
b2YgImNvbnRhaW5pbmcgbmFtZXNwYWNlcyBhdHRhY2hlZCB0byB0aGlzIGNvbnRyb2xsZXIiLiAg
U28gDQo+IHRoZXJlIGFyZSAyIHBvc3NpYmxlIG9yZGVycyAtIDEpIHRoZSBBTkEgZ3JvdXAgaXMg
Y3JlYXRlZCBiZWZvcmUgdGhlIA0KPiBuYW1lc3BhY2UsIG9yIDIpIHRoZSBuYW1lc3BhY2UgaXMg
Y3JlYXRlZCBiZWZvcmUgdGhlIG5hbWVzcGFjZS4gIElmIA0KPiB0aGUgR3JvdXAgaXMgY3JlYXRl
ZCBiZWZvcmUgdGhlIG5hbWVzcGFjZSwgdGhlbiB0aGVyZSBhcmUgTk8gYXR0YWNoZWQgDQo+IG5h
bWVzcGFjZXMgaW4gdGhhdCAoYnJhbmQgbmV3KSBBTkEgZ3JvdXAsIHRoZXJlZm9yZSwgd2UgYXJl
IHByb2hpYml0ZWQgDQo+IGZyb20gc2VuZGluZyB0aGUgQUVOLiAgSWYgdGhlIG5hbWVzcGFjZSBp
cyBjcmVhdGVkIGJlZm9yZSB0aGUgQU5BIA0KPiBncm91cCwgdGhlbiB3ZSBoaXQgdGhlIG5leHQg
bGFuZ3VhZ2UsIHRoYXQgcHJvaGliaXRzIHNlbmRpbmcgdGhlIEFOQSANCj4gY2hhbmdlZCBBRU4g
YmVjYXVzZSBpcyBpdCAiZHVlIHRvIHRoZSBjcmVhdGlvbiBvZiBhIG5hbWVzcGFjZSIuDQoNCkl0
IGNhbid0IGJlICIxIi4gSWYgeW91IG1ha2UgYSBncm91cCB3aXRob3V0IGEgbmFtZXNwYWNlLCB0
aGUgaG9zdCBjb3VsZG4ndCByZWFkIGl0IGFueXdheSBiZWNhdXNlIHRoZSBsb2cgb25seSBjb250
YWlucyBlbnRyaWVzIGZvciBncm91cHMgd2l0aCBuYW1lc3BhY2VzIGF0dGFjaGVkIHRvIHRoYXQg
Y29udHJvbGxlci4NCg0KQXMgZm9yICIyIiwgbXkgdW5kZXJzdGFuZGluZyBmcm9tIHJlYWRpbmcg
dGhpcyBpcyB0aGF0IGl0IHJlZmVycyB0byBzdXBwcmVzc2luZyB0aGUgQU5BIGV2ZW50IHdoZW4g
YSBjaGFuZ2UgaW4gdGhlICJOdW1iZXIgb2YgTlNJRCBWYWx1ZXMiDQp3aXRoaW4gYSBncm91cCBv
Y2N1cnMgcmF0aGVyIHRoYW4gYSBjaGFuZ2UgaW4gIk51bWJlciBvZiBBTkEgR3JvdXAgRGVzY3Jp
cHRvcnMiIGZpZWxkLg0KDQpBcyBmb3IgdGV4dCBzdXBwb3J0aW5nIGl0LCB3ZSBoYXZlIDguMjAu
My42Og0KDQogIGFuIEFzeW1tZXRyaWMgTmFtZXNwYWNlIEFjY2VzcyBDaGFuZ2UgTm90aWNlIHNo
YWxsIGJlIHNlbnQgYnkgdGhlDQogIGNvbnRyb2xsZXJzIHdoZXJlIHRoZSBjaGFuZ2Ugb2NjdXJy
ZWQ6DQogICAuLi4NCiAgYykgdXBvbiBlbnRyeSB0byB0aGUgZm9sbG93aW5nIEFOQSBzdGF0ZXM6
DQoNCllvdXIgc2NlbmFyaW8gaGFzIGFuIEFOQSBncm91cCB0aGF0IHByZXZpb3VzbHkgZGlkbid0
IGV4aXN0IGVudGVyaW5nIGEgc3RhdGUsIHNvIHlvdSBzaGFsbCBzZW5kIHRoZSBldmVudC4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
