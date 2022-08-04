Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C5EC00144
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Aug 2022 06:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7kImp1PK373KKiYBv8/3dPT+WqgCnXf9cx2HZliZ3L8=; b=mDMBWsURAvHuiWpE/6xPuWOPgG
	24SwzSLyD/2wAq1/mtxMdK3buXcdwOtYqf+hzB+kw41q/849dDBu7btc5INFaYE76qFzCB0fQIhzA
	AfobIIlxdhpxqAYtG3tuV+8t0iBOsEP2/sNztbREd1TgokBScOfFI7qa6dhOHmAXNTEVKmOMd75Zo
	qopmockxXAX750Cls3ynwOPN09L6bDHU1X6puMyyZgQPayZ6lcZGMdQ7m1GX2nMny99oV7qfx8WK1
	ANEaqTYgRKXYKuMNGlb/CN0rJeu/Ni+r7plAZv3ZiJFX6ic1rRKpX92oal1jr/hJnDzzDv4SXB0AH
	bqZf2ZeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJUcf-003rTD-0G; Thu, 04 Aug 2022 06:46:21 +0000
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJUcc-003rRi-H2
	for linux-nvme@lists.infradead.org; Thu, 04 Aug 2022 06:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEB6fZXcRzwmIZU1L5P29GoOLIaf4iAKqky0aDsQUhfelUAWOwSd0NEH4o3qMskg0Wgbj3yUWCOTFHIj2qCop4oT9AEklxqKngYiJHFcKZMSlgtXCrawhzSaqRu8lw6sq9bxZy7BGrgoXKvKH97cmcJUivzmlwgeAMPyOUxDc58DKCEQX+GphsCa3X1Fay7MrvwLQox41Qvj7fyp5hjMUyXSJhrkqGsxlznjDev1VOte0a8uLHoUxvooEX8LYXdntzWuPsThLUmDyqDm5pQBva1GNcIrRiR/esBJCeJRE5YTut3d3HPwh3G1dO8xTS41yOQEFTb8AIzzR+CrmV0XCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kImp1PK373KKiYBv8/3dPT+WqgCnXf9cx2HZliZ3L8=;
 b=eWWL07f1hohWkIN1JrLxCBwo99sltIG7WIUwwuWCSoQcZeEhOz3kOGfEmv+QqdbG/mFl7JM9OaXBzW6MTpzmfQeSKPDgFV+ONc2OeGgUrLJsnowDhoxnjh4wuW3D2GR57Hzk5fEv+N79K1m8axhHzxamwLUcMd9fEypAmTXAXETsLufUxBZ6ub3SlEcQ9r5o0/EwhQLy1iQ4y+E/GVrQxcjp4aK9Xkj2JZTb1pGhv2Qsh9ncgDmSe+YnQk6CtnAv86Oa8TPucHG4qWBDrtCxaHqrbYLoxsW33f2jSHaFzQos2rHk9U9ozQ0NH3DzMH84zHluAQ2ghD0hJQMJNdf7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kImp1PK373KKiYBv8/3dPT+WqgCnXf9cx2HZliZ3L8=;
 b=H/mWJXNRsrcrE6hkD6k0TO9myYB+0rGLlUvDaSOPAuYlHSL84zrjR20DTopEtO2JeomD5PWJxDAghmn8vq8NNvzO8TNz2GkbozytJSA2akz58zt2bBuuRngeZLJEa7pjh+JgbA9gfPa6AwFhSpI3+P3uS3sTIiG31TGOKgMh2zL359m36+44l4cKmwym1Gtto3mZ1Xi0XVk6mI/Puw2hnvLTRuqE/TSOUFjzBltkZz+tHXgyH3yzB2VGxXoX2h6KBAEH3DcIIMP3+YGfpEWVgKC8vTFYcLSkO7+V7ZriLbioefY9c1KoxBfo5wUic+5f2MQQJ9JV/kqb/K37JLJQTw==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 BN8PR12MB3266.namprd12.prod.outlook.com (2603:10b6:408:6e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.14; Thu, 4 Aug 2022 06:46:14 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051%4]) with mapi id 15.20.5458.024; Thu, 4 Aug 2022
 06:46:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvmet: avoid unnecessary flush bio
Thread-Topic: [PATCH v3] nvmet: avoid unnecessary flush bio
Thread-Index: AQHYov69KrEHGxFHyUujzCpS5wI+oa2eVcmA
Date: Thu, 4 Aug 2022 06:46:13 +0000
Message-ID: <784f09f0-eca8-631e-2c30-55600893420e@nvidia.com>
References: <1659066785-88807-1-git-send-email-kanie@linux.alibaba.com>
In-Reply-To: <1659066785-88807-1-git-send-email-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7796667f-0f87-436f-a4a6-08da75e5063b
x-ms-traffictypediagnostic: BN8PR12MB3266:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  7orx2u1YKVPUFlDhBJR0T4v0AxJPgGymM74UUB/xk/mwSs9OIcVz81LsifZ7sR6FLmspf0a8BFN56HnbMfvoJfmZPzk1KBKjhaTor7L/ecKtxY1cSr8iP1FqMrId3JqeJokYPIhgKtdxDS98bvz8TQmXwGQf5QIF1gKdj1AngOoe64iqpb3l68dAEPsE82Yc9r2NZf28OwpZ3zd64JKY0EEUDAJh88MW00dRMqfKnTBUb5N+Gqu15DHR4au3j34P4ybvbbzQEjDJuXp01U/1y9K0ZUXAkhSMAru4VRuWeOd/4DzT7wRk+6HIIrTM4XSPx/GYQ9+ttJn4EtfbdduHlB6JTc8+SDdgQSvejYRlqR/4PBAfq7gvms/R6/LxWu2yO4KD3BJaYXDAnNdBJg74kI3YxRt/Z6efT40JvNVc4QKAccrpY3C8z3471DCX0qThPQqqBrtld6/ApiduleiW7WFATLAOtSDnkDQ1aeyeiF4XZgvqt+qmj7l+piOOI6T6x2r6KwCxbKRObCu7+FDvZY5X3cJH9sIyg5YKNcJ9unRlQB29IaZFWy90lPFbzIRiOI/4PkjUpKoj9M06XOzkimIPAMqXS861+xt9uOFYfNLmjogXh3JuovNaZoj11b9Z/Ic7UxhFkHylpJO83HQ6A8YDB5DcaXw/NIiQ82+irtvz8yhMj7GPJfUoqpcnphauwqvpFC6J3B2MTkvCItQUMVzT32r+ruFYpqy9ydWO3dDJ/Q7DwpSM3ttLx/E2mmmxa7lfCb8T4cp74qCXIb2zU3JIz92mE3034GKRMheB3xlHQ1HW5xpF1l+cfWs/z6Hpv3bgNretiXuMsGQhFqDwDHVWnx83dSOrZEPCoJg3gb5ATCkhiZnh1iQsSPvcBBub
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB4663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(31686004)(478600001)(122000001)(38100700002)(31696002)(316002)(6512007)(71200400001)(6486002)(186003)(2616005)(54906003)(8936002)(83380400001)(41300700001)(36756003)(53546011)(6506007)(76116006)(6916009)(2906002)(8676002)(64756008)(66946007)(66556008)(86362001)(91956017)(66476007)(4326008)(5660300002)(66446008)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dHFLSUFpTW1LNEtXNUZKV21Ca282bExBZTlSa2tNY2dnZGJQc0wzcmhyL2hv?=
 =?utf-8?B?bW5yS2dRN2R1Vk96TUpRYjRacnJVOGIxemxhamhRbm9LVklLb3VYaUZVTUhQ?=
 =?utf-8?B?ZWpPQWEwdldRVmp2WUxDQVRvVTY0QXVTNnpPMXZ1RG1HUUpmVnoyTnlGeG9u?=
 =?utf-8?B?dXMrM2VwLzFvYWRxczl1MDg4UFlBcC9QWXpXcGtKMmo2bEg2SVhHc20xckFM?=
 =?utf-8?B?cndPb2tENFlDWS9OUUZNSDlrSVA5UUhUbGRwaWpCNWxML212MjRUblRkeisx?=
 =?utf-8?B?Q2MxSVMwdnlXNCtDZWRObnhNbmRGQWdybUlMWEZXVXRGV3lxbGJydlNrZkZD?=
 =?utf-8?B?dEcwdCtRTkFoOHdQYU42R3pWM2pCMDgvUUIreW9GNFlhT0tlNzdIU2l4ZjB6?=
 =?utf-8?B?VnlvTTlmeEkySDF6b1hMMHY5Q2p1SlJQWnE3Y1R4TFhBZklHNWdUNHlndk9R?=
 =?utf-8?B?ZnYwTVU1RWNrNnlLME43K3V3ays4MVF4dytNYVVocG9jaUN4dG9wRkRjQThI?=
 =?utf-8?B?UHM4Z1JQM2lOVE1UcGt5Wkp3YTBDVHc1QVI1ZGVHU3N0ZkhkTEJpMXo4VmYy?=
 =?utf-8?B?TEoyb0pjRzZZMnZyRVRKM1F2anNOa0NiczE5R0d2WG5PM1J3bndiVlkzZ1Mv?=
 =?utf-8?B?UzhValdJVWtibWxMNnd4U0tlS1BFL3lQdWNTT1hnQUsyMVZkRkI2WmVrcW10?=
 =?utf-8?B?ekRaS1FJT1FocnFXdVlSbXc1TE13WE92STd0Qkk1Q3lUT1VTS244SlZxcTk1?=
 =?utf-8?B?RjVYdTI5b0ZZMjIwODE0L0gzUWhFUW1rZFd1L09QTC9mNGVkMFQ5eCsrNng2?=
 =?utf-8?B?WWNQSlpJNUVHTXNnTzVSVTh6VzJpQm5TS1BFVGdiTGF5cGQ4Wm9BdzVSa3NH?=
 =?utf-8?B?MlBJMFhFNGs5eXRIWkdBUUxHaFY5TnJERWF5b1RQOUkyQld0NUQ2Qm9ONzhD?=
 =?utf-8?B?LzRWMmJuS0VmbTdnWFRWelVxbDZSeGtjbi9IYklMcE53c3czSzl3K2RRRzdL?=
 =?utf-8?B?RUJYVzEwRml4MUZDR2Z1amVTQWREUVdsa3pPOWoxemRyTm1OUFIxN1FkOVJD?=
 =?utf-8?B?VGpTL0JpcUU0eERjSFdkTUUzemJjN21rTE9xU2VUblRFQXF0OTNGK2kwd1B0?=
 =?utf-8?B?YTNMbG1FY2tHTHBwKzhLN2xiaHFqS2FhTlpFeVJHRHhrMHVDbmwxd29oVURI?=
 =?utf-8?B?UGo2MnpLSXpoR0V1TS84MUNhMU5ieDBBMmlqR0FwWXdnSy81RmJ3NWtBSWt0?=
 =?utf-8?B?Y011bkxoKzVJKzd5alZDdEdVLzAxeUN6NTgvenVUYlVPMkdZZ2lmdUIxd0lP?=
 =?utf-8?B?eEVhTExtQjRQNUN1c3lvVzJIbFpjTVFEamZiMHpzVlNDYmo4bzBJdzRiUy9O?=
 =?utf-8?B?QUJQazJrUy9SMGRhWXl0N2hQbnNEM2M3ZmJzaElEd0x1RUdqYVFSMzFyeDVz?=
 =?utf-8?B?SS9WUGRteXVMQ1BXUTIwaHpoK2JCdjYwYWwvNFpIRGhwZDdJeXA1YXczdHE4?=
 =?utf-8?B?K0xkRmhNeHdmVkNWU1MvaS9DZFRsTFBDazJtMDIyT2ZsbzBEZFFaczlCYmdC?=
 =?utf-8?B?V2J3MEtNWmZkakw5NmZ2cEQzQ2MrMHFqSHY0YU15TEJCMTA0MDRnU1BaVjhR?=
 =?utf-8?B?OFV5NHo5cTVPQjJvRUpsK2d5RDJhcG83TGthWHFGSHFFdGg0dGJLeFcrQ1Jv?=
 =?utf-8?B?S3ZMbHloM2hVeVNTQytqVDdKVE5kNFhreDZzTmNuMmE0S3FibjBWZEwxR2sy?=
 =?utf-8?B?MlVvaFhhOERCM21rUkZ4QU9DdzFaYnpZU21oVThGN0h2a2ZWbWlUVEdqbEFW?=
 =?utf-8?B?Z3RWcmZsUkpVVkJ6Tm54aHhvYU9sd0hwUzB3eCt6Vjg4V0hkR2Nway91S2xz?=
 =?utf-8?B?c0l6aW1ycGZBbmNTajRGaU9wajJybDMzY0hZSHlmWndvb2R2ZG5CU05wQm9Y?=
 =?utf-8?B?VVJNRUpHeXlSbHRTcDZVTHgvaEJFZmpRYjdod3Fub0VpRkk3M0JVSTdUM24x?=
 =?utf-8?B?Zm1yYmFtUlJGQnN2OVduRDZIcWFBa28ydjR1Rm1vTmdLUjhZR1AvTE4rY2Zo?=
 =?utf-8?B?MGFia0VJRXpXVm9VUFB5dmhlYkdvWmlwbmFSc3VzQ3dkREE2MHpUQ1pDczNk?=
 =?utf-8?B?Z05vS3dHdnRrTHE5Q1hBUEdKOWZhNU9EQ2ZiRjZiVmdTS252L1BhMkxuQjFx?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D83118A7FA33E84AAC3B78325FA1DD5B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7796667f-0f87-436f-a4a6-08da75e5063b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 06:46:13.8722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3LrjepprVAEDHms68aIG5K/pgQPCR30ZksPzYv0PrfshkI9BgqBLt30P0DlMlszSrieySD7k/Ug9tQKriBe3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3266
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_234618_844566_E84387ED 
X-CRM114-Status: GOOD (  15.72  )
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

T24gNy8yOC8yMiAyMDo1MywgR3VpeGluIExpdSB3cm90ZToNCj4gRm9yIG5vIHZvbGF0aWxlIHdy
aXRlIGNhY2hlIGJsb2NrIGRldmljZSBiYWNrZW5kLCBzZW5kaW5nIGZsdXNoIGJpbyBpcw0KPiB1
bm5lY2Vzc2FyeSwgYXZvaWQgdG8gZG8gdGhhdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1aXhp
biBMaXUgPGthbmllQGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgb24g
djM6DQo+IC0gUmVtb3ZlIGZpbGUgYmFja2VuZCBjaGFuZ2UuDQo+IA0KPiBDaGFuZ2VzIG9uIHYy
Og0KPiAtIFVzZSBiZGV2X3dyaXRlX2NhY2hlIGluc3RlYWQgb2Ygb3BlbiBjb2RlLg0KPiAtIFVz
ZSBOVk1FX1NDX1NVQ0NFU1MgaW5zdGVhZCBvZiB0cmFuc2xhdGlvbiwgYW5kIHJlbW92ZSAiZWxz
ZSIuDQo+IA0KPiBUZXN0IGxvZzoNCj4gLSBBZGQgcHJpbnRrIGxvZyBhdCBuZXcgaWYgYnJhbmNo
Lg0KPiAtIFVzZSBudm1lX2xvb3AgdG8gZW11bGF0ZSBudm1lIGRldmljZS4NCj4gLSBVc2UgdGNt
X2xvb3AgYW5kIHRjbXUgdG8gZW11bGF0ZSBubyB2b2xhdGlsZSB3cml0ZSBjYWNoZSBibG9jayBi
YWNrZW5kDQo+ICAgIGJ5IHNldHRpbmcgZW11bGF0ZV93cml0ZV9jYWNoZT0wLg0KPiAtIFNlbmQg
Im52bWUgZmx1c2ggL2Rldi9udm1lMG4xIiwgdGhlcmUgaXMgYSBsb2cgcHJpbnQsIGFuZCBjbWQg
cmV0dXJuIHN1Y2Nlc3MuDQo+IC0gU2VuZCAibnZtZSBzZXQtZmVhdHVyZSAvZGV2L252bWUwbjEg
LS1uYW1lc3BhY2UtaWQ9MSAtLWZlYXR1cmUtaWQ9MHg4NCAtLXZhbHVlPTEiLA0KPiAgICB0aGVy
ZSBpcyBhIGxvZyBwcmludCwgYW5kIGNtZCByZXR1cm4gc3VjY2Vzcy4NCj4gLSBGb3JtYXQgbnZt
ZTBuMSB0byBleHQ0IGZpbGVzeXN0ZW0sIHRoZW4gY3JlYXRlIGEgZmlsZSwgd3JpdGUgZGF0YSBh
bmQgc2F2ZSwgdGhlcmUNCj4gICAgaXMgYSBsb2cgcHJpbnQsIGFuZCBubyBlcnJvci4NCj4gDQo+
ICAgZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jIHwgOCArKysrKysrKw0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQoNClRoYW5rcyBmb3IgdGhlIHRlc3Qg
cmVwb3J0LCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

