Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16923E6C5FB
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 04:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzuIYRqMK2eSCowoMK6DSJ08cOe7EojT24U0phcgQDA=; b=xb6bODD2/OdpRGyNNAOwsNSKVB
	LmTiaaq9FoxTuZnquJbNbUNXYp6XpzssQUawV+WASWuap/Cpw0uXxrsRYWtAvCFWJpVMkwceXjV7H
	MAk27EQ5XBw0RlHNML0zEsUih6mXiUbS9m0ykiLFjPznlzIn/niDbF3nuUFhArgU3AGbCq83SsIrA
	dq+gaROZ+eg6Hu2A8Iaa5ba5AQloDIWiebiry2V3wZu9pBZFgjCsSTIM7Gen2e9w2BXPSukm5Mkel
	+evwWtIJDHyia6Zt/u2i8H+n5wVT/Um9RkAdSUq0TipNaHxQbYxNP68ioIqTllyIIY67t0nQFNNkc
	qjHy2cDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKMu-00000008CAm-42gu;
	Tue, 03 Dec 2024 04:18:36 +0000
Received: from mail-mw2nam10on20617.outbound.protection.outlook.com ([2a01:111:f403:2412::617] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKMs-00000008CAN-0vts
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 04:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX1tHDrPFJzBXyMPQ/x74OJADQSZKigMTy38X/gfiFYDtRnOge+b/8i3m5NL5hkVU8f2LdC4LgZ3pQc4GJN/LctyU3ZsiPK3jLUjhgZkCm944VJYewu0Apdig8WPJSsnW/BlCLGNk4lPlXZ4xPOtSmUuvzvlHLlXV5a1MsDN+RbBWBVJI0F0lhDindc/+8jIyiYOLody6+e6CK+LcSgteWZCLx9GUsQqEST+2D0lIoWAcNH8hQS8oXuQv1lhuB25AuRlsSK1SkYJl3LFEqgVkzMGFNtUbkQQTCV9a5i8evG5nG2jNrmEv6TghmXA7x/i1pQqaqSeADhwVA3XR7PocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzuIYRqMK2eSCowoMK6DSJ08cOe7EojT24U0phcgQDA=;
 b=kiImfa+wK1o4xNxlj8QlnB8eckYuA0MgA9no5h01yWDPBnYPWdyvPfl9Xn3nhkAghROz9XB7y1aKhR26gJB4QgLcroisP8ir3IbCfJ/c1WfN0T+YKTCRkzOKOnQPEqI/7B4Fzx7oKz93bygQtA9jlC5Hik5Y5XDk8OEk00xrscknuzYiJaSP7W/ROG+RwNiLDdZxEMkpt9XdvevBaYtTz5uzP7oBTNTAq89fQny1tsx4WiN3fkjEe4uiiEl+dT2k0J9OoDbrkfoXcMOJQFpeY3wVPO08QuRbXSVUWD+eUf6HkgHs6wpBKrsmJHdBIlZ1aC+4jx2JykS9M9KfAcjx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzuIYRqMK2eSCowoMK6DSJ08cOe7EojT24U0phcgQDA=;
 b=IHjvQ2nMDjJMQe+g9RFJ51kccdQszLVsGxor0E2GvedmQpdMo+eiV+ReOQNiAfGmdbjGpjaLnUJpwVxjsyQCyJZTrdjO1h053KUbn+zQacP+iAhesHBgd4E6tTAhiS2FEYTNHCpkWK+lpShIJwUMCunEq1lyzr+lScePiCm2KAy0W0urM4/HaVC5cmLNJ+iMzmhMTmDTNuIO7/jPCffvDPRYaZAI+K2X830Avokv0ngvmk3Oe86Ne3DqFNGF8oTCuhzr2ZlS71Iy0Iab/ACxyQHMcc9NcL9Q9T9WnO73XhurahhOmJI4/1tm/gm86T/8bzkHsevgDC75Y6mmoLfiTA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 04:18:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:18:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, "hch@lst.de"
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests 1/2] nvme/052: move nvmf_wait_for_ns() to
 common/nvme
Thread-Topic: [PATCH blktests 1/2] nvme/052: move nvmf_wait_for_ns() to
 common/nvme
Thread-Index: AQHbQjUch399BHf2JU+pDy78U9w7MbLT8FUA
Date: Tue, 3 Dec 2024 04:18:17 +0000
Message-ID: <26ce9f0d-8104-44af-a648-46613e518ea7@nvidia.com>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
 <20241129080231.2994578-2-nilay@linux.ibm.com>
In-Reply-To: <20241129080231.2994578-2-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7274:EE_
x-ms-office365-filtering-correlation-id: 72c36ade-17ed-42a7-dcf4-08dd1351832d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QUlhZThiL3UwSjdhUTdsQWJ3RXZnMzBDeExZTVA5TGRVU1UzaVhZZzU2NS85?=
 =?utf-8?B?bExmYmI5N2cvNHpkT093K0ZxVkphb1NOVGdST3pjU0hRZzlUTTIrVmNkMWVV?=
 =?utf-8?B?QUh5aDd6Qm93aHlvS3RjdEF1a0tESVVrcGh1WXJ4U3UyMkVRTlRlaXduL1Bw?=
 =?utf-8?B?dlk1a3g1Y1lxdEdmM2FEMWdjRVFDdFZrWnJTWldjVVkzZHYzODZ3OVRLcmNx?=
 =?utf-8?B?NGRvNHZGOWFVenAySzZkMEF4T1VSZk1zNEJZbHd1NjM4ZFdyUWlpdzZOdjFV?=
 =?utf-8?B?K0V4NjZMRUQzd1prUHV6a2gySUkxaHhiVHdJQW40aEpNemY4bnBFMnVSKzRm?=
 =?utf-8?B?YWlUVzltTjMzSSs2SVltME0vMUlpSDRzWURwSTR6eXVmNzlpMVIvOEpVVmJk?=
 =?utf-8?B?dFdoSDJud290ODBZRmtpcUNQemk3d2xRRzVMVzZuNk5VYzJ6aGlDN0hEVkxQ?=
 =?utf-8?B?SVVaSDFUeVZyMmVwRmRMRFNuQTlXaFFqelUrMVg2V1hZNDZ4YWhWL3VYZnBJ?=
 =?utf-8?B?WURNdnVBY1pWRkZSa2lOK0locm5iUGx5WWFqeU41S3ptcmFaRFRXbVZjSXNr?=
 =?utf-8?B?R3NMcHVjcEFmVGNTdFcyRVYwZmp0L3RlbUg3UlNhaFRYNU03aUh1U3cyQ0NC?=
 =?utf-8?B?ajB3bWY0Uk5DeGdabWU1anZWVnMvQmhhR0NPUWdhaW5UTEMvSDVORm9rM2JE?=
 =?utf-8?B?aExPVzhCV0FraTFOTkFGYmNYeUZmenNuais1eFZsaTNRVjQ2ZWMyaEhydmJq?=
 =?utf-8?B?Q2dsZi9BZGJPa3JTVG0vUGV6YVIyT01nb0pKdkhpWHlVK3hvbVJtQUxZK3JK?=
 =?utf-8?B?T1JxaVd1dVllTGRWSkxaUHA2Z1NIV3ZNdFJlSmEvU1JFNWZvZGJkbnI5M0RT?=
 =?utf-8?B?YUhVeEpDOVlmYmdGSmpza2N3MmlwTHQzbzFBVGZzTUdKUUtmV2JKVEZSQ3Bt?=
 =?utf-8?B?QlBZRWNNWnQ3blRNQ3RuT2JIMXB6bmN5cjhGemVZdStWNWV4ejhqTmUvcHMr?=
 =?utf-8?B?eG5jSjdMM0lVK2gzcHVnb2JTRWtUSVhvSkFhMFFtUjk3T3pOWWlTOUxucG5H?=
 =?utf-8?B?RmI2Y0M2cHZwYjdmYm05RFlBbTVFbWpLTkwwaTdlL29IN0pZaG85eFh0cnM1?=
 =?utf-8?B?UVNvbCtqamFXcnVTdGVXcjNVU1o3TExSWVVzUVZkdXIwTmdMUlZxWTlTRnlG?=
 =?utf-8?B?UjdHbitKK08zNTNmb3h2emxtK3FSVG1MNGhnVC8rc1JOVnNZRkl3SUFIaGlN?=
 =?utf-8?B?TkNiQ2N6TXQyaXlnL1hWdlRwbGRneWdQWVFZc3U5dkw4cjJvWHYyN0RtY3Vh?=
 =?utf-8?B?bmtnNFhacHR6V2VYam55T1lOelBoZE1vS0JtbU0xdmFPUzZGTitGQWxwbnZW?=
 =?utf-8?B?R0xObDBDYzgrcld6d0duL09RWTcvUWJ1cnJmaXdFb2xKRDh1R2s0Q0pGWDNQ?=
 =?utf-8?B?b0lYaUpUTFJuNWdMZFVXUHhvOUNxa2ZMZVI3ME5FUHZUVjJqd2pGeWE4S2V4?=
 =?utf-8?B?ZWJ4TGhpRzRwMGQ2Qy9oUjQ4K0loZXFDYS9hNnI1S2lCbWtqcStzSWJ4RzhQ?=
 =?utf-8?B?K0N3emdna0liVUVIcXFJZTNaR2RmQk9nREs5RkpXaUNraHBEbHpORjZZVFhJ?=
 =?utf-8?B?MUpZQXhDUFdnaUl1UDI2N3dnaU9iVmgyeERydzVsM1h1UHZEZjc4andtRlVt?=
 =?utf-8?B?ZjBYRDFlUFVVbmoxZjR5L2pOMjJVWEMyYWQ5Uk1uNGNoRUVoeGJMMSs1UGNV?=
 =?utf-8?B?aVBtTlU4YlA3QmZvMVlWR0FBaExwTk1pQ3R0UFk1dGprMmZzSGUvR0x2V0xW?=
 =?utf-8?B?WkNhUU1Zc1krT1p4U0lIeWlqVUtuUXRzU0hDa1FKSmV4UUFWTldYTE5MUkg3?=
 =?utf-8?B?NXQwU0llRTltVXpPQVRvY2lPZkNDQXY3UW91VFZtdkIwTnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0NhaFhxKzBSYTlqWEJJR0ZYSnhwblBTekM1OXYweVQzcUQ5ZWZTSU0vM2J6?=
 =?utf-8?B?NnVtZEVFMUhZS2JhaUtvdHB1cWQ2UTNSUWJxeFNkbEMvbTZDYkQraXlUdDBp?=
 =?utf-8?B?VjF4SW10Mk90TTN5UExJbGg2Zzk2NDRud1VRalVnZXlOa1FYVlVDc002VTRT?=
 =?utf-8?B?c2VWbTYzeTFMMStEZUhUWU8vR29tWlN2K2Rmb3ZpcHJxZDlJa2VpQ09ZaFNG?=
 =?utf-8?B?UUVmWXc3b0VVYmJNelZhOUUzcXI5Z2UzRk1peDQ2RWMyTG0vNk8zaHhEVGYr?=
 =?utf-8?B?eW1qMjZiN0x0bFhZMm5jR1JwbFQ0aEtXZjNpT1ZSQzNKZEJMUnFaUjIxVDU2?=
 =?utf-8?B?OFo2c2lSS1FGS3g5S2VmM25iWGl6Vzc4MEt4cDR0YUcraUFNckh1VzRJendv?=
 =?utf-8?B?Mnh5NmpCY296NEdtb01CSFJ0OEZLWVB4L0VBMkdYRERMZ2V4T2dRZUdiTlVL?=
 =?utf-8?B?WFJnNXFMajJOSE9lSkl6ZTBVdlQ1b0V4WE5CaEx5U3M5OVBFTjQ3amJmU05P?=
 =?utf-8?B?ZUpmUVp4WmYybDcrdlNTTUloV0JxQmJYR2NVbGtpQUp5UVRwNG91TzM1dFhx?=
 =?utf-8?B?RWx4c01tMkY4UmQrZXo2elhCdmlWQVdiM0FpaTJYdGlMQXdKT0JaUTY5Yjc3?=
 =?utf-8?B?SVdWUk1XOW4yc2QyUGNMdnZ4NWFTeFUrbldwdkxtYlNNcEFVODNnUDE3bnRi?=
 =?utf-8?B?Wi9ValI4cGRtL3k2SEJJdlZuVWV5R2xPOWpxclRLdktWb3RyaHh0M1dBMnIx?=
 =?utf-8?B?SmVkTStaMnFDcmpzTVRSOWRHOEpLQVJFd3BDU1lhR1FhYzVXNEFJQm5DaFQ4?=
 =?utf-8?B?MzZvVEhqckRheE1EUkhJV1RDUjV4MGJPQ1ladW12UzI0VGJuKzNuakZpL0xa?=
 =?utf-8?B?KytRZ011blpHTzdiL0x5TkJGcHpPYjVocFA4ZDU3dGNOQnJCTzkxZExsa1Q0?=
 =?utf-8?B?SjBMYUQvRWx3VTg3bDM2T2tkSzc1VTZxdTNBWTdoQ0szYldaQjBrUmZOWFJx?=
 =?utf-8?B?bXN5a1hwcHBTeVFMbEtZYllCeW9yMmNrTW9Za2JCV3JnS3lOL0tjUEVOcnM5?=
 =?utf-8?B?VFUxV1J4VnZwNlRMWW8xUTIwdWpqeUFxMkV2Ui9RaUdJYW9veFZNaVhNaE1F?=
 =?utf-8?B?OUFreU1yVWtCZTZqNWQ0K3I0Y3REaktJUTVjNzBJaDA1TUs4YUs2MEs5Mnc2?=
 =?utf-8?B?U3l1aWQ4RWtIcFlGbGYwbkFaZGxGdEtNcXNyWmJMTDdBNnN3ZGNtMGE1ZXBr?=
 =?utf-8?B?S1g4bzBPbkdNbTVrMExkWTk4alk2M1d1Q2cwRlk5Z2x6aC9RM0w3YUxaZkhM?=
 =?utf-8?B?MWlSS1hrbXdCbzNTSTZSTVdRNVJLOC9YMWx4RFBVS09CL2dERWJJYUtLNFlX?=
 =?utf-8?B?ME95MTJlVWRHUlViL2xHUWxrSk1vWWhjRzVwL2h4RGYzUEFCVFdqQ0h1TkNR?=
 =?utf-8?B?akhSNENkQU5nY1RGMTVEVGhTQnlWeENVK2RzTERESzJGQ1M0Yk9CNUxkcEJY?=
 =?utf-8?B?aElOSmRtbG5PMGJuUjNSbjhTSXdFV1hhdmdySlRBNHg1WEFiN3Q4czROWHF3?=
 =?utf-8?B?OVdEOGd3VHB1RTN1RnNDaWxzZTZkblEzUWJoMVJyUzlaalpGOEszemFLQkR5?=
 =?utf-8?B?SXFyWm9ERWRJbTlsZ04yU3Qrb2tEVGErVGd6eEpXdmVGTjJLN1NnME82THNG?=
 =?utf-8?B?TkVoVUdNWVhoVEhKc29EUVFiM3dzeFgxVkZ5MmsvR3FXTi95dFlRS2RxRVlk?=
 =?utf-8?B?RDdVN1NlUVh3SmZJeklocVlTbzJ2KzRSV2JEMGY0SDFabWVvLzQ2clRBR1g1?=
 =?utf-8?B?MEp6aythTGo4L1BPdit6Z2U3TWtZbnlpT2hTZVd6V0laUGFKVHZYNlg0S1Rq?=
 =?utf-8?B?RHJYN1JGWFg4cHduMlN0UGh3MW85QllRbTFMdXczeGQzMnVMbWFoSmF5WEph?=
 =?utf-8?B?bzlPdHBqYWNXREtySk9SRFNJYXhhVDQyQVVOOHY2Y1d4VDdUZTMrbUErUnR2?=
 =?utf-8?B?RGhCUlpmajRhUndTV0Y0bXlrQmx0Q201SUFISjdZTFl3SmVzTkxlVHNOVEtQ?=
 =?utf-8?B?bEwyUW9aV2pKOFJObE5jeGgyTWowMWxTVE9QTGRRZExSMWxleExWSFBPOTRK?=
 =?utf-8?B?eGFITUx6OTQzc0d4WHdpYnFtaXpaQyt3VmFtRGZmOXM0cmFBcFVsZSsrUnAv?=
 =?utf-8?Q?CLkHg53nSHsyJrp9rUJTadUZNjw+k9KN9HXC76CjogDR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D6B0CDB35E9334F9081F17037D7BDE8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c36ade-17ed-42a7-dcf4-08dd1351832d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 04:18:17.0223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8pGIiYs3cH99N8q8vTOLbfSRbC2HdPNv+RzAM3XftmRRnjPrxoHiy7gG56DOpHzvMM9cbe7zNACVEc/Gi/idA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_201834_264646_4B87BC4A 
X-CRM114-Status: UNSURE (   7.55  )
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

T24gMTEvMjkvMjQgMDA6MDEsIE5pbGF5IFNocm9mZiB3cm90ZToNCj4gSW4gYSBwcmVwYXJhdGlv
biBmb3IgdGhlIHVzZSBvZiBudm1mX3dhaXRfZm9yX25zIGZ1bmN0aW9uIGZyb20NCj4gb3RoZXIg
bnZtZSB0ZXN0IHNjcmlwdCwgbW92ZSBudm1mX3dhaXRfZm9yX25zIGZyb20gbnZtZS8wNTIgdG8N
Cj4gY29tbW9uL252bWUgZmlsZSBzbyB0aGF0IHdlIGNhbiByZXVzZSB0aGUgbnZtZl93YWl0X2Zv
cl9ucyBmcm9tDQo+IG11bHRpcGxlIHRlc3Qgc2NyaXB0cy4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
TmlsYXkgU2hyb2ZmPG5pbGF5QGxpbnV4LmlibS5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

