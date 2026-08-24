Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804DEC5DF9C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 15:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izmxYpJzFw55KGp/4A5R/yFfeFseR5hm1QLfum+53gM=; b=2QjRNuSdiPMo8sbhubMBvJumCZ
	2wAcaskjM1KVgirBXIRo+g+QZc+8zqwMvL0OxejYyvswVHadb+2Zv9mcx+WX0e4v7HUdLbbj5aH6W
	ytNkxlew2w8lZIIQaNc8uqH2AwiASPh6FJDu+ezoXDcahiU1MUQz2InfpUT0txCOznlWatFUhkz+v
	nbyYKAfuXcur5JkgwkW7yqEizkhf2K4NBHufoL5H/z+9mIaTvhz2W37VxB3hEXiLmgJtULOywOvgo
	POuFUuSlvkSUS2sm745nXz/JCoq4A8PJ/jiSGWPIh4w69cfG3gobqniwBfwGeyBG0Tu1Xx+smeSTA
	JrOSr7Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyX0M-0000000Gybm-1EUd;
	Mon, 24 Aug 2026 15:54:34 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyX0J-0000000Gyal-0Vyq
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 15:54:32 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ODfWRf1599639;
	Mon, 24 Aug 2026 15:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=izmxYpJzFw55KGp/4A5R/yFfeFseR5hm1QLfum+53gM=; b=
	gZPVPCqMVp8Zs40X7RS5UURAqSgweXGPY6hY9t8kIIy67v5flr31r/1ses+NXPe5
	EqrqYdjxk0XFb3OjvZl4ze+1S2vAkPOyXcbqKHDRk4T1z8J+79j7AKZUUYu3z3TD
	X5ak/FwIj0pe7hmSsJt3B36XgqETLjUvypC5FsCKgVecyLIwIk+PmhyHqBR9f6kA
	1ld9sKqltwQjEO2sb5ZO1LptMs7MMBmUw3KX+iPme40nIJzahQ5Hd6+XDHVGmab0
	gaI79HjRjJQHKRBss1Fw6VBkjt08QA1Kype/DY2O+gRDNTzK3S8oVTHrSbR57u6V
	gKjvPSpkAHsXCia6mIi/Bw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g73n7ahaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 15:54:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFsD2T032493;
	Mon, 24 Aug 2026 15:54:24 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g850tqdux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Aug 2026 15:54:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iG4sklfZRygqY1K2kkiP4tYFUdppqvK+6PxRsogM28vG8lcBDFwIIlftiAVKbdxiHJaxH3y2zH/NypATrjjHj4AT31s3kc1ZTI6mDO1hHjpp2MpV8epygbT6Qfi+Q4A5FZnpelqzWTS+TIa1yzrAEBgU7DI+T8jUQ3vUlRvRdY9LNHNeOeshAFft9MNe2J54yrZ5olrhXvJg2nny21tWsch4uG78nM4OXQzbzR+2Dc8FtHMWhBsVfK2XhuTEZkcrP0jWOm3NbElAuwzn0hTXvifw4qIFHx8cuNUjX+QrcngWbw5JVB9TA6F/1SZLgt98A7e/CZeb+T0gs/2TZMdWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izmxYpJzFw55KGp/4A5R/yFfeFseR5hm1QLfum+53gM=;
 b=ToikocP7Hio/nvj119s4fe7gJc0nkBba7qjvsIxhSz4LHjXlgZJe2E9fMvBKnkPbVUvo8nC1wtC2gjnVg/SjHkd2vYFrcQsRrjXjabdIXt9bh9xIBRGe7YE/Scq9ep0ioIEzLGlOdofikbbd0OKPNQ8wYKnN5PwtLsZy/Cu/pVk6F3UzqcMeWKsezzypQFfIlwP+bTxLS30DzpUuDIx4guHqgJY1cAMtxoel/49tynq6ZuZQmOmbrJxz3cvTldWFO05zNlB7KERuAUnHFJmCRrXEm0FvfiHdx1HHnew2cvvdGHy2cisNMm05fyQcCoUl0NVpUv8Dyf3afyj5X+eFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izmxYpJzFw55KGp/4A5R/yFfeFseR5hm1QLfum+53gM=;
 b=z5csbAnI2cZ4/jksAdJRjmRwCuHKjwURRlE0LnsMJzMRH8T6J/AfgcTzFZTBtdL6FsbAuEd8C3ZYvARv9o+JKO0MtNNtJBki8804vcXzeQ0ZZofpeLdj8rYTdDYd39AI6yPkwJYbNaeCQwq0NRxYcT6k6k/M6RlsXDbiye4TD3M=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH7PR10MB6673.namprd10.prod.outlook.com (2603:10b6:510:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:53:13 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:53:13 +0000
Message-ID: <dadbff9e-92ae-4301-91a4-551fb2f74298@oracle.com>
Date: Mon, 24 Aug 2026 16:53:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] nvme-mpath: No need to protect req->bio with
 requeue_lock
To: sagi@grimberg.me, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-2-sagi@grimberg.me>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260823084903.193188-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::21) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH7PR10MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 971f7ab6-676c-48df-5815-08df01f7cd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ySaEkZbsmSxzYUu9UEzPkUkzJ7suYqkAe5VMVtqZ36DqglqQsp+R/CpLYAoxyDyXA+sTMIPxdDfdDDYKDVSlvuBtIO0Xdv/GxUTPBIlsFFXYDhn25u7FFyuKP1ENR90qEvNaP0EoPzc58T4EX+kjl9rmJlYteU8256X8F66XPbC5iX/Cjy33aLNFH8rQG4/6BZ71rSV5BSUguu8mzAX13SqfSpuj6obq8VxhPERQenNCWAc89oVVwfPaeJIIP4l7y9geqXDlkk+d3Oe2IsuzDSS+rUGGfMhh/tK2LwLzMyxvQ2bAF5R03187lIhMJL4kCuPXNnRQ9ikEvXsIfu78l2orL3pWebCUcC9qMnAfiJaOKWeZ7XzK6SbKmSV+wba02ADu17cht/By2b8ZSWM38uQ14WZFi0MFleIOToZDic9dyuoJT35wtihPn6tN2YFFpnPG+MbJEVfjN64GFtY+oJ7enWUqdL3BUDPlnln6bafzdmhBIIcTXlZyVULLzRAPJ12p1qIm3CZHLiUXGiZISokP9pdzMYT20K/HrN8GzhsiNV/3ceBaywqrdeU4HXheidLSJC98WM3S+fLPgs9c9KSF+mgdeyo0X4AwTjAHEJeDiBwjmz5PigYYRxGu/SKiA31bDr6B6DE6bFMMQipEliO2zoc7icpH3rW1Q6u9WF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkVoNG56cHZ3YXV5OGovekxvdWdmWHV5NWsrQldUTldyNEo4SzUxSkZSMk4z?=
 =?utf-8?B?SmlrUWcrb0hia3daNjRlVnY2bWhFdkUrZUJnN3ZmY2l3M3hMcGI1enZxVlVL?=
 =?utf-8?B?SFVOeFB2ZXBjTUR1eDFtcHhMZ0V2QzRIaUltelIyemtQRDBEZTJwS2pEWWtw?=
 =?utf-8?B?NGUzK01MT3NoQUtZbzVMWU9HYmE4SC9wckhEcHhWVUZKV1RaZWhVODBIc1do?=
 =?utf-8?B?V2tuZUhTWG0xdUQ3UmJjQW9McERYZm9ReExmaWxGOSt1Rko3dTZ0bmVQb2F1?=
 =?utf-8?B?RHN4NDNlSnVpYXM3WGRFTWRnNjhwaWYyem1vTEExQkVTQlI3Q1lDZDJyNUJz?=
 =?utf-8?B?M1VtQVpmeTVtb0dlT1dScTc0ZHJ2b09WbWtEYnp2WGNOVEdYbDRQTm1wRmdC?=
 =?utf-8?B?RjF0d25LbTJwbmtaWGV5dGNONVF0c3d0aUZ1Ym5ZVHFiYVZQSXU5aklNZzFE?=
 =?utf-8?B?TXE5NFBLNklIbUU4REFTcUpYMm9pVGs0RExhUCtoTkxQL2FPcTFtL2RINTBR?=
 =?utf-8?B?QWVSTHMyeFNSWUtwOCtkNFFIZHdDR3FPQ0NvQUErZkRiTUVOSDFMVXpwZ1RK?=
 =?utf-8?B?WGdPUzZoSjEwaVNnTk9Gak0vMWJKWTQ4VUQ3d2pib2JyMk9Db3ovQ0hYVG9C?=
 =?utf-8?B?QWFjODB4RGJlUzF5WWtGQ3lMTHVZTktIMmtELzVSb0kvMXV2aExWcjk0dFNU?=
 =?utf-8?B?c1FuNVNTNm5NRHB3YXpwUXp6SWJjVmtOQjVDWnFEUlJtY2lPNmdiZ2pzVjhX?=
 =?utf-8?B?Q3R0UmFLeVo1eXh3YXBGZ3hCYnZ2c1FJNWZIVUc0NHhkQzBuNjZZTnpwVWJB?=
 =?utf-8?B?aUQrdThqN1U2MWRMUm1CV3BRcnUzWDR4Y0NDbEVFWFdiSGF4WkM5anRRYmx4?=
 =?utf-8?B?d1AyUndWQnVNeXNXUmhpR2tHOUptNTVQd2ZyRERweEdWNjROSGNXQVR5TGFo?=
 =?utf-8?B?aGlZUzNWN1lpUjlBTFlaQ1BOdWt4YUZJck1DN3NYV0ZFNzFiRThnTVFieFI1?=
 =?utf-8?B?Q1JoUkhBQU1ERzJURlVpYk1LWE9GT0Z5c3dTTkZmVHZqZlFIMHlUVUlHZ0R0?=
 =?utf-8?B?cWJ5M1lSZmxuSWc0ZXBRSnY1MC9CUlphdklkK0xtbFlZZ1pkVGsyZmJadzlW?=
 =?utf-8?B?aHVuUC9oWVFkdEtnQklwRCtJdWwyMkloMUY1Z3kya24rZ25tVERxSnZ5TXVF?=
 =?utf-8?B?ZnFDdU42RXhheVFsZ1oxZVhFOGNqNzQ0Um9BRWQ5MkFUd0tHWExnSHFnVmQ4?=
 =?utf-8?B?dE5rZlRtSktWa285WW5IOUVXRDJJYnkrUUZuSTBTNHUyLzQvMU40anEwZjdv?=
 =?utf-8?B?dkRzekh6OXlYWFdReC9nNDBBc1YvOHA3QzNFUTdjcEczbWc3aU14SER0bml1?=
 =?utf-8?B?WDFRMG4vQ1NaVHpXMW41MnJnZ1VEdEMvd2ltM3RCYUI0TkVLR3VhN0ZwYVhY?=
 =?utf-8?B?QzVkM08wT3hkNDdHUndjZHdzdXM1ZEwwa3ZROTJGTFZLaUUvcjFSWE1jVEsy?=
 =?utf-8?B?a1A5N0lTTG4ybmN6WUdXbHJYald6VE1GK3A0WGtsY0NVMVAvWGRuc3lhaUtF?=
 =?utf-8?B?R3lRNFkvK05lUFZOK3pwZ3RERFpha2dLc0RPWkVZRmJTOTdyNlRneEtyek5p?=
 =?utf-8?B?S2x0dkd5UDhkWENpb1hXNHZtYXNDK25PdjViZm5MMFRtcStVYkFSUU8rd3pY?=
 =?utf-8?B?VVpZS3gzeU5WQmpxWXgvdCtybHFzaml2bkk3UmtJdjNJTUxuV0Y0UTBPYWtJ?=
 =?utf-8?B?MW16aHJaYXRyMk01MjlUQzExZnphMDQ2WnRuWWR5cHpYQXlzNk9rNUN3L3NQ?=
 =?utf-8?B?OTQ4YzZWMHVSRHVXcitEMkYzZFFGU1Q4cHdyRVJ5ejVjYmw0UEdtMnNKbk1j?=
 =?utf-8?B?aWFhMDZySHhjLzg2UmcvSTRESUVQSFVya0ZMeHdjL0pkVVZsRWU1T2VMeGhB?=
 =?utf-8?B?dVpLZlM4cDNnZGVxcUQ0TE5BN1VZQWlnUzJpYTVBZXRJRFRYaVpyL3BrYWlG?=
 =?utf-8?B?NDRpUXdjQk5XYXR4QW5zdXRQK1B2UE1FTkp1VzdwUytJZS9XVXBlMTdseWQz?=
 =?utf-8?B?aUtZM2FseGxiaUt0QTVKSE91NnZ0YzhJaXJyYU9JSG12WjdIa2IvRWhPUkw3?=
 =?utf-8?B?UjhmTnFKWDFxR0ZsSGpWaHJkNy83MUw4RGJEeU9OUXBiMjh2dWZIUjNSNU1W?=
 =?utf-8?B?Z3BPenFaWDJDS2p0YTJ5U2ZESzZka1NmblhaNkdtVlZNRWRCVGQxYTU5Zito?=
 =?utf-8?B?NmthWE5uUWtVWU45SHRHcGM3bEZDdkFZenhxZytldGYwMzJtL0Y4UlRBdkxC?=
 =?utf-8?B?K3JaU2hkY0hIaWJuZ05yTEszeXNZLyszNHNwVXdzMjZDTFBHTCtFdz09?=
X-Exchange-RoutingPolicyChecked: tfjrR3yGWWC7sFpl56FtjC/O7auknMN/66g5CJk+vtjr6he9o9N+d0AWfz3WWWAZQdWNp76Ks3z0Mdd2di+oMhUtVYQACVzMIPCkwi792llcqSgduW9o07eU69uucmDWgMQjVn+gwvJ+bno1Sx/XfiCHqr0cASLfbZSJvDuQIJ4iQ5dpq6oGLWlHyTjN8Yy4voJe6OHHOOL2wnn8FyWoZdctyY2YFV7pszXBz5knZbjbtMX1yUuAj76yOFEBcw4Sh8/UEu+0PM14oLV27UrehpcGsNWzxvhmaV5TR/o7lR98DsLfrW+1Lk/3MoI49hKU419f7I7J5vbpnBBUxB46MA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MEdD8vYxREN9zrZq4kznUFqHPRqjyx58IzBs2x3Dmze+3LnCTvxRxlJ/yjOMqRZQZ28M29nGU48wHH3nawgPenJp6D0JcysFTuQxjtS3rKEZLN6RIvaoeJpLmmWyjkU7BGL1hZ9TeH2/suWx2dFc/t7urHtP2owM8xDgpVoqeLPqZeGdtOGRaPFAfarNuihxDstoUcBOyrRrzmZdb+ZM7JrVTIoQnD0O5N1CRBorqMqx7ev/NCuCg25dOQpNlBgHqg/7acdjz79ciBFfrR+30vNDzHhkfzJv3TpLLZqehXZpB2qpnIDUktYpt3iHHVP+Pl8tLHZCyMKNK7E0ee2hOssTmqCmMurADRo4yb1BtQcrV0xz+njgQYEuhWX53idgFnhlDLV5puMxgs7NI80HGHFcY3xR+ig3b04Yc0CwZdZF/zUXkmvIRncVbTmu5+264jIojX9EU6utAk0zJndt6adzCn4SbhANyEtMrvD3jQPnqeJfEVxAM7E9iktAI6Rw8lIuMGQNALR3OV7wblP9h5wG6+l75TWdSJvCoJcqfN9ls0pJ47PMqRkyUfj7CJZh2zXw4VPcu5B0tdpA4MHJ7W9SxNF9g+zIk3Prp9zgDb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971f7ab6-676c-48df-5815-08df01f7cd85
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:53:12.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 739XXQh6SOVZgfDi0SQ8a1rHksMXjus2RvE+N+8XM5N1jKqJTFlsWobVbrgtzJrSp9lh+eMsWvsBfcRhdZMdUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608240133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX9do9klJbwlzq
 oUbTM3KwD6w60Rxjshxv629pX7D2J2/Y4nDk4nFqXG/Zhs/7KUvZg+hSoJdwKA3UEKJ7a01B970
 mRQETQaUUKo6sD06t+2jzTHDtasKkd7L+9fXG/6nrmSup5hXXG9Ip75IkEi7ah8QNgKJnnbGHaG
 bUHdMgV2Shvjw1NxxOBqHfwcF7ETzPoV6jvkgIqomH9yuo3cvEIbOVTgfK+AOSHyj4aIbylyTXk
 vTnPn4MuOierVeEo7KMMutrYvo3RCzJwWg2/m7bKURFkYg5MiIyhaCks2LD52jexP1FMi8BZ6Jk
 Z9hlEuegE+pz7Q8lPYTnW79Vxmioy/fFWuYswmNuno1d5d9elvs5Ni9YKtLTXGvWEDCi37JpCWZ
 LI2b1GaehXcmb4LrN2di6Lqs5GrGA8qbOUCQYprSjGL+O1rW2ygCVPZg6iPsWxbgCyTpWN0WIcT
 4dH/m0nNozvoY09AevA==
X-Proofpoint-ORIG-GUID: IW9fLqv5fQmbzyj4m0T0rxUakkIl_WT8
X-Authority-Analysis: v=2.4 cv=Os9/DS/t c=1 sm=1 tr=0 ts=6a8c6930 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8
 a=uGgpzOphiMTjW28eRdgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX8l5BdOKkmtB+
 ETpMFraE1ezW6SzBZwRjMkb+1VvWspFm1jSPnlDMljDcbY+bmtQmtmaa1i4X1QsPwm7VzYoeM3o
 0edlRw8QNaM4xTn4Fb1XCgRj0IcAlI0MIP7tSs8tgGBW3wOrtgHm
X-Proofpoint-GUID: IW9fLqv5fQmbzyj4m0T0rxUakkIl_WT8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_085431_392156_DE4CF818 
X-CRM114-Status: GOOD (  15.54  )
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

> ---
>    drivers/nvme/host/multipath.c | 3 ++-
>    1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9b9a657fa330..b5501217303c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -164,9 +164,10 @@ void nvme_failover_req(struct request *req)
>    		queue_work(nvme_wq, &ns->ctrl->ana_work);
>    	}
>    
> -	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>    	for (bio = req->bio; bio; bio = bio->bi_next)
>    		bio_set_dev(bio, ns->head->disk->part0);
> +
> +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>    	blk_steal_bios(&ns->head->requeue_list, req);

I think that the first half of blk_steal_bios() doesn't not require the 
lock either and does the same bio loop as for calling bio_set_dev(), 
above. Maybe another helper could be added for all of that.

But this still looks ok, so:

Reviewed-by: John Garry <john.g.garry@oracle.com>

>    	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>    
> -- 
> 2.43.0
> 
> 


