Return-Path: <SRS0=yHGa=PY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8DCC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Nov 2021 03:23:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBD560F39
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Nov 2021 03:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BBD560F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BlYGAjr4v34KOGSPANDyncafenJ1t655vXkFU6pO4Sg=; b=1aAlIK1xWM9hjdAVBmbbKvx13B
	bqID99lwLKZHLpwVBhPr7XTubpyuUYmSK1pJxlO4hnmZDHy8hjZqbzbRRkAmWk7/vKnwf1jN87+70
	BzvCkIK8hFVianiVrfG6qWx5QbhSOAdYTPeBw2YPb42gH40OLSgGYK+3zhvssghiVJXpBqTSRUulP
	I9hiDZfZZmCLb4rypXAaFKCcXGcLlG0eHwaQ87yOHnXjT+IUnXAhJVruPo8/jDE3n+9lx4ADIslMP
	kW0LhTkBgeUbqVVWZ80ZldhJU2F9+cEdgX4EL5klESWzyUl+TPyLIveF2UQIqXidOHzACSUNR8xJk
	0VQmGQOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mippT-00AUSZ-N9; Fri, 05 Nov 2021 03:23:47 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mippQ-00AUS6-Qh
 for linux-nvme@lists.infradead.org; Fri, 05 Nov 2021 03:23:46 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A52jY3B032448; 
 Fri, 5 Nov 2021 03:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BlYGAjr4v34KOGSPANDyncafenJ1t655vXkFU6pO4Sg=;
 b=TxWVhfeMfAft1hqQqBOHqkQdjXuYYoIPfwH8UoyndDxXQiJmLMHp1ogrhGG+++9uYvFP
 ToEnKoovX34HELD9dW5Yt1WxRhuMa5APCy2F0kJaC/C1fN3mdbHtbgvs0wa+yBppPJv9
 AqfBznEcXCVuM9rgxJL7cKumnTwt5/edGv/xUxxqEIZG7ITwafcBO7uwT6VcvmMIyoXx
 HzdaADUX27jsvwnGLjwo5OMAIHYoTqjuSqehIW2CyETxDrpvpuqVuK2NLMR1gODenf3P
 5cvkChkj+JGlU4MLgl4eFOJ+UTLIrT6N73GYX8JjVxYC4pl/DGiqKj4J0vN/U3t5FnCi yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7q0h9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Nov 2021 03:23:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A53Fk31005725;
 Fri, 5 Nov 2021 03:23:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by aserp3030.oracle.com with ESMTP id 3c4t5n54ku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Nov 2021 03:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXR3bGWxEO+vgI+suRq49MpsgthoJFRHwiVW4CbeXofr9l2FBJ9TX0dCBssZGJ36oV+DryP5kZ0bpymc8TO3YQ0/JRRx3+EMN6nbPJmL6iyil6IchX96u1azhT/mVLXBz5RQYopX5qpn4e4tGPkQ6YLQL0rY4Z5NlHXybYtx94zUCR8tKveXnozuRPboUSiPxx+eRDa/8s5ODze1Nib8tbbeifRC6fK1XGp6Jl2aBDYOkwigRvGSQwAVfpzVIBa5GnlhU/SDAAJpq9C7B+DtbNCJkigzeOEte5ONEM2eH+haagcAYllWrU4V/+uBN0kXrLK/fD++j/oS3K9rQ2uNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlYGAjr4v34KOGSPANDyncafenJ1t655vXkFU6pO4Sg=;
 b=L0ugsi/bkbwalpq1LZ8iU0Mlu0EmTnGtWdMvmk2UGS2U0TE34rFw4i0/q8iaK9FFxxmqu5U5kaP+1SL6FR31uPYU4vu8Yau3srL4GSfIHMuDZFLciL8WEEno52lb02zKMzDR+5wVp1qxoN+ILU+LRH1jEMhqrvJ2ipB0NMgjfdnsEoGlCrm7AMnNk12MB2A3OaC7u0jDhZxu2KfMAryxo9DPdf7HROjg2TaLXL+oK0aovly1CCHzWu0Q2KkUv0AZOoyqoBjiPEB7AJ/BazEg1IA0UzAs6Gnqyn/x+ATbrQP2Vc1mY+8M6DoDGynWzJkUtvIvzNfZPh+Igl9gzTWlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlYGAjr4v34KOGSPANDyncafenJ1t655vXkFU6pO4Sg=;
 b=cV9EMX99M7tIpJrMcRxrTOvSiVPpouw0fGr/RDVu4ZdHUxu4KkXK4LIrIEA2QRHtizLe4UOuLbAewVYj3/5hTfLWZ7brrq/SB17wipXSjfTzWNNY5NzX0O7X+7D/AmHyAR4AKvL0ik9//XhdieWuu4t/uUWoLOOkAO+JfCqgSSM=
Authentication-Results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:f4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 5 Nov
 2021 03:23:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%8]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 03:23:27 +0000
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org, Klaus Jensen
 <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme: fix write zeroes pi
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq17ddnp9s9.fsf@ca-mkp.ca.oracle.com>
References: <20211104181618.864157-1-its@irrelevant.dk>
Date: Thu, 04 Nov 2021 23:23:25 -0400
In-Reply-To: <20211104181618.864157-1-its@irrelevant.dk> (Klaus Jensen's
 message of "Thu, 4 Nov 2021 19:16:18 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.40) by
 SA0PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:d3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 03:23:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1e52aa9-103d-412f-0355-08d9a00ba1fd
X-MS-TrafficTypeDiagnostic: PH0PR10MB5580:
X-Microsoft-Antispam-PRVS: <PH0PR10MB5580A9DA75B14F8D3F29D4D08E8E9@PH0PR10MB5580.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvLMPJ3z+MerbG+z7DgOfTYWK4BGpAppenHQzqBzy5lDCC36gHUaR8M88wRsUjFoUrEUlTojwA2zFT4v9GfHujx9H1Of03Wd5RsaAzTuj5kD3P7FhLjM1mpx4yC24SuFZIraKZP6QAJrhaKuWwVCY0pme5oEuBOwC5TPvxg8iiKtyTmqQP1bV8q5xfJj0UUT43IZYnieH/NjPuUz4fbaaDLhW0CAxfz7asl6t6Fs9dwnn02WVF87IbH7ecvwdr2iiRaB10mDmUymXKj2HX7zUxsUNGI3K1kMPX45+jdQxN/ODwPUsHPETwvgyXDb0JEa0WEaFt9WalcgE21GgjnZpF3PoZ7jPHgfnWqZCpJQDh2hArT00MLG6nOgAozRNidsxcAGRE8/gnPik/wlWPwPLFwy0sDyRU9RRLV1Spq0F2ejr7o22jRbZu6P8t2fSj2lKeCfrOwgPSgaVzJGcdOg6W+KY0ELBWonRWiBxLR0Dk6UCPg8iWbgB1TzL1TPPoSbHTVs58ukNGtSugJZy8oDqGr6SWEAiwrkT1+IHTLdMUyeyoEpI2ZLZAWlnT7B0VvBN1mhrp7Uzp11BjHz1LRGhympKpK1fRhVuALyoTKYfdh3Ro73goO1Ore9hMdvEt1Q8PSNtRyznq7TvXapAHYgcCY4LYo6RPXuKDe15VIs+6KJdyFrtFou8mTbsY2Ofq9nhhWPYC5lTXgtw8Gzzm9UzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(4326008)(2906002)(316002)(508600001)(186003)(55016002)(26005)(66476007)(83380400001)(5660300002)(36916002)(86362001)(8676002)(7696005)(6916009)(956004)(54906003)(52116002)(4744005)(66946007)(38100700002)(38350700002)(66556008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b3HkjOwstF7Mmz2SBwQxKVUL7G15yQBawMyBpPA3W4dP4EdJ+tqh8jK4GAA2?=
 =?us-ascii?Q?jCOSvRCWHarPy2JqNiNUCk3hwF3M1yicR+smJTn2WRVW5u9JVQuBq2kwnQGO?=
 =?us-ascii?Q?FZhvuGrUyFDdu4Xx57nSfzfKMJAmBP0UXcDe5gaGSfiyGs+sCjV0ME5EXZ1f?=
 =?us-ascii?Q?oXzKVjpKqDrJ/O90kgBOC4Flj+QCVog4d1VfKfsek/Yh3NvMSbc9cQjr+LvX?=
 =?us-ascii?Q?GwNGUQ3xDoIZYWZzGEGjhoA0Xx4bjLIKMKGy2WN/mMgIvhp3cZY2M21o5oQP?=
 =?us-ascii?Q?NTb71DiSqVg7XDno6is8tx/E3P5qu1vHVwJNPuwDFc07W267mcwez6YHF+7V?=
 =?us-ascii?Q?+02mw0GfLjtMgAu1+3oQnzjO76KiYlM37+ri3BDYfsg7oMMpI4M/dOXPnUkv?=
 =?us-ascii?Q?YZk/inMyYlQTxRGp6g51xNatgCMbouuPhuryYjQxQ3ExKJX+xS8c/n0NZSXy?=
 =?us-ascii?Q?VbJ4DOZzJ/VNs8qz34Z8tomX8zq4aQU46LpHY8qT6ZR73I1fLGG7jApYhw3a?=
 =?us-ascii?Q?w9SYnhfwYFl9gvCMpM4vlEfKmBSXiZJ98B7Azohc+oHnE4dvRc62ndAfUeMl?=
 =?us-ascii?Q?dxPTp1KtW6CuUxP2daorgaMK8AmvVp45U18MvHRalvhGIZkypz4CtIGjY+5k?=
 =?us-ascii?Q?7L8C9je5CYSNVULbB9/E1SPRIcUTqiUpxRy+w60l69wnEIEPzzKGkX7Gq2nk?=
 =?us-ascii?Q?GtvH3ASqI/yT1gf1BNeHIxIFI6GvHxKMuaQmUDL9Gj7Sf2QJSW5Z/V3T7eQ6?=
 =?us-ascii?Q?oZvntfhuIuKDEvpUJOnG5ytbxWQqClXcuQFdQzid5XOI1lK2zXfpaXyXeyIQ?=
 =?us-ascii?Q?2td29UiZFSpBG0vX7FgziNCljKw2eAvB84vYElIjz7qz/RIrMaPSAmEAbJoo?=
 =?us-ascii?Q?aF/vcJ0zgOyX9AkkjwScTq8E6PqFkKVBSunfsmw6/3VTxv9M5HVyxE7lbkwr?=
 =?us-ascii?Q?zh9fb+Rzoh2KUSgnzLOcSmsdLjD3tQXxbntdXriZ1m2G/9Pzfu+m6NpIUY9r?=
 =?us-ascii?Q?J4zQUp1GoxKMPZHJcXXz8hCxhEmVPEC8KM5xHz6httHialYtS5weYoyiySyW?=
 =?us-ascii?Q?SQio9vDEmSrTOzjwgd4RbMnULzNQ5fRXWLDekco3+S3xhjrt7oJTiE2AiJm+?=
 =?us-ascii?Q?6Xz5PRW8iOfjWCDSwYuGDYpTInKsaMpW8eCSvqLS2avduzHU85458jGdzJkj?=
 =?us-ascii?Q?jAnLKgWZOqAeIpV62kGcCSHekcdSe34sl40KEHrt44uVCNnRmppQpVUSo7Tg?=
 =?us-ascii?Q?8nuAVkTqEPM9O8HEvfQMVNcWFwNKbtX6Wq+9lBZg8YfnFb8gn+CPomMn6xF0?=
 =?us-ascii?Q?LWUoP+s+90b2OIzWtHH5otgGbrzr25GKMlcL11tUQsqIbeJIE5gxlxZA9DLV?=
 =?us-ascii?Q?rKWI4N8h0lHhQVMljnUEVmTXHA8XHtPFclLHa5aofoig85lcuAc4gj49VNM6?=
 =?us-ascii?Q?jMtTcpwh+0YFQoTcOlJQzdw0PNRlKYgK06QS1LmRapS2JKnSArttdQVvwoZt?=
 =?us-ascii?Q?CvQGVGcVouCGW2Mly2R6YsCXvqr+uXKe1u1YAua4cIYT2Df286J5aRhiCyoW?=
 =?us-ascii?Q?K1xoHjw/N62yobj+UN5QCoCRUKXMbJUBtK9EVUuvdoAAzG5sTiF3/HaU5cr0?=
 =?us-ascii?Q?lBWcXDnVIWmh5+eBn6fNJ/ipBv8zKpf0Y0pzzNotvBVeKayohOscxGij13p7?=
 =?us-ascii?Q?q+HVEw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e52aa9-103d-412f-0355-08d9a00ba1fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 03:23:27.4305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJJkXMbPRYRizFbGchiIi00X7qEZlFqSzDyv+OMVylcTrWEdl3IzuCv3EX7F+EKTgx3uzy2MD1S7F6QWam3s/OklAx+XtORmd7Iv07EUPd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050016
X-Proofpoint-GUID: 6fGVw4BsZ1zsUgT9Xf51DgOLdI-yjxLy
X-Proofpoint-ORIG-GUID: 6fGVw4BsZ1zsUgT9Xf51DgOLdI-yjxLy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_202344_916602_5C39EBB2 
X-CRM114-Status: GOOD (  14.50  )
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


Klaus,

> Write Zeroes sets PRACT when block integrity is enabled (as it
> should), but neglects to also set the reftag which is expected by
> reads. This causes protection errors on reads.
>
> Fix this by setting the reftag for type 1 and 2 (for type 3, reads
> will not check the reftag).

The NVMe spec now clarifies that ILBRT is not inferred for Type 1 so
that looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

