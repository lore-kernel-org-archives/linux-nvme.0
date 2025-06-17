Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AB8C71157
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxB/FffYOiH73hiQgo0rm6T8UhewYWc70O1AsZrwV7w=; b=sBDLV37VTd7Ur40yzLWnnHV8DM
	i3NHSYzXaFGciiA6+cHWk27rVvmjNh7n2KuUDz78BzUMKdxeTNBwNecMuwr1beHqabxaTEgshAfTr
	/V6RGmzcqsKegFHdNzlyqixuiLHx7iltSkWLj1eVCeQ3TH099G/0upv4CtI0TG8bGM82ROQjOotNF
	2XoVoCMAbSGVSX0NYwOGCO0yOrGG8SGnYuR475SaFLdWFdlqZr9AGKQ3VstLqKhVhZdumXw2wjxwQ
	7P7tmGuNbudpbgQcWIV+QX6aBvVGHKLNLr2IGZQCnSyaef0DvtIF/SEW8Rsk1l5qObRSYxO4rWZG2
	EToUuuKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRPtw-00000006MsM-3s4c;
	Tue, 17 Jun 2025 06:34:32 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRPmc-00000006Lxt-3FgJ
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 06:27:00 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H06hKF030561;
	Tue, 17 Jun 2025 06:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oxB/FffYOiH73hiQgo0rm6T8UhewYWc70O1AsZrwV7w=; b=
	FesFGo75n5N5I5oH5wj1uKfzNVXk10e8c/7lHgq+xNUcbl65w8ooculxYA5rkrVb
	E/gIN98x7iA+zkw2jkxgyAJLly9txOXct5ZNs+Q+INMe7VAmCWbd5O5JobdDig0H
	XOtI/1XFxnqntoWsgZjGIJsgyTEn/BreaGuFy6xki6bHCh1N549OrsLz5sHdoBFp
	0+ah2K6cr9laONHkyxJGjuNGtA0SYd+ZFN3m++2AudFfmZasjYCYg9NuNBzANR13
	0eZnP6JYMCv4b8ws4GD6sJjFHRFnnAn77M1ZM3NVruJEPUpOKiKkPGu8jT+uTxTF
	TYcNE6HVChqJ7fUBFzAaAw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r3pvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 06:26:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55H4n1CE025895;
	Tue, 17 Jun 2025 06:26:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhf3ank-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 06:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7awZtkl3LY78tmJ+GpOZWro+2KcNydLZoB/HKoBDCk4iHTuMa6JbuHPS7bjQ99DzbQBtQAv2b/W7lkAgbsGg+VImv6A16ZZGYJtx1bKe+17Zn80ezQU+zAzJv+f1QMxakyG2pxa6oLntBqJFKY9SVA1ZQR+ttia8PoFx6zJVOqk2CmFxqdgnE+vNMiA/xEb0sMtiZCXqF0sKFpN+d6qgmSSYCv4i4azh6fdEm//jQ5waxM71u1tfidAiERRRYOgCbTChDzhNE96uKLoL5kFjifW+9aDTa+tDfT8Zqh97RgmuJYrV37JgZCKDTfu1Tzi0qxHMn0vCNdceZiGOrchRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxB/FffYOiH73hiQgo0rm6T8UhewYWc70O1AsZrwV7w=;
 b=Mt7uFMlU/8j/bg1m21We0GU2n4pKXzPHukhwKetdTByRtSDVTG6LxCR+0F8XoahjAvYbYP7FSzDOP8z1Qvc8Q5Qq+Hg5q57tyF7TQhIhZzn7zxpy8SOiirKiDZsS7rekZ55fNnS8u7UhrgBNu4Kp3FqfbAvaJcxEkeU/gOKhJYEsH3CNjcx9uzjv4eW+8uZ7OWovjjbs35HtGD2mGeBG3MYTwCUUEQ01Y7Cnno7VzRIIJAONjdvGKrN/LkPTmB6nHfCmOz/3wDfYldmS++aGP6ddF5wHXFbct8f+TFeZcLpZIMQxsus+DTZudjLkHDpek0PjzGv19IBI3CQrjk30tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxB/FffYOiH73hiQgo0rm6T8UhewYWc70O1AsZrwV7w=;
 b=WQ5EBLpiRYJT4XkcO2XLcBffiAQ6CTRqe+VrNCHnAPXcw5gqALde5iDJPHBUQzn2Sqiax9g3Z2uAvewaOIMQ6KfL/NCULdLALqeB8VNaVGa6tiukcRQTGV9eeH+TPtnqSbsOd+tOSRHHPH64al0cg/6z0gQMlkAgEUyJwxas1iY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6583.namprd10.prod.outlook.com (2603:10b6:303:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 17 Jun
 2025 06:26:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 06:26:43 +0000
Message-ID: <7a4d3674-53b9-4f9c-92e0-74aa1202f500@oracle.com>
Date: Tue, 17 Jun 2025 07:26:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Fix incorrect cdw15 value in passthru error logging
To: Alok Tiwari <alok.a.tiwari@oracle.com>, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.d, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250616181936.2094176-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250616181936.2094176-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f74749-e19c-41b9-ba5a-08ddad67ed36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmJCdGc4S1ViKzJwS0tldnNSTUt5TUc5OGdqWkFCS2JUM2FkRHd4VHdoV1B6?=
 =?utf-8?B?V3FhNnMyT0JJNUFCOVI0Uk9SdG05QWFwQjZiS3pNbWpjb0tvL3NHRWpHWGlw?=
 =?utf-8?B?OXBLNXBsZEZ0cWdNZ1AzbjBSbGgxN0xOMXo2QzBHbmp3WDRIYXdDZVkxN1Yx?=
 =?utf-8?B?QjVKSXVUZnBTbU1QMzNGeXkwOFFad3hVVU85QlNRR0FKL0JPTm1Fc0I1YWQ1?=
 =?utf-8?B?aGt1Q2RFeGxabVZNVHR6aHN0VHY3MWd0ZFlSVFpDVzdnZkxSR3JhYUExNC8y?=
 =?utf-8?B?QzRDUWdxcUpVbFl2WjI2ZlNYYWRZQ251UnVDeXl4M005N1ZndVoyRERmK1hp?=
 =?utf-8?B?bk1CMWRGOElKUFNOdVlGMFBITUdIRC84NXJYZUZheTd0elBpM1RlOUN1MUp2?=
 =?utf-8?B?bnp4MzM3aWltdmQxL1VYRWtWSVpob3FMTjQyazhOYUdFWjBpWTdQYmJiVmha?=
 =?utf-8?B?dndJcTlScTJzeVk5c2xFcW5md3lTcXp6TTJlVWlZWXJsZTBGd1R0TEVYRU51?=
 =?utf-8?B?QzErelRTbUNhM050Z2ZOM1hqcVlSMmRiZ0FPN1VlSjRNT2NsemRlNmVXck5S?=
 =?utf-8?B?TmdsWlFDWmRneCsvNjBMNTRxejZOMDRhY2ZRRTJJUGVrNkZnQlNnZDRkQnZh?=
 =?utf-8?B?OHpTaFM0TVVoODd4bWRnMDV1U1lCT0dtM2NvYXNzbmNMTXVySmRGR2JIR0Vy?=
 =?utf-8?B?RU9mamh4akk2QThhYkxJd2RIemgxSWY5U3A3ZERqY0VmUFVtRnFkSXViVEtU?=
 =?utf-8?B?b0J3Zkdha1U2WmZYcTNKNE8yVU4xM1JyelExTXZUMDcwc0dVR0xWVDV0bHNt?=
 =?utf-8?B?aVhqaXNVTW5EeTVTb29SdGllTWNaQzJtU3hPMVdURFJVUkVucWpSTFBTMCtB?=
 =?utf-8?B?bGtuR0ZtMWgyRjI0SUlPSzFKclpLZXV3d0h3a256VlQ4M08vcEZYU243RlJ6?=
 =?utf-8?B?ZWhoVTVLQ0dHbmxYMVFRSHZGYk9BZzFZZXZ0ejBPeEtxOGNzbXg5OGxaSDNh?=
 =?utf-8?B?N0k5YVNXdk5HV3FqVy9HQnhNalpRMmtKck9iOFZwK0VidEY4NndUcVFRUlIx?=
 =?utf-8?B?c3JQRE5yUlNST2xTTC9JZ2FQUFNzWU9JSmVoUHFQeCtOOE5lUHpqQ1I2RHpk?=
 =?utf-8?B?b1AzSHRYbDhaM0hKajQ3aC9TOWo3Q0VSZGlwRzhyNFdwaEsyZ0E5SVFpU2Fl?=
 =?utf-8?B?a083dFptUWRyWkhxdTZBSzJCRnhtRTAzTE5GNk53VTBMNitXdjQ5OEwxZHNI?=
 =?utf-8?B?dkV6cEQxZW13cHhRMVlaeUN3dlVZYzR2N3NPUmE4dERUL0Fnd0c0a1JHVzY1?=
 =?utf-8?B?eVRPb3M3NFNJaVhqUUZjT0ZHYVlCREkxcFppdnEzV3VJRmFLN2JCV1VLVDNF?=
 =?utf-8?B?VnY0TFRVZGFRREVyK3pVZXlRdkV6bmcxN1hQVTlWbEVtVmRnMHZXVk93Um14?=
 =?utf-8?B?NE1yWllUdWp1dGY5cWtJQUl6b0VIUXpRcmxrc3A3VGR0QmY1cDJVdit6M2Nq?=
 =?utf-8?B?NTgrY3FFMDFiNjFTa3FPMkVHMTFoNW00cFBBQ1Q2ZFA4dHhEWlMvTDZKNUNp?=
 =?utf-8?B?d05IT0l4YXBHWUQxSGxWYUFwb3o2bXBTV3J3a0ZFY0x0ZVpaWUU4VEw5cDUw?=
 =?utf-8?B?V3dPTGFjTlpiekRzRDR1a2I0bVhGbWIxWU8yYjdKRStMcHI0MS83UnU5Wnd0?=
 =?utf-8?B?WjdPTU9NdFE5YW1JWnJzcFh2Y1BJTGYvRHZUUkpNTUJLWjFrTW1CeEZBejNu?=
 =?utf-8?B?T0xseHpCYWhFaGVPKzBkM0VIV0R5SmlvOWE4dERIVkFheFU5T1cvUnJtWFNs?=
 =?utf-8?B?QWs3OGlEOEFGWmltN3RyU2FYMWRUUFd2SGh4U05SUUxYdjJUQnB2SlJNZCtL?=
 =?utf-8?B?b0tNc0xIT0ZLNXAwMGlxREJhcE1zUi9CNE5CcDhaVldiV1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtaQ1IvMk5tSnhKWTZQdEZDQ2R3eUZ3NTR3bHhUNGZ3cG5kUGRDVUVNWGd1?=
 =?utf-8?B?WURMY3plS3orNTlhMU54WWxnaGl4ZDVHRFlkTFNPdFIzTEhFZWVVNVlHS0RL?=
 =?utf-8?B?R1NZblJhZGNGbnFyWTU1Z1BlcTB1dmViM042YVliV1FLK3N2NnlmTVVhYWFN?=
 =?utf-8?B?SDNQeW4yNlpLcHE4YVR2bFFESGI3SDZDS0VIRW5CcXh0bzNqWEJNOXJmcFds?=
 =?utf-8?B?Uk0vSVo1Vm5HcmlvMTBvTzdVdCtoTmwrS25DakFFdWVTNkRDTmpzMS96RzdC?=
 =?utf-8?B?UTdIQkpENzVNSFg4S2tXa2s2enBDcWxCZDRuQitQbXJneThHUFR2TFBRaXlX?=
 =?utf-8?B?aDdZL2lLdDRNaUVENklra1ZvL2VPYjl6Vkk5UnU3ZkJISkhmQmxONDd4V3lY?=
 =?utf-8?B?UmJKaEFrQ2owcHVxZWhEbkkxR1hEQU5VNUNHV1M4ZkZXaXJXQ0VBZUxoWmt0?=
 =?utf-8?B?ZGsrWUVkcDZpaVhoT012cXFOVG9zL2VTdzRXZkVJZ1JMVlhTVVdVRGdNUnlp?=
 =?utf-8?B?ejQ5VkdYMlpsTUhzWGkwN2xMZXhkZG9pTjNxYjVCZ24xTCt6RlFMWDExdFQz?=
 =?utf-8?B?bXU5ZytpMDAwOTZWT1R3NjR0WmUzdkRNNllib0JlNjh5ZkhpczU5cVduYkU1?=
 =?utf-8?B?RU1ZRmljSWFreGN1SFNld1NBTGhrZElJdUJyQm9SbVBnaWprRzhrdHdIdG1M?=
 =?utf-8?B?VzBVa2NuTG5HdktKMGZuSXJvcElqQXpVNWg5MjBYWVJjNkdiTURGTmNxdE9q?=
 =?utf-8?B?U05vVmVnQjJtSEZnQjhXeDcxbzByNGJaK3IwOHBtQlhMOENBUCs2QWc3bnds?=
 =?utf-8?B?WVdvY0ZBZ3VQV2lxWWxPY1BQSjNjYjJaVzZ0anFPNG9EWlFTbEFLTVZoei9h?=
 =?utf-8?B?UDB1M0lNYytHZzF6SjR6YnNZNVFtNlBTREtEZERiMnlVWk93b1l0OHk3REZH?=
 =?utf-8?B?RVBUMXFlbVNUdWlWNUwyOWVZRlFuWjJxZTkvbVhQMEFpcEdBRjV1NkNPa2s1?=
 =?utf-8?B?SWF1L2xxempJRVVOVUdyb2VPTmlOOXJSN2xPV0V6TjVjZ0QzQytHSjlpY1lv?=
 =?utf-8?B?RGZSYnE5M0YrYTlQU2JWdTZFZHNYd3VtK1hNQ1BtWG5IcVRreGxWSDJKeXZS?=
 =?utf-8?B?cDYwVXhCRnV5THdHcDZqa1V1MmV6UHpTMFRuWGhWS0ptOGo3cS9WN3FlWUxj?=
 =?utf-8?B?VkRTbWdoTThMV2s4aHgwVmpDUG45ZWhkNVFTTll2aDlZdnpYWUVsSUE3UTJE?=
 =?utf-8?B?SXZicmMvSmZ5TXM4SzJ5OW5hSnA5ampqSm5MRlUrSlhIditnUmE0UWhHbHUr?=
 =?utf-8?B?OERkUUFvdzRNYUduY2JnVTlUWnJjUWNxdkxKSFdNaVduRnhaMnFpUjc2aC9M?=
 =?utf-8?B?b0V5elExZEVGazE1bEZrV0ZUeVo0Nmx3SHo4SjY4T1kwa0NldTNtWGQ1Qys2?=
 =?utf-8?B?VDBWV0pFMCtudm1LMEpITnVzU0EydWdVaE9NQlVMUGxxbmQ0Z1dVNG5YQVMr?=
 =?utf-8?B?ODJDUFpob0xBTXVzVVM5SWlaU29QaGU2K3M5dmNqNFd2cXlBZjhyMy9FZkl1?=
 =?utf-8?B?U1dCVVVqTmRMSmhaWit1dHNReVRna0VYQmZlRlVZZ2JlZ1BZSS9CS2FBcnk4?=
 =?utf-8?B?dDBhSGliSTduYWR4RXp3UFVPcmRwdGRXTTlwK0VhQmo5emxjblRoSEFDRUZS?=
 =?utf-8?B?Ky83K3ZiTlNWSGQwOFlBWXpXNTlERTRCaDBaYVFxYytPRDhCNW1DRC94N1VO?=
 =?utf-8?B?WEsxL3hFSGJKTkRNT2cwU1BpWnpGdG9zVmNxYTV6VHB3Z0ZxekF2RWl0NVNG?=
 =?utf-8?B?YjBnOXorYmNmN1Zhc0FOY1krOUk4RFl0YUY2ckFaZFRKeDQzY2wwUHhXYWVT?=
 =?utf-8?B?QVVvS3NkVjJFTzB3a3oxZVVQeTFZZ3h2QXVoZHpEbk8vL1RGVG51a1pSR2sz?=
 =?utf-8?B?bitnT0NRcUdVVlNoYjNMaG1hc3BUMFRsbmVyUDF3TVBzZzdEbkZZUkpaTlNV?=
 =?utf-8?B?QnZvWWZYQjZJNm81bytpTGx3cVRoSUFBRjEyODkyNVF4ZHdYd0J2bExuNjZM?=
 =?utf-8?B?OEFFbWhpRFUxbklLSVlJZlBaTnFmYnNJNGViNjZNNTdUOG1hUVlWcjVpWjdn?=
 =?utf-8?B?eDZLaXBRTUhCZXFOTitxV2RVSjF1aFdPa2R5U2w3S054aHNCcXkzbEk0QWdJ?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QMVT4Pk/2KBRiPhA2Wbdqm3343wJdvp5BwyFtWkEt0hSUrfAWjkmiKynZ0X71pQcTZpvi0OaLYdEf36kb99vhhvBuSyR6Q924YOsAKyruHlKI54YwDaF1TLJGkwFpmDwsRuamURjBZ2egjiQz/DRjyxgUKERXjJCdUv4vHij07X6h7Byb4BKLUxmRKa7hfUg43Y+QM2Qprzo2RVMvINngVFVzHuSYQXcy9xJMB1mwEFaazbzNsUUjbcBW2ZspZBmTNVDpeyDX2BmgFlR2MIpU0MxgcN1C1V2qED/SkT2q4ehvBxISolVjcGQQqG99wjBdN9blJA/wuXZ5mxjHf9P/yUCyFRQVCtvRkONH6losvYfy5C45J+wPRdi5VmbsbIJBrlKVSVaUu5Rq1THx5rdAAlUl9xSemz6kPVgD1vDmSkdcatD+kHumP3/m4MB1wmIMmhJfPIMZo4KxJu6SE1JJL3KU0dw/kzyN/eAsDRk1r8apz9BAGSbg+lBoVsDoxvgnmYufnXXtoq2nR3v01nxRasmyCWAOUGXD8IBn14u9l11KoqvuhTLLszkV3wfUzo1eGLVgRb5Vb/QvNYiTO/gERjlyIOQWMifkCjF/grjU2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f74749-e19c-41b9-ba5a-08ddad67ed36
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 06:26:43.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29VfaaIxtVfC5Bhn7CjKswGtZHnxpE0gWOTDJDjEXGRNczYnTZ7fm0nABqNqi+xzkGfa950NiamlrXVRMG7OFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170051
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1MSBTYWx0ZWRfX9Nf2UZvUS8w/ AvXJQYC6+rvqc4fZUIGyHfj4xZ7pB0rElE5O3Pm3DHaB0/AMHA6XS+QgDDRx4YJMxXwBNWNYtKZ WWp856cGr5EARERouu+Pjr7cec0G9cM15ZQR2fQxZx8IfxLxeHYbbpSA6JM3Tcc8T0DQkLEvo6V
 EhjN38IoFw6Mvict0tkCubY748fAzXTbv9ws6/wBopbL2LEfISI15OoqEVtG1AZ0BY57GChjmNL PBg0gRhCcfV8yAm/QPA1NWFQ7VzoQjzbRGzxXIdzZUCoCLX3jAzZzrgPpSSf1fnif/GkDSOZgQ5 763peUnpGxJ4/Z3qYUk/DkeCXIgWpt8zRONTJ262HM5W/qGPOjj4q3Xc8VFS+RPV9buOLyTt6/V
 vQueMk2PKnJB7mA30m/zaBgBe73mCQQlD/UGcJmf7PsKKDhmXi/zi1nV/p/OIy8tANx+zJSk
X-Proofpoint-GUID: Q9dp0EXmYSfap66xXFPPPrh5nqW17UgB
X-Proofpoint-ORIG-GUID: Q9dp0EXmYSfap66xXFPPPrh5nqW17UgB
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=68510aa7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=BM0EpCZ_gVQ-_g6xMOgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_232659_029392_62166546 
X-CRM114-Status: GOOD (  18.10  )
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

On 16/06/2025 19:19, Alok Tiwari wrote:
> Fix an error in nvme_log_err_passthru() where cdw14 was incorrectly
> printed twice instead of cdw15. This fix ensures accurate logging of
> the full passthrough command payload.
> 
> Fixes: 9f079dda1433 ("nvme: allow passthru cmd error logging")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> Is it ok to keep Fixes tag for this fix?
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 92697f98c601..f3e07cb92385 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -386,7 +386,7 @@ static void nvme_log_err_passthru(struct request *req)
>   		nr->cmd->common.cdw12,
>   		nr->cmd->common.cdw13,
>   		nr->cmd->common.cdw14,
> -		nr->cmd->common.cdw14);
> +		nr->cmd->common.cdw15);

Apart from the fix, any reason not to use le32_to_cpu() when getting 
these values? AFAICS, they are __le32 type

>   }
>   
>   enum nvme_disposition {


