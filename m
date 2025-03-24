Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB323C36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g+5nsVNGBipy0/lDkaz7vEAczdbNJAx+BR93t7Swt/8=; b=dto9PdKT+vi06GYf/WeTZ3E4/V
	M0qtyeEcmpUYd7yU5pEyPm2HnA5P8rac2svB5TjRKZFYNjrMKE2JFu+fG4jm6Kp8+AysbXTazZjSf
	eyRWgGxzja+9JJjQNDOEl7ra4ia0JkXeqTS0CWFUhVDyGDyqrmWgSiYq34xrC18N8x0HeTIKpDcCY
	ONonFUQFNwkEUpOvgyFMzwYjz8REfcUx3lqqK5LMROaBEWZM/MGJjKky7SfnVGCogkN1xfbrGN0Tc
	D4mbaQ1yQycj8BNVyHFkDO7dF900Dj86vwFnWsO8ZYhGLhssAj64Gou4Kk+l5yDbWQKgJFd4enjr3
	EnnGrdtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twrAA-00000004U6a-212O;
	Mon, 24 Mar 2025 23:24:58 +0000
Received: from mail-bn7nam10on20622.outbound.protection.outlook.com ([2a01:111:f403:2009::622] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twrA8-00000004U5s-0Dbs
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 23:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK9Q+E3qqq+NnjyAJ/NMMK91KBCpJR8SA7KXwfy672UHVM+nhm91FmYUc18r3U+hXt+NRbRQeKaFci4mSh0Y4kecN3nZGsEc5UsEM0e6WWJR9J/GUuRK5XjNnm7bbEV/crLhw6kUjBYDtueP6cD3MFTtmKMPFGzFix542c5F50danmKfm/IHt+SGYfXf00+O/KloH/TnhPW31FApMaNRCeeOzMkIj/PL4uBro5qXpB+mJKaYfNLn2DLrtfwrhRdhegn3zBQWhEHFJemFaQ7vHjboYbJcMav5lTHz1DX0a60q52h94StQc/J+vjA1uKo24reObGO4SwUW8ia818VImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+5nsVNGBipy0/lDkaz7vEAczdbNJAx+BR93t7Swt/8=;
 b=l24XwTFvpJsNCf71cHVAEtT8xevzDghs+bE9KRgckKkq2WQD1kyRtcI182IO07gypvk3EoRdEhLtmVE9hXGL8AmSlqXqLCQPMXzqPKTBurgDeen4B/7f3scnH8E+zSeKM/3J3uMTGSdLMfxycLjiTcB9J3E96gPpvy+Nafd/1BQfS1QOd/J+Zq3mZtxTv7ygu5J636l/IR9vNpHiYAGhEUrAe8ZEH+w7dy4rF/GlxxKstuePSu0LuNPwHwC5m3pergRdGE6Tl+z7OITcU9p9LkxlO2x1YMnGlYP10i3OSY5LDMc1wXZ1x47zXQFmem+sQULClwDJ9o8iBMx1F8tokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+5nsVNGBipy0/lDkaz7vEAczdbNJAx+BR93t7Swt/8=;
 b=lF3yFcEeSp+RwSz4VXoEW5oE+kBibnEdaN5VXWx4F0JfFrkZh9mI7SYgQ/TfCZ1bqV7iA+ERcUSls2m65i7cGdq+GHejFGOixcmVbNAFsWq3iTdJp5zyK6jhS2Cm80oJaC93fTJyBSonxGRtLQniPnt8U8xMGB/ZMA0Dn0cWdfI5LMqVE3sc/a5Y3pMJ0FDtRkYZ+yZImJk07yrxf4XR82rQpEn1/HSSq45iyjDx0Hubj3WGQ2whgvwBZVfTuWwHVcBimY8F5Q1yZqK5iHN9loOw4t5oa6mwmEhtXO+0m/G25H7QQeJYGNsfe02rog6gGmmUdc7P9DqQ5LAxPeixWw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 23:24:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 23:24:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "shaopeijie@cestc.cn" <shaopeijie@cestc.cn>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "gechangzhong@cestc.cn"
	<gechangzhong@cestc.cn>
Subject: Re: [PATCH] nvmet: Replace sock_create with sock_create_kern
Thread-Topic: [PATCH] nvmet: Replace sock_create with sock_create_kern
Thread-Index: AQHbnGtbRVUSmaF1VUKEE6/9QE6fwLOC7vsA
Date: Mon, 24 Mar 2025 23:24:38 +0000
Message-ID: <e5966920-92ff-4f6d-a72e-7b621fc5c567@nvidia.com>
References: <20250324031708.1687164-1-shaopeijie@cestc.cn>
In-Reply-To: <20250324031708.1687164-1-shaopeijie@cestc.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9267:EE_
x-ms-office365-filtering-correlation-id: 5dc6f3b1-44c3-4463-686e-08dd6b2b0c14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z3R0Ums0SlRDMHkxWWpwZUtES2lrc05uYlhxaEJIU2NodzZpTlVUcWJIWVZF?=
 =?utf-8?B?ekVmM1pvRWI1Tnd3eklVbGtaRXB0WmUySC9qT3FURU4yTVhLNE9GSGJZcndD?=
 =?utf-8?B?MlpHL3NFL2lwd1Y4emRPV2VKOXFsSmpHNjVGSmNuRm1wS3Z0R1NtTU1RT1Ns?=
 =?utf-8?B?YjdLYTJzcTZqalBQQ2t5U0JOTWhDTnZ5OGR4S25JNmRBUlhXWm1IVlJTWHBS?=
 =?utf-8?B?ZU1MZ2VuWWVVdTZ2RllPVUJZRVpPT095L1ExQStWeExZaVQvREFQMlRjRlRy?=
 =?utf-8?B?cDVZQjZYUS9YcytGWjRyd28zZE5nc0gvQnRnQ2IxYTkxZ2dNcmdkdUk2NHdL?=
 =?utf-8?B?c2RMU2ZmQlhUTkc4Z1lVWC9pNkJ1NXdrQmh3bEwwa2FmbmFTRWtmY0Z6VEw1?=
 =?utf-8?B?TURDZkRvM3J0QjJSQ0J3bmY5Ry9OczU4N2RmSVh4S0x3b2Jtd2Z3bEcxSmda?=
 =?utf-8?B?WVIveVpjeDVObXdncXE0Q0Z0bkI0S1d0bGN2bzlqM3NERi8zRVp1NlNXMktW?=
 =?utf-8?B?L21DRlZ6b2FsV082UDhoNTJFZlIvK0VJZnorVDBRTk4rRWF1UllpYXlPV3d5?=
 =?utf-8?B?UlJQSXduSDRKSE4rVCszVFBVUFZBeTRkMy92N0lYZkp6UUlBWUFVVjgzYzlt?=
 =?utf-8?B?K1FUR0FvMmk0MnJPNVJnUHdtYXBxSi9MY2lKWkRvQW81YXhsUmFmL0huZVFG?=
 =?utf-8?B?S3Z2bjkzMXFIWm5NZkNoaTVrK1ZvTmFKQ2xYaDFjNzdVbS9NQWtoN1ozOE54?=
 =?utf-8?B?bElnbWdPcXJOWjBjOHNGYWErd1RsSjVjY1l0ZzRQM0xvY1JqRENSQzdFL3NP?=
 =?utf-8?B?ZGJkeVJaMWEvRWxXS2x5ZVV3Rm96VjFzV29kbmF5UjBHVUJMdk1hQXM3d3k5?=
 =?utf-8?B?V3pLNXp1VlBnNnZBeGZJQVVPYUtqWklqL2hTVk91aWg2OUxrMkkyOXErSGhC?=
 =?utf-8?B?Ym1Iem52NnpORlFTem1jMWhmYXpaMnJ0YitXaU54OWYrSXY1ZEY2SjNPQi9p?=
 =?utf-8?B?ckdPTWc3WlIyNTJVTWk4aEdaNFp5dTF0YVlnVUprQnhSMFRhWEIyMUwvTXdh?=
 =?utf-8?B?bVJXWkRCeXNhcEtkckFZbWgrM3Vsdm1xSlR5alJza0dqNm9jOS9nR0ppYk10?=
 =?utf-8?B?VHRNT0VydjZqZllTY2RzYTZJWDBaN0JSdjR3OVJWdkhab0VibGRhNE9mclZn?=
 =?utf-8?B?L0tlNlZhZ2J1dE5peS9xOXZMcytYMFhPay80dzJvUFdhZks4amEzKzFacHo4?=
 =?utf-8?B?TzMzdXhGcktFSmFNcEV5YmMvTWUvOEpvblZWRGFoVVh2dldBZ0JURThUUlky?=
 =?utf-8?B?cDNNVkZ1a2FaU1llcUNiSUoyMVlPN2ZyaXNQUmx1Wk9rSDdHVzcrK3crbk8z?=
 =?utf-8?B?SVNGK3hiNVI1bEMyRE1UbC9RT3pFUzlYNDVqblJ1ekR0eml0THJOTVZZSThp?=
 =?utf-8?B?UzJOeWRodCsxclh2QmRLaXJ0SFhpckZSRWRiREJWbWhBUk02ZDFVdVdGUWU2?=
 =?utf-8?B?T3NNQTZPZ3RMUGNnU2lkWnJwQzdwR0NRakRkNndQeSs2d3dhT2oyT25MRmNF?=
 =?utf-8?B?RG9DZ2U3OXMrRTdVendUVzg2ejNFdTIvemhTT1dsWGU3Q3N0cUJFODJ6Q05Z?=
 =?utf-8?B?UjZxbkw3dENTdUdySFhVeHlyT0tEUnpJWkJwM3hodmMwTy8zc2NNempUNEo5?=
 =?utf-8?B?a2lsOXVjTGg4QkhuS25sVElkRFAzNGRzRXZFMTJaa2JNZEh5SzF6RUJyOHh5?=
 =?utf-8?B?Wm1td3lLd0FoQnRORis2QW9JMFhybWN5V2Rta3NnYk5Dd1crMW5uTE9JcVpO?=
 =?utf-8?B?K0tQcGk3RGgwRzArbUU2bjZncm9kazRQY2tpOVQ0Z3VXWW5UMjFYTTFxbGJl?=
 =?utf-8?B?MzhMYXBwb2huV0VJK2liVE1mZVdaQW93alVreHQxY2d0ODhTWmdkM3FxNWdi?=
 =?utf-8?Q?w2VE9be8Ov4O0aA8Zgc4+H+FkzmHoUWJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Lzdmb05heWhxVkFXZ1JEZk9PK2g4TWUrRnpnTjRneWZ3alR3Rm9IU2g0SXVo?=
 =?utf-8?B?WGFaS0JNNGtlOGROTzV4YXJWdUlLQzJGaEh1V1B2eExzQnJmTWltWlkzUXlm?=
 =?utf-8?B?SEk4cGRSMVE5ZjF4MnpMN1hlWnM2TFhiclpoQWFESkZBUEtOVkl1dzhjblBK?=
 =?utf-8?B?VzlBOTBzekxQOWd3TkgxU05sVGtpYVBIY08rNjBMNEc3WEcwczRhMkZZVXdH?=
 =?utf-8?B?QjFRMFpPTkFwQ0QvWXN6Vk5hRXZhUUk4QThGaVN3UEFaZ1VEUGdmd3lJdEtn?=
 =?utf-8?B?TDh0UFVmdm16TFF6eUllSFFJejV5VWx1VEc4UFNzdW9CWmdzcXBiVGtGN1Bq?=
 =?utf-8?B?azRWMEdVR3EwajhiOTN1SXVLUlFPVlpPMExvaFRybGJtY2t5YmM2RkRqL0F4?=
 =?utf-8?B?SVorVXB4b0oxd2xUaFkyeUZmbGlGVUIxTGxoWVFUTzdZYndvYnhhbE53ZklH?=
 =?utf-8?B?QU5qaVJBUWVMQWpsOTJsekRTUnBSOTNpZ1lnZHo1YVR4ZXUwTm5jWmV1M1Av?=
 =?utf-8?B?SHRXblRwOCtRbk5vUE9jOW04b05LYlAvSXFrSS9PeFd0anhwM2UwbVR6VG4w?=
 =?utf-8?B?anFmZUJQa3NZWkpYaS9tS1JTbG1xNzQ4UTRQTTY3VTBwNzlsbUtraWhKbUR2?=
 =?utf-8?B?cFArTnZxOWJ5czJyVHJaMnFycUFGb0lCcTBFSGhsVlAxMXpOQlFuNTVId2J3?=
 =?utf-8?B?WDFaRkwwZnJ4WTlncW42elpMUDR0ajBQMkNWQldENXVCd3o0U2xWUjRaWE8w?=
 =?utf-8?B?ZVREZDUyT3dEYlF0M29ia0Z0emx3V0wyR01nUXpxZjJjZytEWGJlVVp0Ny91?=
 =?utf-8?B?MHJzdXhQRWVyUHZnbFlsVDNoRlQ3Y0NQWGdGRkJKQVBoa1FqNnRFU2NDMkVV?=
 =?utf-8?B?K0tMT0pTUXdJU1ArQ3kxb2tpeVk0ZlBIM2N2YnFWVXIycDBWS09qREgzRmhJ?=
 =?utf-8?B?bUVpd25wcHM5OTE0WTc3R0poS0pRbi9HR21CUVVma1lHaDRUdGc5MFNFNk13?=
 =?utf-8?B?WXdabWw1NHBLTUJDc2dlOW5kNGdIRzJaOGg1MHgvcm05STJNQkpZTDZHb2pM?=
 =?utf-8?B?TFAvcllMbEpVL1lmOVhIenlRdTE1OVNwWU14RnZueFRSNmVhQncyS0pwcGhD?=
 =?utf-8?B?c2pYbnVnaHVLKzNmVTMxZkV6VGpmM1pTbGJ5RDhpS3RMU3l1c3VCVklidVhK?=
 =?utf-8?B?V0FpY1VuamJkd2c1aGVIa2pFUFB2a2hZR3B2Z2REQXd1aHlLT0pRNDM0VHA2?=
 =?utf-8?B?L0NGVUpuczltU3JXSVQxQXFsWlBsNjZpSEtzNlVJd1FqbzNMbkJJVFNwQVJx?=
 =?utf-8?B?M0ZXQlE3cU9CZnJxNmpsREtJKzEvelVTUDVRNkREWkZTMHpsMGtsS1hnUit3?=
 =?utf-8?B?ZDliQUNvamUyaERBQzlkWmtJNmZPODVkTC8yV3V4bXVsbkV1VTJUYmExc01v?=
 =?utf-8?B?dTdrb2dTaHZxcktqMXc3UkJqaW5PT1l0YS9HTEc3WWdoNU8zNGtEWXFLcGpk?=
 =?utf-8?B?TlcvN0Z5OFZ6QkYvSG5nbWhNdVg1MnNlMGxvSnpKOWV3aTlRMFFEV0dTTjRC?=
 =?utf-8?B?N3ZvM1hLK3A1SWVoOXFDV3E2L1dUYVlzNGtDMUxJN3VzeU0zb1NxbHB0NkVK?=
 =?utf-8?B?S3QvUHQ1UUhjTEpteCt1UU5SM0xjZFVRMysvT0M3enZvVVR4cVRRQWw1dXgy?=
 =?utf-8?B?OFQrOTBVaGo4ZkNiMWRxZktwWnorODdFUFNYTHpDWVBPSXZ4VEZDSTVsQVY1?=
 =?utf-8?B?ZmFzTjZhNTh1OEtPZWVxakpCbTFDRWp6YWlCbGtYcEQ3NThmS3hrZGhIQngx?=
 =?utf-8?B?RnYwcUlTajI2R1dDR0hjQUMwMG5jbG56UitoQThSM083bnlWTHZLYUQ1OEZ2?=
 =?utf-8?B?NWc3OGdNdlBka1dHRHVlMHFXc2ErQWxTeHRBeVR5My9XaXhxT3MxUjEyT3RW?=
 =?utf-8?B?Z00rUWhPUGFTUVJVakdJTjlFTVRRamRBUFFRQXRYbktQTXdPY29ycmJ0UjdD?=
 =?utf-8?B?Q05FSUxKUTEwNzNVWmt2KzlLV3d5YVNNcEtBVC9WQTFaczZsNEtpb2o4OUxH?=
 =?utf-8?B?M0NBY3lWU3NENmFBWHFGeUttQ3VzNnM2ZFVETUQ1SjRuQm4zNmM2cGNhNTZX?=
 =?utf-8?B?QXMveHJ0aFVldDhmNDlvR01NcFlXU0lRS3BvTGQ0MXByeGNsaDFTbWRqTDJw?=
 =?utf-8?Q?v894BvBGYETEJmWi56G2EgkBRQp2h+q/Po/KtUGiHCvU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <058C79E22A6DAF4FA2CCC140A0C54E78@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc6f3b1-44c3-4463-686e-08dd6b2b0c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 23:24:38.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3Jzt3ST4BLeEVu16+clmRaH1rWbtj39Yrt9b1/9N2GAQFJfeUzl6dV+3hD2Ka4pumXbLTggUPAMmq+WBmVbhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_162456_095502_897ACB8D 
X-CRM114-Status: UNSURE (   9.06  )
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

T24gMy8yMy8yNSAyMDoxNywgc2hhb3BlaWppZUBjZXN0Yy5jbiB3cm90ZToNCj4gRnJvbTogUGVp
amllIFNoYW88c2hhb3BlaWppZUBjZXN0Yy5jbj4NCj4NCj4gUmVwbGFjaW5nIHNvY2tfY3JlYXRl
KCkgd2l0aCBzb2NrX2NyZWF0ZV9rZXJuKCkNCj4gY2hhbmdlcyB0aGUgc29ja2V0IG9iamVjdCdz
IGxhYmVsIHRvIGtlcm5lbF90LA0KPiB0aGVyZWJ5IGJ5cGFzc2luZyB1bm5lY2Vzc2FyeSBTRUxp
bnV4IHBlcm1pc3Npb24NCj4gY2hlY2tzLiBJdCBhbHNvIGhlbHBzIHRvIGF2b2lkIGNvcHkgYW5k
IHBhc3RlIGJ1Z3MuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFBlaWppZSBTaGFvPHNoYW9wZWlqaWVA
Y2VzdGMuY24+DQoNCmNhbiB5b3UgcGxlYXNlIGFkZCB0aGUgdmVyc2lvbiBoaXN0b3J5IGZyb20g
bmV4dCB0aW1lDQp3aGVuIHBvc3RpbmcgbmV3IHZlcnNpb24gPw0KDQotY2sNCg0KDQo=

