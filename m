Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A2E6C5FF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 04:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FmPBmj2G5OlIaVX2fEwY2syeyWfHV1IbiS52SIKur3M=; b=y0X98oEsddh1kDN9+fJVuKpaW2
	0AO66DpiwP3KYWc5TDoUY5UqajJQOeBcg112jNA+3xvGU3zsMJ0izT5SvnFBoXmSPcWMKk9aMqJ67
	qxWUn6G/IW3pcmaOhLVe/2Pf1rtkrEdty5Pp4VM2jfd6z7z+G29QdPlsU9cru2Vun+6yBEcpi+lBo
	34qe9lPPi2Q0++EcDsuzyz61CIJ8LgkPoAthaNQYYuuQqUs4NG+HL6CYIT+FQewnQW6f9YjxZOC0T
	4bQduAcPyZaefSnFX25jmt5PUlpXfxXZE/tPqHpeam6cL4tpHT1etni71tB5Nq55iEHh485PgUanW
	SIJrck6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKyA-00000008G11-47VG;
	Tue, 03 Dec 2024 04:57:06 +0000
Received: from mail-bn8nam12on2060e.outbound.protection.outlook.com ([2a01:111:f403:2418::60e] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKy9-00000008Fzx-0e3z
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 04:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJYielwt1S6mwPM6AcV94HrGdyqhbjCxPLE7mIk90xWWNH/gLoVnooThIuzDFoTSAu2UmEfHJY87tDC5TnCJNbIzL80pEQGb6qFMSG62VBC1IreFZ4tHJoTFz/qxW5PfzBtITmHHBSVogrEG/Mf9xtrt3l+ZOTp+V4GNG0cWZQK0WpcsrJ2NCB8+0wKxvMOehHIl8hpqVAMeaeQl2SWj6hfTR5mV/By2+d1Vg3bxTg/bv6C3WNdCmHxfgifsUw8r6ubs6i3rSJuPzvuBL+ZbDJqxXZuou5UbcJwHn2qYzrwawKB38/tTy7Ag/zTqGlKO9hCcvh2giEjr95e/H1Imrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmPBmj2G5OlIaVX2fEwY2syeyWfHV1IbiS52SIKur3M=;
 b=VzE1LQ5o8iXoySYCRk3snjWHCofyxWMW+dlnlqAuJbBdS6S+OQicAk2hU8bUFFSe0k7olQ3KHxMOGv0ibOzSY76q6gnljVN5RgMQNYo84oh1Drz/P0oQS4X4c31H96ZzJXPwnmhoVjlZSFPxxynzprVToqovCNua+jlnJLLwO4wX2XKXqoU7o7GA8SDwZvciMOTzLlZ0YcPnMXIFMl1WpiCD/47xGBSZyMujwJxjdxUl6q2xCwrppiaw3GZOsTnn6tqBPBQTuH0oXXidj6FgQPxqjf11j+JeDt2mko4LOY42W8ojxakkPgOX14KDrboedk4xFKuY22I4Io3w/9qTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmPBmj2G5OlIaVX2fEwY2syeyWfHV1IbiS52SIKur3M=;
 b=Mv/b/pOzrAZm3k4CNx071uasqbdx+iYChAuVUOwenY/e8QlEFaNiWrFrm8o/ctgDfGrWvmKKal0nUWC9qbmdVJr0/ODAU3/gQWEEfDAqdJJijwRZCzVzdhgec5IGGZFbRFy1MOOsQgUX6fm89umstSQkDxrFABm7qZl+lG/h0y39TJUHG7LFQTQsgw8sYop7o6nTrqWjpTU7tYBzTSyiLEWG1CKejGG7i4a8f3qojsDj+egnjY3PvlAl/pmmjJOw/Kwq7iq8ESXHPZ/90u1JbJsGmwgrHGSlnks8jphllAibwKaoV/h4uBMso4AHY3hmRFn42pdy3uLtCcMDdagIpQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 04:57:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:57:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 4/7] nvme/rc: add argument '--ports' to
 _nvmet_target_setup()
Thread-Topic: [PATCH blktests 4/7] nvme/rc: add argument '--ports' to
 _nvmet_target_setup()
Thread-Index: AQHbQmJZOioCsDO8mUithJitX00qqLLT+syA
Date: Tue, 3 Dec 2024 04:57:00 +0000
Message-ID: <3a64e8c4-1abe-4605-95e7-18f416ca302e@nvidia.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
 <20241129132617.400429-5-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241129132617.400429-5-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: 6625f3f2-41c8-4adc-5db1-08dd1356ebda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDJOM2Q1QmNmZGE2dUpnOGdIQytyN0xjcndyVkhxTHlORXhJMWcrY0Z0Y1hz?=
 =?utf-8?B?K2xYTlgxbzkzRVRRUk5qM2Q3WVpyaWdjVzJMZVVFWGFXTktzYWR0WXh4V1BG?=
 =?utf-8?B?NUQrRUFBZmVtUzlIS1Q4NktzU28wMFVCZWtkSUNCQVRham5MNktrR0VvcEZq?=
 =?utf-8?B?Zm9CazhDRWhvNjFGd0s4WXUwdzczZ2hrdDljamNRRUt0RG1CS3N3Y3NzcGE1?=
 =?utf-8?B?VXA2R0NrMzF6WHMyYzdMdWNMZGd1UFRCWi9KUUxySmtrVFh3OGdCaFRzTUw4?=
 =?utf-8?B?SWo4cWRUTWd5QW5QOEZkSG5Ua1dpa2xtSWg3b1A3dTcycFh2aTBXVk5JNUpI?=
 =?utf-8?B?RFUwYlh3SVB5RmYyTk1KUHFRNWlhd29ONXRwbjYrSFZnMjQ4MHJ1eGdOSUFy?=
 =?utf-8?B?Z1BxSUlrY1lZNHd4OFgwOXNOVWpuRzNzNVgzUGJwckhsUGFpMnMxeDVZT2Zx?=
 =?utf-8?B?MUUzSFd3eXY5dFVCclROWUVrcTJjUUM4RThHYnJzbDNyM1YvK0p6cmxOcE95?=
 =?utf-8?B?cHBFYXlPeEZtTFg3aEhvelNPRmQ1b0h5M05ZV3VobmNqUjJKNTZhTHZ4c3A5?=
 =?utf-8?B?OEs5SW0ycEVNUVlvaytvVWVkMHRQWERuaW00alZwakgrdG15ZXZOV0d3c0Vp?=
 =?utf-8?B?RWpKU1lyQ0tWYmt4RUJUNHdOMW15N0g5YnE1VnQ0dHV2Mmh4MjM5NE9BbER0?=
 =?utf-8?B?QTVSUWdpb2NLcWhPTEw5bGdKSmRRcUpYamFhK3FpMUdOKzI1cFlIaTlub25i?=
 =?utf-8?B?Skp3YzU1bmRydzJBdWRVLzRkZC83UFhrRFJiaFgwYncrekxROHpINUhub0w5?=
 =?utf-8?B?QmRXWkFyNmtxTFNGeXNsMjFZM21oKzJ0czF2a3pQd3RrS3BrclRCaDBuNHlh?=
 =?utf-8?B?NE5XZlRkS3FjTWs2YklwNWJsL1JzRm1xdHNnQUxUS1NtaVNGMUlBdWVNNnVm?=
 =?utf-8?B?ak1USE9xSnJPOGNkMWdYR05uanRJcHI3L0VWb2Q1QmVYREtORmZHUW5OcnJp?=
 =?utf-8?B?MFNiRUgrK3FIay8yempNeENnR3YvL3g5NEFYUFpub3k5c05TZUJLRWo3RG8z?=
 =?utf-8?B?RkRGQUxJZW9LRi8xSWpGV0ZCNko2bUZIcFVwZUpwM1UwV01GWVRmS2F5QVZN?=
 =?utf-8?B?bEZoazBJS2xKcFphMWVZSXVrQ0c4UzYvd3dQeVJOSXc4cTFxVGNsaTJ1ZW9Z?=
 =?utf-8?B?T2xFS0owTkQra3ZWdXVFTU9YYmtmY0FXL3F2U2lwMUQ2VCtEYTlCTk5qVmxy?=
 =?utf-8?B?emIxUkc4Y2ZLcTRrRWU4VDhpenUyWE5YeHZtUVdqTUNLY3QwWC9wYkdQRjNU?=
 =?utf-8?B?cmpoeDZ2Qys2WW9PcGVSU1V2QS9ic3Nvem1PdU5FdlN3NkZwZHhsRlJiQUdt?=
 =?utf-8?B?cnRKUFQ2YlZuQVU2TU15aVdsMUY2R082V0g2di94eGh6WUsrYnAyemFxSWZI?=
 =?utf-8?B?YjVRYWQzOVFxYS9ydVFIVS95VDFjUUxnWFNJTVdJZjJaT3lIK1NIU0Y3clFK?=
 =?utf-8?B?c3ZHVW5LS2RCSXlqUjV1dXJ1QWpUVEQ2Ykt3eFYzeXZQZWYxelN3bC84c3VC?=
 =?utf-8?B?RjNuZFBZQkNtYU1CMzg5MlREWlpCU09NS1N1Z3RaWitmdFJ1d2dObVZHZ1Ro?=
 =?utf-8?B?VCtZNEpIUjdKQWpRUmM2TWkwYXp3WCsyNEZTaURKUWFldTdYa0o2NHRYSE51?=
 =?utf-8?B?anV3dXh5MnMrTXB4bVhNdjN4dzAvMzZ0RnRaaGZ6aTRRSysxSnp3ekFZZ1Jq?=
 =?utf-8?B?MWsrWUhEOFFUQ3JFeDZkSEp0RUdmcE9paTlOb1oxb3hTbzlzQXRxOS9lVjBT?=
 =?utf-8?B?Z1NYQTZrb0E1THhoYmpQZDhBVFJMeTk0YUJxWmtrOGp6cDlFY1RFTkcrMFRT?=
 =?utf-8?B?NEZxQk5GdEFNUUJ2cjNxZ09PWC9FV08yek9UbGNnOUVBakE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUpNMGhXamY5U1pSZlZpdFAzM2FZWlJYYkVjWlNHS3NDV0p5RTloL2NGOGpq?=
 =?utf-8?B?bW1Qb1ZBTEJveGM3b2FlcEp6R2ZUdXZOT0o3VXFtTjYwMDB6RVh5U2ZxVmZO?=
 =?utf-8?B?aUNVZHg5bmNVcmZUUWVCLzk3cEpNckdQcWI4QmVzenNzaGpFanh4ZDFJMHFK?=
 =?utf-8?B?cjdQak9pclFYMTcrL2FkdVcyWDZTcElhUFZVNHJtN1dyWHcwMkVPejJTTzRh?=
 =?utf-8?B?VU5DdzJCM1NoTEFIOWMwZTAxKzIxbzIraFU3TW03TkdIdFR2TDFMNHRCK1JM?=
 =?utf-8?B?U0pFNW1VaGhCQ3pkbnhYS1dQWDZUWEh6eHF5bStMVEFXMWlFOURNMDJNc21P?=
 =?utf-8?B?OExBdGkzejM1VzFkdy9jQ1IxcURBd3ZrQzk5Z2I2RGZ5b2prTWJWM1dMRDlv?=
 =?utf-8?B?TmpHYXBKenFxVVkvQnR0ekRaWnJ0RUFxOW9KMVVoOWRtK3AwUjJKM3NSVkFu?=
 =?utf-8?B?cXpPZ2pVQXJpTEJPTVpkdFVoTUVoV3hkWC8yTUViUjFPQlVwNHlaQmVUR0pU?=
 =?utf-8?B?ajB5eUV4TFU5RmZSYVpJZXBqMkQ4R05UUW9kMEJtTGUxa1Z2U0VRcjBkb1lY?=
 =?utf-8?B?bG5nRzdCZGloa2VMYmtIcDVnM0VFRlZFT1phVWVuVkVqOE5jM1ExSlhUTDJS?=
 =?utf-8?B?NU00blJCT2ZsN01KSVNpdVVNWUdONDRaaWZkb09zYlQ0QnlUUCt3UXFmL1hP?=
 =?utf-8?B?QzRWK2p2V0ZCWDFaazR1N3A4OWYra29GL1ZoRWtlaWloTzdmL0lnMHlFZU42?=
 =?utf-8?B?NjZ1bkw3TDhHSE1BMzREdE9vcDRaZzZLRHVrd1FQTmFVakVZYlZjMEwvVEtF?=
 =?utf-8?B?bGlhS2tzb3owUDdaVllmSCt4NWt4YzZoSGtUMmVKcmg3ejRWU3MzSjhES1Bx?=
 =?utf-8?B?bkRldm01OXdlL2N4UUMrVTBud3JHR3JCbXppZFQxWkxmT21NcHJrWEhWTGNp?=
 =?utf-8?B?M0dkYWFhMzNvb21POGJIWDdYaWR6eHBENEJjeGNMTC83RG50QkE2OE5MQXJ6?=
 =?utf-8?B?M1VHaXlkTXppQjlTbHdsaCtNSUM4VkNVeWllYVUwbnZRWWc4cmU4eWs1d2dq?=
 =?utf-8?B?SHczQjZXd0lKUFlKUnI0S29oK1FCRzFoUzVvWkZiRndVaHhaN0J2M05vKzUx?=
 =?utf-8?B?eXdBdDU1TzVtS2M1NDkzVTBCcjI2UnJZNDBKNkVXM0ExS2pNMDV1Q3h1VVNX?=
 =?utf-8?B?Z3Z6N1FSd3VJdDJrR1NCVE5paXVkU3NTWTJrNEd0Z3dyK21nWmZKU0IwWE9P?=
 =?utf-8?B?bHhUZElxMjNFVFNoSC9Ob1FGOFlYVW9NTFpESlJFa2RGckZ6cXptZlBsS1RS?=
 =?utf-8?B?elllWFhQSGxoSmxxWHFIVVhPdmRWVTBOYWZ5RHZyWVZmSkpYTi9xVE42Zkx2?=
 =?utf-8?B?RmlEaVN6Q3k2azBYcHpmd2FuYnBwWnVNS0ZxcGtNMXVzck9jYk5Ua1k5S0Jj?=
 =?utf-8?B?aWI5Wk1tRzIzZHZJMm9SUkw3dnFzQ3FwRmNHSCtRWGFQMDROeGQyYnFSUEdD?=
 =?utf-8?B?UTNEdGpsMFZRZ2duV0FSY0EwTjBibmVXcDNVcFNKbjE4b3VSRGlFRndIK1FV?=
 =?utf-8?B?eTNjclNROW9lVkRrQ3Bkbm9yVForSmFVZFJiRmtabVpUV3J2WlAvOUN4QlZj?=
 =?utf-8?B?TWV2TnpEZU1LbXl0SW9OSnJIODl3bkNQakFPdXlSOW5odmh6Q3Q0UHpoQjQ2?=
 =?utf-8?B?VmdjeklkazlJT3hCcHRXTXdRdDhHVEwwQnNFZjF5MkhCcWluejMxQWhVVmVo?=
 =?utf-8?B?OHlNcEdJZXg2RDFHMkRaU1dLY3ZnMEp3MHNrQWNxT0U1aXBiSFg1S0NKZVA1?=
 =?utf-8?B?UzNoUzNQcVdhT1dTZW42MldnNHQwQzRZcCtzU0FnSHk2ckpmVGx4eklGUDFs?=
 =?utf-8?B?UExTQk95U1VZdUxnbDJMYnBaMnJGcDFTeVk4dk1wL0FNTUM0UTV3OS9sVFk5?=
 =?utf-8?B?a01TTEF3R3ZRZzRvanpiZlo2WThQR0lWenFqTVRIUGYzNnlvOHhKOFc5VXda?=
 =?utf-8?B?eXF6ZmxhTHdkR081am1UbWRyNndqQzZjTGtFd2k0SmRUUWgzdURRb3EvTWpV?=
 =?utf-8?B?YW45WENEZEJaajBSUGExWmZNQUlBMWpWNmQ1c0g2U1FSSHlINFR2K1pSVVFT?=
 =?utf-8?B?ZTluL2h1L0dhN0xOTmphNzVjaEliME1BWFhOOUdFZzQ0R0U2MDB2Z21ZMjZ0?=
 =?utf-8?Q?BYL1aZ7acRUBMLCTthTqpr58UMJ9kPtN5P6TNL0uIAaf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2EDA82CA9AE6145AB1180027AE3EC95@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6625f3f2-41c8-4adc-5db1-08dd1356ebda
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 04:57:00.1000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3qYkuQbWKWMKUHfjLtTfl5tBbvnv5Bq2xNRWwZ9cWBouR86huDWG4zhB0pd6gXrhpFmGnWDsUo1Ie54NKtwNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_205705_190875_3582DB01 
X-CRM114-Status: UNSURE (   8.02  )
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

T24gMTEvMjkvMjQgMDU6MjYsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPg0KPiBBZGQgYW4gYXJndW1lbnQgJy0tcG9y
dHMnIHRvIF9udm1ldF90YXJnZXRfc2V0dXAoKSB0byBzcGVjaWZ5IHRoZQ0KPiBudW1iZXIgb2Yg
cG9ydHMgdG8gY3JlYXRlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2U8aGFy
ZUBzdXNlLmRlPg0KPiBbU2hpbidpY2hpcm86IHJlYmFzZWQgb24gdGhlIGNvbW1pdCBlM2ZlMDZl
IGFuZCByZXNvbHZlZCBjb25mbGljdHNdDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEth
d2FzYWtpPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==

