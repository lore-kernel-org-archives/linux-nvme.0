Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC38C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 00:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CH5Ac2Z5JDyrwRFU+ZPDzr1Nlw/DuYvMje+8jcyO9lo=; b=B0Ms9oL+rKDByoEemjpt2Ae3ao
	4chJkekykJldj02MGyZEYzdbCQHNWvTLutKBbuk3PGQCBuzyMw+ajd1kiSnC8Jq4sHaPysxtSQBJL
	IoCx9rha6HhDqqVt9xOq/+yNBWR/2Bt2Z5HBoo9UMzwQnQiSiapV6SWFObpTAXel4B1EhdqPn7Yd0
	oFr2NQ0rkM0tPkySq3xMbBCmAqz/nK1CAvgujCWpdAI/y3Ta0ekEZKM8Hw2m6XbU8youhEVT0BSBa
	TAopxuwXAG3x7s5W9o+FXcZviJO/O+7ppGx3b2lsa2PCiptNPo0u2aUTxm2jb/liCiOa4AH3YOvAt
	vXqAE4Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubTWY-00000003dSM-1xO6;
	Tue, 15 Jul 2025 00:27:58 +0000
Received: from mail-co1nam11on20619.outbound.protection.outlook.com ([2a01:111:f403:2416::619] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubTWU-00000003dRc-0oyZ
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 00:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAnEEfmst8lxnAkkIxt2uB0V9WmwOXq0Bp7v3MmNwysr9zr0VN7Pii0m8OCSg+aQzuTPdBFE7/8bEGuw5rBUFAIo1c3lHJXBJFRW2gYx5Dapma8nxSR5Z+JqtyipI/mQ2WRGjvObjngqrJ4TbQ5dkfi9rts5q5LNeSN/8d9n2uq6n0Dwc28ed8Zpl/79sgyzJcJGzZBg0cKeoAmA/NLFCeJcge0H4DjPST4fJlkz0z7fcABl4vJkG3eCV03jLPhfgybBI9Vau8Ss7vXPM+YDfwayWtwz/4toCVSIlJoK0FSX79g5zwLlx1uHmUmxijcdy+4ALONz01U14jiycXnyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH5Ac2Z5JDyrwRFU+ZPDzr1Nlw/DuYvMje+8jcyO9lo=;
 b=mxrcO4zYUn5BucDFtjoZqm2B8t8uTYXsfr6mw+uaQXvpses01BbKdeGhMbkyFM/biLwYis1NlFSXDkmNUIRgxbIIYMtyo5x77+RAXjo477cU5Jtgk3AGYmFUJodUPDB/pKzlFc4tC7W8/HxOJSzsGydHV1Au3T1kU3wPJ3EGGsnKdKmvq4EMrUR5BC5XUpIRWCofPVNac02FejbwQsfUSMzQ7hAFc60GkMjNFk2Wd4fcyTJqh6IrtHUsC0wWaEKxFvT5bQo8s7+eBnysISpHMsTB9jXgtLIaoD9GrpaSRAWTXfkbZbTsBkwYgzP7n3DfMJITmYdSCSPedPnUlzCyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH5Ac2Z5JDyrwRFU+ZPDzr1Nlw/DuYvMje+8jcyO9lo=;
 b=tksK0Wkojzxvjt4EORe6MR6oJo1LzSnC8bVngo9Jsg+l8nepozZg0m0f37jPXg61/9bAN7FBw8sC6F55DhEZ9rnABAGnd6PCby1/hgDXbNtSXGycfmDbuoSJHgvC9hqF5RnSafLDwU9jwBhZWkQ1+hjz/e+zpoKmorQcyupMHNHEebvJrvgDWPeBSZHZAcONzt+O/zZTUMHhOeyI3UkFjo74TuVzyvgGKh3sw1rxAoZ4BTWL981Yy7zkJGyYIJn7t6qMxqdiVTyQljmItwBhPq0wtFMz+l6pfk75HaMWT1GGBnUoEUC2SKjmzL7+3R413DVfOlTzZL+NYpea6ik/gA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 00:27:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 00:27:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: try function level reset on init failure
Thread-Topic: [PATCH] nvme-pci: try function level reset on init failure
Thread-Index: AQHb9PA2yrPUzoHpUUmlzRFymUcV5LQyVLCA
Date: Tue, 15 Jul 2025 00:27:45 +0000
Message-ID: <a3dc9e19-8c2b-4985-9426-627ba084e855@nvidia.com>
References: <20250714171328.681885-1-kbusch@meta.com>
In-Reply-To: <20250714171328.681885-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4297:EE_
x-ms-office365-filtering-correlation-id: b9d96c9a-b1ee-4344-d286-08ddc3366bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cU9WTHJIRVVqblFyOWhvZG1USk00VFAzMkZlSDY2c2Q1S2ZmZW1CbnJHaURI?=
 =?utf-8?B?UGNIMVFoNURUckNlcW9MOVd3M1UzaTZGbmxMa0gvcWRabTlLdlI5YXRLYjdn?=
 =?utf-8?B?Wnlkem5KdnR6V1NncWhhTVFjM28rQ09yWXdsYWdoWFo4bnZtNHRFUkpVZFVo?=
 =?utf-8?B?Y0JScURERVQ1Q0pqaDZ1Mk5uU2dvc0ZTRStTakp3dzRBTHp6c2F5YVNqVldz?=
 =?utf-8?B?d013RlMraE9GVmZGNlpvOGpMRXhJTDQvcVlaeFp1VStPdlRnZG0rSGpGbHMw?=
 =?utf-8?B?UEdCVzl0bTlvUTBRL2R2dkxhcjNoQ3psQ0g2THRNY3ByWjFCY3ZLcmVRVE9L?=
 =?utf-8?B?a3pnMzdhd2JldDdtY2tNdFIwOGY3R0YzOHV1dnZyZG0vWVFCME5HR0ticC8v?=
 =?utf-8?B?R1BzT203azlFdGo3RDFxTEZjT1NZeTJVZEdsSitBL0E4KzQ0RlF4d3JKSW5i?=
 =?utf-8?B?eGdzT0o4eHBpRU0zWEdXTThMdkJmS25PUkNPd0QzSEZ0T2Vrdm9kVjk1ekZ5?=
 =?utf-8?B?eEl1ODR4MWRZbWJJT1FKL0ErVmNPSTJPdkR4UTVpcWx3R3pJVmNpUlVuaHN4?=
 =?utf-8?B?M1FvWWJDTkI5YlhoQ3l0dEYxZk9iaVk0SG1QM0luNFV3M0dqR3NmSWYyRCsz?=
 =?utf-8?B?NHp5RzdaUlVLaDZKdDhLb0FkK0lIbzZETEdwZ2dsV0NWUE40TWxlZDdBaURI?=
 =?utf-8?B?NktIaEkvb1EvRWpvQXI2cVZLV3lYUGdVSGZxSDdGUzNSSHlrWGNWeXBxRXlu?=
 =?utf-8?B?VmprTTh0dUUxSmszQ1ZoVThWcG5Lc3pmRFZ4RUVJM0JjU3hGU1dHT3NLbCs0?=
 =?utf-8?B?YXNrV0RBcnJUSW9Kd2NkWUROdEJKUHJVSDBuOEI1RWhNSUZrK3hyU1FZMnNG?=
 =?utf-8?B?cEZmdmt5ZWRJczBSZkpQbmY1bUg2TUU0bnFmSnRhR3c5cnMwK20yanVESUJ3?=
 =?utf-8?B?ZFJjQ3ppc0dPK0drU3pqekFXZ1p1dlV0OVMzTHZrcEt4LzRYVFRhVkZnaVQ3?=
 =?utf-8?B?ZDNNNDFwMDZDc01oNWNwSng1RHl1UitHRSt6TVpjQzM2TUlWSFgvMEpBUEZl?=
 =?utf-8?B?WlZaWlplekk0L3lXck9jVTY0RmhwYW53ZmF4WnpuNVBGUWsrajBVTWhab2lh?=
 =?utf-8?B?YXpDYVZodVZlYnFsaTZUcVk4Y3hBK0s0Mi9WbHFNQzlPZW5uMG5uZXFIQmNI?=
 =?utf-8?B?ZUw2eGVOTWhJcmRVc3ZkYVNNc0ZtT2RGWFdqOTNnRjJLK004RUNmQTYvbkQw?=
 =?utf-8?B?Y2xzUlB1Q0xJUWZjbEx2SW5lTDU3QjhtSzMxNnBVSkFWV1dqRHFSUGg0NW5Q?=
 =?utf-8?B?ZkVWbmRFOHpJWVlodWlLaDBxdWg4cU5KQzc3VStFMFJQUXZOdEUyQktIcmZY?=
 =?utf-8?B?TkxVOERtM0d0YzV3MVFhOTJ2Q2JIVmhRSjBJK0EwZnFNK0V1TVRseTErNnkr?=
 =?utf-8?B?RmhTaHIraVM5UDNTVXBNbVNMQkUwWlREL2hLYzJxNXhtVUFQb0Myd3I5VEhl?=
 =?utf-8?B?WDl0aEVUTXd6cmsrMXFrbmV0d3JsNjNLTGVSQTlpNjE4dzl6eUZ2SDVrZUhR?=
 =?utf-8?B?N3VYUUZtSDVEOGxDODB0bGZYQVNtaFZkZWNZWEM1QmVUZWxVbWo1TlJSam5m?=
 =?utf-8?B?ekRCN2tuNE02c0I4eTMxU082ZnRjTFNpc2pUbnF2S295UC9VSUJCRE9LMVdn?=
 =?utf-8?B?eXMyU2VpVGxxdXF1cnE1RmpSZ0Y3S2QyamJqVUw1T3JQUWFlOVZwcm51VHZG?=
 =?utf-8?B?M3A2eTQ4OXZCOVlJcmlLMnk0K2E3Q3dhTzNLYnBBWXpaSWVBcW8vVmNpRGVK?=
 =?utf-8?B?NlZRT3pkZUczWWd3Q3Nja1lONFd4NjE0WlZ4VHlnTUVnUklzWFJwNG9obnp0?=
 =?utf-8?B?K1NhV3lTK1NYbWEvSVVucVVQbFptTTV4cXl1ODJoN1NWSmdKR3NZanZROGl3?=
 =?utf-8?B?dmhuZlduT0dLQlFUeFRkQjBsY2YyeE41NzQyUkJwRVUvdDFQbU1JcERpQ1k3?=
 =?utf-8?B?YlF0d3l4ZkZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhTcVBPTlpINXprcVMwODJyOG9UOWhkQXVURlhMVnZ4Q0wzVy9hRlB0cmV2?=
 =?utf-8?B?TkFwWlVsaTczQ00rdkxqeXBXM1VPZjZQTE0zdHJiUnRaN2RqdUJYdlFVMDYz?=
 =?utf-8?B?Y2JWakorSGd6R0lQSHIwa1BGSVJjQ3ZLWDV0UDBiNnRGVTVrbE5TMTgwY3hv?=
 =?utf-8?B?NXJDT0JYanJ3OTBQZEs1KzNocnZsaU9ZV04vaHdmN0RTYkRDOEtjWklTMm9S?=
 =?utf-8?B?ak9JS2JqQWdIUEliR0JuM3lqZDdmSHRxdG80MHRJblU4NTY3ZUFKZTdyY2hV?=
 =?utf-8?B?dGNSUlJKOXVQSnVXczMxQ1ZTOCtyUGdnYjVXNGxxN2h6MVhISFlmSWo1T2ZW?=
 =?utf-8?B?K2VWaldWTEZ6MDY2VG9kMnU2alp1TE8wVEt5Y3BnSEpLZkRzNGNYREZwRFIz?=
 =?utf-8?B?UTNNaWltN0tMYXdnTGxWRmtvRjBBVVF6R1g0cmFZSnJXeWdYcXFDcDlhNUxN?=
 =?utf-8?B?bWlFTzRtazBxaDl3V1J5Rit6N20yYmRVZE5qaFd2QTFWd0lpL3JrMi9sYnNv?=
 =?utf-8?B?cXBvcEVwZW1JTnVOaE5ZWDlTWnNCVTh5VWxiM21VQjNLUVlsdGVHbjdMbS9F?=
 =?utf-8?B?MHRINzFsYUVSMXlERHhlam5OWWltTTlCM2JGdUt1cXlXd204ZnhFd2RpeERQ?=
 =?utf-8?B?QlVNM1lBMXU5NXhSZjU4MC9uQ01XYWdRUm9zMGVHak1XMEd0WTdMc0kwMHEx?=
 =?utf-8?B?Tkp3aCtkTE9SM3N0SWdxc2RESW5IMlRCNVFHY3FRQlhWYVZxMTRXNHp4VUJ1?=
 =?utf-8?B?eEdUM1lteURvUmxLcmdYalpoSXB3RmwwR2F2dVBzN0dHa3h2cU13TzVNaUF5?=
 =?utf-8?B?d3ExOFFrTDdzZUVJbDlhRCt5NjdiYjdjMmZyWG8reFJxMm9pd2h5SGZ6UG8y?=
 =?utf-8?B?YlRPSVZ2N1NaQ0xZdndHVHhHNlp3T051Zy9IRGEvcUpqeUdBOTg1WG0xRXA2?=
 =?utf-8?B?RzNhSTVtZkNhTHZEdy90dHpGelp5VXpTYlFnaG05MXRvZmdQMGpLeGZhcFdL?=
 =?utf-8?B?L3BkcFpTZHV2TmNodFFFUXc2ODdBRUFaYW4rV29ZTTY0eHVrNUgzbUtjYVVy?=
 =?utf-8?B?U1F1QWpnOFRSQ1B0eXVKdTY0TDlZSXhDOTh3dGFHdGZlWm9qM001VXd6UGZO?=
 =?utf-8?B?bWlkbHhWaVBTTmR1VE9jYWNvd2k0QTJYRXVUZmpmc2pIbjFIbXNMVU5JK1hH?=
 =?utf-8?B?QmswVzRQdE9nTDB6SWtrM2hGcjY4YktXR24xbXVSQ0RPU1JWRys1cWVmQUZ6?=
 =?utf-8?B?WS9rbko5UElYWHZ3RXpDdE00NERRYzNiU0pGR0dPZDEwR1ltam5ydC80ZUxk?=
 =?utf-8?B?aTUxdi9uODdtZlVPOTRCdjk1MVBjSnNBUDB4RjNXVWpQV0JibkRWS0N5M3dC?=
 =?utf-8?B?UGRNekptSnZ3bitQKytIK3pzaWw1VC81WkovR1pLTkpVT2hyUXVndEVPdFcz?=
 =?utf-8?B?U0Zrek1lYVdEcjBnbjk0NWhaVUZoUzRUcS9IMGprZGdidzRLYXpuQ3RucHk2?=
 =?utf-8?B?a3N5Y0pCZlNwRytWZkhuTDhqSmc3NndUVHpIOGU0WWtHMnQvR1BERUZOTjJo?=
 =?utf-8?B?eVBaa0R4WEdxSGZhMmhaZnRCdUsvWDFYRmNVRlJsemtkSXRrRml5WGRVQ0tP?=
 =?utf-8?B?SVhNYzdXME10SWVaRTZMYmJtelVoSWw2L2s3UEI3aDVTNXZ4N1ZpOUkrQUVh?=
 =?utf-8?B?R2t3dTRCRmd1NkI0NDV3RHp5Z2NsYnZEM09HTk9UeENwaGhPSWsxTGd1YVlE?=
 =?utf-8?B?S3c3NUtVQk5sbmV4NWlzRUVkTW5XVVVsMXJwaVFXZ0RhaFVuRUtpWXBFWEJq?=
 =?utf-8?B?eVBxRjlsY2dNbnhXMEU4bVdRcUdJaFZ0RFQ5RE9YUU52WEJvR2k2OFRZWjFu?=
 =?utf-8?B?MGF2eGZGNEI5NnVpaVhZbHc4dkNiNGF1b3o1STRpZHBkSFpWNmR2RVBZN0hJ?=
 =?utf-8?B?dXZNQnJyWUpMZWdBQnpXdm1BNXY2eUZLOFZyaTlHMXRPQWRNNHZWdFBFcloy?=
 =?utf-8?B?R0Y1S3VGRlVDNnhjZ1czY25IL1ZCTlNpMFJKOVRPNEM3TUgwMkttTzFpTjZD?=
 =?utf-8?B?cUpucjdjQjVKaDQxc25EZERkV0dBcEttNjZRaXg4ZkpFaGVCSUpnSVdrVFlG?=
 =?utf-8?B?SDlQbHZBaW9Pajl2M0RRRXRqanJxMmpvRDRFdCswSkoxVklWbFJ6M1loMEZn?=
 =?utf-8?Q?uQu9PvXDz24X5pKtlRTWeCyQiRm2uE+ukYmB1xjp5kc7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B13D235D0B75824DAAFDB9DA379ACA39@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d96c9a-b1ee-4344-d286-08ddc3366bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 00:27:45.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uK8CNh30HJoMAnI4+FcMly13ZCUtI2EkTkNN7conqHL/R5mW/MZB0dQb4S78m55qfXD2YkdfmjGr0SiEhAsvTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_172754_426917_328C9D95 
X-CRM114-Status: GOOD (  20.79  )
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

T24gNy8xNC8yNSAxMDoxMywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gSSd2ZSBlbmNvdW50ZXJlZCB2YXJpb3VzIG52bWUg
ZGV2aWNlcyB0aGF0IGZvciB3aGF0ZXZlciByZWFzb24gYXJlIHN0dWNrDQo+IGluIGEgcmVzZXQg
c3RhdGUuIEhpc3RvcmljYWxseSB0aGVzZSBoYXZlIHJlcXVpcmVkIGEgcG93ZXIgY3ljbGUgdG8g
bWFrZQ0KPiB0aGVtIHVzYWJsZSBhZ2Fpbi4gVmVuZG9ycyBkb24ndCByZXBvcnQgYW55IHByb2Js
ZW0gd2l0aCB0aGUgZGV2aWNlIHdoZW4NCj4gd2Ugc2hpcCB0aGVzZSBmb3IgYW5hbHlzaXMuDQo+
DQo+IEluIG1hbnkgY2FzZXMsIGEgUENJZSBGTFIgaXMgc3VmZmljaWVudCB0byByZXN0YXJ0IG9w
ZXJhdGlvbiB3aXRob3V0IGENCj4gcG93ZXIgY3ljbGUuIFRyeSBpdCBpZiBjb250cm9sbGVyIHJl
c2V0IGZhaWxzIHRoZSBmaXJzdCB0aW1lLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNj
aCA8a2J1c2NoQGtlcm5lbC5vcmc+DQoNCkkgaG9wZSB0aGVyZSBhcmUgbm8gc2V0dXBzIHRoYXQg
YXJlIHJlbHlpbmcgb24gdGhpcyBmYWlsdXJlIGFuZCBva2F5DQp3aXRoIGltcGxpY2l0IFBDSWUg
RkxSIGFuZCBhbnkgc2lkZS1lZmZlY3RzIGl0IG1pZ2h0IGhhdmUsDQpidXQgSSB0aGluayB0aGF0
IGlzIG9rYXksIGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9w
Y2kuYyB8IDE0ICsrKysrKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+IGluZGV4IDRjZjg3ZmI1ZDg1NzMu
Ljg1NzQ5ZjE5ZTNhMjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+
ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+IEBAIC0yMDY3LDggKzIwNjcsMTggQEAg
c3RhdGljIGludCBudm1lX3BjaV9jb25maWd1cmVfYWRtaW5fcXVldWUoc3RydWN0IG52bWVfZGV2
ICpkZXYpDQo+ICAgCSAqIG1pZ2h0IGJlIHBvaW50aW5nIGF0IQ0KPiAgIAkgKi8NCj4gICAJcmVz
dWx0ID0gbnZtZV9kaXNhYmxlX2N0cmwoJmRldi0+Y3RybCwgZmFsc2UpOw0KPiAtCWlmIChyZXN1
bHQgPCAwKQ0KPiAtCQlyZXR1cm4gcmVzdWx0Ow0KPiArCWlmIChyZXN1bHQgPCAwKSB7DQo+ICsJ
CXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYtPmRldik7DQo+ICsNCj4gKwkJ
cmVzdWx0ID0gcGNpZV9mbHIocGRldik7DQo+ICsJCWlmIChyZXN1bHQgPCAwKQ0KPiArCQkJcmV0
dXJuIHJlc3VsdDsNCj4gKwkJcGNpX3Jlc3RvcmVfc3RhdGUocGRldik7DQo+ICsNCj4gKwkJcmVz
dWx0ID0gbnZtZV9kaXNhYmxlX2N0cmwoJmRldi0+Y3RybCwgZmFsc2UpOw0KPiArCQlpZiAocmVz
dWx0IDwgMCkNCj4gKwkJCXJldHVybiByZXN1bHQ7DQo+ICsJfQ0KPiAgIA0KPiAgIAlyZXN1bHQg
PSBudm1lX2FsbG9jX3F1ZXVlKGRldiwgMCwgTlZNRV9BUV9ERVBUSCk7DQo+ICAgCWlmIChyZXN1
bHQpDQoNCg==

