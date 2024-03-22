Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A65C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQBt0BRNHZWrgog/JVTkYOq+WPoC3L7OkJXIWgL49gE=; b=sTLbFFn0TA/jU9dVKgCDbLBb9s
	iSU7Dmj+pz7BsyOPHNxzv7cAhtZ6n8ms0aF90z6gQp1Sv8rJo8IzunfSvsgDr01cSZ/3pGt3tBRSn
	OtfXG0EvqgsstoSVEEqCvwSPTJaXO4MidJPkRAKwJJUIkWz9e+TM09YLIid7KMlle2Ck9FdUuMvpX
	7/TeUaFNy4LqnrzxnXuZb/kNTIfWJj/Yf2WithqBDa8YJAhQbspSzyDodGMHqaxK7jKIdmMvtFAhY
	Ymr0/aCaNtpM99PoxrzorohzKOHEQiIO1EeCx3ruvRciLhsvtlvYJ2kX+ialTw2zDYJjRbAEw36tN
	GOBQCvjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnbRJ-00000006dtg-287z;
	Fri, 22 Mar 2024 09:43:53 +0000
Received: from mail-dm6nam10on20611.outbound.protection.outlook.com ([2a01:111:f400:7e88::611] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnbRF-00000006dpx-2rSp
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 09:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SznZ2NXwcxN3V0d9vW7sXRJKeA5PI8bqulMd4wL4RNtPsigaQ0e3Xf4rl2F3euj93ffvX/vXGxfSkK0Su4KNoJogCRrkAYej1i4ivaoP4QiUZJQDOyk9Neox1oMLlAVzL+FhqOHzPWYlDR0885iFTi+UVWUzvexn6M1QvoxNAk4c/WI+WYtJPwCLIHGlzlqj0jMG7djYjZjkpsJwW8PZyUmPfsyg2L8NS0ONrw67zYjvMybJOfGZni1SPBghRYOVKV5LfwYkRWeQroc3YpCDPzFXuYe4qyiI8/12KPkNscNWKbqKq8pfR4WIteDzsHGmlK29xCaEFaFIUcG7OYkV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQBt0BRNHZWrgog/JVTkYOq+WPoC3L7OkJXIWgL49gE=;
 b=duObMB2/Gjw2CdrEeotmk7ouQI+dLGyU7Nq31cn3Nf3F6jTcOEzINEMgy7zCP6ig+7rpac1t44ChyVxAut5JyYU9Xj+kKvW6Vii1+3Nlmh3gEz/m069+K2HikPzj7BuQLaWaA6oipqXJ3lNPCTbAdtRK9aslO0muKEWLxG6u5wwzT+zwI00rf7cyGb7g21uafok6LU9BqeQxWIiyq+fMiRuvSZx1Gw9hJWmgiK8sDBnzk9XEKjpVW9eqDei4cW1v1UwcvRt0hg4Mf0unFEMSSJwVsy9XhZ+nm2WA7jjgzvtYu6HtuTkpZ9/amcdLvrU7Nychduw0iJXXcSK1LpbH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQBt0BRNHZWrgog/JVTkYOq+WPoC3L7OkJXIWgL49gE=;
 b=D4W6ppswyhxE9Kr6lbCN9DQ0wSRx1fwx0gVSnMYpUM/KjYk6jkrQP2x8gYgB5KmS00NXWo/5zOsR+OapXQ+11hDKcAcjeKH+5zwou6gO39rvTk1CLc2u2zVZxqTy8grY8jE75MWowMBGolvRWgVdrKwZMNDfAtVvj6oNyGyomnDr1gqDjGOqAy+3cvRh9dzm/cTYoS4dmH8Xkt7B27FJspA5rkXSJayUOye/BxUUD88OLXVmbDhYhhz4SgsGXdvUPLx4aCq079YgfvpSEYi/8xIY7Jy7UiSauZ9SYbbQy+KkdDznPcfrX5/X/SmzOC9xV3RYjZF0aclSvMPPP4juHA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 09:43:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:43:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv4] nvmet: implement unique discovery NQN
Thread-Topic: [PATCHv4] nvmet: implement unique discovery NQN
Thread-Index: AQHafCfyKBm0wlG8GkWIMD0zvUTKFLFDgokA
Date: Fri, 22 Mar 2024 09:43:41 +0000
Message-ID: <dc120432-e759-44bb-8667-78e381be61ee@nvidia.com>
References: <20240322070927.30454-1-hare@kernel.org>
In-Reply-To: <20240322070927.30454-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB8779:EE_
x-ms-office365-filtering-correlation-id: 7fd5ebef-742d-4321-4763-08dc4a548f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lgCUsH7Pvfdqb8Nb4sYfzIMstLzTPlI7lS6VfhlrEFi6O5Bj3TlScnxvSbTDD2P9awrvyApXWDc5KcvGgWEIw02hsYHhbGKbQcO9mBVy5Miz0noww7uEvFVNQMNyEracYROFLMAahL/O2kxSIpxZjEpEWUOmetn5nicJ8DJl00KQ95U2MQ3AhJM1hDoPsNq/BFLSCXtiaAW/lGj8k8RCH3C0HFqFhCCCWqIAcCQK37mE+9zMzR6E5d3OxpLLheg54YgeP4ow2NnijWAqopxQKrq7RPqchEUFQ38APct/svUa/rsnQBOZQSFJn60Cd0u27pb7e4MC+HX78WYDnYMt2Nv8QiEyVR7b2FiMGWkFsjP+HM6JeoW6Q4MPvPo8RXsANcdM2xGJeW5qkMIwRYl5dkC904lSoghrz5uX5+rxwhiMyP4BZFLllp9bzhWjUwdYEZqKZnz5igbCSGZbMloKZnKk3hXzDPaHmTRGfiEJUrCjFMDca1BF5bz4N4wYLotk9+Jg+MqHYF/lz0c2P+KFdeJmYKcjPVSAD222zteSVQQPYmwze5yBse3WiQWea6IKUGIKrEKqGXsTb6pXvE1GnGAyUJsJbOq1hBMM0IPPswqmvpeeU5DOi9EKsH1uinVM+uhG95GrNPpswUfJS7BPFEEA/wq1L8At0Z3dWN9Udu45spJFVSDa4vwMs+uH2nuAncOoWK6Ml9xdf2KIUZL8H25DPbPh9LkBNQBnXj90/uM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Szh4WHRpR3NLOGtWTG53aHY3MDBNRE8xZkViOHROMmZ2eXowYWlBN1loTitu?=
 =?utf-8?B?YXhyL3BmZS9YVlZIZCs1c3JqazJFTGlBeG5QcS83MDVCbFN4M1RiTkZmQW9w?=
 =?utf-8?B?VnRvVGF6bkQ1S3pNMzVhOGNkb1k0ZzFJdGp2WTBIcE53VXF3YnR1dngydnU3?=
 =?utf-8?B?QmVFWFhNMHBWdlE4dzFVRE53cWFlejFQcGJiZklHRUppV1NvaVVyZTJMcDJS?=
 =?utf-8?B?dVR0a3l2ODZOWmpRRXdRQXE1MDFIRUt6MTJJTmZqVWRIdldRcGUzSkM2ckdB?=
 =?utf-8?B?S3lTcFlSVVA2NEtUR2hxeTlNcDZ1NThhVVBGdkIxNnd5UEVDVHAzZzEwbkZ4?=
 =?utf-8?B?OFNkOEtKczFnbFY1OFNwWDVyVE1jZklXZ1AzbnR0QWZHNHVSckQ1MDBzUVFs?=
 =?utf-8?B?blUrU1lEWFcrOFk0SWI1K0E2WVU0YndqdGtGM1FHS2s4djFMdnFlTE5aZ3k4?=
 =?utf-8?B?NlI5c0pGNi8rdzhnSEtLd0VUendiSklrZVFaZjJIMEg3VlJuMUNYL2dRRlVF?=
 =?utf-8?B?RS9lRjJvY1NKQXZ0RHR5ekdjS0VoWVNxWURuMTByd29WcEYrVXR5Z1UxMFAz?=
 =?utf-8?B?Ky81MkZ0RmZKS0hDZ0NPN2tobVJjVHFYemNiUWsxakJkd0FORm5oZVMrR2RN?=
 =?utf-8?B?em9uYVRwL1l3T2NqdzBiTDdPVm1lUnVpbTJtWi9qRUxNeWJsU3BXYmFOQkJ6?=
 =?utf-8?B?VjRqUHo5Q2RRcTl2SVo3UnB4MTUzTzFSUEZSZkxYc2EwVGUxelBac1pOaGp2?=
 =?utf-8?B?dkZyNXdMY3RndU1nTmdWcVVuK2kyR2hvaWlHWVRCYzFTdnRnN1NXbmU0OS9P?=
 =?utf-8?B?YzF2OFg2T0NwWkNzdHM3SkRMQWsrby9zdUxKQTZrQ0kxOVVQbldXamlTSzRx?=
 =?utf-8?B?bk9LK0VXS0ltZGc2MjZsQ2FITHNnZUZRNVl4Y1F0dUVBcnpyYWR6ZzZMaVVh?=
 =?utf-8?B?bi96NUYwY2VMSDhSeklPdGdvUysrZGRWa1JYTFZaSk5jNXBMblNoZFhmb0N4?=
 =?utf-8?B?aHFRQXdERG1rM1VmWEJQQWlreFpEQTY1RE4yemtUcFFDbThnUXB6TXREOTJY?=
 =?utf-8?B?b3J4c09lQ0xQYUZIN0VCbWJ2MFVYK2ZidjU1NnUwZjdnT0d5UHp3RnZGNGY0?=
 =?utf-8?B?U0RFNitmRXNuNTlTcmJvNTZPS09IRXBTQmtZNlI3cUZRM0pya2p1UEM2UFhJ?=
 =?utf-8?B?Ly9lajVweFBFU3NBZEQ4U1MzSlo2ZG5PMStDU0lHVnl3ZEJ5amQyOHd2cVdk?=
 =?utf-8?B?YWJKSHF3aW0xV0RROHJqeTFXT25hT2NjdGd0QVRocVZ4M0dDcDZHeUdOREVY?=
 =?utf-8?B?QnU4VjBvNTQrT3NtWFZRWE16ZWlIQ2xpY1ROWVoxOGhaTGpEcDd1L1I2MGtv?=
 =?utf-8?B?ek1nK1JDOWYwV0lKUnpIT0pPUzVnR3ltNC9xejdnT2Y1L1prMkYwa1ZHa1Q4?=
 =?utf-8?B?dFc1dFNpRC80ekw5bzhYQlpTNWdHdzYvYTBvUFV0U0FZUGQ1L1RvaGlUTzdE?=
 =?utf-8?B?WDZXZXl3Rm1xb2VMeSswbkMzcS9YdWRZYlE0THQ3TTNXZ1JhSGFjVGpRTVpT?=
 =?utf-8?B?NWs5YjdXZVlaaVY2dDMza3BpVFF4ZzIvbW9aL3hCTlZUT3hoZFQzbm1wQVM0?=
 =?utf-8?B?UngwRkxUeCtpZm4vcDNPbUFpQ05JSjVVLzhmcHlWQUFPTlFCaG04Rnc5MW8w?=
 =?utf-8?B?elpvaEM0WDQ5VFhVa2hjK2N5TTZhREVIUmcxN2xQNUhuZ1BjV2FJTWJiOFJz?=
 =?utf-8?B?d21CbnRma09zT1poUVJSU0xWcU11VGZZWE1HU3VZeDlkMXNmZUR5enRQRkNX?=
 =?utf-8?B?cEQ0SjgzWk12ZC9obDhQYjlncWNGNStDUWx6RE1CUjQ0SDZRMDVGK0h1YytB?=
 =?utf-8?B?SFgwa3lnS1Zjb2dOVk80cGp2bzhzRVRKZ205MHlRTzBvNlM3YVRnZk8rdkZm?=
 =?utf-8?B?RnlRVkpjNEF2U3JwenltazlGNHBpaEVONTVuejEzTFlnWVpRa21FaWdsaTBz?=
 =?utf-8?B?aXczeEx6Um0rckNkNDhwTVFiZFhDUU5CQzJZRk1ERVhDck9hUTE1UzNRTFJh?=
 =?utf-8?B?Q1NWQUJyK3pFRVBrbStQN0FDU3lTdS9SeHVuYXU4ZjZsaHYvM3VxRGZFTjJh?=
 =?utf-8?B?a0tub3UyNGdKcnU2Wk80anREYkVIOTB3Y3hlYzhJMEZrOE1FcCtvZDlHZHRv?=
 =?utf-8?Q?hB6wGoYWWqbs7nH+vdvq1oTob/k6wxOunw3FayC7i2Bq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79469EAA3CBAC9488323B3E4215BFE24@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd5ebef-742d-4321-4763-08dc4a548f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:43:41.7967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2Tnqs3Rbi277eYC+DZNT1Dlv8YzVcGF0A3SJnEbndJ1tCVQCwycVnGTdbXnQG09/2ZF3h4bSrEFdC8IahJF+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_024349_766398_147C5A6D 
X-CRM114-Status: GOOD (  20.15  )
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

T24gMy8yMi8yMDI0IDEyOjA5IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IEZyb206IEhh
bm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiANCj4gVW5pcXVlIGRpc2NvdmVyeSBOUU5z
IGFsbG93IHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBkaXNjb3ZlcnkNCj4gc2VydmljZXMgZnJv
bSAodHlwaWNhbGx5IHBoeXNpY2FsbHkgc2VwYXJhdGUpIE5WTWUtb0Ygc3Vic3lzdGVtcy4NCj4g
VGhpcyBpcyByZXF1aXJlZCBmb3IgZXN0YWJsaXNoaW5nIHNlY3VyZWQgY29ubmVjdGlvbnMgYXMg
b3RoZXJ3aXNlDQo+IHRoZSBjcmVkZW50aWFscyB3b24ndCBiZSB1bmlxdWUgYW5kIHRoZSBpbnRl
Z3JpdHkgb2YgdGhlIGNvbm5lY3Rpb24NCj4gY2Fubm90IGJlIGd1YXJhbnRlZWQuDQo+IFRoaXMg
cGF0Y2ggYWRkYSBhIGNvbmZpZ2ZzIGF0dHJpYnV0ZSAnZGlzY292ZXJ5X25xbicgaW4gdGhlICdu
dm1ldCcNCj4gY29uZmlnZnMgZGlyZWN0b3J5IHRvIHNwZWNpZnkgdGhlIHVuaXF1ZSBkaXNjb3Zl
cnkgTlFOLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2Uu
ZGU+DQo+IC0tLQ0KDQp1bW0gY2hhbmdlIGxvZyA/DQoNCj4gICBkcml2ZXJzL252bWUvdGFyZ2V0
L2NvbmZpZ2ZzLmMgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
ZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgICAgIHwgIDcgKysrKysrDQo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
L3RhcmdldC9jb25maWdmcy5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb25maWdmcy5jDQo+IGlu
ZGV4IDc3YTZlODE3YjMxNS4uZThlYWQ0YWIzNWFhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252
bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb25maWdm
cy5jDQo+IEBAIC0xNjEzLDYgKzE2MTMsMTEgQEAgc3RhdGljIHN0cnVjdCBjb25maWdfZ3JvdXAg
Km52bWV0X3N1YnN5c19tYWtlKHN0cnVjdCBjb25maWdfZ3JvdXAgKmdyb3VwLA0KPiAgIAkJcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICAgCX0NCj4gICANCj4gKwlpZiAoc3lzZnNfc3RyZXEo
bmFtZSwgbnZtZXRfZGlzY19zdWJzeXMtPnN1YnN5c25xbikpIHsNCj4gKwkJcHJfZXJyKCJjYW4n
dCBjcmVhdGUgc3Vic3lzdGVtIHVzaW5nIHVuaXF1ZSBkaXNjb3ZlcnkgTlFOXG4iKTsNCj4gKwkJ
cmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICsJfQ0KPiArDQo+ICAgCXN1YnN5cyA9IG52bWV0
X3N1YnN5c19hbGxvYyhuYW1lLCBOVk1FX05RTl9OVk1FKTsNCj4gICAJaWYgKElTX0VSUihzdWJz
eXMpKQ0KPiAgIAkJcmV0dXJuIEVSUl9DQVNUKHN1YnN5cyk7DQo+IEBAIC0yMTU5LDcgKzIxNjQs
NDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjb25maWdfaXRlbV90eXBlIG52bWV0X2hvc3RzX3R5
cGUgPSB7DQo+ICAgDQo+ICAgc3RhdGljIHN0cnVjdCBjb25maWdfZ3JvdXAgbnZtZXRfaG9zdHNf
Z3JvdXA7DQo+ICAgDQo+ICtzdGF0aWMgc3NpemVfdCBudm1ldF9yb290X2Rpc2NvdmVyeV9ucW5f
c2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sDQo+ICsJCQkJCSAgICAgY2hhciAqcGFnZSkN
Cj4gK3sNCj4gKwlyZXR1cm4gc3ByaW50ZihwYWdlLCAiJXNcbiIsIG52bWV0X2Rpc2Nfc3Vic3lz
LT5zdWJzeXNucW4pOw0KPiArfQ0KPiArDQoNCnNucHJpbnRmKCkgd2l0aCBQQUdFX1NJWkUgPw0K
DQo+ICtzdGF0aWMgc3NpemVfdCBudm1ldF9yb290X2Rpc2NvdmVyeV9ucW5fc3RvcmUoc3RydWN0
IGNvbmZpZ19pdGVtICppdGVtLA0KPiArCQljb25zdCBjaGFyICpwYWdlLCBzaXplX3QgY291bnQp
DQo+ICt7DQo+ICsJc3RydWN0IGxpc3RfaGVhZCAqZW50cnk7DQo+ICsJc2l6ZV90IGxlbjsNCj4g
Kw0KPiArCWxlbiA9IHN0cmNzcG4ocGFnZSwgIlxuIik7DQo+ICsJaWYgKCFsZW4gfHwgbGVuID4g
TlZNRl9OUU5fRklFTERfTEVOIC0gMSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwlk
b3duX3dyaXRlKCZudm1ldF9jb25maWdfc2VtKTsNCj4gKwlsaXN0X2Zvcl9lYWNoKGVudHJ5LCAm
bnZtZXRfc3Vic3lzdGVtc19ncm91cC5jZ19jaGlsZHJlbikgew0KPiArCQlzdHJ1Y3QgY29uZmln
X2l0ZW0gKml0ZW0gPQ0KPiArCQkJY29udGFpbmVyX29mKGVudHJ5LCBzdHJ1Y3QgY29uZmlnX2l0
ZW0sIGNpX2VudHJ5KTsNCg0KbmV3bGluZSBoZXJlID8NCg0KPiArCQlpZiAoIXN0cm5jbXAoY29u
ZmlnX2l0ZW1fbmFtZShpdGVtKSwgcGFnZSwgbGVuKSkgew0KPiArCQkJcHJfZXJyKCJkdXBsaWNh
dGUgTlFOICVzXG4iLCBjb25maWdfaXRlbV9uYW1lKGl0ZW0pKTsNCj4gKwkJCXVwX3dyaXRlKCZu
dm1ldF9jb25maWdfc2VtKTsNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQl9DQo+ICsJfQ0K
PiArCW1lbXNldChudm1ldF9kaXNjX3N1YnN5cy0+c3Vic3lzbnFuLCAwLCBOVk1GX05RTl9GSUVM
RF9MRU4pOw0KPiArCW1lbWNweShudm1ldF9kaXNjX3N1YnN5cy0+c3Vic3lzbnFuLCBwYWdlLCBs
ZW4pOw0KPiArCXVwX3dyaXRlKCZudm1ldF9jb25maWdfc2VtKTsNCj4gKw0KPiArCXJldHVybiBs
ZW47DQo+ICt9DQoNCg0KLWNrDQoNCg0K

