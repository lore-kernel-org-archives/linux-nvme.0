Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E03C2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jul 2024 17:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zfu3L4uu3+4iebbkVf5/qAkw9wvGWv6HmqiW8CtBVzI=; b=Mx2gfWr6ceXlYbpmF5SJX7PGSK
	W7ejSaPRzZ/0GtqjDffA8ZsO5gw/ReMs2BfUSofok/S+OGjgcJyNYgws+syiefQ7HGKaWclKhBB75
	cPFySzoHjVHpMP8Wst4YOK8Eq0sqthhpucR7cqfOa8o4wAO/LoDIab2PJGa1ZKMDTDqMUtNGkRA+X
	oRWeGzIn1KGgoPcjCG1znpLnvRvMZeaDxWeV6VJ3r6mFheKsN5ZOv3Qt2p9m4rDGvd5BtOziiZyBl
	7+stiO6D1Vlk7pSzdwkcxOCZLgslGQWILtN99BnS6wt6eapE1DdLR3t897jgm53o2mMjlPmEik1rV
	M0vVdA7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSKHT-00000000sOK-0XUr;
	Fri, 12 Jul 2024 17:42:03 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSKHQ-00000000sML-0AGk
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jul 2024 17:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1VXOUswaz8i3JdSOSSH7K6fsnM7wR72Chee2oXaDU9teWHhdYRqkh5qxj1zRZKmpgJRZO9jksXqQmGLonmp2H1qMlLAuvEzuVe7X7d4wAzohn3xQE5B0jpMITuHzSNBnLeHKkeSHwL7J95eCHS/F8iLWwjeZWJjxiA/uMwtkhTVkp0xfx1IaHh5n8v1+qa03SoHJ3WCQF8YKKlkC97QVG7B5ei82uLnVQtDjlBYAPlrC2Rmy0MImZ0Ro3wJ745pzmCbWrLUHBFUlZURLH/cuDlADcwxS3Kzp+oJKLbeiEWPUd+6IFXvR6nVtXJD+1RJqUhK7lJMuJJ99lq7gmGKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfu3L4uu3+4iebbkVf5/qAkw9wvGWv6HmqiW8CtBVzI=;
 b=yVqLVuCw5b8bpggelqYgqtlx3wH/+dnCAZOePPEEFIyhBOYHvAWAUEP6i7H7M3PEzTtVCHLM32IVBUq/vj2dffXtxQzIKtqzBhTgMLJQ6/eEc0Po/ZZIkC1BIKv4hQkqjKgUDPWBv9lI7zWn2COB+Kl49HWDtrSMhj+UWF0LQ5DdCJP7+wD/bfhk5mMfgy12X4wHncZuZBwcBeC6ofgHCN0VXGAlTj6oHt5l2GvM2HlDXEns6/bwRdH70z2VYtvXZgU9kOGsQCmWcqmX/cKnKPP6SQ1mrMX4LP2F5HckaBYB9yQswq6d3w5KVhEqUrzHBz++w6RGZNS6fv1a2k8Klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfu3L4uu3+4iebbkVf5/qAkw9wvGWv6HmqiW8CtBVzI=;
 b=MHvSkL13AObmZte8CdTmJqD+h6CLj/uqiyMfF1rdavyx0xh41Q2fSQ2nnWhxq3Eem3LA4SqzdfZsTk5KvbmN4vHt5BNH0m5irmBPad1zry+0eKa1TD1Gwa1r2JxmiwiEjkVe8lzu4+ncrz8QEM+8mRx1l/Ar7kqoWi3HmeZB353RWrosIxGNtMcCApE4+7+vINnQsTi2ETh0Eb1M1HGemai7Pw4z0773fg5vQpB2I+T43C6tJBRfKSTJ1XM2Ac9J/yOBmNRZctak0zibcSccXKmJ2EhS0FnUG6BX/S8izhzEhv77pV6hJHWAIsgCyEf2Egi3tBTJKYZolWlxVPtLEA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 17:41:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 17:41:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Israel Rukshin <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: remove redundant bdev local variable
Thread-Topic: [PATCH] nvme: remove redundant bdev local variable
Thread-Index: AQHa04dXl+TbnbD4vEyeOZeFktflt7HzXoAA
Date: Fri, 12 Jul 2024 17:41:51 +0000
Message-ID: <2955fdf9-529a-4858-a9cc-d4338b228aa0@nvidia.com>
References: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
In-Reply-To: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6027:EE_
x-ms-office365-filtering-correlation-id: 920fde40-1d31-4d3c-e265-08dca299e987
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXJvSm0vekpvSEp0bWc1YjB5REQxN1FwRDY0dXdtL1hhcks4aW1iZ0habEp4?=
 =?utf-8?B?eWNiVGFxK2JqazVndUJWRTREUDY0aC82N0xGcGNweGd5UXVJWTVoeE1FNVND?=
 =?utf-8?B?R0d1emJ2cUhFMnpFSkd0bS9SOEpjRG5CN2kwcEhxaHdCQXY3MkVnUnlnd2t0?=
 =?utf-8?B?OHY1bTBybEVOY095RUMzRjZuMDdJRVVTdGRTM3AwQVNTNWJ3OE1EU1hxTzlB?=
 =?utf-8?B?TjMzOG5UNDJXNWxLZjByRmVKQ3BJYnpveVFTaUlzcTFDbHBjOUxpY2tha2dF?=
 =?utf-8?B?T2J0SGJVcGJIMzZyMGVyUHlybHFLb1ltNkdqUVIxczNybG82WjMwSjdML3dl?=
 =?utf-8?B?SEtnV0Nmcnl5VmZmUDdySmhyN3ppODVsazJmWnB0UUliQUN6c0grRlM3U2hv?=
 =?utf-8?B?K1N6bDgxdDB3VEhNRjBHMXhyZ0pValVRWUNJbjRvaDRFNnRMS2Z4aGpxckt6?=
 =?utf-8?B?b1lLZmtrdHd6a2crYnFka0d1WmdpUFRWL2dzOUlvNlNxdmJJV2pLMGQya3pU?=
 =?utf-8?B?U2dOYkNHRU0xV251SXptRzhYbWthN2Rnd3A1L1N4aGpFSFdJczZHRUJVeHph?=
 =?utf-8?B?V0JoNXN0SERzZDBnV295WDFiVFZaU1hIM1VLMy8vQXZwa083WUFqMlpDVGlU?=
 =?utf-8?B?VDg3c3VxSUNaM2lyaURINkNYOStWWWZ6a2Uzd244eXNmQS9lOUlZQ1pGTlRP?=
 =?utf-8?B?RWpVMS9Hcnp3WDVhKzEvWmlwbkhsbGZFNC9pbFJkdzFYVnZtcDZJTk1QUW4v?=
 =?utf-8?B?L2ZXc2FlclExakhCaXo1NUhwNGVSbFNXZnc0dzBJbUMxek53WEROeFRKR0ZZ?=
 =?utf-8?B?YjJQTVFTeWl0MCs5VFZPVko3UFhidnhlZDQxMTFibFZyOXErTzY5SWswMVFZ?=
 =?utf-8?B?dlFiRW02VlBiZmNndTZrYVVPTGxNLzJlbVFTWmJCdWhITzVCeCtzMG5BQWlq?=
 =?utf-8?B?VFVNelNoR25Vbm43Q2lBUDErNEpvQ1hRSGtBK1cra1NqelhRVFdQRmtxanZF?=
 =?utf-8?B?NDdZdFdTWE8wditmWlhlYzNVRENsQSs1SkhkMGVLd0JuSHRGR0RYazdqTUpQ?=
 =?utf-8?B?ZlBSWVBsdTZBY1IweEZQaGw5T2E4L2ptTXg4R3M0dzNad05MTW1DaDBsR2Zk?=
 =?utf-8?B?RWdwelozRDFsNGh4WmVma2xiVzgvZ1lnR1puNGVZM2c1c2tkZmR0VERjaDJR?=
 =?utf-8?B?TDRkNU1TSlRFYjRZZFJJcmRPQmNZd1NBbXhOOG04cVlVUFBxcmxpRDU3ZW1k?=
 =?utf-8?B?ellwTWFnWFphQmo5NzRFZjhZTUFXUVJFS1VocWw1dDNnT2VBV1pUOGNZakFP?=
 =?utf-8?B?SForamZXUW5LSFBGbEdlVURPY0FTV3MzaDRUMGU1ZU1zcldaRlZjWWNwNE4x?=
 =?utf-8?B?QWZ1cUJBN1hrNlRNRTFUdzJ1bU5FRjdzQzNTVy9tK2FxbEZSdU9ZY0JjT2pT?=
 =?utf-8?B?ZmYraklyb0t3RG9Gd3YyME5hWlRVdW9NZG0zTTVsNnpVTnBFRTlhd3Rsakoy?=
 =?utf-8?B?RnFTN3N2Mk9ZSnlybEFtZ3VsVHRoZmNFdzM5dkdHN3oxVSswTDFGNjRFZWIx?=
 =?utf-8?B?YzJMQlo0aVZxT3dlQzRBeHE4UTYzai96MnZQQjFPSkZqTnpIRFVDUGkrRmwz?=
 =?utf-8?B?aVFtYTEzcndWMWRzQW85c2tkVy9IT0haYWxSVWRQdmczb0pqaEh6dm5sL1VZ?=
 =?utf-8?B?blVBdTZJMXQrWGMxcFNrSkw3NG9oY1Z3N0Y3RzFFVGF0ZlJJZVdpTnBHN3pz?=
 =?utf-8?B?dll4U2Mzc2xKelNnb1RvdmcvNkthaXhVOU0wVjFHY2dJRFBKN2ZRRVlWb1lp?=
 =?utf-8?B?VHdUaU5WSGVWSzJqR3orMWFVa1dXbS9MT2lLUVprY0FHUWpjTzRFeEZRZElN?=
 =?utf-8?B?SzZJcHFzdnhMZGhwcVRRN2I1T21Cc1JaM2FOZlVLeStwM0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW04VTRyM3NlYU81bWVWY2k5ZEFsYXRXcTM5VTlVM256TUQ0MS9CK0dDZGVP?=
 =?utf-8?B?OVkrU2VnZ2JBYzlYSStab1J3ZytYTmxidzNzZkt1RHV1OUtyYmdMaUhjZ0JF?=
 =?utf-8?B?KzNBTi9DTHljZlBmMlVrTTFUVENIVVBpaDZVS1hUblRVaFkyUHVnRnB4UGpv?=
 =?utf-8?B?UzVMY3ZjNVZpaXFyVUF4aExrOGtoRnBjY2xnb0hQUEZJRFJKM2xBL3BuWkFQ?=
 =?utf-8?B?QkovYjY3RCt5MFhDRU1DcUdNcFhGajZVcy8vejJyeDRqVjF2RUVWQlNuanU1?=
 =?utf-8?B?SW5HSVduN3hXaERySkMwV0htdkw0bzZsOEh0aDA2MEwvT3VCcDlWU3lSd1RB?=
 =?utf-8?B?ZlFBeVY3N2VCcUUrVEZBbE1tbjNXamNHU09LOFllWW12dnBqRnVaVTJQL1Q3?=
 =?utf-8?B?b2NKbFgxY3hNWW1kZ0tXdm9PVlZPNjZodkxtdlZUSDc1VW4vVVN5Y2sxOVVB?=
 =?utf-8?B?aDNnSW81WXpIaW15dEpGcEJXSFF0S1NaN2VwOVBEaVgrLzZrL241anZJY0NI?=
 =?utf-8?B?UTVGelBmR1BlaXBncDE4eWsybnB2cWJqTmtvdm9leHBlT1hEVXZEdFlObUlr?=
 =?utf-8?B?K0NKcWpaTVN5bmczN2c3NGhWc0hxUUZkSGhyV1V3TlA5NERkWWZjempmL0Nm?=
 =?utf-8?B?TmJNRXYrdTdOTFVXRDMyendXWlNiYS9ET2pmOEl1a2VuSUlBSVhXMUM5YzJ1?=
 =?utf-8?B?ZGt1eG80NXp2TFlRZXJ3RlZCMTByK1paTzNzZlJ3Sk5UMVlBSGhRa3NVSVhD?=
 =?utf-8?B?djFld0RvRTl3VmMvOG1tWk9CZXlzeHBvR0NPMzdiSmF5bEZ3STJaU2I5VGpH?=
 =?utf-8?B?N2hnQjdWcXdBd2dmZEJvRlgva005MG42RUZzUXRBMjJDckxDT3VWaExGeHE2?=
 =?utf-8?B?aVBoZjJaSGVNenZYZjA3Q0s0SUFGb01pTlhhY0YwWHBwVmpsaExIU2M4VU9B?=
 =?utf-8?B?b2JxYk0rUTZtZGZmSXlZTXl5b1NKSHVJNnc2RFBoN0ZLTTlUTHpmU0hHMU92?=
 =?utf-8?B?eTg3ZXowZ21NMkdKd3RJTG1QRy82VmdONUdvRldwYWhXb3N5d20vQkc3eXBv?=
 =?utf-8?B?V2NuQXd1QVpYQVpsNFJNRkNDR3pwK1pXVm5QaWFiN2o4VTVTang4cC9lUDdv?=
 =?utf-8?B?QlJBMU5QTktiSUtkMUxEUnlhaGREOGUzampEeTJhbTk5enB4Vit4NWJuTy9x?=
 =?utf-8?B?WG1nZForWHpPWmtiNGFtY2lJNkIvQjA5ZWtwZUl4OXJpVUhJNnZTVVRsMGpJ?=
 =?utf-8?B?c3NZNnByNEY1UnRlY3hPMS9GQXFJZVIwY05nM2JOQk5FWnZYRWorWWZTTk45?=
 =?utf-8?B?RnNVdDg0RzFUYndOZzRFQ2tmR3FLc0lQM2ZqNldpbHl5dWROcUw5ZDhoNlZ3?=
 =?utf-8?B?NS9ENE1jWlgwaUZuRXlnd3JKdWQ1N3NJcGFGMW53Qkhnc0cyajE3TzEvMDUr?=
 =?utf-8?B?V0ZwVGpSRTR6RUpBVFFZR1hSM2t5dWZOS1pDL2R4Y3l3TUo4TnFkV2E1NDZ5?=
 =?utf-8?B?ekhXMXVER3g5TDY2MXdXb0FCcE5qeEFlejZpVEFqaW5lRmRaZnZ6K2FYVCtO?=
 =?utf-8?B?bldLUzVJK2lmNTdsY2J2c0ZSQlRqckVIRldteHArTGVvelJyek93QWVLU2dk?=
 =?utf-8?B?Kzg1WktDeXIzVTluU3FMSCs2RGVHTWpqb0VIYVFmTjk5b0srN3RnQ01kT09R?=
 =?utf-8?B?YVQvVEFFeUsvQ3lFUEh0dEJFQkNFd1ZlT2xIQnYrTml1RWY1RUhGSHpNMzJJ?=
 =?utf-8?B?S1UrY3FoMjk4dTlyMjY5ems0cUFrMmJwcHRYdEd4V3l4cHBpV04zYWZvUW1Q?=
 =?utf-8?B?Wk92MFZmYUI2cHNmbkpHdHJERUFEVjA5SHpVR3IwRVVJUVZ5OVBUSnpBcUpR?=
 =?utf-8?B?MXZvSHl1WEhoekRvNnRQS3FqS1JpS21mTm1LQUNMcVNuQ21tZXVhUFFDQ3Rq?=
 =?utf-8?B?UHVOV1dPRzJGNzlrT2E1RWY1cnZ6QWgwV3ZFMENCTjczakVYUzk5czJWaVBj?=
 =?utf-8?B?Z1BSdXpqMnlrWS9NSGpnTWhva1VVaFo2REdyZkpRc1RCZEwzOE9oNjd4Rk50?=
 =?utf-8?B?NWFJdXVtdjV6WDdnUGd2dHpVR21zZm5PeElYTlEvVUIzVjJ6VzJXeC9SRitw?=
 =?utf-8?Q?E/15DEDiHZuu3WfSDVjGGSW0G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1A0C2719A5B6C44B2D119FFC270097F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920fde40-1d31-4d3c-e265-08dca299e987
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 17:41:51.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQl9TXzUjG6HIw3o9gZniH6TiknhzJPQd0pZrpF2myt4TOoRI9VCshpswITh+9yeoz+v3yvi5+hOiufrNtTWrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240712_104200_101491_8CDEA461 
X-CRM114-Status: UNSURE (   7.90  )
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

T24gNy8xMS8yMDI0IDQ6NDAgQU0sIElzcmFlbCBSdWtzaGluIHdyb3RlOg0KPiBVc2UgZGlzayBk
aXJlY3RseSBpbnN0ZWFkIG9mIGdldHRpbmcgaXQgZnJvbSBiZGV2LT5iZF9kaXNrLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSXNyYWVsIFJ1a3NoaW48aXNyYWVsckBudmlkaWEuY29tPg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K

