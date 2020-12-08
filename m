Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8AC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 19:13:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB3323B6C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 19:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB3323B6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pc47qnps0SqEH29pznn8o783X+d/FpDw8G6GJyJtDXA=; b=W0zhh21vHyxOZLoW9c2rqVjnr
	PjU8xiysDjvDqa47BtXYYYNeMhx+s2UuDfmIb0UkAsU2ynlHfaAlAhGhIh0YiXzTv7XrUrCB6pJeY
	7wOME6J0tSi0WhrjFbdjFb4CZzoaclXb8bHasIJ3JlATf1Qi5RranHL0mD95GUcw2XvUUkxJYXUKZ
	bLDRQyBzvk4yflCJdOaZswHuxcFGYtS2oPB+9iX2VWYovcD6fNlThLyMA7xVsPRQMKcH0j3P/FO3t
	Z3EWlh2p8HNk8N6zabS/qTnTHMXCUpuXxXapTd8ikq7hRgO+GsWgaD95yAyiGgWZxTtUoFKOpW40I
	IZGaom7rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmiQ5-0005N4-Rr; Tue, 08 Dec 2020 19:13:05 +0000
Received: from mail-co1nam11on2080.outbound.protection.outlook.com
 ([40.107.220.80] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmiQ3-0005Mb-6D
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 19:13:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH7OsvAqL/s3CUpfHna9FiZmM1xQIimgUQSQpQ5HY2MYySyKTKFNtzGtATlAaCk8BeQ/Z38QYcYXfSfzN/BWG2wU1RujoknAPmMYY/Hx7OPVk8rEgmGz8GW53atugaogetzrL8IdrAQ3mpJl+QMioevDEny5beh2udZZ2f3i3HG2g9fadCirv/D1IVoSFR2gE38fqYQB/XxaMUasnTpqWbmhHRN33Tk0Y2OfpqaLFUQbVDa1cZRHB4LeMVTXseE7N0Cvn0BY4w/b0WxT/xBn3Wni0Hx5kTiwYk8FhZ3LkQG47e/dSd5c7Z2y25O99ycagjknJQOX50ioV8WLfdDNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BNaGRyvKa/+G9M73QspiW6EOgzm/Jg0U7KcGtUWukY=;
 b=j/Brb+H9tHyLq9VmUPyWtbUZQPaNB3eILJynJmJofB389nzJxxJpDyfRzlLgo9jDtJbiNkbl6wAFVOt5GtZWu6Qt2v6YiILEfEcUp41oujKLR7qBhu1Yrv5wwqhrRIAvGDGFYKOdMWdL1rVBSJOG2oeNJp/pa86xQFSkPMmCtp43YN87bVf9pNNONAIlcT1YeA1JFGsgmy1Svd4lI2Qt0p5fSiRY0oOZoNAElryOF/6O/vsGF/mVsLqFgQGG87TRPZpimOoJmnUjUvR7FHUhO4uzd8P/cxS2qdb4beV3zwqqvZD4u4FMjtFebcanRBevOOrVuLnBUZCq4uvVJWVFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BNaGRyvKa/+G9M73QspiW6EOgzm/Jg0U7KcGtUWukY=;
 b=Z+fuAKMtL7iwlRp1mKqnhX51gxi2SIh7uEkkGPYkUTGspcq87QIeZaFQha/IkeC1y23gTry8G2pjrEJTtqiR/b09GZnz6vA704SPl82fQ7HHNGfwQXlzWrga+wVuPYTkzOvbUJeo/R/+uLIRcLqz9v8gK3jrDtsAo67oFKfrjRJ1IGdQBQY7weJDslT8BDmQq3Z7CFaw0pSeiISBxYR2EuqwxpCzbKy5TDxU4kZmJEyeAJsks9dHFRtS8dxevdEAnutg2Vhmn4bwtw2NZjF9wwQMT6YcE3tQoOPTJTlphlnK5QwQe6ZYZuCLr5OIM2Q6EWvITVYsOH0pZ7maD5vMlQ==
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com (2603:10b6:4:7f::28)
 by DM6PR06MB5020.namprd06.prod.outlook.com (2603:10b6:5:9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Tue, 8 Dec 2020 19:13:00 +0000
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610]) by DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610%4]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:13:00 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQgBYJ9gCAAAOmgIABtGiAgAACP8CAAAzlAIAABdaQ
Date: Tue, 8 Dec 2020 19:13:00 +0000
Message-ID: <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [2601:186:0:56d0:5cd3:ab9b:a8f1:b122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69f5aa02-d6c7-4059-4865-08d89bad47b9
x-ms-traffictypediagnostic: DM6PR06MB5020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB5020A675E022174BFD0A473EF1CD0@DM6PR06MB5020.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVN0MlWJEQTWf14dlXcoYnQorPooXhc1LIGxq8xhrJ/hPb1iKjwtt/oSzt6j/5egM7ydrzHC1d8Y+pHjJ5+gLUq8sEdFKxV1vGYnTLIoPAFy0yNjJqLiknJtXahf+MDA3Xjbe3Pi3m73i1dHHChMpFBQLiZ5zp1vfzVCvti4Y8QaO0LdgMQB0AdZuIrqjqedwzCMpIaegjlthSHSKxSlyWxihfMFA34nlfO9aTYkIbSfE5gLxaOrmxZvDLzbSw/khipjscXJQV4IqPam2kGkppXlXft2Iwpb2u2m2AnVpGN2pFypKD21clzGzKiil+oX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0601MB3624.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(66476007)(71200400001)(8936002)(83380400001)(76116006)(64756008)(4326008)(2906002)(8676002)(66556008)(7696005)(54906003)(6506007)(52536014)(55016002)(9686003)(15650500001)(6916009)(186003)(5660300002)(86362001)(66946007)(53546011)(33656002)(508600001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TzBpS1dtbUUyRUlDZFJ1Vi9QYm9WOXl6NUZ5dElabyswQ3N2aW5ISGcvOENa?=
 =?utf-8?B?TUcxbnZFV1NGVHlicDdZMG1LUldWUWdNUDVZQmRPRVErYlpOajZLK0ExSHln?=
 =?utf-8?B?dmszLzJ6V0l1Q08yR1pxa09LL2JvUWExUk9MV1lVWmg4S01WZ0sxeDM5RlJ4?=
 =?utf-8?B?QmJ5WjB6Wkt3Zk4zSnF0TWJ6NkxiaU9ENDhlbElHN1pUeU9HbHJ5QW9BMHRX?=
 =?utf-8?B?Z09KdWN2WkYzbGJ4aU8zczFNa2JReVJkVFJndmZvSjF4bDhoSXFNWUQwcExB?=
 =?utf-8?B?N1FUTzlxRFkzS3FoZlMxTy85ZFVEQ1Rzb3BoVjZCYnhRS0JRTi9iczdmRXlR?=
 =?utf-8?B?bzFNOE9NREFsUURuYjhTc1lOcDBlR2ZGZnJ0WERUSStLY2o1NHlCOHZOcDJH?=
 =?utf-8?B?UXREMEFvNC9HVkErR2dPZmJpSVZNWnJKRWpqOWovVVdBY0hXZHVOTGJSN3lm?=
 =?utf-8?B?a1BsL2s3NlZLMnhmR20rRHpmNm9QcG45RXcxY2lxQVZrczdtRVVnUXluTFVS?=
 =?utf-8?B?VnpvUGdvRDJiSUJGOWFzKythL0drT1BqTTlYY2NQVUsrNG5EWkhTbEhsN0N6?=
 =?utf-8?B?b1RwQnZjUHdXcnV6TnJBejR6QVUrT2k0Rmt2NWZRS0JOMGhCRHRpV044MWZy?=
 =?utf-8?B?VEdEQ1FmNXJZU0RPSVl2dmdDaDdEdzVadXlQYi9NZGlITU52bGNuQWhoSUdC?=
 =?utf-8?B?WWhpckhXRnlud1JQNlVmckpxWVFqMUdWMnNiKzVJNEZMSklVbHVmMDkvcWht?=
 =?utf-8?B?cVJxTXczYkpNVnpOU1RCckFQcVdFY1BTbXRHWHVsUFhwb2lNSHpxbWVCblA5?=
 =?utf-8?B?alM3cE8zaFZPM0R6blhyVGhMa2RyaHY4M1NJenJ2dlp3L1B0TzE1RitMU3pi?=
 =?utf-8?B?cXNLcmlVRGV0RFh0OEJXc3BjYkU0TUc0d2IwUHF2MEtmSzFLd2Jsam1abktn?=
 =?utf-8?B?V0toa3FYR3hmR001SDhwOUUyUTlDcEdrK0NtUzBvd2FEVVNPRSt4ZlNNb3g0?=
 =?utf-8?B?NXNROWRDYUQ1bG1RL2xRS21qQWQ2SjVOc0Jqc2VhbUVveWgwbGQ3WVh3aERF?=
 =?utf-8?B?V3dxa0t6OS9VQkQ4RzAzdDRYSFlGUTBTTjVOVVZDOGxMdlNmc3BXalkxU1ND?=
 =?utf-8?B?TXFPUndBbFg0ZUVjNGtJNFd1Z2YxdWFDelYrQU5qUFV0dUU5NG9ndzZzYnhD?=
 =?utf-8?B?bGhuQW9vU3R6VXlVY1NMVERSS24vSkMrbEEyLzZGUUNxMzZSaDBLNW5BcGdH?=
 =?utf-8?B?Slc2NmRBc1RsQStiV3pOcmpGYTBpTDZiQ1dYY2dBMWVGVzFjQ29sektDN1hI?=
 =?utf-8?B?bXRrOTRSSWt6dGtNdjMrckVFNjZ1NWFtR01LV2tiNnNncnhSUEVWVm9LenVG?=
 =?utf-8?Q?nrj+SIz7D3Nd1QprJG011tvjGYLcIGeA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0601MB3624.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f5aa02-d6c7-4059-4865-08d89bad47b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 19:13:00.6538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PjTdAXB59HcmipajXDgc+kXZl8UyMhgvEy1r5ltAE2zvhgT8H26c1do7YsWxGZxkmdELXfzmWqtsgH5a65KOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5020
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_141303_275975_CF034FEE 
X-CRM114-Status: GOOD (  23.61  )
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

U2V0dGluZyB1cCBhIG5ldyBBTkEgR3JvdXAgZG9lcyBOT1QgY2F1c2UgYSB0cmFuc2l0aW9uIGZy
b20gPFVOS05PV04gc3RhdGU+IHRvIDxzb21lIGtub3duIHN0YXRlPi4gIFRoZSBlc3RhYmxpc2ht
ZW50IG9mIGluaXRpYWwgc3RhdGUgaXMgTk9UIGEgY2hhbmdlIG9mIHN0YXRlIGFzIGRlZmluZWQg
aW4gc2VjdGlvbiA4LjIwLjMuNi4NCg0KQW4gQU5BIEFFTiBpcyBwcm9oaWJpdGVkIGlmIHRoZSBB
TkEgY2hhbmdlIGlzIGR1ZSB0byB0aGUgY3JlYXRpb24gb2YgYSBuYW1lc3BhY2UuDQoNCklmIHlv
dSB3YW50IHRvIGNoYW5nZSB0aGUgdGV4dCBmcm9tIHRoZSBvcmlnaW5hbCByZXF1aXJlbWVudHMg
YW5kIGRlc2lnbiwgdGhlbiBwbGVhc2UgYnJpbmcgYSBUUEFSIHRvIG1ha2UgdGhhdCBjaGFuZ2Uu
DQoNCglGcmVkDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLZWl0aCBCdXNj
aCA8a2J1c2NoQGtlcm5lbC5vcmc+IA0KU2VudDogVHVlc2RheSwgRGVjZW1iZXIgOCwgMjAyMCAx
OjM1IFBNDQpUbzogS25pZ2h0LCBGcmVkZXJpY2sgPEZyZWRlcmljay5LbmlnaHRAbmV0YXBwLmNv
bT4NCkNjOiBoY2hAbHN0LmRlOyBNZW5lZ2hpbmksIEpvaG4gPEpvaG4uTWVuZWdoaW5pQG5ldGFw
cC5jb20+OyBHZW9yZ2UsIE1hcnRpbiA8TWFydGluLkdlb3JnZUBuZXRhcHAuY29tPjsgbGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBzYWdpQGdyaW1iZXJnLm1lOyBIYW5uZXMgUmVpbmVj
a2UgPGhhcmVAc3VzZS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBudm1lLWNvcmU6IHVwZGF0
ZSBOUyBBdHRyIENoYW5nZWQgQUVOIGhhbmRsaW5nIGZvciBBTkEgZ3JvdXANCg0KTmV0QXBwIFNl
Y3VyaXR5IFdBUk5JTkc6IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIg
YW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KDQoNCg0KT24gVHVlLCBEZWMgMDgsIDIw
MjAgYXQgMDY6MTU6MDhQTSArMDAwMCwgS25pZ2h0LCBGcmVkZXJpY2sgd3JvdGU6DQo+IFdlIGNh
bid0IHNlbmQgdGhlIEFFTiBpZiB3ZSBjcmVhdGUgdGhlIEFOQSBHcm91cCBiZWZvcmUgY3JlYXRp
bmcgdGhlIG5hbWVzcGFjZSAtIGJlY2F1c2UgdGhlcmUgaXMgbm8gYXR0YWNoZWQgTlMgdG8gd2hp
Y2ggd2UgY2FuIHNlbmQgdGhlIEFFUi4gIEFuZCwgd2UgY2FuJ3QgY3JlYXRlIGEgbmFtZXNwYWNl
IGluIGFuIEFOQSBncm91cCB1bmxlc3MgdGhlIEFOQSBncm91cCBhbHJlYWR5IGV4aXN0cy4NCj4N
Cj4gT0ssIGhlcmUgaXMgdGhlIHRleHQgeW91IGFyZSBxdW90aW5nOg0KPiA4LjIwLjMuNiAgICAg
IEFzeW1tZXRyaWMgTmFtZXNwYWNlIEFjY2VzcyBDaGFuZ2UgTm90aWZpY2F0aW9ucw0KPiBJZiBB
c3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgQ2hhbmdlIE5vdGljZXMgYXJlIGVuYWJsZWQgKHJl
ZmVyIHRvIHNlY3Rpb24gNS4yMS4xLjExKSBvbiBhIGNvbnRyb2xsZXIsIHRoZW4gYW4gQXN5bW1l
dHJpYyBOYW1lc3BhY2UgQWNjZXNzIENoYW5nZSBOb3RpY2Ugc2hhbGwgYmUgc2VudCBieSB0aGUg
Y29udHJvbGxlcnMgd2hlcmUgdGhlIGNoYW5nZSBvY2N1cnJlZDoNCj4gYSkgICAgaWYgYW4gQU5B
IEdyb3VwIElkZW50aWZpZXIgKHJlZmVyIHRvIEZpZ3VyZSAyNTEpIGNoYW5nZXM7DQo+IGIpICAg
IGlmIGFuIGFzeW1tZXRyaWMgbmFtZXNwYWNlIGFjY2VzcyBzdGF0ZSB0cmFuc2l0aW9uIGZhaWxz
IChlLmcuLCBhIHRyYW5zaXRpb24gYmVnaW5zLCBidXQgZG9lcyBub3QgY29tcGxldGUgYW5kIHRo
ZSBjb250cm9sbGVyIHJldHVybnMgdG8gdGhlIHN0YXRlIHRoYXQgZXhpc3RlZCBiZWZvcmUgdGhl
IHRyYW5zaXRpb24gYmVnYW4pOyBvcg0KPiBjKSAgICB1cG9uIGVudHJ5IHRvIHRoZSBmb2xsb3dp
bmcgQU5BIHN0YXRlczoNCj4g4oCiICAgICBBTkEgT3B0aW1pemVkIFN0YXRlOw0KPiDigKIgICAg
IEFOQSBOb24tT3B0aW1pemVkIFN0YXRlOw0KPiDigKIgICAgIEFOQSBJbmFjY2Vzc2libGUgU3Rh
dGU7IGFuZA0KPiDigKIgICAgIEFOQSBQZXJzaXN0ZW50IExvc3MgU3RhdGUuDQo+DQo+IFNvLCB3
aGF0IHlvdSdyZSBzYXlpbmcgaXMgdGhhdCBzdG9yYWdlIGRldGVybWluaW5nIHRoZSBpbml0aWFs
IHN0YXRlIA0KPiBpcyBhIFRSQU5TSVRJT04uICBTbyB0aGF0IHdvdWxkIGFsc28gbWVhbiB0aGF0
IGFmdGVyIGV2ZXJ5IGNvbm5lY3Rpb24sIA0KPiB5b3Ugd291bGQgZ2V0IGEgRkxPT0Qgb2YgQU5B
IENoYW5nZWQgQUVOcyBhcyB3ZSBkaXNjb3ZlciB0aGUgaW5pdGlhbCANCj4gc3RhdGUgb2YgZWFj
aCBBTkEgZ3JvdXAsIGFuZCBUUkFOU0lUSU9OIHRoYXQgZ3JvdXAgZnJvbSA8dW5rbm93bj4gdG8g
DQo+IG9wdGltaXplZCBzdGF0ZSAob3Igb25lIG9mIHRob3NlIDQgc3RhdGVzKS4NCj4NCj4gVGhh
dCBob25lc3RseSBtYWtlcyBubyBzZW5zZS4gIFlvdSByZWFsbHkgd2FudCBhbGwgdGhvc2UgQUVO
cyBldmVyeSANCj4gdGltZSB5b3UgY29ubmVjdCB0byBhIG5ldyBjb250cm9sbGVyPw0KDQpXaHkg
b24gd291bGQgeW91IGdldCBhIGZsb29kIG9mIEFOQSBvbiBhIGNvbm5lY3Rpb24/IFlvdSBoYXZl
bid0IGV2ZW4gZ290IGFuIG91dHN0YW5kaW5nIEFFTiBjb21tYW5kIHRvIHJlc3BvbmQgdG8gdXBv
biBjb250cm9sbGVyIGNvbm5lY3Rpb24sIG5vciBoYXMgdGhlIEFFTiBmZWF0dXJlIGNvbmZpZ3Vy
YXRpb24gYmVlbiBzZXQgb24gY29ubmVjdGlvbiBlaXRoZXIuDQpUaGUgaW5pdGlhbCByZWFkaW5n
IG9mIHRoZSBsb2cgY2xlYXJzIGFsbCBBRU4gZXZlbnRzIG9mIHRoYXQgdHlwZSB3aXRoIGEgc2lu
Z2xlIHJlYWQgYW55d2F5LCBzbyB5b3UgZG9uJ3Qgc2VuZCBhbnkgQUVOIHJlc3BvbnNlcyBmb3Ig
dGhpcy4NCg0KTm93LCBpZiB0aGUgaG9zdCB3ZXJlIHRvIGVuYWJsZSBBTkEgZXZlbnRzIGFuZCBz
ZW5kIGFuIEFFTiBiZWZvcmUgaXQgcmVhZHMgdGhlIGxvZywgdGhlbiBzdXJlLCB5b3UgbWlnaHQg
c2VuZCBhIHNpbmdsZSBBRU4gcmVzcG9uc2UgdG8gbm90aWZ5IHRoZSBob3N0IHRoYXQgdGhlIEFO
QSBsb2cgaGFzIGRhdGEgdGhlIGhvc3QgaGFzbid0IHJlYWQgeWV0Lg0KDQo+IERpc2NvdmVyeSBi
eSB0aGUgaG9zdCBvZiBhIG5ldyBuYW1lc3BhY2Ugc2hvdWxkIGJlIHRoZSBzYW1lIGlmIGl0IA0K
PiBoYXBwZW5zIGF0IGJvb3QsIG9yIGl0IGhhcHBlbnMgbGF0ZXIgd2hlbiBhIG5ldyBuYW1lc3Bh
Y2UgaXMgDQo+IGRpc2NvdmVyZWQuICBJdCBzZWVtcyBsaWtlIHlvdSdyZSBhc2tpbmcgZm9yIDIg
ZGlmZmVyZW50IGRpc2NvdmVyeSANCj4gcHJvY2Vzc2VzLiAgRm9yIHNvbWUgcGVyaW9kIGFmdGVy
IGEgbmV3IGNvbm5lY3Rpb24sIHlvdSBkb24ndCB3YW50IHRoZSANCj4gQUVOcyB0ZWxsaW5nIHlv
dSB0aGUgQU5BIGdyb3VwIGVudGVyZWQgaXRzIGluaXRpYWwgc3RhdGUsIGJ1dCBhZnRlciANCj4g
dGhhdCB0aW1lIGlzIHVwLCB0aGVuIHlvdSBETyB3YW50IEFFTnMgdG8gdGVsbCB5b3Ugd2hlbiBh
biBBTkEgZ3JvdXAgDQo+IGVudGVycyBpdHMgaW5pdGlhbCBzdGF0ZS4NCg0KVGhlIGV2ZW50IGlz
IGxhdGNoZWQgYnkgdGhlIGhvc3QgcmVhZGluZyB0aGUgbG9nIHdpdGggUkFFIGJpdC4gVGhpcyBp
c24ndCBzb21lIGFyYml0cmFyeSB0ZW1wb3JhbCBkZXNjaXNpb24uDQoNCj4gVGhlIHRleHQgbmV2
ZXIgbWVudGlvbnMgYW55dGhpbmcgYWJvdXQgY2hhbmdlcyB0byAiTnVtYmVyIG9mIEFOQSBHcm91
cCANCj4gRGVzY3JpcHRvcnMiIGZpZWxkIGFuZCBhbnkgcmVsYXRpb25zaGlwIHdpdGggdGhlIEFF
Tiwgc28gSSBoYXZlIG5vIA0KPiBpZGVhIHdoZXJlIHlvdSdyZSBnZXR0aW5nIHRoYXQgZnJvbS4g
IFRoZSB0ZXh0IGRvZXMgZXhwbGljaXRseSBzYXkgDQo+IHRoYXQgaWYgdGhlIEFOQSBjaGFuZ2Vz
IHdhcyBkdWUgdG8gdGhlIGNyZWF0aW9uIG9mIGEgbmFtZXNwYWNlIC0gaWYgDQo+IHRoZSBBTkEg
bG9nIHBhZ2VzIGNoYW5nZXMgYmVjYXVzZSBvZiBhIG5hbWVzcGFjZSBiZWluZyBjcmVhdGVkLCB0
aGVuIA0KPiB0aGVyZSBpcyBOTyBBRU4gZm9yIHRoYXQgY2hhbmdlLg0KDQpJJ20gb25seSBzYXlp
bmcgdGhlIHRleHQgc2F5cyBhIGNvbnRyb2xsZXIgdGhhdCBoYXMgZXZlbnRzIGVuYWJsZWQgYWZm
ZWN0ZWQgZnJvbSBhIGdyb3VwIGVudGVyaW5nIGFuIEFOQSBzdGF0ZSAic2hhbGwiIHNlbmQgYW4g
ZXZlbnQuIEEgY29udHJvbGxlciB3aXRoIGEgZ3JvdXAgaGF2aW5nIG5vIHN0YXRlIHRvIG5vdyBo
YXZpbmcgYSBzdGF0ZSBjZXJ0YWlubHkgc291bmRzIGxpa2UgdGhhdCBjb250cm9sbGVyIGhhcyBh
biBBTkEgZ3JvdXAgZW50ZXJpbmcgYSBzdGF0ZS4NCg0KPiBBIGNvbnRyb2xsZXIgc2hhbGwgbm90
IHNlbmQgdGhpcyBldmVudCBpZjoNCj4gYSkgICAgdGhlIGNoYW5nZSBpcyBkdWUgdG8gdGhlIGNy
ZWF0aW9uIG9mIGEgbmFtZXNwYWNlIChyZWZlciB0byBzZWN0aW9uIDUuMjApOyBvcg0KPiBiKSAg
ICB0aGUgY2hhbmdlIGlzIGR1ZSB0byB0aGUgZGVsZXRpb24gb2YgYSBuYW1lc3BhY2UgKHJlZmVy
IHRvIHNlY3Rpb24gNS4yMCksDQoNClRoZSB0ZXh0IGFsc28gc2F5cyB0aGUgY29udHJvbGxlciBz
aGFsbCBzZW5kIHRoZSBldmVudCB3aGVuIGEgZ3JvdXAgZW50ZXJzIGEgc3RhdGUuIFRoZXJlIGFy
ZSBubyBleGNlcHRpb25zIGxpc3RlZCBpbiB0aGF0IHNlY3Rpb24uDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
