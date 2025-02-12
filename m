Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B539FC021A0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sSmy9EcPmfyxCtBlx6DzSiQj+M/DmknOqcUN/zO1ZGk=; b=r+o4NZWZ8PWMWwU//pbslVNyBy
	dGtNhavqiZ9k2o5zpUtW8PYBXtAS8WoubrSA19KbcQ7rfJEpGlP2UyqcxJpN8iiMrM8413UGcW3Aw
	tHKwcws6Y9mUJFKj8f8oubrC5LC5zdHr9iJu2wky27txIF5BeKdoXNKVr8d4PJyxNjmEH3YwM9PqR
	TMjQwEXPDYHrMPoGjBeculzwdNI6qaLR4pQUjb1Cbu6MvrHRlq4dJzAYyjFSpHewzXduZtvdj5O+5
	1v6mlryjdbn0TXxxbgOyzxKVZmpm+bD0si2KyUGhyTyIYo18DePXjhHvAFHA3nb1QHlq+8u5wSqR6
	Sji1AQ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiHVC-00000008TrG-177h;
	Wed, 12 Feb 2025 18:30:26 +0000
Received: from mail-mw2nam12on20603.outbound.protection.outlook.com ([2a01:111:f403:200a::603] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiHRc-00000008TIO-35YL
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 18:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRob61ZH+/eSPua2DWtTwVyzPEyaAgdLmKs+PBJwxRZrhUN2TzgYuKPzg/A4NE674qIe6t3S5gTiLoEYr+mqxK2E2tgivW/B07j+DH2q+1rdkO7F6VC+TXq3yib59LALPmPlVnG1r6RzZOg4LstnpSWgb03h1LKtuwfojlyYEB4KNBW7Y5c7XitX0E/OjREoI11PFUBtF18qeRJ4Pg779VClWrVl56njKnRQeoNm+XPX52IP1W3E9irXSZv9hZ+3taMTOOBp73qC3DJ7jLkE1vzCYnXZBdGg+pftlg9aIgz+zCtQAIr0zok2QKHNRVEYE+f5QSi3VXJk04PC/ydLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSmy9EcPmfyxCtBlx6DzSiQj+M/DmknOqcUN/zO1ZGk=;
 b=TEHvBnk0I7Hj6g9yMVF3PIwB8qaeRHg2HHTPgO4qEZ0+MYqMngmdPRNhfYcqkao1FE/aDadXj5I3Bx64hsquEBY1pKZRu9Yse9mcESKxv+9xRGmJtTJEdKiwyYwrIw0S2kt89BKFyQwK3/R5v3flJAJEAK4VNXppdEf2r1ou6LbspYItv1o3lIdHdz+ItW64WTY/63iN67AG7aU5u0ywGHS7SVBPErlmA7QDWACuZJOTogGkhevXDFfRAej7CPNxohc2hR3dIoqd4YnZC+rmUckmcZZ0sQJdUbTb8DnGWoAfwxP+/AQHNyISwH9pOFOwE0jsYlldR0mZ7HP9CmT+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSmy9EcPmfyxCtBlx6DzSiQj+M/DmknOqcUN/zO1ZGk=;
 b=YmE8NdYNcuUkixpuV1EOF5kgufknlySNkLN1aW6aSZGWycGAHx2NflV6YpYMYhOG4aCJsHRvwAhqjk9ZayCWmA4kI5QBqIkYzVe6c7xS/q4NlZT8hS9A98eusdQbCPRlisBu4DB+xsuxaPmtB4aWGqVV/yP6gCevXGuPeENzRuZt+JbDkEI6HD66VUgJUNdhReU8ClZBhaszuPjO+f6I4busXft7U8tvJHytfkMpvMV1QD6MEiDuHjOgXuXh/PAbA3VZwCDsN5ZS4srS4rLdofqwqP/4Kqyzyq5QyYviji/vPRpMpaT14wcRcHRKIa68r42u1ax8bqN4x3FNbHjiYg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 18:26:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 18:26:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: Cleanup the definition of the controller config
 register fields
Thread-Topic: [PATCH 1/2] nvme: Cleanup the definition of the controller
 config register fields
Thread-Index: AQHbe1MNNQLndftk/kKLmPmB1r3lzLNEAJ8A
Date: Wed, 12 Feb 2025 18:26:30 +0000
Message-ID: <025712da-2371-4282-9d3f-ef5b7ffddaaa@nvidia.com>
References: <20250210002935.1744249-1-dlemoal@kernel.org>
 <20250210002935.1744249-2-dlemoal@kernel.org>
In-Reply-To: <20250210002935.1744249-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4331:EE_
x-ms-office365-filtering-correlation-id: 05195045-e960-4438-10ff-08dd4b92c5aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXJmc2VkaU1PNWxidHl0Rzk0YjVZU0hEYkJzL1N6dmg5M29BS0NtTENra0RM?=
 =?utf-8?B?cmdmaExKSUFTU1V6aWtPa0pNWVJNYXBtcHZ3aXdIZXdrcWlCNkJnbDdWeC91?=
 =?utf-8?B?QUlXK1poamxublJDeHNoSDh3Qkw3Qkg0cG5oRnJVUlVLTDFWWUZDR28xdk4z?=
 =?utf-8?B?NlhtWHkyeGVGU0dVeWppL1JWTkREaEI3dGZ2SXptcHhXaFBJSnVZaUJwdVhm?=
 =?utf-8?B?QWVDN0VVeTcyK3VkNjEvZnhTbGRhWWhRMXNRcUp0OUJlZDFYMlJZQ0R0anpu?=
 =?utf-8?B?elVDVWwrNSsrbmlYZW1MaGR5NDRZNklXQkc5R0NVby9mUGhHaUpXd2VzMDRv?=
 =?utf-8?B?TWtUVzVSQk91TzFrbjBZZHAramxiYzRTbmRySHhOaGJaNmpPZFFNUEdIV2Vm?=
 =?utf-8?B?YlJYeGJLVDRVTDJadkxLeFpCUU5HUUFUTE5LbFQvTEVGb2tvQ2FYYzRjZHhw?=
 =?utf-8?B?d01vQ0w5eXRicFR2L09oQm8xalFUSElUV2hFU2pmZE5HNHBKaS9saDVWOUdN?=
 =?utf-8?B?WWZSd1U5UkNTZEZQTFA5UWlqRGwyQ3hudkJRRlhjcmpLejA1NzUvZkpMaXlw?=
 =?utf-8?B?UnBZQy9uL2xlTEVJTUZSZWRaR1pHL2ZyVlJvdCtMc2VyU282bndDODFQWlRV?=
 =?utf-8?B?UGdqM09rQ3U0OUQydEs4TkY5MC9HS1dPcS9VRzh5bkxmQlpwb2pVdVl0N2l3?=
 =?utf-8?B?UEtBdHFqRTVidGVzM1BSOG9aSmhKWU5weHIyT3VqdVpaVmJ5b2RKYVlpdWRa?=
 =?utf-8?B?SFpLUVZvNlZ0dXp1TlVPVEc1VW84MzB3MnhsSU9xM2RjUUowQ2lsRU43OXZY?=
 =?utf-8?B?Z2szQUtRZXhKL25KUUt3SzVKZlllNUE1QWRsVGYxRFpxai9DOXJyOGgyQWVU?=
 =?utf-8?B?ODQ5NkxVejJGenlPRlZ5aUZ0T000TmxVeUtOKzV2ZlZFd0pvZVJ5TVJxeDZQ?=
 =?utf-8?B?UTdZSlVkQjUxUnErL1A1VWl4TzFlNHpJZ01ZV2M2WjZENzV2MW5sZTJ1N3Ns?=
 =?utf-8?B?WTJJWUhLcHpkN1JNSzl2RXJRaVA0a29odnd6OW15YzFuVXdHQ0lRQzJQa044?=
 =?utf-8?B?SnpFZGFyZHBBaHo1SUd3cHI3b05oUVp1VHFpeEcxQUJoeGtFVlBHUytjZGVz?=
 =?utf-8?B?Z2lLT3p6V2d2bGVtMXI1YXZlOUdONXFGL01SMmZ2MTdQLzNKSEg1SEhWRjIw?=
 =?utf-8?B?a0UvWjFEWCtGazZoLy81d2d2UTgxL2RMc0R6dlZmclorVnk1MGtnbkYvb2Q5?=
 =?utf-8?B?ZTZzOUdSTDlTenBFdUwrSDFYSjNsaHlmNFFROHZ6bVJwWURmckNVR2NqdmpM?=
 =?utf-8?B?WXNlK3FuaEdVMTBpMk52SzBGbDFsaFZXRlJsZlJnNUMwQWJQSFl5RVRmNkdS?=
 =?utf-8?B?V0tmTEoxQTV1TkE3Rk1QVEhoSVRBTEF1a1NHZHMrdGdhclU2RWh6T0Vac3Zw?=
 =?utf-8?B?UXg2WktBZk9MR05lczd5czVuWlZTSm9EdjJFVHFDS2xjTy9HZTZzeGdFNVk1?=
 =?utf-8?B?UFFKc0FGQVhmazl6c3RRM3cxYit4MVIwZUwzZGFCR1JSbGdXMC9lczF2S2NW?=
 =?utf-8?B?dnBjOWNmbGM3Wlh5TWNkSDR1SGN3Y2ZaZEtFNnJpZ0lrU2R0S3NZRGxjUjZD?=
 =?utf-8?B?VzB0L3FTSjh4cElMcEtTMVV6K0hIbDdNVzBEVThYa3l4VWZ0UUxidGdacy9Z?=
 =?utf-8?B?QnlTQnRiSVVlMXJYUllzdkxubHVHa3FnYTQ3MzlzK2FwUERRcndITlI2QVhO?=
 =?utf-8?B?dTNwcVpKeVhwYnJ1eGxLQXlUQnJZbmhVUkt6dklzblBDRmFxd1draFZrckF6?=
 =?utf-8?B?Mjd2ODJmZjE5ajQ1TkdYQ3ByOWFyS3VrdFhNZTFnZFFnbHFIeVY4TzlIZTZW?=
 =?utf-8?B?cklGeVBsY1ZFb0UvK0UvMHkzNUNTbkg4ZlY2MGU2ODFvTk1ueVdqWHBhbEQ0?=
 =?utf-8?Q?N4nCImL+aAw0A8Jp1Dq3PkNNqGoMF9wL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFV2OVU5bXIwSitMYXNFUU5HeEhaUkFoZ2Q4aUJZRlNKMTV3L1F5VUd1VW5j?=
 =?utf-8?B?dCs3UjVqVnF6UTdrL0VGM2lFK3BneURBREdTc0ZkZmEzQkhKUHpuM3B3TW1P?=
 =?utf-8?B?VDRHOTdZM1dTKzBSMytrNHZJc3ptc25oMElFSytoTHA2UTFROTBDdEo2Y0hp?=
 =?utf-8?B?NFd6WDl4bWYrMVZWVGh4NjdUQzFRYXQ3U0dSV3JrdlYwNzc3QlBicUo1NHNu?=
 =?utf-8?B?bmd2ZVRxbnh3RzNiVUhmWmpPMHZwekM0U3J2RkFBMDlrNHdXcG91dTZwSlo4?=
 =?utf-8?B?a2FTczJIeUNyOHpmWENPaTBBR1FRK2U4R21OQ3JMNW5zb1B5NGY4amVoSHlo?=
 =?utf-8?B?aHIzRlpTaEFTTFZyeUZxRTNpdDRFM1hvVXF2NmhFTjlPcVB3dWFZdlY3NXUx?=
 =?utf-8?B?aEFOQ1VGaUFWTlJTWkhzNzlYeUZRS2VhMno1VXZGR1E1cWkxRDZ0OWxxV0ZB?=
 =?utf-8?B?dWNjbnJqSWFRcTlhYVZvbXl3OFVCVzI2SnZMSEU4aEhlL1pwUDArREt6MWpv?=
 =?utf-8?B?aTgyMDRuMERqVkVlb1I2bWpRVEtINDBvQnkrcDduSHRyYWphWklaU010S2x2?=
 =?utf-8?B?ZDdLa25ma0k4MVVOYjNaZExaT1Rsby9iWFpQZkEvNmluR2FlRlNaSXJDNDNp?=
 =?utf-8?B?SFREWnhySHNOQkRsa1MzRlF6M3BrMEtnTlFEOEdzcm5sVERuU2V3Ny9CS3l6?=
 =?utf-8?B?T1NhZUNuUGxqVXNSYU5yODZmMnJ5STJKNUJ5VGxQaXViN0djdXFTSGNGT2F0?=
 =?utf-8?B?YmlRakhBODhFWGIyeW9MMDZxVGdqd0RaNm50OW5kV3BvVEVqa0N3cCtvdnBp?=
 =?utf-8?B?bGQwNmd2ZzdxQUFnTVBpS2NlNGg2NVF3elZ4WFNkbDNjbWJhT0VIazJ4YTN6?=
 =?utf-8?B?Q29mZi9TM2JpN2NnemdWWUlzM1lPOVhmQ0FNeGtxdkx0cFEwdGlsVkFwWHZU?=
 =?utf-8?B?QXdySHJzTnIvM24zNWdWTXQxcWd5ZWxlUUpydWROR0FZSmkyenI5eG1tMGND?=
 =?utf-8?B?WEJzUFBjRTU0MGdYclNNRjZQTm8rR1pvWUZZemJNTHBSZldkZHRJaHljVTlx?=
 =?utf-8?B?MTA5VDBhV3huQ0JwdHBsL1ArRHkvaDJTMHA0QzgycXJTU0NrcHpLVzhwNFhy?=
 =?utf-8?B?ZVk2TDMwU1MzVWN4WGNsYVZiMTBPS0tLOWlqM3Z0TEM4RkpLMkM4Tlh6VjR1?=
 =?utf-8?B?enpRb0VYcmNCcVVwMTN6UFg1Yk9FSVlDUDJmWVhLcDNFQy9pdkVYWmZSdSsv?=
 =?utf-8?B?MVE3elRxYWJUd1BpYXRsY003czcrUUdyM1V5SVk0YlV1TFNNZHM4QUs0dVJK?=
 =?utf-8?B?dUdvL3hHakRqR1BXNVkrdW9qbys0Vi8xeEJjdW9CUGtDZWRTNUp0UEw4Nndi?=
 =?utf-8?B?bHhQOGdtdmJPa2F4cWk5TktJR0x4VGt4b2s5clhralhRaEdBc0RLRFRNdHdO?=
 =?utf-8?B?dytyd2xXeTIzVFNSMG5HTFZTZjZ1ZHZHSlZhU3VxUnVyOGE4dW1QM2Nta01x?=
 =?utf-8?B?TVBINDBRVXRGbnJvcVhzanV5bHdhN011K1cvbTdlZThyeUlTRS9OU2hwVmh1?=
 =?utf-8?B?ZWorS0RkNkNwUk9paVpQeFplcDNJRzRjT2VlNE1Ga0R3TmpySnJQS3V5eW90?=
 =?utf-8?B?bXlsNXhUZFZTZ1RwNUtwWmJUTndWa1VNU1BjTnlDL1VHbDVRdnlJOFdUcm9B?=
 =?utf-8?B?SlhtSXNCQmNoTk5QOWRkbzJSMFdmaU0ycktoSzNrL0N2WDNRTTg1b1M3aG40?=
 =?utf-8?B?UXBVQ3psK3krczg0UG9aTlNWL2hQakhMSGhlMFRCQUJyb014ZmhUOUhvdGN0?=
 =?utf-8?B?RkFheG1mVXZkRitaQlJ0d2U3dXNxM3FscnlOb01RYXB1cXBPSGk3a3Zmd05L?=
 =?utf-8?B?QjZ1UXN0QW15ejJ6UzRSd09XSVNRc2NTdzQ2c1lJdzZNZEVZcU5jODhCM2hz?=
 =?utf-8?B?SExEYzN2Nm5XZXhGWERkY1U4bmZ0RlBqT0pKMGJhWlNjdVJjZUV2YVdGblN1?=
 =?utf-8?B?NHVmMnU0UXI3ektrZkNOTVp3eDlEdTd3dVlhV0NNNDJoZ2VPL0tEMzBmOFh5?=
 =?utf-8?B?bXFUcXgvMUdKd3hnbFVlOUJqSjRyT0NQRXVJYVFWWGpHZFRwVm4zRFVDVEMr?=
 =?utf-8?B?U25NUHBHVk5nQ05udGtqOE9DM3l2UzdxUnhleDBhL3pKdDZFYktHV2dHcmZh?=
 =?utf-8?Q?qniHokthRvPd6d+lZJDpR2EOFKqsFOoBIliiOcEwWcLY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61C464D1AA5E7F4AB41323F4C297779C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05195045-e960-4438-10ff-08dd4b92c5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 18:26:30.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLMtgHobLQV3dscAQDckyoEUFo+BnAsJx/W8PS97gUP/oUv2P4e5DXK+Bl+TJrvcWmyXGhWMLTWgvL9XkJTS0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_102644_775668_711EB092 
X-CRM114-Status: UNSURE (   9.31  )
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

T24gMi85LzI1IDE2OjI5LCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gUmVvcmdhbml6ZWQgdGhl
IGVudW0gdXNlZCB0byBkZWZpbmUgdGhlIGZpZWxkcyBvZiB0aGUgY29udHJsbGVyDQo+IGNvbmZp
Z3VyYXRpb24gKENDKSByZWdpc3RlciBpbiBpbmNsdWRlL2xpbnV4L252bWUuaCB0bzoNCj4gMSkg
R3JvdXAgdG9nZXRoZXIgYWxsIHRoZSB2YWx1ZXMgZGVmaW5lZCBmb3IgZWFjaCBmaWVsZC4NCj4g
MikgQWRkIHRoZSBtaXNzaW5nIGZpZWxkIG1hc2tzIGRlZmluaXRpb25zLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=

