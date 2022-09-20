Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091F9C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W4Bi1E0hb6C4/lgB9R4icyf2xzHzTtzBUUmWHw+OPns=; b=vHFrzlwCgtalX6YpBZyT3dpD3G
	jLoQZQCLYrDxW4bUF7Nb5+plPhAbgJRFm0gKo0UM2vsA7kfXgMXYCt5PgeFWMB5Egnml1YGVIfz4Y
	dNv98TbuO1m1DOwW5P4m6SIAk+oYN247HIUH1+P/MMklS6Wp9b8MIuiiiJ0O56RLtbl64+RkSAVGR
	qyaMhLl/qTPC1ZZ4Zh4/6W6NsITVGbnZ7E2Hv+TNb9DuHO5Or5895QqpbyAVbJtDxTmAd9ck/MOYo
	1Be60nhAY9RSkApfdHCE8/RjWXNSOX0LU7hea/UFiCHgjdVDjMN9SOVOOXg53CJCVoFDTxAp29FgH
	AEvxvBNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal5Y-007CxF-0b; Tue, 20 Sep 2022 21:47:32 +0000
Received: from mail-mw2nam04on2057.outbound.protection.outlook.com ([40.107.101.57] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal54-007Ck8-8A
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/7kIh+23im5ZMceIDv3Ye1aL//tU8ldFJkEUD6RpfJc/OxT7ggzUcJGovPPLDvbacUBYIEsBfEaafGB/QxKt/yt2pDBWyzV/KWzWU2Dik6sIhDZQcHG8sI4xx+E4fYKEvOPb5VrlfnocKwVYzyIkEqlfY2z02JmMv/Ygzz9jbStyrypkSlJ7aSfkrphno/KRNKzK0ySSdQgPy2GhoiH1WWtaQjmSbqNYyphfIjLdEa/pHLlMvcrqc7oeGGuKkP9zKgdeQO6H4kP85eSvC2oYIj9XHrmWxzho5qZcI0WuqTzmvoMkwsApvw2DJRe7rTLj9MtUR5rp7RN0n1XmfgDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4Bi1E0hb6C4/lgB9R4icyf2xzHzTtzBUUmWHw+OPns=;
 b=gYywQGr/mMTWtY7XKraHGkf8IblvS0QoilmLD9tbpyZmY05npeB11EETK79uyqA2qKkgRtvzM2wkQH9X2eni2C+KOZ4SgzOELCWy/azK0V6WvF76DiH5UFJzkUP+QeyfFTYcUGIKGLzabKh1GAeON2XnZe7d+PvIEPaiVdcxAqs1ASeGwkg38QvFckljs79iDeTg3EI4swlLmjvjDKUgI8cXcd3FLBqDRmJQYd0AdU51BocNXJYJYRJc3cZA4wRgBno/Za/AfplmYrwAmVCQSTTdUlo8qfZsM2VuV6xv4b8Rx5AWZdyxHbOnGClB0pJK6u36t+JGeOoQkdHs6AuzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4Bi1E0hb6C4/lgB9R4icyf2xzHzTtzBUUmWHw+OPns=;
 b=GNcR8CC0W4uOgp96wZgSyKQCJ4wJwBbBGU6FUERfNqnYpqWOQ4zTOi2SRpoZ7YaAUO1biuaEhFFmqGBi40gnLzMCr+hQ2XdxE34oH1Uh36u5jAQOtKg9yqgCrDvji9xtUozKNc74s/sS8mDMqwm1Mvvxu4ckn0hWP+ItiIIKSZ0V3U/wprUn+ENQHYjcdgN4S43QBbQnLOURJ9/9yhomDDUQyxURpmZ+UcPIiCumd+r1jZjZRPNAlFV8jo+wLVX046RsfvJcL5Nu4Xb2oGqccBXXicW/EoeZGUFh6sUYOC++NktMa4Z0L03fVigp/BDe6Nry5LyHhP2MrewQf05qwg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 21:46:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:46:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 13/13] nvme: remove nvme_ctrl_init_connect_q
Thread-Topic: [PATCH 13/13] nvme: remove nvme_ctrl_init_connect_q
Thread-Index: AQHYzRUUd9p22qJoXUu1dydJoXDAy63o2tkA
Date: Tue, 20 Sep 2022 21:46:58 +0000
Message-ID: <76c215b6-c5ec-b16f-8141-0710b1913924@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-14-hch@lst.de>
In-Reply-To: <20220920171611.1289361-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: a9e7ca2b-e975-4b5c-5023-08da9b51a4af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  vugRvteUYSMlyuwcfJwX1KqPQ25pavXtBuqW96ksxScba5PcjdWqOfV+fa2HBf9hcrtLW/VjYeBCyFy9s0qMUxiOCb2+NlTNmmZ6IrC2XNOGhXeCWPK/FGhl47v9Li3hWtJrDKNT916v9pBjamnOx2eqNqs4UKa3b9krAQ7n8gQIy1gTaOucjTBa/x/YQm0cuWB9PhdYnh/aJpLBIG7Fw0mTuP3L1Fo4lhSaATP0QhF6rgqiHMAk1ARQFF5l/gUSVV/Jl9NU0WxzHUySIc0R1Xq0v26nEBPr8TXXIA6DW0RxCS67SrlHY88txhdW+r/9TSba6I9bkJyMauT5ydTs5BLhGlNCCO8Y2VAEJi/8iGgI/UP7is2GFyl81W+ECWFmryBFYdgSky2hc7CYxggplNGmc+i53jcIkqctgNRoKkapI7hdX6+6J7du2K0wW/zE6h9wG33Vpz6/GinrA7lh/77VciLJoqZ+qcfq6jjy8GEZCjTfnhFs3z+GdauwxA6uve3zPA++m4X97vtLuopxRNrkHuC/wDtP8wNlFY4v8Z1m2wbc09moDUpvUgKR805wE4eVWv0EAtqUmudYbBAPeNeqD1rD3lVPL19L21K6pG5FuWwozpLa+gdEdsD2sRAuGOx9oBBVkWJ5wPxywIDyaCYKsfmBqFCHGG4zp3wwSWOA9Y9IPoK8lSUeWbuWW4aoswONojsMN6qOF6x2pp0dLkfbP6EkoTUJvZJLEt8r++ZdaRO3dvJ2HFK8wFDRxHbCVfPt6Rd+Yq5nceF4kDn6JkvHeEGi9a/tXBiKqTqja+kqQYhIdIeNWTGfj8YnykekJOr1WMewsFfsA6Pchg6NmA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(31686004)(478600001)(36756003)(66556008)(6486002)(558084003)(66446008)(91956017)(76116006)(66946007)(8676002)(54906003)(6916009)(64756008)(71200400001)(41300700001)(4326008)(86362001)(31696002)(6506007)(53546011)(38070700005)(66476007)(8936002)(122000001)(5660300002)(38100700002)(6512007)(316002)(186003)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?R3cwS3FxUnJycGY5Y2RiQnVZVy90eEF2ekRCOEhIa1g4NDV2UERRRllzbmx2?=
 =?utf-8?B?REFOTlZ6cUpaVFluUmNvUmpINnVoNFZMcC92eSt1dEw3cElRUjZtN0tZb1Jp?=
 =?utf-8?B?Vmd0Z2hrUEhjSkdXRWxEbWZldDhyRGVGbnVKQUpKb0J0aVQ5NlByQUhXR1RY?=
 =?utf-8?B?UVBmLy9OZG56MHQrWk5lQVRnYWVkVFVRSXRYR3l0d1d4QUwrNWN3UDRheXV1?=
 =?utf-8?B?NXIwYU04bGxBK0tob3g3cWJHQlFyUnA1aDM3TEQ5Z3huQnNhRWVQb3ZMUTUx?=
 =?utf-8?B?TTRzckVSNEwzbGVqM0cySWlJcy9Gb1NJNFg5a1lLSGZ0dUR1Nit2VjgyQzBF?=
 =?utf-8?B?eU80ZTNGMVBscUZORW5qODRtc3JlcWt1TWhXM0l0eWxTQnRYRmZLUjNjSWpu?=
 =?utf-8?B?ZVVXOXk4MTNkWUx3UGVpU20zYXVBS08xYVB5a0ptWFRuOVJHSFBBU2dqYjNq?=
 =?utf-8?B?ejVsNGxNa3QwWDhkK0kwenp0MEdUakZiamdkcTYyQVh3cUhOOEQyaEhpOVZX?=
 =?utf-8?B?WG9wdFFyMzJlN0FLYnZnM1pHTHhHZEw4ZFhNWHdyZUJweGV1RXV3b2E1czdu?=
 =?utf-8?B?TmdQa0VlY2liTXcray9SV1ZJdllEWFV2MWNSRWNIaHhrTjFTd3lxTk42V2Z0?=
 =?utf-8?B?K2pBRDJXa3ROVU0xamErVGcyRG5heWFqTk1WSFFMclBkZVlwOEthd1hpaFB5?=
 =?utf-8?B?MGtINGJuTHNjTjZUUm53Z1A5R29QOVp0RlRQQU1tL1R1VDJKSENXSjJHK0lL?=
 =?utf-8?B?dVgydWF1ZXRSYXRabHB3c01WUmM4ZjJhUzVmV3J0TlRkeG9Mczd6UmtvQ0ha?=
 =?utf-8?B?cGhFU0Vlc0k3VTBOSmp4bjhFMTJrY0ZIbjhOV2NLVDFiNEdzOWJtRDNOV3I0?=
 =?utf-8?B?MktJN1l5cTdseWk4NTJ6ZExobjk0em90THU5YWlJSGY0aUdpOHJ1RW5qZVhn?=
 =?utf-8?B?ajZCdmVRS1B0Q1FuTlFWU2Q5Qm5kWWdtL2Z5c3RjcThpL084YlFLemp2NUNN?=
 =?utf-8?B?Q2hhZStOeFB0K0dpR0F1Y25UYk42N2gzWXVQS2w1WVhFOE9hY3V1V1V1b3NF?=
 =?utf-8?B?WnJJZURVV0V6QTJGTmx1eVBjYlpFTjRXSEJpQVhwdWpLbUxkMHJmNVlqQWFT?=
 =?utf-8?B?Q0VoRmdIemw3MlRmYWhpSjl0d2dKZ2pwcFd4ZnlWWXRNVjV1UlhDRmZSM21Y?=
 =?utf-8?B?NDkwbm1wcTI4M0JvWm5Wc2wzV2JQanpwSVJUSFIyR3BCUzVIVFdPWlJ4VkZH?=
 =?utf-8?B?QkFXUU8rV0lybFpyY0ZvZ2JhOUU0aGFKR1l5dVQyejBLWTltNVY2dnlkSWht?=
 =?utf-8?B?dTgvVXQvZ2ttUHN5aWhmM1lSY3A0M3RXV3ZhNDgyaHNwY1FHZDBuRW9UWkw5?=
 =?utf-8?B?SlRZS3E5b1dzOXoraWplT3ZJcHdML1Z6cHp1WVp4MFZkaVJ5V0ZGQ2t5N3Mx?=
 =?utf-8?B?TTYvdHB4cGllenp3UlVrTXNWcVdXeHYwRnBOeTgvMmJMdUlQaFR6V05BNU1X?=
 =?utf-8?B?cGxsOVhkMDF5RWlQc21PTjNqdEk1STgyRk9Da0VPZXVpN0VvUi9CbGMyRGs3?=
 =?utf-8?B?c1JTLzBLQkdrZEh4ZEUyUUxkWmlyM2FraTUxcHlhYjV3Ny9HMHdaVUZUQ3ho?=
 =?utf-8?B?Lzdmbkw0RUEwM0ltUHY1ODA4Q0VWbDRWb2JzdXp0SHc3V2s0UndJa2dQcm1w?=
 =?utf-8?B?OHRtQnNkOEViaFlZc0NEdms3akZ4Zld4OVRuZ20xaFFkZVkzVXd6WVJZdk5p?=
 =?utf-8?B?UkxDcTdwQ3BGS0xGQnBrM0wvQUpVaXFUTGxJWHBTV0ZIL2xRVnhKWEljaWdC?=
 =?utf-8?B?RU1HaHRQR1oxcGVMSWJ4ckRoUG9nWkRoUVJMZFlETEU3d2Y1N242WUtWMUt4?=
 =?utf-8?B?cC96OWZMYUNBTHlFZHlla3lmOTJwNXZvVG1PdEJkVy81d1R2aDBPQjh2ZW1x?=
 =?utf-8?B?TjBMRklYZEF2RXBCdEUxMlh3Q3JUS2tUYW0rVDlzczdYbXNDaFNITW8rdmhF?=
 =?utf-8?B?WDhjbnpweGtmVVNmTGQ3dVYxWlFzaW1WZkVzaXV0UHFSdllSTUtIL3lmNHdu?=
 =?utf-8?B?ak40ZzJWOWIxd2V3UDdWSXFGTElMVHo5TjJzY1J2VHRMQVlSVm0ybUVxN0ZD?=
 =?utf-8?B?VFFsem53UDdpUmZLTmdDOHlDNUpBQnpVRHY3MVVOdDdxTXBHaEUvS1dhZGlu?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7C17267C70C0A43AC9BE4743F1E4753@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e7ca2b-e975-4b5c-5023-08da9b51a4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:46:58.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qfpOwty+zfhpgQLQ1U2zOEOBX0b9wmrO3STxr7jXfdjiSIzMNVRNLo3HbPCat4ZmttQty94mqOxpaFG8m9Ajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144703_567526_6CC097C9 
X-CRM114-Status: UNSURE (   9.43  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVudXNlZCBub3cu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4N
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCg0K

