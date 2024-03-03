Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C60C54798
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Mar 2024 02:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vwwhAx2KhgLsva8PfPyzmOgeGXErKTg6fsW/Is7THTo=; b=D3Jk6zGmkXnzPHzrJYh1JXHUXn
	Dh0uWnDmqA+w11DgJMUvyhwIGjbiAekoj2dmN6Cv+saC5faPi/4KZ4sJ6SgYn64vSSTczrKYVc4Eu
	sD/1Cz94ItHKOvhj875FQnX0qhT16pbaOLZlqXzjGPzpccDOcXjx2RnhiMbPWsmCh35JlF3d7Etbb
	UhLGw+yB/NLrYPPaIFY0rzMyZZZLQa1VP7tevSS76v4NamIU2a1sfmbIKuxZAeGi48qiJDNfWGEom
	YBcTjGwXoRYesRbZYjJAs+4fX4wlzHOmpQQSdU8zpeVvcC62bSLV8CgYwPrc1AlmpqgN3RMBYQO3P
	9FS3in6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgc3U-00000004xBI-3rf4;
	Sun, 03 Mar 2024 02:58:24 +0000
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2418::600] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgc3S-00000004xAD-1vny
	for linux-nvme@lists.infradead.org;
	Sun, 03 Mar 2024 02:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHMY+q23i6qvwTrOWV9dis3Q9ZMw7AStuUKghani6CWqwAvim2ypLwXtc4iohW4UnHpXsePUqrh6Vga7TZM4Y68Gcsp5fSSlN/eWOeNQcnZnnSryD7Wttnh/O3++sERLfFxauxW96kgsgeNwngnWxCkAlo/rWpuu5p7y3wamPbhQbky0oEo8pGtL7zCjcCUygMe7Gk4gQvxQ50iObQrHyziEGjH72otyRoD4E7WpgpTGQ6hJMAWyUMLsu1Y1yEVmdf+8JIddt/uEuAf8POtj8wHL4JRKRqaS4KPBB+uCPI1UEej9vAEWM5YEQNjcnFMcAy0oCYe+uD547RqMHVj8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwwhAx2KhgLsva8PfPyzmOgeGXErKTg6fsW/Is7THTo=;
 b=ntcNNs/JQ4+xM6Um5pGeE5U1uZyWJXJ+pA296+QpoDHeVak8O6UKNTLKcBjTAp5kGDEH7wcpFVCpnWFdoNIZcVElv4O0q/vDx8wMIADjDDJc5LOIDsKd0b7zdxS3Qcdn6M2gvyng8cYQK6CV/7+JyWfTGneMqvdj9IdqBZOu12QG+gajYuJNPL3GeUfgkxSixOfgWzvuWTb1QhDPymc/2kURY1586MeOL26h8YQ10C9U+k1LMeTTt6uArDts3fWnjgPsCbLk+dzY270zCWzlRSnJSj8Zr1dsv5W4fw8oUPCgfQvzgkV9iJIAbclAagfgQm/KJM0LxwPXdwnXbiUEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwwhAx2KhgLsva8PfPyzmOgeGXErKTg6fsW/Is7THTo=;
 b=OL6bLo+8K2WZsG9+SuYSsFW7p6wYZyDUodC0QM4Iro7v28Nma0gKmzAn32+0wByKQ17Awrz89PLdF6UKe9WD8LJsWMnhxAYvr9CiZrGLqkRSTc1EFGqIuDO3Mskj8BklazhX6ke6vHId4Mkp3I0ZikRFJztOMvs9hOgGY1YhdObx2zAq8X58ltFtiFt1gFXmxwdyJ4EjcyFIMCHio26hjKcAMUo9qFXmxSZHNGImmSfli4jeHG+/vzuVOrm93tlgy7bD4zaPB7RdLw1U3DXsHw++mrwi8gpbpKl2HF9rGY3f2Lt4ivwseYkrNRAU7F6Ucd0chUklA/e7/BqhiU+EkQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Sun, 3 Mar
 2024 02:58:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Sun, 3 Mar 2024
 02:58:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/4] nvme: fixes for authentication errors
Thread-Topic: [PATCH 0/4] nvme: fixes for authentication errors
Thread-Index: AQHaa8uo+9HK3V4hjUWVgAaW6OU6nLElVZ2A
Date: Sun, 3 Mar 2024 02:58:01 +0000
Message-ID: <97a15d31-a742-4c4a-896e-1441e45cebaf@nvidia.com>
References: <20240301112823.132570-1-hare@kernel.org>
In-Reply-To: <20240301112823.132570-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5978:EE_
x-ms-office365-filtering-correlation-id: 3f331083-ecc5-4107-4353-08dc3b2dbd24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/aeP9Aok1agJOgMwMa0ZEWkDiWSiHXm3dEv7kDKcWJi0dRm+tgqyh5s5R9N4xQ4ePHTyT/kgyPeUwAs19T8+OyRpJR8eqfCJPiHJCXHsYUoGeltX4i+NYOSyWCz0Vehm3bn1TjYUi1qDBDO5S5UyGspDPDNrdqlCmOb7uL3bVW/IGZy7zX4qxzaxX5BD1vuBI7aiaLqKLFOB/g5L+VeuNwdoazWsvKTa+7hS88h+LjBlYGGgigHq3jzmw3PTIBCK1X9LoWb5ZpMq8X4nOCz/Gcs4WYBoyczwREFqoY6fY6VwhDZ8021QLIIM8IADXEfl6x7x2RNYlozBRWljNO6pvrz9XPA+1xRjGTBLQCEAmHcx2aHE5uPVtdfqlojpGyatsPUBW3a80i4XDbQueNzO+NXRhof+3bUzbyhnMexlFNSORlulKo9sbLAmYyLGsiBx41D4RZvxJhjUwWFEno2m0bXETqiD/XLL0UoDSin5wTKm5Co/E2Bx0PxYMww0Trp9NLgS2zi+MPEHZziRdMbY+jX7EwVyYxSanTVm4aUxunds0ThoXdDyvZcVYSOidt3ovrCNvQjocvcpOERE4faLx8Ma2I1InQtFHT6I7c4aSyx9p6dzhpXiycnUkRCYAec9waAglucbdH0DjAn/EMYEcYPqxVP7F6R5Pg31knIVOvLlV8u8SFiK5ZrQeDod91NjPp8FaFDP8xN0qLwkORyS62/C0rrNNx53eRtQ1L2uDU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDdBYzhFWGF2ODQzSmEzRW9ySXh4RjYxQ0c5VDAvMGpsc0ZZSFVZNDRzMkZZ?=
 =?utf-8?B?VWlEb0dCQjVVTkgxUFVLUy9hRmtwMWVtOVRGdkZFS1dzTUYvMWM0dVZlY05F?=
 =?utf-8?B?a2NrTWw4SEhRRjZxclN5Z25XcUx0WXRpN295cmVIUjc4TWpxTEFuTTRZVzVL?=
 =?utf-8?B?TXN2bHR0bEtPQ1BIZmVUa0NYRXVGTTR1NFU5ejRVd3VEbjl1RFJyMXF0cmFa?=
 =?utf-8?B?RUUyKzhxWDV3S2MwQnFwb1FmV3dRbHJLdnBCTFhHME5CT01WOTVsMzJZQ3k0?=
 =?utf-8?B?ZzVYMmgrYzdRZTNIb0tpUGdKM08zMHZaYjNoRFlhZGRVemFNUW9HZDVMZ2Vn?=
 =?utf-8?B?LzhIeTZjc0N5aFIwc2VnUS93aGVvVmVCVWZ1dy81bmRTRHBQd3dvNUF5QlhZ?=
 =?utf-8?B?QmYvZTVTV1M1WjhtSDZ1STdPK09WNEdiUDcyV0JVekxocDlSUmZjUlkxN0Mw?=
 =?utf-8?B?M0kvMmJwS0dsVE51RTgwS1Q4ZW1FRklPeTZIc0V0U2dBaTZLMWZhN3ZhcjFP?=
 =?utf-8?B?Z1d2MXR5L25uc0pkMjdRaDV3eURVa2F6MVdSL05qYjFsTEcreHJxcGRwdEVC?=
 =?utf-8?B?c1RQM1RBZVM0UFlydEpya2RjUXVFN1dtcEkzTWpRUjFHZjl2RGRVTUh3TGl3?=
 =?utf-8?B?bkxtSXdXVGhxc3ZuT0RnUG8wb0JZbWF5ZC8wYXkza3VKTldTSktuZUpXMlA5?=
 =?utf-8?B?MzYyOVFrMHJVSHF3ZnMwaEtTRkpGZ3U4dnFjbG03NTZ1UkRxMlNaNkV4eE9G?=
 =?utf-8?B?L0FidVE1K3dOampSZ1h5a0dwdmlNVURtc2JJTHZ5TkhwVGFNWVJHcEFsSlZ5?=
 =?utf-8?B?M2F2eVFsd21FU3M2MEdFbzJFRHBSQjB3ZE1RcmdKVTAzNnA5WXRIbEtxUk5T?=
 =?utf-8?B?aVRxWFo3WWcvMWlscXlvM2gyMHl3bGhzY2JTM2ZqZ2lmSitlbFNPWU9KT1Nh?=
 =?utf-8?B?bTlncjkxVWpWWHhlSzhtRU1abk1JT3hFZkFjYkhOeG1PdStRVVduYVZOMUpq?=
 =?utf-8?B?MUdxaUNjVTdIT1lPeGVaMzZKVzhYQWR0V1dwMWdsTGU2THU2aHROTHNZbDNI?=
 =?utf-8?B?L2V4L0ZxOHFybzBVbGxhZUFzSWl3ay9sSWtBMENSL0VwQmtwU1AxNEttTitk?=
 =?utf-8?B?MWlHalFRWHFPak5ienorQlZzZUxKSWxyYzE1S3FhdHJUemNXNDB4UGRMcDdw?=
 =?utf-8?B?ZU9qbzgrZ3VKMWNVRTVzQjV6ZnVPcXR5dGhHekh1V2k5dWxxc21jdGE3YnJl?=
 =?utf-8?B?WC9mb3NRNllvV2tBdVQxTkY3b3M4TndRUUtTay9YRytQRkZ4em53bnJSKzl4?=
 =?utf-8?B?OTg0NmgwOWJPZ0VDMkNBeFIwS2w2ZG1BMkhaMjhTd1VqK3B0VkMvS2xpem44?=
 =?utf-8?B?U2FqeTB3VFg4ZUdBN09mTUJkKzBzVGx0WTJiYSttZjJpRHR2L1ErTVNhUmw5?=
 =?utf-8?B?RVhXc1pkOFlwRy9xVkZQb2J5M1hnZ083Ris2RnhmblN1VDZGQit3c1BmYjRO?=
 =?utf-8?B?THFOWVVGTFhDSkt2OFdxVjVDb0daNk56R2NNaVNHN0JUcVl5bUVZVi9hQ3dJ?=
 =?utf-8?B?dzlKZXRucUJrUXlnOXVraUVpUUx1Y2EvSDFpNXdkakVZREt2eSsxelhnTUhy?=
 =?utf-8?B?b0YrbEdkS24vYkxQOXVrbkg3QUErSGNtc3hqbm44dW5IaEl2VUo0eHlEOCtG?=
 =?utf-8?B?ckRYd1ZiK2xUQ0loS0J6TEV0TitrM3BqcGNORDJYUlJNMjZSWS9hRWxUZjVZ?=
 =?utf-8?B?aFdibVdOWU51MURuejBkYmx0djc0ZVdaQjRURWxMaXNiS1JyTDNqbi83ZDRk?=
 =?utf-8?B?NlVQb2lueG9zV0JBVkFiU0ZjZEdiWmdRa3pGSmxIb0ljMzJ6djVMRkpVUXpV?=
 =?utf-8?B?eGI3Z2pUbFlhR2FaZWlaYWk4RVBpWno3RVRCeFovK0EvTDlsd1JhZmVEb2pZ?=
 =?utf-8?B?aUdzOGhla3k1OFYxMG1zQkxTSXF3a01hY285R1ZDY1A0ODRRN0V0RzA5aUlx?=
 =?utf-8?B?VlZieDBWWWs0SFQ1WXM3dWJ0MTAzSlhoSU9YRi9tSmdaQ3VIMHY4NEkycFRt?=
 =?utf-8?B?TWRQUmc0OE8zN1JWY3lKckpuRjluYmhhdWVSRHcwdlVjeW5EdTlXejA0bG9H?=
 =?utf-8?B?K2RkS3R5emxIcjZFZjRxTkIvTHFLMnI3T0lCdzhpTFlRS2Z5VlNzUUp3K3M5?=
 =?utf-8?Q?ONSs6KVOeGW5PAAIUs715yDXvvDaRWTsfoJFzwjziAIC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B34ED321D2A14469D030DD1AC0AB05F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f331083-ecc5-4107-4353-08dc3b2dbd24
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 02:58:01.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R59w9+kL5zKCJ2C57HvQTJfjVE2Fe9Bnw5wTFW6vYlvuhMLtrE5C0pg7lWxszqjj/DZN/Ylq5kS72Reoq6ok5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240302_185822_547418_B4150FBD 
X-CRM114-Status: GOOD (  13.92  )
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

T24gMy8xLzIwMjQgMzoyOCBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBIaSBhbGwsDQo+
IA0KPiBoZXJlJ3MgYSBzZXQgb2YgZml4ZXMgd2UndmUgZW5jb3VudGVyZWQgZHVyaW5nIGJsa3Rl
c3QgcnVucy4NCj4gVHVybnMgb3V0IHRoYXQgYW55IGF1dGhlbnRpY2F0aW9uIGVycm9yIHdlJ3Jl
IGdlbmVyYXRpbmcNCj4gaW50ZXJuYWxseSBhIGluIGZhY3Qgbm9uLXJldHJ5YWJsZSwgc28gd2Ug
c2hvdWxkIG1hcCB0aGVtDQo+IG9udG8gdGhlIGFwcHJvcHJpYXRlIE5WTWUgc3RhdHVzLg0KPiBU
aGF0IGNhdXNlZCBzb21lIGZhbGxvdXQgb24gdGhlIHRhcmdldCBzaWRlLCB3aGljaCBnZXRzDQo+
IGZpeGVkIHdpdGggdGhlIHJlbWFpbmRlciBvZiB0aGlzIHBhdGNoc2V0Lg0KPiANCj4gQXMgdXN1
YWwsIGNvbW1lbnRzIGFuZCByZXZpZXdzIGFyZSB3ZWxjb21lLg0KPiANCj4NCg0KVGhpcyB3aG9s
ZSBzZXJpZXMgbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

