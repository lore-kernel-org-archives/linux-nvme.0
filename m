Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA96D3E78D
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 06:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8sQ4F/GFaKj3yfvkI/TVzBbaM9a8flG2ODn7aABtFQ8=; b=a+H2kbGLi+dI4ZXeDAufFlDGbt
	/Z7v1GQwMcOzXnXMh4R0cDZwdm5cS3msj8l74tdqdLuMsqKeYzUPu4LLYdFVsKj30KhiKh9jvX0uv
	Gwn03fYLGHz1M1C0l7G+n5BsyXWFwvL4uSY0TlnbCqLNBB0IYQ1+YVHyNNknsdNCchZm3jare68IE
	NlQpWCLoeylnfDPf2Oe1CjQlIRR6YO0k8jf8wdGC8EOfBf0WaUzq1gO612IUgz6nyr/QNvfOeojJ+
	qaL3Rj1NA1w3qbo+vOEork84IjfsUpbgDC83pRb9T6PvXAWqEltZ+wi3k3r0NMVJttQTvZ51/nEcV
	Vmcg493w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZMG-00000001y0M-41Nm;
	Wed, 06 Nov 2024 06:17:36 +0000
Received: from mail-bn8nam11on2060c.outbound.protection.outlook.com ([2a01:111:f403:2414::60c] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZK8-00000001xh5-20ML
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 06:15:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJacTPAXFUemPFC57cmpzXokWepKlGZYL/Qw251qzFBNb9fcJ67U8JrZVRgMMSZfIRrcNeev/8ESxoMG+8qarSW570hSjxFmxL+/u2RFn6wHNeNIoi2lSjBCtBozgvMzPfHyKUjosDZq8Y2TAX6QXH6KQGYt4LqC3sacXZ6/XXjlvqr5NgJCDE1uFZ9+RxzzEz/DCGV6Wv5Zs+0AC48C9xtfT8TIvub2D89MZa6MeCOHSkoniiOblfGdOmRLNlad+bm21JO7r8rCRrvC6iywdC1pmpdYeGVn3JvRGaJvrLf41+tqimXofj55Iz8JAUZgOowLyorRH6Yzh2WOLnGLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sQ4F/GFaKj3yfvkI/TVzBbaM9a8flG2ODn7aABtFQ8=;
 b=Ve4+RiQp2923VZn6PmsVBJ0jIujZGssEiDgLQNLcLLE7KFDPxxZaBv1pVnF6EUeIKwPQaefU1r2j8RFCnH1pxLYO5jvTFWGw+V6LilHaYt6GfjIIMjebVdl8/21gDD6fKjyy5jB9TJcZX47QsvvTNgnhf5ObAZ5tDRi9HSNZDmChEuqOfQdmSxP46BHffvd4xNKTzZ6755ZVCnOB9JNEIHOtmp+ZQE7uHQwYZFypcA9D30DA34z7zMhWZ9pomoCiF0zhNbQINmZmuFkIhJEqt0cSEvskzpQAMRf8KNiDUn4RslMWO3yNYjVUBpGkaJ/3rraYR8sBHykwrkuXIhLFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sQ4F/GFaKj3yfvkI/TVzBbaM9a8flG2ODn7aABtFQ8=;
 b=mU/POteQ42t6qVKzw1/o8Cu5UnG8NTyThEqjdJHehlSTPbIkHOH9FZgNS5kyKzmR07DVSfEjFWnOWUXd+SRHoTN0FO+s2cNoX2j4NyiLSf8eLQiP67baqlPxWyCR3RLfGLtZIpRDBHnavsMmptM8cLpSG+jzu9/D6HvagcbWFQvXkuQuS7WNiTnklW9Hzz9hMZFyk4W28I73ktlhVXrnWXTfC7yf/I28+E68zWyKI2VcDIiNRxeZSk6d2GjEGES0HKHGEWskFAWQ2YedozjwwJYOYDO3i7myunesQFQF8MlIH21bYGiTqb7ormjreWAFn/Gkm81hrYJxQUl2/vQn8g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 06:15:19 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 06:15:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 11/11] nvme: add rotational support
Thread-Topic: [PATCHv3 11/11] nvme: add rotational support
Thread-Index: AQHbL6saYuORtM8FqE2KpN8tAM8kg7KpxyuA
Date: Wed, 6 Nov 2024 06:15:19 +0000
Message-ID: <c72f5ad3-3767-42db-b581-b51726152030@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-12-kbusch@meta.com>
In-Reply-To: <20241105174904.3612888-12-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5810:EE_
x-ms-office365-filtering-correlation-id: 684e27a7-f903-42fa-d5d6-08dcfe2a63bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eHJLRGMrS3BsdlVSSkM5R2FiaWpPREx5V09WOEVuWncxQmxuQlY1aDgyQlpL?=
 =?utf-8?B?UmxOc2d1cEYrcFlUZ0VldVQ3VjJsRG9BeVNoSUdHbEp0cWNMcUYzc1kwang2?=
 =?utf-8?B?bktpSDVSRUVkdDN6aGpHeUIzc2xBdjU3amNNQmVleS9wRlpDK2tPR0Vac3Vi?=
 =?utf-8?B?STFJV2I0V2pLTi9ZejhEM0R2NTMzRXc1MzFIakIzUVBEQ0k3TTh0Q0NUM0E2?=
 =?utf-8?B?bHhid2J6S3drbmFPeVVLTXlETWdVb3RWVEZaeGFaRFM3VGtPK1A5UjJySGVs?=
 =?utf-8?B?dFBpMEVYMGdsTTYxTTUwdUlYQVZCKzBVU0dobjEwOXV4aGNwMVB1NHpkTlhz?=
 =?utf-8?B?cVQ1Y1Jtc0xzbURBL20zd1c5eVIrNjJ4YjV1UDlVemUzU2xSMHR5L1BVMHNS?=
 =?utf-8?B?RkNjWCtXSGE2ZW5IYW1Ha3h3M0p2aGdjOWxmM2NBOGQ1R2p3ODZnL1JKRTZj?=
 =?utf-8?B?OFpFeGxtRllxdzZJUXd0dU8yajNJUDRIem1VM3ZJVUhNVitaWDBBOFg4Q09S?=
 =?utf-8?B?ZUo2MnFsMGpOK3FTYmVKOG9zYWpaL2pUamh1MVNSNGpOWU5aVS9QeVUxK2Vk?=
 =?utf-8?B?WDNjdUxDRWkwdmJ0VHhmc002eFc4Uis5S3BVcmUyODVmTWM4OWQrY2JnV1Fz?=
 =?utf-8?B?TWJTNXBaMTA3WlpjQlBnQys1SzVkWXR1bjFIeGNvUFNTZ3JHYlZYN0RvOTRk?=
 =?utf-8?B?dmltVUkxTVRLandQc2E2Ukx6YlpESUkrd05URUlnQUdKZlVjQ0ZxYmJwMXBJ?=
 =?utf-8?B?cFR5d1l2TVlYdFU3MHBBblpLa2FqWmxKNDR4NTBDL3h1enZiZnVUbENaaEll?=
 =?utf-8?B?bE9Pcko3OHZqanN6bWtoZmlQcGJxTkZmRlZzNHpjZk43R05rR2ZQTm5UdFlU?=
 =?utf-8?B?QVdweVJBODdEdnNWVEZUa3ozeUk1RkhVZ2wvNHdEK2x6cXZseThhY0JPcDc5?=
 =?utf-8?B?SVAwSXNHejZUV2pxRkxCOFIyZit6NHdxSTNXWlVVL1lLU1R5NGU3eU5SaFFO?=
 =?utf-8?B?L25KOEZ3bXVTaDFkbmVQVUhZN0Y3RzJYTW5reFhZdjEzc1hyUVlrYUVuN1dU?=
 =?utf-8?B?NzVHQmM2eWFlWFpXM2hTL29jdXhVQ3NsRk1YUldJRiszS1ZNbS9yWi9Eck9U?=
 =?utf-8?B?MS8vdGR2OG81MkRkdUJsLytySEdBcDVreW1ENXFEaGlzZFBKRkU2aml1K0FI?=
 =?utf-8?B?QmQxc2JpcFB3amVVTlpkRitneGRBOFJWOGg1SGR5a0lKZndLbDhOWmdyMmRE?=
 =?utf-8?B?SjlCQ3gyVmF1U2V5OEkvK3lubW9oaXVzOWRDb3E1b01iVkJjZU15Y2dhYnBu?=
 =?utf-8?B?WENjQklKUlp6WjJDa1phbE9JbSs3Z2kwQ1VKSlVNQVVXc0w5b2s2cGxHbjBG?=
 =?utf-8?B?NnUzd0ZHeWp4TVh6NzR1Q1RkcXZ6SFBUVHdPK1N1c01zNzF5RUw1TEg2VmVq?=
 =?utf-8?B?ZUx3dmhQY2J0WjRwQ0pON3diWFl6cXozL3lvZzdaaVVlQUg2emd1MjdrNkpQ?=
 =?utf-8?B?N3hXSmhURGdLaFMrRXdBYUZ4b0krcERvVTJ0QTFFemRWLzVSeStXa0FJZ0pS?=
 =?utf-8?B?V0hZVkpDMW9VUmVCQ0xUdUtyU0gzMkpLUFBibEM1MnphWWtCam5XV0dsbk9B?=
 =?utf-8?B?QUF0NmZRR1NtY2E0WmRuZUpqTHFTeVVyOTNDY2QxZEJlZmh4VXNJVVBUbVdK?=
 =?utf-8?B?TUtXYjBkdkV3a3FpRDVjMkhXaFBablFxa2tEaFFEKzV4MmNSWHdBQnFOc3JN?=
 =?utf-8?B?S2ZjUURZNlZ4Wmhtd2hMeisvTVFTaUdrNFgvbkdrNjFvVmN3REdZM1VhVFlI?=
 =?utf-8?Q?ZzzLcZ/gU/UkQcUZtYoakyvRKAOMAeC9MoR8Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0JCeUk2dWNXWGF1ckdKV1ZiTjdUeVV0Z2hScGppUllkT2xwVUxXZWwrVWl1?=
 =?utf-8?B?TVQzdFc0RnI1WUFaYmpxazZpT1lLOHZwTzMwUTIwWGNaTUU0anJjN3hwSWUy?=
 =?utf-8?B?a3JmZkFScGl5ellUVDZIOTlQK1lSelNiS2ZGa1JqdFNiOGsrUUIxLzVWbk5u?=
 =?utf-8?B?TXpUb0pWVEtlekZ2azhRTmtrMzU5eUdxTC9wdGV0YlZVREl1NlBaL1liRW1n?=
 =?utf-8?B?ZVB5OHB5aUFuYjRsNEc5ajM1L1BYcUFLdmJPR05wSTROdEdQV2c2RVREWGJ3?=
 =?utf-8?B?WWI5dFhqMUN5UWVxL1ZQd2UzSXdjbnVReXd0UnQyOHkxWEpwQktoS2JvRlFK?=
 =?utf-8?B?MUlXVlFzaUZCSE55ZkhjRm9UazkxK0x3aVdESzY0aEZ1bU10a2dpR1FtQ1dl?=
 =?utf-8?B?ejRkUGhyV3FVQ1pNaXdNQ212aVNuREJiOUI2WEc5SVF4bUdRVHMwQ2dOajRU?=
 =?utf-8?B?SGlPdUtOV0xGenJnbXRuVWZGOE16R2VDSHduYnBvejVoYTJVSmVBYWpVelF0?=
 =?utf-8?B?QmEwK1pHaUkwT3pGL2p2T2NQS3M4OThZREEwZmk0amlEU0xRT3NvSUFvaFpI?=
 =?utf-8?B?R1VMcWhhQUFMQVI3WkRCOU5UUzNzQ1RSTmhUSXpBTnNRdHZpMlMydnhQWno3?=
 =?utf-8?B?c1pUMUQ0OWgyQ2V5QStKTjd4MnFhVmdUNGtPN01BVHNtY2M2RGxEb1pDZkZP?=
 =?utf-8?B?YmZDR0pLbnhLYlBEMmI3eTZQeUlJTDRIOFRTUEYxZmJNZm9ST1hJc2dlN3Zj?=
 =?utf-8?B?ck1kUWowUUZSdTZHcHJUVGhRYTNBL3RwOGZ0bUU3T1dHRHFRMExWSGNMY0ND?=
 =?utf-8?B?dGpzUmh5dGNBdmtsaDg1U1BJY3VEaWtoWTBoL3JiWjl6amoyN3VMdlM1ZDRQ?=
 =?utf-8?B?S0R4QUtwWHVHTWFSUVcrTEo4VkJUZHV5eFJrV0VPM2hTVjBXMzJoeEZFajZk?=
 =?utf-8?B?Snp0djdUa1dmR3V4SGlLQVMvTFRmMElabTNBdzd4UGd4bGpZM004c2Yrb2t5?=
 =?utf-8?B?S1JpZkZydHF6alZXOWRKclVFTFhYVW5WOFo5TlBLVVBJYW0waUFVU2dIRlhw?=
 =?utf-8?B?dFg1SERhRUFjODVHTFo5dHNSOWhYallBS1U3SzRNKzBROURPSDJ4RnVkL2tC?=
 =?utf-8?B?MkZHV0ZqS1hIYmhMdmU5b3F1TXVock02VDNYMlBnOGVvLzFjVDhQQnE1enho?=
 =?utf-8?B?Mm05aE8vaUREcG1oY1ZnbFBWUXlJeW1rdDNOZGIzVjRjZjU0YmtnNGxPZDc1?=
 =?utf-8?B?ZmdkMEN5bkZQcy85SllidGtVMS8ySTVMVnV5VTBHTzdIamJuRUxxNmthRXA1?=
 =?utf-8?B?WjRjcmZNbGJrYmZFTHJ6RjlGMVRRamhRVEFPYndYOGR1L2gvR0svT1ZYci8z?=
 =?utf-8?B?M2l1dmlBSy9rc3ZSS1NNVFpsSjMxOWZiK0RpeXZsRDJQT3h4V05vRGUrdzFw?=
 =?utf-8?B?eXdzRXdDMk5LUVR6SG5Xc2NrSTRmYTdNMHJTZzlCWjNZZXptcm4vZCtxdzg1?=
 =?utf-8?B?dDhGSEhYMVZCNGlSMEFmTGN3SjdKNlk0clNuTjBGcFBZa0NJcEhGb08wa0dF?=
 =?utf-8?B?V21nbWZqblNVRzZpVEx0V3hFV1cyM3plOWNmdnFBSTRjc2pGWTh4R0hvL1Qr?=
 =?utf-8?B?RnZ5OHJnY1c0VkJ5bklPc2JOWlZXWE9NTnRSRmZGbGVXTnJ6ZndreFcySHZ2?=
 =?utf-8?B?MUdtN01pSW9tQkk5UVNzUHJMbWpCUk1xYndXa0NtUm1SM3BUeG1scXlCMk1o?=
 =?utf-8?B?bFhEbEhQU0p6elRmNURueVBaVUdXZUx6RWdnWkY5TktPVDBOZDZmVmVLRUJh?=
 =?utf-8?B?Zm5XaFZEMFBhem96L1lad0JJZGRLTlQ2a3hRNHRiei94MVU4SFNRSDVpYmxY?=
 =?utf-8?B?RXJYa3F4TUpZditzZEFsQXhwZ2FRQnk3SjRyL3creWZyaXF2b1JTWGNuQWZ4?=
 =?utf-8?B?ZzJQVHJnaWkvRnRQUDJGRm9aclR5RE90TDVYUjEzQU01UU9wS3RrN1hBMXNP?=
 =?utf-8?B?UC9YUHJlcWcrOVVwZURxeFFjb1VLWi9JZDFITkEwYlhNeDB6akgxOFBhMjdW?=
 =?utf-8?B?VEZGR2VJc3A4TllrNFpSbFAvYW54dzc3WUZSRlFoOE9wUGNOUTFBNkhDWjU4?=
 =?utf-8?B?bGw1UjBpbGtscFN3Y3dZWjAyMllSMnBBVytkMmNJZUc2UUI5MWM2N09PR2Jz?=
 =?utf-8?Q?TOJaWTZ2PW0SkY+C56fJWmtvaUJJpezNjWHs0zioJ1/X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDD7760B98314C4282C83D4C6962AECD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684e27a7-f903-42fa-d5d6-08dcfe2a63bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 06:15:19.4511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0FSjIUGJ/mrLJKoVxO8NVLrlF+cI7MpZw7SPp4ISazptp5gqGlMlVuijOUndiUy9kwEg/rwTwPcRpKZwf6cbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_221524_564979_02E7F633 
X-CRM114-Status: GOOD (  10.85  )
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

T24gMTEvNS8yNCAwOTo0OSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IE1hdGlhcyBCasO4
cmxpbmc8bWF0aWFzLmJqb3JsaW5nQHdkYy5jb20+DQo+IA0KPiBSb3RhdGlvbmFsIGRldmljZXMs
IHN1Y2ggYXMgaGFyZC1kcml2ZXMsIGNhbiBiZSBkZXRlY3RlZCB1c2luZw0KPiB0aGUgcm90YXRp
b25hbCBiaXQgaW4gdGhlIG5hbWVzcGFjZSBpbmRlcGVuZGVudCBpZGVudGlmeSBuYW1lc3BhY2UN
Cj4gZGF0YSBzdHJ1Y3R1cmUuIE1ha2UgdGhlIGJpdCB2aXNpYmxlIHRvIHRoZSBibG9jayBsYXll
ciB0aHJvdWdoIHRoZQ0KPiByb3RhdGlvbmFsIHF1ZXVlIHNldHRpbmcuDQo+IA0KPiBOb3RlIHRo
YXQgcm90YXRpb25hbCBkZXZpY2VzIHR5cGljYWxseSBjYW4gYmUgdXNlZCB0byBnZW5lcmF0ZSBy
YW5kb20NCj4gZW50cm9weSwgdGhlIGRldmljZSBpcyB0aGVyZWZvcmUgYWxzbyBhZGRlZCBhcyBh
IGJsb2NrIGRldmljZSB0aGF0IGFkZHMNCj4gZW50cm9weS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1hdGlhcyBCasO4cmxpbmc8bWF0aWFzLmJqb3JsaW5nQHdkYy5jb20+DQo+IFJldmlld2VkLWJ5
OiBNYXJ0aW4gSy4gUGV0ZXJzZW48bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KDQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=

