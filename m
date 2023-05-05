Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AFEC77B75
	for <linux-nvme@archiver.kernel.org>; Fri,  5 May 2023 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PJD5YenvktRx4CMXACWI7vhPdRZqaiwuxcEw/AEHb98=; b=VCCVEx0B9p8BoF/9I9clEOO6Z/
	7sD/p42mOavBRe19A7uAUGZdVyMokwB0p3gQQjhoiRgnpzaJGshf5D4Dpii1egm/NPQbFVDrWJ76O
	NlTdbhCIihP3FeqxcQZMMmyeg66x7VTVjT4VCqH8kMIAKdkji3LSl3NL1GJDN+fHklD41ibEcuaiR
	SqS4jvMm9P5hCfcpMwAKRNJiqm0sEv23LyFvnRiX+uibvmoqavJFGqBvN2so15iaBZHDEabd46/yS
	t9zo3lXw3I+1qHl8lWbmrlvfgJTj1B7EybG64tJVnu5DZ3v+EGmQTMC4EGJeNY7Ge5Co10kh7/2nV
	3JrtNHDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv3Ss-00Bvgs-1e;
	Fri, 05 May 2023 21:59:46 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv3Sq-00Bvg1-03
	for linux-nvme@lists.infradead.org;
	Fri, 05 May 2023 21:59:45 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhWw4006422;
	Fri, 5 May 2023 21:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PJD5YenvktRx4CMXACWI7vhPdRZqaiwuxcEw/AEHb98=;
 b=XVYEURG+vyR8BFThiUMDAwpFoar1Oy6HV97BvOIlRcF2sjg2pjbvDH00AVyfDrZ80yJm
 AzdwUDO22gnhbXiksQWiwzmUyh9Rp4/1YU3OXLEo6T4XgC0dJBXWHt5Wsdn6GQUjK+3r
 5sI0Tspim1xkMNDGEsCsISVWlu+6qcuJCTn9pAkF195gm0utOQoyBkIstdUqHrZsfn+J
 xdYEqWAo3KlovZQ75nSEj6Tv8Q7/11MlltQZV10bk/gW8g1YtSrBnqAsKoTV4fbCFFSI
 B1wIofUsaKWV7u2XOKqm+ww3dji5pMSO2l72KJvJy77LDf9awidp9hze5nMvH0nJ170k LQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4awp41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 May 2023 21:59:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345LY01k020732;
	Fri, 5 May 2023 21:59:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spad015-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 May 2023 21:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtxZY4IM9VQrB7lYavbgsatBqnd6rdVy8sTEneCUEqnYUg9rUkURRxjr3WB2F1pq7HDJrhu8LXxNKKppQZzC5ZGKKygl4HoStsmEpiaRTupQq+jpBacPvrDb6Fd8t4HCyOojGXQ5IsArBJZf+P77fFTHTm9Mu1F1rB8Bl4KcXJrNyyOxu7G7/FVctRXuJiL1En0w5EzO++rc8PYtpQr5m4JYMxgL6Dsjl1gDftWq9GV+7KIqKYNnQvdmpORx2HjGVJKUdfXrk+LY3fKoaNg3/HbW4Qdxsd2VWENWUAlmCSCa5eNDJTlgdjrIXr92BNGfAoY418trdnQZ3vwKAhVa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJD5YenvktRx4CMXACWI7vhPdRZqaiwuxcEw/AEHb98=;
 b=na6qCjz6iAMJ05IVTLbXhLR4GaeqY2Cl6CJVodzeYO+x4P364Je4MN/Im+pA1ZxjGXOySlipC4mwh1GkxsJ33GXHk95C9ms3WwBT0YzFmNlrDeYpg9ggXJWqm30lh90uBUZr5vPOOABzN4+ShOMXB7Fq0LVAVzYncujBByY8Bxr8Bu85t5o8g42eZQugKdAWZjVZvMdjksnVgzQ7oNRqJ4l/0Cz4T8dl3XpWEukWuwqLU4QD2VKEy3tu1W8B1/dv0fHBXPU4xeEeOofvF/vCV0WU7f5J2ezK6kjt3nCBXfasRBOswtNxyZdoPWH+u9ahVlGca5wa4PdVNgt5KXKhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJD5YenvktRx4CMXACWI7vhPdRZqaiwuxcEw/AEHb98=;
 b=L5yXse5SqJdzbVRBPuTrxBdNceolaqU6YVwaKgxq0BQ7SXs5vjoFH0aYWzAW8KHbOFfrKxXP7yZzOX0J/JokryN//RVx9NAeyHUKFV4G+E6nU7TYr47X2efTAEkgt0xjWxPo1RD37ZQ99czYPcJNa4I3sC8Oq/T6S1orHIWCeAk=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SJ0PR10MB4463.namprd10.prod.outlook.com (2603:10b6:a03:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 21:59:37 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 21:59:37 +0000
Message-ID: <c9ed84c9-58fd-37d1-138c-869726ccc7d6@oracle.com>
Date: Fri, 5 May 2023 14:59:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Content-Language: en-US
From: alan.adamson@oracle.com
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20230409212538.18647-1-kch@nvidia.com>
 <0c50fbf6-4bc3-7289-2a39-072191c81dbe@oracle.com>
 <8a811508-f53c-bae5-fe32-da65101bdec2@nvidia.com>
 <551a5499-c4eb-0416-0d2f-9951817346ce@oracle.com>
In-Reply-To: <551a5499-c4eb-0416-0d2f-9951817346ce@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::25) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SJ0PR10MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc612a0-eaa3-4cd9-62b6-08db4db404b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Xnvgar4oDg7wwtbtOuo0SuPgX+DNZnx45TFXLeLcHCUoMIxfS9tE5NYF/I8ZfMJNwh5uNI0BjKuLkpcOpetmQ7PNGBPYh3ILAdvofTbQr9PLzFVJrT4NVP4QIWby8a26ECAWpmVCzUaMZ3h7MtLjGTkfEAtr2CiCQlDVVafWaKGA1Rtxs4bHk+xTxweiqj44NcC4oXk/tGtF2dOdwrcuraDcQI/t6HjhJwGPXV1y00vj98QBfMkjWI6opNhPMqwDNN/PHAdXiXpZ+t9p0f8lezix6z+eeBHUy8moO5moozR6tv3WTS3qxVuZTs2CpJ+t0nHWGtf97qYk0zY4gHL0UIGfKFCZCqO33QydSP99Rqkswx4KnHIRzx6MZjSoaI3/NtZNRbd50ZOr+NwdshcKBQ1oVE06NE1UWLIAGYlIljc11yFCNBUBNB1MkQOf+U/clqWx5peR5DnzkbcIHgJNn0MzovJURcrDFNwTyAfoXAIXTxyI/hb3hXe1eXzqH0xiqjf4dWyNWFt0DPnvAfBfH7fTWRvh/KlNdY3MOijf7rFEmbA7i9VO0RlYU9mzWtMCkhVTK0c5pyr60tDDL3lMFfrih6LyGKDgBCi6gCc7g4o=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(31686004)(66946007)(66556008)(66476007)(4326008)(478600001)(6486002)(6916009)(316002)(36756003)(86362001)(31696002)(6512007)(6506007)(2616005)(26005)(9686003)(8936002)(8676002)(5660300002)(4744005)(2906002)(41300700001)(186003)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?dE1OZnlDZEJrZG4rOXJ5VUZOOFpNY0c2UzA1RmFTOThuc3ZQSDlxMFltN25y?=
 =?utf-8?B?bUZTZHNxelR4aG80eGJOU0p0U2dKa2RqYTBvb0dCTEpOeTFCVFBoNFNYbjYv?=
 =?utf-8?B?UjlLUWpZZ2hXWWxEYVNOUmFiNDNSendWVkNybGVtQnVPbXRvSUZGczJaeWp6?=
 =?utf-8?B?d3NJNTNJcEo2Tm03dkNpQkR1WHpuSC9IL0Z6WWdIVGphV0VvR3RIZHJEVmJV?=
 =?utf-8?B?SjZrN2NzOGQzWldmL2wyQTRnR1V0cFVlVW1LeU9qY1pNVGwzS3FGTHliYkhV?=
 =?utf-8?B?U3RoK1BzQkpyYVNsQzhueWNkdWlVRVp4N2dwVUdRakxJTGp3VE1IWnNnZ2pv?=
 =?utf-8?B?L2VYbFcweTM2KzhDZU53Uzk3N0VXZ1VJQldGbllNSEZVTkJOaXF3NzBFeDJt?=
 =?utf-8?B?bTk0SWQ0a2t2WUhEWnZhY25FUmY4S3U2djgxSnNpODBLUzRiTHRETndpUWJT?=
 =?utf-8?B?OVRLRnpmRTFzdUhyL2tpUFF0aEN5VXFEUjI2bnlBMkRkamdORllxQStRUmth?=
 =?utf-8?B?dnJFWWJPODNJR0J0VnIwTkNkUXRLcVI1MGpnYkN2bHk4ci9YQXY3bFR4SFpC?=
 =?utf-8?B?ZmZWZ1VTMFNld0gyS0dnbHA3Y1cwMkxBWDFVRzdla0pEb1lEbHpsL3V3NXpN?=
 =?utf-8?B?RzVtdkFhdzhaZ3pvcTFHNzhGL0ZML25CMXlNQlBabldIb0h5L1lSUGx3OXha?=
 =?utf-8?B?WWdUSEtQa25uekhPa25EaEtyMnZ4bkdrNzNjY2xtK2taaElHTkdXZm1SUisx?=
 =?utf-8?B?eFMwVjFGVUhqc2FFQWVGeWVmMFhKZ1lMc3lucm9TQXJVQU9CcWtaSHZYQnBk?=
 =?utf-8?B?NnZ5SVRvWVEyYWk2RlVpTDFPcmltTWM4dlVxYm5BNDBzMzlZQWJFZ0o1ZWZN?=
 =?utf-8?B?cktsaUZ1K1MvdTFhQXovQWFiOXdJaXBWMzk2Q1lENG5QUjVSK1d0elRRNHo3?=
 =?utf-8?B?RkR2c3JXL1dSTllpZVd5b3hMb3U2Tys2TzNHQlJaVU1Tazh0SjNMMjI3cGIv?=
 =?utf-8?B?QjA3aExENE5MQzNERWpwMndsNlhZdVRiK004VXRMODhXTDFTZGJnWHZ1b3M1?=
 =?utf-8?B?QzBoUGRja2pMU1JEemVEVHJDNWVMVVFVcmY5aERZN1BEaSswYSttZ1dKdHRa?=
 =?utf-8?B?N0V3K1FVSUJ1YTFsSE53K3A5OVJHMktRQUxySWhudTlUUWl4RC85ZHNhYUhu?=
 =?utf-8?B?L3M3UHpEMnpxaGRENkNjT3JpSGFreVphMkNob2lOWlA4c0FzRzlvREdJbGZV?=
 =?utf-8?B?S25UL21kVkVSVXBqbDhsU0ovQXZEbitOejZrTkNha0hWWFBZNmNLNUs4b0xt?=
 =?utf-8?B?Z3RQRkd4dHcxT1pNdS90RlhEdjhkNW9oR3VxcDVIZUFCSFZRM2JVUU1HRy9J?=
 =?utf-8?B?YTJNdlYzTUNYNnQzWG1rWWpkR1d1V1JGWm1ZamJWMmR6a21zYkFvYUYzQ24v?=
 =?utf-8?B?UnBrMFlaT21MWUw2QXh5cU5XNnl3cjNmWDFiMGUyTXFGVUh1NzQ3Q3RtM0dD?=
 =?utf-8?B?eFhVaGRXR3dXTDBBY3VET1E3RVFza3Z0amFWaG5Ub1RRQ2F5ZVBISExzSkE1?=
 =?utf-8?B?dVplMzh2dVdxOEMxcW1ZRlNJeDFoRnNRUXFsYk9sQS9aWXhQamMrTVZaUno5?=
 =?utf-8?B?U1plR0U3VWtEMnJzNGJjTFd6WmRubFBDaW4rVVJhUjBMMko3RDc4YkhESmVm?=
 =?utf-8?B?QlNqWnhwNWNnWURjUnJTR3d6ZHZoWnZGU3p4OWI3NkNTc0NnWWNremRXNlpa?=
 =?utf-8?B?VTAzZ1dybW9ySmxWejZ6WkxMYkxnK2J0UWlaNkJDZk1TVks5VXRZaHNIY0tR?=
 =?utf-8?B?dm5mcGpxUGVxOW05cjF6Q0ZHSHFVN1ZaQnlGd2NwWWZBMzdTUlhZOEEwc1ln?=
 =?utf-8?B?bStLSFRvN21qMjRxN0ZvMWN2VjBRZ1RueVVkamhQUjQ1bjZsUGliM1F4ZGp1?=
 =?utf-8?B?Nkp5c0ovZ1NXSEltbFFrVnQydzIvNEZoUFBzUm9RQ3ZFQm5iRmFSRjNCZCtj?=
 =?utf-8?B?c3Z1WmJRdkFVMWpNZzNWeXlMcXlleFBlZHN3OTgxWXUyTDJvRnMxb0dXVm5u?=
 =?utf-8?B?WWJSOFNaWW96VDdFR0lKaVVDOTVFYVg0Rm9aWGRwUGNIWmVCSDk1S3lySlR2?=
 =?utf-8?Q?tzVgx4u7F+0tGTEIiof56Dq9l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	GNTpinFqoOpkmpEK5CQjaurouWfZ7cl9GszhGvd1xbK8ClQINHAihvWBzwq4krGZG/8O9rRHUtSLXkOtHmcyJzeyBgtopYi3ZDzaciQ4vImtVSXxlGWrzvLFnm6Ch/dr4avlIcKZeTsUTq6nWocRBRMA+fxhrh0s5SYnSHb3438/GxWnhv3LwWdCr/CB1qsLszdw0fTtq7I5bGAXCfdXcksXOCqtXTOcjSZKkgn+BZ+aYRuNevy0tcsNPvP7iL62/5Oo2Q4iVqR5oATnlRii6jGdGth0XJCrUrdcyc9pKdn3RlGzPML96M/lhTBmKqhUPiOA2uHzDfTdZrTsEQH0oUA+6YAgDj0/qnKJcGUznS1ED7lwKeshHnC6WJblFDyZvg8HrE6CwVI5B7sR3FCvFhX2HcQf5CYOjy5B+AGAiQnA2GL7K5mpwU5Jk+OrVi236A01cj2ZoiNt2VW2/exoEJcPXXzdWk75aOUAcm02m+jbSryVxgoztQ3afXzFy7vqlt0F50y8ujtG6Xu/e1BzsFW4FiM+GcG5gSODZdtRQIPf3UnlFFEpr+6KH9+hT0roLXv8ixB1dONBEekcZKuU9NmFSO9GcJqinp79ZLCiH6TDpO9c4SGHJz/LqkNqjB6qLKvZLoTxruT+qPxou+/jMq2kYGToHimmXJ4+kLcr8u4pgshgKhpBxkI64uiuiPeoHRDmX5RP5S8b4OeAwK7MOEb71/9++vhV6CtTaKFYadss86AIzoWhaeS/eXDjp0LXtq8/z9RoDuPac33EKQPlgd8/G7ntb0bQ6h5pjWUQDK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc612a0-eaa3-4cd9-62b6-08db4db404b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:59:37.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzgdR+B22/7JULBXiL2T/qtoCoBeUKGuiF/n2cvNFu6CJi3DNumHY4/9qW15X3N8wkUPBV0h9o4QyRMpESmE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=864 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050178
X-Proofpoint-GUID: WPxFyOWgLM_BRmK62nD8Vj5wD-cQ-GQP
X-Proofpoint-ORIG-GUID: WPxFyOWgLM_BRmK62nD8Vj5wD-cQ-GQP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_145944_079810_651425A8 
X-CRM114-Status: GOOD (  16.18  )
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


>>>> In nvme_end_req()_ we only log errors which are for non-passthru
>>>> commands. Add a helper function nvme_log_err_passthru() which 
>>>> allows us
>>>> to log error for passthru commands by decoding cdw10-cdw15 values of
>>>> nvme command.
>>> CK,
>>>
>>> Thanks for doing this. Looks good.  I've tested it in my environment.
>>>
>>> Alan
>>>
>>>
>> Thanks for having a look, let's wait for others to have comments.
>>
>> -ck
>
> I'll be on vacation next week so we will move forward with the patch 
> when I get back on 4/24.

I'm back from vacation.  We can continue with the review.


Thanks,

Alan


