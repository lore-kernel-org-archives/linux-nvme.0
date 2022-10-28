Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B488ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 03:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/QclV2vH8hGuYSdHv2BMgjnCkhuViJIdOjEcoZ4dMJk=; b=wA1WqXkmnQZ+y9MvcLCbWY3Qr0
	k90j8A5FPa2tSjFH5UTW1biwsddtHMmPQXv+/2xiLE42cXb20F/Eep4OulDpIal/QBz6nrayufo9Z
	6Vt4QuuzubsjwX7VkCQOaisbD7Y2EL5tdtMRcki0ZCTptz+UHN6KHE+v250D65SS61JBgcyjIzN3d
	MgeCgwiepsg6P4vpSjT08o8pHncpQ+nUV/428DZr0VNYAfBqwVM31etO4/l4cAiPzpNzg7KtAMVUV
	H/RoFHz5BUbjaKG4AlbVTYaS1RWsBakpGkh8ABtvcvwQaadi2IzRG0PCOoXdaeDZcFf9WVpHWHoqp
	M41tUzSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooFpF-00FbNv-AI; Fri, 28 Oct 2022 03:14:29 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooFpC-00FbN5-6P
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 03:14:28 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMO59Q016814;
	Fri, 28 Oct 2022 03:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/QclV2vH8hGuYSdHv2BMgjnCkhuViJIdOjEcoZ4dMJk=;
 b=tfXTnkmQ+ai0dT3FLhZo1Yt3HRTKPQXSlzsMCJESdLXrBQrecwfj/PT5ylam+AnJ7Lg6
 MFp+Yml8HLVy65u0T7Lr2P30lXU8PjB4CL4V3tBvE2sMMQQaWiueieqOfp2d3A1dbxwM
 pXvdXq43hizVaS8vfQh/nV8i8P5L8Wl5XGhzGc8432O7d0LLcDlJxTHpdYtrkbSAzrWG
 6Qu4aJnFe4m8TOyNe0K6ly3qTxpUqRIA0roti7r6rQeXXZIUG+S5itnoiPam3WGvrZpu
 Khg9ET1a3j5+ZEdjSDPKQdFJLoUetVLOuj5ndXVF+Pd8WsTGKqH7Uy6HPnFdT94MmfAO qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawruws2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Oct 2022 03:14:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29S2Xoqg032662;
	Fri, 28 Oct 2022 03:14:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagnnb4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Oct 2022 03:14:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8OAKZKycwqNtzFa3In5n7uAGi6aESaXRNs+TRxEsr3LH3nPqGMdHmBVNAsVphN8yjEqyoU/XnoERugM4Rmn/IUWxajPtltx8UX/pzCApN8GYzflNvoLbNiZhwDPX8xpgnHAJTA8VVw7XGDCsB9T+rW3y1h85mQEIitYm8ZciN3joz6bel8vbkJ0RQ7uEmUJtvzhQCTLPEy+iKDPClFy7rM+5G0kt/Ao+4hehj/hXjVF4o2ltT1/Sq+yg7m7z5jmtRS3x7G3v5fbpK83phtXUhhZe7/asMjOCqJw4NWadSe07t8lvRNb3tAyKDUBABZnIz5KmIOV15L6AIKegJM8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QclV2vH8hGuYSdHv2BMgjnCkhuViJIdOjEcoZ4dMJk=;
 b=POF78e/hdDnVRUm4ZDNahFo+qPfaOW8rKePY2SD1mIIISbPg5p7sFfVLJVhHiSqt+seCCX2FJ7Qb9cx8KVEFp/GnMNKqJxVxNUG94KI/69zUq5A60/pKPWTtz4zNtPCqAEc9BS1e4Pey3oKtWL4qJSUeuH437DIkofW1vqRdRunMnejsCKko7cZ1fG5JZObDNt2ttU+dG/mDe5ULyxPFeaskm+hJ3QN1BD+UriPu7Zc+5tXOC5UQ0WujaJ6DoLFsdGsDl7SbxDNKNFU5edplkWMR0FoAf2Lqs5+XDvrOxelb+XJK87P13AfbR9kTmX2rD/2G50jfPHlYXvR7H76BVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QclV2vH8hGuYSdHv2BMgjnCkhuViJIdOjEcoZ4dMJk=;
 b=FebpHHMlLIbspGz1550dsetNBArz6hRlKiNuUR7l7z29mwQmebxjk6o93A1He5MeF3MdNpUijvD1RGr/GigQP9hyyV62bUeNLn8uxxvrXxQ7xpmTTJj2ltZLuSu4QYC+2//gEkuVuulCjuAeszssHN3aISG2ZXD7H/EGuOBrSQo=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by IA1PR10MB5972.namprd10.prod.outlook.com (2603:10b6:208:3ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 03:14:13 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15%4]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 03:14:13 +0000
Message-ID: <85c20be9-7b67-ffeb-5d80-b1f4b5646b81@oracle.com>
Date: Thu, 27 Oct 2022 23:14:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [External] : Re: way to unbind a bad nvme device/controller
 without powering off system
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
 <Y1cTbOinkQZvpzY0@kbusch-mbp.dhcp.thefacebook.com>
 <13888912-24a4-870a-cc93-4192a69ce9ca@oracle.com>
 <Y1dJbgKZUU9z/7Ok@kbusch-mbp.dhcp.thefacebook.com>
 <Y1gVOK8VXhZZbm/C@kbusch-mbp.dhcp.thefacebook.com>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
In-Reply-To: <Y1gVOK8VXhZZbm/C@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|IA1PR10MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 50649a04-ad70-4e25-3ac0-08dab8927d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	pv2/pGpVG4+7nIJxHjd6dCHJAhRhkJpAjoq4VFfERk85P8GwW6eqoR037RQftyjAlhPYQJGHfwxeeOzLXNt5jzftCRT5kzz8nP85V8Zi9FM0QdW8kBWeFKPMuWCsM/E9sk8c6e9BBzr741/BZrQkCrgLiw4LZbFWpknIhPNq6WtDCeIIJDftUQWWUdyYufYwRy2NcRtquDpzL2hGUAv5ugpHIjXQiLEJbtdDqneCwzZKt9caw17eQ8sS2A8AUtCVHcjxsdMoCOW1vQOTuGD7Uia3p6L1FZLQ2IwbnRn/Lf35tkXsNoTxq2NUaUxULK24p6QNGLqOah1nxJ/6F52w2yAMdrpRyMfoPRMJJETOX7s+bh2WwZRzgpMjjuFT8qvUYFzceP5xd3Gy4NDPLO4vH465p5GsqahKvyFSTnao+w/csp0kohhRexpoLi8K4G2e04dI5HyvKMp1AdOzf2+AJZVoZh9NoUJAQ/o6+sJ3I+FK6MiJaBd9GijyFhGdqrozEGUSfBePNx0OlbsrMoA2NpMW9zCR5FJaSCHyhVgtxQBB1916MnLGlkbT5ykrK1rLUZQ7s7P9rzky5MrzHP4Y0rqZ4ve0WWU3ZIK/sQ3tjct52JUqSJFv9249yY1frqffSwN2vYLFbCaoY34OJb8opSJXgpjYVP0Lxo4ApJBk5bM1sECdPZ3GdlVJzneS3oQnMBqIrSXRFx+D7m3L0XrME/NlMZJTn8WwgDBL1YWwNPHSX1lp/DM89hkPRVrjkrqsAS7FryqJqRRH4c+UwIlKJmOsd/pIxPJjofikkp3GE+KsrV2zvcUch1Q9NQF7p/B8
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199015)(6486002)(38100700002)(5660300002)(478600001)(66946007)(66556008)(41300700001)(31696002)(8936002)(86362001)(8676002)(66476007)(4326008)(36756003)(6916009)(316002)(31686004)(2616005)(2906002)(186003)(53546011)(6506007)(44832011)(6512007)(83380400001)(26005)(43043002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?VW0vYVprOStxa045RkZlanpvU2FPbjFJTDQ3Rk9BU2JLMlk2WVhJZ0YyeHJi?=
 =?utf-8?B?amI3ZWoxTGk0VVBLaUFoZHZZRjByWGlyVFFmcE5Vd2VXVS9kV2pUL2NzZktk?=
 =?utf-8?B?aTc4aGxtMGdmdjVGQ2RxOEZxeU4wK3M3ZlBOTk9FMFpOTmlXNU9TS01oaC92?=
 =?utf-8?B?NmJsL1ZZaEVlVGQrRUNqSDJQMU1DMUM0cXdGWnJzNXRweFlZbDg3VXVjTDVq?=
 =?utf-8?B?b2xrTU1HOGREdCtldE5rcTZxWiswUERpeFovaHR6QXBwZy9RYk45aFRIdlVl?=
 =?utf-8?B?c3NIWHJyT3NrN01JcHRCTDkyOVNnazJQcFNWZGE0Sk5tWjBmRmpvMGlselVv?=
 =?utf-8?B?aFkzMUp6VmdsSGpJM0s3a3NQVkNaNWIvbmY5eUc5TW5kRUxMV1JvbE5UaFJ4?=
 =?utf-8?B?cUFDemxZQVJvL0dDN0VPS251LzU1TnlNV3hFSzFRMHVoaDBSMHcxRWY2ZnV3?=
 =?utf-8?B?UE5oRHJ1UGxjQkU4dXJBa1dwQ244UklHaStreFJhS3NKdDdKZGcwNTQ2OXo3?=
 =?utf-8?B?NE5WY1ZvdVVxNThBNkQvT1Q0YzZRbjArTlFlZzBxczllbDJLb1ZZa3dCaldt?=
 =?utf-8?B?M08zengwWUpzUnlubk1YQ1NGM0szbEsrcjFMc3JEeUIzRFZsV3dLdEVNcUtP?=
 =?utf-8?B?YzdyMkE4WWVhc2phMi9LbCs1SFJwaGg4SFBHWXNUaVZRWHFHdVdCV2FsKzlE?=
 =?utf-8?B?R3RJcHIySHgyQitManYzYWw4VkdKVGFoYUFHUHpRekxsYU9ndXVycmFzOWZW?=
 =?utf-8?B?R0gyb25mS0xGU1lmR21QT0xRS05iY1Y3enRYemR4a1RRUk5nZnVoWllZcXVF?=
 =?utf-8?B?VXkzdXlvQlUxTExJdG5PU2IwYlM4ZjlOTGVTRitZeVZiaWQ1aitPM0REVmhy?=
 =?utf-8?B?Y3JtOE1aUmdRRjFUMXpzai9Ta0xQMEJCOVJ1Ym41aXZpRENwMTYrTlpqRURh?=
 =?utf-8?B?NGpMR3JhVk9xbkFGR0RLNThTV2xaL3FuSmh4LytUeWRkUVVFVUlFeEREM2Ja?=
 =?utf-8?B?Szkwc2RQYWdMakhPS3J4OXFhMEZMS3ZFaTJXMDA1dFAzakdZS011U001RjBV?=
 =?utf-8?B?VFlFaXhCTGlsMEFqTUJaam45bzNWWlhqcFZBdVZnZG0reTZrM1VwNDh1U21N?=
 =?utf-8?B?NlZaS2hsa0xWTWlOZnArbFk5K20wNGhTUjV0VnArU3NVRklEVmx1UkdZWXZN?=
 =?utf-8?B?M3VWM0dVY1BwazRIZERVL29nbVlHZXdnM2M5VjBGb0Z1NzhsRE51RERabGhw?=
 =?utf-8?B?YXRGVERtaGY2L1ZnNUp6NHpxN1J2dlRoNW12QnBQN0pZQkRad3MxWjNZaXZH?=
 =?utf-8?B?aDVaZ1hLU2hBTUMxdGQwZkxVLyszbWdFcDUreUd4bDYzalczY0hIaHdHUzhU?=
 =?utf-8?B?MEZXdDNidXd6SVR6M1BLUUNJVWZpcnduTHNyTTdxQjRZS0pvMXhqS2tJVDRn?=
 =?utf-8?B?d2Q1Zjl3MGlaT3JkSHJWbDhRd2lhSDZ3bzdZdEltWXB1aENWSENMaTVOK2Fu?=
 =?utf-8?B?QzFCNDJSQlpybGh1bnY0MU56T093bjhqYTYzN1JPTjlFTXc0S2FoL0tWR28x?=
 =?utf-8?B?c0lGWWpmdER3RW9lWXVoeHA4RGNEUkh2NGJZbmZSVm50TzRiR2ExWW8yVjN2?=
 =?utf-8?B?ZHc0L2hmbDJOMzlhWGR0cnN3VFpuc3pTbzl1eGxPaDhtZ1dVa0NKVURPZzNn?=
 =?utf-8?B?cjMxL3NJeUtFYmVMUFIyTmtFL3NldWJTa05LeTRBNTRRNGNEVm01SHRndkVH?=
 =?utf-8?B?M004M2YxQTJQOXlOZytLczRvNHhOcjV2bnppS05ldUxlQVNWVVJVTUpWQTl1?=
 =?utf-8?B?YzJ5RWpqa3ZFUEM1SnY2M3pxcm1UZ2xyZWhvZnJvSkk4czkrbkRrNGwwVk56?=
 =?utf-8?B?L3UrT3M4cjk4UlZsdFd0OUExRGZDTW5rcHRlM2ZMTEhFOGdMbjJkRVVZWjBw?=
 =?utf-8?B?NjdHWU1QemJyT0FXcGEzcVF2QjM3NkpqaGZXdFZuTTVPYkhUYW5RMmNWM3Fm?=
 =?utf-8?B?R0RZWDNIRkJuckFkNjBuTFNqRkVkMFFUU1N0VmNJblhGLzUyM3F2WmdzZWk2?=
 =?utf-8?B?eWFaYXVHbTFHVlZPdDJ3bzVhN1N4dVNHVUszTG5GUERRaFYyeGhQVDhpK2sy?=
 =?utf-8?B?eCs5bDU3aDl2aTQ4UmdQWnlKS3llNlp5RVREa2xIMUd5Z1hrSFZzakNxdm1i?=
 =?utf-8?Q?FfH6w3Qh/cCgoeI86LuUQkM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50649a04-ad70-4e25-3ac0-08dab8927d71
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 03:14:13.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBCFkb885qibuNDlw5DooBvewP+m+U6A6aXJXEtIOo+d5IreLiiSfvTT1y21YlRlAF40tEFaLPw0xaw61/hxKpoHzt42IT7rdL+oSy4xn2+YaJlDg/d979IRD6lMqVwc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280019
X-Proofpoint-ORIG-GUID: Co2jJIDT4v6L3n2f5rgBaT9smQJXHAOy
X-Proofpoint-GUID: Co2jJIDT4v6L3n2f5rgBaT9smQJXHAOy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_201426_950172_3D03062B 
X-CRM114-Status: GOOD (  24.40  )
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



On 10/25/22 12:56, Keith Busch wrote:
> On Mon, Oct 24, 2022 at 08:26:54PM -0600, Keith Busch wrote:
>> On Mon, Oct 24, 2022 at 08:02:33PM -0400, James Puthukattukaran wrote:
>>> On 10/24/22 18:36, Keith Busch wrote:
>>>
>>>>
>>>> Generally, the default timeout is really long. If you have a broken
>>>> controller, it could take several minutes before the driver unblocks
>>>> forward progress to unbind.
>>> One concern is that the reset controller flow attempts to reinitialze the controller and this will cause problems if the controller is bad. Would it make sense to have a sysfs "remove_controller" interface that simply goes through and does a nvme_dev_disable() with the assumption that the controller is dead? Will the nvme_kill_queues() in nvme_dev_disadble() unwedge any potential nvme reset thread that is blocked and thus allow the nvme_remove() flow to complete?
>>> thanks
>>
>> In your log snippet, there's this line:
>>
>>   kernel:warning: [10416608.580157] nvme nvme3: I/O 209 QID 1 timeout, disable controller
>>
>> The next action the driver takes after logging that is to drain any
>> outstanding IO through a forced reset, and all subsequent tasks *should*
>> be unblocked after that completes to allow the unbinding, so I don't
>> think adding any new sysfs knobs is going to help if it's not already
>> succeeding.
>>
>> The only other thing that looks odd is that one of your stuck tasks is a
>> user passthrough command, but that should have also been cleared out by
>> the reset. Do you know what command that process is sending? I'll need
>> to double check your kernel version to see if there's anything missing
>> in that driver to ensure the unbinding succeeds. 
> 

The nvme command is either id-ctrl or id-ns; rather pedestrian

> I think there could be a mismatched queue quiesce state happening, but
> there's some fixes for this in later kernels. Could you possibly try
> something newer, like 6.0-stable, as an experiment?


Can you point me to the patches for this? would it straightforward to backport?
thanks

