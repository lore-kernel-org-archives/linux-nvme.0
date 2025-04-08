Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D1FC36010
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8eOkmCnPFcq9sLJPqwWGgVAihpClAffEnFE0JT4aQaY=; b=SWzU1AU64wCs+Kj8w7lXG7ldaw
	XkUwqfJgxQee8TVXfK+OI9wGvoCKytcJQo1iFsmRLNxMB8KKLggsLaTEljKqxXGXXx8eiv018d2qq
	vEAXAM0n/oBnyldTFobrYM1eewopYeSLxlTjfgq0NK3rN1p/+XYSmT4+gjv9y3Db9p8BMfMl9zXye
	EaCOZ7xHULY3NmCufHLREXk/6NeMYEHdqQqyve95cRg3kfIWIrQgR6Yp+ej8bAFnkRGqlr8JmzWQ8
	nr+ipPBidD9Y5rxgY5NACcOrPGT95iCp5eAeScMYXxVZSkerw7o1RefUrYx8JQa2iNNR/LNFB/mN5
	JsiH87Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2FzY-00000005Npl-3UCi;
	Tue, 08 Apr 2025 20:56:20 +0000
Received: from mail-bn8nam12on2060d.outbound.protection.outlook.com ([2a01:111:f403:2418::60d] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Fye-00000005NgM-3OSc
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 20:55:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioZD02Ul6UbNnasxkSlaVMbfmpWA5L7OjxgifosEOekw5pmahbMjn67lD5uMmcRPyhjw6J9bLVgXfAjUqKkIyeR/B/+mMyC8MzQnTgIv0QzmV+DOnWqfp5DzvFbo2/7yxG20SLmXxJFjBRrpmuoAaDe1Wp1ebCQqpi0Emz0s3IQdfqFwkpV43VMvDXfhGKg+xfdLkkON6K3xZM9VScOdMGQLN+PnDDxxGBGcHy8daBTFTfTHPat7Qt8I82+HBsvsCLlRQg6yJzOfcOowTu6eVId202dMp/p4hIjdpZYUCIxNTTK9QzDvRFfn5Bw99VkMsnlaWGor2PaVhTnmo6t1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eOkmCnPFcq9sLJPqwWGgVAihpClAffEnFE0JT4aQaY=;
 b=m1GvNdXeKrYBZ1MJDlQeOTzSw9vLP/j9eKKL/DNptDCk2K36q7f84QY6vD9NNiHQQeBykNLgCllnJrpGvMAj+Go0EM3mp7nYRx0bt6c8VLLKSLAwFLl0yGRKqBdZUaKV+v5s8mWAAe/NVLfM/xAoXn4kDrqzgtSH72tGG6lDVOqCgsg7dnQMa1oUE5aulv8QW6wXtAy6uO3B+G7Sw1yKZ4+/5pRIN4bYAIP8zGcLO7et9dGhC42NzRwNy0UeH12dDEeSyK53EK/szwCNZxFFuszgCsrlTAOOXzHfly2i6DDnlaBHZHC4iVqhmp+rrujeJehOqMiiLg8cDQSVyRw0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eOkmCnPFcq9sLJPqwWGgVAihpClAffEnFE0JT4aQaY=;
 b=CS2zTaqXUCdHjMW3C3Drw/Tk6IISn+mM2ajJJHYUww71N6s+EyzO/u/fVGaF/iHDGI8+weE9RMJ2XSaqJ8UOVyxkeqNMzf2A+O/36OMYZWOjHkpObYEMyVKSsjq98gqzewerkEMXoODm+DzKdGvtYmcn3GMSRtw3kmlSeY1AiYaKoBH96O7/AWC401cThop4bwFcVaNMbND1Vm8JEKZt9sDjareLphOO/+2lJigWdEvUgaZ9+So+Q9i9fKK24optCrbeFGM6I5rZdlXEqBg9UCCi2sFhIoPnuJZ8SW6iBSqUxDofszY230fWE0UzTZV7HSywuCAcb/0mO6EmfCtPaA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 8 Apr
 2025 20:55:12 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 20:55:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Steven Seungcheol Lee <sc108.lee@samsung.com>, Daniel Wagner
	<wagi@kernel.org>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests] nvme/025: use character device for nvme
 effects-log command
Thread-Topic: [PATCH blktests] nvme/025: use character device for nvme
 effects-log command
Thread-Index: AQHbo6IlXWOxJJ3F4EeCl7RaMAfSG7OaScWA
Date: Tue, 8 Apr 2025 20:55:11 +0000
Message-ID: <eb6ac214-a7bd-4578-9502-ff81763170c3@nvidia.com>
References: <20250402073727.395179-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250402073727.395179-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB8431:EE_
x-ms-office365-filtering-correlation-id: f88a626a-cc2b-4fda-59d1-08dd76dfa7be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NUh5ck5GQjlXYStYR2J4VE51ZENlMDhaV003MWJjY0tucXlDd0NmWVBoenB1?=
 =?utf-8?B?UTgzekN3ckNteG94UzExN1lTZ05yYU9kekpvZjVSN0haK20xS3hMaDU1VWlE?=
 =?utf-8?B?dVQ3N0hLZE1PR2kyR0JwVGhobnNtWFlpa3F6NTFzVUwzZU8rMG5jQ21uck9j?=
 =?utf-8?B?RUpOVUQ4NU9OMTV3WXRWUHJJaDk4OEhnUmEyQ01XcHBhSzJhUWN0V0hoNFNm?=
 =?utf-8?B?MElSRzRMRmR6NUhRYlZ5Ti9XVDhJak96WnRqek9QUHMwMHVhTG9CZWtCZlYx?=
 =?utf-8?B?MkVGS1VkaGwwL1VnTUJBM2lYQk9hVmFqMU5CbjJTR28rQlc4MWdWZXBIY3E4?=
 =?utf-8?B?Q3kzOVhxZVlOODhoT2lab3VwWGsvTlFHa2YyV2lEUDZRaDdlc2hKUXAwK1hR?=
 =?utf-8?B?N2VoZXJKOEJ4cVkzdEdWVmx6eCtScTAzSy9oT0tPdHZyeDRZckhuQkhBOWEr?=
 =?utf-8?B?UXNCR2ZqSHEwdk5UdzZ2TXJyKytHS0lZcXhDbWNXUDVILzFsNlRVUGlDdVd5?=
 =?utf-8?B?MGtkQmlZUS8yMlBiUTVaVVZ5VFhzUFlWazRkUG1hMjA0Rnp4YTdQM0FQV3VD?=
 =?utf-8?B?NGVOTGQ3Y1NWcTlpTGRyaURVOUcrVVlSK05YU3FpQ3dwYXIxZllLOE56allV?=
 =?utf-8?B?RFoyVjlGYThWN0FtNlAwYm5UNkdud3REekJZUDgwZkR0R3VzZWFFNU1UeVZm?=
 =?utf-8?B?UHhwclJOZWxTS2JJTGJpanVoTG9jYm52c0Y4T3NUcWU4ZWRGWkIxa2lsV3NS?=
 =?utf-8?B?MlcxT1NoaFRnMUc2SEZacG9WbzBZcDZDM0srZGh2bVJxcXlaZU5IZkdDc01U?=
 =?utf-8?B?elRsbUU1b2tacUJnQTlCZ1FhdWpOallvS0ZScVhDZXZEazJ3MXZLaWJXeFlC?=
 =?utf-8?B?aDNwT2YyNy9qcm50eVBlWHJrbUFHSjg5bG5KTEVmRkc5MXAxT3NVbE1BRXhj?=
 =?utf-8?B?QXpDa0FhR2JtL3NJZ2tZZlYvQ2Ixa29vSW5zMnNGUHlYblBheEJLWEs1elFm?=
 =?utf-8?B?WHFPRVo5R1hXa0RsRTR2bk1kelZ5ZWhibjBlNFFYZjk2ZlpJb1VOV0Z3bHQz?=
 =?utf-8?B?QXR4Z2c4V1UyZHNJZ2krRHhEUHM3L0FHZWlVcEJmT21rOTdiVGR0b0FjdTBR?=
 =?utf-8?B?YkFLaXlDTlY5K1c4QlJUNDVLQXJSK2ZFbDExcmJvbmlSQ05ycmtPc3g2Vlo2?=
 =?utf-8?B?RUpsK3NNTDVoME5GSGNhVkZsOFZWYW96VlhvQzlvLzM2QVlxeVpOb1JudTRF?=
 =?utf-8?B?RjFWanFiaENSbXZoOVBFU0xCK0ZjWlFIOGdhY25CVUhqTmVYVkorVWVYUG9t?=
 =?utf-8?B?ZXA4Z1ptS3RtOFBhRmNzdzFVUGNsODlkRkRGWnVJeHpab2ljOCtGZTN3d0hy?=
 =?utf-8?B?Sm8yUVE3Z3dpbU05YllTSmhkK0RiUHlheW9MWVpwWTk2eFk1ajRGY2Nsenky?=
 =?utf-8?B?RmdGc2V3dFJKVXpZNkhFcDBUbDhhek8yaUxQTHpScURubk8yOVpCUVpsbmlB?=
 =?utf-8?B?Y1lSaXdreVFqNDlKRHBCRElaMm9FL0ZXK2Y2S0pJc052VGZMeTdaTVBQcm53?=
 =?utf-8?B?QUI1UTNZUkV6UnBDbDJZRlNlcjJobHJYUU51RnhMK2xxTFZSc29xbGZtNm5S?=
 =?utf-8?B?Rkd6ZlBzZC9EUDNVbFNpWkMxVDRhQmF3dVlOQWhmNTluQ3NjamVuNkx6elMr?=
 =?utf-8?B?ZXplR294ckZSd3piTUpzUWFnM2FHV2ZlRkxEc3dHZ3Yva00zbEZHWDNaK0dG?=
 =?utf-8?B?Sll2RFFkY3dBb2VKMndneW1YRExISmE3b2s2aE1Ma2MxWWFBdncvZFlWMEhT?=
 =?utf-8?B?eUxKQXkrQjNVWkc5akY1UEhFOXgvUmRLUmFhYUQzSmY2N0xBbmp5UGM5aWR2?=
 =?utf-8?B?M3llT0xiZUZMakRKWXNET3R0bjlJSk1JUHMzdnNUZ0F2c09wbDhjWXQwcmFE?=
 =?utf-8?B?SGZMY05uc1JPRVZyQm1ZVW5MV2trUDU5RzZzN2N5cG1rU2FBRnZwdCs2Y0Vp?=
 =?utf-8?B?U1VTOXMyOWZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUFpaWkvYzJqampiaDZFbjRVTFhxdjdxZU1yMTQzT2xEZStHSDA5Ni8veFl4?=
 =?utf-8?B?S1pCTWYxTXRTUzhrS0lHZ1pBSkd0WFcyOG5DT2w0SGtWVmFEZjcySkJxVDRO?=
 =?utf-8?B?UVZCOFY5dWhZaHA1enBTb3BTUWFMOXhKMWNyOVhzU1l3TzU4RldIb3AzbkJt?=
 =?utf-8?B?em5NUUJxalJYYVQ0eVdRYnF3TllCZkxSZkNQOWFDV0FRQnd6T1A1MCtwb2Jp?=
 =?utf-8?B?YVppOXpEenJjSDZXczVKZVhua1FBQ29OWko1cHovYWlVTStYcXlocXBXQkdU?=
 =?utf-8?B?MzE3L0pWUTFCN2RMWlhwMTlQMVRLRlVEbmJidGdSaFFEQW1lN3laU1lZUm5v?=
 =?utf-8?B?Q0hOVTYrTjI5QVZIVjVmeUZMZTVyL2h1Ni9kRE1Bcm9neGlXVzBRK3VyUERE?=
 =?utf-8?B?ajNOSHpjek9ERmZ4L1dSUGxpVlFhTjZ0bUI4S1lIVWkyb0hFRkRDVGZlYzVS?=
 =?utf-8?B?aFhDckYrcGxya1l1TFcvNXYveVg3UXN6MVdkWWUyL2llWStrOGY0Y0RTY0p0?=
 =?utf-8?B?T2docUNkZWp1WEpLUkcxSXc0Rmk1LzJOV0VhWUY2dkk0YzBnRUNxeEg1NlpJ?=
 =?utf-8?B?U25abEVLWjh2VlRURDJNWXRVRzV4RXVCdlpTWC91YmZkdFNMVkZyTkVBRXJi?=
 =?utf-8?B?Nmg2aE9FSHBHNGJ0TlR4VXJPVW5zc2VtYnFrV3hKS2JwNnlTakEyTFBua2pX?=
 =?utf-8?B?ekM0cldlK3FjdU1HRUNvbmxadUNmZ3hVTTBMRks4eFhEY1J0cDJUd0x2MWdT?=
 =?utf-8?B?SFlGRThveE1zWmZaMzlydmxGRk85UnpYUklsTzhGdmZ4VGtlVzhzNzN6L0JH?=
 =?utf-8?B?SHBBdGJDZzlZaVpFN2VmcmhjSThGUk01elNTYnR6TU1rRFBQUTV3N3BKZktN?=
 =?utf-8?B?SVBCZi9YNENHbkpVR2lwWU1vV1hzZjRnVENRTGh6ZlNYQk9pOGN0dzZiOTlM?=
 =?utf-8?B?LzlQL1ZzSlhmUC9GVFRjWHl1WE9NcTlVV1lsWWlGWE5PNUFmQTdpTWlhWSsy?=
 =?utf-8?B?Mlh6cnEwVjdlM2hDU3BWRjcyUUdaYzkzMmoyeWFZNXlzZ2g0RVJzY0dhUG42?=
 =?utf-8?B?QUNlcU8vV3pZOWlzRnB6c0pOSFkxN09yQ2VOQmE2YnFKYVV5RzcrY3E0K2FM?=
 =?utf-8?B?cGFGNC90QW8wbDg3MGtBcWp0NXJ2SkZoMmFIcGZaT3FaOHlMR1lEZVA5UnFI?=
 =?utf-8?B?bjFRc1RNSUZFa1RHQ3NDem9PcHJJVDJHT1VsRkpCdUllbDZBUm1ZSjRMVFpw?=
 =?utf-8?B?TGxuenM3SW03VlNrS3NCZk5ReExFRU1zU25PaUViUjNEQlgvektRdENPT3hj?=
 =?utf-8?B?RjR4bUcyNE0rNWhpUkFhMHRQQ1h0eEk3eG1sVTdneHBRckxrTWZQUTRRU01B?=
 =?utf-8?B?UlR1bWhJZk5MTFVmdFFOTEY0SUcwb0MzWlZDeDR6SU5wWEhVQmcyeVdNUit6?=
 =?utf-8?B?ZjlPNzE3NTlOeW1XVlo2VlVoQ1VvWUdTV2VRVWRzUVRuaWpGdEtIZVFRZHFk?=
 =?utf-8?B?OUhsUmhGSll3L0o0bU1zbzJLcklzS2tkRzBXR0ZzTlhYLzBuQnl1K2pPcDZl?=
 =?utf-8?B?aFl6UFN5eVFuWm9NbUI1UStKVkJmQTMzSGxtVmJOVzVyaUF5ZnVGc3JXZXJ2?=
 =?utf-8?B?cEkvUFhpeFcreUlUcHRVYytUVkYva2JvU3cwRzVtcFVYREJkRHNQVmp1cVdX?=
 =?utf-8?B?UWNBWHVxUHBMakEvSzhVSVh4ai9tV2hmOThiOU1WTTVSN0NUdFJGWmRRVHhl?=
 =?utf-8?B?RnJtemtFY1NZUXNRbFdkNzZGd2UxcDRhVm1HeEVQeFc5d2Z5dkJkcVV3Wjlj?=
 =?utf-8?B?NWtHM3VhdFZFZ1Y5bHNzdUlPSzNUWndNREp1MC9TVzB4S2d3Y3RhaEphSnZG?=
 =?utf-8?B?Wkk1UFVmMDFCYTBJUW1LVko1R1JaUGs4d3NHYUhuSjFLSVFvMDZPSVZpWkpJ?=
 =?utf-8?B?RHZ3WDBabFJwQldjbitaSHlUakVQK1JCdE9wTk1vWG1XcHJUdXNWbkRsUVRR?=
 =?utf-8?B?RUQ3LzQ1THJHTHBDSmlVbjdRMlI3ZjNJMGNlOHI2YndRZk81WWpvbFA4YURM?=
 =?utf-8?B?TlZDNzVWcHBhcDUrMzRwZy9CTGlvN2x3bVRvYTFlOW9qdjQ2cmNBWmt5dDJl?=
 =?utf-8?B?amxhMWdXZ1JYazQ0T01TVDZ2Qk5HNE5TeVk0NkVFQVV4WTRGWHc5cDhyY2NK?=
 =?utf-8?Q?BzDWnTGsgzJCJ2675VYhXeSyO0zHaFmfvzZgNEl3jpMW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53405DABBCA5A7449FA426F00FF67A57@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88a626a-cc2b-4fda-59d1-08dd76dfa7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 20:55:12.0035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSvs+Ze033r9eS8MNeLyV/EVKK3sqh49ocw/KCA/r5zrfexj1RlBS2wzUMkgydiTKeDoQJi4JodaGJxSTbyTQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_135524_848170_9F778EE6 
X-CRM114-Status: UNSURE (   9.87  )
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

T24gNC8yLzI1IDAwOjM3LCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gVGhlIHJlY2Vu
dCBudm1lLWNsaSBjb21taXQgYWVjODVkOTZlMDdmICgibnZtZTogYWRkIGVycm9yIG1lc3NhZ2Ug
Zm9yDQo+IG1tYXBfcmVnaXN0ZXJzIikgaW4gdGhlIHZlcnNpb24gdjIuMTIgZHJvcHBlZCB0aGUg
ZmVhdHVyZSBmb3IgIm52bWUNCj4gZWZmZWN0cy1sb2ciIGNvbW1hbmQgdG8gZmFsbGJhY2sgdGFy
Z2V0IGRldmljZXMgZnJvbSBuYW1lc3BhY2UgYmxvY2sNCj4gZGV2aWNlcyB0byBhZG1pbiBjaGFy
YWN0ZXIgZGV2aWNlcy4gVGhpcyBtYWRlIHRoZSB0ZXN0IGNhc2UgbnZtZS8wMjUNCj4gZmFpbCB3
aXRoIHRoZSBtZXNzYWdlICJCbG9jayBkZXZpY2UgaXNuJ3QgYWxsb3dlZCB3aXRob3V0IGNzaSIu
IFRvIGF2b2lkDQo+IHRoZSBmYWlsdXJlLCB1c2UgYWRtaW4gY2hhcmFjdGVyIGRldmljZXMgaW5z
dGVhZCBvZiBuYW1lc3BhY2UgYmxvY2sNCj4gZGV2aWNlcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
U2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gLS0t
DQo+DQoNClRoYW5rcyBhIGxvdCBkZWJ1Z2dpbmcgYW5kIGZpeGluZyB0aGlzLCBsb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K

