Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6985EE83836
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 21:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBvO/aNsZs6TaDPa07OFc65hcdJxsEX6RPu/9zWd0OY=; b=J8bVtWLGeAeRWTq5fQ0MhMRt/o
	I5qmD9zhyVKDUEdPhbPWdJPqpe43QxR0WVm9jZLLpHVv/JKcEPgdqyqFdEmwW+f/LN/UxHr2EPxo6
	PVvekOdqcwyuLhf0DrlMgXTc6cdM0VUp+Uv1fifxwHjIE96cdVASxckqrNC1hpjGJp/BMX5jC3GTA
	Fa9RwqN9aZQjrGQ6OEcY1+RfVjOPYIX4YwXReaIDHm+nqnJLtp2eA7TSFL9HDWrKwjy67QQRRP45X
	PKLPOqwxVQmPxKJg8wUINIbOd0Ri+GnPD/g7gLWH7UBWdvjXjL5sZhXDyqiBFD4nFQTslAlGkZTv4
	W3nuohCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs5zZ-00000007I3x-0eqs;
	Mon, 16 Feb 2026 21:18:53 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs5zW-00000007I3W-46Pr
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 21:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpjJTOEXIOX7PvpQEZMNNg71azAw/wbz4fpJnlkKrPs+MiV+GWNOboDLM5CFm0jHgOPyVzwKgYfpZdtwp9uuccoAjoIEwTd9BFFlM9fjW3330ua1Z6B6YphBeQ2U0jy3hM72ukkqON6txN6mwetWVbi8ZEAdNqPqYjG6eVNjAVCTcjNXEVhELTyEtx2sFF7jdDN9vpZMe10RS/7OinbH9i5Uvi84EzHxxGOjitnEgBZS70OpaVFBAVEtDlTJmjBLW99PTAAQ/B0qi8XiRzi2kR+ciwLpLwtqunzEMgoo5C5lyv6bslm9hwMssSjEuPD1bZKkcLCv9womIBhfBYwc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBvO/aNsZs6TaDPa07OFc65hcdJxsEX6RPu/9zWd0OY=;
 b=J/vXitAEK+dZ9g604cScOov8I/7njN3yN5iikhW971okm7e8m9xfKnElZfaEfjdqYHkzeGJxgPpH6Kwu2L6inbDDFnTPgtxyy1+/Ld7qlIkGgvm8Lp9NyzHVte+/C/8zk2TrZ1i4Wes/k87CwDrXav4/J+6qiTVKUoqUc7ch1P5ZgZOS0SjVSNpuhhpZ0bFsL5RqtUdjfK/C7c1add+lcEYFlZkKfgHpkyxhOYjj8RKwXgPmKio5GlzBNwgisnK3jPt0wjk6f/sS+JgGvnxGSa9LHaXVhqdrsTBMpQKRmHBZZWtUJEPZZGEs4eCGPfK0qKMJZ0E4qeoSPWRNAFivyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBvO/aNsZs6TaDPa07OFc65hcdJxsEX6RPu/9zWd0OY=;
 b=os4AJfk+FJVJA8pFKuY6iy8Rl2XtSnc0oUq0OpFKycRtmzKeXUUahL1tAQn/6dthhprRkYEIaOD02AeMyo9+ZNEab4M8M8FWwF/lTab6psMMFV9EGePqWZXrFLErI2po+aZofMLgaeDHzepImQfPdV6V5sowG6aHJe/P06Ov0Ad4yO12tq/tCSLCf2sn7jI4nRAxsnzUVjcC7QsEZ4Kz156mZOiAw//wfwaOMvmixDYMY3wBbBryTTxwDXYbks+z/4y5nM1wAE1yXtsx2u5qO5hYfkwi5dTdye56nJx3nb++m/7dtSvOop2vHM6H8f+y/gHZ10cl9QQN14aF8ld2/A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 21:18:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 21:18:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>
Subject: Re: blktests failures with v6.19 kernel
Thread-Topic: blktests failures with v6.19 kernel
Thread-Index: AQHcnL546UP/dHCUV0i3P4Kt4vejdLWFFmWAgADDxAA=
Date: Mon, 16 Feb 2026 21:18:43 +0000
Message-ID: <c3f8b641-5607-4553-ac8e-7afc43bb14c2@nvidia.com>
References: <aY7ZBfMjVIhe_wh3@shinmob>
 <1ea3f9bf-c271-46bf-9310-be489ded05fc@linux.ibm.com>
In-Reply-To: <1ea3f9bf-c271-46bf-9310-be489ded05fc@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB6011:EE_
x-ms-office365-filtering-correlation-id: 91ac5df8-8930-4c51-d084-08de6da0f68e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021|7142099003;
x-microsoft-antispam-message-info: =?utf-8?B?WGppcVk1TlRxcG13LzZ0TWhodkVuVTYyNkt4alM2WXd5Q2FXOTBER2R5MnZR?=
 =?utf-8?B?VUlOc29VVzdZaHB1YzVLVFN0ZVVjUEJFQUI1K0RjbFhVaVBheTZ0bjVhOUFv?=
 =?utf-8?B?bWt6UmlRWHh4UFVFMnhwZmpQeGdudjFPRVFXd1pPckptSDZiOGRMUnVQSENs?=
 =?utf-8?B?bGFyUlZVb3RWVVJqdTRqSU8zMytDWVZ3eTJHYzlFck1VWDdOWTRHc2c3M0FZ?=
 =?utf-8?B?U2N1YnFpMHMrUkxkOXNCNkxucHZwYXMvQjFtZXRYWGMwV2podURDbFo3L1ph?=
 =?utf-8?B?SWtlWEV3SmM5VDFZdUw1amJDaE5Kci93NzR5M0JtWWJJT0Vyc3VBTGJ5bFJv?=
 =?utf-8?B?MkFCczRSSmhHZUtiRzgvYllFcXY3ZUwxbklLWktnMEp1R2VWT2tWU05uTjFW?=
 =?utf-8?B?cThYUlZWby9kZVNaVEp3Q01FNDhWYzhWNXNITzJ6eHpvamxEcWlhKzBiWFZ4?=
 =?utf-8?B?dFFUNXJZMDNLeXBqVW5xQ0YvTDB3VzBtNVJYYVM4N0xjWk5ML3RacGJZN3BW?=
 =?utf-8?B?S2hYdEJDdDZja3kxNU1SMVV2VW1IRUhZRlhwbERPM1lsRFFhZHVscTB1bjZZ?=
 =?utf-8?B?T3pVeVA0UHVqSXZTNXRsU2Jma0c1L3dwcmNUQ2M1V3NidGlLUVFCOStzS3Jw?=
 =?utf-8?B?elB4TTZhY3R2WXJ2bklzdlRzQWRpajNwWXRRb3ZnZ2lCZmV1Q3dpZXdwWmpJ?=
 =?utf-8?B?S0gwNTJHWlA3TXI1QldiN296MUFEdDlXQ0szT3BNMVhIMld6ZjlwamJmbXBj?=
 =?utf-8?B?dnBMa01GMmJpT2VOc041ZWhtdmpHaHVlaXVUeGdHeVBuejlxcERLL2dKaG53?=
 =?utf-8?B?cWRaVkN4b3FCR25ROFR5V1V5K3ZNR1cwb3VTWEluWFhkWDVhSFlhVS9uNGlX?=
 =?utf-8?B?TjQ0ajVkZmNLYUo3aGxsdEdSZEFBZmZuY00xMTRtdnB5eXJhQTNPcjU4dHA2?=
 =?utf-8?B?dmdJWmx6cXoyZ0ZUeHBNWHZmcGZCOEcrdENDMHJLczZxZDlPcWZWa1VEWC83?=
 =?utf-8?B?a04vQ1o0VFRzOGd4aXBTVUpMT1JkNnZuMm1BYm5XSXhKa0tUWUIyTGN0YTJ0?=
 =?utf-8?B?dTZJRFdId1pDSFJGc2hOaDhRVW8yT3h1ZlJJMFRuSkpoMVhLOTV0WHAxZThp?=
 =?utf-8?B?cmU1OWlMZkpmanlCUkVFWmpQMFQweTlrRWw4ZldWZURDUFR0VkI4NkxYb1RY?=
 =?utf-8?B?ZlVHU1FBRGdheDhuejQxcENSbGl1aXp4aW9KM1U5bVBLUGxEaDhTaVZJUDlG?=
 =?utf-8?B?SGNzMVNKVkVFazRzQ0NZYXdWaytveUs5aFo4UzdxTmFtcS9xaEp6NTBqNDBt?=
 =?utf-8?B?alZ1bUxick1ZcmlDS0RSVTkxQXh6UzFORk5ocElzZTUxTTk1WEZTQ05TM1dh?=
 =?utf-8?B?ejdwcEwwd3lZVUxoUW1vVklpR29DYm0xWUlvMXhsbyt6Q3hTNFhIb0hrVlU4?=
 =?utf-8?B?L1JTaFlBWHFQRk9nL0lETk55WHozNEJrT05OSGl1SmJoQkJ0TUdxdng5K3g2?=
 =?utf-8?B?dllyR3FvdG90YlBLbTgrSVJhcjJENU1vVGZUUW5pR2IvSThNa3hJVzNIYmJ3?=
 =?utf-8?B?WHREb1kzUHROc2xicmh4SmQwTm9ZUndZdUF4TlBJelpYQ1FQK1pwcko3dVBE?=
 =?utf-8?B?bWFCN24vczZLTWlrZ0ZzSHJURTVmZ3RwZ3l0U056WDhYZUdjNFIvanJHUHlP?=
 =?utf-8?B?T1A2MTVDd2sxVkNxbUM4Y2RYdHBNRmhTL2NFNkRxZVhla25US3BvTlk5VFkr?=
 =?utf-8?B?dVZvV0prOFd6TUEyYWFPWnJxdUlScVZHUkphKzJ5dE9rMEFzTWYwTVFvZnEz?=
 =?utf-8?B?NlpPcUkzYWwwYXI0VFhpK2UwMjdWcThiYjRUZDJ5dVFYb1g1bnJIMG1PRVlY?=
 =?utf-8?B?SnlGQ0FtK2M3dUp5MzdndG10UzlvdUFNejkvaXhOSXhZLzAxZ0xqNmt5dHJa?=
 =?utf-8?B?UkJLZm9mcFRxQmVDY2tpWlpuOUt0YkpHTHp0ZHhhbmdqdGJ3MVRId2d0OEJr?=
 =?utf-8?B?UUJockVxRVRDclBlSDdMWUw5UE92dytHL0V1bGgzZWI3ck0rb28xQmhFZ0Q1?=
 =?utf-8?B?ZXRzNU56Z0pBRnpxRFBYa2Z5VndDMFZTdXEvUEdieGl1YW80T3NQV2FLU3lD?=
 =?utf-8?B?MFNCbWpHWWU1TWZDMnkxbkYrcHZidStFWXNmYzV2M25IZmJleUxKczk3dThZ?=
 =?utf-8?Q?twbcLiFi18MF+yBrpf2IvkU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3RzTHByMnZZUzJ2d2dhTXFRVWpSeDh1OVkyNndjYzNoMmNMSG5NZnlUa1kr?=
 =?utf-8?B?YWh2dEhFcWxRTDBSNVB4TklURUhaRFNCZDdIS01QOXltSnhZUHhRcURxSU01?=
 =?utf-8?B?Qk9RMjhFWWpobDJteXY5V1dBMnlWenBIRFl5VFpzYzJ6SWFYSkNkVWkwK0or?=
 =?utf-8?B?RXBHRE15eG91NVdPSXhWQTJsakpNK2drQlA4ZnJ1c3BvemN0RlduZjFNTURR?=
 =?utf-8?B?UWNsUXNLN2ZVMHRQL3VjVW0xWHhSSTJmSUhXMHNPTFd1djM3S2ZDbEZvSnpr?=
 =?utf-8?B?alkwcHdua2F2WHBZcENNTU9Rd0lUc1EySlh5bmpka3lENy9WR3BXbzRocmc0?=
 =?utf-8?B?d1pZeHM1SnY2SUZ5SkpRRzllZUZMVVE3a1ZWWm9vRnhRUzVpMzR2ZHp6UUsw?=
 =?utf-8?B?SWsveHVnQXZkcDErUVorZ01jL0NhRTV6a0lmSkQyLy9tdStUK2loemxlVHVp?=
 =?utf-8?B?WWRkQldXSFlOOU1HWVh6TndUS203U2p4a0tXNW9MRUQ3cGR3aVFjUG50dWgz?=
 =?utf-8?B?bG9TWllXVy9CS083K2xYdGNrV2pvdVpqbEZFdXdhazdnczZTNGFiYTJDemtW?=
 =?utf-8?B?U2g3U1ZRcmc2TVFiOTFleE5jMUNiQm9vSWVYRFBlTUxUd3FyQXdack9ZbmFn?=
 =?utf-8?B?ZW1VUDJFSEYrYXF2eFkvNHVHdENseTRtdEp0aFBBZVpnR2o0c0ZucThNRWl3?=
 =?utf-8?B?alE5Y2ZEMGxaYklXZGQ5ekM0ZGx3WTVZNllDTVIrN3hqaXc4YnhMYXc5Y3oy?=
 =?utf-8?B?MmhQcm53ZnFJN0czbUF6VTI3Y1VJVDhmOEZXdnZYcjRCOEh1NjF2dlBWbkxS?=
 =?utf-8?B?T3U4QkI0SWFXN2NVdDUwZ0VoUU5GVjFSSTFYdERuVkluZXJkQ3VYaE0yS1A5?=
 =?utf-8?B?OEtyTEYxL3V4a1BjdGVQM01kTGlqZ0JZLzh3UUtWMDNKejVobG4wckQra1E5?=
 =?utf-8?B?dW9VaDBvSnN5bmRCRHFLYytNdTRMZ09MRHNLWng1M2dIb0Q4c0JMNEZLblR4?=
 =?utf-8?B?RWxSQzBkOTI5SUN0eTh2N0Z5VS9sY3p6ZVBTRjdSak5ZODBZaWpiNG1vSGMz?=
 =?utf-8?B?OUY4dmdVTVo3Z2MyMXJvSmZDZEFtY2hERFJ5Y0Z0R3hoc2dmVC83YU41Sm1G?=
 =?utf-8?B?QzV6QllXbW9CTU0wdFVSSUE1OExhQyt6Q2lrOGlUcFFzelU0bThxNkdOeEVp?=
 =?utf-8?B?OTlwL3hLN01SNWMzNkZ0T29qcGluNnBjUDFlSVVCTDBhbzNwTERxR1hBeC9F?=
 =?utf-8?B?RWMwRWpINDROZy8wOTNwbmNVcThZOXRBV3FEZXFHeDRKdUxZSENIUk5mcjJx?=
 =?utf-8?B?Uk5UMHZHWmpRQXdveUdZU1JZS1BTN2JpbmdZVHNqeDhPSlFRYUZSSjFLSk1r?=
 =?utf-8?B?bVR4bURmSVpyOWpuT0gvclZYU01maVhkM3hwaVVIVmNTZVdRMmdkeElqTXY5?=
 =?utf-8?B?YmhqZnZnV3hoS21sL25FR1A1akh5Y1gyWnJwdW5YUHNmVEZwbVZDRG8vYlRY?=
 =?utf-8?B?Y3d0dVRCV2R6U0NpMzBibE5DZ0crOWkvcHBKNU1lUUpPOWU1VGUxMXk0YkJ5?=
 =?utf-8?B?VDIxVE9QQmdSK3c1VStPN0FRcDh4YWYvTHVEdWRiaDlLOWovR0pJaWZhYnEx?=
 =?utf-8?B?RjJDaHVmNkVGajZaMS9KWnZjMFVmdnRCWXJZcUpUb0R0aHp2b1BrZlBRazR0?=
 =?utf-8?B?cFI1QkJBUkdGbTNJVVEyb0JiVFNCeC91OVlMM1cwdXArZG9zK0o2Y1czMkpX?=
 =?utf-8?B?WHlUVkNsY2k4dFJHTUFIRWthMWM2amdkVFI0blNPY2M3ZDVwbXJseGVyNXds?=
 =?utf-8?B?SDZhdXZVZ3FiMDJjRGxyU3Q2UDhZdXZzWGxNVDVmamdIcjNQWnJZZWQ1b3Rn?=
 =?utf-8?B?MEtMMnArRnRpTUJjbVNMbituL2N0YXhKUXRWUnNCTUcyMk1mZThtN1I2M2oy?=
 =?utf-8?B?OUZOOTNPWDFobWZFdjhoY0FkV0FDL2ZsMUl4U0RiSmJnczNOLyt2K01RSmkr?=
 =?utf-8?B?aWNZNFZNa1hsTXBnYlFOMmlCZFZ0aEh3OVNnWU5JRDVkQkp1QVNXV3RhREU4?=
 =?utf-8?B?cTdjYUZoWEdYNlNlRk4xWkxnWld2eHZvYllNZVpUaEFzcFdRNFJWVmIxYzI5?=
 =?utf-8?B?VW5yQk9CUXFlbm82TWNZaVpwQWQ2RGZGdlFVUmhBREd5YTZVREtmVHh4WE11?=
 =?utf-8?B?TFRWZDA5RXkxQkhBVkZKaU5mWXRNMFZ1K1YrYjhiYWVOSkZYL25ycDRueDQz?=
 =?utf-8?B?S1lVc3FBYStjUGVoMXpDTk1MZldDQTRuTkJVTlNvZE4vN3VXdFliVkNodkJ1?=
 =?utf-8?B?d0lrS2lydEtndkF3V293SVVqODV5QnJ1L0JDR05lUWpQWEpITXdaSTZ4U3E0?=
 =?utf-8?Q?pEaymdFzlK6EE+Mpn8ps05Zvsnc1hbxN+E+mGJliHYfRU?=
x-ms-exchange-antispam-messagedata-1: WInFCgzk/J84Pg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2A91CAC78F5D64294A13BDA35298EA6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ac5df8-8930-4c51-d084-08de6da0f68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 21:18:43.1399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sWi1Zx1DE1fJbcRnF5S/R1m9J0r+xa12NPvDPlbdlhmPhq1Ekpbu5h0/xAv20B8SsTnMlt4tx4CLoSixY9uog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_131851_022202_829E36DD 
X-CRM114-Status: GOOD (  16.47  )
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

T24gMi8xNi8yNiAwMTozOCwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBIaSBDaGFpdGFueWEsDQo+
DQo+IE9uIDIvMTMvMjYgMToyNyBQTSwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4+IEhp
IGFsbCwNCj4+DQo+PiBJIHJhbiB0aGUgbGF0ZXN0IGJsa3Rlc3RzIChnaXQgaGFzaDogYjViNjk5
MzQxMTAyKSB3aXRoIHRoZSB2Ni4xOSBrZXJuZWwuIEkNCj4+IG9ic2VydmVkIDYgZmFpbHVyZXMg
bGlzdGVkIGJlbG93LiBDb21wYXJpbmcgd2l0aCB0aGUgcHJldmlvdXMgcmVwb3J0IHdpdGggdGhl
DQo+PiB2Ni4xOS1yYzEga2VybmVsIFsxXSwgdHdvIGZhaWx1cmVzIHdlcmUgcmVzb2x2ZWQgKG52
bWUvMDMzIGFuZCBzcnApIGFuZCB0aHJlZQ0KPj4gZmFpbHVyZXMgYXJlIG5ld2x5IG9ic2VydmVk
IChudm1lLzA2MSwgemJkLzAwOSBhbmQgemJkLzAxMykuIFJlY2VudGx5LCBrbWVtbGVhaw0KPj4g
c3VwcG9ydCB3YXMgaW50cm9kdWNlZCB0byBibGt0ZXN0cy4gVHdvIG91dCBvZiB0aGUgdGhyZWUg
bmV3IGZhaWx1cmVzIHdlcmUNCj4+IGRldGVjdGVkIGJ5IGttZW1sZWFrLiBZb3VyIGFjdGlvbnMg
dG8gZml4IHRoZSBmYWlsdXJlcyB3aWxsIGJlIGFwcHJlY2lhdGVkIGFzDQo+PiBhbHdheXMuDQo+
Pg0KPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrL2EwNzg2NzFmLTEw
YjMtNDdlNy1hY2JiLTQyNTFjODc0NDUyM0B3ZGMuY29tLw0KPj4NCj4+DQo+PiBMaXN0IG9mIGZh
aWx1cmVzDQo+PiA9PT09PT09PT09PT09PT09DQo+PiAjMTogbnZtZS8wMDUsMDYzICh0Y3AgdHJh
bnNwb3J0KQ0KPj4gIzI6IG52bWUvMDU4IChmYyB0cmFuc3BvcnQpDQo+PiAjMzogbnZtZS8wNjEg
KHJkbWEgdHJhbnNwb3J0LCBzaXcgZHJpdmVyKShuZXcpKGttZW1sZWFrKQ0KPj4gIzQ6IG5iZC8w
MDINCj4+ICM1OiB6YmQvMDA5IChuZXcpKGttZW1sZWFrKQ0KPj4gIzY6IHpiZC8wMTMgKG5ldykN
Cj4+DQo+Pg0KPj4gRmFpbHVyZSBkZXNjcmlwdGlvbg0KPj4gPT09PT09PT09PT09PT09PT09PQ0K
Pj4NCj4+ICMxOiBudm1lLzAwNSwwNjMgKHRjcCB0cmFuc3BvcnQpDQo+Pg0KPj4gICAgICBUaGUg
dGVzdCBjYXNlIG52bWUvMDA1IGFuZCAwNjMgZmFpbCBmb3IgdGNwIHRyYW5zcG9ydCBkdWUgdG8g
dGhlIGxvY2tkZXANCj4+ICAgICAgV0FSTiByZWxhdGVkIHRvIHRoZSB0aHJlZSBsb2NrcyBxLT5x
X3VzYWdlX2NvdW50ZXIsIHEtPmVsZXZhdG9yX2xvY2sgYW5kDQo+PiAgICAgIHNldC0+c3JjdS4g
UmVmZXIgdG8gdGhlIG52bWUvMDYzIGZhaWx1cmUgcmVwb3J0IGZvciB2Ni4xNi1yYzEga2VybmVs
IFsyXS4NCj4+DQo+PiAgICAgIFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9j
ay80ZmRtMzdzbzNvNHhyaWNkZ2Zvc2dtb2huNjNhYTd3ajN1YTRlNXZwaWhvYW13ZzN1aUBmcTQy
ZjVxNXQ1aWMvDQo+IEZvciB0aGUgbG9ja2RlcCBmYWlsdXJlIHJlcG9ydGVkIGFib3ZlIGZvciBu
dm1lLzA2MywgaXQgc2VlbXMgd2UgYWxyZWFkeSBoYWQNCj4gc29sdXRpb24gYnV0IGl0IGFwcGVh
cnMgdGhhdCBpdCdzIG5vdCB5ZXQgdXBzdHJlYW1lZCwgY2hlY2sgdGhpczoNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUxMTI1MDYxMTQyLjE4MDk0LTEtY2t1bGthcm5pbGludXhA
Z21haWwuY29tLw0KPg0KPiBDYW4geW91IHBsZWFzZSB1cGRhdGUgYW5kIHJlc2VuZCB0aGUgYWJv
dmUgcGF0Y2ggcGVyIHRoZSBsYXN0IGZlZWRiYWNrPyBJIHRoaW5rDQo+IHRoaXMgc2hvdWxkIGZp
eCB0aGUgbG9ja2RlcCByZXBvcnRlZCB1bmRlciBudm1lLzA2My4NCj4NCj4gVGhhbmtzLA0KPiAt
LU5pbGF5DQoNCg0KVGhhbmsgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0KDQpQbGVhc2UgYWxsb3cg
bWUgMi0zIGRheXMgSSdsbCBzZW5kIG91dCBhIHBhdGNoLg0KDQotY2sNCg0KDQoNCg0K

