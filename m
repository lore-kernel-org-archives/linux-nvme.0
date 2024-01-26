Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAFEC47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=58/+EudhRwixn1dQPukYXxsZ4gBykykO2PmowK+d0P0=; b=CA4fHV3pzs7XAYeqtYnVsUejG1
	Mv9Om8Af6PfAOqFEOSGT2DQRCAMpnOpfoSFreMrkBv8AdCefhAY7CV0EigenyDVvCP5JAlQsikrqQ
	p8BX5pmI3BsMG0I1243ObmHCPWcs/VEAd7d4OpSBDcl0xAF74yy5EfytvqdjqLyKojv2vgDKjyVkc
	Ysfr9UvCh2gMrsB+M+R1Ndct2Bcv2QCcmH67lBDtUgLsxeTOXmsqhrzxTIU15z/07zGlx7m0Nwz7A
	8pc0NvZcyPMSzlrfVjRETAPPMwWf58sQgLBgDqOd/N5XpxVWstgDdGRkr40c8o5Sal1NhbwSB4W3+
	hmK1rb7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTGWG-00000003Knr-3UB9;
	Fri, 26 Jan 2024 07:20:56 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTGWE-00000003Kmp-23ew
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 07:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xudv8Z1DJhJGfeaz0Gttffk7QScRJFmL/7QbFLVSGtFzQRntv0oQzkKezmAFhGQu8DTz4ly5StribTYXj4neNatdXEkNl/oMVEYbQT0S109IG26t1zDQEKOkfkkWWv4zXQBQP89/r9QrOZofiNXwzefBKr7ezaik4cxi+jZ24N1cdvjeBPWmjPMLcIeMtTu7ef7b1qnsHFAPXQeF2LJAxo9rDbFkyj6zNlSUfiN5eEmbZuFcd3erbVZFJLeOvGvlEfELYt4OJrDhGIItFtxKDPOCH0669cUFvELTznyQoJNC4+rYALSPcu3NFOLh6MvpvVgWw3G8s0Lr1NlUQDE6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58/+EudhRwixn1dQPukYXxsZ4gBykykO2PmowK+d0P0=;
 b=ZlWWjvh6pmBSlcH1TveZpHF4KjgJYMutvrSj8N2V1B2Nzqpz5SXTBXHIfTfQduIoIzmSwnvlNSStVPQ23R3/Tdb2UhywqPwQN6l1Ew+R3r1jstkIxXZqk+cucSFnRn+AaCqvhBP3vbtGRBaQ+dM47Az+Bxep30lECzBhctStmChtaXw/S3JEeso+k3rHcOo+WFrT7YVHNQmapyQJucm/x1FWHLBAzK/Tpv0OEwsofcDiBi9h7tm4fwU8sQNtECD36NHfQP7BVabcX+lSQkbRvhxiMLJ374AiS7b3IpxMjxJVVBcMMIiKR/L56CngCi3+X/8NzoQK5w+nuXnLteXpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58/+EudhRwixn1dQPukYXxsZ4gBykykO2PmowK+d0P0=;
 b=JeDFKT57L3Z1GKWoCrOz4WHPILRb0AShXBAUz42RRRLNDcSL6lz9vUQ7Klr+xce/TdBU74ttby1nMljxqyk3HvM7DCoNY3Ph1oOZZF4DzY2Q3eQud8Icr8Dr4K+XU/Gu+cBHAsnlmefwdrsd+kT+Mni7hj4e77CFHODNhdXr9hUZ7/307WpwUfTt+rkanhHdKdTbIGVs9KZwxFixi6ZANJdP+2zP6WfTBHmhMxTup4w5nmLcK0JCwq/hCaK53w4DK6nkTnAOzfvW2fKoHAI35QHoyzJy2ipEIjfM/9prlU70wQP0J/NlZOUl9pKxITAk8Ia7KIJQCrQVis6ymZAvqA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 07:20:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 07:20:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "sven@svenpeter.dev" <sven@svenpeter.dev>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2] nvme: use ctrl state accessor
Thread-Topic: [PATCHv2] nvme: use ctrl state accessor
Thread-Index: AQHaT6aBj2KydFX2G0mmuY1T9Zjm4LDrsQaA
Date: Fri, 26 Jan 2024 07:20:39 +0000
Message-ID: <6286227a-1169-4068-8a44-1bd856be37d6@nvidia.com>
References: <20240125155213.3727106-1-kbusch@meta.com>
In-Reply-To: <20240125155213.3727106-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4330:EE_
x-ms-office365-filtering-correlation-id: d6e7cd68-0453-4ab9-7fe9-08dc1e3f4c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRMrbPyI7jg0HE/9tYRzauKoicYWDJbDFzLtkzZnFEiUyRFuBea+ihubEJYZwl2pHimWCe6w4bii9tZWiNnYQtI5im+VcXj0hc5LWs2CF1iZa1m1N/SBnNoQzesxJEvsSto30r/Nzb8YcyMKZwij57HEKUpwxktUMtshJ5khLL4LRJrC0Ns9VTiE0Pzg3eemhSh3olrDXQFY7/2jfqgeHxAw9z9NkcsaKDQadJWf/cZMZVBvELG3hoyq+C0l1TZ75gAUPnFQMGCtzi3qssSnNsQZl6bpIsVmJWiVOeZOKtzThmtpdfXHpNeSZUMHDf5OEPSn+Icgg1INj02644qQMplVmrDTSG+Mht7bU11V9bO9tVJXtmNqiIszWA8cGzlRlSO+9i9iTFAQJ5tL+9ra9Sc3F78HAYlf78DxcxQ/6/emqtXC8iscu42zVUqRIS8uQFJnjVggsgNkBJMkZzd/+VAQO5AYUnoLfR8Lz4I2UUUg1MK50c6Yi+nJ2Sol91rU8NpUYM1zuECdj3MWgPd/k5oNVOShTQsiFMvSo77EmdEaIw0jSBqz9uY1tyq7bIwGejdvzuVLxtjgr50iWjTmYZ9Ns69ruh/wsUYzjNes1Bucrnb+2POp3IQgKGVv7zYTS75nxQbkEF84QHpRfz/QZYTxhoNo7cOgo3vx+pG+06R/LDd3WLkTUx2Pif4UWn20
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(83380400001)(478600001)(91956017)(31696002)(86362001)(38070700009)(36756003)(122000001)(2616005)(38100700002)(6512007)(66556008)(66476007)(2906002)(66946007)(6506007)(6916009)(64756008)(316002)(66446008)(76116006)(71200400001)(53546011)(26005)(4326008)(8936002)(8676002)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlZ0WDhMNjQ2UVZEb1owRWdVTnBBS3JuTjF6dGlOUDZpRkV4eHZRVEFGdG1N?=
 =?utf-8?B?S1Y3Qmo3TkozWjlKbDJsdm5MeVc1UDNlZVk5ZzNTSU1YZ3NlMFZ0a2FyMFoy?=
 =?utf-8?B?NDF1Zjk0QXZ3UDNnWXBSWElQYkp6bm84c3JkRUs4bFh0MnBwK1BBN1ZkeWx4?=
 =?utf-8?B?U0NnaXJhY1lhUXFZUnNoZHlpUnR5eXRWYlJvU0k0d3htQXhtNzBrZUltWUh1?=
 =?utf-8?B?R3kxMlZuUWgwZGdwWENxTFhiTlR1ZnRvMisrTmFRK3hBdFBiZmtWRUsrR1JI?=
 =?utf-8?B?OCtEZ0NkbGpWeEU1cEhyTUkvajNZZDRYODc2elh2elV2U3E2TG1oc0Y3TEJC?=
 =?utf-8?B?Uzk1aUhxVzQyNkt4QTNicGEyMnRiZzZXdGdKL1VsS3g3cTQ5V3FkUW9kRU4z?=
 =?utf-8?B?Qy9tUzMzS2c3R2tabWc3enlEWGdwZzNXbzY1K2xTcmFPTTdyL2VBUE1KZmhs?=
 =?utf-8?B?V09UWGx5TG43bU5VaE1NV2JRanNXSXR3ZXRYWFhBZUE1bzhEVFdsczh3MVV0?=
 =?utf-8?B?a0tqMnRCcGtOTW9zeVF0SVZHVy82d2swLzd5R2M1TjFvWmZpY0x1Zm5mRGJk?=
 =?utf-8?B?OUI1dTRrdld6M2hMUzB3N1BvZ2M3Zi92Y1lZanA3dnVXbW9PNnRFUEF2WlRk?=
 =?utf-8?B?OG83bUV3QWFXai9SdDdnTXJkRGlmYkk4dWVweHNmaHFydGRKVGFDK0dkZ3NT?=
 =?utf-8?B?K1MxeDlLZTVsdXhIcTZPdVljb3pvRTd1NlVsWlk3N3EzVWpLbytqZVZpVW5P?=
 =?utf-8?B?cDdNWlFWY0wzbUt6OWh4djZHeStpZ1dOeXNlOWwxbVhtZFdYVmNDVkxxUXJG?=
 =?utf-8?B?Vk5mdm9Wa1BITzVBUVRrTjkrZTd4bzR5MGxUVmwrc2o0SSsyNkVPSHpzS0My?=
 =?utf-8?B?NVg3dVdtOUp5WENkSWlvb2c3UkNvTmZRQ2piOTVoM0xLdVpMcHFiRHVqSThO?=
 =?utf-8?B?Q2pSRUQxWERxZ0dhbk5FZlphV3QrT1hpRkFxQ3BXS3RkZGY1aWNRSTBMVGFh?=
 =?utf-8?B?Qlc2WjBicTRkc3ZvMkJSaW1wa1hrUkhWb0g5cmhCQk1oSGI1Mmo5VmxpUzh2?=
 =?utf-8?B?dWFyQ0J1emdDZjRIRzZZQTlyNWlEalA0dEtEeitBU0ZLS0tiZUF1NzV0bnZG?=
 =?utf-8?B?UFdjY3JvN0wrSlpuRkFjK0VubDN6VHdid3ZxSGd5SnF5aUpjcUlJTlVKbWNB?=
 =?utf-8?B?OTZJUGpsdmJXeWFHVDlVVUxDeHAyeVRZUUhrek9URDFUdUFpOUFKZXVUUzF3?=
 =?utf-8?B?ZjNEbzBYUkZXbWlaK2YwcS9wZmVFYWo0eUgvT2pPU2dMVlhXdnJCZ284M0lB?=
 =?utf-8?B?WGpiclVWYXdPeVpDQXdJZUVBZ1hHb0VmOWNTbE4yc29pNG1wYlRNeGRSMzhp?=
 =?utf-8?B?WWh2TGt6bi9Qa1dnN1Ewa3Q4QWZHNmN2ZjhnMW1oM3dZdnhnbWpQTFNSQ3JE?=
 =?utf-8?B?V3JwdENYNHJVWHF3MWM2a2FJS3ZYZzFFSzNtaGdnOUtwUERXZ3R3VzFiWEhC?=
 =?utf-8?B?L0JuZWJJWmxOYW1sL2hzOE9iVmY0Rk1ER2hBK3Q4dm1hb3YyRTFHd1k4Z3Rx?=
 =?utf-8?B?NkwyTGFsczJvOUtWNWhqemYrWXc1bnJVV1NCU2lsV1JPTU1UU2ZsdDBFdkRi?=
 =?utf-8?B?NjNUbUlSQjJ6eWYyT0lZcUpjVVZ2RjQwSEpjVVp5U1VZZjNvcVRucDhFTXlj?=
 =?utf-8?B?NzZvRmtRTFpLdzY4S1VpVjlPNHRXV3lZZXgrbCtpYzd5NkplMFJLUjFHTStk?=
 =?utf-8?B?WDhpZVFFNEZGaXVlT09VYlB0NUlzSDJTNXZkUGd4dmd2Rkd5UnllMFB1ZWpj?=
 =?utf-8?B?cmtDV0lnc2ExLzJpYi8reFd1cThaNDdlSFhETVFGZHlYOEd3b2YySG4vTTl5?=
 =?utf-8?B?U0VaZDJoekExNDNlV1pRdXZZZjkxczltSEIyUjkxZzlBU1FHM1lycVluVy9z?=
 =?utf-8?B?NkV0RGxhTk5DNkZiZFpRbnhwKzNSR2J0a084ektYVzdGV0cwSEkyM0ptM2RC?=
 =?utf-8?B?eHBwdVpsd2NIK0xEZERWb1QrT3B3SG1MQmlCckd0UTRwZHMvOWFLMUtQOFRm?=
 =?utf-8?B?K29qaG16N1BJR1IwTjhKNFkva0F2cmJZNTBBZTBJRGdVYnd2dGlMTEJmaDd0?=
 =?utf-8?Q?MZ982xIq5crskQ/W+IDkqdkYx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90897EB8BF308540BA446C72220CA352@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e7cd68-0453-4ab9-7fe9-08dc1e3f4c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 07:20:39.6066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sg7v6wcPHc9pQAQMomz1AuFNG54NXDjpatmoJlGnmt4E3h0abgdGv1mTqjuYTL8bOE6il34WUirDVKFKZoIr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_232054_558080_28CD6DCE 
X-CRM114-Status: GOOD (  14.15  )
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

U3ZlbiwNCg0KT24gMS8yNS8yNCAwNzo1MiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtl
aXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gVGhlIGN0cmwtPnN0YXRlIHZhbHVl
IGlzIHVwZGF0ZWQgaW4gYW5vdGhlciB0aHJlYWQgdXNpbmcgV1JJVEVfT05DRSwgc28NCj4gZW5z
dXJlIGFsbCB0aGUgcmVhZGVycyB1c2UgdGhlIGFwcHJvcHJpYXRlIGFjY2Vzc29yLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPg0K
DQpCYXNlZCBvbiB0aGlzIHBhdGNoIG52bWUvaG9zdC9hcHBsZS5jIG1pZ2h0IG5lZWQgc29tZXRo
aW5nIGxpa2UgdGhpcywgcGxlYXNlDQpoYXZlIGEgbG9vayBhdCBbMV0uDQoNCi1jaw0KDQpbMV0g
T25seSB1c2UgZm9yIGRpc2N1c3Npb24sIGRvbid0IGFwcGx5IG9yIHVzZSB0aGlzIHBhdGNoIDot
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9hcHBsZS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvYXBwbGUuYw0KaW5kZXggNTk2YmIxMWVlYmE1Li4yNTI0YzlhMTNhZDcgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9hcHBsZS5jDQorKysgYi9kcml2ZXJzL252bWUvaG9zdC9h
cHBsZS5jDQpAQCAtNzk3LDYgKzc5Nyw3IEBAIHN0YXRpYyBpbnQgYXBwbGVfbnZtZV9pbml0X3Jl
cXVlc3Qoc3RydWN0IA0KYmxrX21xX3RhZ19zZXQgKnNldCwNCg0KIMKgc3RhdGljIHZvaWQgYXBw
bGVfbnZtZV9kaXNhYmxlKHN0cnVjdCBhcHBsZV9udm1lICphbnYsIGJvb2wgc2h1dGRvd24pDQog
wqB7DQorwqDCoMKgwqDCoMKgIGVudW0gbnZtZV9jdHJsX3N0YXRlIHN0YXRlID0gbnZtZV9jdHJs
X3N0YXRlKCZhbnYtPmN0cmwpOw0KIMKgwqDCoMKgwqDCoMKgIHUzMiBjc3RzID0gcmVhZGwoYW52
LT5tbWlvX252bWUgKyBOVk1FX1JFR19DU1RTKTsNCiDCoMKgwqDCoMKgwqDCoCBib29sIGRlYWQg
PSBmYWxzZSwgZnJlZXplID0gZmFsc2U7DQogwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBm
bGFnczsNCkBAIC04MDgsOCArODA5LDcgQEAgc3RhdGljIHZvaWQgYXBwbGVfbnZtZV9kaXNhYmxl
KHN0cnVjdCBhcHBsZV9udm1lIA0KKmFudiwgYm9vbCBzaHV0ZG93bikNCiDCoMKgwqDCoMKgwqDC
oCBpZiAoY3N0cyAmIE5WTUVfQ1NUU19DRlMpDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRlYWQgPSB0cnVlOw0KDQotwqDCoMKgwqDCoMKgIGlmIChhbnYtPmN0cmwuc3RhdGUgPT0g
TlZNRV9DVFJMX0xJVkUgfHwNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoCBhbnYtPmN0cmwuc3RhdGUg
PT0gTlZNRV9DVFJMX1JFU0VUVElORykgew0KK8KgwqDCoMKgwqDCoCBpZiAoc3RhdGUgPT0gTlZN
RV9DVFJMX0xJVkUgfHwgc3RhdGUgPT0gTlZNRV9DVFJMX1JFU0VUVElORykgew0KIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcmVlemUgPSB0cnVlOw0KIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBudm1lX3N0YXJ0X2ZyZWV6ZSgmYW52LT5jdHJsKTsNCiDCoMKgwqDCoMKg
wqDCoCB9DQpAQCAtODgxLDcgKzg4MSw3IEBAIHN0YXRpYyBlbnVtIGJsa19laF90aW1lcl9yZXR1
cm4gDQphcHBsZV9udm1lX3RpbWVvdXQoc3RydWN0IHJlcXVlc3QgKnJlcSkNCiDCoMKgwqDCoMKg
wqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOw0KIMKgwqDCoMKgwqDCoMKgIHUzMiBjc3RzID0gcmVh
ZGwoYW52LT5tbWlvX252bWUgKyBOVk1FX1JFR19DU1RTKTsNCg0KLcKgwqDCoMKgwqDCoCBpZiAo
YW52LT5jdHJsLnN0YXRlICE9IE5WTUVfQ1RSTF9MSVZFKSB7DQorwqDCoMKgwqDCoMKgIGlmIChu
dm1lX2N0cmxfc3RhdGUoJmFudi0+Y3RybCkgIT0gTlZNRV9DVFJMX0xJVkUpIHsNCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIEZyb20gcmRtYS5jOg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
SWYgd2UgYXJlIHJlc2V0dGluZywgY29ubmVjdGluZyBvciBkZWxldGluZyB3ZSBzaG91bGQNCkBA
IC05ODUsMTAgKzk4NSwxMSBAQCBzdGF0aWMgdm9pZCBhcHBsZV9udm1lX3Jlc2V0X3dvcmsoc3Ry
dWN0IA0Kd29ya19zdHJ1Y3QgKndvcmspDQogwqDCoMKgwqDCoMKgwqAgdTMyIGJvb3Rfc3RhdHVz
LCBhcWE7DQogwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFwcGxlX252bWUgKmFudiA9DQogwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgYXBwbGVf
bnZtZSwgY3RybC5yZXNldF93b3JrKTsNCivCoMKgwqDCoMKgwqAgZW51bSBudm1lX2N0cmxfc3Rh
dGUgc3RhdGUgPSBudm1lX2N0cmxfc3RhdGUoJmFudi0+Y3RybCk7DQoNCi3CoMKgwqDCoMKgwqAg
aWYgKGFudi0+Y3RybC5zdGF0ZSAhPSBOVk1FX0NUUkxfUkVTRVRUSU5HKSB7DQorwqDCoMKgwqDC
oMKgIGlmIChzdGF0ZSAhPSBOVk1FX0NUUkxfUkVTRVRUSU5HKSB7DQogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKGFudi0+ZGV2LCAiY3RybCBzdGF0ZSAlZCBpcyBub3Qg
UkVTRVRUSU5HXG4iLA0KLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYW52LT5jdHJsLnN0YXRlKTsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0YXRlKTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ID0gLUVOT0RFVjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7
DQogwqDCoMKgwqDCoMKgwqAgfQ0K

