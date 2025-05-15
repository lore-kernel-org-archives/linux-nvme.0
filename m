Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D17FC3ABDA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 02:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Pbkfdh3ESZ9nIFyOTDWAcVks9F44yCdtLMW+cI3RPI=; b=UmBcqBnFJPU57d2EVpqUmPbEzB
	c/BLnoZwqZlWRD1h0p1qh7HvxFUDlw7dtga/oBiSRTEJv4zjORA3l62rZiyApsSlp4p0f+7TWzsCZ
	IlsulswTdEgWJSrDXmvi0NtukylIqai7UJssGgcq2vetnT9UDTgnFA4+6TM/GdhviJBuZNkA1XXc7
	IuBjblcxFZUEqtdQ36fJlGJRZVQPgOnikVqYBkj0/RgQPUmiFtAz1EBkg+20FA0x6PK/8ti/YblD1
	VoPNm52Rs6pphnm1FsEAK5i63/7TCh/1w7/B63Y8y97ztdoyPUYhwsbiStJDSx630ySQKIeKHM2vz
	VYj2Ok4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFOja-0000000Grdi-3N7W;
	Thu, 15 May 2025 02:54:10 +0000
Received: from mail-mw2nam10on2060d.outbound.protection.outlook.com ([2a01:111:f403:2412::60d] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFOjY-0000000Grcb-2VXz
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 02:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuJtzv6Ms3XfvLWtz1Jj6VplZSvB9yqRznQ+zFh4xZjcwbJ6NlR5+fMkp6dsxeMsgso6vLiZrVkazYeOii7IJf003iDTykIQRgaW6iX/KmtjwjAgNj5KJDCM9RbYBH1HWijRK3fil7iVRATJ2R64++yMgKD8XfCK5wND5UPbYgM1b7ItqIOUT5eTS/vrltVJDSiabwbJ173TraalMAlH/kl+5XGRKZYl8tLiTAoFzydd9BkPQR0cuOb4WYlVgC8sEG/dCNGdoLUkvNwWZlDobUj1cKSr0o/SiGdEXcpMJW3hLBi2RqK2Cwp7ZChhV+dFN9Gldab15+UMcgmmcauFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pbkfdh3ESZ9nIFyOTDWAcVks9F44yCdtLMW+cI3RPI=;
 b=XpwoJjtM4IWmkRxaGQJoZ6mNzaxaJhlCD00idvu3lZdu51h7LotVewENB2ylTD+fleNpQWG5sV4R7qEchXDnGNSL2qtl7ZPn34t2ncFINiZ3Z5N4fJF0IW6T1iBpqFmygtdauG3Ds2XDG9nmBYO2BGyrFx77r1zfMsNlUV7QApfxcy/2MaDouNJ9jEb8WnOerQjfOTcFZNIqfFFeWVmmhluYdPfLy+LXDvk67LV56lBfk5ZmZQAlwxcpCVo8IVBckpA+oDBPyNObeP7fvk9wpJfDbuLyFKSNtAAx/g7TTPePIsTaQeG9u3bArjUiPUC0dqKDFVRI7f8dn/RAo4+dLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pbkfdh3ESZ9nIFyOTDWAcVks9F44yCdtLMW+cI3RPI=;
 b=JQGKH4sOvq1LN+ToqvVIQLjnqhc+DSXf1DAYIz6ROY51BrzUDEOPUsJOKFdctDPhU9E3wTXewQ9ApOSZKvdubEFJutzAqmSqJMokogffq/Drr8leu/tvzie2z+viK/VUc8jD81kpy2Ke67QZVjoJzoRAWIxdgs363k5sCvWQtsi8ICpoc+yxd4AlsUslLRHZxLrIW9qXPY2PJn38GNnijF4CUiVSaT5L1yYn/Y6wBKxg1MCCGYOXpWNuoWOhY20lMue3LElk3Lo/Zwo91Vi5D8BG2voKU1xg/SYTBknKLHcuGSp/wwoCtDhJODVgsIR0ML2UB2EhtoiBu0BDYapH9A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 02:54:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.024; Thu, 15 May 2025
 02:54:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH v3 2/2] nvme: all namespaces in a subsystem must adhere to
 a common atomic write size
Thread-Topic: [PATCH v3 2/2] nvme: all namespaces in a subsystem must adhere
 to a common atomic write size
Thread-Index: AQHbwGiGyLJTJrFGREOz7scSoaq5RLPTCGYA
Date: Thu, 15 May 2025 02:54:00 +0000
Message-ID: <0226efd5-84e7-4293-99de-ece9d39578b3@nvidia.com>
References: <20250508223802.277311-1-alan.adamson@oracle.com>
 <20250508223802.277311-3-alan.adamson@oracle.com>
In-Reply-To: <20250508223802.277311-3-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7138:EE_
x-ms-office365-filtering-correlation-id: c1efda31-bbba-4ea2-b10e-08dd935bbebf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z20xTjk2c1hOeEM1eGVNWlBVdmRHNjNJcjVLMmplaUFGS1R5ZFVGdnlRMGRn?=
 =?utf-8?B?NGM1Z1JWUUhTMUFwVGw0U0MycTBDMEVsQ3g0UjF2aDNtbG5IMFFsbVduOE4y?=
 =?utf-8?B?dUtxcTFLRjdxU3NJeGZQSERVTnd5T3pjb2tmT1p0QUJacDV6c056Zno2TmEv?=
 =?utf-8?B?UElaejN1K296c1hKRFlzZUtrcStzWGtLRTRGVUlzbzBVb29rWVcvc3BuR1ha?=
 =?utf-8?B?V1pLQ2ZlMmY1L0MxTElKaWIyNlV0VS9JMk9CRG5qZkhrZjBMV3RnaVFDREdx?=
 =?utf-8?B?TnZ6a0dMWW1lWkVpY3JhY09IZkFUQkxqdUZVUGhyOFp5UDVpTmdMRUMrMUVt?=
 =?utf-8?B?WUpTcFJtSm5zdkdORzJseVM2bEZLdUphbXdSb2p0amh1NWdEdXBLU24yK0JS?=
 =?utf-8?B?YkRwQlZEZElEU0tnUlBiWHJQQVJBQmRCVDVRMm9iRjlpSTV6MXVNRGxuOElZ?=
 =?utf-8?B?Mm5mOWVhTS85a21DcC9yYlIrTUJ6OTA0T2N5WGRSMElRTnQwMGhHZUpKeU5X?=
 =?utf-8?B?VUVOcEtCZ1l5RkN6bkk5ZHdqUitGZW95RjlSM051YWJXZlZyNWRyR0ZEUUZL?=
 =?utf-8?B?dDdPelJuSFBaTTI1TlhLYmt2MUtPUjRuZFdTWVNCd1ExaVMrVGIyMTVobDA3?=
 =?utf-8?B?T1p2Y0JLc2psYVF3c3dUazQ3ZGhLbzhGNzFYUVZPTEhDMm1nSDhUemIwcEE5?=
 =?utf-8?B?Y29qYisrdU1tRDE2Ni9yM3VpM0pJS2lSR3JIcVE5dmJON0I2ZFhIS1owdTFI?=
 =?utf-8?B?WUIrREdPT1laMVlMVkkxaVFPMHcybGlSNE1mTFliTy93RTVVN0pyNkJjdzNz?=
 =?utf-8?B?OHZNMEFRTy9ocGxWdFFyeW8wcUtCTXNxazlYN1BhRHk0SDNVaUJJMkRDQUVF?=
 =?utf-8?B?YlRYRDk1eXpiZ25tdHYzNHpDVzQ1dDVaOFVJMlZLVEVtc01scTE3Zmo5Z296?=
 =?utf-8?B?QWlwVWZoN2dPWlRoWkp3TDJFdTkrQlVRdE5kWTBHSmNkbDAvSlBQejcvY0E2?=
 =?utf-8?B?MWxML2VuMWFlcFJKZGV3ZVNjTU9XUXkzV2VmVEF3ellHY1laK3VZNlJDMTlD?=
 =?utf-8?B?dlpFSEFBS055cWNCME9BVEhaa3Z2aFRUVS9YS1FrbHJEMGkrbzFPbjhzL3gz?=
 =?utf-8?B?bUZBbEplL0hDalU4QUR1ZHYxeEVLRlVoZXB4d3NBczFMYnlXbEFZZnRrL1hZ?=
 =?utf-8?B?eEV2d1pZNXVDM2s0SG1JQ0JJNkhDTmlLZkZ0dHhSK2ttTWsxTS8rTnpSSjh5?=
 =?utf-8?B?Q0d3Z3lkL1ZkWWJjQzM1QisxZ0xoOG5ycHA4NHROZ3lWSWJtbUd3QW9HemNE?=
 =?utf-8?B?c1BXeGRvK2FWVHRZam9ibnpMNFFKRWhPdktPQTRFK1Y1ZTV2dVVQbC9uVWlX?=
 =?utf-8?B?djdISGoyTk5BVUR1VEFwQnQ0N2hnNGNHVWJtYWxQS0lSRytBcWFEbTNMMmFw?=
 =?utf-8?B?c011T3c5QkFzVHA1V01kbktTekg5NkUxVVRWK2VROEZEQml3YnowQkl0SE9Z?=
 =?utf-8?B?TWd0TWp2dXNPRFJTTml6NWhtc3hBRE1qdzN2YTNrNHBORkMyYmxXT0JNNndo?=
 =?utf-8?B?aGhzaDVFeDlnekR6VW5TY2k1SkxyWjVkOWd5WHh1QTI4bThCd21rUTZ3TTl2?=
 =?utf-8?B?S010SXRyWjNOZzJ1TzFYOU9QOVREa3Y2YzhUQmxSY1hITFhjNHQ4QmpBZkdE?=
 =?utf-8?B?M2RKc1dia2plZmxMMDV5MFgvcm5oQWdtSWhOVDZuOEFOdm9YdTYxdnVpWDMr?=
 =?utf-8?B?RnFudTFMN0FWNVE0ZlQ2ejFSMVRrbUtpY1FqZXl4L3lQS1FoaEY2aEpYNmRT?=
 =?utf-8?B?RU5vcm52QTVnTEVoRW43WmtMWVZ3Tisyam9NV3dQVHFDZ0cva1E5RmE3clMx?=
 =?utf-8?B?Tzh1d25xM1UyOW1BQkRBTTZJdSs1RXU1dGxseWVjSko3WFNLbXFpM2J5VEwr?=
 =?utf-8?B?MVNjbTdzVzI4L2RrYmtoSXM4NUwxenpVa0swUlpwZFlqUzU1Mlc2WUtjd0h1?=
 =?utf-8?Q?enMybacC86iSYkbcBh2hiWjZMLUDpY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHdBc2pLM1FzRlI0bG9pY29zRDBYbFJXY3JBbTJrbnJWbE8wK2N6SHhsSkpp?=
 =?utf-8?B?VE9zNkNodTdDVEhDWTdQejI0K2YyS2g2WXVKTUo4eFRoYjFDYzhiUEYvUHJu?=
 =?utf-8?B?OVhGeG1sMVpYNExjNUdPSVhteHZKL1NHRUp6NFI2Y1RvZFE4Z29HZkptaE80?=
 =?utf-8?B?UE1zSXVCMVN3VG1ONGVqcWc0Nm9uZXJ4S2hTSlB4NFVEdlRWb1V2aHhBVFFm?=
 =?utf-8?B?amVDRVlEYTNXNHArUnZkMTExekJ6NmpmVGZtQ3gyamVsak5PclluQVA3T3Ay?=
 =?utf-8?B?VVAwL2grbEpUVW5UQ01PMFZtT1N6b2hTeXRhVFlHNDJORHg4SGZ5MWhZeHZa?=
 =?utf-8?B?KzFjbTdKelowWmdqNkp5SzNzeFNxcTE3WStNUUtWcXlGdEJWR3E3WjNqeTRI?=
 =?utf-8?B?WWF2cDdmcEpyU3k0WHovY0NwWS94emozMXNBNDdJSHArMEhLRWtPeWxlS3hv?=
 =?utf-8?B?ekdqaHZQMWxRc2pnaWhkUDU2RFBBTDlaQk5jd1o3VzQzd3dyQmRhWXNIanRU?=
 =?utf-8?B?QVFTSTNUUFpQRjI2R0NjbFphZ2szamgrTVlMU1Q5cWtxejJKb1FVZDh0a1lz?=
 =?utf-8?B?U29QOE1uZm84L05ZOFRxVjI3S0Fzc1JJd2hab1Z1TGhkMWxlVTdEZkZpbDRu?=
 =?utf-8?B?bVFHN0tvRlcrVFVKSlUrdlU5emYzU3dCNDRHRURaNkFaaDZEZWJlMklGRFhT?=
 =?utf-8?B?d2xBMElHckNxUWlpeStNeHNKYk5JZUdQM0dlWndpbm9uQVZ1S2dXdXUzV3c2?=
 =?utf-8?B?eTgvYVFFWkh5ZE91emNYM0R3S3ZabGRtK3BLWElINGE2VnRpNFJIQ3VHTlZl?=
 =?utf-8?B?bks5alpkZ0dRenBmMTJmZnJSS3BqVERyRTE5dHVaZUJJSEJQb0xkemNNZkUz?=
 =?utf-8?B?ZlpqbThZQXBENGk0ckpKZnNaWENDY2d0WmtwVEttTXZKMTNzZGYwYkozQ2Zr?=
 =?utf-8?B?NWlJdTJoR0lJdjdkbjdpbmxyMksweEVxMEU4ZXlwcEdFUmdiUWNhVEdPTnNp?=
 =?utf-8?B?L2lVS1I0aGkwaFh5YlRkVyt5VlJQaFk3K3BxQXJKdEdKNDNXWFJHdDBGcGNo?=
 =?utf-8?B?eE9JY3BFRWEvdmM3VGNlS21kZHRkRWYvczNSdFhpK2lvT3hHYXUwM05OeVFy?=
 =?utf-8?B?MDd0L3JEQlR6YktzcFBFcDJjUFltaHAyelpFa0FTWDZHVDQwUHBCUmFjRjBH?=
 =?utf-8?B?aHo2Wi9YSVloU0QrNHp2YUNQdEZyS3M1TGdCRnBxU0lFSThkR0tPdFZ4dW5m?=
 =?utf-8?B?b1VoQUE4TVBoNW1hTWN1NmhtV3RKSmg4MVdSR3hyNm1FQm1ESWt4VGlkRVRp?=
 =?utf-8?B?Sm0zUmJ6OVFCMFo1V2c2dnVuRFpxT0hKcDFXTWEraC9YODNyUmoyYkpvelJi?=
 =?utf-8?B?NmV2eFZQN280NUJEMzN0Vm13YXZzT1Nia3h5ZzU4VjFZT0NNRjZzekF1VCty?=
 =?utf-8?B?MWFSbmhpc0VVckFNYzdibFh0YzZITi90aTVnVUZxSWY1NFVFMXRSOE0zZEhC?=
 =?utf-8?B?QnJoTXE1YXlBQm81eHpuZXlQUW55OFlTNnJDMGRTM3FVVXQ2TWtJREtvZ3c3?=
 =?utf-8?B?ZjJKQXhMTzM0N044LytWOVl0SDYxTGlOQjlGY3Z2ZExFN1hEVWFoc2tQUjFo?=
 =?utf-8?B?VWcvT25MQkVtSHVySTA1bS9ScFRNWFVMMW5kVWU0OXd0OGovV1Jrb29YZW5y?=
 =?utf-8?B?aWlpZFlOUUNrVXlwS3psbGFxS1BNeE52cWtINVphTWY4dzFBS3ZkWW5kMnJD?=
 =?utf-8?B?ZGVnRmdZYW1hdHZqODJrVlFqWGwrdkFQMHJsQVFtU0lER2I2VEVDaXZtR3JI?=
 =?utf-8?B?MWY3WjZuUS9FRGRpbVhTd3RwTkxIVkN4TFhCSmwyVC96WEE0OVc4K0hud2Nh?=
 =?utf-8?B?d2l1TVhGemxMdG5ETG4rR2JqR0R5KzYzMTRvRGlPcGdNaklvV3pRU2srTmxl?=
 =?utf-8?B?c251cGNTNHBtT0N2eVRxRHgxQmpYeG5vTDhDQ3BoZTFPMjZhODQvR3cxS3hW?=
 =?utf-8?B?Mm8vVDdSR0JQMUZZSGxKcks2bWFQSzJ0TnVrR0UxZGRXMW9QK0ZNbHlkV0Fa?=
 =?utf-8?B?RVVsbWdsNytGNk1CeHhkaVBzRkhPenFtZDU3M3lPdzdZTVJOOFZlTksvQ0Vt?=
 =?utf-8?B?NURSTDZkcndtL0s5T3F5Yk9wbm9DK3gxUHAwYzBJWGFzV3Jaaml3emhFRlVu?=
 =?utf-8?Q?LQduwGa5lBdUMnCFpDb18hyjAJ0FTKOOvkioydxBNzQL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2FFF27FD0CF124AA8C2D93A8466DE9C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1efda31-bbba-4ea2-b10e-08dd935bbebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 02:54:00.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjHC86YEvLQSn/+/k/dbnTxXAjrFkIQ//COrpK7FgGm+Yd5AhUUOPw5SQL6XIYptJwyKUIehYNH7cktbQZWesg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_195408_641362_CE8CDF93 
X-CRM114-Status: UNSURE (   9.16  )
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

T24gNS84LzI1IDE1OjM4LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+IFRoZSBmaXJzdCBuYW1lc3Bh
Y2UgY29uZmlndXJlZCBpbiBhIHN1YnN5c3RlbSBzZXRzIHRoZSBzdWJzeXN0ZW0ncw0KPiBhdG9t
aWMgd3JpdGUgc2l6ZSBiYXNlZCBvbiBpdHMgQVdVUEYgb3IgTkFXVVBGLiBTdWJzZXF1ZW50IG5h
bWVzcGFjZXMNCj4gbXVzdCBoYXZlIGFuIGF0b21pYyB3cml0ZSBzaXplIChwZXIgdGhlaXIgQVdV
UEYgb3IgTkFXVVBGKSBsZXNzIHRoYW4gb3INCj4gZXF1YWwgdG8gdGhlIHN1YnN5c3RlbSdzIGF0
b21pYyB3cml0ZSBzaXplLCBvciB0aGVpciBwcm9iaW5nIHdpbGwgYmUNCj4gcmVqZWN0ZWQuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IEFsYW4gQWRhbXNvbiA8YWxhbi5hZGFtc29uQG9yYWNsZS5jb20+
DQo+IC0tLQ0KPg0KDQp3aXRoIHRoYXQgYXJlIHBvc3RlZCBvbiB0aGlzIHBhdGNoIDotDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=

