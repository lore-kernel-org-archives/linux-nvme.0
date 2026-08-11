Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87296C5CFC1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bgpDKo+V+j/jPuEBl8Ec2THEZd5cp+HLk9Zwiy0tK2s=; b=UdxG9PyxziAClc0a5yUNM/uyXq
	9x9dqSwN86IHnw4KtJBziSgzKqfT7oUTs0DDTi8Z5nR6oCRiS9f84Typh1VkAWPx+ZGFvGG8asCbq
	beUZcxF4s1M5Q6EKkW36v3HBW8NLbpiSGSOsVGySK/sCp1hIe7PtbUZakFOeA0K6QVl2khTj6SVTi
	BVkAqgOlJlKZrMm2JLUqIe38z92CziffuUEDszmybjocTjJ9VQDoQmBpKpTnSX5y7aI2TJdhuPeTn
	eal80yw4XX9f9Ecb++3OTQSvetfA37pVP0RNMgaZAy+DN/15gCYvd7JPRb122JDB9GaRFlMLW8Bfh
	DNgAlE3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtiw6-0000000DlRo-1nKT;
	Tue, 11 Aug 2026 09:38:18 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtiw1-0000000DlQe-3aoT
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 09:38:16 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B9MdXm3174185;
	Tue, 11 Aug 2026 09:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bgpDKo+V+j/jPuEBl8Ec2THEZd5cp+HLk9Zwiy0tK2s=; b=
	nMHhfia3ZqS/kWGrdThnFdIxYVexztmCzP+J4o1H+VMQt+muNXMzXtEQB+ozgja1
	duXUkQ88jA2A5JsMmJNC9Dt0ZKnIK/yBjT+1tKrBxluVTZKXTVo6EeKOMgiojlgJ
	CTNxQre2wnjsruKEmxO/+S5tpKY00BcNENhNgjmjOfzW/wNammqnDGmR6URmlpq4
	2eEQS0FKDEdMbi3pVVrN+A1CK/MJi6ne29Hd7bvWkJS7afXbk4HhPD/QEWJSdpTT
	XijqcUmQ0F9jqoqUYTh9GXDJzWWqIi1wohbJIAtxYo4xN7U6+klrOeIFAEVaOiw8
	kCmqqZEmbOjQ5pf1rAOQOw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvhdvmc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 09:37:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67B9Z81I017073;
	Tue, 11 Aug 2026 09:37:49 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwdk0ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Aug 2026 09:37:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFya9nCauDdFV/tKipu4qxgWKq1038rh1Oz6iIrsvMdAhKkPMvMe2MUmAgC+WmtLiWL83BZETo39sPPZZQsTedeQcQZnwBlnVHdNP6OfhVzfEUMFFkx+fOt2+F+pbjAu8baB1aOO1R8AI7LX2edIGEESqVfTBsy7P3wi0udqKx8gTRCKFg2RPj8N2ScKCDz4Wk6mD1x9fy63ihYo5tqEtIqveOu4Ig2Lax9XRRR/7w3HZu84ZRcUuW/Z4ENgaSMpwkWd8aTBvq1hhXotBA9+0r/zs0PFYZckUWTzRTYlOIkCsw2QngBCNktn247g28YpF+hWXwFN8c3y8iT82tJCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgpDKo+V+j/jPuEBl8Ec2THEZd5cp+HLk9Zwiy0tK2s=;
 b=noUbnNLPu7RxL8iixBxf2K2Mro0NjflbktE7HSqHsI3T80jFtH1pXH+KNT3MNvs8YlzawKDnjixnETnDaHmmzE4lZSAu2XXCQrw0ArsvctDtg/E/dmqZuf5brq6U4LYXxD5uLkXd9P7O3tSzRkKOVU45PZvk5FSNLwxzoJCyI+VJa8iT6IdvXyoL13i5X/rxNau5uGJ502KfmESRUAluDe9zJjraoMZqqiKEOjM1hLvpCKn1NHJCahKjY/LtgUzMFw4abFO9G/fs/OVbPQLn2i5+qOeKRUBsUcx7ANPDOZ4jjUy/kFczA0oBq0X678rh+tiZ2lAmi9NxTuCGSpFv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgpDKo+V+j/jPuEBl8Ec2THEZd5cp+HLk9Zwiy0tK2s=;
 b=emBROCLiJO7LnRitMtulKsXOHaVNBJRicE+sjtmJKLQkw0e7BVh+ozStNUt7yz8KusZy4tctaE8X8k2wXlBDW8npagWSdWzcjCJTGbxlZZiQs9RjkiTcfj4O+AGQReiwYZQgvfOIIPUj/+DxRTGe8zJcjTmqdyWW4PeMfnzMdRk=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 09:37:44 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 09:37:44 +0000
Message-ID: <52332d80-95b2-4aae-8dd7-313b6e76f5fc@oracle.com>
Date: Tue, 11 Aug 2026 10:37:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] nvme-multipath: introduce latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <35c99788-ad97-420d-b16d-5ba8f6a28f82@oracle.com>
 <e229a15e-26d1-44e6-8cb6-fa59255d609e@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e229a15e-26d1-44e6-8cb6-fa59255d609e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SJ0PR10MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbea6f8-d400-464c-2458-08def78c321a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: h74tnJj8NQBFs+0LV09BsL42s+wB1gtxHo1y07W8V8sGgQRgrwBfvC9t7lwmHRplId7/K71V9dMqNK+w5Ujbe//pyisRu63AkzjqZvewi8pEpMDsyn9s73Ke1KQBFDDROVrEtOyvghLAk59nfDf9qX/Ga2NwMAf6BKsUJ9IzrkGTG6lI2r4Te/Z0D6VgXKYII4rX14Irds+FIBEqeEjuGk4eyiSPKweQVzbAhjiJ2jBxQ+5nsMH/r/EwIIxM4D48ZLcGtfn1qAYNHWsacuXLoVIQLyLrnbEBwD+VFMRVUe8xeAZ2PhLDuc88gwkwLCrfR6bhESIVgCEaR9cR0nXdl7SsIBGnj+RLdxmucEZ8RjNuO1N1yDGnfXUhaJCSWR5gcsHcjo7fCV1uUuwN89yxrxj6VCJtAW1TVPxE1mhZVuBFuk8s3lkOsG6InhBW4y+UtnMm5LSfDoj3pqELm6XUPRQuL/Ba9mEIp1PuK9z7bEZce0+w0+CkdJR1RTdSBcjxohFeNpNFR+tBKgj1D4jHuNv0ifhNm5uYgYAN4IgRlG4Nt41GzEKFyXvq4+qMA2LN53T9D6saa/440aPlzX6Q/RddN3cmKMphjNVOjj3KBvBNYiF2gHXkzdw1Vbq/fHAQihgr29/IyOmWFVbDzmcEAfwhBs1ABwwVuStTccItuwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blUvdFNsU01UdXNYTjFQQndRTlg2RkZrNjBvVkxTZWU3NUdGZ3J2dUF5YjE3?=
 =?utf-8?B?dXU5TFgzZGsrbGVwZUpFdkRrWGlUeExCSXR0VTJYYkxFMWZ3VUpFRStYcHFB?=
 =?utf-8?B?eXBxZS8rOTZtUXZQOHdzUmhpN3dNVGRWN0pjc3pZdGFyZUQ5Rm9wczgrM3JI?=
 =?utf-8?B?MjAxUFM2MnoybCtWSjFoU3k4SUZ0ckpFcHhTYkpnVEdIY3BYMTFPbW13VHVK?=
 =?utf-8?B?TVBmQSsxUWROSjJtZGxPbXd6V0l2dXJKa25jOVgvaG1admRCZlFhbEpNRFFl?=
 =?utf-8?B?bzh3SHdpR01pakp2Q3JySllUaGlKbUFhWjkwM1ArNEorSTJQRHBrZ3N1NXY0?=
 =?utf-8?B?ZEUxYXYrV3U0UHpjUWl2VWlVdHRoNlV5TWI3K3U2amlFRlovcGk1ZlVnZjZM?=
 =?utf-8?B?TXcvd1NwSlV4cDJLczQ3UWU2REpZbUo1Y2wzTDkyckRab1l6cy9jV0o2YXVp?=
 =?utf-8?B?VjhBaEk3d1hzd29ocmlISGMvZDZWeTdZckw4SWpQMTlPaGVGak5Yay8zOTdW?=
 =?utf-8?B?cm1KdVB6TGtrSkplTDg4QWx3SXFNQVhCV01pTVFHRS9xcTMvUmZIRFVVdXY5?=
 =?utf-8?B?TjVjNkU0U2poS3M1Y2s4dTkySDRZVlR3eVNlL3h2VFpxanIzRkFWekZYRE91?=
 =?utf-8?B?OGtOdFJjRWxEeTBzOUVPUFYrY3ErOW02MHh1dXJTR2dmWlEvSzV5T1R2QWQ2?=
 =?utf-8?B?aGlXS2U5ZGZEUDQ0T2tMMEwvbnJwTXp5YjJnWWZVSU1UOUhPYU1sL1d1U2R5?=
 =?utf-8?B?VEFGanhPblNhWHJIbXZNVHNPc204NVdYR0xiNnhVQlNhYWNueUlBQjF4anlV?=
 =?utf-8?B?ME5OMFVtVDgwcUJSV3lEbTB4M3hVaDA4S1pXVS8vVnR4QmNMR25sMTV0Vlla?=
 =?utf-8?B?d2ZMOXNoaG9tL0FxaGtnT0xtYUVKMlY2dVIzb2dpOGxqZTNKYmttYWZJSDNh?=
 =?utf-8?B?MXpENkVwRm1TcWRUcGxYcmQvNmZ1V1JDVzFKSHhNdjYyZnNSaGI2d3F1eDN1?=
 =?utf-8?B?ZmVLZFA2dDcwTUZQWmx4cGJmSG44N2h6dXdtYjhQMERqNGttOGR0MVhRejdV?=
 =?utf-8?B?K0hYZHl1Skl5YWhnTWFib09zOGxUekFVVmQ5N1dxbFlnVVJFRldrelJzQkt5?=
 =?utf-8?B?Rk9HTElFNm5wNm9pMTRSY0NIV1NJRGxLdDkyMDlWclFON0V2VlZSSEEwTWd5?=
 =?utf-8?B?N2doUDVjR3ppTDRjbWdCbTJmZWpOcWhHN0s3ZmxNMXdPb1VWUk12QUtpcnpp?=
 =?utf-8?B?d2Q0a3JDMVVLdGFKTVRCbzJKZ2JCc0JDRlh2S2NqaHQ0U2JQYlhiWE96bXZX?=
 =?utf-8?B?YjV0cVVFMFZQVzVxSk93N2tvYk9JV2huTXVZYk5qNVZleUtRcG5mQUdqcHFm?=
 =?utf-8?B?VFc2akZjb2NycjZrMVVvY3g5YkhoZWEwNWZpNkdJdVNNQmRyOTZoYWZMMW5v?=
 =?utf-8?B?MVphVUJMR1c5UDJyQktXNFJuc0N6NjBIVDdiUVZENWw4aDY3RjI3M01PdCti?=
 =?utf-8?B?M0dvVUpHbkUvSGFUN0crbzBsLzNVWFhDL2hPRTF1eC9OKy9WVm5ZcGtDWGli?=
 =?utf-8?B?akVlcU55aGJrYTQzYm0rcVBVSForaHFKWTQ1MjBVWjRXeWhDWnc1Umc4L2Rs?=
 =?utf-8?B?RVdzT253NEx2Y2lGYzE3RUdlNTVWOHFaU3BTRHpUUk0vS3BPenNRT1g0ZVJl?=
 =?utf-8?B?QzdHdmkvUlFhck1JaGpHYmhtY2RnSkx1OVdjMUhoRXI1T055c2kreXhMYjA3?=
 =?utf-8?B?Z3VVdHhJSDkyU2NQWUJ4U0cxekk5b0x2WVdka09wbnNCYS9GT2NoSkY2eHg2?=
 =?utf-8?B?aWIyTW5sUTJTRXlhekJsU3dhNDJ3U2xKQXJIWE5scGNPUnFwQTFyci85RzEz?=
 =?utf-8?B?eU0xcFo5eksxaFBSWVlIWWRNWFRkQ2tlV2RqenVDK3dzSjhnRTZHM0Nqa1Rv?=
 =?utf-8?B?L2dsbzF1UDJlR1FzNDFVYU1qelZJaHZ1VUdBK2lkQ0N3cmovMXdxa09qanpT?=
 =?utf-8?B?cTFJdWozSTc3NkFNQUI2bEViblNPTmppSFl3aS9OcnlZc3lrMlozRXNEdzBn?=
 =?utf-8?B?cnlWMisrbC9rL2MwSHluZXpwRkpGSUQwNXcrWWhuNWpGbEZwQXdJQUwyV1da?=
 =?utf-8?B?bzJrTU94c2kxRE5JbE50TEV4eVk1eWRXOUtBRlhoUldjY3l4RHlQMEh3cElH?=
 =?utf-8?B?eEI1UWYrekxTY0NzVWNGdE1uWm9oUkJyZ1FoMEJaSmtKeG0rYnRoRXl4MmIv?=
 =?utf-8?B?L0h6R2ZOQzZNak9OQjRaZStiNWxncVh4RDhOaU91eVBMYTRNY3lWV1EydjJs?=
 =?utf-8?B?NzExRUU4NFMyZSs4VTloaXhIeWVTdDlLRWQyUXBnUEpYUmMyNFc2RzMrL1gv?=
 =?utf-8?Q?knnp+qg80O3q3tW8=3D?=
X-Exchange-RoutingPolicyChecked: PrpER5pujOC5ZmLaLZgBlbNBkPgavxTQJk1RphWqkIquncXFmhKWoQxwHLy2JqMf6OlpxcUGiDXklofUlqONwQgDQdccYlfp8gydoNox3CjYojcSWyMqTqbYnOTrhl0kpda/Q2KkboWrC2grFd4WLWn/SZunEaZ+HRpGriz4p39h5lf1W1Hb/EKIqkgkuiPAO+QbYTsklEWj7HSNgbhYAdVkq7UyDK1m/wdJ22f+hOwOIX1dp19iMuGfP6t6wYnhtnIT9rC0NbgbmKV0iw9c4/cGEho78zSOwCpUXkVsSP/lShItYs8wuMktnuLyDh7g5C0yKNPIRxDuHjc8+hL6uQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0xnyV4A+eWZIeSlo4RPu+E+LcFUKnONYyaNFkiwHbCiSkdm+FAW9qUJS5GwnEi7Zqb9AfM1FwyU9UcjfaQcJSLuu8i2oPDAlCRvtEt2qdMwXYCOM1RBUF7tu82FKJr5K3oWJennswqqf9k1rzVxJ8YrCDLdmdF8/srlMMVjJjpMzsmJe4dVJrflNfyaHkCmmnVP/NvTwSgLKryCNjiFxqJ1D1P7u5MDilHO1zkYuU2SWlX1aPWJF93ARFLp9htLCqhpwYKLhv2bnatEdUgYGJ3ZPngKzaJ3UeyWi3gPY6NWLy5SLxkZBH7WyQ+TCCcbyPyKDSX17yyOQGZ0a7SbBFj9L2tpzaUHCXf2ytX78+gX+y1JNUdkNg50ycDro9kNRQ4BKlUYA8lJSGFUgqVO8kg6t290EfUv206QFysy3T0dAD6SqgLWVgASPbAf4rYA9T3jDd1J3XMm11XRRmlcnHX6CkYPZZw5L1r2uGLmcQ8x7fQAIMr0JodVzRQPYBdwjxgjsqXOl4NCr4BmCGUsPN5RS2pTjC5oQx9AimxXl3dBGUylr6vJ5s8XwjMfR6MUb9JiqeXibaMzECevK1E1TW4qFlp6rOaTsO0Bc8tOjnLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbea6f8-d400-464c-2458-08def78c321a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 09:37:44.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac1lcrxcpQ2NVerIt6f/R3P/U6mQsURqtV/0WPZr1e/F4pw1gOjGiuRgQXlOjkv4JM2RCYjZtc76PTMlSLXv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608110079
X-Proofpoint-ORIG-GUID: yCZ9b1DkWdEu6ZkCvCnUlRvNpGmhYz7_
X-Proofpoint-GUID: yCZ9b1DkWdEu6ZkCvCnUlRvNpGmhYz7_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3OSBTYWx0ZWRfX+697RzqM8nWU
 2GLRhV0Tx3nM2bmBVvsubPXbTeeD/Vw4hhwG5EO0o+oanyTOAmL6HnEbQCNhAPe07XEfgM5BE5H
 JJJAfO0aloigVrCAfm3dLQIV94gPRhdoa1PYelkV41fm/qzXBF6DjXqSJuv51XbfzAClMWlTLCe
 CrojkrRrDCoLnS7+f+ZisOlx2JsbfEARGpgpQj8GQBT9OcQEwDPsY90FT0E2aSUPLq/Z7Q9qtlD
 cwMBe3f3ektxabTHG7cZ7slteN64kftGhPtEjIxrlTAKTAcWCxKDb1yNp+/KG2SYpg84vSEVURV
 SsNVHwum+VRnwxEAvtCuDqGbwSAWpzS9xe36AT3w6+j7qL2OJe0Z2l1DJnx4iOoZjtzH/dojh8H
 59z4l5qdOHprhWdMn97jyhVUi7PZ3Ot5yOWcLC/6oY3KBf/MNPiOiQAuyeX6dvMtmas8hWkG/Dg
 3FDs1zB6SVn8uItyiCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3OSBTYWx0ZWRfX3pOipUCo6hrj
 YybNuo9Vr21By0QzLuL/7tFvd513XFtyg/P4PwKR/LJfvtq6119qoAU+Aj7cPURf5mZyC/hlI5t
 iFE/kUTvvQRjvtiblNgOyLGPoM7JMXUVDJKxTq33tQvpMP8hpLtl
X-Authority-Analysis: v=2.4 cv=L/YtheT8 c=1 sm=1 tr=0 ts=6a7aed6e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=NEAV23lmAAAA:8
 a=sqD0ntYo5iO-Rd1evaQA:9 a=QEXdDO2ut3YA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_023814_028827_BFA6BF7C 
X-CRM114-Status: UNSURE (   7.53  )
X-CRM114-Notice: Please train this message.
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

JFYI, on another topic, I did a quick port of this to libmultipath as a PoC:

https://github.com/johnpgarry/linux/commits/scsi-multipath-v7.2-v7-latency-v7/

It's really just a direct symbol-for-symbol change.

