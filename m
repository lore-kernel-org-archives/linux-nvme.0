Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1E8C25B74
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cpiq+rAJYqKF2B4x48mYA9EpsFoSD2ip/dSXX4qkdY0=; b=iJ3mJIa/VXOhrmniPWTicAnhDd
	Q/sGI3CdT7FQDrb0esTs5C8ySs0IcIFg++mN8F+iGjt6VW9lpRP4reM1BXYhMZxeY8Gqqcx8cx4u7
	zGCVt4FxgHFmYx9/ZnAdCD3wqmFKdVDTtaPHmD5yRIGcvIOICGjagnjDp/SRLbfIGE7Ga8dDj/+ac
	1hAAusOaiJg8EPyAZ70tnNJ3uZeu+cgFX8pdLrlZfGTNHsnovQs9UDyuRNHc+klqfhdbnNbrD/C1Z
	BS10BRUpX4imr9ZD0hblHnByIhjfSCIHA5y2rULhkbiozQVPFaY8xry3sqKEW9QIkw62xVDos2AJ9
	2EHr0lOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9aFd-00000001SX2-3sSQ;
	Wed, 22 May 2024 00:54:41 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9aFa-00000001SWR-3dyK
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 00:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4CXq+9ZV6ukTPbsSeI06xaLFR+pQnhPh04adlBJz6YcazYddVvxbAczmWi7r1SHnwdItUNh/6Ok/KCXrWQdI5592tecaH34Jn/tYCZNH2G2ywArvgUeWpFHaDxwicA9OGcq3Xb5rJIMFfGIAvQf1PeiQbk7gcxrbbZf8JNGrt2yQUP7IUfbRkaOEvy7dENsIOHMsFQgSwsCmiVCJ2VsWKeUs4nyE+CVMd6LH5C72qGQTfAM/Ld3Rgqr+ouf5YqiaAb9NEUS4x8bPcEObogPi1Mxvy9xkVbiTSOUlvLGZsLtHP3znIiMSBbAMlGPXhzWLQXQc3yEcFq4YPF4QMrrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpiq+rAJYqKF2B4x48mYA9EpsFoSD2ip/dSXX4qkdY0=;
 b=FK3ECvjLvwyZSHbMyLWuQkxD8DgeJsiymTF9GLwCyMeTLjHw5w/UUHEdakf41E5Md8XiT9QVPPxpQ1flAaSviNANxz6fg81qcynK7MleogJFTltY/Gru7tGmCDoLA7I+x17S6ojtv4df2tkFaPVSh8n+eMaFowiKNb9vsHTrtA5OATJ3tFrYVcNyo1NTe1DOqcl+BG2mFCRHipA4IO+4R0CstAIsnftJjJHHQfQcbSyQq7pXP/kSgRu/5ARm0O/xOETPVK1WJ5ezsbe7RHHGQ/38evFmkm1Va+6daN5pbP5fYVIXRcFhEcUldY2JZZ7CCuLvRuKVJz9Rl5Ko98Oklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpiq+rAJYqKF2B4x48mYA9EpsFoSD2ip/dSXX4qkdY0=;
 b=KZyKZodliKURYXmNLWtn5ka+K8PIzeqWTj+rwOGXYzCW4FBNPMSOygqYNgHqlOCAmi4XojLkJT5obNCAIjo52NWcTuJl9LCKwaLMn/7f4VLE5WVhZNJFngd6FkfzkrPJpEfUtahV5G9Gg/p84hyeJdQcrM8fG/jq9fKF/+ygLOEwOSxawjIYRFZ50OiQ+XGPi3KpT2kZYoDbciUhFlNfHXFZxXUr36oMRvg7ae5O8ufzgJf4j4YbEkN0b4O7M1WhAZTp0N9uFhvFP907pOtgdU9l3MnUMF2Q453jO77+Wr0WxphBHk8Xaao/vg+L7cJPX7xwANVGAMfk+b1aqu82oQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Wed, 22 May
 2024 00:54:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 00:54:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests] nvme: add regression test for concurrently
 enable/disable nvmet ns
Thread-Topic: [PATCH blktests] nvme: add regression test for concurrently
 enable/disable nvmet ns
Thread-Index: AQHaq1zUvH5E0yZZBkuDv/8RV48ciLGibnmA
Date: Wed, 22 May 2024 00:54:30 +0000
Message-ID: <010a2f18-1f2e-4f95-b5c3-08ee1a197ba6@nvidia.com>
References: <20240521085623.87681-1-sagi@grimberg.me>
In-Reply-To: <20240521085623.87681-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7222:EE_
x-ms-office365-filtering-correlation-id: e9639911-2e31-4da7-5d8c-08dc79f9bcda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WnBlWDlaeDZpVWxCMVpKUW5yN1N5UU8wR0lCSlhtQ0RiZ0NpS3RJK1Y4a1hi?=
 =?utf-8?B?TTJzaC9tLzZKTnJKMFE4U09iYXVJZ2ZZTlJJNFFZNGMwYjdiSk14enBLU2pi?=
 =?utf-8?B?SVlHYlFLOFB0M2JFZmo0QkxMNFNocHBqeUZyK0dSMXoyNFU0OUhZQy9KREpk?=
 =?utf-8?B?RGZSVnlIQWx3dnBvVEluWm9HUjRFbThtckFLY0hCWUlhVHlhRnhqVFVNUExK?=
 =?utf-8?B?SnNkTGZuMWhUNTNTaGhTTE1ZT0k5QjBraUtqbDFmMkpSWkVIWXMwdDhBSGdU?=
 =?utf-8?B?TUJNbHo1WHF0dVdNaU5hL1A4ejFhRG5qbHpWcEE3ZUJWaWVtM2dvcW93WWVh?=
 =?utf-8?B?RStxVkRDY1ZjVjkxRWtJMkFCN1R3Sm5TUkdBRlJ3cW80czEzdGVxMDlIamdo?=
 =?utf-8?B?L0k3TGQyZVZMR2JSWU9LNnJFejBFc0QxZEJkTE5pNUJyNU8vaFhrQllxS0Z4?=
 =?utf-8?B?NWhoc0tEK0FqMzNMc1g1NDUzaDREcnZXdFhGeEcwWG5OYXM1L252ZmxzT2E1?=
 =?utf-8?B?Z3YzSDZoZlJTTTI2bnk1anVpbWh6WEp0WFFXYnJpM1JRVW1DcjlzTS9senNO?=
 =?utf-8?B?alVqbUo0NXo3YW5rVnVwUlhlNnl2VTRNUGdPQityRHR0RG4wdDZJVE5Wdkd5?=
 =?utf-8?B?cUcrU043aWRYT1BGb3RiZkg4SmV0em1aZXg1UE10RVFVd3paaUxmTVhsRzMy?=
 =?utf-8?B?MHpud3hVcjlKa09uYXNocDBHYnpQWGZSaWVSN2haQ2lhemV6OExsbEptRHhx?=
 =?utf-8?B?eUxGZzI0QnllMjlVM1MxbWNjRms1NUZBeG8xdnJSZ1VSck5Vbk83OEx4WnRN?=
 =?utf-8?B?MGVkTStkUURwM0hZQ0lvNnVtYTdGN3pWSVZFN2VlZzBDV1g2bGY0VjUySjBj?=
 =?utf-8?B?ZytKamcxMjV2Tktnc2ZJM1ppTE84S1Y5dE9yUEZVSEFtczFadkdMTDJ6VjJa?=
 =?utf-8?B?aDdUalFNczdSWVFaQ0d6enNSaDZmTzR6U0xwYUg5TkdJMEZ4UGM0V2FmUjlJ?=
 =?utf-8?B?T3lVajN1dW1RZDMvUUNyUnpqR3k4M05wbjlVN3l1RklGTU1ERWFHdWZkMWpo?=
 =?utf-8?B?alpiYnB4VWJkVU5PUzhsL2lPdVo1aWEwbWhYbEdLcmppaEtYUUhsa1YvYm03?=
 =?utf-8?B?WXlZU29MMlRBV2d6djArYXVnekVleTV3ZUsxU3FGQmNwbmdQWjgwdlVjdVlE?=
 =?utf-8?B?MTA4Q2tFc3BqZjhqZmZEU3IrRnh5Y2syUGU5L0VtaURTL2wwVnc1TXNGVHZZ?=
 =?utf-8?B?UnJ3SzMyMGFUMlVCWmNNSGVUdW1pbGh1Mjc2T0hHUXFLOVZZMk4vNUVBMCtB?=
 =?utf-8?B?REV2bVRwaFluM0szVFdReVBqSmtJcm16MzVWRWYrbGU5WXMwWUpacVNvY2Jq?=
 =?utf-8?B?Y1B2QkVBeHllSWd4R3NVUzZTVTlQS2JiSHFLYk1ZbDRhZ0VPbElWYmtnV3lS?=
 =?utf-8?B?QnIxOFE0UzRoa0ZuZGRaKy92WWZjZmNDTC91UWlhbThsb1NiNDIwUmJKUm9k?=
 =?utf-8?B?SWxaL1BwQ0pUaFpheVg3c29PaWl0TDFlb3hNV1JvRFZpOXFpQnVhNEVJQXl4?=
 =?utf-8?B?dVpha25mRXNjQ0lDN3BwN3BXbEZTSjRjOHNMRDliKzFGdWE3d1VKSnlWZmNE?=
 =?utf-8?B?dlBGMFVPTDFOK1RyVXlqaUtUV0RJMDlGbTdMRllQWER5ays2MkhFNTAzdEVh?=
 =?utf-8?B?cTFQUmgrTXBqamJGRklCd256SmNXL0RlSlpOVWhNU1Zra09WM2ZrUmUyV2pZ?=
 =?utf-8?B?NTdvZkN1TUVmeDYyM29HdWtlbmdQVWRkUGlnSldSZVE4aXZUdS9jRVZTSllx?=
 =?utf-8?B?M0cxVDRQbCtaMmFvM3VBUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXBFaFh0ditYM01KYnJ3cm5YQ0lvck9BaDNuMlZtWE9iSUcrYVp1OXBpWWND?=
 =?utf-8?B?V3I3QUNIZnRFUG42c0hYZjJ1UVorWDlMMHlhVzBJczdBaW5Nc2NkRi9zTFpL?=
 =?utf-8?B?UWdIWGxlZUhOa3FlcUR1Q09PTzhtWURIaHdta291Wnd2bjVnYXgzTDhYaE9r?=
 =?utf-8?B?d3VLRWdIaklSMUZHZHdnL2Nqc1hMTU0vR1dSVmx4aDZjejJXMDFndmRFL2Iw?=
 =?utf-8?B?bGNUKzAxN1FjS1B1WGxtTG1VYmtoNmxtMUVuV3NBZzlPQlNncHZ4Y05yZlZO?=
 =?utf-8?B?cCtaeTB2S3dRdXErdWp2Yy9sSFdNcm9tam9aOFlhRWMzVjFLeE1hdGNFd2Rw?=
 =?utf-8?B?Vzg3UkhHbG9WK2sxdHdhbWM0eHYyaXRIR1dwWERrSmgvY0U4cnpLcEd4Vkds?=
 =?utf-8?B?K2ZpSHVyODhwb3MyUDY4VjVFRzNOZ0Y5czZ1NmFIaFROdUlKaURtWTBkVVQ2?=
 =?utf-8?B?WEZMZmxvSnpXY2F4R3NFUm5zMkt1RnV6V1ZySkE3NS9VZEUycGMwa1VqbE9F?=
 =?utf-8?B?ejBRbis2emtCTGFBaGNKOVBwZlJLSm5WVEtKZEI1Tm1VV3dIN1VIRUQ0UXMy?=
 =?utf-8?B?UmYwNkhETXlTUTNUaWVMOFQycTZyVTNrZ2cvVGg1dGNhM3hvQ1BjZEpLM1VX?=
 =?utf-8?B?d3REdzRDVGhDQXpkNFZJTjdoY3EwVkxNSnBGUUdJU3g3bUQySnpHZ2gzcThj?=
 =?utf-8?B?RFh1Y3ZyRHEwaTdVc3d3OHVxb1A4UHJXMUNobVFUWEErekZnNnN2NG1haTZx?=
 =?utf-8?B?UmVkN3M3ak5KSjhqY0tVZjk3YlNmbkpzeUlQQlRzbXkvWnJuK1dVY3Zjd1RQ?=
 =?utf-8?B?Y0ExMjhteksyQ2FRTWlIQ1RVZzVtTDV5c0l0bGJwc1FVdElWNUNmQVcrOHMy?=
 =?utf-8?B?SFNpZW9wY1FjTm1KOWs5R0MrTUhTdkc0dTEzRm1pL0RjaFNRRWZ2L3RLaTMr?=
 =?utf-8?B?T1pZR1VsWDhHdlZBeWsvbkdjbWVyQXZZWVdkMFFuSnlWUm9HeERLeVZMd1Z2?=
 =?utf-8?B?K0FoWWJwVzFndTcyMmU5elliZW1ZN3NIMXRMSERudC8zN0VPaFhXS0FDS09W?=
 =?utf-8?B?N1VHRDNzQTNoWmZiUTRoSjhmeldHV3kvTzR2Q0o0elA3cFBVd2ZYOU8ybFhZ?=
 =?utf-8?B?NVV0SzZ1Q0lkR0tqeEV2UHE5NlRVZmpVdm9INDB1RFA2OHhoeTl6VmtCa1Fp?=
 =?utf-8?B?Z1ZEcjRHS1JNUVZIbjlVTytFdy9sMDV4TTkwbmFqZFNzUzV1M3FXYzFnQzV1?=
 =?utf-8?B?dmlrSlUwUUNMZXdkSWZxLzJqU0xVTVdwT2ZNVEZJdzR6R3Y2anZUVGl2ZDR4?=
 =?utf-8?B?ZGp0NkhBTG1JRm1zdzlIMGVGUTFxTGpSWlNIYXpwdW5GYlI0VUJ0ZWtYS2hv?=
 =?utf-8?B?cGRJbjFhZnlDRURoUlpJeDhJNE1jTDNZQXRJMmNNM3BOb3kwK212M2xQNHFp?=
 =?utf-8?B?cHJQcnJzTUxKaXZFaXhKWENZSHVDM09mbTJWa2xtUFZQaXp3d0FOd1hrZnJU?=
 =?utf-8?B?T0g0aDFBOUtad3hTdk0zYkZQZ290dGs3WmI0Lzl2UFVwbU0vU0JjbEtFNlBD?=
 =?utf-8?B?bjFYSWNYbk1FZ1hqNlNRZW1kOG5DSDAwWmN3ZUM1L3IzQ2VvelZCbTBsNlFX?=
 =?utf-8?B?OTZPVVEwZFhQWDFKZXhYMDBoeVp1Ynp0SnVWZCtJc1l5N3V3RnJ0cWsrbTl0?=
 =?utf-8?B?aXh4NS94R0RSUFhRSzFRSU81amE2WWpwYTVPbUxUdGFuRE02NXJ0eE10UGRY?=
 =?utf-8?B?UzJTZ1BPei9hcFYvWXZOWWRTR0hpVjZWdTkrOGNsdnhGcHJVZ21ra0FJQWpI?=
 =?utf-8?B?cVQ3dDc2RXFHSjJxRlArbyswUFNOYzZVZ1RiUDdTSU5ZOHduNlNJcE52ck9k?=
 =?utf-8?B?dkRQbWZzVDkvOFUycUpGNjF5TzlDOHFjNGlGM2FMOEthdFc4WTdOWGNtM3pH?=
 =?utf-8?B?ZHZHSG1SeUtOOWwwbjhZTi9VR1VXTmp5UldMREkxVXpTWVVCcDNicUdkQWhh?=
 =?utf-8?B?YjRpOUNidjA4TmprS3ZmUlluT3RpOExXditFcTJtS2lLWXQvemd5TzlmSTlM?=
 =?utf-8?B?Q2hMZUVoVHhQSk5BaWhLRjl4TStiZ1JKeDFCaSs5WWpKVzdXdzNNYVRvOE42?=
 =?utf-8?B?c20rbW5nRFFVQ3YybkNhcTdlbTREQ2ZYdGhvelk5YVBvUXR0MXpFSGNNWXFr?=
 =?utf-8?Q?1ZsF1cUotfArunfSePOSr8JHHkIsNzqg8+aGtjSj62WY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B10E7F86225B74A8ABD443C2C481250@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9639911-2e31-4da7-5d8c-08dc79f9bcda
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 00:54:30.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nr3EPnb6b6AC0LYuGMGl25a+Q2pB5SYhKDRn7q4btw8mVQbMR08QjcaDBgKXqb3rR/w++uMnafB7ueImjyGGgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_175438_936693_E7A531E8 
X-CRM114-Status: GOOD (  20.19  )
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

T24gNS8yMS8yNCAwMTo1NiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gUmVwcm9kdWNlIGEgaGFu
ZyBpbiBudm1ldCB3aGVuIGNvbmN1cnJlbnRseSBkaXNhYmxpbmcvZW5hYmxpbmcNCj4gYW4gbnZt
ZXQgbmFtZXNwYWNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdy
aW1iZXJnLm1lPg0KDQp0aGFua3MgZm9yIHRoZSB0ZXN0wqAgLi4uDQoNCj4gLS0tDQo+ICAgdGVz
dHMvbnZtZS8wNTEgICAgIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgIHRlc3RzL252bWUvMDUxLm91dCB8ICAyICsrDQo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL252
bWUvMDUxDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL252bWUvMDUxLm91dA0KPg0KPiBk
aWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS8wNTEgYi90ZXN0cy9udm1lLzA1MQ0KPiBuZXcgZmlsZSBt
b2RlIDEwMDc1NQ0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmRkYzA5NzMxMGRkNw0KPiAtLS0gL2Rl
di9udWxsDQo+ICsrKyBiL3Rlc3RzL252bWUvMDUxDQo+IEBAIC0wLDAgKzEsNDggQEANCj4gKyMh
L2Jpbi9iYXNoDQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4wKw0KPiArIyBD
b3B5cmlnaHQgKEMpIDIwMjQgU2FnaSBHcmltYmVyZw0KPiArIw0KPiArIyBSZWdyZXNzaW9uIHRl
c3QgZm9yIGtlcm5lbCBoYW5nIHdoZW4gZW5hYmxpbmcvZGlzYWJsaW5nIG52bWV0DQo+ICsjIG5h
bWVzcGFjZSBjb25jdXJyZW50bHkNCj4gKw0KPiArLiB0ZXN0cy9udm1lL3JjDQo+ICsNCj4gK0RF
U0NSSVBUSU9OPSJ0ZXN0IG52bWV0IGNvbmN1cnJlbnQgbnMgZW5hYmxlL2Rpc2FibGUiDQo+ICtR
VUlDSz0xDQo+ICsNCj4gK3JlcXVpcmVzKCkgew0KPiArCV9udm1lX3JlcXVpcmVzDQo+ICsJX3Jl
cXVpcmVfbnZtZV90cnR5cGVfaXNfZmFicmljcw0KPiArfQ0KPiArDQo+ICtzZXRfY29uZGl0aW9u
cygpIHsNCj4gKwlfc2V0X252bWVfdHJ0eXBlICIkQCINCj4gK30NCj4gKw0KPiArbnNfZW5hYmxl
X2Rpc2FibGVfbG9vcCgpIHsNCj4gKwlsb2NhbCBucz0iJDEiDQoNCm5pdDogaG93IGFib3V0IDot
DQoNCglsb2NhbCBucz0iJHtOVk1FVF9DRlN9c3Vic3lzdGVtcy8ke2RlZl9zdWJzeXNucW59L25h
bWVzcGFjZXMvMSINCg0KYW5kIGdldCByaWQgb2YgdGhlIGFyZ3VtZW50IGF0IHRoZSBjYWxsIHNp
dGUgPyB1bmxlc3MgdGhlcmUgaXMNCmEgcGxhbiB0byB1c2UgZGlmZmVyZW50IG5hbWVzcGFjZXMN
Cg0KDQo+ICsJbG9jYWwgaXRlcmF0aW9ucz0yMDANCg0Kbml0OiBub3Qgc3VyZSBpZiB3ZSBuZWVk
IGl0ZXJhdGlvbnMgYXMgdmFyaWFibGUsIHVubGVzcyB0aGVyZSBpcw0KIMKgwqDCoMKgIGEgcGxh
biB0byBtYWtlIGl0IGNvbmZpZ3VyYWJsZSBpbiB0aGUgZnV0dXJlIG1heWJlIHdlIGNhbg0KIMKg
wqDCoMKgIHJlbW92ZSB0aGF0ID8NCg0KPiArCWZvciAoKGkgPSAxOyBpIDw9ICR7aXRlcmF0aW9u
c307IGkrKykpOyBkbw0KPiArCQllY2hvIDAgPiAkbnMvZW5hYmxlDQo+ICsJCWVjaG8gMSA+ICRu
cy9lbmFibGUNCj4gKwlkb25lDQo+ICt9DQo+ICsNCj4gK3Rlc3QoKSB7DQo+ICsJZWNobyAiUnVu
bmluZyAke1RFU1RfTkFNRX0iDQo+ICsNCj4gKwlfc2V0dXBfbnZtZXQNCj4gKw0KPiArCV9udm1l
dF90YXJnZXRfc2V0dXANCj4gKwlucz0iJHtOVk1FVF9DRlN9c3Vic3lzdGVtcy8ke2RlZl9zdWJz
eXNucW59L25hbWVzcGFjZXMvMSINCj4gKw0KPiArCSMgZmlyZSBvZmYgdHdvIGVuYWJsZS9kaXNh
YmxlIGxvb3BzIGNvbmN1cnJlbnRseSBhbmQgd2FpdA0KPiArCSMgZm9yIHRoZW0gdG8gY29tcGxl
dGUuLi4NCj4gKwluc19lbmFibGVfZGlzYWJsZV9sb29wICRucyAmDQo+ICsJbnNfZW5hYmxlX2Rp
c2FibGVfbG9vcCAkbnMgJg0KPiArCXdhaXQNCj4gKw0KPiArCV9udm1ldF90YXJnZXRfY2xlYW51
cA0KPiArDQo+ICsJZWNobyAiVGVzdCBjb21wbGV0ZSINCj4gK30NCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL252bWUvMDUxLm91dCBiL3Rlc3RzL252bWUvMDUxLm91dA0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjE1NmYwNjg3YWFiMg0KPiAtLS0gL2Rldi9udWxs
DQo+ICsrKyBiL3Rlc3RzL252bWUvMDUxLm91dA0KPiBAQCAtMCwwICsxLDIgQEANCj4gK1J1bm5p
bmcgbnZtZS8wNTENCj4gK1Rlc3QgY29tcGxldGUNCg0KaXJyZXNwZWN0aXZlIG9mIGNvdXBsZSBv
ZiBuaXRzLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

