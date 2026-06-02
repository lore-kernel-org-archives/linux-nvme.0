Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09B5CD6E60
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UW0C77635dPlzY6UvBYlGvnZxglYsI2wrFvI5vkofH8=; b=4B0hCS4BmPUW5TkgSM7ZlpA+Bo
	1zXYacX/+X1ZQsKIfXuY/Vy7BixVkP1r1OdD7VnKWhxq5RqlgJA9azAJwTCi40f2CIZfpysH1OG6E
	ifFQ3g6lZ7ysu1NwwQql7yljLLi0oMGq2hwTdMdHefaybN3YBmlXphXT7QTSbcAN+FgIW4fqXqD7W
	5p1CEw7CfzsR9AYOdG1wR+NowOxRIjHjp4eHXgDj3bWIhWjvma32eg4XtkOks+FaseGpQ5s6xC4mG
	k4lVBsepwrV45okG8r0JNmJanFftQZT4LqbC1HNCSGg7aDVRv8/RszVc7GGqYD/LdAmg09h8YZJxv
	TqLKURTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURpa-0000000DQ3i-1I1F;
	Tue, 02 Jun 2026 16:19:06 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURpX-0000000DQ2q-2Kyw
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 16:19:05 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652FilKF221348;
	Tue, 2 Jun 2026 16:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UW0C77635dPlzY6UvBYlGvnZxglYsI2wrFvI5vkofH8=; b=
	edMHIeAQwFm19JwIqCyyLdhVPfrwpDR8s3S1rEof3pmg+phMeNb3epxkYbJM8805
	wHUF4hOwNtTNkLGQIGz00nMeaqa3w1+E/O7wecFM3qkKcQk1o1a0+2s/pq2ZghgG
	Mu1x98cOCpa8SxiSyVfDboRFyI0eNbaYMaeO8GuUBITBFMQpJ3UWFFUIcmBlCa/c
	8AaudtPmhbYnbM/lLfr3hx4mPpPDyIm36L4rc5J1PF6LvIgZRxszQhj3MQWG+c/d
	8+bbokjF1rTz4M4rMl3hhEOOHXsVlhCiVcqBC/zUcKzSxBOzlfValDtSGQM7/0HW
	cYHlAYqZwFROXDZcEN5zag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpfxvgg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jun 2026 16:18:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 652GF2wg039457;
	Tue, 2 Jun 2026 16:18:40 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbcuk9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jun 2026 16:18:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXBNlfrt+igyipJq/RtguiMPY1XKaFmEZzL6IHEP6pes9QAY59PpD6FmXp9QKMkhIooby5ZvRI+PEr564dw6v1x8iwfto5IJUwVQLkJn5lA+nGZ7aTL7nzLzzTuVL0bjVANuvMPwyOk5QJiCW5vq94jmGUD4itdIsENBgILRqWbIh+ccOJrQbP/IKeAeMYDug0IK4ps9hy9/7My3KkJfGea+vQzQQDZY8LH05yy5gku4Aajv/GYtAcv8euJ3zF857xbsFCVyKtD9AvSlV00+/hEuwnHB18J8qvxWC8wgs+jFue6fv/GzKoqBQ+JRsnJYKA8znzlI16jgMomuILEPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW0C77635dPlzY6UvBYlGvnZxglYsI2wrFvI5vkofH8=;
 b=DeDjJPHgoOv0X7u/YbO98Uo3LUQk5wC0IAANSevaBVcjfujdsfxdXJvEUwDG6p++WickcCXeP5yUPIkeFTHxhEO89klZybR4vLchyNAj+kK5Q1ASjOoJBvfqaRwB7IirCLSQtw1bsORJQt9lt4UdFLiv2YTA34fmO9RnhR+3DgAVAtzTZR2sjSGtZSy2bliVkgjv9vZLoGODOfHqQV6OpmAWsoRJeQi6Un0Yy/rgKos3GlPcRmlldGY9Er94V2IstHx3/ZRSmK07O+udOkalKZ1Ss+Pv0EmpSWVcRTU9021C3pMFL5rGCCeX5f5ot6oMkWo+PfTgrCMm7TfN0Lw6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW0C77635dPlzY6UvBYlGvnZxglYsI2wrFvI5vkofH8=;
 b=DsAX/pYSI10MsPKTN+f62WfvBrMn3BuLpPxsVJcENVWd1ngwXBEtjc93h9F61H+RhbLkuY5Yc9SDQAibVcY44+5iKnZKLQrhr6bGqAJ1kcw4eXWD8z3av7IhH0uUXRcwnU231dy/MgU6uRkfVUXrmskFJBJwftP5i3tBRIH11sI=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BN0PR10MB5207.namprd10.prod.outlook.com
 (2603:10b6:408:12c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 16:18:36 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 16:18:35 +0000
Message-ID: <c6046eb2-9594-4355-9f4c-21a6f3bd8131@oracle.com>
Date: Tue, 2 Jun 2026 17:18:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from Identify
 Namespace
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Shi <coshi036@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Maurizio Lombardi <mlombard@arkamax.eu>,
        Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
        Weidong Zhu <weizhu@fiu.edu>
References: <20260515185853.2761456-1-coshi036@gmail.com>
 <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
 <ah7znSpPM-H-ACaV@kbusch-mbp> <ah752_DIQdr_LHaB@kbusch-mbp>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ah752_DIQdr_LHaB@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BN0PR10MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecb0ef3-1566-4f22-2d00-08dec0c29908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jZ3Ylfh0Si6rPXkuc0otEV/QF9TKOV2zmnTigNkOugo959d+MZjPPR2Vs4vZttt2XCB+xRcukcvJwOoAQ1rYXvh6mpNj44n/pSYe4VlYzcpP5UEIDwLOW8K9ln4PnbSzAuYLVi3cjYEhvWV2KS3/WjHggIWOiOHOeqE5w6P5aqTqjZKf7AssCqMz9ec+OiiTd8/NuPaELO1LzH6xUSvM24EpTQbRI5tENHzC/VLU6s446zi0D1FJ/EKSOgKIW13JQcOtXWpOLUeAEz6cz1r0xe/WIux9kVYquA7Ma8cKKLrO6jVvy270dMIan3olf/0KCqqvCtngr11Su5cQXP5yf6Sm1WF7I+Yv9FxvSClU1MU8U8dBWy7GVIVkNRcsyGliKjc80CLRTIjhvHengIh7waW5zameezQigd0RGcBN9LsqmasiNO7yFrNN2cEvr0xjF+Gu4ddn25oCjCac8tpFJyQa9E4A2Zc5ICVbl9ff8LM//hjxlwQ/jf9kvkI0k8nNRGFVCZ6sIEgbdI8dWyDUrAPHU7/jAxioeCHtDVx8pGWlHqmYJ2USbSC/pPB0e0ryqOYodOu2r0BXSTGoxF83izx7UauEz/HLfntKtastX4EFjTBu762HJHryZeJUczuSVYKcXPhANvjg1eOORNP48tL9ZqkPN5jM8zp5H6WEUcD4+fWiqiWIYOtN6yAMX9m+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhLd1FONmlMcTBqeUFVWUh3SkY3SGZ6UlU2MVpBQnZTRFZuYUg3TStRbVdy?=
 =?utf-8?B?S2I4cnJJWmFpMVVITHA4RFFRdVdodklxL1VyeDBobkt2b015YlV3L2I5T3Fm?=
 =?utf-8?B?dHlQY25aSklBMTA5eWN6eVM1V1V4cElVZVI4ZWh4WUZPek1qdEFnOHRackhV?=
 =?utf-8?B?VWhyNklmWmxKQzlEQnVWYit2cXRRUnppY2lHc3pmMndwVXRsMUl6RWhybVVp?=
 =?utf-8?B?eFdYalhpOGk1NVpRaXpFRENWdDFRWVJScTN6NmtsUzRWK3R1WElyS3FlNjNn?=
 =?utf-8?B?cGVTVkRZUHR5SXR2WktDWVJmMERGN1cwWWtzQlpwT3htNTYra1FWZ204VXc4?=
 =?utf-8?B?UG9ZSEwwcTdYKy93ZEtGektUdGV1akI4VHJvUy9hY25OVDdVMTRVZGcvL1du?=
 =?utf-8?B?Z3VTNDZkdWdhd29COVBLd2lZTXFrRlp5NTJGeWliU2ZQWmZIRUhQaHBpNzZi?=
 =?utf-8?B?cFBxcnlhVFVrVmJWa0lUdlVUREV0Q2VkTExFMXFlNmFjNXJYS2E3WGtZRExj?=
 =?utf-8?B?ODRhdmxqYXFsa1NQY3ZsWUJVT1ExUGZiMjJvWTZHcFJZK291U0JGdFVGU2Vx?=
 =?utf-8?B?Ny82bWova3ZkY21QdHdub1dmMTc2Nnlwb2pvRFpSSmlJdnNaeXZSdnhLUm1P?=
 =?utf-8?B?bXppQ2V6aWpSalBPS2p4YVdLV2hOUEgrSTFuRnhpTmdTREo0aVRzUlhxN2Ew?=
 =?utf-8?B?YXBiV09HK1J6U3lpdnEyL0xxaVQ0SEtyWTJiWk9FT3hZdVllK2p0TWJKUnl4?=
 =?utf-8?B?ZFBieVhFdFNvaXg0Ri9NRzN6dTEyK0dzYVFNajVManVxWU5vRnFpY1dMNjdv?=
 =?utf-8?B?SDErQW5tWkE0aHBwNmJ1RjQwckZpNjdLNllTZ0lYRXRlYUp4TDV2N2hFaUtr?=
 =?utf-8?B?VUo2aUxrbkt6S0psOXl4Vm0wVGcwWC9oRisyYnNySm50aDRkeng4dzV0LzB1?=
 =?utf-8?B?dXNqNTZzcVRrT1Y5c0N5ZEtMMzJ4aTllbUR5UmtMakNIV1hBc2x6WmFTZUJE?=
 =?utf-8?B?bjZENXp6T2ZlcUNPM2ZDYzhIL1VZd2FvcTBtU0xPNUNHamZrU3NKWDk0TmJT?=
 =?utf-8?B?VjdhTEF2am9QeHNVeXZRQ2pKaDBjdTNmYXZpYXNLQTIvMVJ1N0llak15L1FQ?=
 =?utf-8?B?UTZzZDZoMW5IZldGLy91bHVoSkxta0NCaFI2REdvR0UvcmdoZ2Eyb3M5ejhn?=
 =?utf-8?B?K1p3QkRhc3c4ZHVrUjlPQ3BQRm5uMExBVEV1U0thOFM4eVJvQWlNWFVoczNP?=
 =?utf-8?B?eUVoKy9iOFdYYnBRUXM0bDlGaEZ3M1VGczAxVDdaeUhUUS9icy9GbHB0U3pu?=
 =?utf-8?B?L2J2T25PVEF5ZE9FL2JycitsV0tSS0VhMEtwQ2Z6QW8xaTIrSFErN3l2aE9C?=
 =?utf-8?B?MlRiQjVrM3B3K216cDVPSUswUGpBQnJaSDFVZStyd3dFbGJndXdDY3BVWWlZ?=
 =?utf-8?B?R0pOM29yNDB5WHJvQUduT0dFSDZXYllhZS95RWlyTHhHZWFEaVo3VFUwdC9p?=
 =?utf-8?B?KzYwQUVWdi9OZUY3VVlyYWl1UWZxWHZrT21rbGIyWE1uTHhZNXpNdlNOVlZv?=
 =?utf-8?B?Uy9ZaTdwWmx2dDVvaGNWMjdKcjFZUy8zL0R0UitOcUdzU1BTUzN1ODF2V1lm?=
 =?utf-8?B?VGg2UzFVNUhNYVFrZ2tyOUFVdkhqa01kY2FHYzVvaFRVQUxKQUhLTzFvNG80?=
 =?utf-8?B?MCtPSU5qeFRmcm5XaHBOUllIYUdrdTBqZmViMjVlREdkVUxNT2ZPN0NnejBP?=
 =?utf-8?B?Y2pXSnJKYlJOZUJhakdlZk5yaDc4V0JPd0pCUUNIZVdaVXg5ZTFPQkR5aHhL?=
 =?utf-8?B?VklxUnBwdWRTdmVOMUZWb1BKQ3Q3Z3pxeVRkVlhqeVArbnNmaGhVWXRtSTR1?=
 =?utf-8?B?bjNzSWsyY0pta1hyMEE3MEpBZ0pua090cDdIeDEvRjNZUERDSXBLaEVHdHJa?=
 =?utf-8?B?MWwxdlhBWWdwM2hhNyt4bzZHd21pUUExTmlreEo2ODd4U0tXbzlpVU1CVUpk?=
 =?utf-8?B?dm11V2NOcTN4bFhGSk1KTjRzanA0TlJhQTF3WTFkNEswR0l5SmFRekk5VTls?=
 =?utf-8?B?dnZHNjMveFFCNDI5L0dUaVE2Vzc3bXF0U1NqcThSb1pGUVhaRzB3eEQySkxQ?=
 =?utf-8?B?Skl0TGRGQzBQWXBoY1Y5OG9Yd09HQllKTzFMcWllV003MHBlZ0lsMWxZVnVy?=
 =?utf-8?B?bnhrbjB3clRpTGNmc2RVRVpnWHhjUWxBaVB2WkNpQnA5NVU4TmpyMU45RXJD?=
 =?utf-8?B?RDcyTEJOUXM4OTU3dTVlVm0xdFEwY1lhZ2ovMFFSTXlLWU9RUHk4aHVKYlFN?=
 =?utf-8?B?U2xJMFVNaDJSUlUzR0IzL2tTYWliSjRiRG4xMzVSZFpUbG52WS9tUT09?=
X-Exchange-RoutingPolicyChecked: kxCD1uXBNeQ32RKcf5aFBjS065xAffHoKXAmFyXPuryGxqu/unfNIgbPk0KJJCqZn8DrstHKED6oKiF0lOYyWt8XhvDnT2BVPWNPGwcDnEwJpDmgVtcnexUMo2y5D8csQJy4WeP3ecW0NYF+fMR+nR4dFDCVZtnXliXvKxq+NkI7t3nfSToIcq9lHEtoOnUWKH//WtPJGe4jH/qGHUiIHNZzFNViKZXXXoUWWhpepFNwCjZWdkeU6L0+iukP7NfdOQ5fSS5xrVNwMUtr6EML9NKsOBn+kmHD7BUcUzJdybkY5/N3Y118o+ff7FKUnQrWp05bzYGPUuBwvvVFu1EQng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xzNd3IzHJX7907SIifFuuMzSzniVFjk3BrLjZCAm2KY4w1jX2Vhwqrwzz/SuIvVbf4ZbEZS/AkwZAvf9gFQvXwPf5U8CGncq4P6n4I45rs4Tfa2k2qABZLOJONXVGs2kZT6iSmyRupR+2tHqnROt6Y5kU4rTrxext40BFCsn1boYJRL9mkuzHt0Ki5Xpa8orJs/je8R5MsYpjvGlkiadvu3VpzsLlT3HBAjhYsJUT7yFTKRABpICu2xYZgeiQPNEMv0uhaIu6cf4Z8Ipcd3xDDX4shB0jMkZVNt0m91AXZKoO5SpNnGm3XD5QG7WkcWpYeoFPhHOqlpRw0dPAmrc1QNxX/KF0WWPl+/Ggus3jwDMUqlLT3dUozzncFeHyifRMUI9IUen4L1KSn1kj1W9w5zIJl4aWoy/oB5Jh4P136+WLaTGUcKUMyVqfHsQcQRLNlyNPFifky/F3TG4leRvBu2I343ro/8nBLc4fDWmN3vzAYvnucv/3Ii0vqyQpV1ff0ijp4xj//elpABc6Q2c2MmgtnevA4jnOB7BynoF3eCctyYacl5SRodr9zZnSMGesH7BzLMa22dHQBiZrdrExcftmFaE2Zjor3omaa8qux0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecb0ef3-1566-4f22-2d00-08dec0c29908
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 16:18:35.8592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWoWdAbBizCVir17kdc96W4osNUfAmdutVlwDjDyTM2XsWROdCQsW6fIPoy+ugvCwpzRqLM7nx3vPBHs7WTM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606020157
X-Authority-Analysis: v=2.4 cv=FOMrAeos c=1 sm=1 tr=0 ts=6a1f0260 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=aNp1UiQglMhjhedrHt4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Pxcg9a3lR7OckRhZDWN_hqiOkJYegO13
X-Proofpoint-ORIG-GUID: Pxcg9a3lR7OckRhZDWN_hqiOkJYegO13
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE1OCBTYWx0ZWRfX6J2sk6hoUBno
 p9Z6HylDpqpSSUc+OtktQ3UbV60fjqgaSAnfnpVUxiRN6pg7xuY5i/9ZNO5kiqVDrkDNiDWELn1
 lwcVS9IhoJXyiJcHqSzlHtsxdcEGidNCwcvYqYuyagkHQgEFrrM6cwQTvallnLp6qO0HLrD4gUA
 fVj8XoWGWM5N2SMWUoTqIbBymoeTS/dNPku3XV0lCsMqpK7XY7T7/eO9SbJ/Cn8vqN/Rw+oZH9K
 pUMx4olS7UP3LvZHiqLtjunmFPvs1c+bhcN8yK1jqc7uB8dFCV/I0i7M74+Zc1TZeP+MiMRQckg
 EzmbuBZxMZ4Eqr09s1N4fo5OlZacMJ2vAcchQWXYUjhlFLZaORYnrXx/TuR5+6XUXxl3vI4xbiK
 ++499KI1MYEmG8fAePwXjFJY0VTl4Vh7QcqGMhroRrbQeUSqmrAD4VgT2YgtApp504fGmTZVyjY
 jmw2w9hEMAurZE82SDQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_091903_910008_F192EBE7 
X-CRM114-Status: GOOD (  26.11  )
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

On 02/06/2026 16:42, Keith Busch wrote:
> On Tue, Jun 02, 2026 at 04:15:41PM +0100, Keith Busch wrote:
>> On Tue, Jun 02, 2026 at 02:10:07PM +0100, John Garry wrote:
>>> On 15/05/2026 19:58, Chao Shi wrote:
>>>> +	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
>>>> +	    check_shl_overflow(le64_to_cpu(id->nsze),> +			 id->lbaf[lbaf].ds -
>>> SECTOR_SHIFT,
>>>> +			       &capacity)) {
>>>> +		dev_warn_once(ns->ctrl->device,
>>>> +			"invalid LBA data size %u, skipping namespace\n",
>>>> +			id->lbaf[lbaf].ds);
>>>> +		ret = -ENODEV;
>>>> +		goto out;
>>>> +	}
>>>
>>> JFYI, this is giving a C=1 warning:
>>>
>>> drivers/nvme/host/core.c:2411:13: warning: unsigned value that used to  be signed checked against zero?
>>> drivers/nvme/host/core.c:2411:13: signed value source
>>>
>>> I can't seem to quieten it myself, though.
>>>
>>> BTW, I would have thought that check_shl_overflow would catch
>>> id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra check).
>>
>> I see it too. check_shl_overflow has checks that suggest it was
>> expecting a signed type, as all the < 0 checks don't make sense for
>> unsigned. The warning seems harmless, but I'd too like to see it
>> suppressed.
>>
>> I think it's odd that I'm not seeing a similar error for the similar
>> usage in generic_check_addressable() from fs/libfs.c. They look the same
>> to me with respect to the types passed in.
> 
> It appears that sparse is having trouble with the type provenance of a
> __bitwise __le64 type. No idea why. As a test, I replaced the
> le64_to_cpu() to a u64 type on stack initialized to a random ULL value
> and the warning goes away.

Yeah, ditto.

> I say we can ignore the sparse warning, or we
> can rewrite this to avoid the check_shl_overflow entirely.

Since sparse is having problems with le64_to_cpu(), I suppose using your 
own version is ok. It would be nice to know the root cause of this 
issue, though...

cheers

> 
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cad9d97352615..6409a8218e3eb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2372,8 +2372,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   	struct nvme_zone_info zi = {};
>   	struct nvme_id_ns *id;
>   	unsigned int memflags;
> -	sector_t capacity;
> -	unsigned lbaf;
> +	unsigned lbaf, shift = 0;
> +	u64 capacity, nsze;
>   	int ret;
>   
>   	ret = nvme_identify_ns(ns->ctrl, info->nsid, &id);
> @@ -2407,10 +2407,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   			goto out;
>   	}
>   
> -	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> -	    check_shl_overflow(le64_to_cpu(id->nsze),
> -			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
> -			       &capacity)) {
> +	nsze = le64_to_cpu(id->nsze);
> +	if (id->lbaf[lbaf].ds >= SECTOR_SHIFT)
> +		shift = id->lbaf[lbaf].ds - SECTOR_SHIFT;
> +
> +	if (shift < SECTOR_SHIFT || shift >= 64 || nsze > U64_MAX >> shift) {
>   		dev_warn_once(ns->ctrl->device,
>   			"invalid LBA data size %u, skipping namespace\n",
>   			id->lbaf[lbaf].ds);



> --


