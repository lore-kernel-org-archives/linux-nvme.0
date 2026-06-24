Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236F5CDE006
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qjso88Yq/8rymKBbvGQTOJHnq7popP/Znl/qn0ZhfB0=; b=O8tHhsRc+/C4L8wHInOJ6vmztW
	8iSjWuPq84MFwEPhiYPUMd4RULeG3ns6tCT3JlnXqBpraJY+kvoDxAVz2UbkrNosV/xJkDGTr0RYV
	KLOg4FEUd2eNDJF1Hoj5qG/i89oX6XtaYkCHXkXUDqkIZHloXLcMgOgEygDpFP7eoFGjQX0cqrapf
	wc7PmVctoFBi/yVj7wOgcB9800N83qSnHMc/Ry/7MGzASn6qHIpY1xohkSzE6pPJu7kGO61gAMLWO
	9AS1SsKg99MqQPEALu6P0/tN7qa1RAa0vFcrmrJVThvcDdAAuAbLHnF0K/4roIz71BsAXVKM0KCyH
	BMbNSH1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNRr-00000007o8D-44Jq;
	Wed, 24 Jun 2026 13:15:24 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNRo-00000007o7U-3r1j
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 13:15:22 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O50I041548638;
	Wed, 24 Jun 2026 13:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Qjso88Yq/8rymKBbvGQTOJHnq7popP/Znl/qn0ZhfB0=; b=
	AWWwAhrS0k9UwaHjW2zQ6LSaYVossqoEf5bM9wRlTQ4W9akoZ+1np8CnTlfgqhhj
	d5w3OMq2DrTs/rOfANE5okHTmOXUEG1gFkVRPtRfhYOVhNcXTgGqKeIJBUflmXaf
	CKrg5e83RRB/YhrZMm/RNjIVko2TA2BtSCIZxWabPIZGvjL4zfglGkMV/6g3LzSE
	rzP9DdviJvcL66FUiyH1nxeQbxY8px3kQJsqrIbtbvdRVmzAKkTiWcYpH05aYEu0
	4zl9QgDzqwcu+YmS6W1DelKxh9FnoOOax9I5PgJ42D148aK1mPRBMPqSTfiYRJaS
	ShIZXb7IYocNNiOk1NqtIA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewh9c5cwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 13:15:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65OD8cXo024420;
	Wed, 24 Jun 2026 13:15:00 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhardupw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 13:15:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag3wYm9SNox880QbMfI9GSgaw6AeCbuxWrnkBAH62og0ayv+d58WHuHPyYCMCGDX7i8P/7cj6HRhLwZX5dn2VvcASwaS4lo7hX3rZq6DPjbbyjVymEsl+Ei7EGoZgUlLuu8HEBGhUtoTZx+8YxIa0lQ41iwsmeKy1Yf88yYpilMVSvsUoVDJx2cAeG/v/Wny0yYIh15u8k7Io1xsL5CvKNG8q8SqHexES/qzrBYzdu4zhxgwNBNYSUHk9ov2ua1jMPRcp5eTOL0K/kiUok+v+aRHQmnbP5Obv57pwvxVWHGbFaSY1XQZBeP7kIq0K3BAPAbBfKU6iGBxRYz0t5TgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjso88Yq/8rymKBbvGQTOJHnq7popP/Znl/qn0ZhfB0=;
 b=iq4Wn9vghBqvHr1AaW1qvJJukXDs71pzpeqc4wh9USK9lktz6zc+AzifAL/s065PgG/P2MxKKl7/jk+KxGGUq1mOMaiRhsNWXivYQcRTQvYjbye4rgJSEDOVbHEewGyt6UWr42A5V1y3jXLIHQcpVsqWZHuNpLxk87kdJzj3DQ9uA3/8klnZODjWfNiKTJlbIjdNCB0Ajuf/rVxeiQ0j0UiQTRDq5mL6KBaRSfz5Ceik7amyP56ljEwE711phfSRZeawseTEpOWK1ZyVjkqLXyS3ChzIs9CydMSWIHNBJq/BNJx1J+mi/QrUIgceDT4F3XaP7lf9svk/XiH6xUhy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjso88Yq/8rymKBbvGQTOJHnq7popP/Znl/qn0ZhfB0=;
 b=R1Mgoq0qQuperrMPoR3hgpasSnCGvrfT2NBC9ghilphHi/FGh0umg4UrgU123r5K6XqA0tGyZrs3K5COgqRP4pnL9T4lK4z8aux+yoGQy9vwklroyo9YMyI5K3KMLknBB8INvh2wGqpF0/UgmUteSVyE/zLe6BFjGCwpUXdnwqA=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CO1PR10MB4401.namprd10.prod.outlook.com
 (2603:10b6:303:94::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 13:14:56 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 13:14:56 +0000
Message-ID: <e4650024-1706-46b5-91f8-57f2c358fcd3@oracle.com>
Date: Wed, 24 Jun 2026 14:14:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from Identify
 Namespace
To: Chao S <coshi036@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Maurizio Lombardi <mlombard@arkamax.eu>,
        Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
        Weidong Zhu <weizhu@fiu.edu>
References: <20260515185853.2761456-1-coshi036@gmail.com>
 <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
 <ah7znSpPM-H-ACaV@kbusch-mbp> <ah752_DIQdr_LHaB@kbusch-mbp>
 <c6046eb2-9594-4355-9f4c-21a6f3bd8131@oracle.com>
 <539bb4aa-30a3-457c-8c77-c0d660376c3a@oracle.com>
 <CACd_6n1h6NW3DS1MDKkcr=r-uxGQ=HspMLN6TWtLc26Vct8sYQ@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACd_6n1h6NW3DS1MDKkcr=r-uxGQ=HspMLN6TWtLc26Vct8sYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To DS4PPFEAFA21C69.namprd10.prod.outlook.com (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CO1PR10MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 677d8ca5-b69d-43c6-222e-08ded1f295f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: iKn/a1Ft+nl0phDvNMVXqoViy1NU3blos48fdkrKZuQUyj0KPwOHlXg7tFTf1IU8f+7cSApATL+C1h4jOPwpzHFoZtkHjqcNSiF59e9ykACq+VFgDsZaDVkOu8ke34FO15TBJ/M8fGH2VlLeDzA3cVkXspqxjc/VRLSHjOkA5v57KJN9QL6AUe8IVsi8QEyTy8wq1+5Ds3/Y6jJQILdrINohS8az74qklT7poFHsIxk0ZSj943uGBS1amKi7LOqyR8E7nnTLI9hx+XuMSZXpO0JODMA0Y/ykEhWMTUyLfKzFlh91Kk8Zx9W060rQRwy3fZoVAyID733t7lv1g6P8Mh7jnxs8oyDN7kb6a1NoMrwMEFiH8jSiHvnFmt/DktCOaGn4HWTbDfTqJnZzP7FJNGuvebq2FUMbE7leoPwvAqPkrZ2zOC93EHJT6myR43oXfLKml8csTx3UmI2FDY+CctvwGsb+XgguKEsg5nM/01Tl0Pwas55Rz0jGlOq9h4EoYgCfoaU72zMiPxdA76QBsjhTTcP3AyMXtGnwgjo8SZDxrYghKoCO/6ahFsLF2xUQoev7Fcu+WDfLOZZx1EzFYHbZM9PkA8tSUkNtbI02c6XMlnp9ozYQ7QE8a7zkx3tjSWihx+Xnza+etOlA2wTiT5bsiBp8QbXt74gUsTUMxbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkx2Z0xUL0t6NmkrL2FPKy9rRlNjbW8yaE51bnJMY2NnbXNkWHZvK1dMWHFB?=
 =?utf-8?B?WXBkTWFXZmtuWEhXMXZkUGFNZUlXTzZqVURaejRMTGN6VERsWTRscS96R1A2?=
 =?utf-8?B?b1EyQ0NxSTNvUDFxTEpWdEYrdW9jazBHb052T0E2bDJrNGVjSnY0TGkzcXY5?=
 =?utf-8?B?cGpxWmNEOExpMDNoUys1WStzci9BZHljTXlzZ1NHV3NWdHFzSTZuOVNaYWRH?=
 =?utf-8?B?aFU3Y3NhcUJYa0E2NlVkSkNVanF6NlFibzMwZGJNM0hhdkw4a1FUMzlpMVhU?=
 =?utf-8?B?MnBlTTJlbmtiTFNLZ1grc1hRZXRYb3Z3VFJZOWJ5V2sxUzlXdXV4Q25BQ1R2?=
 =?utf-8?B?a2c0WGk3M0VSSzdTRmpqY1lLNHpiR1FyV0hYSmpRclN0STFJVWkvcWl1NkFz?=
 =?utf-8?B?eTB6cGR0cVkyZ2pNS21FMk9mWkpBeGVIRFlzUytzUU5Ta0cxUHpwZ0YvNzRW?=
 =?utf-8?B?WmJ1VVBodXhxK2FCMkp5M3pldHd6S1Q4dVlpR0J0enN0NndIS2JYVUNJZnRD?=
 =?utf-8?B?K2tuR0ppbS9wazNLZzlpS1NGUWZSbTdhdVR5R1BDckV2QWRvVWxRRGJMVGF1?=
 =?utf-8?B?YXMvK3ZRQkxJT25ldzRZZVJOQ0t0eVoyWWFLMkpXRm8wd085alBvQU5YNy9E?=
 =?utf-8?B?ZmZnMUVNYldvSkJzYUpDWnpib1lPa1JPSjZ2Z0V4VTZweDYwcjgxQjc2ckww?=
 =?utf-8?B?UGJhTGJWVTNKNFQ4L2VremQzRE9qT0RVRkgxalBiY285eVZMVHZ0T2EyMjJj?=
 =?utf-8?B?Q01rd2dkQVZUOURaNjFNWVdVWjZyc1VYN0FDaVRzZkhlQkFua3FyNS8xZFRS?=
 =?utf-8?B?UTFxNmhlN0JLaUxxWERySkhJb1ZWS09TVFRKc1BYRk5VT2xLU2pxTWpObkRY?=
 =?utf-8?B?Z0xuVDh6OGc2TWd4a3dZQ1hXT3pkSDNyVWpmLzRkS0pWZm9kL3ZZMWF4VXVq?=
 =?utf-8?B?NDk1dlI3djNQQ2xuSWM5WGRNSXAzNXFpOVRzdE5TV1lDMFU3K2EwSDFhRFhJ?=
 =?utf-8?B?S1RKNk1kRWJZU3gwM2w4NFZOWjhQU2ZjcUJEVVFXSVNvaEFBTEZUMUV1aUpa?=
 =?utf-8?B?NlhMZm01aWRtYm5NOEJjSk1QbTlvam9qZjVIbW1nWHZGWFVSYmh1eGhOaDFm?=
 =?utf-8?B?bGVYVFJMYmdHdDZvTlZpQ2ZEY2dZclJlK0ExV3FzVml4NnNGQks1NTBHNG9K?=
 =?utf-8?B?ekdRQmM2WGZPeHRpbkVHMDdXeDFOb3RZNVZpOUkydzJqUDhKUUx4cGFaZis1?=
 =?utf-8?B?dFdVMWFuYzYxQ2hwTVNIQStkUm00NTBYWWJJSWt4bDF5YU53TUNXeGQxOEpr?=
 =?utf-8?B?REcxbm9KT0dJbmRSRHFWbUtaNW5FTDhBMDM0bTN2WGhIYm82V3FxejRtY21C?=
 =?utf-8?B?Z1I3QXltdW95OW5rbks1LytZOUZaSjBveVZBQmFORTRBdHFhUXFYYTF5ZWdK?=
 =?utf-8?B?Ky8rdEgvOTdLNnlPRzFmUjM3cDhtZEdqMHl4TDZCTzBsa3k4dm5wdFRHTGRj?=
 =?utf-8?B?N0NNWE16WXE0eFJJU3lIQjFldVA3Q1hFcGFLNkNQcDZJWGhVWVVFcTJoY21L?=
 =?utf-8?B?aDBGYWFwWmlQNVNudFBXcStnaDVvdm1CTlN3RzZ1Y3E4UklnUndQdXl4V1lE?=
 =?utf-8?B?QXdnK3dGcjhiSENFUC9HWlhFT2dXT0tzWmpCZkp1Rytuc1E1MDlWbkhCUzhr?=
 =?utf-8?B?TE0wSHBwa21yU1o1NDF2S3R1V1UzQnQ5ZUs3UFBYY1p4dTdmaWlKS1JXc3ZF?=
 =?utf-8?B?SzF4amVxV0pzcTZmNDlzK0ZzNGhEcGlyck16TkJsUnBNQzg1SjROMGNlRGNo?=
 =?utf-8?B?c1ZCVStYc1AyNDFRUGN1bDIrbGNhNUxISW9BTmNiNmVYT3krbEVQaWFUUDJO?=
 =?utf-8?B?Z2pRSDBvMmhKckJES2pxeFRjN0RMdG5wRU96bWttZ2d5a1J4bG5zT2JkOGF3?=
 =?utf-8?B?SmFFdExjbWU4Mk9JeWppemdrc2NLSkt0aXVWVlQ1Zkh4V3hNck40VVArMnVh?=
 =?utf-8?B?elFvaXF5TDZTalIvTFczNm9SWGJQYkZyMlNEWnJPcmlZVGtqd3dqcjNLdjA3?=
 =?utf-8?B?aTFTMGxkMjRoM3B5Q2pseEdPaUNad2IyRmRpRllEQ2drWHprbWhwUEtJTnZQ?=
 =?utf-8?B?UW9VN0YxQ2FVckRBM0dMZWJRVzNGTlEydjdRa2lWUmc3WDZnOVhTUUlDVi9j?=
 =?utf-8?B?dys0NEtIM0ZzL3Z4ZFY3S1lWY001VHJXTE9LTVdvaHR0R1VPTS9EK1pNeGVs?=
 =?utf-8?B?eXU3NnJSMk1Cc2VoaWxrbDVwOVRXeUxkeWM4UXpBdkJXVWhrR3RPYmhwOHM5?=
 =?utf-8?B?TGpmcmN5Z250Mkxrb3k2T3U2bXZzUEVwSm0vdHJDV0Jic0Nadit6UT09?=
X-Exchange-RoutingPolicyChecked: gWBMSttJcHZz7AsAefws8JyhvDwk8HX2+VTZKYn591itGodueHEfFlmYzfvMxcIQsF8cM5P4W11zoSEdN3j2xgR4A3Xqo17rZmI7ZFZNGGyX4VMUpIVAz6RJmFxPSzpezc67buROfYVFc3eH2W2t/AIdV9uzIHpucpzQ1hsnFCz+b0ePZxV1XYelkGe6mvz2XitTBpUXQvT9WzAaaLOpj8pXLyYi6uxwPh4vSlsQk0mrzVwDreD1KzoVw6lNVBzc+AG4YtFzjIFsu1h/bt7XI9g8gNKgjzGOewPLmOSIgb0BNACu6hni83yr00SX9+oMRdyVTGa7gI6lwoAe6mFwWg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2YQQaupit3AuIMdsy4sKikkq0gSoblgERO/jlLNj9zp3u5Rl/hCGpVjBuWb8AojiSMgwPNkrov9Y1S9E1+JOwl1dlWQUWP+9cD0VDoNGnZ5wuLdYT42UVhGxj6v14V0ClFpywpRS8PHY+D/+6tLVjOVv+ZE//jASm5g18mM5tEW0iIkzQQIvvmjqF+BZYixN6DtUtpBXPX6OMGZkX2iWCRtwsWvkbzKkN6m+I30VbB7//UPD8Bu3bbl+3HY/LTSpZHFCcv+KCw70P2mUVAHBQGa9j/JGZ95Xg1Rs0/hYjm+nVP757aojOyC2iBsZEwHUK5Ey4aiSeMF3VFhC5VWRGelN/DivDZLNxVyrHNm8S64cQh+LAZaSQ9fnketWHz0+NmjgIOoba2Cjq/+GUlfo4pxyOEV5yHAIMBggEEsSeRJzc5p/a0MksOicZZdeQBpSTupcc9kQhVJkSDC3x/GzNs9umcH8eDKPkBeRxu2H/HcEHwfqcHsjgNPhGPtdNLySzP8qIQ+YYgLHnHWamLFYpUEb9lReamavcluT+MizXugJwLKw2Yjw7jXPg5qvfN8Vtwc9aOO+jDkWZsLPj2d8HveaQ07uz4pIfa9eAmDQKYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677d8ca5-b69d-43c6-222e-08ded1f295f8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:14:56.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7vEZ63JirGYuIV0Yl7bdw39PIe2FopdZv6JHxl8FTusIU3wn0sxu7lFw3ZnCz0xoyzaUlNGNBMivM6BPNYrHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=879 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240109
X-Proofpoint-GUID: R-Mw0vJW4OXU7LCr7t7oZGs12GS3WKu8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEwOSBTYWx0ZWRfX7DGwqqhLbO3P
 AnhmBqahj7urqf1rTLv7MsYnWR9pkWyglaLpvX2dwuoghF8/FrmvUCCpoQpi7OVAa3tQbgAoLsZ
 pQBl00sKxqoAjEb7btmg/ZXJhYPoRVR/STkFAquIaCkMsKf+Ddax
X-Proofpoint-ORIG-GUID: R-Mw0vJW4OXU7LCr7t7oZGs12GS3WKu8
X-Authority-Analysis: v=2.4 cv=Rd+gzVtv c=1 sm=1 tr=0 ts=6a3bd854 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=0E0-HatuF1h-3MI8YfAA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEwOSBTYWx0ZWRfX/LWlRnZg6jgN
 bUUt1jbRx4VMzgC/xHg2AHcWngGhkTLp70tdpoIbpEqz53q3k8VJbamo3VjJocroDDq6JftRfHQ
 Ae35oYYbwFhuhbwAjVeUx1GEN8gRvN7hvqg5Le803e2OaOypFvDejYxBWAJ+kKGH8Up59E3yrc8
 50ejbRdg0X7Cr/YlAEKTkPFGQ/To0L6tW0+qNT5nxCTf9hJBjlK9d6wlsBEWO5PxXZaTAV1i0gZ
 UoBrE7gcS8m8yL5UKd/2R6DLFagyaPR+D2QU7aHGM86/c0hk/62ZoibtrCehSjNa3kYlyuqGdGZ
 gY9EvZadNX9WftWoTbYOTt4/GXAU7cac4qw8ChGnmFNG1JCyD0g42LRXT7U6IIkdHNnXglLIwpt
 glqw6Fu6inIV4/LQoPIiOqkEWx914b8Jf9wBFQ5KCVvM/vTWiQww6POzaZN51Nm/QHddWW3p8Xp
 5PQmiMKtvlIg29y4vkHCc6U3Ca+dVWM3yMkO0mAg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_061521_083580_8856AE13 
X-CRM114-Status: GOOD (  18.16  )
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

On 23/06/2026 21:37, Chao S wrote:
>> BTW, I have thought that check_shl_overflow would catch
>> id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra check).
> Confirmed -- check_shl_overflow() returns true for the negative shift
> that ds < SECTOR_SHIFT produces (_to_shift collapses to 0 and the
> _to_shift != _s test fires). I checked ds=0 and ds=8: both are still
> rejected with the explicit lower-bound test removed, so it is redundant.
> 
> For the C=1 warning, the minimal fix is to drop that redundant check and
> feed nsze through a plain u64 local -- as Keith found, laundering the
> le64_to_cpu() result through a non-__le64 type makes the warning go away:
> 
> u64 nsze;
> ...
> nsze = le64_to_cpu(id->nsze);
> if (check_shl_overflow(nsze, id->lbaf[lbaf].ds - SECTOR_SHIFT,
>        &capacity)) {
> dev_warn_once(...);
> ret = -ENODEV;
> goto out;
> }
> 
> This keeps check_shl_overflow() in one tested helper and avoids a
> wrapper. John's nvme_valid_ds() works too; if we prefer that, I'd name it
> for its actual sense (it returns true on overflow, i.e. invalid), e.g.
> nvme_ds_overflows().
> 
> One note: I'd lean toward keeping check_shl_overflow() rather than
> open-coding the bound. It folds the lower-bound (negative shift) and the
> overflow case into one tested helper, so we don't have to re-derive the
> boundary by hand -- e.g. the lower bound is on ds itself, not on the
> post-subtract (ds - SECTOR_SHIFT) shift, which I found easy to get
> subtly wrong.

What exactly is your proposed change (to what is in the tree)?

> 
> Keith, since v3 is already in your tree: do you want an incremental fixup
> on top, or a v4 to replace the applied commit? I have both ready.
> 




