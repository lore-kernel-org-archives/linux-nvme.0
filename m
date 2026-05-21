Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BA8CD5BA4
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4W8MjfplYZKqlzNcmqfAynlsWYlENeNEo42iRvmt9s8=; b=RKa59FN77Sthc25kZNcYtGjjQq
	ygmpP6844ULrqsVJ5kX59ZBAZ/+QI9+nwFTK4dO2CKzoQYQGi6PU8PeasNqT3yySXQ2+7QtMFB+bR
	9y7mID+KBpftxZ/2js+moaQCFLdbWeyqGvF0AZNb2xf3GOZhu9x/DsRUO4leBzPWDHyxAeTDFKzhk
	tR8UZgm41Xg2B0L88SBwrgeJuegsko4dBC4SRVaIPP4V4MxAWTGhurekKisPaDRY1A8rpyvYT3/YU
	1AqWhDiTeHlWejbavCg7fyndSPNz6knJgcpfWCkyvvqZqEHmCnRC75Jnvfjpfx1b5v4tA2U6wsvTe
	DlhVWmSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ2Av-00000007gYL-2APB;
	Thu, 21 May 2026 12:06:53 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ2Ar-00000007gXI-3hAM
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 12:06:52 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1MpIa3895502;
	Thu, 21 May 2026 12:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4W8MjfplYZKqlzNcmqfAynlsWYlENeNEo42iRvmt9s8=; b=
	W6Ec3YbfojpRSN0w7ZL3tVFubWUkAQgB3b5i5if2R/iYk4N5GqXDIGB9AtodYbP/
	5ZR7j7ECX0z/kVnzf2WhZIcgFF1SLEfIWrdjHaJ/f4WhUKQylEYT+e7oTKkUbfYb
	GW9NmlY2cdan4w+Rb+SzXYLb8WWHmlo4/16462n3UNe3oLxXypZ3PPyZqReOvqsM
	ZQDEmPfSjG+ZVScxeXQsFsM+NGgo7InFowHhcvcFNqFBvJiSVdCYZ8Hf/iIrdXpi
	6Bp+55w4ypHsyIu0urUOAGM1ODNjL0FDS8hsL/933jhz2adDhg0fJnr7UeMxpPIK
	ioi/vBHSLjtQnCjpc4DUlw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4q963m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 12:06:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64LC4qEF030694;
	Thu, 21 May 2026 12:06:30 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1dgm9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 12:06:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT0LZQR5FJMqJZt34MN3NcAXDZgKu1Qop5rhVPzMwggQVMYXgbQchTO2LC2D0JE1hlzGRZXCIMMPzj2K0ZMl6N815m7jAdEHa/MC6gziXKVtRmltmMqQT3GoruumP2NWBKcTtZXh8/BDfeN993Ou9LzzTTYHopPi+W2oLAsMv04REtZpoCysfctMamLpLVEWjW81cT62MYIwZBNDSFGuWqRWk5TybltwVdcrWtW6lDwyzSJo/VnVIk62EwfyURFvT1L8VcNhhvsJMVnD5vsFsjBcqlSaGYEYtRTb2dp+rV9BZoowd9bgOMqQEgwWF7s3wrpCDUtbKXNuNmPk87PDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W8MjfplYZKqlzNcmqfAynlsWYlENeNEo42iRvmt9s8=;
 b=Q/Ov1/xBl75BkhfTSuTkuD7q0uQkdmu49hB3FwmCC05Niy7ENSkc26DkEpF1qe3Rgtk0gNi0A+EsksWGuKkM5FRd1oJpf08Tlx5eTFb5VcdivL4Sg+/JGFtw3CcEZlSeCbsV9Kw7gFb234qfiLGwv11R2eR32ViAmfwfiSbM8FzR/ILbrtBvcM1TVarqN+/N0fWgqM74FynuADcGFO/Ky1wXhMtXVB5HGLRPrzpVlQwfpEwHt3jkdlgf75E1vJ+VsPePUxHxswCalTUxKjAFmlkLFfeVxyIhxXEEnJyzBwwNNaLA64c5bhThD7E5FBbwzue9bpJcKANjc+rOJfMRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W8MjfplYZKqlzNcmqfAynlsWYlENeNEo42iRvmt9s8=;
 b=s31/CO0PARGbvNNNNtZxhnZ/ZMpLA+sxrbLRh+y81Aqd++aMw9gYheURLffDoO3cYv884Y0IWc6/e3MRq9Nqm7HAwacwwiey9JlbjntmK0wwd0cR+1Ejx/vNcx0LhRxSE68Y7yZMaus73GolDIOwagM42E1TfGEJEEDPOWaCVlM=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BN0PR10MB4981.namprd10.prod.outlook.com
 (2603:10b6:408:12d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 12:06:26 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0025.020; Thu, 21 May 2026
 12:06:25 +0000
Message-ID: <e9b2c9a7-b9d5-48f3-8a79-cf925b99b7e1@oracle.com>
Date: Thu, 21 May 2026 13:06:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 1/8] block: expose
 blk_stat_{enable,disable}_accounting() to drivers
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260520182112.863076-1-nilay@linux.ibm.com>
 <20260520182112.863076-2-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260520182112.863076-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BN0PR10MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 777a416d-2d23-468a-2c34-08deb73161cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 458za15EbaUCZm3hlmNBgE9o8XhoIvPwhvEblu3pI4qL7jFzgPDXGEfYxnu9v4UOYfE6omDiF/GsqZqFU6+1veZ/VwtBgv4BOtBnv1PzL9yhYuQYt6LcJ9haf6tt416pdPrTHeSLtsZiGTkYCZ3NrotZKKNqiKYP95lwO+CrP8w3PvfMWMQxiBiF8nF2TGN7ykck/lSnSuOs++gO/UBiROljMRmRWLq6LKmZZDNKtqH9k2RTjmDOybMYLJxnF4/KvMD5lG4M/TgYFs2a7Oi+AVfPfyEocdtzJy9g//m0DLQ4OP1CqLE/6e7etsyoX06Ep3zj8jN0Krla0NYf2j1tl1VNiS7Lt22E0LAeex3I0LjdhrIlvu9hI7JbqI4J3gTCl/PxE5tYumVXykfXCyQRG+MuzRgDwppXW+qqK4u6Fh4NEYQiq7/6ZaMcn8bubE6HKO5jhJSACg9xU+xxOjxER7ZHjpVRqjcM4CYbnw6vv3BY82gWUhlnBsCj/X70WynhGsGZoh/FsRpllExUIWgs8tvpTtZE6vbY3MkL1AgEyuroeZGX/cjYFcCggBezQXHjxad93fjm0xnrzmGxUPlLpNUNQhGaBrvhT1ERlvTIBluwTGnLIOfPNr+O7j+22Fd545JdR15fLtcBVh7nwh/NpY+ymMt1bAMgjJqeoGQIAs6Qh4NozQc4GW+0E2ALNGs4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ZpQ1NuSkltM3BJeEdlMHYybEVPdkRVd0VkTGNSUVA5VEc2TVI2bWRMN3pQ?=
 =?utf-8?B?WTArWk80alZ6TnQyb2FRVGFHRXJSeUFsNXpUY0I1dXp2SkdneTlFUURjWHB2?=
 =?utf-8?B?L3RncG42akZXUHVJckVUZExQZnpDVzJJN1A3ZjRlT3Q5NGlqTjRobFc0L0dZ?=
 =?utf-8?B?WlFsZ0M1c25yNDRhSDB0QzhvblFvVEJWQ05wakQwOU50bEo5K2ExMUtzMTkz?=
 =?utf-8?B?MkQwWWliTGVYNE52T1NueXpGT2M4ckF3SHQyNHZidGJ1bWk2OEhuN2o5R2N6?=
 =?utf-8?B?bGNoV09yZmxweituSFV0T0JLem9Hckc5SEZ5R0grNEVvWC9UQjNQTW5yMXY4?=
 =?utf-8?B?NU9zWktETkxMemZHUThSU0UxZlBlb1BNbVV1QWh1RXdNWXRTb1pCTnQxbVM2?=
 =?utf-8?B?bnJEUGUxZkRKY0hBdWZVWGJLMEw3TmlvUmovN200QVpJeGUwaTFYcGNvZndo?=
 =?utf-8?B?YUZnZ2NxMHJzQk1OaytmMXF6amxjSGF0aEhrbUdZdDNYalIxY0NncTVIVHg0?=
 =?utf-8?B?eGVZL0JnSkVSeTV4TkZmeU9Kd1VLZjczV0xOKzd1NXNBMEhHakR2eTRSL3Na?=
 =?utf-8?B?VDRnYy9jNEZPamI3N3d3blpYK3oxZDN0OHJLUHNWcjkrMnl0eGIwWGd1T0FK?=
 =?utf-8?B?NXk3T09yVzBrdDZlVnBZdTN2YmoxVndIZldkN1VGVjVRdU85Mmw5aHF6N2ZM?=
 =?utf-8?B?N09RUVI5eXhFcVU4VnE3REpKZFZSYlZWeGo0WDU4RjdlRy9wTzhML1BjVy8r?=
 =?utf-8?B?TzFpTFM2WFp3Z0tQekxqTjl1bGk5S3MwdnkyMnJWY0dwRTBFOGVHQlU3QitB?=
 =?utf-8?B?eDh0WFBUVkY5K1U3TVl5RWZSZk5EN29TOXFvVUxabmdGV1BvcDcraG5MUE9Q?=
 =?utf-8?B?bngrbDhHdWRuK2dhQmpkY2hjN0VSV3Y5dkdaUzZ1b1FyaDlyVDJUSHRzSGcr?=
 =?utf-8?B?ZFc4QkhUZCtyVXppL0h1bEYwS0xjVWUwYlZva3duQ2hhNlNxT1FJVzl5U0dJ?=
 =?utf-8?B?SUROYTZ4VzJwR0JWRVVUZXNmVmc0RXhTLzJKb1ZXSnV3Z1IyeVhLb05TbTAy?=
 =?utf-8?B?V1F0RmlnRWlzNjdub0xtMzJ0OHp5Uzk2ZzZoNTFNZVpVWHZqR2h2YUFLQ0F5?=
 =?utf-8?B?ZW1obEdsSm1QemZyd2RKUWIvWFhLbWF6QUpoYVVqVGRxVEdVSzFuYWhvaElH?=
 =?utf-8?B?dkpXbDFKVE9uY0ZmTXBjMzNtY1BTZkJjUGJ5bnR0VWRwRlRnV0pKR09ab2l0?=
 =?utf-8?B?dXlUdVR2WmxsNFZaUHBZbU9QQnAyZXM1MlpiSUZ2cFkwNG9yNGVzeXBPTys2?=
 =?utf-8?B?VkxFUndNU3VqQzVBVFk4YjkrdDBZYWx5SzJtZEhIS01HZjNnUkpnYk05emM5?=
 =?utf-8?B?NEpjZCtSWXdGSWNjcW80TUp1Y2JlQ1k4Tkd3NkkrUk9OMWxkeFJsZlF1QzBz?=
 =?utf-8?B?dkNXQkNRWTFhWkVNVTNIRE50QTBDaFJIc09FYzdpZHI0Mk44SjNGeWVQWWZs?=
 =?utf-8?B?QWlMYnRiaE9KM2svVmd3QlhFOVVBM3pmU0lLVGtNS1NEZVM5YnBlcENVK2FB?=
 =?utf-8?B?VUJWaCthb2ZPSVRQQXNENjN4QXF4cjlYOUZjS3gzOVkvQ25nanFpbmpKR2J1?=
 =?utf-8?B?bW1lMmh4QXVvOEE4U01UQngwSVZFeEk0ZkpaNE5tVkw4eklrMFZGVFFuR3Uv?=
 =?utf-8?B?TlhEVWkvc2k2QnNqTjBodUdUMGhuOGVKNVN1YVhULy9PWFNoLzFsanZWQmR4?=
 =?utf-8?B?bTZTeWs4aGgzeVdUWitKV1ZuTXdkVTd6QW52cFY3VkUrMmR6b2FDUjdWQzJ6?=
 =?utf-8?B?Mm1aL21ob2lkUnpDb3VSUDVTKzdBOG15V05udzVDSmltc2FFYU1TeFlXbDVG?=
 =?utf-8?B?NkI1dFlVNUhhcGhmQUlwSWl3QmFVbHlGWTlhMWZiWkVFZTFFbnpxbjFkRWkr?=
 =?utf-8?B?SnhWaWxXWkNWUkNsQnc5Z2NJSFRoRFFsOXpxeEpYYlY0cnlncVZ1NWh6ejRi?=
 =?utf-8?B?OFRublhYeWFYT0xjMitSWEdXbmdnMERkeWFpQXVEb1hMTXMzM2F5T2M0c2RU?=
 =?utf-8?B?bExublFjWDJjMmQxcytjblRYZHJhM2UxNW8xK3VVUVRwVlZ6aU14WFRqWHZQ?=
 =?utf-8?B?RWg1NDdyL0JUY25VVTJ3WTRpTFJTSDgyalpIek1idmJpSnJ4a3lDWGtzdko4?=
 =?utf-8?B?d0pmYndlWHdZS1RjemtyeGZLVlFSUk5TSHZlczlUK0tabVgzb0lFTm0xdmgr?=
 =?utf-8?B?VGtiVk8zUW9RT2VNL2Q4MWVpTTdmSFlwT3pOeExZaG9zdGRnMEtYZWw4dzdW?=
 =?utf-8?B?YWt2NWFmUERFaW95MUZYUUp4OForaldVRlIyQXREZ1g3MS9xTDNyZFcvK00x?=
 =?utf-8?Q?kFa3TyqGxZLoppG8=3D?=
X-Exchange-RoutingPolicyChecked: edXYbYN07YjZiQ85xrZd6CtWNeEUfFdoV9k9ga2dQtAy1WBZtTFQrK2qHqv1hya6xzlVI7TlUj244G6BETkFSWuBZ8TTDwtD9lW9lEnXmmWUZbUYCojXf6rRrBruJ6S1Pk9rw8A+nLKgB4SfkaPhHU42ii6WlRqcr2as+ktta/zh23cRMM4Z8LQr2AdTAFnNOZYrHZxQafPeOj/gzhViVPprsbt6j45KlqCFlyIsnTGDzFEW4PNss6RxWGcDIF3ksYa2zhBotAwq2E9dYH8EiEI2iIJO2WTz3OkQAJSZW9PVwlTTo6VYNygMSZUlIRVikar4JhSzyRoMLWeG9l1Oig==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VIhaQUIkSO96hQ9/LYbdMUL4jEEAqjERP85ijgu76hoqFdqE4w1l4YBbb74Pauz/2fa6a3/TQU911c7uSP0PvJgmlCl7ifLBxj6GgE0QeJs/Nqmc5CSusutdBr3YA7PW/3Q/3mE+v8DAhGjROp1Z8RG965p3eQ8nw2QTE4pBrL57l92DSwnumBd5V+zhufx7AOewJSsf0lOU5ELMyuakla6Bkw/0QZrS1WWQnx91YiYC+c+zSjZ2oUZWENFa+MRnykqxQshEN3w2Rus92Lxm09kFbmBELvJet8U67H4kTes3h3NGToV5Wrj7uM/x215PQYsXPlsk+A172MHf5J4NPp53gczly5lzdaRSpedJNlOZDJ2V32qFjiwwDX9EhDJePJKc4N6IVIsnTvQPC7N/hcQKKCiFr+2GE2Yzp7Au1aA10y2ZORlXKX45hAR8ZDRZ5MiYSuEeTu1KniCWU6W77XuXXgOF6EttLB4NC9d/HZC6BpCxcTndhg/jAY9+uMp3qK4keln45wNCRMppUq0gfR0W6gESooMNdPaNaIp+ViInpPeN4YZvUcgULbTFtwCvBRljeU+iOXvFUA6B2NGaEhDJVMOcevoQgPtqzd5VFLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777a416d-2d23-468a-2c34-08deb73161cd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:06:25.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klgIchmQumfV/HYcR3qr5nL4OTmW5TsxTak3VCUp9snlwAHMG86f8T0E6OLZAEAE2KkmLIUXZ0gplwqic7qVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210121
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a0ef547 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VnNF1IyMAAAA:8
 a=nARipHbfEPCvZBunWeEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EAcjAiKXRjayuICFMsbSxV4VyeI-WBGd
X-Proofpoint-ORIG-GUID: EAcjAiKXRjayuICFMsbSxV4VyeI-WBGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyMSBTYWx0ZWRfX3nqk2X7j1SyN
 13VQPO/FJUlAGUCqSk5ukyQ1DO/z9xhDNpmIfygJOdP5i3xQxbH7FZ0A6rmwt16WE7tHaJ2YrZX
 jqnlMDvOXxMYAOoQm2wY1U6RF3M7H0jv5Ds6DLoOQIe4oUHvvL3YKBW/VuriWlqXYLCAhJAeHdF
 Yan57zQBGDXrsMaQ/mjx1xH0ePD8qx2SaK0VKjzqZQwA3xLAMUKwpUfQe23Bn6P6BvoLGzKitxH
 GncHILxBDz15LtBhnUFRnM9MHQGRXkbEwLvfKXMBCTZIX8TP8Q9nzuLEOoKErCPJRG7spEo7+QD
 1bhM3RRVKX/qRPJG79+BKFD8b+Iamz96HVxdlaUXg/l2pla5prYBsG5cuA9SyR3eYQDXXeog6Rm
 lLMBHZKvYvRZNlqMeutimIMYDdKCByGpH0ccSC5cYlg8IS4rorEylnArS23C6AiWeHDl8nZ8kwF
 NZPpHIPyP8P7C9zCj8w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_050650_339598_59041C06 
X-CRM114-Status: GOOD (  11.20  )
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

On 20/05/2026 19:20, Nilay Shroff wrote:
> The functions blk_stat_enable_accounting() and
> blk_stat_disable_accounting() are currently exported, but their
> prototypes are only defined in a private header. Move these prototypes
> into a common header so that block drivers can directly use these APIs.
> 
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> Reviewed-by: Sagi Grimberg<sagi@grimberg.me>
> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
> ---
>   block/blk-stat.h       | 4 ----
>   include/linux/blk-mq.h | 4 ++++

struct request_queue comes from blkdev.h, so maybe that would be a more 
appropriate place to locate the prototype.

Thanks,
John

