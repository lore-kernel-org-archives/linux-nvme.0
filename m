Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A07C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCYpK5NNXchplH33uEXcpKE9UP8rjL28wmf450n3zAI=; b=BP1rLZm90dtEU8pD4Uh8yvwqKw
	gCuclIi4QSdr8g5zntn2ax6O9fx6LiV+oaugeY8ZKdMYjX9Q9esfTEYYf4PTs6d6f6sNADaMiaw+Z
	d18y+2EZMLXrhz7SFdAnikn+mMix8rrZ2Uux79FUnUqJygRhZ0HpjhnzXdnguf83nbrfe0wWa7aCY
	gs7SLWYDJVkoEpXeyqv7vTK+lIS9sXGtUf3WRssm5Nhrgn4gF1+ERG0oEUs7PbvhaZCs15Q0N7vt+
	JL5UO0ptB/LY0y6f0HXuelwb3AE77dg6DbZ861N/TA0moNITDjlNezVgdpJSy2nPh6R240W/lPF7e
	ImIMEwYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whQQl-0000000H0kj-2kLF;
	Wed, 08 Jul 2026 11:27:07 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whQQi-0000000H0jc-0Jxg
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 11:27:07 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6689qfRn1636566;
	Wed, 8 Jul 2026 11:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fCYpK5NNXchplH33uEXcpKE9UP8rjL28wmf450n3zAI=; b=
	gru2i2SjeqsdL/MoOs4ORATLACAjJ3xslnN6qsUlZcKq8Tnan0bXkk0mIqApAF/K
	sOk2/wS9d8dNEcDG0KsSdflwOKm+JVMUTo8RbmgQQ0GFhBNK0wbxsRd4BBy4NyUa
	WSrP2fOKMy1Sbf9cIPhd1aNBkqk/XKdwkXZsTtrQ6w5sOz9XnFf6ilf4iQkRwE0U
	7ijAfv07j50sVT9SQ9W3e+BhIW/Z2rIZTjlmmO6rTiEn5uzDop3JmqDJn4v8AXn8
	/C4WnHK8Xr1zG6iAZhqGCAdHMDQQvvCu22jjjSS+1qesv4tWe4A/ORyOB70CzEdZ
	6ezdnxFSblHDBXAL8W8m3A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6t7cqfc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jul 2026 11:26:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 668BIV3A012395;
	Wed, 8 Jul 2026 11:26:48 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f8yuy2mx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jul 2026 11:26:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMd+IIY2jtxLUv2ZGY9QfWBRJC/eq/Ysl8B1nOQT4myd2PlTtM1VZk7SomeUTdJPifGVjYH+GAtaq66dukZHs4IR9X/zOm+4xoyQe1MJJ/jC9C7d/MBhFm60jKfGaNftoBuwsngVkS0IPoFs8cF50r3ITSFaxOtl95VTMtsqPEONj0eeoHJZjAQp39bABWZdGVlCMeDA5kNyhvoUq6p7JT/YDpT8cBAGAAosMfy6JwbBeAUeoCgORGHTO4MQnpp1CPKUvfuj6DD47zZps2LQv781gXKV1iszodN3uMocYGrnOGYWS6hpaj6QKPTfdVt6hg9w4dqmYLYsFfFyut/E7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCYpK5NNXchplH33uEXcpKE9UP8rjL28wmf450n3zAI=;
 b=NO35GDSwZLGzdl8kGJf5V5Rwp5qEwKC3YgggniFkuXtAwK1WCHqfexgGvQBOsgZN0FeReyGDOz1lTnKZC8CGzQbOAJCZIBFELuOC6X+MKCnb/RTlxJPCJLp5RzhqOiPxPazuHdAmfA7BF+urla4o49AdD/R7yNDvsgn4crVOcF9Ai41pa0gc34nSWuMCl6w6pNgUz2sBAL/HPWd1R8be8DfcUS0xAkcGbDZ1O2xv2pESanl5zY0OnqqWDEitmVkneNvgZBjCzqKjyY2bwiPWd8NDB1x6NgKcLY74tqYJGlA/Mhmb9RkEkPYsFpWYyKg0v9B7EMbLUgZD9IaN5cBkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCYpK5NNXchplH33uEXcpKE9UP8rjL28wmf450n3zAI=;
 b=A6rvFzmk3yOhyacAPmuyDFzqkaKXFflrU0FXEmAj9Fnq/dVaWr1zY99bZFbrQSzaTMEMr9prTxkR47sJ/qoymnm/SngBkorWpyu0OXSo0CIxkKsy74mUjCeqxirMkdRFrn/oNgX35Ykv1LJCInnDET6e4S1ofkZKBVzXYLHKnHc=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 BL3PR10MB6041.namprd10.prod.outlook.com (2603:10b6:208:3b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 11:26:44 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 11:26:44 +0000
Message-ID: <26df2aef-a740-4287-9839-283578616f49@oracle.com>
Date: Wed, 8 Jul 2026 12:26:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme: fix NS head cdev lifetime
From: John Garry <john.g.garry@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org
References: <20260706130146.617258-1-john.g.garry@oracle.com>
 <20260708092740.GB6513@lst.de>
 <d27cb4a8-cf04-40ac-a271-c7d83dadc8a1@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <d27cb4a8-cf04-40ac-a271-c7d83dadc8a1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::23) To PH7PR10MB6228.namprd10.prod.outlook.com
 (2603:10b6:510:213::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|BL3PR10MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e785d74-c352-4d00-feeb-08dedce3c9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: olTASof9zi8JHAxaKdfqrKmv5A5OLqB3HYn4hRCaw8RMh+qfo7ODbkmbpcKk+wnEBSARv7MviN0nKznLiEbPwWkEMt5YuchQLouc+OQYAC2G836l2yZKuC7hoj3wJyw2mIJa5vhgAuqa8FnpoLciEOEYh/y557bUcjhpJEsdgd8kDK3G6rWIQlWTMAIVFJF4nRVN56VFiy3S2IlGIFX7KLW+AL9GjftghN5/4kB7XDaiEI8wfNWSfNEYRGh4exaegHNeoIJPx81jZeLXNv3YEJJIehg7u/4/x0H5NIsxcHFh1IjCxSr5lBc89uuSqqoGYTiTege49JofsvAhE8C79K/kh+OjPfGozLreu7ByM3OSAiPmOT+wVHmZ/jFkRyAXXCuDzkBnFub8BLbxpzPFR5Q8zpd4r4wbkXWQlTqwfySANdzBzTbD8V5eFvjYl/Xa9GyhVWYJpw2AcWGPQbJyyYgAJmDHzPmB7l3q3kMLH28ClKq+OpBaiICv9S5M4M81+jjdKmtmCPbcm97qmCNV3+ncbb2GpepfxpRVCYGBcn+OAuiO3mVr5S/k5YaCisYjaJfIBhPiL6czmzT2BH6Y79lNwh3sFXyD8ca0uNvsCRv4jI4TS7x3GrutDR+VHFiI5v0Ns/0FadqbgELL/3P93FNYtbxHdLMQoQphN+fET/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?andGQ2ZsUFU2OVdUai9WOW5SSm43ZG5OcERSR1lFVFRSYk40V2VlWXVuU09Z?=
 =?utf-8?B?NmEyWElyZ0dGcHZYRmZNS2hVQzk0aGJ4NkwvTGJsRnd2RjFPYVFXdTdaWnFw?=
 =?utf-8?B?enNHc2g1dEtJUkVXbXNZcFBmSVE4eXVkcWJ4YzF2MjJYOUdiZ1phdTNQdEhB?=
 =?utf-8?B?TGtJeG9ld2ZSdVR6cVJ6RkYxUDlORXNCNmYyUWprUVJhaGQ0cXoxUkt3eFlM?=
 =?utf-8?B?YlQra1N4bXlHNXNMcjR5d2VHN1gwdS9LZFNVSmczdCtPOTZhK1dvek54NzZS?=
 =?utf-8?B?TzFQZmdPaEE5aXZ5Qm9BY0dnNXJ5Y0NWQnlINEloS0NNNXhTRWZ6ZXRnL1R4?=
 =?utf-8?B?dmhwQ0xvSVI4RVA3bUM0MDBnYVVqSFh4ODJhOGh5azMrblIzMG1vbVA5T2M1?=
 =?utf-8?B?U3YzTFF4dHowRVMzWmtyVitwRE5rUFNXZ2ZwTDlhREdqTUJ2SVhTYlF1ZEQ2?=
 =?utf-8?B?SnF1c2hDRzlUN1hZaWxJSW54cjNVSGtIbCtBbWo3UGx4cEs0T2FmaExZeDdX?=
 =?utf-8?B?cEJ6eXgvM3VaVWJjN3daUTRNbXFOM2ZOK3EwTGVJaDdXOUJ2SXlMY2syU3cx?=
 =?utf-8?B?M2RHYmFJNVRLRmZhc1hWQjNpWWdSNnlDUThieWZIaGc0d20vbk5SUG5qZnN4?=
 =?utf-8?B?azBNZGt3eDNBKzFDNi9mRi9aeDZtSDFhUTUyY3V2YXpzbklyd2Iyc1p2WGlh?=
 =?utf-8?B?Z09Vc2tNdTBTYXN4Vm9wMllPYXRsdjBHMWY0aW9FVmVLQllYR1RQWnE0anh4?=
 =?utf-8?B?cmVvRkl6RTdMdEhlSm5JU2J3c3R3YkYzSXhYeWNEWFZXL1BYaVNjZHNrL1ZH?=
 =?utf-8?B?OWRVR3QvWWpSMVhaVGpXVFlXM3FmdUlDekg5NjJZc1FINHlJQ2hvQUNPYlRM?=
 =?utf-8?B?WURkYTdOcDVQUnM1SGJuaDByZU83OERZQ1A4UktXN3l3Y2lFdW5ZVzcvUGN6?=
 =?utf-8?B?SGFFNUxjeXkxL3JkUzdxTHF2SHFtMHVjRTFrcWxWS01oazZEVWJJL1NIakNP?=
 =?utf-8?B?aFZzYyswZjRxUlhJdHBMMDR6eVdrTUZWM2hwMnZlSExMRE9ZSUdTdFNMZ3p5?=
 =?utf-8?B?dWZPbExvaU52dU5wUG1TK29xWkthQVF4UVpTMjB4cjd0MEpiMXhlRURDKzYy?=
 =?utf-8?B?OUNKNS95UWVNVXhHTmdqZERybDVtUjlqdTBsL29BNFhJRXFwREdjYVJObUdG?=
 =?utf-8?B?Tm9OazRBek9nRzR0czd4MFM4REZJeERmUTBYaTNDcm9jZjlUZGl4Ty9vaXN4?=
 =?utf-8?B?Y2V2MEd3WjlQQjZkUVFwNHNsMC9UZldsRWJHcGd0UlczU29mYmNqb2RpMVho?=
 =?utf-8?B?ZjNPcWR1blpzQkN6cnVYUHovRHNZemRiUEd5YWtCSWVRK09jRFAvNXZacWlW?=
 =?utf-8?B?TjIvYjU2dU5IRnNjcGxyMVMrTEV5dHJTSGxKcVllWEI3ZlVTRHlDVm1Xc1lU?=
 =?utf-8?B?QnJmQlNKMFZ0T3Q3c0ViWEhsNVlFYjdHZ0p1cHlmVE95aitTcFI1NEd1aHhv?=
 =?utf-8?B?TzlxV3NwUEZUU0hZVkUzRVROekRQN0RndVp1UE11WkRkdUdVRkV3dmhJTGVi?=
 =?utf-8?B?Wk5KNmxmb29lMllaTTFQcEZlc1BFajFxeXFWZkZUUGhoUG5PUXptT3p3SWdr?=
 =?utf-8?B?amV5L0h6RjVhdmE5bHVWRytzTWdlNDRMdFFPKy9nOUlDdlFxcDRCb09sT3Ru?=
 =?utf-8?B?UURXZTQ3VUxnTDZxa1lSTEZkcldxNlV3Q1dVL3U0dkVUZHRuNmdhM3JoUkUw?=
 =?utf-8?B?Vi9iSzJWZHc4QVdzV0VLR0xxMVhDTzFkSWR6eDhCUGpZKzlmS1Nzd2x1NEk5?=
 =?utf-8?B?dURZdjdwWFBaWW4rRHdtdVVCcjNhc0ZhNFRHNzIxazQvR2J5bUFqbUNPb2RQ?=
 =?utf-8?B?MU0yNkN6dy9OdWs3WmxFTEIrLzJtVjVhUFdUWlg0V1hBUk1tVGR0YUJsU3dC?=
 =?utf-8?B?YWhPT0NJT0R5ZGNsSnRORTdEclArMS9NblY3ZDJNTjdyRUJEVWNveGQ4THJJ?=
 =?utf-8?B?VjVQVmVWQ0JiK3orVUZJUkR5bmVTOHE3ZGxiMTF6WTFqWFRBVXA2QzJCckdt?=
 =?utf-8?B?L2g5bE8yRHpsbGdadjBoTkIyV1Rrd3p2OVhoeENTYmUxRG40WjB2bnBNUHdH?=
 =?utf-8?B?ek5wSGlCMTRna3dKY1Zrd0xlSkZpaG9Oc2h2RjU4Vi81TXVRTS9WTkhXUUZj?=
 =?utf-8?B?MG5Zdkl1dDFlc2NPSW96a2RzeEt2N3NYWCt4VFdTZ2VueUtNUFN6eERCcVB4?=
 =?utf-8?B?ZkRqOVN6NFZsbHdyTnh0K0ZlYldFYTR2enhXMzdDbHFwMkkydHZzaUJCYVhT?=
 =?utf-8?B?OVRCNGEyTVB5cWxkWkdCUU8rdDkyUXI4eFcrK09lbERDaThtRUFhdz09?=
X-Exchange-RoutingPolicyChecked: q3ieqfKX4g+aaHR9rdyIL4XTrWubpjIlLK152hBlnfFwX+lsU4O2Z85OimAnXy0jBW9AQLEU5wlOVx8n6kdPsx1U/PBP29R5zNv1HoshyHKU9yWKM94FK2UpzDZFFS5PhA8uFMMSD+kRRDpQFSee0QcU3pd9+EgbuHzNC9SMeQ+GvOKPEK2OtLS7KYuQeOw5VM5GebQLUMcONQqA3CvU/6LBW7Ejv0dOVhf/6kIELyD6pSguRghgAzYlFUszM5oO2lgSWfHhaXG3AsrVHsaYLqii/kS28XzrOl3qwxhuTRKd6nSY8BVdyRWH6pj+SH6OWf43EN4x/+6+BHOcx8JrDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t+ywRvdVb22fuF5Z1+hFKqtmPfV3G7J/7ffycScm1qGFfiDbYWvF7ZMcqg3RawpamFXaCJ03ZoMuJ4T70dSsgd8xHkTN2WKvL/I2C9AQ/XS3Y2ofskJYdcX8XPjUMzAlPy9ulaRFzNVy9FURaQw9Hngob5+o4AQ9Muw5uQI8KKstFVo/O2XKVw6G141xoVjn3i+dlqNMCXwBwLsGTgTvlLUI2xfokn9scBmGEJWraFBYu6x0ypc1ndGYwWpNhYWfipI6aiKsk9+mkByFo+GKZ9JkwQuEJomeh6tBn8rwp7LnI5sVQ0J11EhlmdHDkYTcJRShok5Y/OVIYMRBMyC98wZIXmYfsLzyAprRtSvOQ9loSowqokCLdmbkaEq8cMvTJx5S1zYp80sB2wjS0YwkUsUd5Ymd47DC/9qDHpbrDq+IRxbD5KN3V/hCIKRnhMEL3VAMzsZ78Ugyf3aZF7UO4NDpB0ZzoLTtzuJM+djpL7n2x82xQ1CagvcNXF4wSorLVeIPiCDEI2FN7ikokU5Cgtk6jseoBb/7yK0cNmrQxfYAnf9knozLkuKnCslA5u1yg3pKc3Z49ixB8159WoBlvc9b/cZWNpGgkNcfe0mNaBc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e785d74-c352-4d00-feeb-08dedce3c9c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 11:26:44.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEh4CkBr4aozsWz1R9jfjDcCFvhBhqqY8mRyV7tUKzxL/clpHOiu9FD6CqAChnGjIUYS6lOMovXU+UwRELMSdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607080110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExMSBTYWx0ZWRfX0CGfyOl0Pl+L
 IVbUQ2Zd87qVs0w66rH6zZS9gS7uHjw6fHsL+F6dTinFK2aLiewTCRNttj9PdLWynLsl2w2psdW
 mJMLZfXETYJXNKjYVEPAips7AQqS+ZtdLbXP+HM1LZINkJWB1qinrqWShwndkIzDT9ar7nHLyF/
 5OQgYjMvufDBYPQtafJ0AABULQvZnsndgziwaXQWLUTvV9OpgoNZsMHDspmdFy2WXVT3iGC1Jpv
 PAlZggViMkIa6ULPoE8nHdk+/SaDWHh/7agH27zXHD52McE8l3ADrVtf0RfCA+09aw84t57f97a
 i0bjePVq/AUTfW+ALzBgq55qVtUbGmjULMBXiL/iCIgUtJ1zaPHy+H6REQX6/aocit48Af4OJ5N
 c7itafvVMLskv7z+yh2mXeSPE6aXFLpLBR4aSIUNvxh8rUiWbjmuh3QKTXodhrQ4qWTTsb8qyCQ
 uTtvfmk3q70zwcFEia4tBVEHXbDiISVp3bKyFeUg=
X-Authority-Analysis: v=2.4 cv=P+QKQCAu c=1 sm=1 tr=0 ts=6a4e33f8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=pdZ2Pso9XvTDf2pxeBAA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12221
X-Proofpoint-GUID: 3c8H9oqmpsQeDUFI0KDOMMJsbWnemcqq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExMSBTYWx0ZWRfX5awU5XuUXTIA
 DFshL28gcda1T19JSKvqqyAIyyYm6LnLm97WokiCS9IEL4ozd6k8sAdP34xY2CwVzU4b1PMgH3C
 HCEI69RZjbgHC77S4JIL5LCmCZ75H3FE6XaYG1BM9Uau98N3jlzK
X-Proofpoint-ORIG-GUID: 3c8H9oqmpsQeDUFI0KDOMMJsbWnemcqq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_042704_253228_4F34969B 
X-CRM114-Status: GOOD (  12.56  )
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

On 08/07/2026 10:57, John Garry wrote:
> On 08/07/2026 10:27, Christoph Hellwig wrote:
> 

JFYI, this is also an issue for non-multipath, so both need to be fixed:

# ./ioctl_file /dev/ng0n1
waiting 10 seconds ....
now going to issue ioctl ....
retl=-1
# ./ioctl_file /dev/ng0n1  &
# waiting 10 seconds ....
echo "0000:00:04.0" > /sys/bus/pci/drivers/nvme/unbind
# now going to issue ioctl ....
retl=-1
[   57.145946] 
==================================================================
[   57.147504] BUG: KASAN: slab-use-after-free in cdev_put.part.0+0x3d/0x40
[   57.149479] Read of size 8 at addr ffff888105cee0b0 by task 
ioctl_file/230
[   57.150890]
[   57.151251] CPU: 1 UID: 0 PID: 230 Comm: ioctl_file Not tainted
7.2.0-rc1-00002-g54ab7087cd7c #943 PREEMPT(lazy)
[   57.151259] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   57.151263] Call Trace:
[   57.151268]  <TASK>
[   57.151272]  dump_stack_lvl+0x68/0xa0
[   57.151294]  print_report+0x10d/0x5d0
[   57.151304]  ? __virt_addr_valid+0x21d/0x3f0
[   57.151314]  ? cdev_put.part.0+0x3d/0x40
[   57.151320]  kasan_report+0x96/0xd0
[   57.151328]  ? cdev_put.part.0+0x3d/0x40
[   57.151335]  cdev_put.part.0+0x3d/0x40
[   57.151340]  __fput+0x7bc/0xa70
[   57.151350]  fput_close_sync+0xd8/0x190
[   57.151356]  ? __pfx_fput_close_sync+0x10/0x10
[   57.151365]  __x64_sys_close+0x79/0xd0
[   57.151373]  do_syscall_64+0x117/0x6b0
[   57.151381]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   57.151389] RIP: 0033:0x7f2f5a57b727
[   57.151395] Code: 48 89 fa 4c 89 df e8 28 ad 00 00 8b 93 08 03 00
00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24
10 0f 05 <5b> c3 0f 1f 80 00 0f
[   57.151400] RSP: 002b:00007ffdeb622670 EFLAGS: 00000202 ORIG_RAX:
0000000000000003
[   57.151407] RAX: ffffffffffffffda RBX: 00007f2f5a4eb780 RCX: 
00007f2f5a57b727
[   57.151411] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000003
[   57.151414] RBP: 00007ffdeb622700 R08: 0000000000000000 R09: 
0000000000000000
[   57.151417] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000000
[   57.151420] R13: 00007ffdeb622830 R14: 00007f2f5a71b000 R15: 
0000561d17af3d78
[   57.151428]  </TASK>
[   57.151431]
[   57.171652] Allocated by task 82:
[   57.171880]  kasan_save_stack+0x24/0x50
[   57.172142]  kasan_save_track+0x14/0x30
[   57.172400]  __kasan_kmalloc+0x7f/0x90
[   57.172650]  __kmalloc_cache_node_noprof+0x24b/0x5d0
[   57.172977]  nvme_alloc_ns+0xf8/0x3170
[   57.173231]  nvme_scan_ns+0x508/0x880
[   57.173477]  async_run_entry_fn+0x8c/0x350
[   57.173762]  process_scheduled_works+0xb6f/0x1a00
[   57.174073]  worker_thread+0x4ad/0xb40
[   57.174325]  kthread+0x34f/0x450
[   57.174542]  ret_from_fork+0x563/0x800
[   57.174791]  ret_from_fork_asm+0x1a/0x30
[   57.175053]
[   57.175165] Freed by task 230:
[   57.175369]  kasan_save_stack+0x24/0x50
[   57.175624]  kasan_save_track+0x14/0x30
[   57.175875]  kasan_save_free_info+0x3a/0x60
[   57.176151]  __kasan_slab_free+0x43/0x70
[   57.176412]  kfree+0x321/0x500
[   57.176616]  nvme_ns_chr_release+0x36/0x50
[   57.176885]  __fput+0x352/0xa70
[   57.177096]  fput_close_sync+0xd8/0x190
[   57.177349]  __x64_sys_close+0x79/0xd0
[   57.177596]  do_syscall_64+0x117/0x6b0
[   57.177845]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   57.178180]
[   57.178287] The buggy address belongs to the object at ffff888105cee000
[   57.178287]  which belongs to the cache kmalloc-2k of size 2048
[   57.179071] The buggy address is located 176 bytes inside of
[   57.179071]  freed 2048-byte region [ffff888105cee000, ffff888105cee800)
[   57.179864]
[   57.179970] The buggy address belongs to the physical page:
[   57.180332] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x105ce8
[   57.180848] head: order:3 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[   57.181338] flags: 0x200000000000040(head|node=0|zone=2)
[   57.181699] page_type: f5(slab)
[   57.181909] raw: 0200000000000040 ffff888100042f00 dead000000000100
dead000000000122
[   57.182402] raw: 0000000000000000 0000000000080008 00000000f5000000
0000000000000000
[   57.182893] head: 0200000000000040 ffff888100042f00
dead000000000100 dead000000000122
[   57.183399] head: 0000000000000000 0000000000080008
00000000f5000000 0000000000000000
[   57.183900] head: 0200000000000003 fffffffffffffe01
00000000ffffffff 00000000ffffffff
[   57.184410] head: 0000000000000000 0000000000000000
00000000ffffffff 0000000000000000
[   57.184906] page dumped because: kasan: bad access detected
[   57.185271]
[   57.185380] Memory state around the buggy address:
[   57.185698]  ffff888105cedf80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   57.186171]  ffff888105cee000: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   57.186631] >ffff888105cee080: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   57.187201]                                      ^
[   57.187512]  ffff888105cee100: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   57.187980]  ffff888105cee180: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   57.188447] 
==================================================================
[   57.189823] Disabling lock debugging due to kernel taint


