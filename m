Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18363C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X0ieO8qyUdkp+QEd9JXEatp9LdLTzu+D8s4udNsa7Gs=; b=Nl5iOpzNLoUT/o2tT3I6216Cax
	Rxwv/8FeVXhyCRVdS/QI9s/0ICiSbcKZJ49pRYd3BLk2bpJPEDqZMA3bHdI996x9pQce1NdysgAYL
	/pqaeGAwZKU78p++hGx/LAuhjTT7lE5SN4Q32AC0bw/6iM5+Se2PLWHfovPHbi114KzXjDVpoMMol
	Vc6WOpU2q8LJeo7Gojy54TivWzXwiz28LGxpP+HVcL4psH7Wt69MW74SafeLepiMF/khoKv9cZDt9
	EVkfJ8W9JJRGTyae65CeH+7SsPALXJsueZ4yJCH2bL0JtoXRxajRiUGE3nxA6R6Pzh3Ijzz76VsM2
	P4Uf4slw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNrQ-00000005t1S-0MES;
	Wed, 26 Jun 2024 08:18:36 +0000
Received: from mail-bn8nam11on2062a.outbound.protection.outlook.com ([2a01:111:f403:2414::62a] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNrM-00000005szf-3QLW
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip6xylhk1ZzR7R+zF90ekAzcUgg/S5XVd8uC9g4GPuX1xM47C8QTJJ2qtidYWlAcfHsZTRJBFfpLpYk9+Rwd4i34DqAzsV3lZveVZlqK3pO3hQ96pFu3EUZdBP7YK2fUSzswIYY5KgHn64iApOj+BDZ1owd0h6XjcAVHfMl6q9KBuMXi2YeHp4uftQTBkBmlaj5eDfC8qyLNkr/pVBHbC7Uv0Tr4GsXsYFc8Vj1WltsWYUqtUIh6kzWognIecgR8JC1WDkjf4DGKuwTooaqnAqLoD2JlhTHqwIrim8TuflNnl4GSpdAcH2I+noohjzCU7kSd8CglRvKuVu14XdYPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0ieO8qyUdkp+QEd9JXEatp9LdLTzu+D8s4udNsa7Gs=;
 b=AKNWyavTUPmDDSGSpyjH0kuxRNeAsOxnT06dsMXwzMC8lYQNEajVjMTeDjMsF6JGexNMjnSiGN1wy7xdvISfH4x/CFF2JkHIG8DoLG+e5MVluvRPoay59f1IlA6+bttm4Apj1joDzWCZlskVh86qwg/iSwFjjCQXwgxb5C0GKMgeTiEwrl3dFQoU3oQASlYoqYelyJIFsak53SqYMVMvNUbZNjmAILyywJhKqYAAw7TQVF+ZeUd8JKW0fOddajPXKdT+9rqZ8tcDgCNAbVXkykkTR4ScPvn/xmLHWmIATpOZkCsDPRQ4uJl9aeEyJ1s3vIGDI+7sKfhQcQNtPpok/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0ieO8qyUdkp+QEd9JXEatp9LdLTzu+D8s4udNsa7Gs=;
 b=t2bg5ZXGap0HG7bKQS8ofQAJANiEe61Vb++xNZ8KH14IQ1MnBCAaebO5vd4zmNksZZQHBnscr7MYXF+MEeWJkf8EkDTQ7vQOdLzrSZiRDvdGswNNcukrQbIcH07IUQ0QvwguNc1CJ1msvlT+01b1OvDBMX5Wlb7dg/HJAEyjMA7NhU04LjPzxawHho9Oz17oe9P05as828RViZRg08BGDFjJ5bcRb7XYITnCmYiMtEFTRkOTVaAzuuAbdmRho3K8CopJhOXY66QFMhKlGlGxigfNzxV7jGyICgBLXv5jUDhm2I0mxnrPtSy02aruI0ZNzthdTEFpOJR6Q30LBQnbsg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 08:02:56 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:02:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: John Meneghini <jmeneghi@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"emilne@redhat.com" <emilne@redhat.com>, "jrani@purestorage.com"
	<jrani@purestorage.com>, "randyj@purestorage.com" <randyj@purestorage.com>,
	"hare@kernel.org" <hare@kernel.org>
Subject: Re: [PATCH v8 1/2] nvme-multipath: prepare for "queue-depth" iopolicy
Thread-Topic: [PATCH v8 1/2] nvme-multipath: prepare for "queue-depth"
 iopolicy
Thread-Index: AQHaxvrkf+lDDWLRcUKY2IuLBmbas7HZsIYA
Date: Wed, 26 Jun 2024 08:02:52 +0000
Message-ID: <0130bbae-8e63-42a1-b579-f122c55566d4@nvidia.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
 <20240625122605.857462-2-jmeneghi@redhat.com>
In-Reply-To: <20240625122605.857462-2-jmeneghi@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB6962:EE_
x-ms-office365-filtering-correlation-id: 1f67919d-fe05-4e3f-08a1-08dc95b6613c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?TXFQWnFPRUttVDBKQVpGVVd5KzVmQUFLZ3l2U3Z1LzR2VkZieVhmbU5RRktN?=
 =?utf-8?B?Mnp1WlNETmExN1IvZnBZK1hlZ2VhSEF3bnc2NjQ3eXovV1JGSkUxWWoyZEZw?=
 =?utf-8?B?Mkp3UWc4ZVVvbUdOekVtQmNvYStGZDZZZXhJakJtOHFDM2dEbnpvTFFHYTJ6?=
 =?utf-8?B?OE5GR284Mm9YQUk4WUNzLzB6YWcveWtzQnZ2K0xiUW4xQm1SNnNNakk4d2ZY?=
 =?utf-8?B?dkRKS3hYbVNWcmNhZ1BMR1M0V0hUNG5iNm8zYnlQaVorN0RNYnNuWDJSYnRa?=
 =?utf-8?B?WHNRaVlVK09xTHREQVhEWlJEWG45UWNRZ3NkL3QxWjl4UEdXK2V3VU5VcjBj?=
 =?utf-8?B?dzloYmpPNzYwbFB5bkYrcHp3WHNnUXRnSngzTEFPVHVIZXBUQVdLOHRQWU8x?=
 =?utf-8?B?ZlVPMFY1dGNQMitMUVF2SjgrK2RIUXlYbVZkNEJvZ2J1QWMzUGxXNFVDbmdw?=
 =?utf-8?B?T2Q2TWVjWlFDQUNwUU8zWDJTNmJ0YWM4U3gvVHFCK05DY1UxdWU1QnNuWjJ4?=
 =?utf-8?B?YmpMYThDVGhVM1NMbnROVGRQMnhVMnFyTndaN2F0akVXbFpESFo0RzZaSjYv?=
 =?utf-8?B?ODVUR2MwelhKQ3UrSUxMM0lvbTVBdDU2L3hHTFAxRGFuQmhpb3R0YU0wUENE?=
 =?utf-8?B?WkxkaHZaQVYxa1hjUVUzell1SW12UVc4Q0dzNStEdzJQRnF3cUY4ZWVVTmlU?=
 =?utf-8?B?QUhYcDNtQ1poUWdWWEhwTHptQk9vcVlub0E0M2RLNEFnU3cxV05UN1RBME0y?=
 =?utf-8?B?VWZIKzZoL3IwSWlhNm9YeCtidTZtVHloc0UvQ1YyR3BTUVRRL3g3RXZnMmh1?=
 =?utf-8?B?L2t5dHhZU25USXBKUlp4M2VDRnJuSi8zUkFoYTZjTUtkN1dZQ0U2U0pTa0hZ?=
 =?utf-8?B?TDdlZDVUTDJXS1BaNjQ5VnZJMlBqeXY2ZlI2VEZTUmRmMDViTnd1elg4bytV?=
 =?utf-8?B?YnhHOVNYeHhqMTM3U0hNa2xzZHdUK3JuWjJoSjJYVWJYdmlKVXVmOVJ3cHlY?=
 =?utf-8?B?VDRWTzVIWFF1RGp1SWtySGFQbkx3bHpYWlpKN3dOS2dtb1h5UU1zbTg5K1RO?=
 =?utf-8?B?ZWFtQ2Z0Qk04a09UMHZoT1V2S0hsanN0b1o2SWN4cUZHalFpSkFIZnpzK2ZM?=
 =?utf-8?B?TGQyZVN5MGVCY1oxaEVjT2R4Tlg4Q0k0Z1VhUmVaa2dzWDRyeS9qWm5haDRB?=
 =?utf-8?B?L2hLcm1aSW45SG51eTVPUkhLaFI2bDlSS3pwRlpNSG8vcGExT21ybGcyMDV3?=
 =?utf-8?B?cXRaMHRLKzN6WldyNFNBUFBYNFUzRGxnWTdaQ1Y3V0lFbmxSUmxYWUl0c1B2?=
 =?utf-8?B?UlFsRjhZMkJ2dWx3TGVwOVlVMDRCRSt4eGE4MDU3ZVVuMEx6YUZTU1diVi8z?=
 =?utf-8?B?ZWlEdENSV1k3dmJIbnc3MStTd0dqM2FuNUIvRVR6TXRKM3dHVm9aazA3V2VZ?=
 =?utf-8?B?QUsyQnBJc011dXI4T25MamV5a0ZBT28yYStJUlNqL0dQRG9xZFFGNEVWSWFJ?=
 =?utf-8?B?RC9oYjBMaUF3c1FBS2NEOUdwWHVteWVlN2tobXdUaGxoU3hIbk9KY2Y2ZVhP?=
 =?utf-8?B?TzRXN2lpUTVLTFV2MUVDTktoM2p4MkYxSGUvMzFHZ1Y0Q2NlQ3Z3T1gwOS9t?=
 =?utf-8?B?a2wzYzlWRU54ZEN1VVVrbVJiTkhQSTR0b0RaMkR0VTAvV0dGbFczOTZHZzBT?=
 =?utf-8?B?L0lkd1lDMnV1a1BSV3NMcnlHVFZFVTVjZGY5VWM5UERTS2x3K0RPSU1WUWlO?=
 =?utf-8?B?bGZhSWFvUUxReGFZWnpTQVJISlV1d3JSS250dkVDR1o1b1diRnUzU21od0Fj?=
 =?utf-8?B?djV2YytHVitBZkRLSStUMWN2WDlKeGdXdENLenFmVEg1ZU5oRkpzeitneVJH?=
 =?utf-8?B?b0ZpTHMwUzl3dFV1WWUxeEJ6bnNYQjJmNk1lVTdid1V6SFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVpjOVlkM1FUUzJOcHVLN3VUaUdoS0UrdE8vbGIrOUpBRy9iUFMwMmhHTXdJ?=
 =?utf-8?B?Mk5ZQ1JFelJOcUU3bDBZbmM5blpCdUNJSG1TM2pqVEFLUk1MYXZvN1drMGNm?=
 =?utf-8?B?SzhZVWdSKzUrR1N3ZVpCcHBzcm9ZeUJVSFNjVmxHNDJzVk4xRWVxb2N0NURp?=
 =?utf-8?B?azZvWlpZT3pPZEdyaWtEc3o2anRuVmZiVzVQVFNWUHR3VGZybTdsTlBmSTVv?=
 =?utf-8?B?MmFTVUJZNnRybWFXcFBnRXZ4YWN0ZUJ0SnJxOFBOYjBPV0pjYzcyb0RySDFm?=
 =?utf-8?B?NDI3UnFFalRZRCs5ckp0blFUa2Z2MHJHZ1ZSN3BUUG5paE52UTJTTG5zaHdw?=
 =?utf-8?B?MWJlNEVWLzVONy94SExUNXdONERvUVV3bFkvRnFjemxUekZyY2VqYjRrcW5x?=
 =?utf-8?B?RnJHZXk5RlhHeVlwM21HbkQ3aDRUV3Q5UVVNN2JmTFhUcEptcUxFYTQ2VXRu?=
 =?utf-8?B?MmxRVklZZTZxb0ZZU3RzSzdHUW5BNGhmUU0xNXg1aG5tM2RDd3pDS1ZCeVM4?=
 =?utf-8?B?d1JtWHJFRStwV1VEWDBLV2xYeVJLaTl4TklicUZGdGUxVzY2L2RNZDUzSU5M?=
 =?utf-8?B?Skg1N0VGbGpYL2toMnI1SkxUZUpabnZGQXFDdjhnMENpNFlGcGJ1SjdJRkoz?=
 =?utf-8?B?VmNBR05Tbk55R1N4N2JPUGlFb0o1SWt1WEpHWi9XY25DSHJBV0IvMmdwL0or?=
 =?utf-8?B?aDdBNHh4d2NxYzdwalBmUnQzTXVaWXN5andGRnVOeDdNeUhGTWhQUnc4VUpR?=
 =?utf-8?B?NFRyeHZqQ3locThQU2plUG1MTVRwSnoyYmhJUndxcUhRSCtBZ2gzNThPZWZL?=
 =?utf-8?B?TUJ4dWh4cFNDeUE1bHkrcVB1TVdRQ2FNcDlaU0krUEQ0WUEzdVJKYUw5S3Rt?=
 =?utf-8?B?NVZtWFFoVDZYOWx1SGd2TUhwVkljdGhzVEhMVnNXdm16b1Y4N2J4QUF0NkR3?=
 =?utf-8?B?bWc5bjhqSU82TTF4aGVObHhLZ1ZLRU1Vc05VeHFRTEdrR2J2VXV1K3hxcGlU?=
 =?utf-8?B?UnpaRERMMDVkMHY4b1U5aUprK05mK3pzRlVGWkwzeWlVWHFwR05kdm1GV3Jx?=
 =?utf-8?B?WDVFdVhZS1YveWVJa1JjUHJsaXJzdVo3UWRYMHhhWmZoRjZ1MHM5dFZFdkNW?=
 =?utf-8?B?NGhzOEZZVUdXNFdTQTJsM05mQXUvb3orSFIxQUcxOXBTb3JjbnZNejQ1OVdh?=
 =?utf-8?B?UmNUc3FpazdqVFNVR2QrYk1WZ0VwNVYxY3JvY1BudFhuUWUxVGpvQ3JZOGsr?=
 =?utf-8?B?Ymc5cEJ6d2pBbXdtQ3JERWhtdTRLSmx2djdRcmJTOTdSSFRTbDA4WU5zRXEx?=
 =?utf-8?B?MFJCYXMzSVVMWmY3L1VaejA1cmltdTI2NitxVGFVMUFBYnF3VlJPRThuM014?=
 =?utf-8?B?SzhJc09jNVJ4U0gwb251OUdSWXUrSjhKc3F2U2I0aVIySVJGeThBMHd2elJp?=
 =?utf-8?B?OUFjTlFUUEM3ck5rL1pzazAzVHAzRTJxRkx4UkYxdk1Gak9hYzZHZHVxYmRi?=
 =?utf-8?B?MWdjVkZ3RGJsTEFHNkI3aStWNVd0dGlsdVp6aUUyeFdGK0JmNThIeVVwajZn?=
 =?utf-8?B?OEtXam9rU2M5bXIrdWdqZ0RZTFhLWXNCSHA5dXdVVk9JSUNlamx4bFI4Y0dR?=
 =?utf-8?B?cW52aTNwV0I5Q2loaGJaNDlJNTl4b3h5MWJDb28vSWdYQTA1VlhCd0lvWi9N?=
 =?utf-8?B?SVJoL0I0cEhGdGZOdmVUUFFnMFMyVWYzSDEvZ2t5ZGFtMHBQV3VMS1p6K1pU?=
 =?utf-8?B?MGVTbDkyVm1Ka056V3RVb0ZkSWRiVEpYQWl6L2hMdzN5V01hYnBHL0t0dGlI?=
 =?utf-8?B?M3B0U3hscExnYWpGcWRTVjNHcWMyRHJBQWkvdUFNRWxzRk5QMkJrUExGZmFP?=
 =?utf-8?B?NWY3Wm5tUitjbFQ5SGRDZ2trQ0tWMW1BWUVTeXZtTEtLTUFocCt4aTlFZUk4?=
 =?utf-8?B?QnZGZkU0clBtd3d0SWRodDd4UDRCL01BekI1K2pvSmF6dXpOMWczRGkwK2Rl?=
 =?utf-8?B?U2swQ3ZZWkFOb3FpOWdxc3NMN3NpY0RRRGdwZFlhN01PY1NGQy8xc1ErTVdE?=
 =?utf-8?B?Q2hmS0ptUVZVdnVqTTdVKzlWQWV2ZXdpTExzWW5ROHFWczdqNzRRZEtpZnEv?=
 =?utf-8?B?TktleDVIdk52RUxteW04R3lXNmkxWWErUHh3NkVSS0xjWjlYdkFtQ0c5T0lD?=
 =?utf-8?Q?DCXLxtRsY0C/BC5UgT1j+PbkV+JSAhC+tJSNAUSj3IoE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E5D4E544A2CEB4A837FE6AC2B7CA826@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f67919d-fe05-4e3f-08a1-08dc95b6613c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 08:02:52.7412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/n0l8U+QqBj5U945uTngOOK4VZNvBoHX9bIxiM19jnt9bU+2rGVQVH8AwwxqaFljr0IFhX5v+XoktsEbl8KGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_011832_959967_04A3392A 
X-CRM114-Status: GOOD (  18.92  )
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

T24gNi8yNS8yNCAwNToyNiwgSm9obiBNZW5lZ2hpbmkgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggcHJl
cGFyZXMgZm9yIHRoZSBpbnRyb2R1Y3Rpb24gb2YgYSBuZXcgaW9wb2xpY3kgYnkgYnJlYWtpbmcg
dXANCj4gdGhlIG52bWVfZmluZF9wYXRoKCkgY29kZSBwYXRoIGludG8gc3ViLXJvdXRpbmVzLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIE1lbmVnaGluaSA8am1lbmVnaGlAcmVkaGF0LmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgfCAyMSArKysrKysrKysr
KysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5j
IGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMNCj4gaW5kZXggOGE0ZDBlMzc3MTE0Li4w
YWRlMzc4ZTUxNGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5j
DQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jDQo+IEBAIC0yOTEsMTAgKzI5
MSwxNCBAQCBzdGF0aWMgc3RydWN0IG52bWVfbnMgKm52bWVfbmV4dF9ucyhzdHJ1Y3QgbnZtZV9u
c19oZWFkICpoZWFkLA0KPiAgIAlyZXR1cm4gbGlzdF9maXJzdF9vcl9udWxsX3JjdSgmaGVhZC0+
bGlzdCwgc3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMg
c3RydWN0IG52bWVfbnMgKm52bWVfcm91bmRfcm9iaW5fcGF0aChzdHJ1Y3QgbnZtZV9uc19oZWFk
ICpoZWFkLA0KPiAtCQlpbnQgbm9kZSwgc3RydWN0IG52bWVfbnMgKm9sZCkNCj4gK3N0YXRpYyBz
dHJ1Y3QgbnZtZV9ucyAqbnZtZV9yb3VuZF9yb2Jpbl9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQg
KmhlYWQpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgbnZtZV9ucyAqbnMsICpmb3VuZCA9IE5VTEw7DQo+
ICsJaW50IG5vZGUgPSBudW1hX25vZGVfaWQoKTsNCj4gKwlzdHJ1Y3QgbnZtZV9ucyAqb2xkID0g
c3JjdV9kZXJlZmVyZW5jZShoZWFkLT5jdXJyZW50X3BhdGhbbm9kZV0sICZoZWFkLT5zcmN1KTsN
Cj4gKw0KPiArCWlmICh1bmxpa2VseSghb2xkKSkNCj4gKwkJcmV0dXJuIF9fbnZtZV9maW5kX3Bh
dGgoaGVhZCwgbm9kZSk7DQoNCm5pdDotIGFib3ZlIGxvb2tzIGxpdHRsZSBiaXQgb2RkIHdpdGgg
bG9uZyBsaW5lLCBJJ2QganVzdCA6LQ0KDQogwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMg
Km9sZDsNCg0KIMKgwqDCoMKgwqDCoMKgIG9sZCA9IHNyY3VfZGVyZWZlcmVuY2UoaGVhZC0+Y3Vy
cmVudF9wYXRoW25vZGVdLCAmaGVhZC0+c3JjdSk7DQogwqDCoMKgwqDCoMKgwqAgaWYgKHVubGlr
ZWx5KCFvbGQpKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gX19udm1l
X2ZpbmRfcGF0aChoZWFkLCBub2RlKTsNCg0KDQo+ICAgDQo+ICAgCWlmIChsaXN0X2lzX3Npbmd1
bGFyKCZoZWFkLT5saXN0KSkgew0KPiAgIAkJaWYgKG52bWVfcGF0aF9pc19kaXNhYmxlZChvbGQp
KQ0KPiBAQCAtMzQwLDcgKzM0NCw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBudm1lX3BhdGhfaXNf
b3B0aW1pemVkKHN0cnVjdCBudm1lX25zICpucykNCj4gICAJCW5zLT5hbmFfc3RhdGUgPT0gTlZN
RV9BTkFfT1BUSU1JWkVEOw0KPiAgIH0NCj4gICANCj4gLWlubGluZSBzdHJ1Y3QgbnZtZV9ucyAq
bnZtZV9maW5kX3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkNCj4gK3N0YXRpYyBzdHJ1
Y3QgbnZtZV9ucyAqbnZtZV9udW1hX3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkNCj4g
ICB7DQo+ICAgCWludCBub2RlID0gbnVtYV9ub2RlX2lkKCk7DQo+ICAgCXN0cnVjdCBudm1lX25z
ICpuczsNCj4gQEAgLTM0OCwxNCArMzUyLDE5IEBAIGlubGluZSBzdHJ1Y3QgbnZtZV9ucyAqbnZt
ZV9maW5kX3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkNCj4gICAJbnMgPSBzcmN1X2Rl
cmVmZXJlbmNlKGhlYWQtPmN1cnJlbnRfcGF0aFtub2RlXSwgJmhlYWQtPnNyY3UpOw0KPiAgIAlp
ZiAodW5saWtlbHkoIW5zKSkNCj4gICAJCXJldHVybiBfX252bWVfZmluZF9wYXRoKGhlYWQsIG5v
ZGUpOw0KPiAtDQo+IC0JaWYgKFJFQURfT05DRShoZWFkLT5zdWJzeXMtPmlvcG9saWN5KSA9PSBO
Vk1FX0lPUE9MSUNZX1JSKQ0KPiAtCQlyZXR1cm4gbnZtZV9yb3VuZF9yb2Jpbl9wYXRoKGhlYWQs
IG5vZGUsIG5zKTsNCj4gICAJaWYgKHVubGlrZWx5KCFudm1lX3BhdGhfaXNfb3B0aW1pemVkKG5z
KSkpDQo+ICAgCQlyZXR1cm4gX19udm1lX2ZpbmRfcGF0aChoZWFkLCBub2RlKTsNCj4gICAJcmV0
dXJuIG5zOw0KPiAgIH0NCj4gICANCj4gK2lubGluZSBzdHJ1Y3QgbnZtZV9ucyAqbnZtZV9maW5k
X3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkNCj4gK3sNCj4gKwlpZiAoUkVBRF9PTkNF
KGhlYWQtPnN1YnN5cy0+aW9wb2xpY3kpID09IE5WTUVfSU9QT0xJQ1lfUlIpDQo+ICsJCXJldHVy
biBudm1lX3JvdW5kX3JvYmluX3BhdGgoaGVhZCk7DQo+ICsJZWxzZQ0KPiArCQlyZXR1cm4gbnZt
ZV9udW1hX3BhdGgoaGVhZCk7DQoNCm5pdDogLSBlbHNlIGlzIG5vdCBuZWVkZWQgLi4uDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=

