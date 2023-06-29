Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F29EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:From:To:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=V+kVHO6+yvSMxbROnu0ltSpJDFb/IsX95HFBwu6Nkro=; b=UzooaXVikapxpL
	QkEDPm64/ma40y9jfHs2R30Rn+NXx5iFIfYutxZCy2pHhMd07n1i0f9NZ4+Pfyv2Ad55O54b0bnjz
	H7WWMZW7ygFIDIpFmYbInGfmKaXUkKsIA/hZpwcasAf5BowgVdyw/MrQ49GoS0ANAKGiI79yRGbPJ
	s5WzLOpLmPVUUFmNxb5bHfmNprGFX5V0R9BwtoXyEz42g/GrV6eA/xi1RDiCkNdqRdM1K8lotLGs4
	TPpK+3eswKsj8c1wMrg+4JuLvfdsQatCdYaospPNaF6D2GvHnvsaU2zTJLYmtQn4VNNWMi4HCq7El
	21WLKEgt3HDOVnUmalww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qExFv-001wHp-0r;
	Thu, 29 Jun 2023 19:24:39 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qExFj-001wDw-2w
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 19:24:37 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ4XcF006094
	for <linux-nvme@lists.infradead.org>; Thu, 29 Jun 2023 19:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=V+kVHO6+yvSMxbROnu0ltSpJDFb/IsX95HFBwu6Nkro=;
 b=HZPPQAWoikUyzfJ2bn5yHoQMHyxy8O3Xgr2PMaKX+GXpKJCEIZZMXLRpj2AR/fvcE9aw
 tVqBT12cr+SFaViSrxh1j8Sg47Pb4LupikY71eFrjKrjKRy4Rd0LJjHYU7qGT74hBqce
 Fo0ZuDXPFnud/ut0wY3iN+7yGQaBlqyjO3cT3/G2aj39oNLIH4R2Dm1IZYof/VUlX9LE
 JNOX6zWRU3AeIgdZhxz5T1HskB7N/6eJzWjCs/FxlWvu/2syrAWDVxk776U5M2J/3GPd
 YX6nvZnpNlrHQv1cAjDbbKgZf09ypfGZHPMRKnrah+HSUGnSqDabuYGNCZFZtgL2o1b0 zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq315vb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Jun 2023 19:24:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TIXUwg038244
	for <linux-nvme@lists.infradead.org>; Thu, 29 Jun 2023 19:24:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxebwb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Jun 2023 19:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7NzNSTewFpZf6HCtTNl1BLAhDa8RS8TY0T09s5kIzMhJZZfHqdyx1i0/kKNDv07SYr/O2FjWMYCzbcLkr0pOFVOJnzQgAkybVf+eQHO0Aj9Z1jyW/nSyEC+LhJ3ePPVxkl75KOSLbdFQb/l968E2dphzQzUY6wAZdbuWyD7qzCkmc6qX9caQQHbOFQ2b1Bfm2qFwJGTAWkA+HahmCJoTRFgRRZ22neMHfvrXa08uR+fqJTT18uLDhpr0fT7ZJVffmxi/Y5dGrqOquhmgr5AcK94aqWXIXJZg8T3FD/sDyqFrV9K1ZuL58nHqfGO7/68smcrIxL2xr1wAE/E14TNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+kVHO6+yvSMxbROnu0ltSpJDFb/IsX95HFBwu6Nkro=;
 b=capMz4c150WE2kZkodZ7hEuYIOtt1l8CyTBHAsG32xdqaf0YtHQiTE4qpj0dBdpnnEMvh0fhQ7et1kFoIdi6bVJobe4eQTU0rmndTzvOWYi0EnXE3t8xvpdyDcHFJbn1XeLQyCi0qiHxj2A6IdRj9FpUYp4jrdzZuCDCMoCmjjz6vaEpztIzw//kpfAkeY08tHXg7cDPFse09ytzshyrc8Kx6rRdQWLgMEy8JzAnegzUd6gY4uHgb/VoxLInC6fGCW3H6cNZ3U4gSQcCgUT9NVa/Q2fKzLB1Qu0v8gjVOFUSpjCXWLeEaztwIOh0bHmMTGDKE+RKo4CZX+OgifIqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+kVHO6+yvSMxbROnu0ltSpJDFb/IsX95HFBwu6Nkro=;
 b=v2YX/6Q9AUHMGOwQZzYervvx0gvqE4+rHUJ8m6BbKfzmkNT9YwWbDDzIizOv7DvDdDy3bx2XZfMky3TbLmoDV4KEmfpH9Set3ceD1Flh2zNuIJOnHhIG9siYMhFBAnDOE1lMn9tNGYYAO9h7QfJwEuBLIEX+/5+8lA0W0EwWASU=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 19:24:22 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::be4a:517e:48e7:e46f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::be4a:517e:48e7:e46f%2]) with mapi id 15.20.6500.031; Thu, 29 Jun 2023
 19:24:22 +0000
Message-ID: <eedfab08-e50c-0a51-5dd3-2861dcc02b4d@oracle.com>
Date: Thu, 29 Jun 2023 12:24:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To: linux-nvme@lists.infradead.org
From: alan.adamson@oracle.com
Subject: nvme in-band authentication blktests - nvme/043
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c7e894-8de0-466e-3fe4-08db78d6717f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owa91D8EyrJXdcYxKbj8/LfLn41PFDqfHYGAfKRjI+FwqglBp3lfjpcl9P8YS2rU3JnMaFkF5aU1iuHAEwJQyZUTWJuevjphTjpnck43GElsEY0wKfABBPlka0lOJkc1Co9Hs9on2bIgcsFcptuSv/4YM8NJP/bliiwXVwevi6FxPGhgAGtPeTU8A8SWzyeElmy7w1kkWN7Wz3yavUeaRclOJm4Avc+9DXPiH3jQ5mdVsivm/C8HmSGSzAndCZX+d9cc0KmY+zWb9InnxgJFI/kh+kZ8M0vkS6eEcrUawa3w1VumDxYQHcA8XeaUFx51huzfcaUdSeBx47yml31Wzyi1R1JnJwxXNtaeWMS9fB/raMCeGf2OXvZZPntE+yqOQbrxt7rnsBmn1dbUTxhXA+IMbpP/j8egXaCEaaAlfZu3RKow6h7w9Jf4GXMBH2w6ScVGdaWi18/rCKbxlPr/ap0+zgNpqIHDwiq6FP0nu+J/C2ykFZgvnis88jvRnRw6NBgKSm6jF5MoyKDStsnoOP23FmHU38iv+9nNy5LmMVjzpcr4K4mf4GoSxleuY3uumixBeKYk6lKlshWyF1M0v0NVcQyrRTCgcGbIHbHLYTp8rcBDtK/NKG05vHa3MTKK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(2906002)(4744005)(8936002)(8676002)(6506007)(316002)(66946007)(66476007)(6916009)(66556008)(31686004)(41300700001)(6512007)(9686003)(186003)(26005)(6486002)(86362001)(38100700002)(31696002)(83380400001)(6666004)(2616005)(5660300002)(478600001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHJKMTI0QWFscXAzVEwyUzMra2Z4RFlvMUZGaHk2bU02RVpMUkNmN0l1YS92?=
 =?utf-8?B?bGE2K2g3TGpuaVhCRVZ1UmdXU3ZidEQ2clc4SXQ2TXJ0ZXBTTE9KRHlxNU83?=
 =?utf-8?B?UGlJS2FJZC9mK0pkZnJwbExVS3FhMjdHZW1OU2JreVcrZ1RYa0lHcEtPUjRO?=
 =?utf-8?B?MHh0dDZiclpkTUhGZ2l1aFJjb1lLWnFQTSt1TWlmb0NWT3VxVDNrYXZYUVdh?=
 =?utf-8?B?YWpuZ3Q2TzdPaDBtV0JRZ0R4LzFlZHA1USt1UmllUlhqcytLYk1UZ1M1dEtI?=
 =?utf-8?B?OU9FdjVwdXR2QzFHUVhUQjFvU0pZZE1NR3FiRjkrZ1ZHNFhLbTEvS2VUUXRK?=
 =?utf-8?B?SHFNQmEwUy9vWWE4T21QakQ5blFFWHFUZTBVVFFoR3hCTFpMaktvYmVsV1BC?=
 =?utf-8?B?YkVvOW1QSzhnNmJxN2xadDFjcjh5WXJkODkvNXFmUGlmV2VUcElSWDZVQlEx?=
 =?utf-8?B?ZE1lb3E1aFdzbHFydFpsdHZCeTc5NnZEWmlLSUV2Qkdpa2VKK2wzN3dFTU43?=
 =?utf-8?B?bkhxWXJGOG5CZmhHbTY1RVpGNXppRFhlRm0zQndnUEVjYS9PNnJJeG1lN215?=
 =?utf-8?B?VTNHNFJ3c1JzcXE0NXNUK0lGejFDZDRkV2crN2lJamFweGNnWWxTYkUwbjc3?=
 =?utf-8?B?QXVoT0YzR0NNRHlGUWpvb2dtUHNCT2lnZE9YWVF2VEl4TEliR2JQaDVnNTdr?=
 =?utf-8?B?TFNDanRUUzdTdUkxWGRzUk1WNUlBcXJabWh6Z1Z3Tzc5b2NWWHdyeTJteFBC?=
 =?utf-8?B?TmJyakhmaEsyMERwZ1pBU2ZEc0xkNWdENlBSbnRKVGh5b3hZL3JYNEZnTk9B?=
 =?utf-8?B?ZEVVMVVmWU9sYStERTNjanZJVHBYMG5jQ0tqTnNub2gxYk5Ra3RCRkVzWUMy?=
 =?utf-8?B?VTNTZlM2dzNDa2lWMU12NHFyNTE4T2hycnFpWUF5VmVjNkpHUHZBSVp5M09E?=
 =?utf-8?B?dWI4MG8rZGZxZEk3RXVTT0Q2bm5EdElyS200Njh2Uk00NTdxdHhRS0drYzJX?=
 =?utf-8?B?RUZoRHkyZGQ1NmVENGlaSURvL0V2a1p4M3c1bWluZURRMnpEK1hDdUdvTzdZ?=
 =?utf-8?B?cUg1RFQ0T0pZUTBpdkMrUUxXTVlnaCtvaWltdzk4RTNmU01hL0J4bzlsTUJY?=
 =?utf-8?B?QzhmVXpYejNxWlFVb1B0MnZycmpuS1Ava1NxNzFIRzlTcHlvaWY0N2dkYjdC?=
 =?utf-8?B?Z0YvalpCT2RZdDc4NlpaUVZiN0JIQXlYZjVsSGlaNUVMaFB1VUJ2Sk91cVBj?=
 =?utf-8?B?OW9sQmhpNmUzUmQvVG5sVWl6dzcvV0tFOU1YMmc0eE9YWVF3NDYwWUtPdG9G?=
 =?utf-8?B?TW9IaGZLNDM1VW96T3d3bmdOZmxFcjNiY201SEdSU0JUU3J6ZG9Ta21OMk9m?=
 =?utf-8?B?aXJwMXFKOTlCNmNDZS93c3RLOFFEMjlCYkh4SGVhcFpIWnY2cXd4M0MxRU9O?=
 =?utf-8?B?aTNxaDNjL0c1L1FkZWhmdjlJVk1GWldNdmRoSE56MEdGZUtjcmhtNFlFTmpm?=
 =?utf-8?B?V1VMVks1QzBXMzlEZ0lWWnlnbG1nczZIN1BXa1c2dEN4NUlEdlQweEpsTGZy?=
 =?utf-8?B?akxEQW9EbkN4UTJ2QkV2N1hEZ21vVlozK0x4QytZcHVtOS9GVGxIUlpLeTZx?=
 =?utf-8?B?d1FWNFJxVkdHdDJpV015WjRweDd1Wi9qckk4NnNFK3ROMndsREJiQWErbVNx?=
 =?utf-8?B?aERtRVNuMTc3blNZTGc3OVQ5MC9BUGVvZ05JL3lTeGN1YUs0MDZKMmkxK3F5?=
 =?utf-8?B?WU5sK1g1MjZQWTJJR2tKbldPQWtEbWFDNVh3L01ySWljRU1CUHdDZVVOcS9S?=
 =?utf-8?B?WDFWTGgxaU9DOWtyMWdtYVczVzRRK1J0bFNxbnByYk05ek9mc0RNSTBINzRQ?=
 =?utf-8?B?R09xdzRnOS9NZzJCV2E3SmNBOFpaOVdGall4ZEMwZzNlTDNhcGdkajRleHlj?=
 =?utf-8?B?dlV0NlAxWnVSaHpLdlV2aW1Rb3M1MDM4d1dqdndIMnB2QWNqVFptM1FnbkdY?=
 =?utf-8?B?Sm1NSFdhM0FvUXFTUmdXclExMGhYRjZOaWlOWTJFa2duRC93ZlBjb3lJaDcz?=
 =?utf-8?B?Qnlmd3hNL21sMlI3WFNZbjg5R3ZYRVdFTm9UU0lqVlpVT3U0S2FlQWtmMjdk?=
 =?utf-8?Q?UycKh7342KxyNGDyjn/h5Ok8q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2OJK9raClD1vSojpM99fWptd8o5lF8iVTvIqMvVvtjCFFfwMhPDPekktJgXU7sCobFJdqrXQ14Q8jKU09BsJQRGHK3wWOm8UaR8JS5ZyKBdRAzE3GVrj2+//aWC+Ww/ZOi2aMxflG5LKBFXuNNyF5lToKV3woVxbKPG/v1tyrsXAuhkYM13KMMf+JM2FMUb1NCEVljAZT1vXiFHjl9Hjp0Nqq689t/NFfC2ba0njy79nAobVPSYP/wVLPb8c9dlOxz2WA6wFdbIxJeAmmCU0EfRvQjLwUZ7Kh3rIqi3vDzJ+JyEn+0phTRfbS2UgYWU4Q3oZAnXOKt+NELIBabf2c2N7jU3l7hZL7oQcx33Y+iC70wKYouX4dYbndnPAwPwOJ3YvVpvOx1/PPdJPkDEFv4vonoX6xPUG7V92izcpFYJoA4WmRCGPGF1cQqb21aOAAomJbM4p3jytNwZXPtLn8mHp5X54hb2CsalBvfvAE0T5hErPidzaysto5ZvxlyAHccFiYsn34MRXKdG5jhD7wOHvSLdjN4/v0Ky22R+IpQq5ZbxdtoJwQEON7KTIwnnGVNsxuupSc6uVLE8HpQ+t3jSmLrnS9jtvhyYEtdbqYBiXO6fQ7S75puSyi8eHdGjkX/lFg3Z+qUL4mo7hBzM/KgZ4DO00piKq+ka72NqhQmoIrUOyp9d0MXGFCrIEoi4JJakIq2KtSxJpnviAblPVbiXbPI42dCJ0rtB+GySGhMnHdo5O5YNG14u+dkPDeIalKUjAzc1YSpwIEJ+QQyyBpw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c7e894-8de0-466e-3fe4-08db78d6717f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:24:22.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqCuDpyFty4kJ7iiqejvfpJsUC3tQp7hdOUCKutzAtSgDDEEufM/sgR3SLQe/f7wkXmIFxIFF7OWpGja7d/d5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=925 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290174
X-Proofpoint-ORIG-GUID: cOC7x6SEcHVvCKX01rr4m0sN53lsAacK
X-Proofpoint-GUID: cOC7x6SEcHVvCKX01rr4m0sN53lsAacK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_122427_964694_49280540 
X-CRM114-Status: GOOD (  14.71  )
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

I'm playing around with in-band authentication and using blktests to see 
how to setup it up and use it.  In test nvme/043, a valid hostkey is 
never initialized and a NULL is being used to setup the target and to 
connect.  Is this expected?  The test with the NULL hostkey passes.  I 
updated the test to use a valid key and it also passes.


diff --git a/tests/nvme/043 b/tests/nvme/043
index a030884..d5e0d4b 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -40,6 +40,8 @@ test() {
         fi
         hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"

+       hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+
         _setup_nvmet

         truncate -s "${nvme_img_size}" "${file_path}"


Alan Adamson


