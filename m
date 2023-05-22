Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D3FC77B73
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 22:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgxsM3pY5J2/rdYKehd8/aVRsnQ9eatDNUogzT5h0lo=; b=uDZrdkBpfExBHHI/lPyVUHaUJK
	g3vfGqTrAThYekQgRBnSAI5NlQJkEHN2srOLfGZxPH1I1Lmyd0XMh2I26oBFD1nGv0VV3UxrRxSQv
	i1zSavpzg1YUIQneIkUTQ2Jmn/C5CZEov9cU62txognXgyA6jbiZ88XCVcAoQfYfkscxslZyAx4aq
	McY45idTU8XWfPB65wwfeSJ6Qw+b4xVyp+3G4evcwn/qW59t31ge/YdmRkdWimLOoP6wAE97NCGx9
	4Ce1ERqIYK8GvN8L2JQK/dFP0R4iwzVfoufxHmDOMSP7qzWL+T0DHahfRa7YbFPiX5Fx4s8Ysc5Hh
	jbOXATLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1EUm-008Iar-2O;
	Mon, 22 May 2023 22:59:16 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1EUj-008Ia2-1u
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 22:59:15 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOU5N016154;
	Mon, 22 May 2023 22:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BgxsM3pY5J2/rdYKehd8/aVRsnQ9eatDNUogzT5h0lo=;
 b=fWsb33Jr117d+HMPbIGaF2x0qdczl70hKLqPwn6Iges0hwh/urYN8jmUUwIWdympZ35X
 wDovr/vqKPBdnF2bPX38vTKsRfzYk3AOP/ZnKsHktNiVkUpfjbMmIViQ1pphVp6LcYpn
 mGSj3sCJG8sIoQBvW7g1w4NeCohr9JFTtuuTKnUV0gYPZZ/VS5OcHtdHfXpC9sFIhDG4
 CBO8yCOh1JAXnVTLpsuZp7SZvXchr0Lj4/vqbrBWdH/xwKPAw1rM4GGDe4wRF8QpzUk5
 BuU3l1dQ5+8fR/Kb2u5NAdXUAnOb9k8tmM97qNBFdYY6jz8ijuD/SpxJZVuFobQv0fsq uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mkv3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 May 2023 22:59:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLtZet023566;
	Mon, 22 May 2023 22:59:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8tjxy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 May 2023 22:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXAPtGmjNyEF/7/NCZZQs20hEk/2u2sexI37EnPUWqkiWt2J9R5rm/bF34CkLvbkQo3Azk60vZnem1YKooe6RmpoEa+TVXpwWvhu36MQ7EAswWkwxZYu36QPl7tfcg9gkHMCMI8W/tD55bsoKpAsmFr3+ymmKQiJo3VtUlb8qnfb//suoVSrss33bG6o8SxMdD6yeNNNYom2Q3SW2yJ9DrER1Eh6treOfz9h25Uxe4TpVM6gfkzr+ra8MxPmKYnuDYlBi6HllDWVYZU2xhaIgUEIc4NQXxliwKf3xGMMA0hUefQR656/ZEbMqGIVeTZxEfwTMZbQw6ujEbYTN7Srgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgxsM3pY5J2/rdYKehd8/aVRsnQ9eatDNUogzT5h0lo=;
 b=LHxnbU7xet3RqDLzH2AFCoUUNPsxe1p+BYX2X/l5K854P6MVfY3m3wx64Ou2SK5pJBynTgRkoINOOt8gI/WoIfEZS0wbYap7jcgv0wSNZEkkTy9m5YxoqVur2OSNlWQDD2zj0x37FYOth1AJpkcCs19OiIvlR78g3RUSt1Zhhp5KYFA/nkvpcuNAh8y6x42YNc5LYoq9GcR8oRoKQUyZBcOUhyllPF+BvmHkagPGFZNY2wVJpU9BKeJhnPuyFIkxyfBR9FHLHrYibt3OD7JFpnJxSGumeiYo5m/LlJtC56IMY7Nc6N0vi8pyJOwHmqqSAcL2sdrTTJ1Z/pwzBbvBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgxsM3pY5J2/rdYKehd8/aVRsnQ9eatDNUogzT5h0lo=;
 b=zBvisqXlSpS/uPnV8hEHsLE9+MXd61XyXFVTponk64QohX7NpJZzcbNVf59RL6N+vsPE3MztwEUSDW2TbsmMg92er9NqlJ5u5cKRXhBEgHXYui6CurE8euVdWJcoNgGs3n0fUprOpyNoWh6ws0te7VuDyW1YceaT5NVg8Tjzy/Y=
Received: from CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:58:31 +0000
Received: from CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::ff8c:fd32:a7fd:f01f]) by CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::ff8c:fd32:a7fd:f01f%3]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:58:30 +0000
Message-ID: <e35b59a8-73bd-46de-0c99-7f6b6db1294d@oracle.com>
Date: Mon, 22 May 2023 15:58:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH V5 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20230409212538.18647-1-kch@nvidia.com>
 <20230409212538.18647-2-kch@nvidia.com>
From: alan.adamson@oracle.com
In-Reply-To: <20230409212538.18647-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:5:177::47) To CO6PR10MB5537.namprd10.prod.outlook.com
 (2603:10b6:303:134::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5537:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: a6eb9448-0b0a-4068-d7d7-08db5b180fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wf17TJcSel/2CMKL3/T9cWyAt3h+ecjlCx2/coVg/lZNPAbpihJZ/o+b6ITXfr20kqLi2BD44k1av7rRxh4wfM4NGdPlYA/QPuN4GMyjHNRN87fdfFkPAEPlpCgb63Z0Ajybz+kM5SuPLQSz7i0u+Lkk1j1Bc2s89gfZSy0Uz3IAf2h2zAJThSkFvlZUk50Cko1VfaCvMZC1/Xpb9otGBvw8Gdnb41X8ZebQjDCWPb+NLK5Z38vRiFjLepHzn9pXddH+u/I6YpgczWIR9H7VhxdlwYD8IRZjesE2kXtPyAi3FjvbvncR8/51vPi0vqPfmiGCwgkVkAIBSOtliUu5GfrBUZrJmJqtc5FHJUD8mXq7LxFZkvtTcrKL3YOY8tTAHlk6JnCZo9cUOXYQ0Gu1knh9TvZalam4DEF/Db64LWu+rDkvleu15tZt/+lfZfnThp73YY4IXBYFRyNKX5BoEATUnl5Q/IQtI8O9ZwZWa+OtiMUGtxF7P+FTRhlVwBTXb4xTxLUxG7J58HsLXxXXtwXFdawdsbl6UvcMrGTPNFoMQc8hCZWDsL2N+Tyvy9wjcBLKzZGMk5URATHBkK7anxO9H3L9BlvM3CtcF+9PEP3BucC/GX3aUl5IkGyP/sPt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5537.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(2616005)(186003)(83380400001)(2906002)(53546011)(4326008)(6916009)(66476007)(66946007)(66556008)(41300700001)(6486002)(6666004)(316002)(478600001)(26005)(5660300002)(6512007)(6506007)(9686003)(8676002)(8936002)(31696002)(38100700002)(86362001)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnhTQ09TUGN4S280eFVpNTR4TGp6aW1JaE1GYmFGOTI5WCtLMTlEUUI4WTh6?=
 =?utf-8?B?Ymp0Mms4WXp0K3hwTlJBZzJLcWIrUXRLcGVKY0lFSkNRYUIwbXdVSkdUeWJi?=
 =?utf-8?B?TUlkQnZNRzNRUFNxUVVxSU1iVTJpRXBOVUEwaHV0MFN0UG9HUFc3Y0l3MC9Z?=
 =?utf-8?B?RVArYndjTDA2YnlBQ2hWakdRQVB6b3JLa2NGNy9ha2RYK1p0WVFIdTMwQjZh?=
 =?utf-8?B?WkRLc2pwQVkrb3g2ZnNOTVpBUkFWcGVPOWFNaDR2ZmpTMElRdFZKTiszMHVS?=
 =?utf-8?B?L3RxaDRNQWZLb1FSS3NhNnRaYS9QY2hzVXhxcXlqRGNYcVk1WE5MU3BFcjQ0?=
 =?utf-8?B?dDFLdjhrTytXQms5UW1NSmFKK3lSSmxoaVpFQ2NBay9EQ3JCeXRZTndITFRp?=
 =?utf-8?B?S2c3SWtyaTA4NVNNU0FlcUhrTWtXUmd5MjhTWFArT3dXbExqd1J6Rzk2WVVM?=
 =?utf-8?B?c3hVbFQwM1BZY2h4MEtRc2tsU1pHR0dYSjRNdkVHS1hMNlRIYjNqTnpScXZ0?=
 =?utf-8?B?RGM5Y1hOT3NRRG53bnRxR3FZWDFKVjBIbnowWndHMjUrRURXTUhxV3ZEQUlO?=
 =?utf-8?B?Zm5lL0ZFckVIUGl0RDQrc2ppbk44QlVjdkcwY0pvVy9aTHJDaHRHSy91bmhz?=
 =?utf-8?B?TGJKVC9iVVZWV1NHZWZuTzhEWXlrMnVjMmV1KzNQOFBqa2ZpaExhYmxUNVhL?=
 =?utf-8?B?cWxzT2lFcDZjclgwYWpGZlBWTjJ4Q3BYU2lIemZGREhXVVZoN2sxSDBUMFVi?=
 =?utf-8?B?UDBvRk1XbHNnOC9qWUE1Ymo3d1VYV1kzOVFON0FJOVFMd0JOdlpVaWFHNHRZ?=
 =?utf-8?B?UlQrdWpRT3lqankrVG9LdS9JK2EzUWtrdUFUcE1zaHFSWGlLcGxqVElRSi8z?=
 =?utf-8?B?ejEraXUzYVVQQ2xiUk04YnV1d3JZcFZ3RXRsdHhYcmVJUUExVytwSThSS2Mz?=
 =?utf-8?B?RGhESmlVa04wYm1USFk2WThNZVhIOUx4R1pTZS9Dc3VQQVJndXNWbURxenJO?=
 =?utf-8?B?elVPQXRPdnhBZ0NrUjdPYWdvdm1HOGsxc2h0RlZIVjlOTlIrcTFhQng3Vmdh?=
 =?utf-8?B?QnB0TEpTMlQyQ1lBUDNmcXJPUHM2Q2lOeEpzQit6NmxPY0w1UFQ2bStNS3Ur?=
 =?utf-8?B?WXhVNk1zK2gzV1RPSU52TWFEVmNrZGl1VVdTZXdDS3BBeCtQZUQyWlF0VDRm?=
 =?utf-8?B?dGhKY2dQc3NPc053cG1YOHozR3FiMi91Y3NReCtCYjFMWTZtcTN1THVkaEs5?=
 =?utf-8?B?aHk2NkJOMHlKekVSaHVmMWhEd2hZSXNqb1RsT3Z6bFUxcWx6TkN1RHpwMnhT?=
 =?utf-8?B?VitkMnVsR00wSklxY2RuT2tHS0VTQjF0aW9CWWUvTWYzVHVVekF1WTNYOUt4?=
 =?utf-8?B?U0lLQXAxRmhYR3RsL2FzNXNJTXM1SXAzbjY2Q2t3TUVWck1JTkNyZzVvdi9L?=
 =?utf-8?B?MTd2UmdWakxXRFNDVTVJejJESXRVbnNteFhzTmthVFhNU09TZmdqdUxXb2po?=
 =?utf-8?B?Tkc1NVducmNyR2hZNkpWTFlxRjNzaGlYcGtLVGlOMmJ5cVc2U2s2aWhJU1o3?=
 =?utf-8?B?Q2RKemRMNW5KK0VXdXVEVGRjMDhUMk1PVDI0UTBPbUIwTXl6REl6NDcvMGV0?=
 =?utf-8?B?cHp3SUZ4cHpRNTd3OEQyY1JKU2FDYUdlSnlvU0d6Z0M1NWlWS2Zva2lsVnpq?=
 =?utf-8?B?bnRUWFE1aXZydndYYjVmV2ZFN3dsQ2xPUWNsY3d4RWQyRm5tV1VPUzJoRnlI?=
 =?utf-8?B?Tk5NNVgrUkQrajZ4VFpJRTZuM09BYUl4WnNnbzJobG5vM2RuNzR3YncrblZN?=
 =?utf-8?B?cUF5Ukl2dWNEM2luL2FyVzJzWE5PVzhYc0pzYm4wN0k0V1JqdmQrYzdxOCsz?=
 =?utf-8?B?b0xSMVBqVVNZL2k4dHZ6WEZnRUF1Ymp6MHVXcys5R2FnZUtQK01OWnpHQmNE?=
 =?utf-8?B?MUtvSTlWa2NmUE1iUDRHNEFoWVQyQ1dBd1B1V3NrZytuZ3VKVzk2SXdUUmRk?=
 =?utf-8?B?YUI1K3BTcDBZdThpTlZmVHhGT3dIbElDczFVdFdyYjkyV0Z1bFpGSU9oRlpz?=
 =?utf-8?B?ZXJpb09NaUVEYlBZM0FxUWVPdmdQMi9EZmRNTkNxZGRLZm00YkZxMVFxSHBm?=
 =?utf-8?Q?Bkayl0xL+4+bSopT61A2yRia3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tAg5PBgNe6PHd1HSOX81uQzGP25ogsVkl0457kgNiCIseLM/gcn1qBDglMYhJCpKwMWJFFKwOfuwJlVKwRFlQK7za1H4QL5QDinTbZOnYI9uUD+clKMxhUYV9cJ74R6Q6RgnhG9fOOxGr+KmHm7/f8YFcQRsSQN+b7Sgi1Dvw7ULWc16lmvMVqBjzlGIC01f279eZEr6T7WbHm4h+ARHX1BNI+BL4gi2Sv8K/rwcU5QPgIcC+D9CQ+eI/LpmjzBjWynKD49U2dL6xRnFgOn5xJ4SKecmuTMSndSnBhFfASeB1kY/Jkltvpk4/FREp/3H0dHDcTEU2zdTwY7Ge4vtBOWdvzp/KVTj8tS2p3zjebsDzT0gNK+phy7UmShzcfiAHnXJzkbiOKXvjjdfI3ovDxhiuk1gCWEfhrzIFkRaIrBDI2nVxYOteMKJFxs5Gu6Hjfy+PM4/O4hOXYUhhZOtUF1cw0qWGqKhDaqwvsTHLhowmZDPRK5Ydfs+36lsgk12QVxCIg3zwtFO7yQ0ZDwRKGg+xXfw6MInF+ymGph2Zte3PVZjA7HH/ctqKGMB7HAM2MxF0BiyK4jepuJlLmJv3Fvvrl82DQgB5SpT3QqIhm/It4eE8dq0GaZgMnUPPMCF22T13UQ6ZDRj8k7o0sxEPC5VJTdLUV+IY6QaL96yug6xlcnVTr+IOzSB1SFDhAoBku0YD8RwBVkJLmuXfWAxjMgQewXd7HsJu2PK1DB82lRv4iflGBtDuqTXqVYXdC1tUmzG9bKRCHCoqNXvZm591uxm9ANbL6v+bb2nFcp4utoJ2UvXUPMpDwnSRexm06jD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eb9448-0b0a-4068-d7d7-08db5b180fd8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5537.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:58:30.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZnZruEJTer1A3BKDls/fC9KprlLUroIwxf1fMHWbnduEG+XheqLeZBbhzxK1kkQWhb5xh/yCFWTtRj16joGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220195
X-Proofpoint-ORIG-GUID: zVXo5Lj-tMPmQJceH7wX0_qFAxGn8jXM
X-Proofpoint-GUID: zVXo5Lj-tMPmQJceH7wX0_qFAxGn8jXM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_155913_685432_28B235DF 
X-CRM114-Status: GOOD (  28.02  )
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


On 4/9/23 2:25 PM, Chaitanya Kulkarni wrote:
> From: Alan Adamson <alan.adamson@oracle.com>
>
> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
> disabled error logging for user passthrough commands.  This commit
> adds the ability to opt-in to passthrough admin error logging. IO
> commands initiated as passthrough will always be logged.
>
> The logging output for passthrough commands (Admin and IO) has been
> changed to include CDWXX fields.
>
> nvme0n1: Read(0x2), LBA Out of Range (sct 0x0 / sc 0x80) DNR cdw10=0x0 cdw11=0x1
>          cdw12=0x70000 cdw13=0x0 cdw14=0x0 cdw15=0x0
>
> Add a helper function nvme_log_err_passthru() which allows us to log
> error for passthru commands by decoding cdw10-cdw15 values of nvme
> command.
>
> Add a new sysfs attr passthru_err_log that allows user to conditionally
> enable passthru command logging, by default it is disabled.
>
> To enable passthrough admin error logging:
>          echo 1 > /sys/class/nvme/nvme0/passthru_err_log
>
> To disable passthrough admin error logging:
>          echo 0 > /sys/class/nvme/nvme0/passthru_err_log
>
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> [kch] fix sevaral nits and trim down code, details in cover-letter.
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 83 +++++++++++++++++++++++++++++++++++++---
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 79 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 954641a45e55..e32265adc034 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -337,6 +337,30 @@ static void nvme_log_error(struct request *req)
>   			   nr->status & NVME_SC_DNR  ? "DNR "  : "");
>   }
>   
> +static void nvme_log_err_passthru(struct request *req)
> +{
> +	struct nvme_ns *ns = req->q->queuedata;
> +	struct nvme_request *nr = nvme_req(req);
> +
> +	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
> +		"cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x cdw15=0x%x\n",
> +		ns ? ns->disk->disk_name : dev_name(nr->ctrl->device),
> +		ns ? nvme_get_opcode_str(nr->cmd->common.opcode) :
> +		     nvme_get_admin_opcode_str(nr->cmd->common.opcode),
> +		nr->cmd->common.opcode,
> +		nvme_get_error_status_str(nr->status),
> +		nr->status >> 8 & 7,	/* Status Code Type */
> +		nr->status & 0xff,	/* Status Code */
> +		nr->status & NVME_SC_MORE ? "MORE " : "",
> +		nr->status & NVME_SC_DNR  ? "DNR "  : "",
> +		nr->cmd->common.cdw10,
> +		nr->cmd->common.cdw11,
> +		nr->cmd->common.cdw12,
> +		nr->cmd->common.cdw13,
> +		nr->cmd->common.cdw14,
> +		nr->cmd->common.cdw14);
> +}
> +
>   enum nvme_disposition {
>   	COMPLETE,
>   	RETRY,
> @@ -381,8 +405,12 @@ static inline void nvme_end_req(struct request *req)
>   {
>   	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>   
> -	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
> -		nvme_log_error(req);
> +	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
> +		if (blk_rq_is_passthrough(req))
> +			nvme_log_err_passthru(req);
> +		else
> +			nvme_log_error(req);
> +	}
>   	nvme_end_req_zoned(req);
>   	nvme_trace_bio_complete(req);
>   	if (req->cmd_flags & REQ_NVME_MPATH)
> @@ -666,10 +694,15 @@ static inline void nvme_clear_nvme_request(struct request *req)
>   /* initialize a passthrough request */
>   void nvme_init_request(struct request *req, struct nvme_command *cmd)
>   {
> +	struct nvme_request *nr = nvme_req(req);
> +
>   	if (req->q->queuedata)
>   		req->timeout = NVME_IO_TIMEOUT;
> -	else /* no queuedata implies admin queue */
> +	else { /* no queuedata implies admin queue */
>   		req->timeout = NVME_ADMIN_TIMEOUT;
> +		if (!nr->ctrl->passthru_log_err)
> +			req->rq_flags |= RQF_QUIET;
> +	}
>   
>   	/* passthru commands should let the driver set the SGL flags */
>   	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> @@ -678,8 +711,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>   	if (req->mq_hctx->type == HCTX_TYPE_POLL)
>   		req->cmd_flags |= REQ_POLLED;
>   	nvme_clear_nvme_request(req);
> -	req->rq_flags |= RQF_QUIET;
> -	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
> +
> +	memcpy(nr->cmd, cmd, sizeof(*cmd));
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_request);
>   
> @@ -3417,6 +3450,44 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
>   }
>   static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
>   
> +static ssize_t nvme_passthru_err_log_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->passthru_log_err)
> +		return sysfs_emit(buf, "on\n");
> +
> +	return sysfs_emit(buf, "off\n");
> +}
> +
> +static ssize_t nvme_passthru_err_log_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int passthru_enable, err;
> +
> +	err = kstrtoint(buf, 10, &passthru_enable);
> +	if (err)
> +		return -EINVAL;
> +
> +	switch (passthru_enable) {
> +	case true:
> +	case false:
> +		ctrl->passthru_log_err = passthru_enable;
> +		break;
> +	default:
> +		pr_err("invlid value %d for admin error logging [on:1 off:0]\n",
> +			passthru_enable);
> +		break;
> +	}
> +	return count;
> +}
> +
> +static DEVICE_ATTR(passthru_err_log, S_IRUGO | S_IWUSR,
> +	nvme_passthru_err_log_show,
> +	nvme_passthru_err_log_store);
> +
>   static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
>   {
>   	struct gendisk *disk = dev_to_disk(dev);
> @@ -3925,6 +3996,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_dhchap_secret.attr,
>   	&dev_attr_dhchap_ctrl_secret.attr,
>   #endif
> +	&dev_attr_passthru_err_log.attr,
>   	NULL
>   };
>   
> @@ -5124,6 +5196,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	int ret;
>   
>   	ctrl->state = NVME_CTRL_NEW;
> +	ctrl->passthru_log_err = false;
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..f5721ad8264c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -248,6 +248,7 @@ struct nvme_ctrl {
>   	bool comp_seen;
>   	enum nvme_ctrl_state state;
>   	bool identified;
> +	bool passthru_log_err;
>   	spinlock_t lock;
>   	struct mutex scan_lock;
>   	const struct nvme_ctrl_ops *ops;

This v5 version of the patch has been tested with the latest upstream.  
Any objections?

Alan



