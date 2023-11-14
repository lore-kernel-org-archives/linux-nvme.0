Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88D7C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 04:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C9HyDhNZXr3we6viujiifZnJd74gq2QRFnYjM6AupV0=; b=2YNjKFPGD2wAjgMgt46oSO/fcZ
	2TVrZmX20rHAZEFanSXIqzaFfNzezCJWmVZ+XZKbSXJ2m4d8cQtlAbliVaBSd2XEEQTSVLQgkWK4G
	NgV8FR9yW+XBMtfybss9pzyvDCw+a+31ueo+LYzpHOqslxPRDnCFJbGKIFpmizXnsO3TTpUx7hTNN
	xZ8dr8fiNK4z+kxCs07FqRmdxr/3yvkqakiaXxiUuQhkeKcJosCsQYzjvqpSHbh55dTqdqt6QtaUF
	+Zw3cWa5ZK+g+c7BtVPEqSstNVUjfFfWhXFlhz/24V8xdB6zXm5hP45BlyxTl5gTMeh40rzI4Rbto
	GJ7mbqhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2kvB-00F93t-1v;
	Tue, 14 Nov 2023 04:21:05 +0000
Received: from mail-dm6nam12on2062c.outbound.protection.outlook.com ([2a01:111:f400:fe59::62c] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2kv7-00F93O-2J
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 04:21:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM2GEgLi4qeCD3y32/+2gUwuHiP+iJPB85AeVaODRznRifxT3eE6/OJEOrUMCkFBjkVJ3asOEA19dTGtXw+V3r3ckBjxnz0wZAUpthzyi+QN/YPOwKghKEYa27zgKgpsuv/aiuCnXRsrCfwiFDT+THTwT4g6BxrwEFCCOc+4jNTkltZ1QhFJXilu6c+2GLWsNU2esJHCQYcukeOiVygSD75BRZ/R+jrP6d7QkY6nbyQ4T+JHDeampmsHP74BzlDnOiySVhyKZJvHJ/7bHPgfNqROVtJs8v7TjwHD1SpBjSI912eni/yfe9wcK2KxmhARLDejX4K32fklM7+TJXojMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9HyDhNZXr3we6viujiifZnJd74gq2QRFnYjM6AupV0=;
 b=D7Xmm+jybw44R7aPthJTtB56wbEiBL7Mimp5rmTJPNmBjfgZmcuoDsA6xnra7oJQFlOcvetAH5Spz9ndL+PhUoeltSQoC78cVzFGh7tylOdGsopuvegy6aRupRyaxzE1eWWBv0HRzJoqaQFLGUlkbfNMKXNEiz3Vh50rI7E29AWlaULM0CZKD8X92bna8L5Vw8aXJwaGXkz03RFsYS0/4ug2p9jMrhGOKpHUGMq2um5KLJOQFgXDOWmciEEiViyLMhOLTRwxpN7qzI/iXcFOoe3ejtaoFFnbsbIdfdqElpPBA/5b0jMaDsuFrdosjjy/R4QrHXLr1LE18C9hOyrlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9HyDhNZXr3we6viujiifZnJd74gq2QRFnYjM6AupV0=;
 b=KdkrCeE5uqMYTATW2C9r/9DCqwXbULJ+K1hFoaYpDfJwkwAHcJOsl6rOZJ64hg/G3TY0m9M/AKu1sK/BtNjOWWOsj8G5CdntfeVZPm/VACY9Kz7bzdUCDxOIpb+YXnfqfwsQKrakjwAWr/12b61azgl9G0bhsSA7qBhEt7asac2LyBbzJ64ykUHJ1swleeu3jGjosj10M2zHdWbvnRVW82AQSp21HOEOaFmLjkejIxXOSkMmAJsINfBCTLyE6CJ8aMOq4lmuCWxRMVcTO26XFvvTQBxwqphtGMJrXgPCgw/EBYzv+phS3luCbDBI2sKR5y0ZZhUUO8NJB6JEhI/ivQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 04:20:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 04:20:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 0/5] nvmetcli: REST API for remote configuration
Thread-Topic: [RFC PATCH 0/5] nvmetcli: REST API for remote configuration
Thread-Index: AQHaFkXpVRWNA1XKkUucd0I2YeCaebB5N1kA
Date: Tue, 14 Nov 2023 04:20:50 +0000
Message-ID: <2c945f01-2b57-4b89-99c5-5cecdbb697c5@nvidia.com>
References: <20231113152709.30894-1-hare@suse.de>
In-Reply-To: <20231113152709.30894-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB9240:EE_
x-ms-office365-filtering-correlation-id: 57fee309-0c16-4dc0-77d2-08dbe4c915b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFo4+pLaocyTB0CVy+z87lBwVTgPfsKarVGM3j7ARhOiOp4zNdTEGBo1/XeT3MyBMXni3jfY25HuT74yDA78W7AJmtZbc9B8EdPD1dWD5yFD90SBUcLsLSzcePzw/DStU6+z3ZTsjRrglHtd/Havunwjr1KLA4g7UrbsIbx4sYpWhrDhacgLa9noA/Dg6PZi2jOuS9pMe1kDMQe1vbHmNHT+GY9lWiur+97ixSgnBTsxeiMyv4CALxBHLwv9pJIJ05dwMUxjrRqHD9M7Uh4tB1nDwWcooXTjsspB41aZLmwnrvBF4PvEXPzneYnrH7yp+mhEL+EzgP1yFqI9+3eozr9BA3/IIkGuluRvLJ0XT6MQvkLHBrVd8yz4YlQ5CiW8KkoDkAljPbic9N87Evi7rykHfFd9OUWPrFjoAfDKUUipe2x/shAfDiUs+/fLw2vfbmr9QSojJdhg9WpiOOrZWVXTN8/KQNjPMkp0vD3y/P8MeJt41X1kcZ34gKT+1NrnNFKPA2cBXLEYV0YTWSuKVxKaiagw/JR1Yfwu0ytaeNQWbQx7Y32XPSBaK5wTseUzU2lSEnNuk5mVeu+IfsVScfuYj1FIHd4gXGIHh9Mqpu4rGS8BBjgMUU/JY9bduFCSLtY7C8zVhDO1UGkBTxtTRpryMC2L3uvCCsgXHko749C2q2ywHW9X3BBSLadAtLzgboqlH1IRh/LQsROG+bSMOvn4VKM1chWgEx2yGaB4G6Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6019001)(136003)(346002)(396003)(376002)(39860400002)(366004)(279900001)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(54906003)(66556008)(66476007)(6512007)(66946007)(316002)(6916009)(76116006)(38100700002)(64756008)(66446008)(91956017)(8676002)(8936002)(4326008)(6486002)(122000001)(478600001)(36756003)(31686004)(6506007)(53546011)(86362001)(5660300002)(71200400001)(2616005)(38070700009)(66899024)(4744005)(2906002)(26005)(31696002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVp4LzVHR2wvcXBkbTZPQ3JKemVDcDRlU0t3OG1COUJjUjNxWTlPWUt3Z2hU?=
 =?utf-8?B?WjRBMDAwVVFJTkVGUDl5TDJjOFBhU09ZRG0rSnVxZitJUUJ0N2NTbnloYmNv?=
 =?utf-8?B?OWFTWXVWbEM5Q0pLS1JYS0gwN21hYU14SUZEMjl3ekFKaTYwNTNwOHJpRk52?=
 =?utf-8?B?b3Z4bXNPYVl6THN3Wk1vWlY5eHJmTys5d3RUSUJBY0l0Mjc5bGpOam9pMkhv?=
 =?utf-8?B?TVk3dFovZ3B1RWJvaXBHOXhyeDBKM01HZ1NGdEFxcERuVFNYSkwzdVhNSStK?=
 =?utf-8?B?ZisvZzloYWVTMW4vWnM5amZnRjJEcG9qYjFBV2F4Ukc0N0VwU01Ta0w2RU5i?=
 =?utf-8?B?K3VFalJxS2MwcngrMkRZd3lUazhMaVpsSlRuemxKc2REcll4M3I4MHNtWmFj?=
 =?utf-8?B?cUN3dXJCWVN1U1hJWUhHYnBSV0s2SmxiWkhQTVlWSVRZT3E3bE9IN0pyMkli?=
 =?utf-8?B?UmdXTC9TVlp2VmNwR1RscytlQjJMUUNyU3hLZW9WNklwVi91d0dvcVVOUzZ5?=
 =?utf-8?B?SzVvTzBESVpnWndaS0pmS3hXaFVvbkVPZk9nNVkzYW00R3NBT0tTRHJ1QWhu?=
 =?utf-8?B?dWJHZmFkYjF4VFhnZElFR2dLdXdrWXAwSHdOUUdKTGVZYzE5T3BGbytnMi9h?=
 =?utf-8?B?aml5aW9LckgxanNkQitmeXg2SkZDUGhRam9YVjNlV2ZQNzMwd0d2UEUyK1ZC?=
 =?utf-8?B?V0l3QjR2M2JHd3d2TThuVGRiTzFLK3VRZ2VxLzhhRUdLTUE4Njdlc3p2Rlds?=
 =?utf-8?B?Q0FUbEVoUWZSdXVXalJ6VFRpRW9ZWTRFc3JvK3hoaHhSbURZYm9iZFc2WVo2?=
 =?utf-8?B?SWx0QzN1Q2tzcWNxQnFLZHBIZjJKQXFmTW94OVN0NVpjUExwUkd0YzJjc2Ey?=
 =?utf-8?B?NzVOVUU3SWlhOC95aWVheVd0R3pvdVo0c1JiQ3k1SXYxTkJSYTNNOXpzdzdx?=
 =?utf-8?B?SU9vQmZhbkRGNWRXYVNpNmw5ZUhnVFlEMEsrOFFmRjR3OXA5R0o3dllCYlJo?=
 =?utf-8?B?ZHFXQ0xFdE1VSDQ1SmM3K2VVbHJWeEJrK3B2QmRPZEFsVk11b3lEWWtGOUIw?=
 =?utf-8?B?bXZIcVM4Q0szcmhOcjl1M3dFTVVwUmtrQzZpNU5VUmlGbFVxY1hhTXY2bXdK?=
 =?utf-8?B?TWVZY3RTamdkMWMzbzdpMjJMdWpLUitDL1pWTzhOalRWaEErY1djOVE5aXdr?=
 =?utf-8?B?ekNvTlZ1VnAyd0hiVm45THpUQ09IWXlhQUxhdTVjeGFaNGdIYzh2YUNyMnlE?=
 =?utf-8?B?d2ZPbkVsR1FTUEpKV3dpdEl4UXYyQUJNTHdYZ0d3eERVajdhV0NBZmdheWV2?=
 =?utf-8?B?M0hYU0VzeGVXQUlxU1FNd2ZXZC9lSi9VbkNUNTUyamtXemcyL0pad0NRSmMv?=
 =?utf-8?B?SWxaUzlab3Z1VE1NcUltQ2djc2FoZmY5bXQzWG5jbVNlYmF6Qk9CNkFGR0I4?=
 =?utf-8?B?TFFaNDJUM2hPS29QWEVqMEJNcW9DK1g2ckNSNWJpWVo2Ni81R2RlQTVMYXZp?=
 =?utf-8?B?b2YxL2Z3VFl4SGZ3QnVoNGpVT3Vzd2E5VTM1UGMzNDhUM0lmU0N2UkgzNG5o?=
 =?utf-8?B?Sjl4UkNpeFovclYrc2RqU2JNOGdUVEZ1NkVhd3lIL0NQaGg1YzBkODdmVGJp?=
 =?utf-8?B?eTZ3cFErL25ab2VWcERKNU41L25PQ3RMTldwN1ZjYXVrd2hXRisvN3VzVVZU?=
 =?utf-8?B?QVFidUJMcHNUdkFBMi9SS202U3NLbm9pZEp6c3dZTC9SMkdsOGh2V3JuTEth?=
 =?utf-8?B?QytRMkJubVN6MThzMUgzYlA3bEk5TmROVldNNXcyamFXUmkwcGxzb2J6TkNl?=
 =?utf-8?B?KzhtT1hpZ0Y3QmFZZTNXN1pkM3hXSGJ2dTA1NHdOWTl0YVB5MjIyQ29VcG5F?=
 =?utf-8?B?VDFmWmkvSnZBWUpFNVJJTytsbE82VzQrSzdCUFZ2U0dKRlo5UnJXVFVEQk00?=
 =?utf-8?B?OEdidUwzUDJaLzJWYjdob2FKSW0xTFpNS00wcjV4cFpDYVpSNit1VEhUT3pG?=
 =?utf-8?B?WjBrTno2SHF3VXRnRG9PaUJXYnc4UlhrK3RNRXlwbHRjL3BtUW4rSFZtWEdz?=
 =?utf-8?B?TENPSW90cnlrUnZaTlc2ZWxua3h2RHNxWGg4ZFl0eTdXdXpGRk4xNXcxUWtI?=
 =?utf-8?Q?LX6VrV+IuDzlY9IfITKFWn5Z3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6A9F9FDB4FD3C46908A1FEC83D035E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fee309-0c16-4dc0-77d2-08dbe4c915b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 04:20:50.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elhQ62teMu3BpIJ88QzHLLx7Y18xeYP4fu5mq1aqq+rxm/+OLIciE7AFrZ41JBsOd4FZ6c+x05CVeHKTptXzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_202101_986745_7B137A10 
X-CRM114-Status: GOOD (  16.47  )
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

T24gMTEvMTMvMjAyMyA3OjI3IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IEhpIGFsbCwN
Cj4gDQo+IGhlcmUncyBhbiBhdHRlbXB0IHRvIGFsbG93IHJlbW90ZSBjb25maWd1cmF0aW9uIHZp
YSBhIEpTT04gUkVTVCBBUEkuDQo+IEl0J3MgYmFzaWNhbGx5IHVzaW5nIHRoZSBjb25maWdmcyBw
YXRocyBhcyB0aGUgd2ViIFVSSSwgYW5kIHVzaW5nDQo+IGh0dHAgJ0dFVCcsICdQVVQnLCBhbmQg
J1BBVENIJyB0byByZXRyaWV2ZSwgY3JlYXRlLCBvciBtb2RpZnkgdGhlDQo+IG52bWV0IGNvbmZp
Z3VyYXRpb24uDQo+IEkndmUgYWxzbyBpbmNsdWRlZCBhIFJFU1QgQVBJIHJlc3BvbmRlciBiYXNl
ZCBvbiBmbGFzayB0byBoYW5kbGUgQVBJDQo+IGNhbGxzLg0KPiBUbyB0ZXN0IGl0IG91dCBqdXN0
IGRvOg0KPiANCj4gIyBweXRob24gbnZtZXRhcGkNCj4gDQo+IGFuZCBvbiBhbm90aGVyIGNvbnNv
bGU6DQo+IA0KPiAjIGV4cG9ydCBOVk1FVF9VUkk9aHR0cDovLzEyNy4wLjAuMTo1MDAwLw0KPiAj
IHB5dGhvbiAuL252bWV0Y2xpIGxzDQo+IA0KPiBhbmQgeW91IHNob3VsZCBiZSBzZWVpbmcgdGhl
IHNhbWUgb3V0cHV0IGFzIHlvdSB3b3VsZCB3aGVuIHJ1bm5pbmcNCj4gbG9jYWwgKGFsYmVpdCB3
aXRoIGEgJ3NtYWxsJyBkZWxheSBhcyBpdCBmZXRjaGVzIHRoZSBkYXRhIHZpYSB0aGUgbmV0d29y
aykuDQo+IA0KPiBBcyB1c3VhbCwgY29tbWVudHMgYW5kIHJldmlld3MgYXJlIHdlbGNvbWUuDQoN
Cg0KSSdtIGF0IExQQywgSSdsbCBnaXZlIGl0IGEgdHJ5IG9uY2UgSSdtIGJhY2suDQoNCi1jaw0K
DQoNCg0K

