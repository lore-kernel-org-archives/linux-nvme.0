Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1E1C25B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wKmsZk2B3jd9tp23p0b3taEvfsEB/8mXfFLs+sVEhkk=; b=uwiA3ET3bT2axBQO7OW86VyOL4
	f3Qc/uw6fiv0F14HG9zqfQz7hbErkBjCBaFghBa2bJDhJGYbJ5eRbxG80O1D2zudkoiSI0HCQmPP1
	ch6Whi1UItpKm1Eb+/QWD8QDIspIynNN+JARgvu6luE57epTs2Owt/pwNWCLrGhSY0IRHj6xSfAbi
	PWpWGpQXz+0qe6eWTSCZaSnRpukq3lu0Wr4XEoz7V4myUwDm89YeKcPDbwA/uAQscL0ZdPJzhmAEG
	qC9ud2LAk0B/d9ryh3s5/YrnfLay4aKK9qsj/OdhvxhByqDkfwdcJ8DWFr6XrJY00vf1BtR9TzN9J
	3nJlRiGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCOmO-00000005JVc-0SsN;
	Wed, 29 May 2024 19:16:08 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCOmF-00000005JNu-1FJV
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 19:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaWbyJffoFuf5oxclE72k5tvmAEFz0zwdiNgR2tgZRxMZifNQWCdmtp1anQ/3KtQIuaRP3QqSziSXrvAGOYl2SaivYra9R+pP/zBOyZsX7xZ0o6Rw3A0SdmXXxsmWMWv/kKL2Cecm0kvoHPXj0l+uJxLs7nM5KBoMO8cqm8510DjYkT8zYftLo8kVS73ndtF7co2b0CxAUEt9jpKk+EMYm02KI2L3wxEsZgLsvAYDCsNAQh6jcvoQ6PpG9ThMLK4wa6H4Zz2hIJen7EBPRkn4KX1esXLX4s2Rz/RuwPcs1iZFgrx98qfDHfutBFTlIkJX73YV3sEpBYa1ZfHrWvPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKmsZk2B3jd9tp23p0b3taEvfsEB/8mXfFLs+sVEhkk=;
 b=nq6vwmN3SspAQlTnOp2xpA8UlsUrV60wDJ7JOKioTtjvvTAhY3AOmf1ffc/9VuvvpwnLM02TmpLhypZBO4XryGjqCldp05++nBexUwPhxtGT3r19ReOAffANte6HZmsIaRzr8Dy4ilDkCcDefBi3eMMsLpBBFoGnZ0R5djKrgrQutnnAHP0xniuMjhmjMmI9SuECRCP6gz6EsDp3DJ1WW3puGYx9DHaybwZ/W7zxTftbURHZg1rXncFfZmsyAbWnTjvRjutdk42oydZiHv7BFqNeW/hQfQlE502qDCvB/jQCaTT2hz/B+KWLGJoqZixMgiSDCOblVfo18vN9H9rD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKmsZk2B3jd9tp23p0b3taEvfsEB/8mXfFLs+sVEhkk=;
 b=Hxl2ONjf7/Vh25/TqbMKQC7E7FWToObwCmMLqJ8mVwBn2pw9ERHupeFRf51wV6M1N3qsTs8yI8boF1/Ska05/ubASW//4uP6Fz6v12OXzDpgPa7deGb540LNIN3icQvsHZDNqy/icB4+tLzL388atd0qnBzN+EYg42M3uG39aKRl139NIMz18gn6QggAViBPOENKSl7clzJ1CSbuDHNmm1WKNqtWIYqoU1/uAzSiehbvEFLfh/wI1Bg6MD0fVK0bSh5RVLauKy5OCn6GhZswxuIC1gZEDf656yld7hU+D2Ct7VhOD89sZ3XGThPFLe3SPqqw90NtYuP6pVGpSoPD3Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 19:15:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 19:15:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: fix a possible leak when destroy a ctrl during qp
 establishment
Thread-Topic: [PATCH] nvmet: fix a possible leak when destroy a ctrl during qp
 establishment
Thread-Index: AQHasG2i0pPCtpBgoEmXLnxxkArlMLGumGIA
Date: Wed, 29 May 2024 19:15:52 +0000
Message-ID: <910fe0fa-f783-45a1-b45f-be973d748fda@nvidia.com>
References: <20240527193852.252090-1-sagi@grimberg.me>
In-Reply-To: <20240527193852.252090-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7343:EE_
x-ms-office365-filtering-correlation-id: 2c4c98a5-6936-4036-d23d-08dc8013c210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bjRVT0xlQWdJbk0wbDUrQXV1L28rUEk2WU1aWmZIdVpKUHJZTVFXaUE5VDEz?=
 =?utf-8?B?Zll5Q2VLTWZrem1BV2Jmb1hmOXo0YzJXeFhVbEhPUnRnK29DZ2RaVGhycWhn?=
 =?utf-8?B?b3VtejlsUzFLWURUU1hRQ2VXamQvdTJvb0t4cWZqK3VWbEMvbW4xRDArUUpH?=
 =?utf-8?B?S3BjUlZ2QjVkaXgrMmxuZWRxcXBtdWx4NFg4N1FxYnJrZWpNL1RXYVJ3bnJz?=
 =?utf-8?B?UkpvUDJJSWVkQlp4Ynp5ck1aMTBXcldmd0U5TEhVMkd0bHVIVDNwa2pnODFQ?=
 =?utf-8?B?ZWtRZjJQVjFJWStiNUx5b2oxdFBCNjRlUGEzUjRJaFFHMnh0VmwwS2JzMnZC?=
 =?utf-8?B?aFBLT2pSK0pVSEo2UDN3dUdXeUlPelNOcWo1aElZWVBJaURKUzZCMGM0aThX?=
 =?utf-8?B?dGVKVjBsMnJTVU9iYVZhM2hZUmhvZlE4VU5LQ25Wa1kra3VJcld1N0s4ZnV3?=
 =?utf-8?B?RjNIbEZYZmp3eVVXYkJQbjVRMlE4T0h5MnBjdWcxaEFFQmlDRzI3TnJORitt?=
 =?utf-8?B?LzVMbmFLUWUzV2F2WVkwU25aWkw5M0w2a1VrYnJHYXpSemJ0aVFZbWJtMjRr?=
 =?utf-8?B?U0RpRVhhNHV5WHhJL3FESE96RitKeTBweVlLRHNsSnZGRk1RdXlURWs4dW9I?=
 =?utf-8?B?anozVXZUd1M0ZTQ3VHFuUm14UThEdTdQeFZ6NEl2cGJNVWl1UkFVelRLYWFo?=
 =?utf-8?B?MUpNeDNUU2tGUk4vSFJNZGEvMjJFb3N1WUZuaStlWXVpZWJZRC8zRjJnWENu?=
 =?utf-8?B?ems3RUxYZW84Z0s2Y1p2WnNkUUFMTWNNSXhLUk1tSnZURWFyY01DbDd3YzVY?=
 =?utf-8?B?eHB2SHNFQmJjQTd3VlFOcUpzMkpxWld3Y2hhUGlSYmFDVnFwbXZOUDhrZlVL?=
 =?utf-8?B?d2J4eWdYZ3J5RENYMXBVQitrNi9hZmk0cG16VFNrWmgrcFZRMmdtMkx6LzY4?=
 =?utf-8?B?clg4WEFRYitFaHIwNnFrL2NaM0RTOGtXdVZkLzRQc0RKY25ucWlnNmlCUjVJ?=
 =?utf-8?B?N2ZqbkJ6eG5TZ1Q5V1VwbEducXU0RGVYa0dkMnpFeDhUZlB4elNBMVZkb2Zq?=
 =?utf-8?B?WkhrNDRyYlJMTzNzMDYzT3p4TzNlTlU5Sm1aQWZDcWVaRFg2OHRlTlhKc09i?=
 =?utf-8?B?NU9reWxVNU5UbTEvZXZOK05rM3Z4OW8zM3JRbkNMdXNHR01zbTIvSEZ1NjJ6?=
 =?utf-8?B?WlBBdzQzSUZBV3RaalFWTUZMRDB6NE5wMk5oRy9TV1NjREpnU29nMjNrNnNI?=
 =?utf-8?B?MkV2UUpmSkdHREc2Q0lsYWVwQ3JWWEpZZnFZbnBRMCtYZmVrRS9KZVF0VVJT?=
 =?utf-8?B?UUQ4ZWlRWGttQzZ1SUJsMlp3NkFxT3d0UnpabkpIUThiN255eldKWER2Mk5Q?=
 =?utf-8?B?T2x3QW1ZUXFQNll2b3Ivd2FqNmF3RmRBRldycXRNM0NGcTY1S0l5cTl6TlI2?=
 =?utf-8?B?c0YxdjdTYTZINzlqbzEyaHBuWUhLTllsWHRTcGRSZXpWK3djYXdtaGR0N1VZ?=
 =?utf-8?B?cmlaSHNTK3N0WVV4eVI5RzN0TkhVcGNRVDhMRUVLdjBqcmZJZHhpaCtUbEwy?=
 =?utf-8?B?T0pDTlJLdXM4ZEg1SE9hN1NnbDV3TUN0OW4zSFc2TG9lZlJnQklUQ0VkMlpB?=
 =?utf-8?B?eGhKdGF2THNRK095bGFOOFJKNG5SQzAzOXhxSk5JenBiNHpHZTBvWU9yU0Mw?=
 =?utf-8?B?MlZNeEV6VVBvKzNITFBPMUttNHZQL2ZaQUZPUHVqWjJrUmpuZmVHOGZJM2xI?=
 =?utf-8?B?bjJFeUNENWlhYnZodnpEQThzc3dmTkdXeU1ab2kwcVl1Ny9MQVJDM1VZd0lT?=
 =?utf-8?B?bENwd2hzYWNEWTZXMldLUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVE2ZDdSWU9qZGZUUG9rRW9MRmtvVXpNanRndklLNUpRcW9CcWNjanVuRTJT?=
 =?utf-8?B?a3V4TFBTUUgyV2ZlSVZqbWhWVEhtMERVVVA0cC82SG4xZElQeWxtTURiZno3?=
 =?utf-8?B?T1lDeHFKakRqUjljRGxzNTgrc3JzbWFYWHRpdFJVL2JUcTByZXRhcTR5djQ3?=
 =?utf-8?B?ZnFqU3FCejJVUGdmMExCRmVGVFdxcU5UeGlTc2hNSCt2Z1prcURlbkJGWURl?=
 =?utf-8?B?SE1hRUxUUFhDcU44Nld3ZGxJbWZKcytyS2ZjYjJUQTJickZic2cvM2VwRkhN?=
 =?utf-8?B?VmdIWDRSR2dQYlBrVkJLUUhyWm5EK2ZRZEN0LzJjWGs1MGZUNTMvcHlpc3BX?=
 =?utf-8?B?b2xDK24wOFZ4bHZsUStldUZZa3hxcG40ciswYUhkdUplc0VwcTI1SmRwd1dz?=
 =?utf-8?B?dUFGNXlVSHhkb0NXQnhBdWt4TWxiZHJGMmJsMjhQcTZmeG5GV0V5VU9nS2hJ?=
 =?utf-8?B?Wm1MRmFwUFF2K2VRU3QvTDhHNVpFdVZHb3RDM3hxVnlOM2k3MExMS1EzWFYx?=
 =?utf-8?B?dGZMY2hhNlA3QzN0WU1Md3hzTGY3VDdFRWoycmhaVFd4L0EyS0xMRS9RNGhl?=
 =?utf-8?B?amkrOUxDN1RuK1BDQUZOTEZucjJ0VmlNcXZIQ1B4YUZWWmtiTjBuUU9vQzN2?=
 =?utf-8?B?Z29IUUh3WmZJNUd0TzJhN001cXV4eWRSSlNCUEIrZk93MWpJUVJxL1pQUkhl?=
 =?utf-8?B?Nnlkb2R5QW0yemxJWWllSjd3THplNTdOd2txRFJ1ZHU0YUV1YUk5TzBqL3Ev?=
 =?utf-8?B?a3F2a3hSVTVGMXBBek9UcE83ZVBOYVVoK1dseDVrRmtBY0J2T3BXSXUrNmsz?=
 =?utf-8?B?ZjQvd3FUK2dCTWRZSGJqaml5SDJyWHhhZ1lWcVRVS3VtNEU5M3ZnWHVTeVNN?=
 =?utf-8?B?c2dXdStGMDZRT0l2N2lQL3hsc1ZjRDM0TU1hdk50TWVHUllmUTZReG1LSHlW?=
 =?utf-8?B?WUs4elhRTkFyeUQxMDdxQ0t3eWk5d2FNZDQwbzd6WXUyZFZTQTRFVzUva0pv?=
 =?utf-8?B?bnZrVXRoRHJXaDM0TkttNkEyZWR5bC8xUXJsNVN5VDRXUE1leEFEWld4WUxT?=
 =?utf-8?B?Mi9jdVpyVEs5Wlh5eHIvMmFUWHBWbm1CYlVqeUE3Tk53KzFkODdIcDNmSzl2?=
 =?utf-8?B?UjllV3QrSC9oNHYrVlVBWHBOYkk1bDVFOXEySnBqZkVRK3YvOXo4UVNHNEkw?=
 =?utf-8?B?QW1nb0Eyc21JZ2RUL0ZROTgwcUNYdDIxMUpOUVgyeHUvUzhDSW5JRVcvWWp4?=
 =?utf-8?B?YWxPMGwrcVdwTHNoNkNKV2p0THF5K0RQcllKTzhXM2xnMGtCTnhUMWxnSlVD?=
 =?utf-8?B?VnA4ZmFBZnJXMGxQaXhSZDBJTHhmQURZVjJaMWZGaUhCSFVZNmRzZ0MxYkIv?=
 =?utf-8?B?cUY5aGRWdjZscS9maGsrQVJxc1g3Nm9ycnRNZ09IdzZXTHBqNkNYUW90QVFv?=
 =?utf-8?B?ZG5PdS9WTGZaWkJyWmNobC9nL1VsWnRJVHdqbUl4ckI5VGtFQ3VuRXBIR3li?=
 =?utf-8?B?TEhtNzR0YTJrTXg5VkJUeFhZVVh6TDNOK09LQjNxWUZXZ3Z3dTEyN2lhaFd3?=
 =?utf-8?B?OWpGWERKQW5DWnVjRllWUnFMYms1dEMvV3JpeDNObHNPdE5OMEJHTkJkVDVL?=
 =?utf-8?B?Y0hhcjQ0azdXYWlybmxNa3ZzUEt5NlI5K2dzMUhnVWM1aVlrT1o1SnJlMGY2?=
 =?utf-8?B?ZnNscXp6QVUrWGdiM0tSTnlEVWpQdkIrbVRFeGZiRWJJZzRxRDVtRy94cDRW?=
 =?utf-8?B?akEycy9hb0s5WXREeW9UTklwZDdwRDkzbzF2YjZoclR4c1NOR0dhMy85dWNP?=
 =?utf-8?B?bFV2QlpNNUZXWVB4VDd0U2dsdk1DM2RiZnBnNlYwZFpqWU54cGNYaGhDWmt2?=
 =?utf-8?B?WFVLdStHNTlZeEpPaCt2M2VqUkk2WGtZenFtZmdEeWlySm1aTVpNYStBT1ZY?=
 =?utf-8?B?dGR1Tk5JRm42VWFFVWNCOVAzYlEwcVpDSHlQbVhEWDdIYUk5Y0wzVzFFV3Er?=
 =?utf-8?B?K0MyZDNxdGduWm15Z3RvREo0OS9qcWdia0YrR0t3ZHc2Y2h3WXRENG0rNTlN?=
 =?utf-8?B?NFp0T0xZOUs5OTdRb25pNlY1REVoVnNScUxudEo0dmFETFNUOFA0M0xBMWp2?=
 =?utf-8?B?UVZvSUlJZXdWZHN6bWY0SnlFdGNMSVZxSm9tdWliN1YxSkxPSURwR1FyS0Nh?=
 =?utf-8?Q?9fjGICD5TXFqMzNGM93DmleRXB9eg9x0O+Yru1khaM61?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BDE9331EEC94940832414485A9A4B2E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4c98a5-6936-4036-d23d-08dc8013c210
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 19:15:52.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiPpo+GOglBds8YGi0JLN1sbiqIikrk9sFyewp52TlXhnrlfaGMhsHuoiqtpY2LdMd4SeOmK91z+2TZtrmJB9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_121559_464289_CA79FD37 
X-CRM114-Status: GOOD (  17.07  )
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

T24gNS8yNy8yNCAxMjozOCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gSW4gbnZtZXRfc3FfZGVz
dHJveSB3ZSBjYXB0dXJlIHNxLT5jdHJsIGVhcmx5IGFuZCBpZiBpdCBpcyBub24tTlVMTCB3ZQ0K
PiBrbm93IHRoYXQgYSBjdHJsIHdhcyBhbGxvY2F0ZWQgKGluIHRoZSBhZG1pbiBjb25uZWN0IHJl
cXVlc3QgaGFuZGxlcikNCj4gYW5kIHdlIG5lZWQgdG8gcmVsZWFzZSBwZW5kaW5nIEFFUnMsIGNs
ZWFyIGN0cmwtPnNxcyBhbmQgc3EtPmN0cmwNCj4gKGZvciBudm1lLWxvb3AgcHJpbWFyaWx5KSwg
YW5kIGRyb3AgdGhlIGZpbmFsIHJlZmVyZW5jZSBvbiB0aGUgY3RybC4NCj4NCj4gSG93ZXZlciwg
YSBzbWFsbCB3aW5kb3cgaXMgcG9zc2libGUgd2hlcmUgbnZtZXRfc3FfZGVzdHJveSBzdGFydHMg
KGFzDQo+IGEgcmVzdWx0IG9mIHRoZSBjbGllbnQgZ2l2aW5nIHVwIGFuZCBkaXNjb25uZWN0aW5n
KSBjb25jdXJyZW50bHkgd2l0aA0KPiB0aGUgbnZtZSBhZG1pbiBjb25uZWN0IGNtZCAod2hpY2gg
bWF5IGJlIGluIGFuIGVhcmx5IHN0YWdlKS4gQnV0ICpiZWZvcmUqDQo+IGtpbGxfYW5kX2NvbmZp
cm0gb2Ygc3EtPnJlZiAoaS5lLiB0aGUgYWRtaW4gY29ubmVjdCBtYW5hZ2VkIHRvIGdldCBhbiBz
cQ0KPiBsaXZlIHJlZmVyZW5jZSkuIEluIHRoaXMgY2FzZSwgc3EtPmN0cmwgd2FzIGFsbG9jYXRl
ZCBob3dldmVyIGFmdGVyIGl0IHdhcw0KPiBjYXB0dXJlZCBpbiBhIGxvY2FsIHZhcmlhYmxlIGlu
IG52bWV0X3NxX2Rlc3Ryb3kuDQo+IFRoaXMgcHJldmVudGVkIHRoZSBmaW5hbCByZWZlcmVuY2Ug
ZHJvcCBvbiB0aGUgY3RybC4NCj4NCj4gU29sdmUgdGhpcyBieSByZS1jYXB0dXJpbmcgdGhlIHNx
LT5jdHJsIGFmdGVyIGFsbCBpbmZsaWdodCByZXF1ZXN0IGhhcw0KPiBjb21wbGV0ZWQsIHdoZXJl
IGZvciBzdXJlIHNxLT5jdHJsIHJlZmVyZW5jZSBpcyBmaW5hbCwgYW5kIG1vdmUgZm9yd2FyZA0K
PiBiYXNlZCBvbiB0aGF0Lg0KPg0KPiBUaGlzIGlzc3VlIHdhcyBvYnNlcnZlZCBpbiBhbiBlbnZp
cm9ubWVudCB3aXRoIG1hbnkgaG9zdHMgY29ubmVjdGluZw0KPiBtdWx0aXBsZSBjdHJscyBzaW1v
dXRhbnVvc2x5LCBjcmVhdGluZyBhIGRlbGF5IGluIGFsbG9jYXRpbmcgYSBjdHJsDQo+IGxlYWRp
bmcgdXAgdG8gdGhpcyByYWNlIHdpbmRvdy4NCj4NCj4gUmVwb3J0ZWQtYnk6IEFsZXggVHVyaW4g
PGFsZXhAdmFzdGRhdGEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdp
QGdyaW1iZXJnLm1lPg0KPiAtLS0NCj4NCg0KdGhhbmtzIGEgbG90IGZvciBmaXhpbmcgdGhpcy4N
Cg0KRldJVyBMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

