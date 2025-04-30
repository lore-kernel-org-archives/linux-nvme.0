Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B07CC369DC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qMtUFanQDgQPv+btu7JkFJGALS5U5PXfx+g9aZJ7CMY=; b=MxLZUi9jUwovfXWgc8iCJGJCaS
	aoFNZFXj5IwTjHrXq7oiPJ00Xr9U25BmbyHQgWYdZ2+fZ1CsavmL5nJv0zot2KkI1QYracUbuCHav
	9jf8bV68mT/ML3nVIG1MZw0tQ7RDow1BgS2Ej9iN2csdSeg7gUUkdpJGUjPfKlhZIivlVKiXhYAwp
	FJfX8i5D/wBptlKs3TydUa+yoXqD8CyomMgvYSgLIjnwYe9x0Gbp5kWRf+wCoV+o0E9uZNTqWRiv7
	l2b8XPTIsQy4ODQDgqvaTE2Tj7DkdhNXTBKkMtNp+DWv8UyoUgxQNBPeTKSJMTyQDXF1qCOWxo4SZ
	k85XzNPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9vZM-0000000BMk5-2aFZ;
	Wed, 30 Apr 2025 00:45:00 +0000
Received: from mail-dm6nam04on20617.outbound.protection.outlook.com ([2a01:111:f403:2409::617] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9vZJ-0000000BMis-39ux
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 00:44:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyIFdVSnJg1Q9ro5SEiAtY/oj3HD+oMwhLMk6Jv+tOVMbPP1r+9Lg21bV2/TXE+BNCXQ0v9dCxIdx8kQ0I+3r9cSfU5xmnDep71JmDrOLX4N2C24S2i3kHvfBMy5XvfOVBAJEQ2dSIO+Lfafj/WY1nGaNfNmAdGNEF3rNfACwbOhkUi+ivZB0MTsZSHcuiyqx2Sx16O7Pb4yCm2tiGo09pg8GAWBuRQG4RbWANvVJOMSklRRrDTDDruYoqwlul3YOZvMAsdbQ3XJMk/8F0/kRzxoOqIDTtuaqbYiYbrp5AOBR6/kZMvBOHcYwcOPc5mzW9KoTSgRgC9OhHgwvlXkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMtUFanQDgQPv+btu7JkFJGALS5U5PXfx+g9aZJ7CMY=;
 b=EBjXkDnqChbblyEzR2/Zlk8ztrrf8dfp7nsylWk9ROv1TOtEhjp+ChzjgJ26aCF7ZH0/Lvmu2KkU0pz9nPG6UlPwvJLaqtX/JYLWl915dPe30YpSavSFrExZxjZ/Z6exb+zUhGfKRhHmRJx4C1XQ1HgVxltq8cpjsvFlr2YbsnRu2QXgflKNBYDTadyyxFUUKLC7Hwlqr/HBCEgwAGSW44fk2krqQBzxNeFv2rUdwI6CfkWZpVmv8BLgRFHvvGdfknMD24mcXnUL0b+fFg/GvJOiKIkxdUBZe6jCCpPyso2TYinHkC9rQm2P1sEJ+zDNExgDbgt9zRgZJ5/+58x9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMtUFanQDgQPv+btu7JkFJGALS5U5PXfx+g9aZJ7CMY=;
 b=Zw49pK5KpPAggGkoarasMVKT4ezFGNiKXD5H7zQ5YMDHKRLxbPcM1jk92AARvTvPNZ2SXw1WsnkSF9tAbqvDFfOk0w+4M57+5nvlZQ9ll8df9Bi3UE10KQUIm42krUUziYynofwGUQdKP6jBWBjaBvZlYLy1MWt9i76+YnqzjEKvBubeDslPCIi1ie4hesyVWQFQPSeQLb/r53u9Dsb6XD6dWc7Nw9NYRnEclpgoDKlqXpr2HQAc2NabZhRtlcf+9r9IVZhMvefnf8GEnxhHECzwmpUwXWwakI+LI7KkYY26qRgj9LBNMHIOg0pZVaswjb8V8fk1v6QqOnwPJaF0gA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 00:44:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 00:44:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alistair Francis <alistair23@gmail.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hare@suse.de" <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme: select tls config when tcp tls is enabled
Thread-Topic: [PATCH] nvme: select tls config when tcp tls is enabled
Thread-Index: AQHbuVfKhw3G85ZUT0am74OLLcLKLbO7X3qA
Date: Wed, 30 Apr 2025 00:44:52 +0000
Message-ID: <34debe52-8385-494b-b15d-9af7c1508e2e@nvidia.com>
References: <20250429224025.3077488-1-alistair.francis@wdc.com>
In-Reply-To: <20250429224025.3077488-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8706:EE_
x-ms-office365-filtering-correlation-id: 3d849abd-584c-4142-2a8a-08dd87803821
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N3o3NGVzb1BiV1RqSWU3ZXNJcW9ETHdNK3d4NWorVUZnU1ZUQzBJRTJNNVpR?=
 =?utf-8?B?Q2dRQWpITDlWMGNsVUVNWENoNlZTM3BPR0E1N1dzUHh5cmkrMnA1bEhXRGFa?=
 =?utf-8?B?cUM1eCtNQVFBYkpsZjFsK3dIbFB0TzlFdkJCY29GUG55ajkrUFUvNG0wOXB5?=
 =?utf-8?B?Sk4zTDBkcEV5NXpFaHRWU244ZmhMUXNRZDFKRGNaRUVBY1VjamJjNmYybEhE?=
 =?utf-8?B?U25GSjBnVlJNbzU5c3FkalZ4bThRbDVTRy8ySmtBQm9hSHlSTjEzMy95UXdL?=
 =?utf-8?B?M0h6bThLTVB2RVd1eXl2ZkcyY3ZDa3pmMWw5aER1RVEwdXRJbWtqRmJSa0Vh?=
 =?utf-8?B?K015aGRFcFI5N08rdFFrbHlSK1lYL3ZaUDJtY2k5RkRDUytvS0RWeXB4RkQr?=
 =?utf-8?B?cHpZcWJoeitMdkNiT0lLN3hMem9lMHB6TFRwMGJHaTVIRTdyalVjc3ZRMERP?=
 =?utf-8?B?VkN1SWtOb0VKdDk2OGxCUURKWHArRVZrZ1FXK2paQkdBYnliWGpvamJhZGFZ?=
 =?utf-8?B?dkFqcjVVaUFlTGVYWFQyMExsbFZ6NWg1ZjdnZ3VqbG8veVRzWmJSdldMV3l1?=
 =?utf-8?B?Q29NVnhmM2wvdm16ZjNXV2pNdXRlWTJOQzN1UUhwWkdkc3hLZkdHUlpsMzBP?=
 =?utf-8?B?eHR2a2Q2OGtKZzhZN0VZVWs5ekE3TkZ1SjBGbkdEbUpXRFVKNUVmbFBlSzQ3?=
 =?utf-8?B?SFJiN0Rlc0JPNlcrTWJlTHZ2YkxyRjhCZFdhUjZRb1NPY3BWTmpHQmVDMVNu?=
 =?utf-8?B?cy9IaCtGbEl5RCtrREd4d1NrUjNhT1YxMHh4VDFUMWpkVU5hVEpuV0dySkRU?=
 =?utf-8?B?TXdaVGdyVDhvcmR4QnNDSmFOUUNzZ2dqOXpYL1BiR3F5b0RUSFByVjFqdFRW?=
 =?utf-8?B?eDQ0MWhwbkpXVTNBQzEwYjF1RG1kU2NZVXFVZzN2cVV0UzV0dDEwcjJpNC81?=
 =?utf-8?B?UytqYWJ5bklqdEdxL2NlYTVzai9pYXdzd091RzZ3VmVmMS9Ta25MUGpGS1ZO?=
 =?utf-8?B?OUsrOFFhQ1R2MS9PY2tNZTF2YW5CeUdQQXEwWVJQc1Z1bVFGVHQ4Uy9tbC92?=
 =?utf-8?B?ekNjWUMwV0VLb0dqa1k1eGU0UjhRSkFkaUtOakgvZGU3S3BtSUNqRTBKMFNQ?=
 =?utf-8?B?Y3ozQVJmNzJiNjl2eGJUK25uOGlsdmpZY0lLWjRJS3FEeDZ2ekdXSTd0NzFS?=
 =?utf-8?B?WVJHbUhLcXF6cDl2ZGF1Wkk1ZUEyWklxS1llUnJIUXFSVHl5UlBtK0REVXRM?=
 =?utf-8?B?dlU2NFUwYWdJbGJQQW1FMTFVd3J2aEdKNVREOHo0Ungrcm1OTGZMZkFFR2Yw?=
 =?utf-8?B?QVZPZVhpTWRrSC9TaVIvUnJwZzJiOEJKeTRuRWhpdVBiQ1NidTk1UWkzU3Ru?=
 =?utf-8?B?ZzNmZ0pTc2d5YkZyb1M1MmtPWmF6dXVMRzFra0dwejM0VDU4b1lVeHhqMC9k?=
 =?utf-8?B?aDhBY3BvVFRkQVJlWHJ5RkFwOG1RYVorTjFkOC9sZTBGSnRyZ1ZDZWtaa01k?=
 =?utf-8?B?UXQ0emlIemg4Nm8wcUF3aXNjSVliaE0yaEtXaVltMGJBSjBTS3JVVm9tbVEv?=
 =?utf-8?B?ZEZIV1dkRVNZUnZBSFYwSFV5SWlWRWZBQ3gvZUdDSjY5cjU4dGRucG9rMUhP?=
 =?utf-8?B?ZzBtM29sVWZmY1hXSDBMYTJzMC9FdzVFdy9LeCt2cjVQeHVQWVRUUG9OZlIz?=
 =?utf-8?B?U1lpWjhSWWtTWmdUQ0pnY0FOUXl1aXJhc2tMVGgzRUVzOTdjWVRDWWV0NDFw?=
 =?utf-8?B?R0ZwUlJzYVdrR1AyUkZrNE1tYzlaKzNZbHJ4VDRmcFVJWDdnNHduTENmYWJT?=
 =?utf-8?B?ZjFVOXk0dE8zSE43bFVYVWJEYWs3QmFWOWpQeXA2VXU2eUhiS0xxMmFXUTNR?=
 =?utf-8?B?dUtVaHFlM3U4UkNocStibHdwenFNLzk2Y0ZnZHI0enB1Qm8rM01mVHBqN3hj?=
 =?utf-8?B?aXF4T3Q0RFd0azNmbFNXczJUVlkzUndaRWdmR0xacExYNmxCNkFmTHBwUlNK?=
 =?utf-8?B?VGMwYTJxRFlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGQ0ZVN5WVBFYnFhV1pJK3hWRjI0QnFRdm5SMHNUcW16Vk1SZzRtOVBlTSsv?=
 =?utf-8?B?QkdlYlozVFNRRmtnRHNlSS9SeHdtR2xTMllzRmgyZmNtV2dRSzdxTXJ3YlRx?=
 =?utf-8?B?YUswdHNKV2pzOWRweUtHUVg2RzBCQVhQUVRnV21ESnBCUDdUR1NYUXR0MWkx?=
 =?utf-8?B?MEZib1NHN1lUMG1lNGR5K09qSEo2UFU3L3hKZjNEbDlMNnlMUW1tMlFiQi9Q?=
 =?utf-8?B?TndtRzBoQ0lDWnduR1BueUdxL1F4bkh1emhvNkQyRWVqZHlCQ3dxeVMrekhF?=
 =?utf-8?B?SlhXRlZKYTU3N2h6Q3M1QUxzWDhYV1g5dUk4aWRRaVI0a2pqcS9WV0kwaVJV?=
 =?utf-8?B?TEdJdE5LZjlBay9EV081bGRib2IrVUVYbEVDU2crQ3dsSFZHNURHNjZlbWw1?=
 =?utf-8?B?STgvRkpzVmpDcm5tamVHS0RqcW1UQllXbVBJRTZieXZNaGl3OVpBeUFJNGJ0?=
 =?utf-8?B?Q2lMTVFydmZkZ01oeEZVMjZ1Z3d1VC9UV1lua2Z0SFV1UW1wTHRTMXY3N3kz?=
 =?utf-8?B?RzFwbEhMV3RxSDFUUEtEbHdQU2Q0NDNCZUxrU3EzRzU1RDRnR3N6azZkL1Va?=
 =?utf-8?B?S3RkS3dTTEdlVEx5UVUwV2VPV2hvRHd1MlM2VUxPajV1bWhmNlFUSWQ1UHhZ?=
 =?utf-8?B?T0I3S2hHbHV0KzVTQVpzNzQvbGZ2SG1aOHdCVWd3aTM4Y09pVlBhaFVQdWlj?=
 =?utf-8?B?M2lGREtTTjJvaVNUZ0tYNUR0YTR3SWRZNmZCL3RGem9mK2dhU3ZvYzQ3QzYr?=
 =?utf-8?B?dTAyWHhXVGcydDVTVUJLTkNnNjR0Nlc2NnBCUVZoVENDWEdSL2FWcDZ4ZEor?=
 =?utf-8?B?ZE5NOExaUFlVUTJPclViTjNsUElSNkxpN1hMTnpRdFNqYnk3ODVHWjZLY3k1?=
 =?utf-8?B?eVFBRFFHOWg4YVdKdGZXYVk3RzB6bkRJWmpUMjZBS0NmTVFZdW9BTG83UnRL?=
 =?utf-8?B?Q1MvS29uSXJINGhjSWFMR0h1RzJoanFiNDNnN05oS0wxblhvY0hDbWZKNUZW?=
 =?utf-8?B?OFdqcyttUFlwOExQL2U3VUwyZzFqRUJkVmpSYUlVLzlVakhpRGt1ODVIODM2?=
 =?utf-8?B?RGVhY081UzN2dWUxa3VlOFByUUk0OG9zVHBzWnd0L3V3alVONkxGcUZ2REgr?=
 =?utf-8?B?ZnBaWEtaRXd3WVRXRzZqRmx4YlVqbnQrU3Z3enJZRGkxUkE5ZHdlWEhwTEJH?=
 =?utf-8?B?WUxhNUc3S1FOT1ZOZXdxTUw2eVhadVZ1cWdZSHF2bXZheXlSUklqc1lRUFds?=
 =?utf-8?B?S0JoNk8wWUIycjgvTmhlYURQR3gvRStFUmJXZWZSS2xNNkpSd1M5Mzk1eUs0?=
 =?utf-8?B?cXFMY3Q4ek02QU5VM1lhandGcHhkY2NxSXY1YWtoUFJaKy9wQVVIRE5OTS9z?=
 =?utf-8?B?RUpwSHNqaEp2WUtKcTF5TUVXU0UwQmtrOVBXd3QwZnlxLyswSUt0dS80TCtB?=
 =?utf-8?B?Y3hFc2g1RmZXSTNCZGJpaW1uQWJwMEUwbGRtMVBsQjczM2kxWUlSSzZSc3lM?=
 =?utf-8?B?VHhJM3JkOHJwa0pTeHZoamU2R3pHZDBOTUp4RlFsZ2NjRlZWQVltQWRtL0VE?=
 =?utf-8?B?VWo2QndUZnQ0UWZDVmU5MVRpekhtUmhOeWJOVW5WQWNuN0IwQVk1N1lyaFZp?=
 =?utf-8?B?aCtiVS9kTVM1Rmt4eVVXMVE3UGdNYkZTRDhuQ2xWZi9tcERUa2ZyblExekcv?=
 =?utf-8?B?ZGlHTmYwMGxrS1dRdldCUnJhQkx3dWh3L2R0bkE1R25QSVF0dEJpVmkxQ2tY?=
 =?utf-8?B?cFRLQUZDZTFoK2pXR1VndWlzMkE4M2FvbUZlUGgwZzFGWlNpTWFHenRJbllq?=
 =?utf-8?B?bjJ5SllsVERLWFZKT3JlY0JaN1RZdmJlREt4VEc3QkF4czAzc2VwMGxyY2wr?=
 =?utf-8?B?a2xzcm5HaFZvSnRkZ3VZVFF4TFVNcHBUaG5wU2xyTTlFMllhRHBpTXo1OHpm?=
 =?utf-8?B?Yit5ZERPa245bEtiZW0veE5SQ0R3a0FVa3BHVW9GMDU3dTFTTEdGcWZsKzI2?=
 =?utf-8?B?UWdmakMrYTFISVdDMmFINUtiL3FYeXNyTUdIRDJ4bThra0N5ZFMxdjFHeDlu?=
 =?utf-8?B?b2piRjRYUDdxZHNKNHkwMWxkMi9XaFRKZll1d09EYkdKSmFEVDcvNXJ0NkZJ?=
 =?utf-8?B?aXY3bk1XSkxOYnhBWUtnK2dlL2VIZ3F3LzFvY09oUU8veTVncnRSZWE0SE15?=
 =?utf-8?Q?ykbFJY5VCDhEbGQuGJzOEvqPoiaSeJEBkSCAe+XYq0Oc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD19E4D5DED9494BB6FC5F7EA3C66C2A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d849abd-584c-4142-2a8a-08dd87803821
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 00:44:52.3321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkFj7L73vQd5KgeD0vPutivdrv1OXPuplgk/HWSUUL/oJYUbUQT0Q53RPCyGDiMEg6B5G7KDnIAeEgt/J8/m6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_174457_790471_A9F6EE89 
X-CRM114-Status: UNSURE (   8.85  )
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

T24gNC8yOS8yNSAxNTo0MCwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4gRW5zdXJlIHRoYXQg
VExTIHN1cHBvcnQgaXMgZW5hYmxlZCBpbiB0aGUga2VybmVsIHdoZW4NCj4gTlZNRV9UQ1BfVExT
UyBpcyBlbmFibGVkLiBUaGlzIGFsbG93cyBUTFMgc2VjdXJlIGNoYW5uZWxzIHRvIGJlDQo+IHVz
ZWQgb3V0IG9mIHRoZSBib3guDQo+DQo+IEZpeGVzOiBiZThlODJjYWE2OCAoIm52bWUtdGNwOiBl
bmFibGUgVExTIGhhbmRzaGFrZSB1cGNhbGwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBG
cmFuY2lzPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

