Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F26C77B72
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Apr 2023 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xqpABgeKmUvSSDSeRX114hVz2vjL/cda5LUUZ+4Yyyk=; b=vO31hZYikcmVIWl+lUey4BDIZ8
	oz1h/3HvZFAjCFLhGGIMZeetD8ClPxYaCizvaqyNNMo0qs5wrFB9sNV/EloGeKX+/CIpTxP+75r2W
	mfHlyN5xu/0qgYpTNPJphjXL1sYSNBxIutQqqiHIPhEOdrFTD4ZlXGCgCvQYJdj1M30hLgdgF/dFY
	N7A7/D/4xYnbqg+9YE2YWs9PKAzjk0B5InqH2tmVjDaQhIYDZtV1CvN3h60QhxcM6dDpZy4sn8jNt
	OQJywVS2dY0FehmVcfK+53q1NC9C7fU9zCBXk7Bju7qrfXruP4UdeYAzoYT9vNNIU9gt9Jz35OsKt
	WiFbqTPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnRTo-00Acr1-0P;
	Fri, 14 Apr 2023 22:01:16 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnRTl-00Acqf-3A
	for linux-nvme@lists.infradead.org;
	Fri, 14 Apr 2023 22:01:15 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGv5t9019467;
	Fri, 14 Apr 2023 22:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xqpABgeKmUvSSDSeRX114hVz2vjL/cda5LUUZ+4Yyyk=;
 b=osYDkXJvzy1KmlMwZzDwaFUTFWaUPnXi/PxQXjmazECovlzECW2e45eXA8yAksncKh9/
 Cha5+NakJ8FypV9PYMQnloB3oWEq39KW6hgjv7fo3NQWJolTuhEbxK9c614F3I74Yi4T
 o2loa8m8/ruoHHJOU9J0LaUjMOHKCott9pP385kfhrX8i1TJOdclHcCUvKjbBlcCYZ50
 dU0KpYcSUKLQ9EE+fvA/znYOgopZY7f1b/qumU3MlsRbWsHJYRiaA2LQBEMU6g8tFumM
 SloKjlAEi4KAu8NZOS0Q/doQ0ESQYXvhVwMR9CeDiCt9Vve9Y1a5z632IdvTJP5rFIEG 3Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hcf00w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Apr 2023 22:01:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EKTcvI040335;
	Fri, 14 Apr 2023 22:01:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw8cddce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Apr 2023 22:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC9H1O+yfrfe0mUhog0NDurwvOdfQ4mxOI96K+/wCrAA3bFGyb8UJ7Ai7E/xbaeMhzmPEoWF+RbM4LjV8/0LWBy2LTwjzU7dp0/ttI7RoKF8iy+cPTluQZT90b4Kp2WDfj5lx29BIt+QXTL4eHmDJ2CURB3RCtjgvIOPgMde68PhGV9qIOZh0XKozTot8s/TPWT0TjFJ+8R7nrfbkWvs60+D14L6k3uyQi+9pE7/2XflKnRb6kGD+7/5q6sfKzP28wlQ+AKKLjqPUfY/eZjEJ/7Q5OW/AKj8iKpDDuJr5PInoXBKRnGjJy8fMzsYzoa46G2JqlvqeR+VwfwKh8tVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqpABgeKmUvSSDSeRX114hVz2vjL/cda5LUUZ+4Yyyk=;
 b=Pg5NXJqnMEi2m63MO0oMKSp6fapv9SPWHURdFwgSJMV7XTyl4yA2XAjXXgXrbqk9mtJdzO3M4GMMhmk9V6DbsfLodR01g/JkHdyrcSwPe9k5yfzi3L4/PRBMYA5Sk98/Qa3vrCszMBtOt2XsJ9wor03xU5jQ/fenZ6ZL0rvtUEAKzHXwGpD61QT30DKJNXmcibQ3o3PxzunnBAaCjzuigKQlRPKYWWvpsS/i/g1We2u0IWc3VeKNiNXQs0txFzxU1bEDJg9ktgbA8oxFSD8jTFDleFw1xlwdZ5vb+S4uzueHXN4gpI8pIdlbC1pvw3Apvxn/VH9jPMZQIt+vDAHrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqpABgeKmUvSSDSeRX114hVz2vjL/cda5LUUZ+4Yyyk=;
 b=uJPlMlCBNLooV6/Y6VctuJgU4v+jmgyJrl+G0flx3j5I7a6RnxXesURUVETVwiN7hWCLlGm2a9EdysDdI82Rkn/pG6pMXq8ka+xgn9aMpacYSh9YZ6Thc6k+CYc9msgznZPAJXQGNaWUkYpT5inIJ4zGrreFkKhigtmcjkc6lyU=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 22:01:09 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 22:01:09 +0000
Message-ID: <551a5499-c4eb-0416-0d2f-9951817346ce@oracle.com>
Date: Fri, 14 Apr 2023 15:01:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20230409212538.18647-1-kch@nvidia.com>
 <0c50fbf6-4bc3-7289-2a39-072191c81dbe@oracle.com>
 <8a811508-f53c-bae5-fe32-da65101bdec2@nvidia.com>
From: alan.adamson@oracle.com
In-Reply-To: <8a811508-f53c-bae5-fe32-da65101bdec2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0053.namprd12.prod.outlook.com
 (2603:10b6:802:20::24) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 081733ed-f3e9-48a2-322e-08db3d33c0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	kHc7m9BROX/YGArqYk0zLuPa7QvHDaySs2TECKIARMSD5DCoIcukwVu9yydTmMRm1GVlPE+zpe1sxTKPzlirwBQ3QyN/PCDMEQIRCvdvlThhC3t8dTklB9h35CFwiPLSN+239oO2CPbmM/c0W5UyyqNPSSlFVGPcobsvQIchveMmlbA11DHtSPzDGwQT93JUvBqW0+5nXX8YoR7iA1P3cXgGuUCP8aeJ3l0AyOqykggwaMYFVbe2ou5LGP5p+ZPO4w69+d9oAsugVANRQhnOpAyQP7nVTvnrpCO0s8MXvRgxIHpo91suuNYn6ftfNkbPzJddPzEc8WIESZc+r21MeFPosh0B+rfyLBmWAEBdPefD6jVesAnhOVK0AWSZ5z0IqIqtYoct688eaR8oPvBTDDKKC41EnN9KwHGWyh2IghIGwNTSkx8wWPzVGLV9E3V0NWozssn/lSlQaVpXBRFgx/85qgFTJCamxlEl0M3aegpMIbuDVx6stF1/hoW1YKb2iSkF1Q1u68vcXlydR22+jmbhs3V35GGH/zqiDgOUYZSZLjV/PJwwc4mluiEfuGlEgdd/GF0TWc96VX8ARvCikZfC0X3WE92Hroi0FOG4F4g=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(6666004)(5660300002)(4744005)(6486002)(66556008)(6916009)(2906002)(66476007)(4326008)(66946007)(36756003)(86362001)(478600001)(38100700002)(41300700001)(8676002)(316002)(8936002)(31696002)(9686003)(53546011)(6512007)(6506007)(26005)(31686004)(2616005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?djBhSmErcmJNS1prbGVQTTJHWUNTOHlxMTBhSStMcjhXOTg4ZG80Yk05dEJE?=
 =?utf-8?B?UG9tWDYzelRXV3FQMmFybHZPdlFvTmJ4alZMMEkrY0ZjaGRMSno3SmNUTDZn?=
 =?utf-8?B?dDJLZnZGODFobVRWYXpnbGdjREJSNGRYdUxmRlI5YXpYMkhhZmYvN1BEeE94?=
 =?utf-8?B?cjh0UGx6Wk1qM2JwY2Vlc0hHUnNzZjNoQy9YWm5YY2lleVNLTHBueG95dlA1?=
 =?utf-8?B?OGMvcUVYam9xZGlCckRweHNLZE92Z09pUVBDQkNPVDNiMTVoWHd3ODRLUXNN?=
 =?utf-8?B?dnR3ajZTR2RnYXBsRy84OTNoWm1YMzhVczlNWE8vSmFhYzhhUndRelkwQ3N5?=
 =?utf-8?B?dW8zcFJEY2VJYnlpMnp1UzBvNEZ2YlNiYk04S2tKdmpRWjRxeWJKNUFQZU1C?=
 =?utf-8?B?N3IzbzhxdDN4M3lLZ3c5SDZFRjljSGpLQVVOVysyNHpMZ0UyYkhjaVFmOVQ3?=
 =?utf-8?B?WFdNQUY0YVo5d0pjSUZZYXdXM2UrN3R2cmZacW9VUEU0cGpMeFBoR3V5Ukkx?=
 =?utf-8?B?akhiMnNjOU4zNjRuTjNzUmJidFVSRVMrcVRYSE9DM085emIza1RlekFUR3c2?=
 =?utf-8?B?L2Q1S0lQdVJTY2t3ZkJSSFVwS3BBWEEwenNYalEwcHJ2WEFKRHZJb2tjYU10?=
 =?utf-8?B?WE83TStWdWllSlkzUyszaWgxTFRadERrZnp3QWJPUXpCUlp5SWhsMnk3U29Y?=
 =?utf-8?B?RU1IZzFVK1A0VWk4d3dUMHJhMUNGSDFtN1pOOEhHSm5jZ3RoalBFRzBlTVo0?=
 =?utf-8?B?Y01HV2pIUm9FcDhwNU1McFBHNTBNY2s3dGliQk9OVjFZN09jWG1LbmV0Skk5?=
 =?utf-8?B?MEN5elVIQ3BTVWhVYk83cjVqRSsybjdqUiswUzd0V3hTU0M1cnBQWGtlY21p?=
 =?utf-8?B?TnowQ1FINERvQVRRWWFucGRVWldLVENCRmY5d01VQ3pCUE9peXVlK2VqWFNH?=
 =?utf-8?B?anpMWmJKYXVFekpqeGpiNjdLRmpndzhZZnFYeW82Rkpnd2x5b0lLTm5LaTVJ?=
 =?utf-8?B?SGZQZ0Z0SEw2VmZFaTRnT3dmOEpEZUg0UDRvTUQrdFFFWElWWGU0Z0VyRDJY?=
 =?utf-8?B?bDRoWVVhaUdEOHV0U09kNHFKdStFaUFsdHhEUURaRmlMRmtwVEpCSnRzL21u?=
 =?utf-8?B?cm9RVU9la0NEUnpxbWwvNS8wUHQyUlZ0dUJ5bGY2K2RJNVRXakJqTXRpQmh2?=
 =?utf-8?B?ajhnVXA2RmRDSWdKb1pUckZ4b0FwSjE1OUVUOUpuaG9TVnE2RkZUcWVIa2l6?=
 =?utf-8?B?dzNVcUZJOXU4MnlIRllvWHNISnZlTUFRYUtDNU9sL3FoNXJySUhpMkR4MDNF?=
 =?utf-8?B?YU9EL2V5b1YyaDNncTdJK1UrRG9wY2paenNQbnBhOVhNaVZnU1MzbVNFZ3lY?=
 =?utf-8?B?VGVjSWFKWElKT2J4OXJnNVJXeGt5eCt4ZUNsRnVVNXJFRlhSZSs1cnZwVkZ2?=
 =?utf-8?B?WmtTYk5OUmtIZE5HdDltaWdjbDlER2VLUkg0bmNicHhiTlVGdk1DRVZDMzBo?=
 =?utf-8?B?SFVJS2tpNFZpY2JYVGNsbTFYd1BTVFk3YmxYcURLUy8rOW1kT3IzVzRLeUVH?=
 =?utf-8?B?blF1N0dOTFR5RVhvN0JaYzhDNlo5eVZvM2N0RVluMmQyYjQzb0dXVXFqWjMv?=
 =?utf-8?B?YzdVVmMwL2JueTk0b3doNzZmZi80dFFHMlZqSlZ3OWxNdlZYVzcwYkxnam1k?=
 =?utf-8?B?MFUxOVpWeDhreDF4YWVaV09HVVkxakh5OHhUeEtXVXpKWmRqZG1UMWFMdkVm?=
 =?utf-8?B?N1gxRlBMTDVOelZLNmt1R29aRWVQbjVRc0JBQ1VpYVV3OEJ1aHVzK3RrSGxC?=
 =?utf-8?B?eUNpdkJsanpaQkZmTnd0S29RMytBWHFSS1kzZEhaVGRhUzd3VG52aWxtM3FS?=
 =?utf-8?B?bkw3WE4vRVZpeFlKNVVpZEhuU0V4NjNQL1NscXE1bzJFMjYzS0lOeTdyY3F3?=
 =?utf-8?B?TFAyS213SUJrbGt6MUxRL09HNzJQQWRDeUxVQ25CR25LWXh5d2dOci9DdUxF?=
 =?utf-8?B?aXV6MGsrd2puV1BVWm1lRG82ZTFWUWd5d1lMTnFGTFhzclkzVXltYzVhY2l1?=
 =?utf-8?B?S292cW9UUTJNQUtkSkcyNXlySEp2SS8rYmdqTWpvQVNlT2NjUVIvQmkxb0ly?=
 =?utf-8?Q?F6HcbrPKP7WHJbqUnK6ATfh+j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	7ibCs/0fIaQV90dZBSVMBOdQcswrUxA1KBvDXsXL75g0x1c+/hnqiXCbjdWcatizoB+zU6GkGBz/VPMjbomnBGmEDbZ0HRn5suTnWFb+JPWLJdFvJ0GfsmumjW4EYbQGnSpeokvq2eVU/OzCd+qtCrgiP4lpELFSPVS3vG4LAtdP5XpliZB+RjxRFNflS4hShmwVHQp/0+3kWP3MTsT6fw4WhtKrAQSzE0GHpDDr/fLJyu0BWrmiLFyAfW/ONPuMkj6fAedAuUS5zaG9WaNSPPcGhJ266YdGleS9L15xQZ4CDE3lfLjfHAJaqBmUmldxTvHzJ/Azg+QXICIzUPQZLJKAphUq99SKDGydy9jawnrAB+nyxcGzd2ZO5rOwL76ob7qPqibBbmh7TifUPr//HaFC3BQq9fcDT3TPMn1TIfK2Memix9UiNJoxA6kCiMQVndED15SEEicvfqfeTHclKYjmIrYEc6q95Rtu0ZpZ3X28RKSEon6ZdKF6UZE9tgV08me+Y4jR/IBlbjIHKUHqQxpG8vJZkyTuUjMQxzahNcwfvaJ/2MX2+KaQv0VB9d6HUVYFL+Ag/7J//88dcElGoCeZtGbB6pfFcnGx5jfS+RP6NayikiJ9z39mXcNLTOspRXDjn0A0LOzhNC/fpf6XxmLiGcjIyqE+XVFXkLmvMfKgozhiLk2YBMtY5MCFxmUgeNC8P7W2znDvXZ2tsa65YYLnKecHAy8LkUHsX/1dKtnBRdkEE0bQs3g/rNlsS9X4wqHdg11Wln/6N7mYKKNfuk/4nVv1BDBra3JkIEleeVZjlCnznlxj61JtUCYMOXyJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081733ed-f3e9-48a2-322e-08db3d33c0a8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 22:01:09.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STwyF2NntRwX5eExC4JldflbxVYd5v3MrLSC7S2k8tKTbULuUvSj4v2Qq71WxsqjKay/CSCOomtjcpB3zWTOqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_14,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140193
X-Proofpoint-GUID: 9Payi5TBE1-tDC-zbF-Y7W79Z-ei6PG4
X-Proofpoint-ORIG-GUID: 9Payi5TBE1-tDC-zbF-Y7W79Z-ei6PG4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_150114_064610_2C3A6E23 
X-CRM114-Status: GOOD (  18.21  )
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


On 4/10/23 10:23 PM, Chaitanya Kulkarni wrote:
> On 4/10/23 17:05, alan.adamson@oracle.com wrote:
>> On 4/9/23 2:25 PM, Chaitanya Kulkarni wrote:
>>> Hi Alan,
>>>
>>> I spnet some time on the V4 to fix several nits and testing with keeping
>>> your authorship, please have a look, feel free to send a next version
>>> if you find something not right.
>>>
>>> In nvme_end_req()_ we only log errors which are for non-passthru
>>> commands. Add a helper function nvme_log_err_passthru() which allows us
>>> to log error for passthru commands by decoding cdw10-cdw15 values of
>>> nvme command.
>> CK,
>>
>> Thanks for doing this. Looks good.  I've tested it in my environment.
>>
>> Alan
>>
>>
> Thanks for having a look, let's wait for others to have comments.
>
> -ck

I'll be on vacation next week so we will move forward with the patch 
when I get back on 4/24.


Alan



