Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6D1C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0YxFTCSqHDaHUmAz2//heLd/v3N8bnrMlf0IEpCBEY=; b=mNa1wzzfgj6ZdV3N+nApcC3Yoy
	BvekD/qkZRlc4CkmKeDzxwt8ku1L/Ohd2Ooc5Su7IZqS8auorQ5lqu04BctA0w8AiGx+jbtz+RrHb
	jmlAfyeV3l59K4+tIdUQfNq5OIeZ2WO3UmgeSePWWW20LLrPp8jN2eI24UC3a3e5BnKsQLzcVmbUP
	m9UHjINjLFSjT5GM9DbkK29fC7Xg412ziYgQh1pUmgvfcp7g4UtGFZYIFmORAJQBwEvr4l6CKyhzt
	t33p2yvqx6opylBs1TnnKJjF6o/Iuw+VUOXVfzUyBccXDSlH81L6iGIrDH9xm5WRgDSofMC+HPk4+
	kyTvpDFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnbIX-00000006beC-1QPb;
	Fri, 22 Mar 2024 09:34:49 +0000
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2407::600] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnbIU-00000006bcM-1hFW
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 09:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9W/B2y9PLYmy2ghBZx83TYNKoSblUb/zVrZCOXeNkIG4W2PJUbh+VVIzq3u1Wfr6J+OPSz9ZDsz/hBmHD0OJteUZoWuMk9rnG2x9f/ksZYMSLeRLN5lBxuuxIDLlB16Aif3iNQN9q93FJCgbZ5Uvvzi9TmIT38nJUaV8bOx49YVi1K9h3oGIpwka/zWRLDkPkTU9ey85dBYoBiMUeMf0jDdzxlLgHWn4GBgzAARXCuQoQQHrC0DH/eXnxiKbnUigd9FBpZwpXG1eoyJhX1rMtqm4K6VH0Na3SSAlD50YNRSZcyiyVYTU1B6beC3cw7wHucLuXocsNO1BBy7MOeXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0YxFTCSqHDaHUmAz2//heLd/v3N8bnrMlf0IEpCBEY=;
 b=U2aDmxefhrU79nrtYBmRjNJBsa9EpfErtNhOwmdE8Xbulmja2tHjks5cyaeGZS6FCt1IxmCwH1jLl238YY9GCXQ7Eze3X9vtvRQvLqzF3POAtr6Sjc1/RSiLuGlDSpjE1dNiVsNGTbs5J7fZxNwZiLRkOxiONkipymPfpl+CaVulF7RparbaQ7kxF/wEW2/gRTlS8AeBEOW/+RhlQaf23CIAtiV0B33yOjm2Ohcb9zCuZDt0aHXv+LB6fP2JRZ+4h650z/e3tBIpJXRfqjHJLaahENYfwSIPuGj1MHHLqIsjgZrYTntUhKr0pzDHFdZwTzx7qG+0dZ10dSFTjKVOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0YxFTCSqHDaHUmAz2//heLd/v3N8bnrMlf0IEpCBEY=;
 b=BWzDl8KIpBlhAbyqNT276eedz7IIbtRyNyPfSJ+1/Iqyjd01xB7/7EnSqKjcCyuMRiHtumtjXKqeM5osPaD484Noz21wOnaAR+nMTPzQsOuLsaPQaoAsdcMYFe9iH+5Kl1mFtH7qd8tfS3qUTmqoAEqAVZn15AXbo/OoVNHb7AVNyYl4uX3yA2Rd7bSVQmL0k0uPYxUkfQEudxcIptDDSRGx10D3AwxLQy1HUPvEfq+qStp8hQ7BXGIZALMdDbQW60GzD9YKBmMTxQhCNm/PDNDDXmg2nB5w2pycD/J3yqBci6amsK4bLpl8WGU4xyA9y2nNbvvPk7zbWfcT3QMb1g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 09:34:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:34:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>
CC: Guixin Liu <kanie@linux.alibaba.com>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Thread-Topic: [PATCH v7 1/1] nvmet: support reservation feature
Thread-Index: AQHaVLbjkz0QMzGO+UKZIHEcqOuwNLEfFBgAgAAcSICAABCaAIAABVMAgAzzpYCAAY7vgIAADqcAgATLIQCAAj1AAIAAZ4YAgABoGoCAACIJAIAACzsAgADhQACAB+twgIAABa8AgAF75gCAAHoVgIACV3mAgADSQAA=
Date: Fri, 22 Mar 2024 09:34:36 +0000
Message-ID: <b3b90aa1-7026-4d58-9a3e-5c1ede800d94@nvidia.com>
References: <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
 <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
 <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
 <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com>
 <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com>
 <b691ccf2-3627-402c-bb68-eb3fc8845e41@linux.alibaba.com>
 <20240320015932.GA14551@lst.de>
 <ef50ec40-dc7f-42fd-b84d-c0842a8392b4@grimberg.me>
 <20240321210205.GC21139@lst.de>
In-Reply-To: <20240321210205.GC21139@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BY5PR12MB4116:EE_
x-ms-office365-filtering-correlation-id: 7925d775-eccd-4da0-b972-08dc4a534a16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9U9Ivks+iKyM0/iHnuldQOp0L45qStX+YI5lp/NJj9Lm8hA/Bqbd2BQh7krUmRFEjtzHMRqq9nQ6i7iRcttMuQyJl1bACYGDHI7tLj4KJbBYTebDun3PHEj9/lGg4czbXqqsHHRW4rxJQ59jmIVKlgRr7X2MkwbHIi7M3CrudRHgQxfbN+R651QlXqqtT6/2b1CPtiJxzwVktTXENX+dW/MIxQlgNrQ7XrdnCDZrLOx7SeUjImJyIWwkeYu/nBEfZzhTh5Q9uEBN2qi0GtuI4NWUzxfxkcejk1ncR1ONV82h42jcaUHg6p7Q2mvH9vdWySZkx/SReULS1VS4XG4+Lw5bEnQ9T4sQuMvaR9xSTdSqZB8U7bRY/Cu6WCgJXt1/2+3qBdbhxRF2HIInBNoELGlHRxRZKYp8Z5tvnKpgmibaJJY+jx0KEEanjoAkwCqMrMKOuNSJRW+eq3X4+2uD7REXW3dzCAq2Lubx+L81XgDMgttmYRNC2ZGse1sDo0QN2d2GAsWpKS5uv/+F7fGX2/G7yBdZjn2ZO63XUBGprUrZI203DkPbhtDWx+yFSxsYiU5LLAWSZtDsJpl3v2kQHLr2fJfqB6d+cfJXgrBrS70UCT0vHp5TOs//2Op50rw5DI3PV2CBHIGm+bg4EIuZ7OvLLF/+htFzGqqkUJX1PI3Xq2NNWAf1EpXcnPn/7iN/fihGmRoGWvkWmTUCZ3GC9EGGRyl96STk9uhqrSEqHQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d25ZWjVqckxHTWlvSUZRZGt2NThSc3E2eHpnSjdhaDRKYmxUU25weE1NR1Fj?=
 =?utf-8?B?RVVIZnJRbThjeHI4V0dXai9PTmtNaG0vRHVNSjg2Wk5IQjBaSFptSzlOOUdO?=
 =?utf-8?B?NDZiVm1WMWluZGVzVGU4ZUlVVHZrMElyMGRLU3QvMi84dHZ5THhYZUZxOTg5?=
 =?utf-8?B?VHJkdUt2Wk5lTlBJOVJsNU03MzBveVpqSTRqWUNkaXhLMisyMVp2VzRjYkNR?=
 =?utf-8?B?VzVzcjF4R1gvV2Vjc3pGYTFHbmZWK1FwVDd5VHFwTW9DaTBGZUo5a253K25n?=
 =?utf-8?B?bjNpMlVaSzV5ZU5mdEpuSUxVZmt3SEJEL0dqVkt0WkQrblhRS2hvWmFZY1Z5?=
 =?utf-8?B?K09PY3R2VnhQVWZ0bHp1SWlvdG9WcTU1SDRsR0lXbHp5cjM5T2gyaHgvR3JL?=
 =?utf-8?B?YjJQUDhMbmhaZGhxeEdPcC83TG9TZCtoc2ZmRzRpRGxhUForQ1JaeEhSMGVv?=
 =?utf-8?B?NlMwYzFZcWhRRFBJSzdYcXBvdVc3djFVVjZJOEVBRVJtWnp0L21zY09leDlu?=
 =?utf-8?B?K0htSXBKZDZENmpRcitmb3VsY2x4WW9zd09oc28zbGNudjlmWTVaa3N4UUcy?=
 =?utf-8?B?N3lCZG0vbjNsbFBlN0xOMFQxRW1qM3ExUGhsd09uZzFTbmJ1endhT3ZJMndy?=
 =?utf-8?B?S25HT05ubmpnOHdaNXVoVmtvV0hBZktWL1c4TWZqYVV3NUQ2aXBNYmpuQ1kv?=
 =?utf-8?B?MUViL3FFRE5iRTRNNEpBSTdyL2ZLS2tJSlJvQTNqV242ZHBuOE04L2QyVEJV?=
 =?utf-8?B?WTFuTUY5elo2SnhNQnNMcm96RTQyYXRHbnpjemNDb0xmcmFJS1dudUJmbjdB?=
 =?utf-8?B?bnE5ZWJBSGtNYVlYTnMya2hRb1oxTE1wazRjZjBvOGtlT2kxMWtuZE1SNXlO?=
 =?utf-8?B?NUw2a1JjQXFWemk4eFpmWUpBVTlwZjZVRGtkR25KKzhtellxVkJEL2ZXSm9h?=
 =?utf-8?B?dHNTNVh2d1lkYkptMEh1U0V0KytRaXVzOUpuS3dRbTJXMWhOc2dmeld4bjNF?=
 =?utf-8?B?dG43YW82VjFaVmhWZld3ZktXbTNsTmEyaGYyZlBpa2dtNGdpL04yaDkyUlFU?=
 =?utf-8?B?TzlOZ2F0UUVXMkQ0dWQzY3VlR3JxeXZ3QWpXeEdVWWVxS2E0Z1diZGxyMFFm?=
 =?utf-8?B?U09OREdLNmVpSWtxY0E0a3JLRHQ2RWxuL094aVphVGJyQjg1UUowQjE0VzIy?=
 =?utf-8?B?dzRTQ2F4NEg1aDVwdzhSMFJnQWx2dWYwdUMwQjR3UUNuNm4rWUhNNmtvcVJu?=
 =?utf-8?B?OUVnZlJCRDBQd2tzREpBUURHVjlROXNwcUYxSDhsaHc0NXRTckEyNG83Umxs?=
 =?utf-8?B?MC95SDhlQUtFT2pySlAyQXA4Vm83OXJuc3FRT292d2l6WDdjdkJIaWV3QjR5?=
 =?utf-8?B?QWtpSUMrQjNtT2ZuRmEvR3RxdTlIUnZvNWp2QzJMRWRzNE5za3hBdjQ3b1NK?=
 =?utf-8?B?YlFQRDBvRXVrcXBXWnZtTzAwWVlXei95WFVCMU1QNmhjVWNFcFRBZGZlMkRQ?=
 =?utf-8?B?RDgzeWtwUGhvMENQc096QmNiVmlaRW5kMjg0NHFYL0VLSDhwcU9odEI2RjNL?=
 =?utf-8?B?Z2dSZVIwdDZpUVAwNzB4R3puaTUyUjFmN3VVUmhoclE0N2xTUEE0Zi9PcTA3?=
 =?utf-8?B?MUxUNFY4MWY1R1hQYXZYdWZZbWYvWDJLazV0K1o1dkx0bXVUL0dvMlgzandN?=
 =?utf-8?B?OXdsSi9JUGxaSXQyWTFDaVBsMUhudmhBTTAwQ04yeDV5QTJJWlMxU0ZrdHdm?=
 =?utf-8?B?OU9hK3RnT1lzOE9zcHc2bG16V2plRUR2YXgwRVhoMWJDbkZLN01LMmkzbEtE?=
 =?utf-8?B?QjhkMk9QUUVGUytlazFBWDc2NTY4ZUVmMzdRU1VlMGV4Y2pNQnVhWVREb3lU?=
 =?utf-8?B?dnNlYk5FUTRSenVWRG9DdmVWVTQ1TnI2NXc4WWljWCtWK3BQOERGclR2WEFN?=
 =?utf-8?B?dWVmdmpPbnpJdHdnWUZUYlRRVTVpTXo0WXdjVEFNY2tvQVNFNTlmSHJ4YmZO?=
 =?utf-8?B?VDRYdXJ0V2hvT3BYK2VWTUc5cWhTY1pFVncxWWJ0R2hISHh2YmFXU3RHdk81?=
 =?utf-8?B?eU9ZcVArbytaS1ZTNk1QSUpCTXZ5SElBYmRtR1RjQ2JaWkpPQXlXaldtOUxW?=
 =?utf-8?B?Q1JDajQ3azV1NDAzRWhEdnlRYmpUZ1MyTktTYXVRZ0dQbkpheUc0QlJQL1FS?=
 =?utf-8?Q?6/fJ2RVx/w0WaTJEJl8xiq3mJ6tAmGv8JKhFIbz/mDML?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D3E2F1ADDF5B64687D7F5223BB457FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7925d775-eccd-4da0-b972-08dc4a534a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:34:36.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0gz463tEOqkrOLuQHS+9L79fooSRF2Odg53R9RGU5E29rWfEHp3IvkFfuc0nxjonQ69hlBpYBPB+B/2krfIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_023446_493964_501D4C66 
X-CRM114-Status: GOOD (  13.78  )
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

Q2hyaXN0b3BoLA0KDQpPbiAzLzIxLzIwMjQgMjowMiBQTSwgaGNoQGxzdC5kZSB3cm90ZToNCj4g
T24gV2VkLCBNYXIgMjAsIDIwMjQgYXQgMTE6MTY6MjlBTSArMDIwMCwgU2FnaSBHcmltYmVyZyB3
cm90ZToNCj4+IFRoYXQncyBhIG5lYXQgaWRlYSwgd2UgYWxzbyBoYXZlIGZpbGUgdG8gdGhpbmsg
YWJvdXQgdGhvdWdoLg0KPiANCj4gSW5kZWVkLiAgSXQgc3RpbGwgd291bGQgYmUgZ29vZCB0byBh
dm9pZCB0aGUgZXh0cmEgb3ZlcmhlYWQgd2hlbiBub3QNCj4gbmVlZGVkLCB0aG91Z2guDQoNCkkg
c3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCBob3cgdGhpcyBzb2x2ZXMgdGhlIGNhc2UgZm9yIGZpbGUg
YmFjay1lbmQgPw0KY2FuIHlvdSBwbGVhc2UgZXhwbGFpbiBpbiBkZXRhaWwgPw0KDQphcyBmYXIg
YXMgSSBjYW4gdGhlcmUgaXMgbm8gZXF1aXZhbGVudCBwcm92aXNpb24gdGhhdCB3ZSBjYW4gdXNl
IGZvcg0KZmlsZSBiYWNrLWVuZCBhcyB5b3UgaGF2ZSBzdWdnZXN0ZWQgZm9yIGJsb2NrIChiaW8v
YmxrLW1xKWJhY2stZW5kLA0KaWYgdGhlcmUgaXMgY2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBzb21l
IGRldGFpbHMgPw0KDQpJbiBjYXNlIHRoZXJlIGlzIG5vIHN1Y2ggcHJvdmlzaW9uLCBob3cgZG8g
eW91IHNlZSBmaWxlIGJhY2tlbmRzIHRvDQpoYW5kbGUgdGhpcyBjYXNlID8gcGVyaGFwcyB5b3Ug
YXJlIHJlZmVycmluZyB0byB1c2UgYWJvdmUgc3VnZ2VzdGVkDQptZWNoYW5pc20gZm9yIGJsb2Nr
IGJhY2tlbmQgYW5kIGltcGxlbWVudCBwZXJjcHUtcmVmIHRvIGZvciBmaWxlIG9ubHkNCmJhY2tl
bmQgc28gd2UgY2FuIGtlZXAgdGhlIGNvZGUgY2xlYW4gZm9yIGJpbyBhbmQgcGFzc3RocnUgYmFj
ay1lbmQgdnMNCmZpbGUgYmFjay1lbmQgPw0KDQotY2sNCg0KDQo=

