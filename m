Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C549D6B6BC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2pmiXxFHz05kAe5a1V86sAPq7+/8SzP1t6TYixMRrg=; b=lVgk079MSkpLohmyc3gBl+tbsr
	qUb+K3uhisycw81n2hTLWPyLgf0WSandHhhBOX9OCvxIKIq+uizx+RVFxjPlDybqoIdEXwnrMAKGw
	lTxc3NFl2vCJGsR++7f9phTnHVgGgJep9o+3XHD1K3qau+DIIHnwb7V8dOHV05EYOWBjxnfji7Yhv
	XnlMsWuAhgXPCmsKHrQcNKhIsQ6/a7cCXkZOjg/vHFUZi4/aqUfnlxoxhbjn7U5fv2noLIy68cKnV
	3q5KnKTKKxJqEuPlCYPpatpkJED56XP6539VUwLZYl6BBrvpUNyQVzHuD+R67zANCizML6VEieGJh
	TIRMfiZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6DaC-00000001RwZ-2Ttq;
	Wed, 30 Oct 2024 18:38:16 +0000
Received: from mail-dm6nam10on2061f.outbound.protection.outlook.com ([2a01:111:f403:2413::61f] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Da9-00000001Rvs-3TCi
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 18:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3S3tpWM8FVQwDY0pEbIZo8gKsLVjJsmAKoGTl9NRokBYQTSztvCCltitXNxBx3+uELfJYCeAZH6/PbJqUtLJ+dc4C1s5i+czuvhHfxPh+1UYes/VSnj+22LBhnTVTw8CZpu7dqlPN2tybSKKuUIaolY7/TaALNtdr8ODlmbECmVARFSQ9zHD64pM/snuay61K5zz3RBRzpbrY0Ly23T5irzKBuliOM8upFGeu4/lXAu8UMOJLcJmHPKlvjg878nS0aNaacpxRVrZwT/uf10ll5J8Rzue1iG4LkHN82HedMabPH/wl/rp+glKjLaODoewLJY1U12cstcauLmmlUFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2pmiXxFHz05kAe5a1V86sAPq7+/8SzP1t6TYixMRrg=;
 b=eUsh76PMxze5A06YYBFINfcjCt4bS8UJLzg6Aq+UQzZl0hlm3Gr0ofzIpNAZfBpriNo0oGKhqq0PFVQdYMUgdkrc2kTtVKpqzmNdD3XGoNUK9R6Nzr1PapovouowK/TJ+UEEkOzPdGp3vxU2Ia+r8NH0lAeag7AaOsBHUMSdv7buO+j2x+ATzGw/hBqf/ApiTF3uxQ4xbGetFJFk7+xmJYsNrLunGcp7D9CvyUFdn0VpgSowTV0WehpEUSkjnEqvxqgcjSKA/TRRoPrfim4/xKa+6a+gHMacRxWtfqE54uhbitOcRaQ3NDO8ff7KQQLJbhXcruIq2Ae0O9UOpl4y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2pmiXxFHz05kAe5a1V86sAPq7+/8SzP1t6TYixMRrg=;
 b=qKdnT+lRGMXJR/auo/3h1vFrcQ2l+63V7G8WEz3olHzjoJN0cMXnPzWBYpg65fKBkdKvDq57xy2zgTIUv0av9h0YoyjTxL7MtHuvNf6UQCvme/1QxiSgpC3oWTAN50QOLPKGh0UbsyLdpUPtZxeX+QOP76FV4ez4twcMWqtJ04/GerSvSrbLaRf6uul1HQNLf6H8vZDNDLBaNfB0E3j/d3swQ+pHu/8Ku8ABviCuIfgrNp9BsAuND0sFy+ZqEeUgc6ESMlA/33eW9e9XBWopGyr8eITf6qU63i2fh0NK7lcD1DakGGP9/ntzlvzERQ+Iyh2ACKKoWCTMEwhsybCZ1Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 18:38:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 18:38:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKaTLTwHNqlYqyUSj9qyQvVBFD7KdLMyAgAAcXoCAANuwgIAAYlyAgABQ5gCAAFAFAIAAekmA
Date: Wed, 30 Oct 2024 18:38:03 +0000
Message-ID: <1996168e-be7b-4811-91dd-c7782e955b30@nvidia.com>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
 <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
 <e666ea1d-2b6b-45dd-8903-2269e2143c95@nvidia.com>
 <d34e59db-66b1-42bc-93da-fa1ddcf658ed@linux.alibaba.com>
In-Reply-To: <d34e59db-66b1-42bc-93da-fa1ddcf658ed@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BY5PR12MB4211:EE_
x-ms-office365-filtering-correlation-id: 3c31f1b2-c3bb-4a46-aa50-08dcf911fd1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SUtVTyt6ZzVDdG0yQVg0TWFxTHE3RlpsQ1BOcy9IQ0ZuZ3lZejZQcmdpbXRk?=
 =?utf-8?B?RVM3YVdlNkNRZEJOMVBuTW9xeW1nL1NLdGltV3pqOG1uSjYxNnZHUVA0S1pP?=
 =?utf-8?B?K0Z0c2ZzTnphR3VQTENOclU2dStTOVFQTVBpaTFyUCtkeFBpKytXYVo1Z1Ax?=
 =?utf-8?B?eUN2emZGVk5ZNktTV3J1M0NqVFRNYmhMeUFiNlhGYjFTeEE2THVZOTRxMnZa?=
 =?utf-8?B?UlUzcm4zb0o4RGF4K0o3RloyOWtaV2MxcStFMmNnS05LQ0NiSU8reXBFQjFQ?=
 =?utf-8?B?NEVaMnJtSGw0NEdlY3NaVDZKbCsyUGxMc05VZGdpU0FldzNzSEFJNjNpSlZz?=
 =?utf-8?B?UVdTcmVoMFgyYjI4VUgrWHVlUUlJQmc1MCs3U2hQc0RqTUk0NFJTT0N6YnNE?=
 =?utf-8?B?bWFUOWJMSDVBUVQvT1BNdWg1elNzUmJwTHJDOVhHdmo4RkQ3bHVmVVM1YW9S?=
 =?utf-8?B?cWVqdmNId1NsRSs1SVRxalh6dUMrSEE1QU5zWktBYVJvcHpyWnpiWDFnaFZM?=
 =?utf-8?B?bkJmOXpmeW5IN0dBSFlOWTVmUDRnUzRIK2YvcUVya3RqUnBxc3ZGd1dvQ3d5?=
 =?utf-8?B?Zm5JQlp1ZFNsUEZVL2NheVZqYi9qd3hMd2xDMVNZUElnMTF2cko0THFIQTh3?=
 =?utf-8?B?VkM4Zmw0V1dIcE01UDZiNXJzYmlXWDNhV29rdm9wWWRGTlhiaDNBb0ZOUnlZ?=
 =?utf-8?B?OHpTeUMvaWhWQzVrTWRBbkx5MkVhK2YxNkNzT1lnYU5OUnd2dUhyWm53emdV?=
 =?utf-8?B?U1gxajJTbTFvdE1EcEdPTi9XancwV3JTRmVUSlF1S2xSMWhkeXJjMU04VkIv?=
 =?utf-8?B?aGtCY1NNQ0hZODhiR2czellsdzNHSTZWNDNLMTFTdkplaEhoQ1dsQXJob29x?=
 =?utf-8?B?bWRQUXhKRUtkQ2VjR3Q4dmRaQ3ZXUE9QMm5RSndVeU4xSWU2ZTZ5amNSS0Ju?=
 =?utf-8?B?QklYNWJwaDZQZ3FIV2dVQ053QVIyV3loL280TzM0MDZNV1hQdVprNVpMNFNV?=
 =?utf-8?B?REVMODJrY2wycTVxZGRjWHl6VG1rcm9kZVNmVmFrd1M5Uzc2WlpXbmpuOFla?=
 =?utf-8?B?a1dtL3ZDYVptNWREZWdTQUx6REkvb2RkWGFmREc0U2xJUUZ1Nnc5bXlmbVh6?=
 =?utf-8?B?RUxVT2FiZ2J1U2prc3FKY3pmZlh5QklSMGZNK01JSDJVMEcwTEZPeWtDclBr?=
 =?utf-8?B?b0pJZVYrTzJuUkxVZDJvbTBrWEs5aVB5alpCOEp0VnliaktOaUNJUUc0amV4?=
 =?utf-8?B?b0I3ak5GNit5QXdjT2tmRW5QR2lwQTBxb2tNdXhRVHV2MWJUejhvYXpMbjVY?=
 =?utf-8?B?Qy9BeWRkb0ZFRzZ4UHora3N0eXlYWHNSdjhkcXdwNWttUUxkZFptWnBmQmk5?=
 =?utf-8?B?NGJwTWtzZTBIdk5vazhVdVRxYXZxdTBoOXA4eWJwYXdMK2YrY1ZOek9kM25y?=
 =?utf-8?B?dWQvanJsUVZjelRtVHlzWUF4a3ZnSXlKUU9RL01IelpTRStkV2c0MTlXOGRv?=
 =?utf-8?B?L0wrWWZEZDA1ZUxZZ1FVTno0WEQ2dUVSZG1PdU12di93UFJPeDBHcHVEajBP?=
 =?utf-8?B?VGNORVp4YkJ0SkhKTEZrNGF6VmczbmxVVmRVQURLOThtejE1czJBbU45SHMr?=
 =?utf-8?B?ZTFTVThLNm9HYnlyODBOMU9JS1pOd3JOczM1bXFOSE1SenNHRFg3QmM2ZHc0?=
 =?utf-8?B?bkpYdHVMdndoTjNoMUt3K0loV25yNHkzQnNJTG1qekdFUFMrK0VRSXF2VTgx?=
 =?utf-8?B?anY5Y0tBcnhSRHpwYXVVdERsd1lUT1RZeG02aG1YSEx1ZEN2UGVOcDBORHRY?=
 =?utf-8?Q?/uAHbgVjV39COgZ6GQaceeWVZuUvTHB/sd00I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFdEYzRjakV2djlYQWVkQlFDd2hPWHRXREtIdUN3eXc5MFpaTmhqaDMvdDdH?=
 =?utf-8?B?ZGN2aFZIWUhYdUpPaDI4bG5BS3hyT3VzRnhEb3Y0WU1CN3NoQU56MHQxU01i?=
 =?utf-8?B?T3JrbG4vSUpITUhRVTltUFkvZWxqa0dDY1pMNjA4M3pzOHBncHhMWHRCa0p3?=
 =?utf-8?B?eFphR0JPNFZwc1BTUzhpVzRJRTRKVXdrUWg5QWVNTU43L2tDNmJ4R3BWVDkw?=
 =?utf-8?B?cGU2RVVPcmRDVkYrT0Z4a1ZGcDhDVEV3cTRyZVBLM2lXanByYitHR0x2QWJ6?=
 =?utf-8?B?bVFjZUhQZGtmcFR3dyt4Y1p1K1ZmbEl4dHZtZU9qWkQrOCtjR282WUlYbWVl?=
 =?utf-8?B?SDZNRHBnNzNrVWw0Y0RHWG5BT3YzeHVuY0Nqb085R0Z3aDBTWmdVRlNBNk1O?=
 =?utf-8?B?aG1FWWxGemJ2VlVoZmt6M1dIMUlZeERnNVJOVUtvN3lVSU5rUWkwZ3FJbzlq?=
 =?utf-8?B?VmVDVSsxc1NnUGw2bHVSWG5RaHQ1eXl2S2VudmNPeVQrZTBkeGlkRWIwV2lZ?=
 =?utf-8?B?dzRkUmowdzJHKy9qODR0SG5HTHRDTDh0QjhFbTA0bmFZSHlYUDBWekF0MVJT?=
 =?utf-8?B?b0tVd0Vmc0x3YVJud3lYd3dZSnpRWmFMcGZUOEVGbDV5a0RSZnpUc25FU1dG?=
 =?utf-8?B?WmxmOFhPb3VtcmNuWXV0bHV0V0NPeG8xQWJNUENFeG1DQ0M5Yy9VTEM1cmtx?=
 =?utf-8?B?Zml2MnlDczNmTXRLcDAwM3FtYmxIWjlkd0VlaUc0dy9OMFovN3krR1NvcEJt?=
 =?utf-8?B?aXdETVpMTVo4d2RzV2tQSUR5NUVvVHBFMmgxbVp3T2pLcjhTZzJUMG56eE14?=
 =?utf-8?B?OU1LZVFwQ1RyYTg1WmdaYjhFZjNPSkJPSE5HNTF5UzlzQzgyeVMvaWRIY3U3?=
 =?utf-8?B?RDVSb0JsbGFKbmV4aEQ4Vjc2Q0FrdFhLVFU5UU5HQVdQVlhMMTgrZHVySTBt?=
 =?utf-8?B?QmlPcmRDNmk3YzVRVkJsd1RiR28rUjRIQUZWZ0NlWWREYlh6SHhudnpvUnBo?=
 =?utf-8?B?TVdFdCtoZTRqcVZjdXYzUDNYUTExdWErV0VObm53SXN0OHorK0xOTkh4a3RY?=
 =?utf-8?B?UVpKaHVvanBqeWJXUnN2VDcxZElWTlFnMTdjaCtSdkNEUGVHMUM2eEtjS3FU?=
 =?utf-8?B?ZkRZR2FZdGthK09BMjE3VWZvdEdzRi80eVp1SEFac0dCUjlzcEo3WFdVR3V0?=
 =?utf-8?B?SjRKR3FRUm53YUZaWHhNTWoxZXRhQ1JVODh2QURhRGJYRWpwbWFQL3pveFc4?=
 =?utf-8?B?cVlUek5nenlGdTM0elQvVVVnU1R1Rm5DSVRSQytVK2Fqc0JQRzA5SmN2K21I?=
 =?utf-8?B?enoxckRJZDQ4WTJyRTNtZWNtcnNEU1ZhenhCYnFMSjV3UENFaTB2VDd0Z2oz?=
 =?utf-8?B?VW5kZGFkZkJjbXBYUFhwN0Jvakw2ZjFSVk9WODBxYmZ4QVphbVBZWWM4SUZM?=
 =?utf-8?B?alhCQmg5S01sKzdJZGhiRWpJazFMTHZISGdWbnBIaGNPR1gveEdhOEpiaXlL?=
 =?utf-8?B?aFlOMzJZcEY4dnQ0aXNYZU5IMXNUMXg1amg4TzViQUlINWFtc0Ezcm1kalRl?=
 =?utf-8?B?TjF4SUE3ZC9sVEUxRExONitqeHNOM250V2JpK0RHaDNoU0tsSHJWdlo4Qkky?=
 =?utf-8?B?bWZUcE5FT01wcm1oQUs1ajJGOUdJWDRacDkyeGcrZEdWSlVHZnNHTlBUTEJV?=
 =?utf-8?B?aTJ5bnhVTlFVbWxXSlJtQnpDNGlHOEk2d21SR0RvM3k0d2Q3QXFYRm9wbTBj?=
 =?utf-8?B?V2xBZFpzaVdGTEhJRk1hb0hhVmYxZy81QlFuS3pPMDFrYlVxT1RTOFJiOU1K?=
 =?utf-8?B?THlxMDRMVDBZQldRSktYUHF6aWhldXp5RjV0eGU3eHVCa0pUN1FzMWdXWUZ4?=
 =?utf-8?B?OWpycFQ4SW5TMnJtQnNaRXRZajhTTUJnM2ZrSFZHSng1MmlYTTN1Zktpd2JL?=
 =?utf-8?B?bHplOWZtU20raFZOODNvNW11UXJNaEgvY092bUgvT0dGL3dQS2piRGtLUXVw?=
 =?utf-8?B?SVlwKy90OXBEZFVXWUpRWXVBSlJtSXI3V0NkcXVDdmVrQUo0MWtpUHR0eGQ2?=
 =?utf-8?B?M0poZzdmbURXaWZRQWVaN21tVDE5dGZyak81M2lpb0hnRG5leXVLMEFHbDBO?=
 =?utf-8?Q?b0BFpFwWOayrZIGV6yJdIcL3b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC811F9B93B6A44BBE2E171AAF17BE80@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c31f1b2-c3bb-4a46-aa50-08dcf911fd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 18:38:03.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+v5QC7wj9e8Fe8yFlKecApgmzyLBOM724EYX8UhiTcy2X/RgjCTakFs09oOqvE7S8ZotmVEukogM3HCop63ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_113813_895526_4001235A 
X-CRM114-Status: GOOD (  18.82  )
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

T24gMTAvMzAvMjQgMDQ6MjAsIEd1aXhpbiBMaXUgd3JvdGU6DQo+DQo+IFNvcnJ5IGZvciB0aGUg
dW5jbGVhciBleHBsYW5hdGlvbi4NCj4NCj4gVGhlIHRyYW5zcG9ydCBpcyB0Y3AgYW5kIHRoZSBi
YWNrZW5kIGlzIGJsb2NrLg0KPg0KPiBUaGlzIGlzIGp1c3QgYSBzb2x1dGlvbiBsZXZlbCB0aGlu
ZywgaW4gc29tZSBjb21wbGljYXRlZCBzY2VuYXJpb3MsIHdlIA0KPiBkZXBsb3kgbXVsdGlwbGUN
Cj4NCj4gbWlzc2lvbnMgb24gb25lIG1hY2hpbmUoaHlicmlkIGRlcGxveW1lbnQpLCBzdWNoIGFz
Og0KPg0KPiAxLiBEb2NrZXJzIGZvciBmdW5jdGlvbiBjb21wdXRhdGlvbi4NCj4NCj4gMi4gUmVh
bC10aW1lIHRhc2tzLg0KPg0KPiAzLiBNb25pdG9yaW5nLCBhbmQgaGFuZGxpbmcgZXZlbnRzIGFu
ZCBtYW5hZ2VtZXRzLg0KPg0KPiA0LiBBbmQgYWxzbyBudm1lIHRhcmdldCBzZXJ2ZXIuDQo+DQo+
IEFsbCBvZiB0aGVtIGFyZSByZXRyaWN0IHRvIHRoZWlyIG93biBjcHUgY29yZXMgdG8gcHJldmVu
dCBtdXR1YWwgDQo+IGluZmx1ZW5jZS4NCj4NCj4gVGhlcmUgaXMgbm8gcHJvYmxlbSBpZiBudm1l
dF93cSBydW5uaW5nIG9uIGFsbCBjcHVzIG9mIGNvdXJzZSwgYnV0IGZvciANCj4gc3RyaWN0IGlz
b2xhdGlvbiwNCj4NCj4gd2UgbmVlZCB0byBkbyB0aGlzIHJldHJpY3Rpb24uDQo+DQo+IEkgZG9u
dCBrbm93IGlmIEkndmUgZ2l2ZW4gZW5vdWdoIGRldGFpbC4NCj4NCj4gQmVzdCBSZWdhcmRzLA0K
Pg0KPiBHdWl4aW4gTGl1IA0KDQpjYW4geW91IHBsZWFzZSBzZW5kIGEgcGF0Y2ggd2l0aCBkZXRh
aWxlZCB1c2VjYXNlID8NCg0KQWxzbywgaXQgd2lsbCBiZSBuaWNlIChub3QgYSBibG9ja2VyIHRv
IG1lcmdlIHRoaXMgcGF0Y2gpIGlmIHlvdSBjYW4gDQpwcm92aWRlDQpzdGVwcyBzaW1pbGFyIHRv
IGxpc3RlZCBhYm92ZSBzbyB3ZSBjYW4gZ2V0IHRoaXMgc2NlbmFyaW8gdGVzdGVkLCBldmVuIA0K
YmV0dGVyDQppZiB5b3UgY2FuIHN1Ym1pdCBhIGJsb2NrIHRlc3QsIGJ1dCBpZiBub3QgSSdsbCBz
ZW5kIG9uZSBvbmNlIEkgZ2V0IHN0ZXBzLg0KDQotY2sNCg0KDQo=

