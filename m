Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2279ACF45D9
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q+PC2ziq1B4yHrtwTgea9xgLBBVlv4NmjuRhfjTJVAU=; b=1Kug9rheITG6KgYdz99kKO7uaV
	ar4qkhqTAjrYWs+adXIqmhcrYawkK4aEOJoONCJcmY5pVKpKWtbD75hR6VjfXFaj5X26zyvohDoe0
	zZpVfLbLrUvKronhqOIv6hHhwa6bxF/b7k5TA3gEb+7eUjtKZdHh4sUNkmyqcW0ibo54PGNrTe/C+
	hgFwCW+GlGkqLmdeKANZnuXoa0KCmKdf5I7LfafyiEiHPP7ROSa5BFIH90XGiNj0jAiYdCz70XRWW
	HbT0ztjFJxC5j8euDFATqHjuqTZW3Td4Qi85CoJKiPDrZNTG3YajEk8EsnERH4MawJC9YsJEFzkLf
	BeOnfY9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfRdU-00000006K2R-2XRD;
	Mon, 12 Jan 2026 23:47:48 +0000
Received: from mail-westusazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfRdL-00000006K1n-3XDK
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 23:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlyPKh/xmKMCPg4aoOFVZTRflP3vigiCtRltdZIWvXAkS0dE2PFgbwg5+8LK7+xRf9/hosO9EmByGPw/FyVaKo5SnTPz86etDCwOEcqGHa6csOMyMSCCocQ8gALC/mdGzWEvD39z/noIMwxA8vRcxD1bp3c/UAxNKqNHOstocjQ1HmjP0VaUiMw7bZxW08w5coV8Q6yMFuXzYFi5ToqHX5KECa1Z3b+8R/hTHYw8SQPxBWuBAd/j0XXxuKUQli8Gy697bL0NEP4A5ayrFBtdiwkcA5ze29d9adLobMvK3IvtSmvo6YfZE/MVmdtbJjXYtMC5K4l3pDDH1hne6ctCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+PC2ziq1B4yHrtwTgea9xgLBBVlv4NmjuRhfjTJVAU=;
 b=R+fCkuusYtyJSuhZXnoF+nwERXqSfWUf+oVgVV6YyKvKgeJQPP/flBP0q0PJJWhXaD83otLhhO+5Cw/dBDNyEV9m+s7fZgqCS67De+YPVJpdyVSJ8NJZXB8cVjglNdZ6a72ip0dfc1jT4Z1/OfzMruirYP6GzT7seEzGPx8/c1lbIWktU/LCx8iP3bBvWLPxKjr/+p3yz/DayxWcf5zLooS5R6HabLUl/5SuLFlsww+p84Nu5glba3l9dbstPyvdMduZeVK3hvDvGVtvmx2t96KNyXP2SDjE8cViyjq58wSzaKfmUBdYQomLmOg1P28569y8MWJgztnfhbebcRtGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+PC2ziq1B4yHrtwTgea9xgLBBVlv4NmjuRhfjTJVAU=;
 b=fMgCbhL5flQFSBCUqOya4MuY/XoppUhD6HQo+kdgspFL+yLAzb6LfhXuK2/4KPntgjpCCK+kJMwXP3RyZidisFofl88iW7M/piznDpmEuqcvF8bRiLe77AY7nPIabCMeGpT5q+WzSDeJBGn1ltnU9pNaodZ9HfG+hcoqd/b4wbhXVYEX4Cn/npGWYonA57M3pr4E+4auuwuOZUydpyhgNZd9TutWpvqTqyboAwiYC3uhLHelFnRy/AGcN9bRCllazz8XHgYHEhu/+JhPDoYXB4YVy/oDtoV21WJtvvTZFnN1Ey8k60KmSqS2xl6dPgkYEXYwni9ZxtwI38FaOoRBZg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 23:47:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 23:47:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "wagi@kernel.org" <wagi@kernel.org>, "martinus.gpy@gmail.com"
	<martinus.gpy@gmail.com>
Subject: Re: [PATCH 1/2] nvme: avoid printing iopolicy in list-subsys output
Thread-Topic: [PATCH 1/2] nvme: avoid printing iopolicy in list-subsys output
Thread-Index: AQHcg7Ura8viGEe8TESJ4Uz3uKh4Y7VPNDqA
Date: Mon, 12 Jan 2026 23:47:33 +0000
Message-ID: <74d585b0-8665-4865-b1b4-867c4fc02bc7@nvidia.com>
References: <20260112111731.1631091-1-nilay@linux.ibm.com>
 <20260112111731.1631091-2-nilay@linux.ibm.com>
In-Reply-To: <20260112111731.1631091-2-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7467:EE_
x-ms-office365-filtering-correlation-id: 11dc3004-b62c-43d2-7909-08de5234f508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MlBPam9GbjlPL3ltMXJJVzcrcG5PdVVXYkcyQzdkclBLSUxtUVE4MDdLM0ox?=
 =?utf-8?B?RW54RGlVNEtkNDVDaWhsMjJ5dHNZcGw4UHE0ZWZDd3FLN3c5eGRmTXY2bzBW?=
 =?utf-8?B?WUx6MWVpVnFoZDNlL2tXcXI5enczZ0lmZVBEWjkwNzRPYTFBOVRpM250Q0hh?=
 =?utf-8?B?VmxMcGVxc05qdG9zUkdwZTBrUUtzTElpYUY0cjZKQ01xN1I5TnRhNWxVdjRY?=
 =?utf-8?B?ekRpZGRuZjJLV1daaDl5OGx5d0phRXZjTU13Q25jK1lCTGkybXBTU0FOUDRV?=
 =?utf-8?B?Z3Y2NHRZMnVpaW9vU1BXUytPcW9KZ2ZJZm14Y1gzbGVUTmtuR3dUTzNRdlVF?=
 =?utf-8?B?MVdjKzRCU1RvNXJzVnhYRUJRd3hiWW9oRXFHVllkcjFrbmc1WlRyM2NPVG9S?=
 =?utf-8?B?NTBNN043ZmtBbENBdS83VzFDVFV5YXFhdXlCandQYlhLU1A1K2MwNnVZU3h3?=
 =?utf-8?B?TmhUM1psRnVubjAweFdSQjZjZ3JUa3pyS25xUzd1bVdZWUxUUGlBNU4yVTBL?=
 =?utf-8?B?bm9LaHZtWjRHVE80Y0tpNm5TeDlOMXNORCtBU21nazdYZGpkSEFKeG5yVUpC?=
 =?utf-8?B?aVA4dk11Z1F1QTc0bWtOSE1WRGVhSEczRDlRVW9NeHRsSEpiNTZFcmd2YXAz?=
 =?utf-8?B?MituQ1ZTRUNTQ0RqaTEySk93bzFYcFN6eXBrY0t2WExPdi92U3NvN0hLbXVv?=
 =?utf-8?B?MkdJdHM2NDN4ZUw2WE5TT1JmYUwrZTdCVzB4eVRwQUE1UGhBYzJHdjhqeERw?=
 =?utf-8?B?WmRZbW11bmViSy9pWWZxUjZhMEZJTWVLaWUvZGVlalUzV09BaG5SYUU1VDFv?=
 =?utf-8?B?SXBZMUxZelBSQW4wNC9KbFF5enNseDFhb1JkRndwWmRlT25pMVVPZG9EMWp1?=
 =?utf-8?B?WFc3eHN3NVJ6MDNtWXZwcGVtUDVydkJMMlhPNmEwNDF0ZlVMZXowbDlFNHhE?=
 =?utf-8?B?dmlqREF3VFFValUxenJBNXlxUmQ4cmJzZEdlM2NCbG4xRDg2Yzg0THJRTWNZ?=
 =?utf-8?B?NWtJQ09wd0ZRWlM4SXZxd0YySFZFc1B2R1c2cU5zRnc0TGcyNEZqZERzVWpl?=
 =?utf-8?B?M0Nwc3J6NHlBaDZ2R1hsU0dDSEx5bmtjSExGdnFwOG9Hcm1oU1hsVFQwZGZl?=
 =?utf-8?B?SCtSTTNLUTlOS09SUTdxUDVvTU9ZSi93NkVYQjNLQ2RvaGFjaFc3YmF6Q0p3?=
 =?utf-8?B?TGFDTnRFa0hSTVdQOStMLzBmb1k5SFU0NnNmWXBlWTRMemIwbkpTb21FZUpt?=
 =?utf-8?B?ejJnNnNRLzFFMGY1clRwbTVyZWErTXBobFUvdUF4TENlRWZQcGk1WVF3YmlI?=
 =?utf-8?B?aUUwcG9qaGg0K0RWZ0g5a3gvUUMybTNJWEZ4TnJTbkNvTDBTTjhmTklPNkxp?=
 =?utf-8?B?emozNjh1cUROZklrTkdCTUw5cmJLY0pmcDJiY1Qycm9uR29rQlpIdC9DNzBV?=
 =?utf-8?B?UjlqOEZ2UUdUODBZR0h2UDFleWpUUFY0YWxWZWVyZVROLzZYeFk2TVExS2pW?=
 =?utf-8?B?OC9MQ2w0RlYzRllHUkkwMEVrSzBNUXFFQzg5NGtLck10OE9RSzI2MW91UzVS?=
 =?utf-8?B?aUd2bG9CSWNNaXJUNDZzVlN2bisrS01PZUVMRTZLM281N05oTTJTNGRRT1Qr?=
 =?utf-8?B?SlpkM0V5Q0FVd3ZmejlqYTRmWnVudElqM0FDQWFVaWVuOXZKbkNDcjhuUFN1?=
 =?utf-8?B?TExZL3dtS0I2VTd4YlI2NUR0QWowTUFoWkJQZzNUUHVQbncva290QWN1Zkxq?=
 =?utf-8?B?dVFFb2xVbzh2S0kwUjlnS2YvVVdrSnBtZFNDNUZGcmNMeHpPRFQwTFFSdmdu?=
 =?utf-8?B?aTg2Zk96N2w5MDYzUDBnNFNiVzN4M1RHK2lacGp4UFhySmlqU3VPZFZJNEZB?=
 =?utf-8?B?R0pXVndJMXZCMUdSaTN5aXlac3NvSElVNW5jZFdwbzdvN2hXU29PTzREUDhG?=
 =?utf-8?B?UEZ4WjJuQ3pqSE5iY05OV0RRSmFKeGVmVmExOUVJSE5zYTc0U0xraFlrdFdi?=
 =?utf-8?B?aG8yZVM1MFNEbE1DMVRJaHh5ZEhBY0V4YWgvRVZzK1grd1pEZnpRVWViK0JY?=
 =?utf-8?Q?YfS9af?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zng0b1pqdkEzbGY3b1ArNnVpWHQ2Sk5SRWtLcWtBY1ErckhmcWc0ZmxmSTdr?=
 =?utf-8?B?M0FoenFTQWpjQUNVYTFUNkdiSlU4b1FncnU1NEtsWWtSWmg2QjdNWkJtczR5?=
 =?utf-8?B?ZTdvZUNZczlaK1VTQy9rd24zelJsR0FsUFArRjMxSVF6NmJUVU5VSEpqT2ZW?=
 =?utf-8?B?ME5td3JmRk9tdVNpNkNYZFRmcml4TFg0QW1PQVZPbUpkMlV4dVI5NytMR1dx?=
 =?utf-8?B?d2pEUEE4dXdpNlNHVmUxOVlSb29vdldtZ3pPUDZLZkVGZms2bU45cHEyV1pD?=
 =?utf-8?B?Q0pkU1lwZWNwdDBSOXVXNU5ZNHllQ2RrVjUwOUd0NUxweEhZL05sSmI1bjBk?=
 =?utf-8?B?dmxjakg3NFlnbHM2a0FUVTQzQmhJUTJMaEt3TkpRVDBYeTlsZFhrcjRkZXNy?=
 =?utf-8?B?ajdhSnU3eE5GZ2lmaDNvM3lubVlrazFmWFdqTnNGcHg0Vmd3YUJ2UDdXTTQr?=
 =?utf-8?B?Y3A5VWZVMXhQdC9EeUNiSHc2VXorbEF4TldCemZQcFJITnlNL2wxVzdWTXRx?=
 =?utf-8?B?RE03RUVGcVViNlJvS3VBZm5Xcjl2MGNnMUMwd2loWEJtNHZ0N2NqRFpBVnF3?=
 =?utf-8?B?eWIyanRsbzI4QStWRTdNMmV1Ym4wL2ZDU3drU1hDbjNRRyt5K0wrcFVQQnRx?=
 =?utf-8?B?U0FkeFY1Um43eWJzZ2RyaEJGVjhpUytOWWE2YU1IYlJYZ0FuenhzOU4yL2ow?=
 =?utf-8?B?cFJhU1psdzlLMDNaU1I3WWtiSlhZZ1crczlzTWlJNkZ1SkVqNm15MEprdFVK?=
 =?utf-8?B?eWV6Rm5HY0VRZzRnT0JqY0l0S20zR2QrM3drMzd2TzM1WlZ5MHowd2dDbW1M?=
 =?utf-8?B?bCtxWjNYdUQzVno0Z0pUQkdXL3lUS0xIcDJFZ3BTUkNUeUF6K3B6MjJvNlFv?=
 =?utf-8?B?Y2JCRnpJcFV6VUdZazYwZ2NXQ3JyRUtRYnVWUFFxb0FUSDJJbXJvelZHYzRC?=
 =?utf-8?B?MFp6TERqVHdTN0gzVUNBSURDSWFlcTF0eVI4dGszMFlhQnM3TkJMdGpGMFBk?=
 =?utf-8?B?ZWRlRTVBQk5qV2tibzhDNDBPT2FSYlZ6dGFBTEVTblJidkpIcmRlN0JoeHla?=
 =?utf-8?B?Y29udmtKQWFGUFhFejlyMmMzRkw4QllGR090aldmaEV4UGpJK01PNlpYTE0w?=
 =?utf-8?B?QUtnOTFJT2svUThERzczQzlheG5id09XWFZKK2EraHNqaG9Hbm55cVhjQ2M4?=
 =?utf-8?B?Z2dCbHRmeVFRSVNDNXRNNzhWOTVBdW9COXJ6VUtnRW1abHVNY0pJOUFsclB2?=
 =?utf-8?B?TzU2YmdqcWdZcDFSYTNWRTM5Zkp1TTlBK2FIdkJzZitmaWkySW05UFFCdTVM?=
 =?utf-8?B?QTUxbTNyMUpldjlqaUpMWkxqK1ZZYUlTdUtmNWlHNzBoSTdmV1czd1hLa3I1?=
 =?utf-8?B?SkN6OW9pSmVuWnVpV05WcVlybXZFeFRpaWVqSmtpb3N4VTNkeXBGOFBTVitP?=
 =?utf-8?B?bi9RRGVvRTg3aDZGK1V0OTJFZ2EyLzlDU00yU1VkNTVrYXR5c0Y0Qkh0RlJO?=
 =?utf-8?B?czhnOEdERjUzTExjM0VycThGZkc0RnI5SmlHd1NSeng5alIyZWxPd0lRR2tx?=
 =?utf-8?B?b1BrM0VhMDI0QnE1dUJ1aURXcElTOXVMMFRHVi9FMW5pa3Y2TWNRSDZndHlX?=
 =?utf-8?B?cHJZZHFmWGVjTFVFUFdkVDM0RVBrVUh5Rnh3M0FGeHZKSmFlNkZObllQOVV4?=
 =?utf-8?B?QXoxZkhWSkxrd29vd1kyNExuaFBGUzMvNFV5aGk4TEFJLzJCMis1aDhjSVB3?=
 =?utf-8?B?cHF4cnliMWJGK0FQRG1ZaHlxTDQxU1N5bEc5YitLWmt1TFpzYnEvTEdIWlhn?=
 =?utf-8?B?MGZ3b0J0cnEzMEYrRStPbmxPMUI0YStDZmYxRDFYVEVHREs4SXVZMW1KQi8w?=
 =?utf-8?B?b3lKZTl1UDloMXhRRHNhZUc4ZnBMOXJuYTdwZGFwSi82ckxjZnNXUXFGZjB2?=
 =?utf-8?B?WWtLWXBCRS9UQXJQb0JLcG1HRFVhc25IR0xJRzQxTzlRSlJnQnREaGdYUEpt?=
 =?utf-8?B?OG1zb3E3eW9wRVF1VGplUFJFeWtEbStZeERFSndJMG1iNDlBNDR1VFZjTVJ5?=
 =?utf-8?B?OGNGT3hKQWhhQmRTKzljSTlvTmh6Z3JkRkpZNGNnUDJhNmVUNzBoTXdPZDd5?=
 =?utf-8?B?aW1OU05yQWFWdG5NSHZLRVk5TG84dVdUMjdheDhhc0dBNW1mRzlUSmRoeWVv?=
 =?utf-8?B?VVZUdTM4Ykl2VFhQRTJQTDVZRkVKYkNuWVZiVmcvWUN1V25MTzVEUGxlckxL?=
 =?utf-8?B?V1RkblNPMkFUdGRaVHFIVjVLdGsvcjAzU3hFZ3kyVzBEYTU1anQ3a3MwZ2pM?=
 =?utf-8?B?em9pVndBWmh0UXdPcDRoN2tlOHJKaGNaL2hESFByR1hOTTFwVHpDZDdGTzA3?=
 =?utf-8?Q?uHpJU72tizzYyiWg6H/z1g5jci7/jf1aAQQGl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28E1C45EF5694C4F9AD70E5FC082FFF3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dc3004-b62c-43d2-7909-08de5234f508
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 23:47:33.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrflIGFB5NFh4LavK/D/0+HJbRbQNIy24t5bPXuiIWubga1NNq81ljfZQW3gdneLXNWDQ1FTLlbB7W3yPPZ/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_154739_883694_DE40181D 
X-CRM114-Status: GOOD (  16.22  )
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

T24gMS8xMi8yNiAwMzoxNiwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBTaW5jZSBjb21taXQgZDBi
NGM2Y2YwMDA2ICjigJxudm1lOiBleHRlbmQgc2hvdy10b3BvbG9neSBjb21tYW5kIHRvIGFkZA0K
PiBzdXBwb3J0IGZvciBtdWx0aXBhdGjigJ0pLCB0aGUgc3Vic3lzdGVtIGhlYWRlciBwcmludGVk
IGJ5IGJvdGggc2hvdy0NCj4gdG9wb2xvZ3kgYW5kIGxpc3Qtc3Vic3lzIGluY2x1ZGVzIHRoZSBp
b3BvbGljeSBmaWVsZCByZWdhcmRsZXNzIG9mDQo+IHdoZXRoZXIgdGhlIHZlcmJvc2UgZmxhZyBp
cyBzcGVjaWZpZWQuDQo+DQo+IEZvciBzaG93LXRvcG9sb2d5LCB0aGlzIGJlaGF2aW9yIGlzIGlu
dGVudGlvbmFsIGFuZCB1c2VmdWwuIFRoZSBjb21tYW5kDQo+IG5vdyBwcmludHMgYWRkaXRpb25h
bCBjb2x1bW5zIHN1Y2ggYXMgTm9kZXMgb3IgcXVldWUtZGVwdGggZGVwZW5kaW5nIG9uDQo+IHRo
ZSBjb25maWd1cmVkIEkvTyBwb2xpY3ksIGFuZCBkaXNwbGF5aW5nIHRoZSBpb3BvbGljeSB2YWx1
ZSBtYWtlcyBpdA0KPiBlYXNpZXIgdG8gY29ycmVsYXRlIHRoZSBvdXRwdXQgd2l0aCB0aGUgYWN0
aXZlIHBvbGljeSBjb25maWd1cmVkIGZvcg0KPiB0aGUgc3Vic3lzdGVtLg0KPg0KPiBIb3dldmVy
LCB0aGUgc2FtZSBpb3BvbGljeSBmaWVsZCBpcyBhbHNvIHByaW50ZWQgaW4gdGhlIGxpc3Qtc3Vi
c3lzDQo+IG91dHB1dCwgd2hlcmUgaXQgaXMgbm90IGFsd2F5cyByZWxldmFudC4gVGhpcyBoYXBw
ZW5zIGJlY2F1c2UgYm90aA0KPiBjb21tYW5kcyBzaGFyZSB0aGUgY29tbW9uIGhlbHBlciBzdGRv
dXRfc3Vic3lzX2NvbmZpZygpIHRvIHByaW50IHRoZQ0KPiBzdWJzeXN0ZW0gaGVhZGVyLg0KPg0K
PiBUaGlzIGNoYW5nZSBmaXhlcyB0aGUgaW5jb25zaXN0ZW5jeSBieSBhbHdheXMgcHJpbnRpbmcg
dGhlIGlvcG9saWN5DQo+IGZpZWxkIGZvciBzaG93LXRvcG9sb2d5LCB3aGlsZSBzdXBwcmVzc2lu
ZyBpdCBmb3IgbGlzdC1zdWJzeXMgdW5sZXNzDQo+IHRoZSBjb21tYW5kIGlzIGludm9rZWQgd2l0
aCB0aGUgdmVyYm9zZSBmbGFnLg0KPg0KPiBGaXhlczogZDBiNGM2Y2YwMDA2ICgibnZtZTogZXh0
ZW5kIHNob3ctdG9wb2xvZ3kgY29tbWFuZCB0byBhZGQgc3VwcG9ydCBmb3IgbXVsdGlwYXRoIikN
Cj4gU2lnbmVkLW9mZi1ieTogTmlsYXkgU2hyb2ZmPG5pbGF5QGxpbnV4LmlibS5jb20+DQo+IC0t
LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==

