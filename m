Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634CDC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4agfmuAjkZB3ktZJiqI2xWXzVJtrH9DnLT0KImL/ofo=; b=TWIgvrTv3/0zcaaWMCG+ACyplk
	mC02lzmydvJcRcYGf/OUsDP8Cm5EwHgvKn5DNmsFsmidbWfxPTSn9c/UhhTua22QRWV5a43SLODBy
	mtzVFwKSkHNAdpbH2Rjd+QWVSPx3O6xw0VtyzXHBd7wsrXLBTk6DKBM5rRGoSeVj8U66MkJUmgPdk
	6H1VlruUPYRPms91Llcuw9a5NUig+mAso1RAFa+jjS4L8LdCOs430n0RhsVfNPFQZm/n23hRA4nSZ
	VHgPsVTAYJr8KuJBA5WWvTbCfC4cnDffh3JBGS1DScUE/gHs90TML5qElRsXp3u4CBz/62MswHPUP
	C8js8njQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogXtM-005A4s-Ct; Thu, 06 Oct 2022 20:54:52 +0000
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogXtJ-005A3d-DF
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 20:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDklCtshTgtHF367nGF4UXukUhHRunFXK0XrvhDNW8YsZVhVohg7j30IghqdtlwMRIda/mpotqgXZQgIblbxg5atCdrA2yLU7b+p+x2ZkSS0EKVGHYw8rkGsnwfDAuKj+C95KLoPrmi9gRlmTOLNi3bYQMBRsm2YeWI9w6chkMMy10JHaIXFsIIwrrDEoYo4P+uYSi3hbA/oQdh9SEjmDHau2vKRXp2b61yqpalN7crTu62MeeS9usbjjOWvAoecG9n1CdqoUaCiIS1fJm/3iZMqv3XcpNwptYGqlYkNkI9D1PW5wM/cy9sMrVTloLc2s8VsjRyyfmlZ+AxCnyYFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4agfmuAjkZB3ktZJiqI2xWXzVJtrH9DnLT0KImL/ofo=;
 b=BcxCxSy2e8Ful6EfzQ3GsVCKT6ukdltKLV434NK30FYmbNr5bloKAXnGLV6AA99ptcOKdv6rt9CW76/kIr5TO63HjRVoffa8r/rY5TeVz105S765ACrahomPvXUn1Q46drYnaMefxxKJduQQC1Zze7MMy80hS9FnwcDiB0pCZ1jzcEuAQ+RBgWyr2N5MT1TsAMsU8k6M93LPxuDYnzSFVdVDzuwzg38UCrS3oeIryIIp5h3kxvg4obpjowZYNq4KAI1+iIiZu9kUrjMhX4sRweK1r0hXS3wnjDjOnVYe5rQ9DM1SkQD4XK1x0d1gkYVPWGChzIIRuGyuyTWjaFJHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4agfmuAjkZB3ktZJiqI2xWXzVJtrH9DnLT0KImL/ofo=;
 b=wLEKtTcQqKQ9Bpq8upO2wxdMbiJEJnHGLRKsT8oV3nwgYi6iRF6GctC2isBnhZgIjrzX552cRT2We1od+Eai25sW/gOBy9nT1Dx/6G5NY6a+mVlTFYSBdCd+goO77Lpj0ez+/IuUvuETfQ32UJb2tgaQO9e5+iLiOth7ETi8IvxuSjA1O1/t9zDh52l2YOvcBCMI+1iJ5wZnaMs9ylCQxKJSjfrBB6XZ9ckeQJ/0GDYfYLkOGUauWTV7pJKIjSqPnbKFZUevP8B7tMe5KSaxvRwpUimetA6J0yI2tfoCVJtXx2tB7Obmoy1sS5dwcGAOCVuxx5MXhBsrEDXCjAqS2g==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 DM6PR06MB4138.namprd06.prod.outlook.com (2603:10b6:5:81::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.23; Thu, 6 Oct 2022 20:54:45 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f%3]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 20:54:45 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: James Smart <jsmart2021@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "hare@suse.de"
	<hare@suse.de>
Subject: RE: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Topic: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Index:  AQHY0xkW0CvFgvGYC0OqpzqIUZQ+Z630t3BwgAAlBICAAAkAAIALQSkAgAEjOwCAAJCpgIAACkhA
Date: Thu, 6 Oct 2022 20:54:45 +0000
Message-ID:  <DM8PR06MB7704A8F14B29CAF6C0DB1291F15C9@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
 <b121c092-cecc-b891-be3c-b32c2a3e611d@grimberg.me>
 <20221005181510.zu7vcwjtltcal2zi@carbon.lan>
 <74eb192e-13aa-5043-3016-5ce0d7ca2688@grimberg.me>
 <7872e4c7-54cc-08d6-e7a5-3510c3875e1d@gmail.com>
In-Reply-To: <7872e4c7-54cc-08d6-e7a5-3510c3875e1d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.600.2
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR06MB7704:EE_|DM6PR06MB4138:EE_
x-ms-office365-filtering-correlation-id: a93c3bb2-e3cb-4549-ef7f-08daa7dcffb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  2Pt7lwtzCVHtJKY/kwdb9iM2lzBlLE53umjMk6daD36QM1T0s9eODqAv61EdkC2fHRySx1GzMZEBeQuaLMh9TAEvqB4zTTSECTZMVLAPbfsN98zQSEv1iXQJ8c7ghZv0h911p0HzVU4RMWE40Mygl83vtBZaxev69dbAc0TMDbSXVjjx/wPc4diI7HPTLM7hVx9BoMi5ufAjDAxcWTvhGmE9xpZ1pQHU+rwdLZ3lsVyhieeWc0k7NfnCgzNll2uHaTIK6tQnGX1p+lgE5zaklzk/RN+9W9XZkLS+yv+isvg4cmR7nJeBNjg2CK36DwiDp37cXgF5CL2pzQpAH0ok19RGIVQcxXH4lUdZ7ekcs/0aO3DdupW371pZ63sWysV1rIPipTrj2xkjqtacs+iQ87ekXwLb1MAhArlJxskcSWN9tIlfIb7yrpqr9uvV7AV5t8tAMSwzg4BO/ra+lnyL1LAqfMeXzojILAfAdUDN97bzd9oqdFN55j4LgV7bZzJs5II+qDCKlqup4tO9OICCtXZ/rkOruMJmDfYiwylNTR7tLMPu8HDa2QINkGvS8gI+fDnQ3lxf17GRU/i5uTdzSl6Qu60xy3t2HPTADMIBLb7iAI3RC0Fs1Y887+qt3VAYltPlHZHbLkcHYC6hOhUwqbVnHRVIWfsqkzMW0dMv8m36qOh2GyrWQJkLijCU9SyVQlDE+1Yqeyd/qkQma4hvQ9S5fzgjIjI2h65eDghniAY4MhFiP5AxrVp3n7ykZWNpVEJf4igO8TKCpYBvxqeXvg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR06MB7704.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(71200400001)(86362001)(66946007)(110136005)(478600001)(316002)(54906003)(38100700002)(41300700001)(64756008)(8676002)(76116006)(66446008)(55016003)(186003)(122000001)(5660300002)(6506007)(38070700005)(7696005)(8936002)(53546011)(26005)(66556008)(66476007)(33656002)(2906002)(9686003)(83380400001)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aGZHSWVlaWJvSWwxUVBack5QVXFialhlbThYdStRTGZESU9Yd29qTERJMkxo?=
 =?utf-8?B?V1U2ZTZ5c3ZidEZ5ZkxkeEZWVEdpdnZheHljbGFsT09jRzc5TGVVWHY5Z1c2?=
 =?utf-8?B?elA1WHluQ0w4TkdQbjh6MStQOUlUd1V2Vm5ETzh4djVmNzlXNEl1TU41Qjd4?=
 =?utf-8?B?bE1VVUJ1RWJnOUJnZkcrSEluN2lvWWVPWElaSnd2bFBLcWZ3WWd4UDJVcHpS?=
 =?utf-8?B?aXJYVG9xdStjOTJvbklzSzhrb0h1Rkg4Y29qaHhyWlJDVy9Udm9TTW94Um9t?=
 =?utf-8?B?R01vRmNGYjVaL0FBcnRYWjZNMGVOU0ZqZU9QODFHVTJ3cURwclR2MkpyNDVw?=
 =?utf-8?B?SXJjcWl1aDRuUnhhSDJ5eG9HV1dqbVQyTThJbkNaSHJwb1B1MENGR0htdEdm?=
 =?utf-8?B?c0V0Mmt4d2hsZ1Z1Z3FvSVpTMDV1U1ZDUWlIWVBQekZOa3VSeDZuYVh2Q1li?=
 =?utf-8?B?WDc4eTZ5NHhDYzZ2WGVIc1RzVnE2TzdzZi9KQ2lOT3dZck13NWp4dHJaOEpS?=
 =?utf-8?B?M01JUUNnL0Q0WXNLR21udTNoUloxa2ppYkpud2pqdENvS3BjdUxVNG1tWlcv?=
 =?utf-8?B?Zks4OWtha29SYldoN3RWbkU3bHU5VnZiQi9uQlVjQUdmZWdNY0t3dkhVY0dt?=
 =?utf-8?B?ZGs1ZDB3NnFaRUxIVFBmUG9sQm51RWVIR3JrV3M0aWdsZUZnYUZXWWZxK24z?=
 =?utf-8?B?UmNvNDdMbEpWMkRCci8yT0NZdUhBc3lpUEFrS2tIb1lIeWdKdkxRdUJmZGQ4?=
 =?utf-8?B?YWkwK0NqKzBFbVlreFBsNDFjeVJWTmJmQWVtUzN3VXdKUzIyL01oSmx3VFFS?=
 =?utf-8?B?UmVlcU9UMUh6cHl2YWJpemtqb2pTYlp3ZGh1ZlpiYk1FR3FtaVNtTGdFV1c4?=
 =?utf-8?B?b2lxa1BJL3FiU3R5SFZUQzU0OHNHdmpRVkdQbVVGYUljTmx1bE5vbmFEaEdm?=
 =?utf-8?B?RUhTaW5jSU9iWmcrMXo5c3F3OEx3RXpCWVY1YndmcXN1cnJFSkM5VktBRmlu?=
 =?utf-8?B?dGJqOTVISjZ1ZEU3Q0UrN2l1U2x3Y2kvMU5uYXVub0hGUmxxZERYR0JZS0xp?=
 =?utf-8?B?QWZjMFZBVG9UdGZ6TUFNamZKU1RpNVJra3kzdWgybzgzUTZ6VUpZb21mM0pt?=
 =?utf-8?B?WCtRZjJWZVJhMmMrZFY4aERLd3lmRGhBVTFYd29LN01RMjlCeUVtNVNmekdn?=
 =?utf-8?B?TVlpQncvOG1kMzkzVW1RV2l5SG8zcnVkdVpkTWlZYnpJcklyNnpDaTgzVGUx?=
 =?utf-8?B?YnZEQnhnTnJ6MWJMTHVKam9RUEJqM0ZPWFRXRWpkaEcvaEV6UjVmZjhnVW1s?=
 =?utf-8?B?SFF0cFROOS9GZFUxN2hJUGluOGpnelFUR2hpYUN6TW9EQVRxVXVjcXNBZFo0?=
 =?utf-8?B?RWhqb1U1NEZmTVZqUjNOTWY5QWJmZ0xmUm4xNVZzUFZiVURHOUdlNDVmekhI?=
 =?utf-8?B?OEVEZmNaUVFOeW4wNmh6VnVvREt6ejd5a09VWXlDT2hNVi9wYW5tRWN3cWJH?=
 =?utf-8?B?b1BnMkkvVEJISmRTSURhdzI3d0F3Vkw2cGZVendLWmFKK3grcHVVWDJDeDVQ?=
 =?utf-8?B?bXZaemdlSmV2VVpncHZudm04NE5xWjlJK2hzOVptY0JMQ0RrWFpGSmJpQnNX?=
 =?utf-8?B?NGd4YmpOZndWSzhkZ1pDTGhGbjZHWDVwL3pFV0xmWUJmcndXbmROcy9TaEdm?=
 =?utf-8?B?eVJrSzRwbGdkeDNFM1dzaUVYMXZhY0grZUJ5ekNpeXV0SHJlRitVSmVnUFJH?=
 =?utf-8?B?MXMwMFJMNFlVcnZvQnlHdG1LOTgvUityZWl4Sk1ObjlOclhVV2FWUkVGc0hQ?=
 =?utf-8?B?b2tUSFp4dkFpNWVpNFIraE5sSityWklGMWtxZHhoQ0FyU2s0WU91eVZBczZ3?=
 =?utf-8?B?UmQ0d2ZBeVdvdFA4bS9Wa0pHM0R2VXcrZzJkWEJmdmU1NjV5aDZRYVFRWkxJ?=
 =?utf-8?B?TUZlYndFclFSSFBiMUxKcjN2OGtvUEVFN3d5dlRZd2ZOVFdpcGc5Q3JGR28y?=
 =?utf-8?B?WlBTZmZaOFh0dGh1SXhERVlVL3RPcTdmQlNOcFJuVHdCS3VzcitrUzZDMnNQ?=
 =?utf-8?B?Ui9FaStBblhzYzFoZFVRZXVjVVJKOVR1UUpKUmdrbEJ0T1BsQWNNOFU1Sk5l?=
 =?utf-8?Q?v8q5P8CCO3VEWrMELBA/iJnk1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93c3bb2-e3cb-4549-ef7f-08daa7dcffb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 20:54:45.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPaMh0nKP5FI2kirP+4hWQiv0F4+RibHVQDcrpY2vRW0dJEThGcSbuv6mOnJHooxWxHvWPZ4IBTyZOx5jU+Cvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_135449_494334_BB583527 
X-CRM114-Status: GOOD (  34.25  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

WUVTISAgMTAwJQ0KDQpEb24ndCByZXRyeSAoRE5SKSAtIElGIHlvdSBhcmUgcmVzZW5kaW5nIGV4
YWN0bHkgdGhlIHNhbWUgY29tbWFuZCB3aXRoIGV4YWN0bHkgdGhlIHNhbWUgcGFyYW1ldGVycywg
aXQgaXMgbGlrZWx5IHRvIGZhaWwgZm9yIHRoZSBzYW1lIHJlYXNvbiBpdCBkaWQgdGhlIGZpcnN0
IHRpbWUuIElmIHlvdSBjaGFuZ2UgdGhlIGNvbW1hbmRzIHBhcmFtZXRlcnMgKG1heWJlIGJlY2F1
c2UgeW91J3JlIHRyeWluZyB0byBmaXggd2hhdGV2ZXIgY2F1c2VkIHRoZSBmYWlsdXJlKSwgdGhl
biBETlIgZG9lc24ndCBhcHBseS4NCg0KCUZyZWQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDYsIDIwMjIgNDoxNSBQTQ0KPiBUbzogU2FnaSBHcmltYmVyZyA8
c2FnaUBncmltYmVyZy5tZT47IERhbmllbCBXYWduZXINCj4gPGR3YWduZXJAc3VzZS5kZT4NCj4g
Q2M6IEtuaWdodCwgRnJlZGVyaWNrIDxGcmVkZXJpY2suS25pZ2h0QG5ldGFwcC5jb20+OyBsaW51
eC0NCj4gbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBTaGluaWNoaXJvIEthd2FzYWtpDQo+IDxz
aGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+OyBoYXJlQHN1c2UuZGUNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2Ml0gbnZtZXQ6IGZvcmNlIHJlY29ubmVjdCB3aGVuIG51bWJlciBvZiBxdWV1ZQ0K
PiBjaGFuZ2VzDQo+IA0KPiBOZXRBcHAgU2VjdXJpdHkgV0FSTklORzogVGhpcyBpcyBhbiBleHRl
cm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yDQo+IG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcw0KPiBz
YWZlLg0KPiANCj4gDQo+IA0KPiANCj4gT24gMTAvNi8yMDIyIDQ6MzcgQU0sIFNhZ2kgR3JpbWJl
cmcgd3JvdGU6DQo+ID4NCj4gPj4+PiBBcyBmYXIgSSBjYW4gdGVsbCwgd2hhdCdzIGlzIG1pc3Np
bmcgZnJvbSBhIHRlc3RpbmcgcG9pbnQgb2Ygdmlldw0KPiA+Pj4+IGlzIHRoZSBhYmlsaXR5IHRv
IGZhaWwgcmVxdWVzdHMgd2l0aG91dCB0aGUgRE5SIGJpdCBzZXQgb3IgdGhlDQo+ID4+Pj4gYWJp
bGl0eSB0byB0ZWxsIHRoZSBob3N0IHRvIHJlY29ubmVjdC4gT2J2aW91c2x5LCBhbiBBRU4gd291
bGQgYmUNCj4gPj4+PiBuaWNlIGZvciB0aGlzIGJ1dCBJIGRvbid0IGtub3cgaWYgdGhpcyBpcyBy
ZWFzb24gZW5vdWdoIHRvIGV4dGVuZA0KPiA+Pj4+IHRoZSBzcGVjLg0KPiA+Pj4NCj4gPj4+IExv
b2tpbmcgaW50byB0aGUgY29kZSwgaXRzIHRoZSBjb25uZWN0IHRoYXQgZmFpbHMgb24gaW52YWxp
ZA0KPiA+Pj4gcGFyYW1ldGVyIHdpdGggYSBETlIsIGJlY2F1c2UgdGhlIGhvc3QgaXMgYXR0ZW1w
dGluZyB0byBjb25uZWN0IHRvIGENCj4gPj4+IHN1YnN5c3RlbXMgdGhhdCBkb2VzIG5vdCBleGlz
dCBvbiB0aGUgcG9ydCAoYmVjYXVzZSBpdCB3YXMgdGFrZW4NCj4gPj4+IG9mZmxpbmUgZm9yIG1h
aW50ZW5hbmNlIHJlYXNvbnMpLg0KPiA+Pj4NCj4gPj4+IFNvIEkgZ3Vlc3MgaXQgaXMgdmFsaWQg
dG8gYWxsb3cgcXVldWUgY2hhbmdlIHdpdGhvdXQgcmVtb3ZpbmcgaXQNCj4gPj4+IGZyb20gdGhl
IHBvcnQsIGJ1dCB0aGF0IGRvZXMgbm90IGNoYW5nZSB0aGUgZnVuZGFtZW50YWwgcXVlc3Rpb24g
b24NCj4gRE5SLg0KPiA+Pj4gSWYgdGhlIGhvc3Qgc2VlcyBhIEROUiBlcnJvciBvbiBjb25uZWN0
LCBteSBpbnRlcnByZXRhdGlvbiBpcyB0aGF0DQo+ID4+PiB0aGUgaG9zdCBzaG91bGQgbm90IHJl
dHJ5IHRoZSBjb25uZWN0IGNvbW1hbmQgaXRzZWxmLCBidXQgaXQNCj4gPj4+IHNob3VsZG4ndCBp
bXBseSBhbnl0aGluZyBvbiB0ZWFyaW5nIGRvd24gdGhlIGNvbnRyb2xsZXIgYW5kIGdpdmluZw0K
PiA+Pj4gdXAgb24gaXQgY29tcGxldGVseSwgZm9yZXZlci4NCj4gPj4NCj4gPj4gT2theSwgbGV0
IG1lIHRyeSB0byBhdm9pZCB0aGUgRE5SIGRpc2N1c3Npb24gZm9yIG5vdyBhbmQgcHJvcG9zZQ0K
PiA+PiBzb21ldGhpbmcgZWxzZT8gV2hhdCBhYm91dCBhZGRpbmcgYSAnZW5hYmxlJyBhdHRyaWJ1
dGUgdG8gdGhlIHN1YnN5cz8NCj4gPj4NCj4gPj4gVGhlIHNuaXBwZWQgYmVsb3cgZG9lcyB0aGUg
dHJpY2suIFRob3VnaCBUaGVyZSBpcyBubyBleHBsaWNpdA0KPiA+PiBzeW5jaHJvbml6YXRpb24g
YmV0d2VlbiBob3N0IGFuZCB0YXJnZXQsIHNvIGl0J3MgcG9zc2libGUgdGhlIGhvc3QNCj4gPj4g
ZG9lc24ndCBub3RpY2UgdGhhdCB0aGUgc3Vic3lzdGVtIHRvZ2dsZWQgZW5hYmxlZCBhbmQgdXBk
YXRlZCB0aGUNCj4gPj4gbnVtYmVyIHF1ZXVlcy4gQnV0IG5vdCBzdXJlIGlmIGl0J3Mgd29ydGgg
dG8gYWRkcmVzcyB0aGlzLCBpdCBmZWVscyBhDQo+ID4+IGJpdCBvdmVyLWVuZ2luZWVyZWQuDQo+
ID4NCj4gPiBJIHRoaW5rIHRoYXQgZm9yIHRoZSBtYXR0ZXIgb2YgdGhpcyBwYXRjaCwgeW91IGNh
biBrZWVwIGZvcmNlIHJlY29ubmVjdC4NCj4gPg0KPiA+IEJ1dCBJIHN0aWxsIHRoaW5rIHdlIG5l
ZWQgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZSBkaWZmZXJlbnQNCj4gPiB0cmFuc3BvcnRzIG9u
IGhvdyB3ZSBpbnRlcnBlcmV0IGNvbnRyb2xsZXIgcmV0dXJuaW5nIEROUi4uLg0KPiA+DQo+IA0K
PiBJIGFncmVlIC0gYmVoYXZpb3Igc2hvdWxkIGJlIHRoZSBzYW1lIHJlZ2FyZGxlc3Mgb2YgdHJh
bnNwb3J0LiAgRE5SIGlzIHByZXR0eQ0KPiBzcGVjaWZpYyBpbiBpdHMgZGVmaW5pdGlvbiAtICJJ
ZiB0aGUgc2FtZSBjb21tYW5kIGlzIHJlLXN1Ym1pdHRlZCB0byBhbnkNCj4gY29udHJvbGxlciBp
biB0aGUgTlZNIHN1YnN5c3RlbSwgdGhlbiB0aGF0IHJlLXN1Ym1pdHRlZCBjb21tYW5kIGlzDQo+
IGV4cGVjdGVkIHRvIGZhaWwiDQo+IA0KPiBCdXQsIHdoYXQgd2UgZm9yZ2V0IGlzICJ0aGUgY29t
bWFuZCIgaXMgYWN0dWFsbHkgImNvbW1hbmQgWCB3aXRoIGZpZWxkcyBzZXQNCj4gdGhpcyB3YXki
LiAgSWYgd2UgY2hhbmdlIHRoZSBmaWVsZHMsIGl0IG1heSBhY3R1YWxseSBzdWNjZWVkLg0KPiAN
Cj4gU28gaWYgd2UncmUgcmUtaXNzdWluZyBDb25uZWN0IGluIHRoZSBzYW1lIHdheSB3aXRob3V0
IGFueSBjaGFuZ2luZw0KPiB2YWx1ZXMsIHdlJ3JlIGJldHRlciBvZmYgbm90IHJlY29uZW5jdGlu
Zy4gICBCdXQgaWYgQ29ubmVjdCBjaGFuZ2VzLA0KPiB3ZSdyZSBiYWNrIHRvIGdyb3VuZCAwLg0K
PiANCj4gLS0gamFtZXMNCg0K

