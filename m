Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34761CAC5B0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 22:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxM0GpG3g/3jML5n0o+qj5Z1JDWGd4MSySaKf2nJgjs=; b=rTssp9LbnmH7nHBtvs8waTtfMK
	t3DcbdsELAj8Q9158DmgdlNodEEK5D/bv0lGhOeEfnHnB4PFrE8uVoGylzGoSnlfT6zmHFp/wGPxI
	JKP+m46McHB9mIjXLBNm519F867JGkd26XbsFliKbExpXtA2F12qS+5b+MN9rXDvK0gofBG7nPQuB
	YhLhpGFEiURBZOMVki/kLPQfRMGv7rvM7Uo5vBxsUbE82oT2LRUdToNhlFQNTDhJGSJNMaUxbLHy+
	M9sAyIQoy1m865UGLWoBXlOnfUcSENQ87hgJmw0zF8QciUOOfj1ZVGGrA94re18pXWQfEdojYdTPD
	nFTot5bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1u9m-0000000DS3c-3r7V;
	Thu, 25 Sep 2025 22:09:42 +0000
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1u9g-0000000DS3E-1NPS
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 22:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMdiulvXYyCtNhJK8HUWJG6/p9A/rKGXa5IdMuGoRrzeECHhvd8jLgbE4JWErYf+kNbGHEK3gX6QZBie5PlGK4/OCsWiLCu++5W/cZo6KEZoeISTDrEP+ZF8srdlFLOd0BPNlhCeijyWiZRZK58r5b6vTYPmJu4MowUKLxRHJIq2HvcQOmgPsfnWq0/hn5+58t+d7fZy85jrKFApGYSqJynhrLHEO5xdgsqCEl7J5bKR82AxBZeXXFcul+0PVznq5IShYQi1TIOzPJK1FoAui8/UCOTckqoQIE4o1tSoUj3rlnycpbt7Vf69GF090g5l+0VO4H8oMDxv/FHmRtaQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxM0GpG3g/3jML5n0o+qj5Z1JDWGd4MSySaKf2nJgjs=;
 b=tMERRMql5XYkKzKVgBiTTD01K8aBmgQZkP5fRRCvR1uhhmq3CaO5nqKcE6TjDrT4P5QAVw4eefkbknLO4TXrGbQJLKKc8TtZX5ZkQzzfZwkZZwHJOwPkQ1/6tU/2ioe87Ef+TBK9WjbVxoLcvRiMI/52v0pBBNx2XOGN/x1wewjARaoon3HKSwIWc4R18hZ7EqR5D1ULB8sR7Oxdxw1BCTcxIRIJvswxFwPHNXAhY26B/w9kFOV0FO/Kt5bH6TiK7C0yHakLkwTNLJ7Aquhyt1VAI9O5q52bT4pAdIM4Y6eqfb6V4CgO0Qr6i2XoCZTJqUsoFOo1pRie1sY6F+y9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxM0GpG3g/3jML5n0o+qj5Z1JDWGd4MSySaKf2nJgjs=;
 b=F16ugvw1uu9fQAs0eACymnRh4XdfRmo3UJ9xZir8hkVbEoNsZj6v+YC1bd3HlAgbt7POELB7ri3bA2pbHkOUeds2yOGEwAkSfud6w3/Uy95Ks0sytLzLd0R7/suskaeoyPirNtdcBC0Wrp2GkR37zOvuiLMwmpXFdSRP0sYEy02Svv1FwQ4RtNG9LuiNcLOjx23qxoqKimSi0y6fA4e8oVa2smGfbby1Nbs7rwBaIekEp1H2MxZbgLpB4nsY0e1+zcpplypbjW/qGJSaTjY+AV8S5nqtgOAhtCggu1l1UwJTaheQbaVq79ZgwcMEwqukZv2CoBFCT7OOA3PlcKWUfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:09:28 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 22:09:28 +0000
Message-ID: <8cf714c7-a692-4bcf-80f0-780fbc2c27b5@nvidia.com>
Date: Fri, 26 Sep 2025 01:09:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
To: Daniel Wagner <dwagner@suse.de>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
 <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
 <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
 <bf276b4b-9d1d-458e-84cc-b24969bc0995@flourine.local>
 <8f8d7c9a-02f5-47c0-8f8c-9aae6b969c73@nvidia.com>
 <cf51e862-53db-4fc7-b2c7-bde2ad31e4ec@flourine.local>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <cf51e862-53db-4fc7-b2c7-bde2ad31e4ec@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: acc385e2-097c-4a0e-0e8f-08ddfc8031b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkpIMFBpRS8rSXpTTU1xT0p1OUJaV3JncUFESGtqODlDVFdxZU9xM2ZGNERR?=
 =?utf-8?B?RkZsNEhyWHZ1WjMwRFVuTmdWYnJ0dTVVaVBpWmFGTjJ3YVlwS2FwTU9QbXpI?=
 =?utf-8?B?dGVaWUhKZWZobjgwNW1aVTVqQkdlWW50Nm5RNlRnbnB6ODlVNW4xZ2xlVXIx?=
 =?utf-8?B?c1FzN0JjemZKdVJUaUpHQUtLRGtwUDhzWG81dFJQUkhxREpjQitua29XQWlk?=
 =?utf-8?B?R1ROUDdFUUlXSVVPeEVTKzN1WUt1NTVhZjJJSHFXN2pkM2hYeGJzVzlEVFZl?=
 =?utf-8?B?SWlwYjd2andWb3Vpa3VqL3JFWU9ySDlGVi9GOWJwRkVrUnl3eUZFbUo1K3Y5?=
 =?utf-8?B?UTVFeEdLYUZpdVAzSnBsNUZ2aXpyUXNNMnRIYW5jUERlMms5NkRUMEdUbmRw?=
 =?utf-8?B?VmthaDFDcXFkaDUwSWhQODZwcDF3VXpkVWtRZlJoQVBIcWhnQ2dZU2VVdlpZ?=
 =?utf-8?B?eHZUbEp2KzN5NDhWSnpPaGVoWkpuZnRWdEs0d2hJWERlNTlXZGRBUHNUaHky?=
 =?utf-8?B?QkNKajBmcFZhTlRiOENlb2ZyL3BBaWpVT09aUDlhQ2Z2dzd3NTV4RzdHRzNr?=
 =?utf-8?B?UlhjTkw0SU5kMTBvZVRiZ05NT2NxaFhWTGJ1eDNXMzliZU9TV3NzbHNyOVhq?=
 =?utf-8?B?OElCZ3dTaFhrZlpHNHNEOXpvc2lpQUdEZDF1blROMmhyVlpUNHhKUVZZUk8r?=
 =?utf-8?B?c2pFRnZLOXY2VEh1dEJaemF4cTU0SXJZdCtaemZJWnRvZkU1WGtoTlFZUWpV?=
 =?utf-8?B?aFZrUW45cFZTdnE1M0o4ZlQzZHdBb1djMmhiNXA3YkxqVjVkd3lhSFVSTVg0?=
 =?utf-8?B?aVRxeG1IMmZheEtiSzNHYWNXcDR1b0NnVUlqYkdHczZMcE9WK002bjc1T0Jm?=
 =?utf-8?B?QlE4RmUzTFQyYllEQ0l2elhuY3UzSkM2SEtnbkZSaU5KS01RNnBEKzNrRGhD?=
 =?utf-8?B?dzdwTFFPNFo2ajlwd2x6TDRkdWF5Ump6OHVucmVzTkpxK1o3eUFYVllMYkJQ?=
 =?utf-8?B?RVJXOXVqdVIyWFNFb0pTRHAxQ3hFV0JTS0VNYXpGTzY2QXVxTklnQnZuWTEz?=
 =?utf-8?B?V3ZHN2RtQWhCeVpmNVVCZGRZYk9OUE9QbzB6SVNjVFlCdFJzVW5CWDNKTmcv?=
 =?utf-8?B?eG5Sb3NBY1I2VjJyY25teVRaQXl4WUxoTlZmYUUydzJ4dEFwd3ErOVptdlJX?=
 =?utf-8?B?bzdEeGFOa0lBUVFrZUdic3BpSFdhN3l1SEtrNGpTZGVMNFlIcHpXY25ERjhu?=
 =?utf-8?B?cE9xQ0RWS2d2c01Na0JldTZYV3gzQzc3SjV5VkFmdDJ4TzhxK2VZTWc3ampE?=
 =?utf-8?B?WUc5WVMrRzhmL1ZZb0ZnckpuVjk1SjVTQWJ2OFFUdEdFVlhYRzRWMVY2My9j?=
 =?utf-8?B?emxEczhxaHRWdTJiTXQzSFZOWkVxNjhPcDhCYzVoQ2VxNm93TC9UeFJ3RXhB?=
 =?utf-8?B?REJ6RFNRR2JOSll3RWhnQ1RYeVZuUW51UlN6c2VoUkFDdEEraDdvQ3VQdjdl?=
 =?utf-8?B?UEFXd0g1V1VrU3YzallCaEFzeThqRzgyVUFKelJ5OSt4WFF0Q0ozdlF0R01r?=
 =?utf-8?B?L1RVQVpEblR2UUZ4K3dHY2F3N21OL0VHL05aOHNvNXNtbDFxdjVIUGtZcnFD?=
 =?utf-8?B?bmdmaGpFMWF3djFYWTVsRVBzTkRFc1hHQVNUSW9JMFZORktyRnhSN3J1RUIv?=
 =?utf-8?B?NXcxMDU3WUFDR3NCWXJKNnMvQ1Q3TnZqbTNPQUNyNUlYcDh3UUJNbXBObzEx?=
 =?utf-8?B?S3FVdU1sY1QrNDBSYW4yK0luNGc2bHFRQjMyUEswdnh2VktVSTZNczNId0pu?=
 =?utf-8?B?cmNZOVNxSXg3clZ1V2VoNllPeUdad1I3citFeUVWS2Q4Umh5MUI2Y0g4TERY?=
 =?utf-8?B?OU5DUGYwT29jUU1BcWo3aUNkRitpZW1wbi9Yb29sY2VRb1dCZ2o4aHJTbnQr?=
 =?utf-8?Q?rjwKJoLKxAjX6xE8+Wo5wo06ejOWBOiA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWthK1ZsZFRJdzlIOEV2bzJpc2FDYm43L0tjVHM2V0M1dDV6R3JFV3lIbi9o?=
 =?utf-8?B?ZnFBM0x2ZkZzTEZIaDR6OW4yUStia05kZ1cyMmxQQlBtZVh4S09KNWgrMnFS?=
 =?utf-8?B?K3RWZENoZEZwZDNDMUFmRTh3dVZ6TXk1Q1Q5aEtMWktvdTZZZEhPTUZzai9M?=
 =?utf-8?B?b3VNVW9IVW9HYWl0ckltMnJMMVFPQlNwSUFWdG9MRW1xUk5tdDBiTGNjc290?=
 =?utf-8?B?bDRkalRVQVNzSnhSOWpGOUh0akJuZDlwTjY5M3dEZU10ZEhaS3h4VnJaSXBq?=
 =?utf-8?B?NzRHazh1SFhid04wYmNtUUlSaTVSeGxSMjcwRTNFM1o1UWpselNaSHlRMnpY?=
 =?utf-8?B?QnVWai85K1dNZFlnRU0zaUpzK1pjYlpuQmRWNGIxUG5IRmtacGw1MlhMWStB?=
 =?utf-8?B?U2tpL0QwWFRsd3BQclYyR1poQUh1RHVENUtZYVRHNGV0QUZuTzJKRFNIUGRj?=
 =?utf-8?B?VndLNDkxM2kxL1dPQzJ1NGcrMGhsVyt6elVBY0F4WmlJTXE1K1Q1VUxreEhP?=
 =?utf-8?B?NDNzcHhSM21qL3psakZqSGZRZDFoS05FOUNMVW8zRTRVcG9pSGNraXJYNlo3?=
 =?utf-8?B?YXp3KzdQWnZReTZiY0k0NEhqenp0Z3UrUThGNzNaR1VIMnZDYVk4bFpTbXc4?=
 =?utf-8?B?cGRkZEFPanVIVXNnblZRQjNMTXJoK0cxMmYwSWRneVN3SnEvMEx6RUVsZVdk?=
 =?utf-8?B?a0JXQlpRa2pVZUVhZm5teDMyblVxaG56QW1OSCtiUUVHdGFJaG9XY0RnY1lQ?=
 =?utf-8?B?WjBkNFNEUVFrWmNoKzFjSkRqWWhmL2tDNk1HTi9mUXE4citEekFtVG9JNWpk?=
 =?utf-8?B?alpjZ0Q3SDNzVU1GS2pzZ1ovcVhrVFZJK2NDdTI1L2VJN1lhZkhzR01semJN?=
 =?utf-8?B?em4xaXg4SllMbmZwSi8ybS82ZllJOFhCRDRkY1FnbTZZd2d1N2dUZHcyREla?=
 =?utf-8?B?Wit1UnlGemJBWmVQZU5NSVdocmtwc210WmVnNnBSYnJlZHVVYXhBV00zOVNE?=
 =?utf-8?B?TGpjejh2WG04c28vT1NkY3hKS0Rnb08rSW1EYitzYk1ZTSsrMktQbWhtL3JC?=
 =?utf-8?B?SXBKM2VYYU5MK3hDNGhKdVhFVFJxMzJWeExaRHl3b0xYUzUwWlQ3SnhJREsv?=
 =?utf-8?B?d1FQb2Q2SGRNRDlCekhlOEdIZkZ2aXhzclJlUmV0bkxJU0ZnZUhaM3JYMzNG?=
 =?utf-8?B?eUtteUljZWpWWk1VSXJZc2RzK3ZneDdPUlI5M3VRUFI5c0p4SUIyK05XYXp4?=
 =?utf-8?B?alpGSjF3bkhLOTUyTWx3S05jQmJJcFBHell4NVp4RFVLUVVSekd4U2xreEpu?=
 =?utf-8?B?MzI2dWl1Nld0RTRFNXE0bHRqUkowMWN2ZlI4UWNOdzVyNXZ5Qncrc04vTVRw?=
 =?utf-8?B?ZzA4aWhSc29iWFlVRU9lUHd2YUhoREZHaTFKVzZOVHQ1dWVsYVE2bld2OEth?=
 =?utf-8?B?aVJmVGM3RVFiUGVkbzlCeEpMaHhCekNQRHdWSVVoYkZKNGhSYXhUY0k0MHRH?=
 =?utf-8?B?VWhEOVRSUHpmTDU5WHYxRVFzRGF5UXl2OTgvYXFtSnVIb2lmYWlmN0VDd1VD?=
 =?utf-8?B?VWxhYng2V0R4TnVlU3M3a2RpTitCcTJnSzJoakkwZ0hWSTRwT1A1ZHpFQ2VX?=
 =?utf-8?B?VVk1UDFLTWEyelVzVDJHWFhGNC9QTWZ5WVc3bzlkVlQrbkdKOUtyS3U4WW0w?=
 =?utf-8?B?OFlYdklsNWVVUURkQ285VXIwR0txWEFQR2tHSUh0OXQ0V3BJdDFwSU13b2dL?=
 =?utf-8?B?emJlS3hqbHgzMERtY2FDa2ExK1oxeXQyZ0dMakxYN2pjYm9ZTEVsMmRaNkNN?=
 =?utf-8?B?NW9PWlRrZURiYXBhb1ZNMmdqL2pPQzRQSGtEYWMrUERmMFROOVVsOEhrWnBV?=
 =?utf-8?B?Z0hxcGplOWtWVDNibk5NNTlHQXN3OEFuRVZjTDNLOU5TUHpEeURDTkdsdjlU?=
 =?utf-8?B?Rno5T08rSEFOYWpaamVnYkM0eVI3WkxLRzM2L3lvWUMwQnhUTGRKYU12U3d5?=
 =?utf-8?B?Zy9iUEdiRDNVSTROUC9RdzQwZlYxMHBreTIrQ2FKWkYzaWpUTWpiZURZK0lQ?=
 =?utf-8?B?MStSd3RMNFFqOENXNDVtajFqWGp3UlVYRjUrVzdqNzRnWWdZbVp3V2kyU0Q4?=
 =?utf-8?Q?3OD1ZhgCusm6Imp9PLTuhIvhu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc385e2-097c-4a0e-0e8f-08ddfc8031b8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:09:28.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QytwXskDmPHznU0Mg7/LkHF4N8oVvMQ6F+Wc4GhuqZe9pKOG9O8nLcxdgJpAFnelsLP+KsBmvzwSd6lmQTLCwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_150936_415997_85F2B79E 
X-CRM114-Status: GOOD (  22.10  )
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


On 25/09/2025 19:02, Daniel Wagner wrote:
> On Thu, Sep 25, 2025 at 03:06:42PM +0300, Max Gurtovoy wrote:
>> Sure, test case can stay.
>>
>> for example one can:
>>
>> 1. create a port/subsystem with max_qid = 20
>> 2. connect from a host
>> 3. destroy the subsystem/port (this will issue a reconnect/error_recovery
>> flow from host)
>> 4. create the same port/subsystem with max_qid = 10
>> 5. reconnect attempt X will succeed and new host controller will have 10 IO
>> queues - tagset should be updated as it does today.
>>
>> WDYT ?
> I can't remember why this approach didn't work when I added the test
> case. IIRC, the fc transport was way too buggy.
>
>   set_qid_max() {
> -       local subsys_name="$1"
> +       local subsysnqn="$1"
>          local qid_max="$2"
>
> -       set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
> -       nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
> -       _nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +       _get_nvmet_ports "${subsysnqn}" ports
> +       for port in "${ports[@]}"; do
> +               _remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
> +               _remove_nvmet_port "${port}"
> +       done
> +

I'm not an expert in the blktests but it seems like we should do inside 
the set_qid_max() something like:

_nvmet_target_cleanup
_nvmet_target_setup --blkdev file (Add here --qid_max "${qid_max}" option)
nvmf_check_queue_count "${subsysnqn}" "${qid_max}" || return 1 
_nvmf_wait_for_state "${subsysnqn}" "live" || return 1

I expect the above to work with and without my patches..

If possible - lets try it also with tcp/rdma transports

> +       set_nvmet_attr_qid_max "${subsysnqn}" "${qid_max}"
> +
> +       local p=0
> +       local num_ports=1
> +       while (( p < num_ports )); do
> +               port="$(_create_nvmet_port)"
> +               _add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
> +               p=$(( p + 1 ))
> +       done
> +
> +       nvmf_check_queue_count "${subsysnqn}" "${qid_max}" || return 1
> +       _nvmf_wait_for_state "${subsysnqn}" "live" || return 1
>
>          return 0
>   }
>
>
> [  965.045477][ T1741] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2.
> [  965.049342][   T69] nvme nvme1: reconnect: revising io queue count from 4 to 1
> [  965.082787][   T69] group_mask_cpus_evenly:458 cpu_online_mask 0-7
> [  965.087982][   T69] nvme nvme1: NVME-FC{0}: controller connect complete
> [  965.357063][   T69] (NULL device *): {0:0} Association deleted
> [  965.390686][ T1741] nvme nvme1: NVME-FC{0}: io failed due to lldd error 6
> [  965.392129][   T66] nvme nvme1: NVME-FC{0}: transport association event: transport detected io error
> [  965.393259][   T66] nvme nvme1: NVME-FC{0}: resetting controller
> [  965.422856][   T69] (NULL device *): {0:0} Association freed
> [  965.438365][ T1788] nvme nvme1: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
> [  965.542093][ T1952] nvme nvme1: NVME-FC{0}: connectivity re-established. Attempting reconnect
> [  965.552933][   T66] nvme nvme1: long keepalive RTT (666024 ms)
> [  965.554266][   T66] nvme nvme1: failed nvme_keep_alive_end_io error=4
> [  967.473132][   T69] nvme nvme1: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport"
> [  967.475251][   T64] (NULL device *): {0:0} Association created
> [  967.476634][   T66] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2.
> [  967.479208][   T69] nvme nvme1: reconnect: revising io queue count from 1 to 2
> [  967.506681][   T69] group_mask_cpus_evenly:458 cpu_online_mask 0-7
> [  967.511893][   T69] nvme nvme1: NVME-FC{0}: controller connect complete
> [  967.807060][ T1985] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [  967.984963][   T66] nvme nvme1: long keepalive RTT (668456 ms)
> [  967.986014][   T66] nvme nvme1: failed nvme_keep_alive_end_io error=4
> [  968.029060][  T129] (NULL device *): {0:0} Association deleted
> [  968.131057][  T129] (NULL device *): {0:0} Association freed
> [  968.131752][  T815] (NULL device *): Disconnect LS failed: No Association
>
>
> This seems to work, there is some fallouts in the test case
>
> root@localhost:~# ./test
> nvme/048 (tr=fc) (Test queue count changes on reconnect)     [failed]
>      runtime  6.040s  ...  5.735s
>      --- tests/nvme/048.out      2024-04-16 16:30:22.861404878 +0000
>      +++ /tmp/blktests/nodev_tr_fc/nvme/048.out.bad      2025-09-25 15:56:00.620053169 +0000
>      @@ -1,3 +1,8 @@
>       Running nvme/048
>      +rm: cannot remove '/sys/kernel/config/nvmet//ports/0/subsystems/blktests-subsystem-1': No such file or directory
>      +common/nvme: line 133: echo: write error: No such file or directory
>      +common/nvme: line 111: echo: write error: No such file or directory
>      +rmdir: failed to remove '/sys/kernel/config/nvmet//ports/0/ana_groups/*': No such file or directory
>      +rmdir: failed to remove '/sys/kernel/config/nvmet//ports/0': No such file or directory
>       disconnected 1 controller(s)
>      ...
>      (Run 'diff -u tests/nvme/048.out /tmp/blktests/nodev_tr_fc/nvme/048.out.bad' to see the entire diff)
>
>
> But the more annoying part is yet another UAF:
>
>
> [ 1090.923342][   T69] (NULL device *): {0:0} Association freed
> [ 1090.924134][   T69] ==================================================================
> [ 1090.925072][   T69] BUG: KASAN: slab-use-after-free in process_scheduled_works+0x27a/0x1310
> [ 1090.926115][   T69] Read of size 8 at addr ffff888111efa448 by task kworker/u32:6/69
> [ 1090.927054][   T69]
> [ 1090.927329][   T69] CPU: 5 UID: 0 PID: 69 Comm: kworker/u32:6 Not tainted 6.17.0-rc4+ #651 PREEMPT(vc
> [ 1090.927333][   T69] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
> [ 1090.927336][   T69] Workqueue:  0x0 (nvmet-wq)
> [ 1090.927342][   T69] Call Trace:
> [ 1090.927344][   T69]  <TASK>
> [ 1090.927346][   T69]  dump_stack_lvl+0x60/0x80
> [ 1090.927350][   T69]  print_report+0xbc/0x260
> [ 1090.927353][   T69]  ? process_scheduled_works+0x27a/0x1310
> [ 1090.927355][   T69]  kasan_report+0x9f/0xe0
> [ 1090.927358][   T69]  ? process_scheduled_works+0x27a/0x1310
> [ 1090.927361][   T69]  kasan_check_range+0x297/0x2a0
> [ 1090.927363][   T69]  process_scheduled_works+0x27a/0x1310
> [ 1090.927368][   T69]  ? __pfx_process_scheduled_works+0x10/0x10
> [ 1090.927371][   T69]  ? lock_is_held_type+0x81/0x110
> [ 1090.927374][   T69]  worker_thread+0x83a/0xca0
> [ 1090.927376][   T69]  ? do_raw_spin_trylock+0xac/0x180
> [ 1090.927378][   T69]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 1090.927381][   T69]  ? __kthread_parkme+0x7d/0x1a0
> [ 1090.927384][   T69]  kthread+0x540/0x660
> [ 1090.927385][   T69]  ? __pfx_worker_thread+0x10/0x10
> [ 1090.927387][   T69]  ? __pfx_kthread+0x10/0x10
> [ 1090.927389][   T69]  ? __pfx_kthread+0x10/0x10
> [ 1090.927391][   T69]  ret_from_fork+0x1c9/0x3e0
> [ 1090.927393][   T69]  ? __pfx_kthread+0x10/0x10
> [ 1090.927395][   T69]  ret_from_fork_asm+0x1a/0x30
> [ 1090.927399][   T69]  </TASK>
> [ 1090.927400][   T69]
> [ 1090.943292][   T69] Allocated by task 64:
> [ 1090.943818][   T69]  kasan_save_track+0x2b/0x70
> [ 1090.944401][   T69]  __kasan_kmalloc+0x6a/0x80
> [ 1090.944907][   T69]  __kmalloc_cache_noprof+0x25d/0x410
> [ 1090.945507][   T69]  nvmet_fc_alloc_target_assoc+0xd3/0xc70 [nvmet_fc]
> [ 1090.946279][   T69]  nvmet_fc_handle_ls_rqst_work+0xd89/0x2b60 [nvmet_fc]
> [ 1090.947078][   T69]  process_scheduled_works+0x969/0x1310
> [ 1090.947689][   T69]  worker_thread+0x83a/0xca0
> [ 1090.948204][   T69]  kthread+0x540/0x660
> [ 1090.948668][   T69]  ret_from_fork+0x1c9/0x3e0
> [ 1090.949193][   T69]  ret_from_fork_asm+0x1a/0x30
> [ 1090.949744][   T69]
> [ 1090.950018][   T69] Freed by task 69:
> [ 1090.950493][   T69]  kasan_save_track+0x2b/0x70
> [ 1090.951015][   T69]  kasan_save_free_info+0x42/0x50
> [ 1090.951579][   T69]  __kasan_slab_free+0x3d/0x50
> [ 1090.952116][   T69]  kfree+0x164/0x410
> [ 1090.952565][   T69]  nvmet_fc_delete_assoc_work+0x70/0x240 [nvmet_fc]
> [ 1090.953331][   T69]  process_scheduled_works+0x969/0x1310
> [ 1090.953953][   T69]  worker_thread+0x83a/0xca0
> [ 1090.954488][   T69]  kthread+0x540/0x660
> [ 1090.954941][   T69]  ret_from_fork+0x1c9/0x3e0
> [ 1090.955504][   T69]  ret_from_fork_asm+0x1a/0x30
> [ 1090.956078][   T69]
> [ 1090.956359][   T69] Last potentially related work creation:
> [ 1090.956980][   T69]  kasan_save_stack+0x2b/0x50
> [ 1090.957522][   T69]  kasan_record_aux_stack+0x95/0xb0
> [ 1090.958158][   T69]  insert_work+0x2c/0x1f0
> [ 1090.958708][   T69]  __queue_work+0x8b3/0xae0
> [ 1090.959206][   T69]  queue_work_on+0xab/0xe0
> [ 1090.959703][   T69]  __nvmet_fc_free_assocs+0x13b/0x1f0 [nvmet_fc]
> [ 1090.960471][   T69]  nvmet_fc_remove_port+0x1c5/0x1f0 [nvmet_fc]
> [ 1090.961215][   T69]  nvmet_disable_port+0xf6/0x180 [nvmet]
> [ 1090.961895][   T69]  nvmet_port_subsys_drop_link+0x188/0x1b0 [nvmet]
> [ 1090.962683][   T69]  configfs_unlink+0x389/0x580
> [ 1090.963207][   T69]  vfs_unlink+0x284/0x4e0
> [ 1090.963722][   T69]  do_unlinkat+0x2b6/0x440
> [ 1090.964245][   T69]  __x64_sys_unlinkat+0x9a/0xb0
> [ 1090.964808][   T69]  do_syscall_64+0xa1/0x2e0
> [ 1090.965311][   T69]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1090.965978][   T69]
> [ 1090.966272][   T69] Second to last potentially related work creation:
> [ 1090.967076][   T69]  kasan_save_stack+0x2b/0x50
> [ 1090.967593][   T69]  kasan_record_aux_stack+0x95/0xb0
> [ 1090.968162][   T69]  insert_work+0x2c/0x1f0
> [ 1090.968643][   T69]  __queue_work+0x8b3/0xae0
> [ 1090.969142][   T69]  queue_work_on+0xab/0xe0
> [ 1090.969663][   T69]  nvmet_fc_delete_ctrl+0x2a5/0x2e0 [nvmet_fc]
> [ 1090.970397][   T69]  nvmet_port_del_ctrls+0xc7/0x100 [nvmet]
> [ 1090.971083][   T69]  nvmet_port_subsys_drop_link+0x157/0x1b0 [nvmet]
> [ 1090.971825][   T69]  configfs_unlink+0x389/0x580
> [ 1090.972396][   T69]  vfs_unlink+0x284/0x4e0
> [ 1090.972909][   T69]  do_unlinkat+0x2b6/0x440
> [ 1090.973413][   T69]  __x64_sys_unlinkat+0x9a/0xb0
> [ 1090.973943][   T69]  do_syscall_64+0xa1/0x2e0
> [ 1090.974476][   T69]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1090.975129][   T69]
> [ 1090.975410][   T69] The buggy address belongs to the object at ffff888111efa000
> [ 1090.975410][   T69]  which belongs to the cache kmalloc-2k of size 2048
> [ 1090.977002][   T69] The buggy address is located 1096 bytes inside of
> [ 1090.977002][   T69]  freed 2048-byte region [ffff888111efa000, ffff888111efa800)
> [ 1090.978600][   T69]
> [ 1090.978864][   T69] The buggy address belongs to the physical page:
> [ 1090.979596][   T69] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888111ef9000 pf8
> [ 1090.980717][   T69] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [ 1090.981655][   T69] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> [ 1090.982626][   T69] page_type: f5(slab)
> [ 1090.983067][   T69] raw: 0017ffffc0000040 ffff888100042f00 dead000000000122 0000000000000000
> [ 1090.984053][   T69] raw: ffff888111ef9000 0000000080080005 00000000f5000000 0000000000000000
> [ 1090.985165][   T69] head: 0017ffffc0000040 ffff888100042f00 dead000000000122 0000000000000000
> [ 1090.986228][   T69] head: ffff888111ef9000 0000000080080005 00000000f5000000 0000000000000000
> [ 1090.987286][   T69] head: 0017ffffc0000003 ffffea000447be01 00000000ffffffff 00000000ffffffff
> [ 1090.988313][   T69] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> [ 1090.989355][   T69] page dumped because: kasan: bad access detected
> [ 1090.990209][   T69]
> [ 1090.990557][   T69] Memory state around the buggy address:
> [ 1090.991315][   T69]  ffff888111efa300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 1090.992367][   T69]  ffff888111efa380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 1090.993417][   T69] >ffff888111efa400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 1090.994529][   T69]                                               ^
> [ 1090.995387][   T69]  ffff888111efa480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 1090.996312][   T69]  ffff888111efa500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 1090.997232][   T69] ==================================================================
>
>
> In short, nvme/048 should be updated and the UAF needs to be addressed.

