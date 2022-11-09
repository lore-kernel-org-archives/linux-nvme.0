Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06A8C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aSx3a0bua/kuDnPdCEjZvJuF152+DVtCp6O/csq5u0s=; b=E1I85zwwTERqheSwg+M68OE8o3
	vnkcCn88twOgCTvyaVlxA3CZqn3pGFg4b9ng2vfAP6q24hpoT72MsdTTopO03228OcdL0ApT8DFjN
	b2TPfZVbV5Hl9Jb1Rex4737+MEeIRsHyW9TBw17JrJOJHOuW5lt/D7Cx3SM9UZfIvXIS8Ed/a5fEc
	Q6YZtObzl7bm9gSdWcGU1Mr8vDEjFud2wPMUkk6hfXCf3AMVZdgrDa79Dgu7fzsk0hdOxkJMhnJfX
	jjj5Tdh49f4Zff9jkRU84yeZK+M5cfsP0p1J7EhtsSbyHP0bPTWT9YsUMEsCeODvifOQWWqmEC8Yb
	3dW1MS7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbsu-00AL3j-3P; Wed, 09 Nov 2022 03:36:16 +0000
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbsp-00AL2y-1O
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQV1IqOG60q7teNujiM53k1jhjkv9gFr/hLdNa5m66ktiTZty7LIwmRnEGd214jhhm2cfBg64csjLy+R9SHoKl1qm4OvqFc/Rwbh9jDe4JJszVPVXFwEW/oCh7wW2sGgxBaDXoLd0NQeY55EXxXgb5drQZu4KQcd+pE7a1bVShpE9c4YvcxZJZcORxTNVulZ8Oe0YqR5cVT2XzIER/3Ie1VZLjzeYUhhSlG4fYLZVzXEmMbKtOTYN3cHYy63Adw/auHj02C88zkx/MRYpOH9xMrlub5+XchyNZCOZyZvaA3poTk9yjHbPoL4p21u4Masdq6v5jCuTusQhgJorWTtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSx3a0bua/kuDnPdCEjZvJuF152+DVtCp6O/csq5u0s=;
 b=Fyi1C2uj5e7E+C00rwIZoY8f3S0vkjp1i3I73wZP6PhxoQc8cQqFYJfEEZPN07rPF4nrcaCBDP5Bub9ZijbEcZhtwPnq5jBb5wS7WwdAvvSFE9N2H41n3KBNZy1eNBLyl/+UrN47rnjUPA9TMREhV8towk1B9eKfuh5Yt0dnpuORsQaz0QzNwoHmWo7E7TDpamye26WV6GRDJAzqrzYSWinJ1pkcyXaAs5IxlBOs9+AuL7oaEat67ewaDeWnJhMnikXTe2+cyYn+a9O+4Iz47dSJBz1cUAuqZRkaFVIlfleNSEAJBWviSyWU3Sn8umeGkvetf7i2bLZ4cvHeQScImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSx3a0bua/kuDnPdCEjZvJuF152+DVtCp6O/csq5u0s=;
 b=MeoNcpUR0pEb8bAMbhHxHiiEZpxGlgV1/fzngG4VbdhcQf9g1qNGdK+ftq9f11qavic3VVKHrj8jxHgwWh0rxoIUywle1kKdSBS9y5W8yTwWjN0ufLte7GuRvUzMoh4+F/+0I0kQg8+vgvzitM3prn1BmAldl2rzUm1FM28LwjgvROv2s8WX6BPE/TY1MMXmDS4qZ5Od7LoOiHVDVTAHRHQORi6zKEpUXd4ZPtDTu973LZM28UsAvHvkCYG5xmbDNubAqJ2hanoPCxcS44S8iea5m0wYiL1RAhgSCFHfhRy8VgoyblpqCkQhCicXoPLyDjlBed02BbW71ZZ8F+HZIA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 03:36:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:36:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, Keith
 Busch <kbusch@kernel.org>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: Fix a memory leak
Thread-Topic: [PATCH] nvmet: Fix a memory leak
Thread-Index: AQHY8+vP7USmeqhvl0qdzU5UxF5UX6418PQA
Date: Wed, 9 Nov 2022 03:36:07 +0000
Message-ID: <30b07f4c-70c0-b4f2-e4be-46f3aa413f6b@nvidia.com>
References: <20221109032957.998128-1-sagi@grimberg.me>
In-Reply-To: <20221109032957.998128-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7492:EE_
x-ms-office365-filtering-correlation-id: 20da81fb-d6e2-4f6d-7f95-08dac203896a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  6PTJt0aLhWIZ8RE4HurmZdgcuDwgf3aC7Oxv//8HhFF+xzPlH+Zkkz0Gcpnjgd2pHAO/ezLbAPKYZUOfmezmjQMGoa44y5E3M0KOHjquFYXTQbNVItWpCP/Ob9quC0M93/he4ZIpBr3D7T1YBlxaKiwavGaeZOK27WdMWwbp1GvQ3v+NLQC1qj3FlcFPQ/wQn6vDd4AlDKrG3pK9sWkYq+FokZl2fOg1srUj6+tNYxu2DFJvLpYjSECo/UpFOKM0xKDoZTeu9I8uBUYhLImr+rSlyDnbzZROrkTAPc5z/bhR6ZoXsqMPkzTUJfzGsZgJKwr2q2jskQUuZa9I8aOqCGyxWcKJwjf4EJTWg18wBDT2gn9Tku2WN/7FP/eg7ygzvfU5Cftl5UY8AMOPgjDeM8PwscN3W++qTxGcDpKDOoiXPE6eeGEmctVrmYRXjuYZ9XfJQg9DgEZV+vzri7kbYikbEL+LUEe+0k5mpQPaU9/gmir0LcOtPPhl4AzIp/UoJpPzjjAnuMzD5qNWsB8Ege26e8m5qZxzc5H6ETX6mV2N7rrX1wrLWx/cNZUWe3czP1uGRI+3sADzw2A+FnaeWDRcROaPnSoOltTebodOqQtLcVFnx+tSMjt66lDZ0pjD2HCCetiaJAA/7WpA/DAU6wXbkDLwKBDjeIwnJwP/2w3KBqrtVK0w5lrW/QMKEnFSuV6OCAxiB0LNNe6z5K+91bFDMqpPt0RBrOxFzt8unewCidFVUmUwMFkPeG+7DGs83Y18ml4CZgu42Bhoj4IwRBJMPC9vHJRGJoZUCYNCHMdWxoT8+T6eEjSVc/ZRcsSwhzmESEJWtvg1juT2OTAZbg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(316002)(110136005)(54906003)(2616005)(41300700001)(6512007)(8936002)(5660300002)(2906002)(4744005)(186003)(53546011)(86362001)(31696002)(6506007)(8676002)(66946007)(76116006)(4326008)(66556008)(66476007)(91956017)(66446008)(36756003)(64756008)(31686004)(38100700002)(6486002)(478600001)(71200400001)(38070700005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ajg4MGNDdG9JbXNoVVN6NVp5N0JMdUtOK08vaU40L0E3M2NQZVdZRkhMbkhy?=
 =?utf-8?B?dkFXMVhNc2VGUUR3eVVDeXZMU3lLeDRSNkhEUndkTlcwMHBKcEtrR09FUXNW?=
 =?utf-8?B?NDA1bWRBV1lobGYyNDhOaGtiN2JEY295RFRnNUQzNXNGVGFIYTJaY3JxMXZm?=
 =?utf-8?B?bUR5VEpCdXREeFRMcTN6VGtueU11UW4vVURXYks0c05MdkJRWGNFMDJzOE05?=
 =?utf-8?B?ZlpOR0VZQkl3OUJxWkpTbk9pKzhjOFNWOXBmRFBXNExnaVltZWI4VmtmMno4?=
 =?utf-8?B?V2k1dFhEQ0pqVHJLdlpzSDlwVUE0engxcWFpZFFGUEFTNUN2N0VIOUE0OEd4?=
 =?utf-8?B?WHBDT1BhZDVLSFQvQzlkVGhVS0pMSWxPN1l3UWlFOERDMTM4N3RFMU9Ndm9u?=
 =?utf-8?B?Y2wvZVVIeXdtZXlOdVo0MSt5ejRyYUpqNzJMT21EeGVReTZqRFNmY0RpWHFr?=
 =?utf-8?B?b3lVbUJxclcxaWdIY2VxRE96V2dCd0FqQUlxb2lrdTNwenpicUVMQlllaDN6?=
 =?utf-8?B?a0loRCtHS3MxTkZtR2NFN3R5UGp1NHdkdVpXR2svbTFJWjVwa3BDWXBlTUEv?=
 =?utf-8?B?dlVRYjI5c1F4NUc1TFZ0Qys1V2Fha2JtRDQ2Z0Q3UjFGbTlpYVRqeTRraW1Q?=
 =?utf-8?B?ekdyb29ENlBPL29pVHcwY29QZFB0dUVFeEQ3OHZsRGt2SXBaN3hCOVFZU25s?=
 =?utf-8?B?cVJGbEIraWIveEJyY3U4ZjZ2QU51eFczOS9kUGMwVEhjUTVHU3RWa1NCdkVC?=
 =?utf-8?B?NUhXZmwwa09TZm5wYitqcDZqY09BR1ppeDd3M250NTc3M2VXN3dXcytxekhY?=
 =?utf-8?B?MzNPeXZtb055aWhDdE9wYjZvNndyek5tSHovMll0TldMVDNZUEc2Q3hxNVda?=
 =?utf-8?B?aTFDbWdUZ0RvR1RBRkZnOWpuN01wTGNqVkkrcll5ZmQ1d0pPZE1Xd2pPSnA4?=
 =?utf-8?B?NWJYOXJnSTFVSlRFKzNJVlgxQXVvai9GaGxmNFlNZFZ4bUViaExpZ3JwS0pl?=
 =?utf-8?B?eXZQb3ovWFpYcTA3Uk8yN3R6QTlKdlZQOGNiaktUa05aNGVBdEVoVFpsTUcv?=
 =?utf-8?B?Zk8zWDV1bGxkUm9JRG1CR2VUL1JSeDFWY1BVSXZlanpWdWQ1MjhxdlJva2d4?=
 =?utf-8?B?Y0ZyK0pjNUZVWHB2MlRyUXJoWUNVeEtjQUlRbWZmS2pQUjc4cnZxNUgxRjVH?=
 =?utf-8?B?d2Fjekp0VWkvY2c4NVdlV0xvRUFLdTE5a1VXN1hFTXdlNUJjcU5ucXZsU1lO?=
 =?utf-8?B?WlVvMHc3UkxJYytjYmdmcGhidi9VUE04di9KRFBqc0srSEYyUWxHTHM4NGdU?=
 =?utf-8?B?SVlqRk1LK0NKUjE5Tld0L2kwM0JtSzFRb1JIeUdPZVl2djIyT3dLb0dSNFNh?=
 =?utf-8?B?cTNlTUk3ZGlhMUJjVmNvblhQSjBVSHdQUEV5OGZOMmlLdzhUb2NFVzdUSzZO?=
 =?utf-8?B?Syt3MWc1eUUwNGpXeVNMeEtKZFl5dzlsQmRzUWVacnF0dmV3a0pBRDQzY0ww?=
 =?utf-8?B?T1hQbjM2RnFTRWQyUFkxd3d1QWVpL0pTZ3BlMmpKOVhBNk9Fb09Db2t0ekdG?=
 =?utf-8?B?SktJMmYwaWFCTzV6Q2R2VWxyWEJReXRSaGt1Zy9LbHdOTmlVRXcxUkNpazdB?=
 =?utf-8?B?SzE2bTkzOTV2RVdDc0grQ0NOYis2WHN2V0ZyM1VESTQ0MHFzZktLelArQjEw?=
 =?utf-8?B?UUxKbGxtSGJaS1hxV1I4S0FVTllNSHB3QXcxUnNHYmx3Ym9VeHFTY3N0QmV2?=
 =?utf-8?B?UGx6T0NwMkRpdmN3ckNLMnRoUG9WM2d0WDhGck5zdGRXR3NsWGVFN25mVnRq?=
 =?utf-8?B?SGVIaktCUWdLa2ZLckRJcjNuYkZ0Z1ZOOElPaXhWNmVvMEk5d1RRTFgxdm5I?=
 =?utf-8?B?UnNkSmlURFZucG9iV3l5dFVWVWVhdnhldm15QzR0WEtHU1VoQ2FHZHd1dmxx?=
 =?utf-8?B?cU40b3Y1VHduaE9pRi9nMDVmbk1wenJsZkxkM3hySzgvK3hJanFjNEJ4SXB5?=
 =?utf-8?B?ODdPVytQYy9pL1VxR3JGU1hKOUs0NkxIc3hEOExVWmxvT0NXSVVvY01FditR?=
 =?utf-8?B?K1VuNUV1TExnSFlsdjFRZjd0OUNyc1lnRzBRb2VadEpJMG1XN2dQaFlpZkhq?=
 =?utf-8?B?bGRyc0padE95QkcvaUFYZVNkKzZKUjRyK0hOa0prMlZNVVZqUXdRN3Q3V2dw?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBBF18F9A15AA848B6C3A884FEE38467@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20da81fb-d6e2-4f6d-7f95-08dac203896a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 03:36:07.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdEWDsx6ggwPXrPNMPFoHceVqJ1Dq6INip5v62EfnMoYlJgSUrKJrnHZPDUld7rjDTMLhw20mywDV/0JWmt/Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_193611_103224_E20D84CE 
X-CRM114-Status: GOOD (  10.40  )
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

T24gMTEvOC8yMiAxOToyOSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gV2UgbmVlZCB0byBhbHNv
IGZyZWUgdGhlIGRoY2hhcF9jdHJsX3NlY3JldCB3aGVuIHJlbGVhc2luZyBudm1ldF9ob3N0Lg0K
PiBrbWVtbGVhayBjb21wbGFpbnQ6DQo+IC0tDQo+IHVucmVmZXJlbmNlZCBvYmplY3QgMHhmZmZm
OTliMWNiY2E1MTQwIChzaXplIDY0KToNCj4gICAgY29tbSAiY2hlY2siLCBwaWQgNDg2NCwgamlm
ZmllcyA0MzA1MDkyNDM2IChhZ2UgMjkxMy41ODNzKQ0KPiAgICBoZXggZHVtcCAoZmlyc3QgMzIg
Ynl0ZXMpOg0KPiAgICAgIDQ0IDQ4IDQ4IDQzIDJkIDMxIDNhIDMwIDMwIDNhIDY1IDM2IDJiIDQx
IDYzIDQ0ICBESEhDLTE6MDA6ZTYrQWNEDQo+ICAgICAgMzkgNzYgNDcgNGQgNTIgNTcgNTkgNzgg
NjcgNTQgNDcgNDQgNTEgNTkgNDcgNzggIDl2R01SV1l4Z1RHRFFZR3gNCj4gICAgYmFja3RyYWNl
Og0KPiAgICAgIFs8MDAwMDAwMDBjMDdkMzY5ZD5dIGtzdHJkdXArMHgyZS8weDYwDQo+ICAgICAg
WzwwMDAwMDAwMDEzNzIxNzFjPl0gMHhmZmZmZmZmZmMwY2NlZWM2DQo+ICAgICAgWzwwMDAwMDAw
MDEwZGJmNTBiPl0gMHhmZmZmZmZmZmMwY2M2NzgzDQo+ICAgICAgWzwwMDAwMDAwMDc0NjVlOTNj
Pl0gY29uZmlnZnNfd3JpdGVfaXRlcisweGIxLzB4MTIwDQo+ICAgICAgWzwwMDAwMDAwMDM5YzIz
ZjYyPl0gdmZzX3dyaXRlKzB4MmJlLzB4M2MwDQo+ICAgICAgWzwwMDAwMDAwMDJkYTQzNTFjPl0g
a3N5c193cml0ZSsweDVmLzB4ZTANCj4gICAgICBbPDAwMDAwMDAwZDUwMTFlMzI+XSBkb19zeXNj
YWxsXzY0KzB4MzgvMHg5MA0KPiAgICAgIFs8MDAwMDAwMDA1MDM4NzBjZj5dIGVudHJ5X1NZU0NB
TExfNjRfYWZ0ZXJfaHdmcmFtZSsweDYzLzB4Y2QNCj4gDQo+IEZpeGVzOiBkYjEzMTJkZDk1NDgg
KCJudm1ldDogaW1wbGVtZW50IGJhc2ljIEluLUJhbmQgQXV0aGVudGljYXRpb24iKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiAtLS0NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K

