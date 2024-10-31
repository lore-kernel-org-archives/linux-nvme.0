Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE67E68956
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 06:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DM2VoZl18TLOSxfcTscGkso5wlyk8HXJS+GD+XNipZY=; b=Dp4zbD6ifNPkcSq87GUTDDFQ1t
	g32NNVfGaxAaY8S+vlN6CWQ3JeUUtzqwBigZsWO3RV5fCFR7VAGJekKoFvsKEa0Y3jDM+EYj3j6W4
	7lOaXtdOz1Tksr1TkkPXoWaU64tCpbIzZe6uk1+0EcWq9jb6gdReQiis5fNH3I0abzgQiqsJY5jwl
	SVYPn0nj7TqZeNHjjPL2zEMVcPmuORgU01izWTCc5IhsUCQFKk6u5cWBSvymgMvzZsgSqiEMQ0wer
	AuWRORRr2cuKbHcS9aBokJ8WmL8kTZx3onCjuwPbqNicn31M6R7ZDByt8LnOr8xC8eWkn4sUBaQec
	XZVDRNSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6OaS-00000002g0y-2dYg;
	Thu, 31 Oct 2024 06:23:16 +0000
Received: from mail-dm6nam10on20608.outbound.protection.outlook.com ([2a01:111:f403:2413::608] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6OaP-00000002g0U-103N
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 06:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMnTa/7z8bYcFK8Yu1EniY7CdWn+i81IzAhDs5pj3/fUnUAu0T+5dRnpgNCZ07sqgDU7Q4AtNvWBcy/6vMBZMkjoFHOfMhpmgN6KldgfjjjI8mqHcXPsRuuDyddLQAu2fF9lqUGaM5JCzC0kmwqE6nbwt5hnTdEtgO01TEOsKtfNKzLIh2CJloy//+wVavBOGmi9Qqyt+F+uJSTIJW1BcuS/BI73hQjnuFFFwSR1HFIMQgNFwqEJgjDuoneCtZMEkeBQvnxRFIB5TEjb6JCW455xMXF8YWyC5LvR4SEsPThwx87TC4kWEmOUMQIHkg5Eu8gtS7vEKHLmItiUr61+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM2VoZl18TLOSxfcTscGkso5wlyk8HXJS+GD+XNipZY=;
 b=Xl5Mg/DKNcWtvb+H2e9NS+WCYCAgtp+s0CUirYONNibCe9nJsVfmmZ9TgfS/E2pabP2a3dzPcj+xexBkhcIAwz5xCSu+iFAuLNkMit+30a+vAgokMJyiIHXQLLTNjurGUXOqREKPQyzKXuyn7gVkBhfted7Pfi6O5WAuSGuvs7PgMjU+fto/xQkXxSncCdpww1fToVZc0qCB7av0EPmFzkYPlzju3QQUBzzjlrIx2r/8Kmk8zJbnPgGwSySZYuC7vaCknSzzhDIm5hSvOjpnodcTy/N8USbHzqq3kfZd0KyaH6QWTuJWkE8SX2vIxZpLOWi7fy6XqElGQAoFYExqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM2VoZl18TLOSxfcTscGkso5wlyk8HXJS+GD+XNipZY=;
 b=kS+erMpdZFvbYBCRiQ9RCHeau+XPjEYrgHhMYY7ixNd91ij1RsbVSAio2Wmonex9ZaiyDKIz682imYwn7YT32FKncYmRAAN9zQuxPfD8eKh06XK3x8CddYIEcdKRQapT1ToOvPXLMb/S0fA+Eo+/eSfFlROPSe20OzLTt03AAWbcx2jOlL1k5BWZenAbeY8vItaYfXeD+IkHBFlm1WeWunV1wpcrW0MD01CiCY47sD/bVSlCtg9Eb7b2G/7Rj1EYfRbtLoeBa7+Qf7oF5cZrsJp8QGr+PyYkyKI0hXRWYvlh3XOZ/w2ItLIAZlpK64A/jZZvmxWp6miJYCg6wqRssw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 06:23:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 06:23:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKzxw10tcCm/QC0SdqiaI6QyqwLKgZDEA
Date: Thu, 31 Oct 2024 06:23:01 +0000
Message-ID: <3cb63cfd-a4d5-4516-a2eb-7b968a036f7a@nvidia.com>
References: <20241031022720.27202-1-kanie@linux.alibaba.com>
In-Reply-To: <20241031022720.27202-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB7445:EE_
x-ms-office365-filtering-correlation-id: 70923b36-7fc4-4206-3b3e-08dcf974788c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0RERUEza2F4Y3FHdU8wamRLaklteGhmdHh5S3NwekJtZEJJY3ZaNTVZRW9V?=
 =?utf-8?B?Z2x5Y2o0ODFOU2Z2WjM3bmE3dnU3OFBFWEMxQzV2S2gxWVB0NGZ2YkNjaHFM?=
 =?utf-8?B?ZjZTV2VYcWw4NHJjRG4yWGdVNjkvMVlKNmljRU5nY1drVzlHWDV3L3VLSmp6?=
 =?utf-8?B?TzNjTnNCMkF5aldweTZGV084UlRNdThoeTNDYSszRzZtdDNYbWgvRnlqR0g4?=
 =?utf-8?B?NTVQbENhM1N4SGlLQ1hrK0owY1FhK3dQR29KcVV4TmkyS0dwQStBOVM3eTFj?=
 =?utf-8?B?MnM1WlV6ZWUySTUwaEtQMGMzQWlNOXFRbmNlY0daSnpCN3Z4KzZ4b09DRTM3?=
 =?utf-8?B?cm9nWDJveXFLQ2tVdzdyVVMwaVJRNW9YZVRWeEpPYTRadGRuNGtCRWN1K1J5?=
 =?utf-8?B?Nkk0TXRzb2JOdVo3WmJWUHRFZGtPMjFKbnR0bWtYVmJGYjNQc215NXdDWW1l?=
 =?utf-8?B?dnlWeGFQOVR0VVpuMFhFUUFxMFZ1eHpGZVgrd1ZCejNycTZONDMrWjFqRnRE?=
 =?utf-8?B?Z2lHMFROSERwbmFLcEFkRzc0UFJXT3N4TlJyNFhGMmpMdHZrckVKd0d4cUgz?=
 =?utf-8?B?ZkdINnNvYzNVRmRiMlhOUWdRSWFFN3BMNjlQcnVBOXZxZFFrS2FnYndNZms1?=
 =?utf-8?B?dFlNV2lSR0I4RWZ4ak9tYW94cGkvU2xSa0F4d2Q1N1BHRmZiK2NqYWdZS3N6?=
 =?utf-8?B?TjhyOFJzaEpHeTNQMzZ6cXFTWkF3VUFwdFl6bkJndTRBK1dES1NVVGMxRkQx?=
 =?utf-8?B?MHRWQTJkT3JZMzFySk9mVWRhWVAxQ2pZYkFvOTFkakFtT3c2LzIrTC9CUlIy?=
 =?utf-8?B?UzNBcDlyeHBQb2lqQmQwZ2p5RWFBRytMZGVzaVFXbzg5dEJpbGRIVjhBb1NM?=
 =?utf-8?B?R1c5eHh5QllMR1BkT3RKTDVqVzdYZytUSlBJNlhQclI5NDZMb2JoVmpoT2Ex?=
 =?utf-8?B?K3NvQnFFRXg4d3JIT1VVSTBvNDdqM1U2UllNQVNFZmRzOWU4Y29SanNvK1lD?=
 =?utf-8?B?UGllY0M5OEFENVVJNm5kWU5rY3NZK3g1dDJHV1Y0ZmdRQ3FiNVJUYjJLYlBM?=
 =?utf-8?B?UFFsOG9iWGx4dVZreUdIcU52bVpCOExMTHJYcmt3TzQrMUFLU0N1Tm50Z0Vn?=
 =?utf-8?B?dFk4bFZ1WU9MNUMwNGcySHZMUy9KUDVXOGJYeFA2Vlh6M3RWYlBacll5LzVJ?=
 =?utf-8?B?blRDaGhPdTVVWGZEeXU1dDlGZEw0aWZhZjJNWUhCSkFkQzhYZzlScFNINUJC?=
 =?utf-8?B?aEpjSk9hTDFIS0JjYjJnY1VqWERPVnBCekFPNU9EUGNDYXFlNkNGSjNYZlNl?=
 =?utf-8?B?MWZ5NlpuY3k2UGowbVpFN0pNL1pKUnpUdHpPNUxBYXZQUURrQlNWc3h3cFVN?=
 =?utf-8?B?VUMwcG92QVVNdUoxbVptUUNCeDNWU1lpN2tqWW8rSlVIMG52RmNxelVqZlpj?=
 =?utf-8?B?RmpYUmUzMXRJTzNvWnhCWjM0aHlJYlpXUkx4RngxbWR3bWJaQXNWai9FeTFD?=
 =?utf-8?B?OGI1bEViZ0w4WjFhaWE0VnVEN3o1azNEbEEzM2hjMlRxV1BCdWw4NmNkS2Y0?=
 =?utf-8?B?S2NFNkhZRU9iZy9TQSszTEw4TDZTc21Bd2Q3cUtpRCswNVlsNU5tQS9zWDEv?=
 =?utf-8?B?c3JVS3JFeEwvekt2Z3k0SHdGeWJSL3Z6SU5SZkxSMU40amxCWHYxNnZLYVk3?=
 =?utf-8?B?dWM3a1FCL3Nra0hDanZTVEkzYUZQTHd1ajNrMTBmOHVvbkwxcWt1MUhMZWc4?=
 =?utf-8?B?TjR3b1EwTDlxZ2Iydy95VkN0bU1nemVyNkFrekFxZ0dDb0d5K0xoN25zS1ZF?=
 =?utf-8?Q?2Xk+WTHVXLHs6FsfjKtuaYKA5mIjYde6tdicM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWZtbWZpVVhDUXIwZWpHbVN2OVdpOHRhbzlVczhGUmg1dWUvUDZsN1NsZ25D?=
 =?utf-8?B?YXp1RkdJRFNSR2JvQzRPKzJvYnBIWUtnVnpNc25EU3czbURIZWVPNUlJeHhZ?=
 =?utf-8?B?TG54Uk1NUVRkNkVNOWk0TUJnWjZFemtkbzJRcWVYQ1poQ1oyazd2eTdxUnVR?=
 =?utf-8?B?YlFJb0VuN3lodnk0eXZqNURldUNjeW9wd0YyRnp0UmluN1hGenVpNEoxNGE5?=
 =?utf-8?B?UkkycjBWcG1JSHdLRGdPRFROT0I5WTJmUlhCQUdzeHlsYVY3UW1XSVh0L1hK?=
 =?utf-8?B?K1JMVG0rZVVMOVhHNnR3cHdJNWNnU1MweFljTDA4Q2drNXZ4RG90WGlEclVV?=
 =?utf-8?B?ZDVzUkhIdmdDbGVHeFB4UGcwUTNLWWRBa1RPbTE4dlYydnYzZ21MNkdhYk13?=
 =?utf-8?B?UDBiTzNiN05KYStLaCtOS1QxbzJRNDhxbVl3dktMT1dZcTFSU2hLaUVLU2c3?=
 =?utf-8?B?VStZem1venRXR3Z0ak02c21rUGg1bWVDcFhFMWttUStUbTVHTEFBMno5cEhD?=
 =?utf-8?B?RlZlUnZJTkVLbU9VNERHSkZDQmlsenAyYytYTHFzMUdvV0FzL3hYSUUxSWRo?=
 =?utf-8?B?cXprTjF1eU5ZcWpXaUNzS0dSZnpobkJ4b1ZyTUJVN3FINHNaTXdWVS9vTUNC?=
 =?utf-8?B?YzJPMWJPVHgvSW02RmIzcll6aGhEdHhGRGtvSjJxaWViMXBYeWxDUGdwM2hh?=
 =?utf-8?B?bmxlS1U4Tkltb2llMDg4RUxTRk10T1dqOHdQQW1Cckpsc0l3SGFSdWY2WGEv?=
 =?utf-8?B?RkRTbE5GVzYzTVhjdnhzRTZDOHNEem9qNklscndnbG5vTW5wOFFLTHkxL3Zu?=
 =?utf-8?B?aVBrb3FhcDR6cVVaZHlDWlVrZ2RIVHAwV0k4VlZJTnlQak1iMXA2eHRVRE1H?=
 =?utf-8?B?M3ZwalU4bHVrcU5uQ0ZuR1pYY1diT0R5K3QrR3B2djJaK0VsT1J0NWU5a1R5?=
 =?utf-8?B?MGVVMWlaR2NqVDNrSmJSVlZiUG9jMWlMNFYxZ1FnQXozRytWVDV4dS9LTGxz?=
 =?utf-8?B?a0U1bE9FMXMyYThOVzhUOUp4cTdaamp6eEtVdWt6aklzMXdxempzMzZxbWRh?=
 =?utf-8?B?a1lYd2JPckhBNm1jd2s3eVZHSDROVTFicDFxNWhkN3pVSy9TVjc4S1ZxWVhV?=
 =?utf-8?B?ZmcrNGFieEpnK08veVlHZUptZ1M0cmMzTjJ1ZlFXZzdZT3EydkJnd3VmNU16?=
 =?utf-8?B?dHhlbjJMQlYyaHkwSHd1YVhnbVV3QW9XWWxrTGpPbUhpQ1BzTVpTTnVaYlJF?=
 =?utf-8?B?V3QyQ1V3VmpXQkpaS2NiOHRucE5ZYzhoNmdHL3FnanNqVjdBME41VnljeTla?=
 =?utf-8?B?citTNkNSQ0VQN0dYbHdQdmNaeEtQeUdySFV2enN5SUxxYnRyTEg0YTNsR3ND?=
 =?utf-8?B?Yk5KcytScFVYbEJxTDltem44VWhVZzM0ZEwzdkdPWUxsZzNuSnY4bWhRT1Vu?=
 =?utf-8?B?WXN0Ly9zakRWa0Rhc2prZHFKM2wvM3l3bXNGUitoUUY5WW9MZkY5ZUI0T3ho?=
 =?utf-8?B?Q1U5Q1p0eHB2NDRtazZOTTFTVFZPeVRubHMxVW5wbDQ4bmJmS2RSSUFzck5w?=
 =?utf-8?B?ZjlDOVlsOGJERnBaeURqZ00rbFhBUlU2YTFscWk4UEd3ME5heWZ5M1UvMGJK?=
 =?utf-8?B?aXo4RVJ4STlJeDRidXMvaWtsclhnZHVkZExISDBvSkZiUksreDV1UmNWcENr?=
 =?utf-8?B?U0FrRmlydTB1Y3BuZjMrSEV1YzBNU3FFZE5QdUFiTDA3TC9LUm5pOVZmaHla?=
 =?utf-8?B?WkR1TVhxdkYwZ29VZGwxRjlKR0FKZm1xWFdpWHNpZnQzL1RLaFVxUmFubGNP?=
 =?utf-8?B?dGhKcjl3ZVNNTEJiN09tZ0U4RWhuZ2ovTGlOTGtMM3hjUTRRVGhSeUJJRCtw?=
 =?utf-8?B?NElsK2FpVTlteFdMb1lpSEs0Rzk3bDdvMng1QjFqY3E4V2xqMXp6dDNYWFor?=
 =?utf-8?B?alF1QmtCNXJOL3EvalQ5YmFNdjFKWUJxOFVnWGVXMElmMnVRcG9HNnZKVXlK?=
 =?utf-8?B?azBoUFJ0OHN1WmVFUHU3Q3N1bkwxMWpqVzFnMjhEczR5YzREWWtQdGRJUk5P?=
 =?utf-8?B?VXpscnN5NWdmaHkrQ3lVTlhrMEVhL0srN2I1djMwVUxzQ0R3eEt2RnM5a21l?=
 =?utf-8?Q?n7ElM1E/VOIxL0eXgDYBPY9zd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F815D56D63B8A438C10CBF6DA70ED60@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70923b36-7fc4-4206-3b3e-08dcf974788c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 06:23:01.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAcLtjkMO3IfwH0fjMcVIaGrwk8LfE0oiGQT3pmslyVrtlatLi51TeSnzCPihgef0FamXDp69xNciboUY0KqWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_232313_306004_E063E65E 
X-CRM114-Status: UNSURE (   9.39  )
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

T24gMTAvMzAvMjQgMTk6MjcsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IEluIHNvbWUgY29tcGxleCBz
Y2VuYXJpb3MsIHdlIGRlcGxveSBtdWx0aXBsZSB0YXNrcyBvbiBhIHNpbmdsZSBtYWNoaW5lDQo+
IChoeWJyaWQgZGVwbG95bWVudCksIHN1Y2ggYXM6DQo+ICAgIDEuIERvY2tlciBjb250YWluZXJz
IGZvciBmdW5jdGlvbiBjb21wdXRhdGlvbiAoYmFja2dyb3VuZCBwcm9jZXNzaW5nKS4NCj4gICAg
Mi4gRG9ja2VyIGNvbnRhaW5lcnMgZm9yIHJlYWwtdGltZSB0YXNrcy4NCj4gICAgMy4gRG9ja2Vy
IGNvbnRhaW5lcnMgZm9yIG1vbml0b3JpbmcsIGV2ZW50IGhhbmRsaW5nLCBhbmQgbWFuYWdlbWVu
dC4NCj4gICAgNC4gQW4gTlZNZSB0YXJnZXQgc2VydmVyLg0KPiBFYWNoIG9mIHRoZXNlIGNvbXBv
bmVudHMgaXMgcmVzdHJpY3RlZCB0byBpdHMgb3duIENQVSBjb3JlcyB0byBwcmV2ZW50DQo+IG11
dHVhbCBpbnRlcmZlcmVuY2UgYW5kIGVuc3VyZSBzdHJpY3QgaXNvbGF0aW9uLiBBZGRpdGlvbmFs
bHksIHdlIG1ha2UNCj4gdGhlIG52bWV0X3dxIHZpc2libGUgaW4gc3lzZnMsIGFsbG93aW5nIGZv
ciB0dW5pbmcgaXRzIGF0dHJpYnV0ZXMNCj4gdGhyb3VnaCBzeXNmcywgc3VjaCBhcyBjcHVtYXNr
Lg0KDQoNCkhvdyBhYm91dCBmb2xsb3dpbmcgPyBubyBuZWVkIHRvIHNlbmQgVjMgY2FuIGJlIGRv
bmUgYXQNCnRoZSB0aW1lIG9mIGFwcGx5aW5nIHRoZSBwYXRjaCBpZiB5b3UgYXJlIG9rYXkgd2l0
aCBpdCA6LQ0KDQoiIEluICBzb21lIGNvbXBsZXggc2NlbmFyaW9zLCB3ZSBkZXBsb3kgbXVsdGlw
bGUgdGFza3NvbiAgYXNpbmdsZSAgbWFjaGluZQ0KKGh5YnJpZCBkZXBsb3ltZW50KSwgc3VjaGFz
ICBEb2NrZXIgY29udGFpbmVyc2ZvciAgZnVuY3Rpb24gIGNvbXB1dGF0aW9uDQooYmFja2dyb3Vu
ZCBwcm9jZXNzaW5nKSwgcmVhbC10aW1lIHRhc2tzLCBtb25pdG9yaW5nLGV2ZW50ICBoYW5kbGlu
ZywNCmFuZCAgbWFuYWdlbWVudCwgYWxvbmd3aXRoICBhbiBOVk1lIHRhcmdldCBzZXJ2ZXIuDQoN
CkVhY2ggIG9mICB0aGVzZSBjb21wb25lbnRzaXMgIHJlc3RyaWN0ZWR0byAgaXRzIG93biBDUFUg
Y29yZXN0byAgcHJldmVudA0KbXV0dWFsIGludGVyZmVyZW5jZWFuZCAgZW5zdXJlc3RyaWN0ICBp
c29sYXRpb24uVG8gIGFjaGlldmUgdGhpcyBsZXZlbA0Kb2YgIGlzb2xhdGlvbiBmb3IgbnZtZXRf
d3Egd2UgbmVlZHRvICB1c2Ugc3lzZnMgdHVuYWJsZXMgc3VjaCBhcw0KY3B1bWFzayB0aGF0IGFy
ZSBjdXJyZW50bHkgbm90IGFjY2Vzc2libGUuDQoNCkFkZCBXUV9TWVNGUyBmbGFnIHRvIGFsbG9j
X3dvcmtxdWV1ZSgpIHdoZW4gY3JlYXRpbmcgbnZtZXRfd3Egc28NCndvcmtxdWV1ZSB0dW5hYmxl
cyBhcmUgZXhwb3J0ZWQgaW4gdGhlIHVzZXJzcGFjZSB2aWEgc3lzZnMuDQoNCndpdGggdGhpcyBw
YXRjaCA6LQ0KDQpudm1lIChudm1lLTYuMTMpICMgbHMgL3N5cy9kZXZpY2VzL3ZpcnR1YWwvd29y
a3F1ZXVlL252bWV0LXdxLw0KYWZmaW5pdHlfc2NvcGUgIGFmZmluaXR5X3N0cmljdCAgY3B1bWFz
ayAgbWF4X2FjdGl2ZSAgbmljZSAgcGVyX2NwdQ0KcG93ZXIgIHN1YnN5c3RlbSAgdWV2ZW50DQoN
CiINCg0KV2l0aCB0aGF0IGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

