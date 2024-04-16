Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D2BC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 03:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gwp+9UClLu6NMPPxmzqvRHvDm4QS4bvhlP18nwpj3Y4=; b=YfahsnZzB+Zh/N3G7HxVXfpyFT
	QbXew4ljS+oQhyhSCQO2U0PDF+7WckqDx7M8VUgPVFym9Q3spVb+6ZpPw6UuVTOzV4wEAUB9lR0ci
	giDyaNntZG0CYx79ehZcu7HuX8fEm7I2dk46TcoXSrS1g4YGNDwvSfDTv/pyBsNH08VMmmYsvNbHm
	Qh1pUGs3gXqvUOoJeHEyp7Nm+jWP7mHSYiumKVdmvgQPgYYzSYOAvpM+EJtKGcNeKfZgkSEazOHg2
	YBIU9YxdE8K8Q3Rh7Sj+KwdauLztsovLAMAhnSwtHPJDvxzfP9pXS21GgcxKrzQ4oQ0yqiFc1uTjL
	/L/Ub+Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZtG-0000000AiX4-3lMI;
	Tue, 16 Apr 2024 03:53:50 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2415::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZtD-0000000AiWO-30p9
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 03:53:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9uvv3i1vR0zCdV5BdfZ9OQpVVgJ45C1nEMqXCnqIxUUW9WR7W9GzA65+W8GqTF61jBtO9dvhFNY/vfTExEXJGrS47cF1SNQwFSidX56Mmw0fsiyi52pbovKMjGple643Z11IQW9B8jq7EV3gbEZhm2/fl/Zg6AXiqKi1QpYfT4Uu1GViWjNVWp3Azt4xFIyOSgdb1Arfw514NYMxukS+3Z4pPYLf98CQwYX8Yh6uaTW75WAM7mMz4P8TVs81h3dawy+ZEgvAMYsQHCt5yMGIrYI9xSQ3ane4ZCaBryraKseujEw2ACbokGUX8uKMj1sLotbtOuphpbhFMBeE5J1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwp+9UClLu6NMPPxmzqvRHvDm4QS4bvhlP18nwpj3Y4=;
 b=CGY28EQOSJw8LDWbRf8NdgCSBiPNnLmkNk2ACjhtfkswrHbgNqy06D7sWL0+063i7ly7ZuzNSC8hGOB8BwtUQQI8cfdO2d/Q3KYVUr2hqoEiUKoUsNZa6bkreDrUYSVggobwSUFbQzjK+7e6zixj/p/u2g67/nhlqz/eBo3+w+HYqF2nVl/OXufiPXvFyozhyG+LljgavQioPi9m/ST6aPgpSYOkUW324FQZGcZGW37sTAlA8b0p9GC9PWdTSYxmUmgARa2uP8TGi/n0meFaJ6UYox7bp2gVAQK/gbsrsIeqAJ0+J8cUk1d3RlrUkHYEwluMBw9IlDxeXTQCTEKpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwp+9UClLu6NMPPxmzqvRHvDm4QS4bvhlP18nwpj3Y4=;
 b=Mz3m6mGEFgjwT5RqTtKQsqxsvCMAh8d0dCTiX91aaOmu99kSgx2bKLN4POiE2Q0lHdl8m8+G4AmZXuqKPP0UJSx0PYRTy0t7YV7SZli0glklkpXEJuv2kNEFQyhtmtc142J4a8F+TMbCeQhMrXp4EOSfJHWozMII1kX6DTJiriAXd4WAFgRcL4g35umE55hoQ9VCg9tCj3eUSvthc9QjgOERyRlyeGnHjbyUAp48aN67a67ui1crSAObYEc5Av0XFmpFvuJ4fvvy56NTjxL9N+WxwIgGUcadk1FP9Af6czgABECIRo4xlJqhmoqL/+pcusTyuwKPS0I99n81noF/YQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 03:53:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:53:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hare@suse.de" <hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/3] nvme-fabrics: add post connect auth code helper
Thread-Topic: [PATCH 0/3] nvme-fabrics: add post connect auth code helper
Thread-Index: AQHaWleHSwGRjK9xZ0u7skhDOgpuirFqrpgA
Date: Tue, 16 Apr 2024 03:53:28 +0000
Message-ID: <e8a819fd-3e40-47dc-8ad1-1932d7a271e3@nvidia.com>
References: <20240208062427.31255-1-kch@nvidia.com>
In-Reply-To: <20240208062427.31255-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB7090:EE_
x-ms-office365-filtering-correlation-id: 0ab67d21-bbe7-44f0-55ab-08dc5dc8c697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjDpX8G+IVgGV6PMdZzkakr5ntRf+DHu+XWJH14lQv5yyG8/ofH9Vrfv6OiXFMpLtKtVWgTVZWgnjG60/svocOFY+S6d8oHo9PDeTTqPew5k78wHwNityWVLIQPncT7m/ILumXtxLGEDcTc2ZB9dWMfKoIYvqeK63rcZZYsKjJ5HePrALIKxb7orYAYXBkEXPCqmDySYhff535K9k9oDTevngl20CxwtQk0ztVBCviMAuIKugjK2wIn76uxTlMGoUdU/xS6arKMLHAmSNW9CwlTiQprWhrLDsR3wWusJzGTD15WxkHGCVmbe8+1CWhVfy0AdtF9XedZAm0cRgIB2Sej7hAa85DzlPyH1rqxmERgfANqb5bQjHFA6O/82LPLPm0VEgtOCu998WR2EroFJacxcNLySvE2q1dGMkt0Q9aDMHxESXBfVUkDPkVlxdhAqKB6LsnbhYlYuUKG8t9Mbabh5ErDTq21KxlWf+zKQmS9YLz4B7hlaivM7CDNKevJi5r4bh9SNy+56yRBmpe2QnwkuqkdJORlzZcpx9RkfwuI6diznF2jkz7dsOyadvGSNs8lYifK3rkXTUwlUCFUrWMjURchddNIyMMEibjitYYVrbIhMJz8e9jvoAHCyRLBdqa3rBnCaaIAX4ulJkW8g0NCmQWJQsjIZILxPhSyoa0t8aFVeIbX/DWrAWdKmC04uqGzC5Xp5iug0wnuGHe/W1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDZYZnpiM054ZzRpWmF4cWs4cEZIc0pRRG1QSFhpMU5GUGphUXJ2cXVBVFFT?=
 =?utf-8?B?MDcyUWxKdUZJbUdzdW1ZaCtkY29YNmcxT3VhaDloYzRCVzgrdXZ1REhpK2Y4?=
 =?utf-8?B?c2IybHRiVE1STlovUS9DNlRVck01ZHRHbldpQys0WUFLYXROS0RjcHJWbmR3?=
 =?utf-8?B?ZnBPU3E4RXVPY1hHTnBhTmE0MFlzeTRpUHhhR0ZUejRjQjliRDFudHd1cXRW?=
 =?utf-8?B?VERpT0tVbEI4dzh4UDBIbXZkVElQTFc5L1NnNTdOR3FHOUZKc3VzYWoyYjFs?=
 =?utf-8?B?b1ZaVUdFaFpMWnF0clgxd2tmcHdobnFQZ0xHbHVGY1FKWHNlMzVNNVRwSDRS?=
 =?utf-8?B?NEdyeVhyVzVxRzM3WGx5VkpmUmJJTldvSGQrWklpV2JicWdNQlNYTUJEcjhi?=
 =?utf-8?B?ZW1rSFFibHBoZzc1WEorcWVteDZqdGZKb3I0UkZqeWo5VEZWbitxSW9SWTJQ?=
 =?utf-8?B?RU5uelVMakljeWdQN0JKVG9oNGxYc05Pc2JuMGl6V3lleEUzMWFNeVV4aitD?=
 =?utf-8?B?SlhVUzloVjFDeVlwMzBxK2owazNUdnlEd0VUOXJDU1REZklqbDRwZjRadmQ1?=
 =?utf-8?B?R3RxS29OUlVnckpiRHluQUlvYVBaa2NlUFhmTDA1ZVgrUXFwR21wcWxKVHdv?=
 =?utf-8?B?TS9qeHZsYW45YWw4R084MU1VR2R5TWd5QXJYQ2dlVDR3R3doT1VGN09MMlMy?=
 =?utf-8?B?dWNEOEkwbEp6V1Q5ak9WMFdROFF5SU9QUWNzemE4UVc1c1htV2FXSFhFdVdL?=
 =?utf-8?B?RWMrUlpWLzl0YWtkaFpDaHNDWFB4elVjVU4wZlc5WnpFZWgwQitUU21KaEJL?=
 =?utf-8?B?N05iek1Gd2kzWkJvU2hnV3hzTXk3SERJSFJyTmUvMjhUNlJ0UjNCTzAxemR5?=
 =?utf-8?B?YXVhSjBMdTc1ako4QUc5dnZVVVo1VHlHcDcycjlQMGUyb0p6V2YvVWxRYUs4?=
 =?utf-8?B?NVRHblVrVmtSdFdxKzU4UThhMFJMMHVFaDhob3daQVZsZ2xTdDFtUUlqcEUx?=
 =?utf-8?B?dkZicHRWYUlNUWdXODNESUZHRkM5aG1vTVNPb1dWNDQ5bHovWnhJNlY5aElB?=
 =?utf-8?B?c1Zzanc2bE55ME1Xakhydk93NFNWUU01d2tsTU5va1Vua3pSN1BicWxvMGIw?=
 =?utf-8?B?ZDhKbE50cU1vWXZXRnlRWFhUbmJScUtSSGlMMjdiaHFxY1Z1d0ZGSGNPcU02?=
 =?utf-8?B?OVBDUlAvekxUTU9DQlRCclMwWm13MXRlRXdzTzg0V2xHNm9aTDZIWW5VK0VK?=
 =?utf-8?B?TWFTZUFrS0c4V0N3cGFQQkVhNXoyRDI5U1JkSFZUdCtsSDU0Ykh0YmFOTzZs?=
 =?utf-8?B?d3NzcHVMWnl3bGI0ZEhhNklNQUlqSDJKZ0hwODhGQUhzT2pmSUcxRzhVSUNL?=
 =?utf-8?B?MFVPM1d5ZGpHa1JHdmt3Y0tMZVVxRTYvZjBQZGMwYXBGT2xBeWQ2c1hCNW5w?=
 =?utf-8?B?UUhwSVlRQjJSelNVenRJd1pnNUcxSmh0VExkN2IrOHh4U2VmUHZOYjh3R0Ix?=
 =?utf-8?B?cjJ5d05lNGh6RDVwOGlmcElWdWhQUGpmN2dTT2RVbFczNnNVQzVtbVZrSHhw?=
 =?utf-8?B?dDJWN2tzV0dsWnhtcENPcndwZHZMNnhiUktHdEdKblErdUtyUnM0VjBpNms2?=
 =?utf-8?B?RWNadDJqYlVNUTF0SWEzUDhrdEY5blBpNDVYSW5ZMktZSER4V0h3bi85QU5O?=
 =?utf-8?B?c2VCUGlvVXVaQWo4ZVdTeDhrR0d3THhoSGZoQUtUenJrT3MxV0lSdVBMV3dz?=
 =?utf-8?B?VUdWNUk2M2VYSmtwWjJYemdibnl6eXNjMVdkT3U4WFc1QUxEK0dCMkNZMHU1?=
 =?utf-8?B?OW5yaFBqeEM3OGhIVnp3TTZhSU1pK21xMmZ0RVpDYWtTbUxCNTdNUDdrVCtm?=
 =?utf-8?B?WTg5d0h5RFVxb25aK3E2TlBjTWlLdEVZWk1DNTdYMEFNeThDK3E2SVRUVmx4?=
 =?utf-8?B?OE45RzZzeFJWWENUbk1WZEUvTXAyNFNMbmlLTHF6eU5zRklGWFp2WDVsTTFL?=
 =?utf-8?B?REJJZ2NLYnNEbVJ6RHR4RytmWFN6S2ROM2g5cTQzVW00UjNDS1dQYXBDdVZ2?=
 =?utf-8?B?ZmhFbEF6UlQ1KzJDUEhLc3NwOUZHRFNDYkdkZkxXcllhZmZ0UU4xdVQva3RH?=
 =?utf-8?B?cVJNZEttaUh2MWcvOHcvdzE5MkhTTnZVK2Nwc3AydWwwdkUvRHV0QURvajFC?=
 =?utf-8?Q?3nrprlsbnR3HRG4GZOHHs9ww0q115iQ6pi92MjpY+jH7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25F76EFF12B40647984AA1DB7825E12C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab67d21-bbe7-44f0-55ab-08dc5dc8c697
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 03:53:28.6270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsEdYwFVdp5r+6IsvafsnoWhL+AQO4qIQzZK7TNxoe79mYcBlhRVTFdRkSaN82M22aE237XOXaOzIgwK88PmBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_205347_860328_A54886E5 
X-CRM114-Status: GOOD (  16.19  )
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

T24gMi83LzI0IDIyOjI0LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IEhpLA0KPg0KPiBQ
b3N0IGNvbm5lY3QgY29tbWFuZCBhdXRoZW50aWNhdGlvbiBoYW5kbGluZyBjb2RlIGlzIHJlcGVh
dGVkIGludG8gaW4NCj4gbnZtZl9jb25uZWN0X2FkbWluX3F1ZXVlKCkgYW5kIG52bWZfY29ubmVj
dF9pb19xdWV1ZSgpLiBNb3Jlb3ZlciB0aGlzDQo+IGNvZGUgYWN0dWxseSBiZWxvbmdzIHRvIGF1
dGhlbnRpY2F0aW9uIGFuZCBzaG91bGQgbm90IGJlIGEgcGFydCBvZg0KPiBjb21tb24gY29kZS4N
Cj4NCj4gQWRkIGEgaGVscGVyIHRvIGhhbmRsZSBwb3N0IGNvbm5lY3QgY29tbWFuZCBhdXRoZW50
aWNhdGlvbi4gVXNlIHRoZQ0KPiBzYW1lIGhlbHBlciBpbiBudm1mX2Nvbm5lY3RfW2FkbWlufGlv
XV9xdWV1ZSgpLiBUaGlzIGFsc28gcmVtb3Zlcw0KPiBhdXRoZW50aWNhdGlvbiBzcGVjaWZpYyBj
b2RlIGZyb20gYSBidWlsZCB3aGVyZSBhdXRoZW50aWNhdGlvbiBmZWF0dXJlDQo+IGlzIG5vdCBj
b25maWd1cmVkLg0KPg0KPiBJJ3ZlIHRlc3RlZCB0aGUgY29kZSB3aXRoIGFuZCB3aXRob3V0IE5W
TUVfQVVUSCBjb25maWd1cmVkIHdpdGggYmxrdGVzdHMNCj4gdGhleSBhcmUgcGFzc2luZy4gQmVs
b3cgaXMgYSBkZXRhaWxlZCBsb2cuDQo+DQo+IC1jaw0KPg0KPiBDaGFpdGFueWEgS3Vsa2Fybmkg
KDMpOg0KPiAgICBudm1lLWZhYnJpY3M6IGZhY3RvciBvdXQgYXV0aCBjb2RlIGludG8gaGVscGVy
DQo+ICAgIG52bWUtZmFicmljczogdXNlIHBvc3QgY29ubmVjdCBhdXRoIGhlbHBlcg0KPiAgICBu
dm1lLWF1dGg6IHVuZXhwb3J0IG5lZ290aWF0ZSBhbmQgd2FpdCBmdW5jdGlvbnMNCj4NCj4gICBk
cml2ZXJzL252bWUvaG9zdC9hdXRoLmMgICAgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysr
LS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jIHwgNTAgKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAgICB8
IDE2ICsrKysrKy0tLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwg
NjEgZGVsZXRpb25zKC0pDQo+DQo+DQoNCkNhbiBzb21lb25lIHBsZWFzZSBsb29rIGludG8gdGhp
cyBzZXJpZXMgPyB0aGlzIHJlbW92ZSB1bm5lY2Vzc2FyeSBjb2RlDQpzaXR0aW5nIGluIHRoZSBm
YWJyaWNzIHRoYXQgc2hvdWxkIGJlIGEgcGFydCBvZiBhdXRoZW50aWNhdGlvbiAuLi4NCg0KLWNr
DQoNCg0K

