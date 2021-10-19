Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:29:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94805610A1
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94805610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnwPuULIYJCESzgyPFzuXRgu/a8OtjpFTr5zNClAGC0=; b=KPcaiD1livm7oCsLqCS/SwgXi6
	bCLgtmDb7V/gadA8Z06FtNWTbRvI5o3PQlzN7kyHdgbbDiyEPeWOa15nMxJuTWcf/tdiZ8UXI06/v
	EVMUaDvsz+0RRfKyNpkTMndbw4hkSDRnwD4uWkYHbTtHgh8whY6uI7PrSAZ9A9W6RQy5DVy3IyT2T
	xPfGGl6N0DZDgcgGUTukEcEQzFkjl32bSf5iMuXYY14M0CEYnKsTUxTN8dRJ6ykcPQC6AK2M7VEdv
	vU4ER2MzL7duUScBIIob+jr8X/Y2kujwwm050fBJUTXUyihyWkmgwAQHdpbyP9xM5c2UfRg/qWnbI
	QW2J0wIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcicU-000I52-9y; Tue, 19 Oct 2021 06:29:06 +0000
Received: from mail-bn1nam07on2065.outbound.protection.outlook.com
 ([40.107.212.65] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcicR-000I4A-IV
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 06:29:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8nQujJhfhmAgPXGkxFYd8YlniXcW0jQ2bQKW8z82mD8IOtbp+xakBeoYdTka7FZ+V0L7tU+71m4lKDRSsDQtW0ao+wI3b1LOvi3qmbqrvkG5KP6N9MpzFHrjZHOAgHlE9kvhZQw7hvQ9kVQSD3Pei1sFJ0G/bv+PiRxg82c573K6piUxr5pBuD0KRxF06GAu8428j1srXP/4vkkc0nKo6YZKBm58BLdyYuMJbFS7HBf1J6rBFKMGsLPQ5PIJ1awkuqu09jiJU5/t/JWVVh5yAnBfM32mO0vvBBcvO4oMd5P04+4blrn9DURuty/JZ0n3x5fJhnLxc3WNDHFN883og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnwPuULIYJCESzgyPFzuXRgu/a8OtjpFTr5zNClAGC0=;
 b=g3TbFpvLgRVMYmbPo3nbapNZPH8K0Bfob0bg+72xqP1TDW0FApyfcOowuYTPb1RTNDHHWMFm7TMQLGwF+6AcPidS/k/rikf3+5haNqPDU+sy0RL7m0Tz/enOGtK1D+e44oSI3Zz5Wcp69o1t1aN45GXwPds7Gixi8N+i5m0bGWzdW1eDKzO1rgjXRLyLLjMEMHWDH57CxKMwMX6iJ0vCgErxsyafYOG/s+a+sB/mnbrz9B0YfEW3FgpqKbHgSQhZ6PiORdov/0OxYxDn1sUOrDeFmYY6G6e1WLWjkdJe6I/WTPZYsWIdzjm5s0NkFNsjRAbjWF7BcFh/pUB2oMUw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnwPuULIYJCESzgyPFzuXRgu/a8OtjpFTr5zNClAGC0=;
 b=LeQRosYjMFzYkOjHuJSN0VZWt0/EBtBHDXQ/9oQCfEvf+e3NFpPGpjAHPeCKBj0QoyofuXSqcp+Ou7kQ4aw0SFksz2FuxZ2fl1QORbE7UKT5FKrJnmK/AIccE6EoGV6f0lki0MA+r4cXJ64FMaHpv4N5dKnRcM8THOr3g9z2NfeOhXSoM7VnRlOmFtKSeyRIyMJYUi5WBai53eiViqD/iV35wVCh+hR897Kfuv8gW4AlsPpUcizPD3k/WTrhmiFr/NAaCbfDZpMcbFparUULriXc0tyBUoLoOmScsGwaIOsxbXhqpTge/ZuwcGToMCK/x+QPSDiiH4rEOcIglcCuzg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0014.namprd12.prod.outlook.com (2603:10b6:300:e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 06:29:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:29:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: Israel Rukshin <israelr@nvidia.com>, Oren Duer <oren@nvidia.com>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH 5/7] nvme/nvme-fabrics: introduce nvmf_error_recovery_work
 API
Thread-Topic: [PATCH 5/7] nvme/nvme-fabrics: introduce
 nvmf_error_recovery_work API
Thread-Index: AQHXxCXHxtq4h2w5wka3O/USKcZB0KvZ3OgA
Date: Tue, 19 Oct 2021 06:29:00 +0000
Message-ID: <aef175e7-7f0b-ca7d-7dd1-7c0bd730a445@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-6-mgurtovoy@nvidia.com>
In-Reply-To: <20211018134020.33838-6-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66773a29-1958-408d-7ba7-08d992c9bd01
x-ms-traffictypediagnostic: MWHPR1201MB0014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB001424174AD119BFCB9A4CDFA3BD9@MWHPR1201MB0014.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3f22etQ1gD7XHkZ9lM/NJ/MV/3R4MdN7mP6i/xRONhq7/mUfKAlYzZtOsIFzaEAcA2NVwkSh+pqc9Y7Zf3A0vlH30CPhNrdH3SzGcKMCgf6cA7R+y1eokDoJh7A38HlqL4bCxyaJ6BcDwcE5I2UsJg1jlG7tTRysqeoXPykK4AQcLxw8AYywhkDjWpsYs6zlesOYG610w/Omprwpad2SC95LXFeoput86/nZHE0ePcScocEkFYAQw4kMwzvACAgUtdMWGxV326wQ6NPDl+xcA2DIGKJJpkIcouAIcdeO04gfn5kyBSBOxHR9rJBptuX/H8JBa1Kyw9cV9OJMQkXn1oGZ5zkk+Xkk19AKslBKYSz7HuS9LSmD0pfU200Op4sxknUXpAZIVB6SueeSClzJYDBzMvbJPWhTjsNKIG6BbdmAkxYpyNzjAzlkqTXhG4mwUZmIXdU0UlU9xVpKaZGU/fZk9KJKpyTlj0DhGBa9G2+30njOgp+xi/zN9W10rZP1nwZDFYqSYtxCrEGSOesZ5ZjtY/oUsr+rFXZn9g6XNZC1gL4kpyKqI8W9rMME5adDxGTJHUrP1vKsd7GeI7RC1N79PPpY/CqiS5h745R0CspIlyLqupV1v40JACwUqLZ8c5OZh+D1A0KRDkttp2SpRM7Meir5L3BGIsDv6tt3MUXVeD7ztUjJ+8XxeXHbPtGOjt3SodOglz9ffbVajBQNv13g9dVIRXio3d9TuLtIaXHzsCxNcfioc0nygFIdo5vLhyidmasITBzpNxq2yHaGpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(6506007)(5660300002)(4326008)(54906003)(110136005)(316002)(71200400001)(4744005)(66556008)(38070700005)(122000001)(36756003)(31696002)(6486002)(31686004)(86362001)(2906002)(2616005)(6512007)(38100700002)(8676002)(508600001)(186003)(8936002)(76116006)(53546011)(66476007)(64756008)(91956017)(66946007)(66446008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlU3aG50ZzNXQVpBYjNiMjVjVnY4cHBLbWJmRHJmTlArTEJZbFJyUWNSTyto?=
 =?utf-8?B?KzhRejFKRktQY3JJbE9DbUJ5aDFneVhwUVpVTHd3ZUpTV0l5QllXOWhwazVR?=
 =?utf-8?B?WVljdG9RejAvbWVBSTlDTGZxd2tESFdTR2ZlV2cyUGVpMEZzVUFWYUEvWDNJ?=
 =?utf-8?B?cm9TczBWdmkyVVU2VnZhekJVR0hxWGN2VnRwM2I3WmZ4SW9TelVvYnBjVEcx?=
 =?utf-8?B?a3c4VnQrRHE5MzlEWW9KR3Y4NUlCZlMwNitvM3V5L1pQMkpORElxM2pRTStn?=
 =?utf-8?B?bFQzcnJxclIvWWpMbXYyTDllS2lYMlVmU1V5WXBuaDAvMDdMNU5VRHplR2ts?=
 =?utf-8?B?WU5keG1GR0RUaVM0MEdnd01ySDJPZGFtYjAvZG9xS2htZzU0dEtVV2l6cXM2?=
 =?utf-8?B?NTV0bFFySk45dTJOS2JBNWMzcFMrVzNFQTlrNzdnMG5mY24vQlhoanNhTkZu?=
 =?utf-8?B?VU80eENyeVBEeGd0WUs4cCs3TWhEeGdaWWQzSjI5Q2RqQkVJR1JDS28wMEtl?=
 =?utf-8?B?SjFtYkRFRDhyQzZiU2NZbmRWOGJBMnBwTVNSN2VpV1hSVG1SMWRmY29GaUht?=
 =?utf-8?B?QXVmQ2dXSXU1U1dEWlJCdk1KaUR4NExDNFVWNGFWT3NWbUNnSGxoNm1ydXZN?=
 =?utf-8?B?VFNJMzJyNmdHbnlUR3Q0YVZjalVxQXBCMTJVZHZhamJKVXZRR0t4bEhNSHBU?=
 =?utf-8?B?a2lqdTBrdDlzdkNOU1ZRTWE5MjlRVEo3aWtHMXpMdUpFMmN0NGdWVVNrYW4y?=
 =?utf-8?B?SFRFdUYydGVicnkzMUlDelFBd0NId1VqYnBiSDEvUXI5VElVYWgxMW4rTWdl?=
 =?utf-8?B?K0tpQitYS3VkR3czemVwazNXV29LRWJkZW1sT3grSHRBQzdjUkl5dk5CREZu?=
 =?utf-8?B?QnI3aUtBZkh1b3owN0s1M2p3dmFxcVdKbkp1WkRRVnZHTDZVMWhXSEs2Qjl4?=
 =?utf-8?B?QURuNGxyaXZjbjYyYUoxNmNvMjRaWkVka3VHNlUwa2prcTRObEI3NFkxbVZL?=
 =?utf-8?B?ZVhMQXp5OTdFVk1QYUl5TnI4WTFhWnN5Rzd6QnNaZXNucXUxZ20xbXJ2ZHAx?=
 =?utf-8?B?ZXh4cXVQRXBiVkdIVllteEtJTEcrdDViV2owTmppL2JBMHBERkw5cGhMc2R5?=
 =?utf-8?B?SEYxRWF2dkk3dEM4RjRjam96NzByUGd4RUJZS2ZSbDN5andnL1ZIUlpYU0lB?=
 =?utf-8?B?ZXlyOWNod2ROd2E4cTZQWEVzTWg2NGpBS2d1b0tEeVBKN2xEd0Vhc2dKY0RS?=
 =?utf-8?B?Znh4YTVnOGtsUitObk9tU29CU25hM1NwYzhhWVoxbHRlS2ErZVo5T1ZkTlUy?=
 =?utf-8?B?SFdadkFmQWc1eFI2Z2hSVFB0OFBId05rc1loMitGVDdJTEQvT0QvaDRVK0tQ?=
 =?utf-8?B?Wjh5aWo3TzJaVDhMRGlmcGQ2d1NqNHNuQnF4bnRoWitZRlBIWTNXSy9tVDlH?=
 =?utf-8?B?RFRxczhpeXFmdVdnd2JtaHcrN0VzVG5TYUJ3bzJ4dS9FMG5nYk56QjFFaTlX?=
 =?utf-8?B?alI2aXZ1VzVVQ1hVa0xqUlREZUpBQVIxVWt4bTY0cGRyL0lscDJ5RFNhdmpS?=
 =?utf-8?B?Z1MwYnBtWFJGV0JFL2xkUzkyMkFNVHF5NVZ2LzZWWDZscGZDaW9EK2ZwaUEx?=
 =?utf-8?B?VTc2U1IzMXl4YjRQdHZzK1NBQ1JtdVJnVEtlQ2RIWXJFUE1HNGlCa3ZkeXU0?=
 =?utf-8?B?YlZTNlI3bHNkNGRHbkpqSzV1eFYvYnhBVjYzVVpuMmJDTHR0WkVNcUNxNmxv?=
 =?utf-8?B?U2VqYm8vdnBPVnhTM0h3YSt4OXdXRFNyeGYyKzA1WVYvZlhJZXpGNldzSk1M?=
 =?utf-8?B?TWt1TVFuQnR4TC9LcnhoeTNZMkJNM0N6THlLaGJ0b3V1OG1rcEcrRmxrV244?=
 =?utf-8?Q?Xqv8pssfFwDP2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CC408AC5B032449856A9E4F86A4DC55@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66773a29-1958-408d-7ba7-08d992c9bd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:29:00.5179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /AXmc+PGYDXvarMUiS8HbvBgznWGN5h6fKl961Z+4Tx/VLWvn77n1h7PUC/QjrsLLCvsy35VcVWMKrYQum2ukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0014
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_232903_639925_C37B3834 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
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

T24gMTAvMTgvMjAyMSA2OjQwIEFNLCBNYXggR3VydG92b3kgd3JvdGU6DQo+IEVycm9yIHJlY292
ZXJ5IHdvcmsgaXMgZHVwbGljYXRlZCBpbiBSRE1BIGFuZCBUQ1AgdHJhbnNwb3J0cy4gTW92ZSB0
aGlzDQo+IGxvZ2ljIHRvIGNvbW1vbiBjb2RlLiBGb3IgdGhhdCwgaW50cm9kdWNlIDIgbmV3IGN0
cmwgb3BzIHRvIHRlYXJkb3duIElPDQo+IGFuZCBhZG1pbiBxdWV1ZS4NCj4gDQo+IEFsc28gdXBk
YXRlIHRoZSBSRE1BL1RDUCB0cmFuc3BvcnQgZHJpdmVycyB0byB1c2UgdGhpcyBBUEkgYW5kIHJl
bW92ZQ0KPiB0aGUgZHVwbGljYXRlZCBjb2RlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IElzcmFlbCBS
dWtzaGluIDxpc3JhZWxyQG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3Zv
eSA8bWd1cnRvdm95QG52aWRpYS5jb20+DQo+IC0tLQ0KDQoNCkkgZGlkbid0IGxpa2UgdGhlIG9k
ZCBjb252ZW50aW9uIl9udm1lIiwgc2luY2Ugd2UgYXJlIHVuZGVyIHRpbWUgY3J1bmNoIDotDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==

