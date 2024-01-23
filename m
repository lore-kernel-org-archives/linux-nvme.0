Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E434AC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LxQYI1RrtgQJ0nq25GzKNXsxxKZL+DSlEPaCJQahQc8=; b=4+lGMvciZGmYmqxarbqpLGmETR
	8K7DoUD0wJvkJOOLxTez6XDAq1UoVUfAfFebdtga1xNL45zQ56yXHXl3bQFfYkccJFSkthlnf57Ml
	V7NJd2udqBe8XTb+TcXRCvKUWOuxVPQVaLEVZNBujKwkNFeUdwxBFYpPyujt6qGtMy4DZz1DCPya8
	bhRUcMca5C7alzFCAo4NAi9W1cEW80Gy3JKX/TAGNQCwoC3F/h1hYUAAh5Br43pYJUx9b7PoRZg7A
	t8Hl6BXKQqZIK4HKtNN6SWbm4mADq2WcwEB/hSS8sXXO+fvL16sCPxOHU0D8wzVgYNeYoByWLvJ5p
	X/vCCUnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSKJR-00HSCU-2R;
	Tue, 23 Jan 2024 17:11:49 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSKJO-00HSBw-2P
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 17:11:48 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGREt2014414;
	Tue, 23 Jan 2024 17:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LxQYI1RrtgQJ0nq25GzKNXsxxKZL+DSlEPaCJQahQc8=;
 b=fvxW/hP7RVdiqKUFw/k98KU1e+v2vpuaKqupLg42+bvG/DC7Gs5Z3dvzLTWYu0vaCwlC
 L7+YkOL2VgKNm7KKlmOrJcyBPBA7ozvKSP5IoQuoqFiIFJWwLihD3DAmhVZMTcsNumsA
 eEN6pQoeP5fYJfdwHdKp64O6E2uOXzOggSHYUotNhpPKNSaMQuJxB6nrQsf2d7ANHIY2
 NGWmuKvIKTCibQxb9yOri5Q+VloqD1u8mT41vovCIIWBAiOHzcxyl+emSIQbN+/zeXWr
 a5emTNaIzo+hzJqwnZ7qGLB4ovaK7FGiwJRjhBBV8yX0og287H0ZdjIr/GXCDtBlgBn3 Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79newcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 17:11:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGNtqf006187;
	Tue, 23 Jan 2024 17:11:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32r5542-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 17:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0yLlvJ26yMY0+h0yO/aUM2JyHBAJBAInNCdgYchf11dcBEWrhox9U0k1iC9gBrRDo7e6zJ5eG3LsAudMnacraO2pafIV4bVQfppYso8/bDOhTUNOANCP91AC6NsEYaCxadouzexatIaz3OFbOyhq/HhOT28QdorbPo6oCDVlyZH7d6FpFhFH7GbpHTmmmrtT0Gl8NWfCQBr/TRxdU+ctkrfIWcwkNBqGmUVWn655rGIAwzVVnV4sp12I4A1z7GtWXaAlm1dFgpRbrPRgdcBd6wzC3H+kExKO06Xhwho8bVUDwpNwoUc+4VpQ7GWFljahnpJsIKLR10+liEsMKmglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxQYI1RrtgQJ0nq25GzKNXsxxKZL+DSlEPaCJQahQc8=;
 b=IoyoqMBePp6a+3gQg8qCCIKfrjRy7Um35WxvsC+/cQp+BJOswj71bk+5jf8lnbaCyOiBCNoOZmksKXxbSXeOVHj3RegWy3GGVTqbmvIpEc0EHKfZCqI4lbBcC13Z+4J6TDI+RT/I4hXbxbRTNa6yfLbka3k8eD4y/XV2LvRAtJYgxXM54zJMEU+Npcw+3LBICNNeebI7dhy8cZwJ2Y+XD299hTnpULuCTVl5K9YQLOew7EL4bZyA1EyoUg+7uSgMERJh7FIooX2wrT/pryhO7Yh7WE/u1qko4DPBHqB2minsFaC1nHS+ig0kc17mfUUm+CuXVXBHbz40giIIYC+bQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxQYI1RrtgQJ0nq25GzKNXsxxKZL+DSlEPaCJQahQc8=;
 b=D9Adyku9xxWMOPtTs/H31gykrzLGdq/PZZh0rU/dotaWbZCkI446kw6yAPRhoBwJVZB4ZwtIN0yf/j+BESGftxBEt1q8DUmWc34t/O5j6Y3dOsONIbu0uvb661bkqec+1q7vKbytFHWVzht2DuTe23kgM4S7XCRelg/aPcxxWeI=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SN4PR10MB5640.namprd10.prod.outlook.com (2603:10b6:806:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 17:11:35 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:11:34 +0000
Message-ID: <718a0a43-40b2-41a3-98d5-dc2eebb41681@oracle.com>
Date: Tue, 23 Jan 2024 09:11:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
 <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
 <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
 <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:510:325::22) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SN4PR10MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: da2c9967-a074-459a-3157-08dc1c365a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPKFOFvEVXh2SpX9+1FirS1wUoRpI1K2jimUfw0pImAD5dEkTOBWGv3VGLxOsUxopCm+UsCo60JxshNrUS5V9XbNxoCpCd5EZTKXfTIex6zXKfGIZ3eWAeiw0W1FTRXTsbrdzDrY+RNESdJ+eEyVzOBiLtFGbfeqXi0qGm5ky1OfWEuQBwZVQNFisME854sCu4/+CEO5/9fyj/AcaL6qEHzXkocE4e30XIKikXNFMTJbVnIuRSTlvTiwxENdzSc5y+zb9BZ85C8nDWZtrL/43O7b/Mcab00R71h1FyaKSUTUJJjgnBvM+wVAdCTUGC/Ws1NMDzEQkt4o5M0m/yVn5dS5cN9RUumWZEgJG8PxWcupVEt8ozUHBx41+0XzHBOBPMl8NgPufCBRywAR7iUfbLWtCbp4mIajgmBIrba0QRZcoKlGEA8cUC6ciN0HZL+tCzPa54btGaCenpaPzm2NiSyh9Hkhmii2ohwbfwfKBbmdqib9rpS3QXj/gBgMsGDoTv5vUejDNczaYVWUhe+jSc2JUvSVS3LiFeAmumPatxNbE3FMHA08KY8Ye7rWZyS/EzYosfaSerYxPmjCb1R/JEzJ5vl35HU0s8a9uMdOtoWwkwJJmalJIvkUx//Kwop+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(8936002)(4326008)(8676002)(86362001)(31696002)(41300700001)(4744005)(36756003)(2906002)(38100700002)(5660300002)(9686003)(6512007)(2616005)(110136005)(316002)(66946007)(66556008)(66476007)(54906003)(31686004)(478600001)(6506007)(6486002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU5NY1ZlN0gwYnJUWHZ2Z2JVd0xxTWxCcklFa2UyZ3ZZKzRHenhIZ0tjbEVy?=
 =?utf-8?B?M3JMRElmNjR5Mm5KYm1pMHBTNnZuR1ZrYXFkU0dINWFJZjZKcjk2OXpnTlVn?=
 =?utf-8?B?cjYvcHo2WDFHQTMycTIxdWF5UmJTR0lCMm81YnQ5UW9UeUJnWStYbXFNZkZL?=
 =?utf-8?B?bHFHU0hHWWdPdWFhMHorN1BwSHRRcVhLcWd6a3h2R3lBMW0yZThaZG55WHVO?=
 =?utf-8?B?bEFRV3BTRGR4dFoyRG1wdUFQMDRHR1BycE9PUW0vT25IVktoZ3VqdnBvZy85?=
 =?utf-8?B?eTdRZmE3azU0Rk1KTTZDc200MWV6YVRNNjRHZTlXVkV0cnlkeXkxRXZJUjRm?=
 =?utf-8?B?MmQ0K2Z1NFVrRklTMzNMUEZOckIwd25EbjBmaGdFdXlNekg1dG9tRVgrc0or?=
 =?utf-8?B?ZFVXVWxQdmJ0L2Y5L1VRWjVMd2pJS3dleFozMmZpdWl3V2d1SWt5N2NpV1B0?=
 =?utf-8?B?RkdCZVp5RmhlamR0NWRralEyWjVTclRNbHo2VXRhUWhKSi9jc1pTckhodUUw?=
 =?utf-8?B?WmNqR1J3NlVuaGF6TllmODB5eS9OME1tblZqVVlRMXBtdzFLYmQrTm9VTUJU?=
 =?utf-8?B?d05nOFNTRFV1ejdueWxMaUIwa0h6QzQ1eGkyellIdHIvazhUZ1Z6NndGUUdG?=
 =?utf-8?B?eHhwdnptNE5zZ05KYzJ1NTAwS1R2S0k2TmVzNUNGY1BVWUliLzlCa0NQWG0x?=
 =?utf-8?B?cGJVU3p1emlEY2VYYlNHLzZqdi9jeW8wTjdkM0M0alNKcVVFN00zdituOUNy?=
 =?utf-8?B?VGF0TXZ6Sy93TE1TbkQvc2Jway9nUUlhV20rWWtKM3ZkNnEvR2dHSmJ0UTZC?=
 =?utf-8?B?WmFFVkgra1ZmNm05M3FJcWpSb2RWa2JPQXlrc0JzWUJsZ3R4L1h1bzVBb0hT?=
 =?utf-8?B?YmdtWStyTnJMNnVtcCs2VXpxNFB3NnFwbEtvYmQ5MFAvb3FUMGYvdmdmR3R4?=
 =?utf-8?B?NEtTZlpvekEwT21NdEgxKzZLSCtUN3dKMDIwcllwUG1JUWJmdDFVOWVEOHJy?=
 =?utf-8?B?b3RDSzZGQlZDdHBRYURmWU1zckdPbFQzMlkrdTRKM05FZEhPZ3ljQmNrMU4w?=
 =?utf-8?B?NGh6amhZZlhYSHFvOUwrRGlYUDFaWlhEck12Sk9wd0RHdlplQ3N1MTYvbzBu?=
 =?utf-8?B?WWoxR2JoVTFBMjFLd25valNYZnlFWVZLNHJCRkcvbThqQ3IwU1BmQmJHb2Z2?=
 =?utf-8?B?bFU3b2U2UnBnYzVseVpxZGJCUnRya1drRE1wQk03ZWhOQm9JcE1La25uSWlW?=
 =?utf-8?B?OVFrWnVFL29yTzBXa1BZb1IwQ1NvVHlBRWUrb3dhZ25pSlNLSkRtRHIvOTc5?=
 =?utf-8?B?VVY3U1NUSTlTSUJ4ZTBGT3BJN3lvOWNjQ2Z3SDhHRmg0bFlLbnZ6Q0lEQ0p5?=
 =?utf-8?B?Y1JWa3h2cVZPNE85NUxYdThEZllWUmFIbTV1ZEhOczZ3azJWcUFnODdEQVUr?=
 =?utf-8?B?ditQaDhzRWVCZDVpZzV0TUV6b3F5bjJjWmhMeXg4QkQ4eWl6bEU0aVkzZEpG?=
 =?utf-8?B?dXZEZm84L0JVM1FZcnRHbTFGZzkzc2Vhc29pcDJpSmJoK0lWc3M3ZnJ2KzUw?=
 =?utf-8?B?bE50M0dvYjNSR09SS2p3UWZpVElGVFhTYXdJRVJwQndaUWRrL3Rwc2NxU2Zq?=
 =?utf-8?B?VUZEdTJueFBucW1BMERUYS9xdllsdjZTdXRQLytZOEd3K3dDZy9YMXVqNTJB?=
 =?utf-8?B?a2xteXdzclFIR1FKRUVHQk40bWJoaC9VcjI3VUhVbHl4eVlWK0hCZzg2d2hW?=
 =?utf-8?B?V3ZnallMMGVtR3hGQ3JSWWgzQ09SMDk1QWovd1pXWkdkT2w4eHB1WXh0VmxO?=
 =?utf-8?B?RTF0M1FXNUxEbmtzUkRDVlpGMmdTM0ErbXFWcWhBMk9rTkhMSEZrOXJVZE5s?=
 =?utf-8?B?V3NIYjJGQlRtdXh4SGFyc29BaUJPZy9KRnlKWnF6QUd3dEJ2YnphWHR3V1Zo?=
 =?utf-8?B?SnVDekZmdllyTmZvVGlBMk5CQ2hNWWpzL0E4YnU3Y215eWFZRHVtTkh1VVlT?=
 =?utf-8?B?dXhFYTFQUG9NSjRSTnJFcHBQTmluN3U0aEd4L2dRaDVvY0ZFY1dRQVkyZDdy?=
 =?utf-8?B?anBOMjVscDdVbmNkMlY1N0JndHdSZWZROEE3T3F2QkQ3VUdxY21jMHo3ZGhX?=
 =?utf-8?Q?yfA550z5qA3nVvcmsxTm00faC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pIRZL4RalqK2+TlMpogwavyFzd31wd2HNCA9N05yUjcPSfnPsA/McBBuGf/mMzgxHr8YBYlgeosHY//xCZuF/e9XEZG6hcir4mnT0HA3u+TzyjYMkMtkTVzxHfaVS7B5Bxxnb6USKVGmT0YMS17fo3n9ppkCviAjUbNLRh3+exWiuoHHGJM1qM5gSx+08ThVg5/2t8qy7XWvoYsMcqeoZYMy9Nk2BOXmGZ4SnHlsMYJNTFX/Xj36bvLVDvWuhwmxSxzDF3CiSCwmVlvIA4/3Lf4e2SLE7uB8jKb3BNqXTcTmKFsv6X+tDCqFK/kHd7liIOR2Hn4k79KOTPkqOJu44DRRAMo1pDHGQIowMAud2Oyr3+es7AB+Zly/ySYGpe/XNbWEbcZyQSl+YKXOR22/6KnxygycdymmUTzcVQjcpLrCbIHbT714brV4yLP/el/AdjRzLPjWTqUPToeHSFNBHPk5jYm7M3DYlpzzdPqgS9qGs2cSt0tRv+58qyouQOzLn/B4uVWd8qId7lzdGNwaOWAZkFM8voG4tshxQDAr+l3z8YPh4Ezr7vmGbGHfJac44YyRCVz/YV9Ld2soIaSbGoG69mOVSmLojdq8tNaza8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2c9967-a074-459a-3157-08dc1c365a35
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:11:34.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVOfxd7N7elCLTCGQmQqok4m3eFdzZIFSSRTFwnCF8FspOFhxFWVwW1Lpjo69fEeDHXrRFhLF35M0F7mVf7eYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=724
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230126
X-Proofpoint-GUID: AYYcFRXBmc5gKTvzizfPK_rsHGrJclIH
X-Proofpoint-ORIG-GUID: AYYcFRXBmc5gKTvzizfPK_rsHGrJclIH
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_091146_938702_BD277A4F 
X-CRM114-Status: GOOD (  16.76  )
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


>> This allows us to get the ctrl or ns object associated with the struct
>> device
>> we get in the sysfs, then based on the device class we update
>> logging_enabled
>> flags for either ctrl or ns respectively. In nvme_init_request() I use
>> ctrl->logging_enabled and ns->logging_enabled based on admin or io cmd.
>
> I was asking why should we have a show/store that operate on both ns and
> ctrl?
>
> Why not have a show/store in nvme_dev_attrs and a separate one in
> nvme_ns_id_attrs ? Then you don't need the awkward is_nvme_class() ?
> the ns attrs can access the ns in a normal way like the rest? Or am
> I missing something?

I did have a version that used nvme_ns_id_attrs but didn't think it was 
an appropriate place for it.  I can go back to that.

Alan


