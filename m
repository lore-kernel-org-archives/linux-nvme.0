Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09ACC3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 20:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2cU4FICIn0o9UpbdZPDPSTDrVdqxB9uOy71f3a9qSdE=; b=zdUvHgtxYDrU+zi0YzsVh4aOra
	0a/otQoXyt7EdnPIHukTKRHAoBgDn61t1RjfJiIihBSP1Rr1R4rW/4XskhNE3Uuqt/RIX1qePb7da
	d/3XHeUV15+oQg6655h2O9c8F8iVwRILUCzp+D5Sl2dhUIIrG1+MzvlpeHxi+PXedmGWnBHMqsxL2
	F4r/EcJlTb5Lv1K9dF/Raa5Kt3fxGWOhqjT6G/2McMiJjf3NYvc0S2OmZq5HVFC+1d3BB3ezV9J9I
	HII2PKRPoOQIXVnSwexV7iiZmXf9v2KU6sbBO6PwqjjjoAGvkNmPDouCY36O7zUCw7ncCm1Fp5lO8
	RuZnTR8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOWV-0000000DJ5c-2DAJ;
	Tue, 06 May 2025 20:04:15 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKkS-0000000CbLg-36FH
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 16:02:27 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546Fq9sQ006556;
	Tue, 6 May 2025 16:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2cU4FICIn0o9UpbdZPDPSTDrVdqxB9uOy71f3a9qSdE=; b=
	kBfZUrG6/yp9Q+wXP6I2SdNjtKe1p1xQ1P4m9AQVBTx9aEqK9rYqDMRAfmsdj5nF
	1jb5H9g6wYOEhOGenPj+H0nIQHXASuQ+QmGVXlicrDkfMprit2R6EN1cB/56pEda
	GMfhf5bkGy0EL4J5gNSuz81ObGIzLBXXqp43eKUdcvRhD1VfZAQaAfp/cV+5nUG2
	g4D5U8VoTJsrUbNX4G0cd9sTAQymBicy3PnXxwOncyar3x47p8HswPmppCzYyOzB
	8Hki1GEzz2rUIo38uYXLDMrtg0xNjHAE1EkqVMIAXizGPwbF+qIAmi+Fm7Ky7N2+
	zrxLJRXVm2O4v247CbEQiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fnen00rw-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 16:02:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546F4RIU036182;
	Tue, 6 May 2025 15:57:42 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k98138-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 15:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpS9k9CV+iGEQI7vuUP3mG8dpunPWtBc/Ka6ycWlQCRvMLTJ2W0sdgnC5h28aBnWmz0/UXS8kQzxYg0rdKqwgF/4wuhmL6jzCodDUb/BeFMrQXOlkYN1PiYcQTebjKpksVa7SOKPHzRv9fT+zYShLH1MniE0B0T1UczfxiftwR6bc/6CtGpeJM4uSdhSOG76DtyFjV5Ulxq8X0TmhqRUbp/s9BtT3snnhatsMrWtrlmJP0zu/jM7xGCBtoCfDe26DKtslOjMJuHGTntm2YNu3vfXHbshi4PBNCuSNVEV/33D8ggOJUFgKB1dKnfy2D+QRIfsxPnBq5jqRperY2KwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cU4FICIn0o9UpbdZPDPSTDrVdqxB9uOy71f3a9qSdE=;
 b=MecZUgIOL6mmhIalfwtiqaN0ly3RJvIVIDmtCAEob9Kd2sM7bLaUcaihlJH03gCDp8k+ROSXVgbIr+A6yVTsbH0fSLyLONh+npgomiHB4pLT7cWs+To32Zei07n25BwDggqaIgOzG8Ed5AR1/s3C0HlR2IX5Rgy74njEP+DxsmlAvbFveYZV/KS18banZoiSa1R0x9u3ZWoxrnYCHSrf+4wKbClJnoL0sKvFboh3QXA2Dk+M8R9Bo9QQAeBFQ1jCsDpsYa0LcT/TZvVPst6y32/SLGtPL/aNPVSlQkMz0Da27kcXw3sAU3q+PI0m6ZD7bN3+oDe9t1Zmis13cdeitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cU4FICIn0o9UpbdZPDPSTDrVdqxB9uOy71f3a9qSdE=;
 b=q+xbKeb8OB6XS4iNlbSPPu4gDF0IiLYLumc/OgRYrw1cQEG+7A9uHOg2qM/2v68sh/Wos4EJ46kPAGxtKUedB3L+5YKWznCRvfTckxZ6fJRtINNUXJ2Hqlkihy6nZOPyeLGrMW2IVHJY4mrqumcn8bCsbdnJGiyG1RxF6oAdROQ=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DS0PR10MB8008.namprd10.prod.outlook.com (2603:10b6:8:1fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 15:57:36 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 15:57:36 +0000
Message-ID: <e8a55150-54fd-4519-977c-2468aa573137@oracle.com>
Date: Tue, 6 May 2025 08:57:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: all namespaces in a subsystem must adhere to a
 common atomic write size
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
        sagi@grimberg.me
References: <20250430171830.1494033-1-alan.adamson@oracle.com>
 <20250430171830.1494033-3-alan.adamson@oracle.com>
 <20250502065239.GA8227@lst.de>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250502065239.GA8227@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DS0PR10MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc8f63c-a3e2-43e2-65f6-08dd8cb6b869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0gvRjFlNGVtdUoyaVFYRm8zZ0UrbWdFV1hiWjFFUGFCN0tNRnNyWHdxY2t2?=
 =?utf-8?B?TmdoWkMwUHZaNklzdCtOcFNmcVdvQjVYdmlvMEZ1VFAzQXpPc3Rkc2hyVWhN?=
 =?utf-8?B?aXBRREpPZExqNEphMUZxd05SNmZiRzlNaFZwS2E1cmRKdmxLOEtRNkhRaDd1?=
 =?utf-8?B?RG42RlkyTnQyMTgwTjhiL0RWV2tCS2pLMllCdzhLeUdEZVU3dFNNN2l2b3Bl?=
 =?utf-8?B?TEFvR3orMWMvYkl0UHlrc3BDZG91TEQ1NzJMVXJxNmZNK2VRdXpTNmx5VWhE?=
 =?utf-8?B?TjlJUi91VE5UVUtMb2x4SFpZaEEzSFFCclRzWnFvVkNXbXduY1YrbGU1TmdS?=
 =?utf-8?B?Z3hmdFU5aXk3UlpEK25XNWhSUnloTGdydkV2TU53bWEyajZlamFYQnZWN2tK?=
 =?utf-8?B?Wjc5dW85ZWk0R09zeW1la0JJQ0R0Rjd1TVFRcTJNdnhCaWZ3MzAreW9RdGha?=
 =?utf-8?B?c3YyQkY0WGtwaFIyNmFKdDVKQVlOWXdDQi81bGw3b1BZVk85M016MEFvYUt6?=
 =?utf-8?B?Mk9SOXJja1UySFJKVlJiVStReFd2UlFSb1B4NGFZRFkrTHNGSSt6emZZKzZl?=
 =?utf-8?B?dm9aWkZnNUFhVmhydHdJVktXZ0tMcmVKTkpJVW5ad0o4STR0Tms1SUpwV1F4?=
 =?utf-8?B?Q1FoUXlZZTdnd1NkbnZVY2ZJVnQvOGFyQ2ZiVERTaWZRSHd0cUt2UzdXMU1r?=
 =?utf-8?B?b3JmZnJsN0ZFdWd1aisvNGpFeko3VE5yTDVwZmQ5YkZyd1lveEQxaTZrcFRw?=
 =?utf-8?B?N21CTEpQQXVldlZvd3MybDJwbDVCZVRtMk9oazd2Vy9iUUtreVJBSFNmQlpO?=
 =?utf-8?B?YzhqVDZpb1p4WjJneU9QSUlwSFVTUWNtYnk4SVdiK3pNc3dVZjZld21uR3Fs?=
 =?utf-8?B?RFM3eVpsckJPL0R4bnIwMENjSDBHTWMyeE81Z3hjWHVSZ2s5aitIZVFjbTgy?=
 =?utf-8?B?NnZoN0JJOEhCamhoM3dick5hSnlkemkzZlNNcjljZUdvTlptVU9Hbm0yUjdE?=
 =?utf-8?B?RDNFdmw1dHJEVHFVTFgwNUJQNC9pRS9oSFVOb3JTbUNxMWxiOXpVaTVJa3Ir?=
 =?utf-8?B?ZHdZaEtvNXlvazhzVVRLcjd4WlJodDZDYWIzVnVYQ3A5dGJUUDcrQWtlREcz?=
 =?utf-8?B?b1Z4TllHcGE1Nk93aU5DNTFNT0lSVm0wcWcwS3JSRzJEcUp3SklTQlBvbm1m?=
 =?utf-8?B?bmc2ZFFTSzhvTlpTN000TDV0VVVJNi9VdnVnaStEYUhqc3lZcGpVckN5WDRp?=
 =?utf-8?B?T2dwQ2pFcG16UFkwLytueHhVTU1qY0MyOTlvRFh3TTNqaE5neWhWbkpyZXF4?=
 =?utf-8?B?TGNTbGo4Ty9aZGNXSEhZNFZnRkhCY3RmT0NCY3dBM0JjSE9lZXhnQ1lkTUZu?=
 =?utf-8?B?K20zRnkzTzdYZVV6bjZPenZseFFLcXk4cENIOTBpLzJXS3ZDQjBKcGhiRzlr?=
 =?utf-8?B?cGx1dGhVWm5OYmJydXdrY3NaYnp3ZUJCdEE4NFdrQWxmcTNPRURxNGw0dWRs?=
 =?utf-8?B?US9pNnVhcHJMSXhNSmlVOUgzVGhNSFdmWUl4aVB6Qi9VejI3Rnk1U3R5V0xL?=
 =?utf-8?B?K2h6Qjd4WUR6ekF1TVpoc29BaXpCV2pPQXJWQkxkY1JqK1pnZ29BTUFWUUdQ?=
 =?utf-8?B?NmdqK2d2eWhwYi8yYk9SNjN6V3VxUzVYQVFFSUJiZ2l0cmJUdFBuaGh4c0dk?=
 =?utf-8?B?VURqcW52SmJ6N1Y2Q2ZlNFJrRHZCeXNrQ2gvSEV3OXZWNFB2OEU2ZGV3czRT?=
 =?utf-8?B?YTkvQUJEamRENzJNd3N5d1IxamJ5cGZTL3JqUS96Rzl2RWdzVTFBcmxpNy9M?=
 =?utf-8?B?WTJvNkRSTjZEdzd1OXpDaWFaQWVIZUYyS2RFb1psT3FZRGllY0JrT1llaThz?=
 =?utf-8?B?MkxiSXNpRXFRQ2R1ZnVjZzhBclN6ajBRd2RYRExOeTAxUUhvSmxqL0RjbUt0?=
 =?utf-8?Q?mmwNSNtJD4o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9uNnJ0ZWpNVDRscUxkWjRxNnlMbld0c0R0bTBid2x6d2xKdjRxSjE0bUY5?=
 =?utf-8?B?dkNzdmtVVlJka3JnSWRlR0taejU5Ry9nT2dvSEc1WnE5cGFlK3YxcTZCczMw?=
 =?utf-8?B?SE13QUd0a0c2dWpEbGNKemdad2VDRVJqNm9qclhUZFBlN1ZKemdFaFZadHNm?=
 =?utf-8?B?djVVdXpSQzV3TU9GNWZWdmpPOHFtbDZqcUUvQmc3N3dFRzBFWU1wdnFNN2tV?=
 =?utf-8?B?cDQyV3orNm90cnNQUjRMbXQwbVVuMkFYbjZwc2I0NlFMZlR5Y0Yva2xqWXV1?=
 =?utf-8?B?RGxCOVdZU0pOYTQ3NWs1ZzJzc1p5RXlhaFZ3eW05aThMMjRxK25kQWMwOFBY?=
 =?utf-8?B?SVY4SFU4L2IxL0QzTmRkQ3k0Z0RjUFFRUnlpeFJ3VXZ0YWVPbjlxRlBqZy8r?=
 =?utf-8?B?TmRBKzZUeG1yWkpCVmUzRUhQWHdsTUdFUThJaEV4YnlpbFhXQVRmL2NaeVhN?=
 =?utf-8?B?SytqRFc1ZFF1SmE2dit1c0lYMXkrZWVlQmZkNjdEMmhVWDRiSTdsajhNa1Zs?=
 =?utf-8?B?OGc0QVljV1hPdzNkUWtOcUlwcm5hOVV6QUZ2eHkvaURkRHd2cmRJSWNnTFVa?=
 =?utf-8?B?UkViaSs4bGdEYlhINFBrZG1oTTN3dTMwbGZ6b3hyTmFEZkJ0VWx3TzBESGFV?=
 =?utf-8?B?eWtsbHMxSDhkaUdDYW1BMDVvUGl1U0tUM3BocUxISzcwOFJOeXlLdTRCbzBJ?=
 =?utf-8?B?RzFtSFcwT3hJZEk2VjllbHV3d0VhTjAxZ09UUnZwM3ZUanB2aFdNT1F0SEtI?=
 =?utf-8?B?NUhnQldlMXdCZ1BGY2NZb3BEMmxKbjQ3UlJjK01NUCtKOEh1ZXNwMVR2UFNG?=
 =?utf-8?B?aGFrYURJMDQrMURxQ2U4WnpESWFtN3hSWDhQVjFObnJqTDFpRmlhMWJTeWFt?=
 =?utf-8?B?dVZ5d1R6OExyZzBxbTlUUHhOWFh0RWphNVJvR0tOSFFCQWg1S3djb2wvM3Ju?=
 =?utf-8?B?ekpmb0FPamNYbTErbDhDby9yNndubCt5MkFES2hURmxOV2F2dldwcE5lNlYz?=
 =?utf-8?B?Vm16Q2xLdVplUm5Tdnl4SFpPdzFCLzg5Z1IvYkhmNWFRaXo2R2x4UHNNa0JK?=
 =?utf-8?B?VFliR1JqaVJncFFyQThqVFFwSmNMYkJiVWxoejRON21ZWkJvWUFsRytvNGFK?=
 =?utf-8?B?YUEyMlRzSzhIcTg5SXd4WkFjUlJxTFN1Vm1jRnBETW1Ea21vYmdXeEg5VEtw?=
 =?utf-8?B?YkNabkM0akovaGwrWEFvU2VkVnVMejQ4Nk84SFFJcmZvOFV0OW53VFVscWh4?=
 =?utf-8?B?M3ZoVnM4WjZrOVNxMFNiWVhCemxzck4raktJdlNvcjFOVVdEZVpUb1JFQ2hZ?=
 =?utf-8?B?THJwZDBXQjQ0allxZDAzQ2VuNUx0UnRlMThzUVZXK3JQemUxSDFFemlLeFo0?=
 =?utf-8?B?S1phK3djU3RIZGxoZ0EwTUorTUhVMmNlRGIraWhtM2JtbzhuZXkxTjdPemJE?=
 =?utf-8?B?WFE2Um5TL3daOGdPQmQ1S2tCR1RueXVJb3lGUG0zY2JxVWp1STBnd003MTZX?=
 =?utf-8?B?aXlpUWZsSVliY3FVT1FvR1ZSZ3FBbVdsK2pjSGhpR0dvTHgwN09WcVdra2w1?=
 =?utf-8?B?ekl0YWZzVWlNcHYxZEVvajE2ZXNBQ09TM3hRNnJaZmVKTUJSazBZVURwL3BX?=
 =?utf-8?B?U3JkRWRnNEZLLzF2dEFpSmJ3L1ZRVlk3a0RXVTBnTGVDVHlXY0tRY2xFalhE?=
 =?utf-8?B?aWhLMWdBdGxramtKZGtuWVZGWUlsTXpyamhESWJ3UlEvbHY2ZFJ0VTd6TUVP?=
 =?utf-8?B?ZEJONmtwRFh4cWdaa3lldHltNnNMR0JkQm8vVkpveWk0dnBML094Y0lwcHUw?=
 =?utf-8?B?QmFRRnBva0VVcEt3NjdBYmZwVERrellkWUZrL3BkdE1yeHdzTUJCb24zbzRm?=
 =?utf-8?B?R1ZpQm5TdDdQZXpueXNkQVc0TUVucW0valFEbSs3WmI3T1lwSnFGL0lmbzhL?=
 =?utf-8?B?engxUmZ1UThHYWV4L0NQOFNWTDVMUFFnTlU3a2RuMXBoM1hrRTduVW9pZEdI?=
 =?utf-8?B?cWduU1RkOTZWb1lQMU83anhGN21la1VTK2U2UGl0d2dyRDkzTmRCYXNHN3Ft?=
 =?utf-8?B?UmZDNmtja0tWUWNLVmVGTHgwc1c2OW1URjJLSXNzUHdkU2N5R2RrQXpvRWVt?=
 =?utf-8?B?QXY1RHdiTExSd2daMlZYdEhtNWtlNWl5cGVqbDBMaDZuUktmUzQ2MTF4b2Qv?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: saZFqsY69hqwxXIbDSVcEu1fY3lnchh3jV+jHKHbJ5cNcGInzhn/Eje/qlngtkne1BM72rho9DQejpcJW8fy3LqeKPKfl1aZjaX0mE5I6hx/q1Dutzex7JZ2X3qMBGpOUwOmMzZLGnml4iMpT4iDvSEQh1mRCFVLQ3du+spcgw512DVE5Slj7yubVui/O4IzpZjZLb/P16o9RiVqLsXUXE1Tj9FcIkCEWG+LcCYE1krp6JZ0bW2BSBdVZQJlilz6c6VNvDZMRx0eOE8i7tPuOAcGjP+ZiZ0audpnBI/N7HWNRlZMSMMOWTxQSJSUsURj6Th0Dd6eucnF3LGGf4HK1RobwOGTKiLWaZi8nmyNgCr2QR1PBeJJ5GzzYi5BYboNONQNaiRBZ7XYDM6FXmUgmLhhd1cSwRO22hn4mysC1DYFZJ7jpZ5KjXGkHUVuKwCsdpQKakjpiekS/i+haoBHJPZeZySZdD2FMhINdlmdl9bYAsIOiLY03SLyHEe2CXTTzVpQTmlMsEulWIwFMS7hZIenoDOV40L8kkSUFBRW/Td9nJZnmdbOQi+v8BSB0BpGQgzSyEZR+fHKKLulKHgju5iGVfTfcMRvB4H2XC9xP4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc8f63c-a3e2-43e2-65f6-08dd8cb6b869
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:57:36.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAP23dP2DdbN9lb+WXWNzvoBD6KTmq+rrzn/7vK7l79xI6+yvw+polgOhACld8A3y7uB0Z0r+nuABYUh4AfpeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060153
X-Proofpoint-GUID: JczuXU30-QUA562CVNjZIqzEsXsWMmgY
X-Authority-Analysis: v=2.4 cv=XZuJzJ55 c=1 sm=1 tr=0 ts=681a328a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=eKKUbE86PEtJs8h_YyUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JczuXU30-QUA562CVNjZIqzEsXsWMmgY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE1NCBTYWx0ZWRfXz0iJZMN1wu6A gSG0rliCvSBo3MepHa9uPjrtM7WMs6vLlpLByf481W+MOPD7uOczr2mzqGSPy9Ah+Hd0loC0FyQ 0ueSk0mFotLQtIdLcQfaRfaVxUkzd4lkUk4uqNreu7HxTXuQnhmYU8B/18DLAFis0YAz+MZNf5b
 wItAQbGHBOlNECk3N9aV5aAHaNvZglESMBAWFJUdU7b7Kj1uYyQefhMyRwoxMWKXxEupnP0/VOZ aArMW48oUxo7UFTLZjygc4wxQSH955XooJ6qfRysrHcUpALGRGXXKzMa2rNB2gO22KOxDU2aYGT 0XOo+VyFiDUV8rl/TjyfnqNTg2G4Gr0XxfV/7fUth2CtGDfC0Pz7FzF2HvacJRnHLu4oxfK6/yl
 9ymciJHvqlm3ZqmlSA4uz0PJ+tJOBisSIYhiSVvG7bs6zRRO4ZgNEMm8WUT1K5jourt5Znvf
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_090224_816967_7A353FEB 
X-CRM114-Status: GOOD (  17.25  )
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


On 5/1/25 11:52 PM, Christoph Hellwig wrote:
> On Wed, Apr 30, 2025 at 10:18:30AM -0700, Alan Adamson wrote:
>> The first namespace that is configured in a subsystem will define the
>> subsystem's atomic write size.  This will be based on either AWUPF or
>> NAWUPF. Configuring subsequent namespaces in the subsystem requires its
>> atomic write size as defined by its AWUPF or NAWUPF to match the
>> subsystem's atomic write size. If a namespace doesn't adhere to the
>> subsystem's atomic write size, its atomic queue limits will be based on an
>> atomic write size of 512 bytes and an error message will be logged.

Along with the error message, we are setting atomic_write_max_bytes to 
512b which will at least allow the device to still be used.

Alan

> I don't think an error message is enough, we need to reject the probe
> for this buggy configuration to prevent data integrity issues.
>
> Otherwise the series looks good to me.
>

