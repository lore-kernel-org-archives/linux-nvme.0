Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F1DE68956
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 06:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cURqin1zDuZCvxPJc03hlZzN/s48cdE85AMV0zBIuMI=; b=eTiFbseorQW/NX1KYFXcCpr02e
	XsZ9HJfzYvxSCiMDG5Zh46+J1rSqMjLBqajL8Nn/YNEv2ec98OyT7C2Gd+c1iOXseTFXykMizNQR9
	wNIHKAewW6iHb7ttuXGMnLKhBbDfageh4CakR46/C+4XpM2NVAnNUSM69P6DH9Se7gETT3fzOw8zV
	ICokuzIi+gI9lWEhopGgFrw6wttsEgaMTh++1SCfYW2lq4RE0aAUgtbJ6SDBKFnc5y3yYPSAGdsCi
	bNUfzuVlDmv0K4peCScBAw8G983I66d0mmBvb6BnduiVMDM6LEUMjwOGK/BrudHKtmfDvYUs1CWcX
	rYvfquIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P0d-00000002ihO-23c5;
	Thu, 31 Oct 2024 06:50:19 +0000
Received: from mail-mw2nam12on20608.outbound.protection.outlook.com ([2a01:111:f403:200a::608] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P0Z-00000002igw-3t5R
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 06:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZhikSVqks2PSAzik6XyaBZdaf21ph8HSW5WNuma6bIXj3jUFw1ccxy7Ec7yGORvVaiD7u2liQgyLDB/E1+vehDj2+1zST2GPfbvaga2AJjCCx0EAWcOAueZMQdoDzmv1f6jOkBwG04AKvt1p9WgVaZvgd8y2x0PsI70xpFja5xZn0HSBdTwcjAmKhXt8mZ6K/xQRMS2tkBwDAK9jnfqRtyuTn0DlTG1sUP3Ciy9ujWdMuGquUIz6TvPjUTORShmuVN8VYcqmzP7fDZFEto0gX0/S2hW1xhM8NgPWkrSNym6A6rMaEhaG47NdKzsb5+ahIksWPlyYtLLPrF+ddE3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cURqin1zDuZCvxPJc03hlZzN/s48cdE85AMV0zBIuMI=;
 b=EvSKN4TiARKA1YmBPyYO5I6NcqTTUfo1yFeZGWhejiwtMREZ1Aqg7ZXNU0Bk92an3L//+OyZhFv97SBzJ/RvZx9sg8zOUXy9zDsKuDs/CXPTUsjdWpO0BjjJsjBbudq3TyrT2tPp0WGP7Ymt5WrdpGKORtaI9aM4XrTcZTkMLh5DyyRiiIXeEAH9SwzrZybUG7mhydxHi1e0aRXaXEnJMmX0s61KGnYmNXEXFm4NIiAvGM26CcJI7MYYPBQheoDqhPYrH6WkYLScc4Q2bCNaw4FZmWP2uE4btMt+nb1ZaVEvoRdFV9WHSTw4KHdrONpDcjKP81EWYmlZ0KdorNXyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cURqin1zDuZCvxPJc03hlZzN/s48cdE85AMV0zBIuMI=;
 b=cySM3qoWQs69xg6yG9dR+axbbZ2onkKFvuMK5tNTnhMlCVm2jWWPOUim4XL06YXj14crahP4GLnv/WE4rOrgBCAMGyGKyOHhVG0aqIl9YBoaQOS4CD/EOGruCHQlLrUtn4+uU0lWzlQ4qOsciyjKYySZfPiImclwfpbnIQndP8fCM9/DmY6CArnzqpbiV1Qnht5KaRK8AbNjxg2MILCl/S0NBDE9fLeIG5BVYURK/rV9aVPCCgSG4OiqjgUHeyiLhOBTcZEcyF5YBHDQjxT98SoCKagoBTdOxBV/y0bOWm7z0CtorUwQSOshtcT27fTfbCsou3A5Cu1+aCFyznuqqg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 06:50:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 06:50:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKzxw10tcCm/QC0SdqiaI6QyqwLKgZDEAgAAET4CAAANHgA==
Date: Thu, 31 Oct 2024 06:50:09 +0000
Message-ID: <019d19a4-cf4e-4405-8672-b371f116da22@nvidia.com>
References: <20241031022720.27202-1-kanie@linux.alibaba.com>
 <3cb63cfd-a4d5-4516-a2eb-7b968a036f7a@nvidia.com>
 <74fd4aa7-5d58-4493-a718-673143611989@linux.alibaba.com>
In-Reply-To: <74fd4aa7-5d58-4493-a718-673143611989@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB5863:EE_
x-ms-office365-filtering-correlation-id: a00fdf6f-244f-4020-c6e8-08dcf978433f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTBDNXNGOFhlbFZGb3BoMUZiN29DaURrc1FKTzdEU0p4eU8xekwyQ3BIY21q?=
 =?utf-8?B?QnhoeGd2aTN6enBuaE5pSEI4MG1CQmRIdGNkTi9PRFBRNFlvSURFZzNCWmxB?=
 =?utf-8?B?eTZEZ3Y5VDIray9zNGJyWlhXK2NhRENsOVRDQ0hrQXorb1JFZnlUY0hTZUd1?=
 =?utf-8?B?TzRqd1lteFl2cWFzVTRoSUNVS3BLR3NaaGI4cWhRK1U0ejA3VytrNnRxVy93?=
 =?utf-8?B?cENtV0hXU25GWDdqcHhzdGIzc1hGWFArWHRKeU94TWd3ZXBNUnIzUllMNzZV?=
 =?utf-8?B?Y21NS2UwMmxLSG9La3pDYVhkOWoyODk2QnVhNmc3NjVVSk93S0lzUWFOZ0po?=
 =?utf-8?B?Um1BL2h3cm9VdURRVzJZdUlBRlpob3pFZU1ib2Q1TDdKM1ZwUHNDeUErUXR3?=
 =?utf-8?B?eERPbGdZQnRNMng0bGptSHRVL1hnSG1RK1dLejJHZGI5NjZIMjJqU3FnVmVO?=
 =?utf-8?B?ZUducXRxaVVWd1k0Y2JDZC9VWERsSG9XMlpiUmg3YWNXaUhhZWUrTmVsN25h?=
 =?utf-8?B?b2R6ejBRNGlERzJ6WU1jcTNCNlA5anhLOTY1RS9kN2g1KzlNWVZNUVVzb2M0?=
 =?utf-8?B?TUNKWWxldk0vdHozYkVTQUd2cklidklsY2gzOXVyM3JaRnpvbmpLVUNINnNy?=
 =?utf-8?B?L01DMk5lSmU5RzJOMjZoS3FncmpYcE5KQTgyWjRQVUlSd2dwQzZwTFFFV2tY?=
 =?utf-8?B?NGFDRmR2SXBlOU14QWpEUFQ3eUN3NytNRVE0TlRBbzVlWGlKQjlTa1lPTXVP?=
 =?utf-8?B?aHgzcE8rR0VDWXE0eXJXRHhVeGpucjhEaHQzZ1duNTRPMnBDdkU4dk0xS1hn?=
 =?utf-8?B?SDYwMWJGVGFKbTNwSURTaVRTRnRPamw3bEF5UmhrY0tidktidVhMcms2UHdX?=
 =?utf-8?B?SEtHRmpEUklhdjNoWXhXclRIT0FWa0VBMmJWR0VYYXlON3FsMm15bU51eCt4?=
 =?utf-8?B?SjR5YWd3dDlZNjBYUlhnRS9ONE84NHFPSUcrYjE1V0M4RG5jeS8xMzhsK3Rs?=
 =?utf-8?B?VGhBYmR1Ti90U2oreFQ2NjNISURPK0VvYXc5Tld4QzhtVFFkdU95dlp4bDY1?=
 =?utf-8?B?ZlNKVEF3bXdYQVhTci84OHF0enEvRDRwc1hKVEk0YmZ6bzVkUlovR3AzeCtx?=
 =?utf-8?B?TGZPUElWL3RWQ00wQjJDTGdxWVp1YTBILzZhaGQvb2VnakhFakV4Z2c4amVY?=
 =?utf-8?B?Zm10TXJYUkIrVFBjUlo1dWtSbiszUmI4SjF3Nlhsdm1lTXRXaDdRazNpdXZ2?=
 =?utf-8?B?Y0NKZ1duM1JmS3FIUlRvaTRpTlIyK08zQlNPc0hvU2twTVdwbStNOVRmWllI?=
 =?utf-8?B?K3BrN3A3UERlL1R6dk56SzhROUxkeDhxeXZKa3hvakJ3TUdCMm8wUG45Vlo5?=
 =?utf-8?B?U2Q3ODR4TUVvcWpGR2FjQ2FsQjFqK3ROdDhxTWh4VEM5TGJoUGdkeU51dkVh?=
 =?utf-8?B?bFVGblZpZnBUTXJGc3BPSmlzeWlCeEJkNVJXN1FZT1BTSUJJeUgxaFFWUERD?=
 =?utf-8?B?OThxTWZrSjlHaE03UGMzWWtkQWJmcGFYQlArV3d0R2owTXFFNHhsdkpLQVlY?=
 =?utf-8?B?K2krcUdQSWcxLzZaTDBNWXZKY0FlTFdkYzZINDY2Z1EwVk9tb3NINDhSU3Z3?=
 =?utf-8?B?QVk5bUJ2T1ZMUU9kaVVNeHJNODBOdHJTcTZqWThKUVg0RlA2emM4dkFhU0p4?=
 =?utf-8?B?Vk0yWnlrWkVtVFpHcHdHNFQvemZ6bXUwUEcwK1NVbTk2d3U3aklSajlLUDkw?=
 =?utf-8?B?Wml1R2drRDFtR0NKbVVuYnhxMTRRQU1WaEtKSUh4Um5XV0E5eXkwYVdSKys4?=
 =?utf-8?Q?cN8D/0GTykgF+Ml5XwlxnYoR3niugoYu1uDWU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEJLNFMrM2RlaSt1a3BVYm1KK3QweUhmcjR2U0RPTFB6Y2o2RXltNkhDNXEz?=
 =?utf-8?B?bi8xYjBwVEZ6UnVjQ1JDaUdDZnQ3UGlSd0w5WlBRV0VMRXF5NFMzVUZVc3R4?=
 =?utf-8?B?QXhBeXJMWUhIUmZyZWlNMUxsUWloOXVtOUNYRTluYld6MFNFTUVVeGNFZjFz?=
 =?utf-8?B?dmd5TEJ1ZXhFcy9SQlZFTmFSSHZ4d0hBeWhHZVBaSXcwS3VRT3ZwWXpObW1q?=
 =?utf-8?B?azVwamN6bkpaVFJaT29MOTNkd3N6Z0lRSVRqc1ZXeHNjdjB6Z1doazlQR2Fh?=
 =?utf-8?B?RjZwYXp5Mi9YTzRrNFFTcldwYXFVRjV1bWRQVDlNeDJ2cFFyZU5CQUxmL0RM?=
 =?utf-8?B?em05WTV5WExQYllKQ0psRVV2RzF2aTA5c0RvK3VMTERCd0VDWXRJUTMvRHVP?=
 =?utf-8?B?OXVGdFQ0aXJnT2lLbzQrVUMxTkxsVGNmUXRTV2NURjBOT3c2Z2VrSnJLWlJo?=
 =?utf-8?B?SmVkdTJTTUpPc3o4OFQxODFTMmRFZnNFY3k3YnhZbTVjZEk5WU13bnJKbER1?=
 =?utf-8?B?L2lRQXhRMWxoaXM3TVk5S2V2NTg2aWNWWm1DVTJXT0YrWG53bUVWdGJzVmt0?=
 =?utf-8?B?R1Urd2hnSWVHeGtUTDdESHpmOVo2d1RUN2hCdXArRzlkOEo4ZU12eUNrTzd3?=
 =?utf-8?B?WmpxN2JSdFlsSG5QM3ZUZXdiVU5FNFJ4K0dPYndKbldNSjFWazhyY1doaHFZ?=
 =?utf-8?B?V0h3SGJab0JhMG8za1pnWXZrVGhpV0phdmlNVGEyL0tKWDlOd3Q1Uzd0VEpo?=
 =?utf-8?B?cGlCZVRBRi9zemdxK2MrZ29iamdVVjNlYVlpZlJHd09ma0U1MVZFSDRyWklz?=
 =?utf-8?B?aVBGUHhtWUlpSzF6WEVLcS9lS0ZUenJ2cUM4RExPNWl1aFcrUTRBUjhKblE0?=
 =?utf-8?B?cFNlRUF5azZ0NVp3S3cyZWFqaWdPeWtiWVdORjZxclgyQzVWWjdIUmRpSm5Z?=
 =?utf-8?B?QU0xNVgzNTJpYjRjN1I5YU9HdERZZEtLOGx5QkJPc1VCYzJDbXNaU2JFTTNX?=
 =?utf-8?B?dDlET1hEQVJpT2JnSkd3eTVycU12VXNFeVR6R3U2a2pURWVmZzVyL3hGcmpI?=
 =?utf-8?B?N3VHcFBzZDZxUjRCMzBzc0dMM01pWTI0SXlrM1o1NXdyZCtPcUF3VWdXd0c4?=
 =?utf-8?B?SFFoc3F2dy9RUnVUSHRENmtrbGo4Nk9BeFRqbjFDbkpPY1BvSUl4ekFMTlV0?=
 =?utf-8?B?YXdVaWNrYVdwY0hHKzhxSFBKNFgvK1ZnRDVaK0U4RzBQMzh0YTNBQnhMN0FB?=
 =?utf-8?B?alo2ejA5U3VOdkU3VmExdnhoUzZWL3JXZDBSc1draERub2NPQk43WWpZZllp?=
 =?utf-8?B?Sk5SZGx1R05JaW9oZGxGWGQ1TkxYRVVZU0tuR091VFhNSjVnOWxMMGZiUk9T?=
 =?utf-8?B?dENaRnU4SXFLV2Rmd1ZhclU0Z3d4eWNhM2t4bXZRcmFhdCtWL3Y1cnpRRDkv?=
 =?utf-8?B?SnZhei9TWXVOZ2F6amJ0M0NUV1NoZnNMUC96bGpXRkRSd0l0eFhDZC9aQ003?=
 =?utf-8?B?MllxODJMVnFwa0p1V0FDVGpOQTVpVzBpSTJXQzJkUUpnV3Y0ei9mdlBURWN2?=
 =?utf-8?B?aEd5UlU2NXJKdEVkb2Z1cjBlb3ZnTEo5NHpmOXRqQ1didC93QzNPcE1XS3Yr?=
 =?utf-8?B?Z3N4SkNZZ2dxL1Vla3daRUFJTGJkQWovU2NET0hHQ05wdzhaWWpsb2dCbjZB?=
 =?utf-8?B?emRqd0ZDSGZkTStrWjR0V2VvRzRtOHcyVUhBYjZ0UkJXMEJsamFGYml6dkRv?=
 =?utf-8?B?RVF4cXU0NUZZMnR2TXcyODdRbW5iUktkY2I5ekN2TDFkU3libmpmS0wzSm5W?=
 =?utf-8?B?a2d1RVRwekdsUWhodE1hWnR5bVhCUWRTb05TYkFLMXdGSnAxUjlyNmtPdUZ6?=
 =?utf-8?B?cGtFNklXYlpkdm5zaEFKY0VOeG5aOGJvZ3Ntek5DZ1pJcWlObk1iVndQdEJr?=
 =?utf-8?B?UmhDMnhQa2tuM2xBZXdRK05yeHVyK3p5YzBwcml1WjBOVGh6a1BIb1dLVXNW?=
 =?utf-8?B?Y1gzNDloeGpTcmFSQkVKdnJvSkl3YmdvNTFLbFhOOTBLb0ppS0laL0tJY1g3?=
 =?utf-8?B?bGNpQlBRR1VmN2dZUzIxY3RPaWZKdjdlN1FpaGpaelBkQ1FuRXgwRHVMcnRk?=
 =?utf-8?Q?dAUoed9FuD4DpDRVaeaB7NTow?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C41FB8A9C7432B479E08018C7DBBD483@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00fdf6f-244f-4020-c6e8-08dcf978433f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 06:50:09.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3eF/2GK//4CyLgeKC4tjbVF+mAS7c0DW+eHZUIVPJ1KTpwQ58V8dY+TI04G5d4kjlRg3G0FU6gEL5TQ2gDdkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_235016_010519_B4E98885 
X-CRM114-Status: GOOD (  11.59  )
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

T24gMTAvMzAvMjQgMjM6MzgsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IFRoYW5rcyBmb3IgdHVubmlu
ZyB0aGUgY29tbWl0IG1lc3NhZ2UsIHRoZSBuZXcgY29udGVudCBsb29rcyBnb29kLA0KPg0KPiBi
dXQgSSBzZWUgc29tZSB3b3JkcyBhcmUgam9pbmVkIHRvZ2V0aGVyLCAiY29yZXN0byIgLT4gImNv
cmVzIHRvIiwNCj4NCj4gImludGVyZmVyZW5jZWFuZCIgLT4gImludGVyZmVyZW5jZSBhbmQiLCBh
bmQgc28gb24uDQo+DQo+IFBsZWFzZSBjaGFuZ2UgdGhpcyB3aGVuIHlvdSBhcHBseWluZyB0aGUg
cGF0Y2guDQo+DQo+IEJlc3QgUmVnYXJkcywNCj4NCj4gR3VpeGluIExpdSANCg0KSGVyZSBpcyB0
aGUgdXBkYXRlZCBvbmUgOi0NCg0KSW4gc29tZSBjb21wbGV4IHNjZW5hcmlvcywgd2UgZGVwbG95
IG11bHRpcGxlIHRhc2tzIG9uIGEgc2luZ2xlIG1hY2hpbmUNCihoeWJyaWQgZGVwbG95bWVudCks
IHN1Y2ggYXMgRG9ja2VyIGNvbnRhaW5lcnMgZm9yIGZ1bmN0aW9uIGNvbXB1dGF0aW9uDQooYmFj
a2dyb3VuZCBwcm9jZXNzaW5nKSwgcmVhbC10aW1lIHRhc2tzLCBtb25pdG9yaW5nLCBldmVudCBo
YW5kbGluZywNCmFuZCBtYW5hZ2VtZW50LCBhbG9uZyB3aXRoIGFuIE5WTWUgdGFyZ2V0IHNlcnZl
ci4NCg0KRWFjaCBvZiB0aGVzZSBjb21wb25lbnRzIGlzIHJlc3RyaWN0ZWQgdG8gaXRzIG93biBD
UFUgY29yZXMgdG8gcHJldmVudA0KbXV0dWFsIGludGVyZmVyZW5jZSBhbmQgZW5zdXJlIHN0cmlj
dCBpc29sYXRpb24uIFRvIGFjaGlldmUgdGhpcyBsZXZlbA0Kb2YgaXNvbGF0aW9uIGZvciBudm1l
dF93cSB3ZSBuZWVkIHRvwqAgdXNlIHN5c2ZzIHR1bmFibGVzIHN1Y2ggYXMNCmNwdW1hc2sgdGhh
dCBhcmUgY3VycmVudGx5IG5vdCBhY2Nlc3NpYmxlLg0KDQpBZGQgV1FfU1lTRlMgZmxhZyB0byBh
bGxvY193b3JrcXVldWUoKSB3aGVuIGNyZWF0aW5nIG52bWV0X3dxIHNvDQp3b3JrcXVldWUgdHVu
YWJsZXMgYXJlIGV4cG9ydGVkIGluIHRoZSB1c2Vyc3BhY2UgdmlhIHN5c2ZzLg0KDQp3aXRoIHRo
aXMgcGF0Y2ggOi0NCg0KbnZtZSAobnZtZS02LjEzKSAjIGxzIC9zeXMvZGV2aWNlcy92aXJ0dWFs
L3dvcmtxdWV1ZS9udm1ldC13cS8NCmFmZmluaXR5X3Njb3BlwqAgYWZmaW5pdHlfc3RyaWN0wqAg
Y3B1bWFza8KgIG1heF9hY3RpdmXCoCBuaWNlIHBlcl9jcHUNCnBvd2VywqAgc3Vic3lzdGVtwqAg
dWV2ZW50DQoNCg0KLWNrDQoNCg0K

