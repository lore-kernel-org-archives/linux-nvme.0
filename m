Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E655C76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8eiRNomGhDokfrXqi6d44XoRrOqOF7eKhjB2IlHU6g=; b=eSmmMK4iu3A57NjXkqHSu+Ztp7
	xWLNZqPtRb3DJvNCRGmB0J+uykaxU9Yx40ScRIbbOt2G1yXG9wgKPMvX3IUJ5v8DcG2ovWr0Q2u9t
	a6ZzCt0CcMypITemddhqmV8mDPbY61DS1dF2AyOolmLvasNIwWYmbiT1W0NVmgO2zU1cOoo2CXXZl
	3zmUDVeMVTth24ZgQMBy4nAKrOQXlBplypwuoo/khPJQLLzuZvNbXRY2mG74wJ/0lVZ60/jE7SwnG
	PZCPjqZ5ThfY7OAitMKnCmC9R2Dd6+/Z4Cq4tODAtgNawAsiVwItWh7npnWXUn++eY1+ROBQn/PBJ
	setm160A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgv5A-00CV6P-2G;
	Mon, 27 Mar 2023 22:12:52 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgv57-00CV4x-0P
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 22:12:51 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RM9w2c029141;
	Mon, 27 Mar 2023 22:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g8eiRNomGhDokfrXqi6d44XoRrOqOF7eKhjB2IlHU6g=;
 b=bU/XQ/nKuIVK3+q7ERWcD1YnB+L3HtNPTwzQH04vzevGmiGA0AXdFcNQhv5FVROr6fZk
 lKiOPgilBpbgrkLbhCBoLXhwConxapWLgJK+kjX3KpjjZqVt5BevkzhdrcghjRQGirKg
 RINptzE+8D6BkodbsHsG+h4g+AN+QFTM1/1UMyGNJheKz3QxinQQg8Rbic311QrCbjnH
 ZvE+BgEZVA4Vn+tViJDz1crMHpfa9YdApwzDvbhTXuOWA8Oo2gqe4BzSphyZoun23eDe
 RAgXsGyK9zzbgMKthzskiRN0MgMTIs8jOrkxWU/Dz+PBjTpqVgaVB6fdyF6s+ZASCa9K XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkkpk008e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Mar 2023 22:12:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RKZjQF032993;
	Mon, 27 Mar 2023 22:12:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqddbdvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Mar 2023 22:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYpM3MwNjD2kLQVJfhyHUnGqlcmLlhoPalElXIGxDOHktjQEoGeFVxwLuBBBANhx/n0IJ5jhZ3f4WhLSPxRkNqGe8ZZxDEkw6SXTx+Tf9fSqSvWFdpmH1OinuLo7xHD3AfOjyh3V8/67ScBWTL+3hWO/zvnuROVkBIwG9qvgAmReKQ2lTIE+sE6kg+WJZyUGIiYN4zSpNKQTnCEd1kmfyXTSRyQTNIpD6ue7+STJgRkXNSCiOmRJa4TVO4yauiVGkK3bGzipUgxtLva++bcGj7RFHQ2HvYfjPxk5Sux9x80uKFcAnZccub2PN5uw28s7Y8/NBkxhZiDNPao6qunifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8eiRNomGhDokfrXqi6d44XoRrOqOF7eKhjB2IlHU6g=;
 b=XZ7ICpN8ohBSNG6m/NbrZnN/2tsqaO/KgIXidkF8K0jX4pzpZ8ZcPQSNy8mU6Vck2KwTFkB3Fh6ld9B0QDiquaU12rU+f3fD977X7PGBcr+Ku8xB59ro2k8keaxnEIObcUntWutHRthyuxkNebYcHHhT+p1k6VSXJyYwRIdlFOZt4KXuXsUAf+kV7q0cEbngopGsVU6ZqhfGV39py66LdsBORIerlaOOvDQCBf5HI/55tYAeZ6E51PkLJAH1VYIA6pexb6W1xnOojSqz712FV3fsmYJF/DmK50fr0SR6HYwBBiY9s1Rhx0VlnIaGVDCh0x86S1s4lSDrDwAH/1cXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8eiRNomGhDokfrXqi6d44XoRrOqOF7eKhjB2IlHU6g=;
 b=HwSElGQ5eE1yDD7SmhY/+TvPkXtQWVEUoPaPhl/w9FNolDLIqpP3JbrYXj6PZM3D3Qpb+PfbcTtidyPCbbuGTHlSlNeM6Es7ZPymWMPk0SxMkB6+37KVpk+oQqDEaF9ZukoFnQMfsw2vQtHOiA3352NH+U6tEegtTfuHbe8+v4Y=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BN0PR10MB5158.namprd10.prod.outlook.com (2603:10b6:408:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Mon, 27 Mar
 2023 22:12:41 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 22:12:41 +0000
Message-ID: <cf2b63fe-2d92-66ae-2a4a-de7930cc87a2@oracle.com>
Date: Mon, 27 Mar 2023 15:12:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] nvme: fix error handling in nvme_init_ctrl()
Content-Language: en-US
To: Akinobu Mita <akinobu.mita@gmail.com>, chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <8ce877b6-5b25-e71e-9061-dcda19c2bf9b@nvidia.com>
 <20230327174406.10880-1-akinobu.mita@gmail.com>
From: alan.adamson@oracle.com
In-Reply-To: <20230327174406.10880-1-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|BN0PR10MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b50af6-4505-4ba8-beed-08db2f10621d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	C6cPQtOLbCBbfaqNyuC6rNOE+HmO8IU/zDa5ZOjR3MaMG9KuprV1bxddM6bMK1HkeSXTxmwnip79O8+Pzg5CPFGLB1rGn2m5J06nBs2gBhVozWqvvf6+edprEz9nv+7Lho4j9Yno6h4pgCsZuxoCAebNy86UaEmQJpt4XlU+jT5RB9w7GZCv2SN3j/0Mi1UrLXJlasFyeK0O1d+MbL2jbr3YEXeDgp06tcLUthQc+U5IOVnAV3OH1z73ZINoT8OI88t3GTa3ybvM5DZtZhVbDJ7dZsM0Wadd7Q21+BHUMB919IwbDr3N7pHTagj+g+CeoLErYExZX+kMdhtgwrxQm7M/9HOvwKYTtq+2LqDE7+EAIVcnlnbtJo2MKAPCsbFE+S8ZCUecw80769hV5SDX6jvSd+volxek/9YhD9LlqoRHgGORK9eW62SnUQBnRGca6OSkFjnfVfGYDo5vGCA+8MlxfIdzpsSisf3qfVBel40vSweN/V7E7kqc4DjMf6pfHAaMEcw2+EVJDsSvUKq80oIxsnOkqEFry4VigHubcERtDMS+kzNnUSnbExisNGkynS2MMmDb47jtoebYXgfJh518s0A2/oQML03oLSZaJjI=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(38100700002)(53546011)(6486002)(316002)(9686003)(86362001)(66476007)(31696002)(2616005)(966005)(186003)(6512007)(6506007)(478600001)(8936002)(36756003)(4326008)(66556008)(66946007)(31686004)(26005)(2906002)(41300700001)(8676002)(5660300002)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?T0lvSGFsSnRCclBraHdVdjNOMVRLTVFHUGt4L1RERzV1MGxpUVBKVXZPZlo3?=
 =?utf-8?B?Q2hUbUdIMDZGOWMvbDlKZ1JuaDU5RjFnYWZEL1NZVlJ2TWw2dm5FNFA1L2VO?=
 =?utf-8?B?aXNkRm9uMmR3MDRzdTlrV2llTmhpVlFGOVlaVGlFWVpqMTV6VkE4YlUrbU1J?=
 =?utf-8?B?cURtR2hjbGxZM2dEYTRLei90emlnZWd4VmNHc1EzWmttY0lRV2hmQi9uZ1ow?=
 =?utf-8?B?cWdWVHVSYnByZ0RqUFYzYzV6bWFlYnlMc1BCSkJwK3YzRm5vNkdaZmVmVzh6?=
 =?utf-8?B?TEVpVEhlSHptK085enE5SWNGYkpMc05KaWJCSmE2YjJjdGdGUXBRSUU3ZTBj?=
 =?utf-8?B?eWhVTW9mZ2lZZURvM09oVFNsZ1pNWlkxQXBTcktMdmVJRkV4OTVZK040L2lU?=
 =?utf-8?B?eit6Q3ZEK2lNcHRhVGpCN0dyaW1vdzV2RTcwSGtyQlZXbE1RTkJVN2VSdk5O?=
 =?utf-8?B?a203TVNaWkFiUjBaamZqVHBJWjFrUGU1a2QrNXJ2Z1hlSm16ZWM0dnRSblJD?=
 =?utf-8?B?c3I1REdHR0FZR0JQelVSMG1zWWs1Y3dFaTcyMkhnQVR2dFhvMHJvSnpnY2Fp?=
 =?utf-8?B?Zy85V0lsR09PUnc5elhQeDhDTTdzY1Q0YWNkMzB2ZzJRNk5QSVlQdlp2dlRN?=
 =?utf-8?B?ZTBCYXZodlZEMkgvNVpGeVBETURGUEYvWTlwU1k2WVlVeWNiaE5PVVF0YytG?=
 =?utf-8?B?QjF4anVIWHNlNkNyeFJLaHNMUUxhc3dyc21wNkpXYytFV3pva1kyL0hRejIz?=
 =?utf-8?B?SG90azR2Tlo4bkI5KzNlMGMvWjdjR2czeG9mNHY2bkI0cERvSU9mbzBSc2Fx?=
 =?utf-8?B?NjNoeDB5dTdKOGJFNVlGWVJWbHAwTmI0N2VjTmtFdGZ2R25Zdk44YzAyWVpz?=
 =?utf-8?B?dVkyOXcxclNLQzkxdUo3cjhseXJlSWVtSEg5aTZNa0MraUYyaURxeG93ME00?=
 =?utf-8?B?UnBockpTNjV2VU5Jbzd1N1Y2c01pQTc5YkJ6TmJJalhVRDJDUmcyMlhzeDdB?=
 =?utf-8?B?SXY4RGYwdDBiUHVyU0VTdXd6Z0podDNTZCtkcWJWcU0yVTQ4Z1FDbXFZT3Fx?=
 =?utf-8?B?SHNtVUl6TmhDYURBb3NsM1NGR2pBM09UeDlkU2RicWEwMzk2cCsxS3pBd2xB?=
 =?utf-8?B?TVJPWVVmcGtxNEgrQ0EzRi9ZQ3BCcmlUYThlY3p0SHVrdjZNSnhPQVV6ME1V?=
 =?utf-8?B?aUlJd3RiNU42aTMwUk9RZE0wVWlPVm0yMDhzN0ZTQ2c2Nys2bXhjY2hXVW0y?=
 =?utf-8?B?MHR5SDd6dkhUYXhTUjRwQVJVbi9ISERWV0lMTkQ1ZWpGL1l3Y0hIZldRa1No?=
 =?utf-8?B?MVNCcDJ6OVZVSGNQalplRHRVbE1TeHo1WFA1UWc4a1lRNi9kTlhGRC9NMzBY?=
 =?utf-8?B?aDhTQ09UUXBaR0Y2Y3JDQ1RxUE9GTUVRN0M1d1hWb1NKbjRFekpYUktuSjF2?=
 =?utf-8?B?TVRRQkYyMEJVMWZXTHRXT0hpRDFnbmNaTU5rZjhKbHVCZ2hYL1JuUzdYV0dm?=
 =?utf-8?B?cC9NMjJuMXU0MWhCdno3K2lVaEJNcFZYd3ZQOHBoa094OVJWV2k1S2dUT1k4?=
 =?utf-8?B?d3cyblNDK21GdU1uREcxdHBNcVpmMi9lMUM4cnpMRDlaOVBDdGgxNXNFdThw?=
 =?utf-8?B?ZlUvQzdrb3k5eDlMT0t3M3VnTUw5cGxUZGRubkw4a2dBRkNjTHpHVzJUZ2RB?=
 =?utf-8?B?MXJaWW9SM2J0dWp0ZFk1Y1poZWpBTktONnJKLzJSSWRKODVicVBEVUMxdHNy?=
 =?utf-8?B?YkpUd09pZmZEdXQrWVYwRXdUS0dUS3Nab1NIc2hsd2xSVHF4ZTlNczZ5WHZn?=
 =?utf-8?B?UVBzYUFuR2RpTGYyYkpBVmFBeWxXaytyMkVTeGcwZ2VMOVlMTkJ5M21PMFpC?=
 =?utf-8?B?RlRaNE5EanlaOFFmdW00Tk9LVTZvZnY4MU1ycWhRNjF2ZlhOVVUwcUthU3Zx?=
 =?utf-8?B?NUN5SVRqRjlxTHMvZnVKcVVvdUlDdXRteXI4NjF5MmRtTk53Y3VsRG1Cd2Nz?=
 =?utf-8?B?Zm5aZ1dFY2Y4azh3VnNiY3dTYU5BUmRRVUE3T2p2dVhHekVRZUlmcFV1ODk0?=
 =?utf-8?B?T3hvRVAwNTFOdkhPVTlIczVZMEcvUGpwSjBINlcrb2FtY0QxNWw3SWRkQS9w?=
 =?utf-8?Q?JFRoMQvRdo17LgO8M/HIKh08A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	ZRUfijLR9HNKtRzqam89d0dRhBE27cjyq5oXyxHbPTLh4Bm3wmUgJu4nCd0pEoL5koLQ85dhsEhm7SRHUdHGLBXHwNfGhaAEp+fZwM7QFEgCndGwxGNisrsdGkbG1f6Hizp79bullxFB1GJQagiEcsHX2RrVk8aU1MpSQBveYyJ/5twWj8UpgQppfmZZreHLGCpG5mfEovRDhxVm3r847pgY/c2XAi2/eBHGBboKSZaFPFBfkD4LMiji8tDQdzNt5I+RU3q4rqnYVOoRrCkgzQ2gDHwK25EqiayCLyWqGLb6+R2oX3hcb32zKVdUQ+iAlyEvTFMq77QZMWe9CkgyOrkUUb7H+S05JoToZuoYy74Y0D7KpWW+o2ICupJJnrNzwEwbEEzAmbd2qAvZWK6ietZ0u2BdM2TLH1LgmlL4GEQOIMD2QTjlFkbVyCIkw7Q6R4D6XLg0ziijQlQ9P9NWC+5sfhiULd3ROVq/oZni98qQpWWAJ0XNgH+PWaYUy94HcXtFZA9q0Lhhpkd5U7CDp+YcK4yHMGwq+75FXoEVEuM2ViifrUo8+i/KJPveFD4ibjQ7uI6Qu9WqMm5EuwtSVjZBDIvQ/sXt5ANSUcQALAtQiIGKFoM6Czt0zooUA04EpE7I5qdU2Mw62RIX5EF3fH4LRjUzkygZRgE9zEnegXZUkFYrYv0AFUKaCch0s3gKFmJUQXk843f+kctgSTvRjhHnCwOy9WkRSdYPUMlvuCdHv88AwB0Zu89cnORE8vL+BEwKmcXC6hPO9vfVUyAojvjYafi+jIEYA6m5050WRULNwOvlRjZM0yof2nxXFvzHVJ8JhISCVFz+K26/lGak0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b50af6-4505-4ba8-beed-08db2f10621d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 22:12:41.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8kEgUUZMHEsiWNj/c4pP1sNVfUahtZs4il9+23zqiPT3FeayrHl7zdg+eKpj69/odBkDFxNPWahJGTk/rpkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270178
X-Proofpoint-GUID: MLgYYrrcIJ-SczXZcGU-NGVu8T1N0e-_
X-Proofpoint-ORIG-GUID: MLgYYrrcIJ-SczXZcGU-NGVu8T1N0e-_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_151249_971234_454DF326 
X-CRM114-Status: GOOD (  18.94  )
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


On 3/27/23 10:44 AM, Akinobu Mita wrote:
> This fixes error handling when nvme_auth_init_ctrl() returns an error in
> nvme_init_ctrl().
>
> This problem is reproducible by blktests nvme/044.
> The nvme fault-injection debugfs directory was not removed after running
> the test.
>
> Reported-by: Chaitanya Kulkarni <kch@nvidia.com>
> Link: https://lore.kernel.org/linux-nvme/40baa75e-fdf5-cb73-5fa8-b12d65bce4e7@nvidia.com
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4eb62a7dac44..0545b3ea5a44 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5197,6 +5197,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   
>   	return 0;
>   out_free_cdev:
> +	nvme_fault_inject_fini(&ctrl->fault_inject);
>   	cdev_device_del(&ctrl->cdev, ctrl->device);
>   out_free_name:
>   	nvme_put_ctrl(ctrl);

Tested-by: Alan Adamson <alan.adamson@oracle.com>

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>




