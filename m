Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5822CCCD1A2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xKhcyLD8KoV3Q/e8IIqX390ONj2lNHedqNHPSHzRiaM=; b=GVEpKWHSMYm4tSIJyNfeIWRAcC
	cDVg88kZ6hcx+YZ9W+MvmErZrqq7fM1B+m1gPMKBvmR0gKEbs4RXgeZiIJl7k92QeguNPrX4vSaz9
	3dZfIv3+1W5GT0si3Y5roesR6PgZ802+g2phS6YwnOGwVocwgqM3omMjAElYoPiN9OEuq6lyBiKTq
	PD1Npf9QJI+1BkSfh0c8sCLyv4+2zf1M5yD1njNpwaJHIDIy2i3it5a5TgQ1BPLDJKPpbvxyQ1Bm7
	1V25o9WcXgnopFSD94xdOaymWLOFcdSJ7F2dyl0lbGZxch9VnSvYaBMMXtrZmoHXAbuIXIKtYQCSp
	TM/0Z7YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAzRn-0000000FH9I-2Dbk;
	Mon, 20 Oct 2025 23:37:51 +0000
Received: from mail-westcentralusazon11010050.outbound.protection.outlook.com ([40.93.198.50] helo=CY7PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAzRj-0000000FH80-3wgJ
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 23:37:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGRXsx0hes2Yss46VJxF1z5s5POtTD7m0sc5h7uyShfUeaez4bpyau2uxBc147EVMSRgflzhm77UREu12l3yydBoKYtDmijlA3edNTo63rbtTLPTZw/VWf+jzKMKJiR91DDTDtUh6vp+xE6Z4r980OeXkCSSX/CUc6uslgw45YSYjTzGOziRi9DZgVJQX9OCBMAt/mp6aqNgDWh5dCh1YIBezwd0pIv0RloINfY95fBlx4uX9SsBA3uVuKEuinCoY4PmxwaHcPUtMjse7CcaGrUbGIWKjRdrl1v/KtOI3wUq+8YEVHY9zEpSTctbq6JzUknxnT5qg2OJWhHCmeS03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKhcyLD8KoV3Q/e8IIqX390ONj2lNHedqNHPSHzRiaM=;
 b=X5Uiu2BuG21Hej+loVsiCskS0fAZmafj2Zy1lVWj7QvvazsVwjqnfYvyZQPlgnlY09U4m/UPUJIQI2TH3gQ1iXZ/eIg08C7dD1AxprjIHOijSq7tkIlDa6eK9gLbWEAOdIXRPSqmeXtqoL0/wKGXHsxAzsjSYS0p5e5ITdebjZ330j/3fuiNEJ48O9FZgcDqx9nN3M4MvfCHPrwO9Plb7G1jKKrshT2VIfjl70Oqs3MBnsWcoIpmf63HjPXI+OUysnLcibpldaVp4e/45hZm+faSEJiaQc6cTVWMdknweGQYLWlwwy5V6+bYo6LZmrRSE9KgjWF5Lv7dumyGVqMVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKhcyLD8KoV3Q/e8IIqX390ONj2lNHedqNHPSHzRiaM=;
 b=iaC7RL9n4XiPMLm8lJT9LWIe1B6bTjUaCuSX0IgdBZwKL92Gx/gqovMUSeEqOYgLRn46qGPzGEGOJ7Qrnt1Rkh+Om6nXT4OdeiI1/v/qEkFSGstaBOIJ3/vJf9Y0e9VCGQqBz8juG8ai9YbhYcmyRf+lRdWuxQFCSH0nyuG+woYRrhlDCctiBqqFFcjr3SRZK8B6HonsTmuDXqlxBMIuA9eZpqp5FakRn2c5SPEsYQToowHQoPmQ5xtPQ5FVSfjFYd6cp7gx/mMVDC1hMEabLBx02v4m8btAQku9XZZLQh2BUH/lIDAFWo1M10Eybw7uVr+ntHRtnRVrhvJbQY0XjA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 23:37:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 23:37:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] block-dma: properly take MMIO path
Thread-Topic: [PATCH v2 2/2] block-dma: properly take MMIO path
Thread-Index: AQHcQeMZErvLcNuVAE6NKNRW/t9a87TLsUMA
Date: Mon, 20 Oct 2025 23:37:38 +0000
Message-ID: <3df0dd64-b2bc-4d3c-96b1-8ecc60d9de56@nvidia.com>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
 <20251020-block-with-mmio-v2-2-147e9f93d8d4@nvidia.com>
In-Reply-To: <20251020-block-with-mmio-v2-2-147e9f93d8d4@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL1PR12MB5827:EE_
x-ms-office365-filtering-correlation-id: 150b3d65-5d8f-473e-934a-08de1031a7ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TmE0RnVRblFnS3lIRjBkTFV5blRQWXlibjRPWlhvT0o5c2hoNDI2WlVEWmVq?=
 =?utf-8?B?d1AvVDhHUHlIMmJ4L3ZMRjh0YStiNlh4MW9VZ3YxVnpRaTBUVThjTWpFK3VH?=
 =?utf-8?B?b0haSmsvMUtIZyt1bmFmc1h6RUVOWHVXZVpKWXgxZWJsOVBUb2o2cm5kQ09r?=
 =?utf-8?B?c1FTZndSQnk5TW03dHRIZkZ6VkQ0OThPb01sUGQ5MngyMHhRb3RUZ3U3eFhW?=
 =?utf-8?B?M2ZoWit2eTUvdHNBNjMvbDVQQWdkRlhsVTRHdjUyTTlKd0w2a1UyTHp5UFZD?=
 =?utf-8?B?aTF4NXBJUkVZRVJkak43ZXhKVkk0RGlCOFF1ajlEd0RvZU01SFkvVEY5TjdQ?=
 =?utf-8?B?VFRrMFdUcDNGNlNtVXJIamRZRkNSQ1FvdmVEdjduRU1tajJVVnJjTllGWE9G?=
 =?utf-8?B?Y1N0MEdid2JtVnR6R05vc3dYVHMyUHJaRTZ6eXhDMjhDYUtHdjE2MXVMaXl2?=
 =?utf-8?B?bCtaT29nb0g0U2RGemwvdEJWTVk0ZnpoSzNVYXdWVUI0SXlubXV0c3pwN0JJ?=
 =?utf-8?B?QVlPOFZxUlNlL2szbldhRFMvSTMrWEcxWDVCVmtaUTU3bG1SM1BvekJvVEFv?=
 =?utf-8?B?bUZqekdYWmQvVXV6ai9Wb3lTRWtGNmhUMUc5T0JhUVByZ21odkkrb2FlUVFv?=
 =?utf-8?B?eEdrQ3I4SHpqQms0aGwvZVFrTE5kZUQ4anJZWXhXQnpTamp6OHBwYmpnd1dN?=
 =?utf-8?B?bm1yY0hRdzV6b24wVmJUUG92dld3eXNSMGpiQ0xXdzJ0V2hUT2lhc2s4bUx2?=
 =?utf-8?B?MVFYOHdoZWtvK0FjM01qVnJ0T3liZ0xSRk5TeHlRQU9ZbHZicFd2MEdmcE0y?=
 =?utf-8?B?cHkyb05CbHlya0EyeTJkVjRDOHZzK1NLOXp3VXJvSFhvK2hSd05OaXIzY2Fk?=
 =?utf-8?B?cS80YTRIbGVrUllQQUtCVlJMdTYrdWRrRjZlamo1M2R2UWpyNFpJY3VhU0RP?=
 =?utf-8?B?Zm5QSzJ4OVpNa2ZiTEpoeml2aFlxZFU2dlZaQUlGSUZYNjhTaTZZbi9XWDVO?=
 =?utf-8?B?ZGozWnNpYUp2MElaSnZsR1VrUkhjVE9vUy9xNnVFMU5mYytqRGUvZlA4ekJ4?=
 =?utf-8?B?aHZnRzE2VG03MU11WUs2S2owNFFEN3ZmcW9uMGZTWHZieEN2SjRHcnRkbkZp?=
 =?utf-8?B?b2dxNTF3eFJFTGZzVXBFbnFPL3dEbHlqVFMyNlNnRXZEM3hkU2pOWE5LWjlW?=
 =?utf-8?B?RGdnZUE2c0NvYmticTRuRUxDUFVWOHhoRUZXQVQrWWxjWjBjaXk5Y1NESVlj?=
 =?utf-8?B?K0hmckRYd2JaM1NNYTRxY2tYcS9DSmtkR1ErY2RtUTB0WVNIZ2h2SHkvMHl2?=
 =?utf-8?B?RVh5UGRFVWtuMGhxT3M4RVoyMERkZURZcDA0Tk1WMS9rOWxKOUFFaWZjR0VO?=
 =?utf-8?B?My9iZGN3bU1YbDk4OVNxbHlieUxTeUNTL1M0MFI1VVk3TEk5dXpibVk4WWdJ?=
 =?utf-8?B?WjVlZUdJSTVIZWZWenpOM2ZTY3FNSlVTYkpRNGxERWVqT21Gbzd0WUxRZzRo?=
 =?utf-8?B?RWlGdHZwcVJrWEZSaTlGc0QxVWliRWNsL3MyZkhOVU5oQlhjNkxrcVhZV2RQ?=
 =?utf-8?B?QWNsdURJL3RhcG45VTF1bGxoVmRxY1g0blZYUkJ5OVZ4NlZrRjZHYkYxbkNv?=
 =?utf-8?B?aGNiMGJaQzFYdGFWZFo2a3R1NkVvM01CWXBYd25YeFRpNFZZTkdwYWEyYUhq?=
 =?utf-8?B?QVBhRk5kbzFKbFV3YlplTXhEdDFrNzBLZXR1SVlLM0U4Y2x1SHZTa2FSR1Rl?=
 =?utf-8?B?aHZCNUxaVUd4b0dDMUZ1USs1bTZjakFuMS9YNmZEbVhEaDc2QzF3RUhLQ0dF?=
 =?utf-8?B?U2xjdzJoZkpTV1hrYjR1eWxoRVZqNzNpL2ttSThuWXdYdHhMa1ByczFpM0J5?=
 =?utf-8?B?V1NhK21Pb0MwV3hGMlllWlk4WkcwUWROYk15dlkzaW9ReDNHSXd4Uno3NDRo?=
 =?utf-8?B?MXk5cVhHVC84cU56MGE2eU5zQi9FRTNkYTU1N0E0WHlvUlhjOHdaM1lsQ2kz?=
 =?utf-8?B?WDNHMFNXREdLRmJ3REluMThrYTZMTzdwd1VhYW5Hb1BHZytPT0l1WWJHNGEw?=
 =?utf-8?Q?B519XX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czhJcGMzQXBNejJ6ZGhGZlFlT3d3VXpsb2tqQ2VmU2l0M3FYNXJzZjFJcXJo?=
 =?utf-8?B?bWVFVmlBT2VBM0JRWVZwK0krbzgzL3dKSk4rdlVTZ0RKTnZ0czhBNmRNTVpG?=
 =?utf-8?B?b28ydXZlT0NMM04vODh5eHFDZ29QM1h3TFhOLzRSUVMrRVhGOXVma3A3Wk1B?=
 =?utf-8?B?T1ZNbks5UVAraS9FM3kxTEg1UnNYY0k4V2g2OTVHZFdoMUk4bVdKbnBZLzBT?=
 =?utf-8?B?bUJDbkdBTnRrUnBOcG1lZ25MUFZTZlZjYzkySVhleGJJb3ZJNGx5WGtYSzRy?=
 =?utf-8?B?SmQwQkJBSEdmbUtPNjVTNmhYdmNkYUZXalltdkt5Tnhsa1RWd2oyK1pnTWNV?=
 =?utf-8?B?WjVFWWZIekpONTdTTjIwb0lESW1Fb0ZPRmowRVovVVpzQnpYdjQ3YmlZM282?=
 =?utf-8?B?NFlDaVRPTW1uK1VlUndyKzlJK2hPb3pudGthY2x2Z3UxaTBqVk1wNUYxWmFl?=
 =?utf-8?B?eEJKQ3FhU0UycDBtOXk4N3BnMXRXWlJlektRL3ZrNFZ4cG9TNDZRNHBCR1FR?=
 =?utf-8?B?QjN5R0VGWDc1bkdHd0tTanlGQTZqejRjN21YbmxORUdVak1RUm9lME1NOXAw?=
 =?utf-8?B?bjFUNVI3eWJ4aUI0K0t2d0NvNFp2aEVhNnlXTVgzcWxwTmRLNDhKOGc5azhD?=
 =?utf-8?B?VTR4WmkrN1Nodm1ES09RbitHVU9QNnA5RmtrUHhmYVhhYzc4ZGJ2bUw1R1ly?=
 =?utf-8?B?T1hCZjVyVzR2Z0RkRTNwa0w5TnNCR0FPTW9CNkE2ZDdoUU1SRDNLaS9VeGxD?=
 =?utf-8?B?ekVyM3EwYVNVNCtNL0ZxcGMxSkJkSDNRUmtzTmN5V1JxVHlKZDg4dHRqWTJY?=
 =?utf-8?B?Z2lyM1BQejF3YVlMdys3UmJjZHRSUkxsd3V6R1VHYTZqRlc4cy8reml5UTVP?=
 =?utf-8?B?U1JzQmw5RFhqQnNjb09UWUZVLzAzdDFkWWJtWVd5dWZ3d0plQ0dXWjhMTWQ5?=
 =?utf-8?B?SW9seW0xYm5iNjlUYm5OT3Q1YjZsbTIwdXJlM00vOThsNFBtRWhsWGpLWkJG?=
 =?utf-8?B?U0VObzBSYjZWYnpFTEFxaEJnWktqZkZ0VEdtMlpQR3JLSDgyQ040UC8wT2kr?=
 =?utf-8?B?VnNwRzVCMkNNekwwUXRDTDNOdkt0U3hLMFkySjFzanprdit4RGMzRGt4TFNY?=
 =?utf-8?B?RUxvVUdwSW5SMndVOWFrUWdrSnd0QVlFSDU3Wm1rRzUwTW5LdnBiYkJtY2hq?=
 =?utf-8?B?alJUdEVETnQwL0EvejR5VEdXbVRVR0JOazdpZlZmcm9DWWNwNVpjWHJrSmZw?=
 =?utf-8?B?ZGxsTjltOEh6SEdaNEg5Zmh2UHJtdmJqUzVyVG05R1IydUw2c0tMZGIwQkg4?=
 =?utf-8?B?SGJLZGFMZmNCVXhFWWw5QnBhdEc1cVNJSzRLZGJxYWpVUW5RQ3VJUURmWkI5?=
 =?utf-8?B?R0liMjU4ZHJSRjBUTDM3Mzg2R3orMDh2emc5MVVSU0xDY3pNVDU0dUZGVHBi?=
 =?utf-8?B?NnBFZWorUkdNcHpSYkJRcmZiTk5jUC9sNU9iL2hzUHpxdGdtRG5iRGdzQU5N?=
 =?utf-8?B?bXNKVzRiUVRkaURWLzdTUTI2cTAyV2lZdVZhSUNoVlJOam9RT083emlHRmxr?=
 =?utf-8?B?SzhoS1pidVhxWnJsd2luZU15b1hkUVVVUlpvUmpGTzh5RjQvaG5PaDN6eDRF?=
 =?utf-8?B?bU01QkhqQnZrNjg5bU45ckk4R1ZBQjM5RXZMVXU5L25IWGtxUC9ZWE1lbnBM?=
 =?utf-8?B?TlVqVk9jZXBvcU5na1VRelJINFhmTkJIbVpLN0NPNGJScWZhNFB6RE84TTNK?=
 =?utf-8?B?dkZjamxkejhvMy9mUUdEV3FXREg2YTdTdms0QXp6VEtkczhPenE1bU5COFRT?=
 =?utf-8?B?QnZzaitnL1NpL1VxTzJzUW00ZnMzRU1wcFlLamt2dFFrTVBud1JPb1MvWUc4?=
 =?utf-8?B?bEFNSHQvM2tEMHp4VTRoWXlraXdNdjZjeEJyZzJhaHBBTEJxUDVsbStkN3R6?=
 =?utf-8?B?RGFHM0NmM09kRllCaUwvZXhxdUVYSUUyMFgrLzRpQ0VRcjA4bUxOTU9YUFNz?=
 =?utf-8?B?eG1ZK0NQSDZhYUdnbnpBcHJRM2ZSOStOV1NiUkVKZHpoTDkwSk44MEFMTjl4?=
 =?utf-8?B?Ri9hUk1rRWpibWFEZlRSSjEyT2QxME5YaUdhdStHdzF5a2xZR1p2S3lTdG5Z?=
 =?utf-8?B?MUdqMGRXRjE0bUhQSk9wSzV5eWhxZjk4cDFxV0JJODFJNW1yWFhTN25zY3Ax?=
 =?utf-8?Q?2SDVk0dejE2TVcQiUh+TjWtDZ1JoGUCMhOYFFpf1XSGv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6323ED1B16FC7D49A5EF833B309F85AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150b3d65-5d8f-473e-934a-08de1031a7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 23:37:38.9394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08XfRvNnik6tsQHxoLB6fgfE496WU7DBapJsdPnyWlbrt/C0caxvg5N1Z2ElrUQ8EAs/6P3kTSdbUwGHm44SHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_163748_408583_2F287A93 
X-CRM114-Status: GOOD (  11.19  )
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

T24gMTAvMjAvMjUgMTA6MDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRnJvbTogTGVvbiBS
b21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0KPg0KPiBJbiBjb21taXQgZWFkYWE4YjI1NWYz
ICgiZG1hLW1hcHBpbmc6IGludHJvZHVjZSBuZXcgRE1BIGF0dHJpYnV0ZSB0bw0KPiBpbmRpY2F0
ZSBNTUlPIG1lbW9yeSIpLCBETUFfQVRUUl9NTUlPIGF0dHJpYnV0ZSB3YXMgYWRkZWQgdG8gZGVz
Y3JpYmUNCj4gTU1JTyBhZGRyZXNzZXMsIHdoaWNoIHJlcXVpcmUgdG8gYXZvaWQgYW55IG1lbW9y
eSBjYWNoZSBmbHVzaGluZywgYXMNCj4gYW4gb3V0Y29tZSBvZiB0aGUgZGlzY3Vzc2lvbiBwb2lu
dGVkIGluIExpbmsgdGFnIGJlbG93Lg0KPg0KPiBJbiBjYXNlIG9mIFBDSV9QMlBETUFfTUFQX1RI
UlVfSE9TVF9CUklER0UgdHJhbnNmZXIsIGJsay1tcS1kbSBsb2dpYw0KPiB0cmVhdGVkIHRoaXMg
YXMgcmVndWxhciBwYWdlIGFuZCByZWxpZWQgb24gInN0cnVjdCBwYWdlIiBETUEgZmxvdy4NCj4g
VGhhdCBmbG93IHBlcmZvcm1zIENQVSBjYWNoZSBmbHVzaGluZywgd2hpY2ggc2hvdWxkbid0IGJl
IGRvbmUgaGVyZSwNCj4gYW5kIGRvZXNuJ3Qgc2V0IElPTU1VX01NSU8gZmxhZyBpbiBETUEtSU9N
TVUgY2FzZS4NCj4NCj4gTGluazpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZjkxMmM0NDYt
MWFlOS00MzkwLTljMTEtMDBkY2U3YmYwZmQzQGFybS5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IExl
b24gUm9tYW5vdnNreTxsZW9ucm9AbnZpZGlhLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

