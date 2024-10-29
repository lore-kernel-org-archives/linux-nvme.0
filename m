Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ABCD5B874
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 05:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vbz3iu71tTyyId3kMz5ITmJumuHRS4sIVYG5jQemNsk=; b=FBKMQqOUr5IzcnF30OSI9Y2jrs
	PGBht7ECNvQnj8ww7FkxEnsdmThG3C6adpYNi8BYX+eLpIuJOFTQviwGyyb2fL3008xxHoz3A7T3l
	B29GeS06Hc3xumnQEN4U/jiDtdXn72Bb7IZ7SArNGcHw242fTRwwPUF3hEQuI/BN4Y/4oMSQ6OmKY
	M6eQcHFIjshEuohBBWhqh9HVA+Y+Ihww/hAPhLxPt2qHwn3ySGiIg7wq2DHT6b6KQ7uGKxMIo9e81
	mNBMte3FWc04mIzNfWke8FxPumyHLzTM9yRbja9Zsyq1AwHsrZGNla8rbG/QeKe5JoOxnb+4xc0rp
	wldpv7Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5eNx-0000000DDny-2HxA;
	Tue, 29 Oct 2024 05:03:17 +0000
Received: from mail-mw2nam10on20628.outbound.protection.outlook.com ([2a01:111:f403:2412::628] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5eNt-0000000DDnM-2gPt
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 05:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzidhEAcG5jZQbpo5xySmZhXua5gqtk1g56oaemOmXdiTsNLpOufXXlQ6k65PDrTKV711FDWPmSG0Vuont8zAVL8kkeWiUcai7roG8bxONCELwgHKeP07nCWNBZIlHdlmaJoKJ7UQaFCQB431JCT759Bw+4JJdk8oa4lsmgFB4J90qV1N13Vg/p4iqwMfjktsUIdTjLoFgeMWrNEdN2KqnSLkaAreYiQ2Wgsoh5lkX0UA7hrQXpHb6pfA7GEvx/i6G9H20kLeOO8daDlOUhqmrRs7mr4nGcLT57OOq5FhR7I70PakCEoHxjbbeVUogZG5uX18hDxy36RrwHA24QdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbz3iu71tTyyId3kMz5ITmJumuHRS4sIVYG5jQemNsk=;
 b=TPoStUZm7gi5MOkY3K9gf8Nt356Lsl7YC2U4ERaBO8pBbmJJLSct3aNTLZ2IPPcMwPNkJTVWTYDjH3UkRS/1/qci2lFibnavQWncwpB/pYCw3EXSWxU3ZmE4Fgz+JxKtGjyjmoS/aWjdenXOFUfZDBFa7g+uawdVZCSj56PZAs3kbfoaLvLvpwBlUlFJxPPrx8DRK0FAblHjWh5pqpW2vHqpbqgyBbFR6HRcowEqUzNpv//7Jn7Sfd/CRJgCjjrFRuhckAl7c8qa4mE5XVFJubLTHWmES7AttOZH40LQRaR5KBLe0j0+y/ZLl0bW6rFdlP1nYvoG8lDWU6VLQf3IBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbz3iu71tTyyId3kMz5ITmJumuHRS4sIVYG5jQemNsk=;
 b=LhGrX8QAP9TfIhmFyXbl5eoBS7OLUpzaViC8VIqtqjhzLGRzALsaJB9O2EQfTKTk34isL9OG82sQ2vmlhCNpKaTgi0pLHFG2lVN9R+d97Aaym+zGcTa1C7juPqftlxqnEGDHcXqIFQJw9Ep8LsvdpZ7VEE5xoDJu6kE2diTIreyC6JdQ6NIt2uUXe9yZmhBSIq6uWQfUl4Ti0acphJLacf4589REFTvmTAYMZDworyv7lPN3UgifVMNYpF7Dr609Iehao2BWveoaj2f+UcUuhGN9Xb/umLDBQE0MgRzKz67xNgk6HuTAQ8HJZSf+Qtnom2B1uYBDGkxo5Ve1Dz631w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 05:03:07 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 05:03:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "dwagner@suse.de" <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Thread-Topic: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Thread-Index: AQHbKbFmcQBQk+oLTUeB+jDaD5L3qbKdLEsA
Date: Tue, 29 Oct 2024 05:03:06 +0000
Message-ID: <edbd6406-bdee-4d88-8c47-b2759d16299b@nvidia.com>
References: <20241029031931.118305-1-kanie@linux.alibaba.com>
In-Reply-To: <20241029031931.118305-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6449:EE_
x-ms-office365-filtering-correlation-id: 1ebad76a-087a-499f-f5b2-08dcf7d6f9cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OG5Oa3k4VENTSzZUcVYrcGNvNitvYnZ5Vk9XeXRCTUtmNnVKZkxZNThmR20r?=
 =?utf-8?B?Z0pHT3Nzb1RyWUM3VkZ2WmFzYVc2bWVrVXoxbFdxYng2U01YNi90MVUrbUd3?=
 =?utf-8?B?WUJrSXArVTBORnMwOUI3bTBBNkhGZzVCVUFZdnZJTDQvZ0V2K1ZwRkh4b0gw?=
 =?utf-8?B?eVV3a1cxWjJMTFNUaWVWZ2xQSEszVzB6c0k1UUcwTHBxN0tmWldvTGJCYXRC?=
 =?utf-8?B?RTMraHRlZWtaUVRKam1DMU5JZ0d0YTQrWkp0RjMxcDNseDNGY3B6bWJxbzBB?=
 =?utf-8?B?VDQ2SmtKQ0FmRldhQmRlcWgwSU9ZK29BdVZtMkp1MG0rWEFFMUQ2S2QrRXZY?=
 =?utf-8?B?amcyUHJiV3RkaUN4UkpwVlRPZTdha3pSQkp4dUlnd2xqS1NJR0VYTUJndkJv?=
 =?utf-8?B?cVNtTktNRWJoWHVoc28rVElIUXJZV1FURnEvVXVQa2g5YU90M0lZeDRtbTBi?=
 =?utf-8?B?RXNlRzZpYmpRSXBpcmZLcVBibzdmL0V3VGZ1Qmx6S2ZKZFFIbTlvV1pST2lu?=
 =?utf-8?B?Y0g1R2hhT2ZNa1ZBb0JIVmxPdzdIYk84dWIwZXJrVU0rR0lUWUswUmQrYjlL?=
 =?utf-8?B?bmRFQWhFMDJwSlNPbHlrWXE2anZZWVYxTEJBaW1ncEpGMWhOTTNCTUJpR0V0?=
 =?utf-8?B?bU9xVkx1Y2d2UnEwOThOS0ZjSkcydXdLbFVnSVJSRU5RSVRrTjZUMFFVNWxu?=
 =?utf-8?B?aEwxVGhnRXBBUzJMTnVkM2dTdmtlUTF0bk9lVzl0UDAweHlGTElpMnVaeUlu?=
 =?utf-8?B?dlBDdUxqS2RpUzBidmFGb0dUTjZYOWM2eHN0MGpTOVRveG42dXZDY1NaZUww?=
 =?utf-8?B?S2RZTFZFNTMxS3Fiblh6Y2VkNDdqQXFVS2h3WWhmZlk3ZUY5QmJjcTNObzVv?=
 =?utf-8?B?TzRDL1B4bnNBR1IzcjlacXhsY1Q1MjBxOGk3aUdJZE40bWVDMEkrUUlWUzZh?=
 =?utf-8?B?UUZHME9abnRsSW90TTczNmZXWmh1UFZ2UTkrZDRiTEc0bWNBNEdVOHpaYWFi?=
 =?utf-8?B?MFJXSm9Xek9aT1dFZ0NUQ2Z0UTc3OU1ndXVoUTFHWlhDYXFqUnBnemF4dUFI?=
 =?utf-8?B?a2NBcXN0SEwvdFM3a3VDVExISmhzaDFFN0xtZnF2aE9qckIyaDhJenpQVnl5?=
 =?utf-8?B?dVVkdmU4bld2NjhZSVUyQ2dzdVpzMk5YU2swUHNsaUoyRm45cE5IZDFuSDRa?=
 =?utf-8?B?UUpRZzQwYXZPbHNNK0czanlOQ3hDTUREaGdZQkdvT2c1a2VBUlJDWHk4WTZp?=
 =?utf-8?B?OWlRbURHLzROc3QybUVUZkFWdlJtT0doMHRsYWVxNm5CSStRSnp6WEZkNVpk?=
 =?utf-8?B?UVpmbEdGYmJhUHNMb1FSTzNjQnhPdVd5NktpMUZvWDgzbUF0enVpTzh0VFBq?=
 =?utf-8?B?b0JWaHdLdnF1NEtsUmNyVXA0VTh5S0pUTitraVlKeVg3OHNtdTEyWjFUYXZH?=
 =?utf-8?B?M2VtV1laS01WdkdjS0pYeStBdjI3eThhdjd3M2hUc0lYYlVNUjU4bklCc1Zl?=
 =?utf-8?B?akYyZmhxZWNnR2ttVGoweG1BR2RVbTloTHhkMWZxZlZNMlZscTlmbTZqSEQw?=
 =?utf-8?B?Q2dlMFpIcjc3ckFuaXdaWFFBNTQ5d3JBT3NaTEdNeEhrOFN5T3VyNWYrUVYw?=
 =?utf-8?B?U0p4TGlJVHBOSEhlOEZwUEJzYXRKNGxYUEtENEROelFJZDNCaVhPdmZPVWlZ?=
 =?utf-8?B?RUk2cVYwNUY3MVNWRDYxWlo1Tlk5d0RRem9BdFdXSW9RbTMwR251OExWTXhR?=
 =?utf-8?B?THVmUXI2RVBNTVgxV1pyMzNNQjY4SGFTaFRyODRlVWdVOEx3U01LbkwwYTZD?=
 =?utf-8?Q?j1RIQD5tOM1pJvL+9Jc9GIIEDqCFqOz8Tn9iM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE5zUEJ0ZkQ1Z2hsbC9JOUc5WHlpb0duckdHZmZUOFFmSlNlODdSYmJZb2VB?=
 =?utf-8?B?OERjU1lDa29Kb1FBZkIyZjNNQkxXUFptei9HSWJFeDRidER4RTcySDc4N1Mr?=
 =?utf-8?B?elBjLysyeHduMEFmYWNkdzQ3TFAzM1g2Zlh0c0ZSZk9XWHBzcmY3NktIRkpj?=
 =?utf-8?B?YlV3MHlLNXVmMzRSUHYyM3BzMXhlSTFJclJNY0NPbFhkOFZNa2c1anNBdXM4?=
 =?utf-8?B?d2V2SlZiTjE2dFNQSUVFWHJEMXJvZnplaytaMUEwQlNGUjJDcDlCc0t6ZFBl?=
 =?utf-8?B?R1Jkd2RtMEV3Y3pKekl6VW41K2RlNHJNWityME5HUGRuQmdCTGZJK3p1S3Ar?=
 =?utf-8?B?aW1INGtlSHczQ3Nra09OL1ZlSmxJb0RiM1IzQUhMMXA5SGlycmF2c0c5ZVlU?=
 =?utf-8?B?UytGdEJFSll1djRBREhoZkFSc00wWEM0V0hMQy9zbVBmQXNpK2ZVUnYvQ2JP?=
 =?utf-8?B?NGhFY0FXb3gyNmlRS2psUnloK0R6WHJVM3NqazJEbmNIbWVxMjgrajZZb3p5?=
 =?utf-8?B?QVQxZWFNM1dWV0J0aFlnOXpIZkw1T09ZcjJ3OVZyNDA1UFhKY3U3K3BVakxX?=
 =?utf-8?B?VVo2YkhDTFgxajEwWHhzME5GVG9QUElJU2E5ZVQxMWFSb0tUVlZxQW5uWjZS?=
 =?utf-8?B?TDN1R3JCNVFBV0pVbitSOFlyOHdJd3ZLdnI5VkdWa2FLa09tTUVKdm1SV0d1?=
 =?utf-8?B?MUg5VXVrYVI3d3pISlUxcno5ZlRhY3d5L2I0b0kxUGo1YVI3U2NGVHVlalJS?=
 =?utf-8?B?OW1ML20wc21GVmxzTFJ5UGVCV2U5SVV2WGtpVWlNNUxHSUR6QitYTXBiU00w?=
 =?utf-8?B?YW5kaHkxWVhWWCtqeXRQc3NzcVVNMExIZGxLa3JtRE9nVk9SMXJvZjgwc1hi?=
 =?utf-8?B?ektRVitVQ1FBU2R3VTVYd3Q0MlVvdGhaWk52Vmg3LzAvV3lBZmp3RFl4TUxk?=
 =?utf-8?B?MUNBejFhQTRBN1NJNmpzV1ZYS2h0NUhuNkdQVlM1MzhVa2dtb1Z5TUYwOHdL?=
 =?utf-8?B?RnVLT1dpaVZFSjVndzFKbGRNcEVmZ2Q3dXpBN1RUU0Z5Tnpnd3FGOUpXWE5v?=
 =?utf-8?B?YzJaclhMeWJGbzNaMGdyZVNlTnVWZ1J0QkdVNktuUlA5a0JZdzJhTzJyOVQ2?=
 =?utf-8?B?Zk5URmFwaWRKTTgzZlA4TGM3RGZXMUQzT0FpNkFUYWtBTDM2QXVTd2Z4a3or?=
 =?utf-8?B?VDRtZDJoRHp5dlBwa21OZHJBYlpabmlYblRvc2x5WFFqUkI0SWc1enhXZ00y?=
 =?utf-8?B?by96eWhvSG1KdkovZ3V5cWQva0hKQ2hLU1krRnFDTjU1eWRjZWNsSDRHdGdW?=
 =?utf-8?B?aElra013YkFmQU9KdnFBNWNIRnVydWVjcTQzTzNLd2tFdWEzd0Voc25tRFlJ?=
 =?utf-8?B?QSs5cjc4RXVyRWRtcDVISURhTVFiN2hYQWR4OTlQaFV1TFJPRzRWQkptTHNW?=
 =?utf-8?B?VHB5d3phTldSU1RrVUg2MEw3eWdNd2xvSWZ0T3ZjaGVKU1hPNHlBSmdVMmZ5?=
 =?utf-8?B?STFBQXExY2w0UVprMUtoZ1B4NDRKQnFIM0ZuRXVCVmFhOG82anphaWVJczQ0?=
 =?utf-8?B?U0g5NlUxMXI5NmY3SlNmUU1YUE0vWWVSa1FDZCsyOGQyS2VhQlFWOGFoNEFp?=
 =?utf-8?B?c2thdlVvQkt6RTNTU2w1cXBmb2JSUE54ZXQ4V0paQTB4ZnRWQ2U3cEx4aWJV?=
 =?utf-8?B?VHFuSmxOKzR4akVsQXJRMTIyUWlFS2UwOVdtLzBwSWtwdUxML3Q4ZlVPeGZH?=
 =?utf-8?B?NisyMjFlZGtaRUJyMjFYdlM4cTVGRlN3bDRhU0hnQXBGbG50QjZ0bUlJdGp3?=
 =?utf-8?B?Nng4c2RHVS9sakUxMVJhTjdKYVRNSDlLT1ByRUlQTXhRRDk3VnE4ZWdHNVVV?=
 =?utf-8?B?WWI5ZVZaVXljUVVRZVZ2Nk1DcDNueGhTQmxmNHJsVy9LM1lsZDhLLzFOblZV?=
 =?utf-8?B?dldZbStTaHFYbDFvakR6MHJxeGdaaVVHanFtUjdmMFA1R2F0bmhSdWF6bnU1?=
 =?utf-8?B?S0hSeDBsdFhjTjBhRDA4NkVwZUhNRUpMeUZEZkk1K1NpNGtRaVV3QXU3YlRU?=
 =?utf-8?B?SHdCcnVFSllKTUV5SGZjcG04N2xYbmVmSWgxTlBialBaZW9IdmRnQ3ZJWGtL?=
 =?utf-8?Q?reOgIQzXgtEXaLHc7oku/n4RC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <942FF492039C5B44B12A4BB68097C24A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebad76a-087a-499f-f5b2-08dcf7d6f9cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 05:03:06.5428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfQpvoPx4nENOdVbTfK3OcvTkrY1sTXGFKbjVIO+AaId/HJf1iERxRIzTUIBk042rcHTpr3J9vDve4SaSKMEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_220313_704592_3EF8084B 
X-CRM114-Status: UNSURE (   7.26  )
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

T24gMTAvMjgvMjQgMjA6MTksIEd1aXhpbiBMaXUgd3JvdGU6DQo+IFVzZSBkZWZfbnNpZCBpbnN0
ZWFkIG9mIGhhcmQgY29kZSwgdGhlIGRlZmF1bHQgb2YgZGVmX25zaWQgaXMgMS4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogR3VpeGluIExpdTxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQo=

