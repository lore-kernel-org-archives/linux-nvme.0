Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7796C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 07:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/iQuwXLITl0eTsDSLL4/cWgT5MOEOMLNoq9rPnUbZDs=; b=ahGbqtKHd9WhQMnTXQHHp88LP7
	4PFNXS45l2haMa5FqXJxkT2g8z+Tt5rNiEtqj4z/R8W1no0Yr14myR49r7/1T6Aaj8XnnJofeAl87
	2swD9p9JkOk1cqP1Xd3+dCBYrtZYkje15jfJGnaymp2VJeeK4AtMViG7K/u40XYzRkXwO9vwy3WMx
	+2QmvhLJLubWkPtkXm+XHYvBkoycK7qiLF7516ucQFGR/EIRNsYuj0HRL8Xi5VQKgWKLvifnhpRh1
	+Nt6iSPBkXFnX8UIZZ3r3bTSgnS5y52XmjfJDeLFQqJG+WwLIJoOgn5Q9sbdulMo90NOZZrjF96Cu
	gFtRTNhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weT9d-0000000G8vl-3TGC;
	Tue, 30 Jun 2026 07:45:13 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weT9T-0000000G8v6-3whI
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 07:45:07 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1SxIv3180749;
	Tue, 30 Jun 2026 07:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/iQuwXLITl0eTsDSLL4/cWgT5MOEOMLNoq9rPnUbZDs=; b=
	N6V5pJ44PkaSWvr4VWhjeS9oIbQwpuGBOtSkYzWz5hmLzbejyr1b5MlMrdgtNYWv
	YjHq4Jy6s/RQaSUac05YjZRc5h6M5/Xa+FJMjmTyVpTm0ZZmROMTvVviTfaoDWWv
	XsIKDD8n8ayJbwfu9GEV26sbquKH2lX2C3oRTalt30bUzkhgKshdQhyXUulXhQCW
	LkgdoP4R5N+91uKW93ewQ5H8z3+J/QoQrYoY5QXklwIfLnPLj7ehZ6mJ56vZ6dKp
	JDr+KbpB4fcl7kPegwTWOjp/WbpwxDFUCI8FmVkzHMXW2LfuzJDKFYsxpZpKDrK8
	knqCDmRDVf7nrIQvmm+H+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26n13kqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 07:45:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65U7c9UX013538;
	Tue, 30 Jun 2026 07:45:01 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ydu4xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 07:45:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIqbtbIUpI2noc2FGaNtXPFyWnzyfOflKKduPRGkp5p9996Jmw7y4abIqtXks/zZ1wCAT0k2XknywC6fM3+rtU5J97VTgZXwwAUrgssCnf24BelNsHBUOaNraRnWGdD8422sKXbzkHbz7ob0Dje73kGAg/Csm8rACL+OmT1VWuTvxxv2gsU1Zf8vbYlEFIa1UQDlQvu8ikOCPbNYF/tjPM0x9UOa9cWKN4e17rIlFS+lxrRNtB688mdOXqM7eooNHafNd70BPRDyHk1h7kBJzZoTHidcU/a08dCamorhsd5iIH+LZd3WQpQ0QqSNJetFxGDa56DcgIO1N7W8oHbk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iQuwXLITl0eTsDSLL4/cWgT5MOEOMLNoq9rPnUbZDs=;
 b=jeMx8n9uSi+NOhknL+/FUtxTppA+aIovGtveFSQPDjOnEfoGxAC1NSrBfFCQWyw8lOkRk5Ef6HA+OLtN7Yk3QsoVAo/1bBlPj9wyeGNek+lSFVyabr5fHPP83K2TzZo7xALOEkNu/6k6U6QRG1jNXYoPLGiyXK2eaqlUg4/HFgvGOA2JK0WVfLZHCd4/4SBGGxuA6wWHAdR2ynF2hQCil+fdI8Xxw+/U7SBZAEf8bwWb3MOS+IXFq1cFb1pbnhtfpOd2Q5oYcSBTd1Xq+k4KQvMwo9dK7NdxqsP4OAxR+4vCRMnEhPNH++/PYquPaj6TYgO40KKnFkKXXGQp90daqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iQuwXLITl0eTsDSLL4/cWgT5MOEOMLNoq9rPnUbZDs=;
 b=TlW1ky+Rf0OJLc2FVSElTkoHFazJwFPcxDNo6PFs5k03WlmkGurZ0R1GW779GHLEP9JiQ9ASh1OU+KyYA6ZGkFEwMbgMVqE+g3Q58fHBKVLw3eRd1kP1WiykU/Cnj+A9PA4aC6qiMurAhtARrliNARzNBay+pSLs77IGP4yE5ZA=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 IA4PR10MB8254.namprd10.prod.outlook.com (2603:10b6:208:568::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:44:58 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:44:58 +0000
Message-ID: <e342770a-f9c6-45f0-942a-21baff3fac1f@oracle.com>
Date: Tue, 30 Jun 2026 08:44:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: nvme/039 intermittent failure
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org
References: <0f6beb6f-3d3e-4408-be8d-5ed36cdc2c56@oracle.com>
 <akMhmoaARgetCTJJ@shinmob>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <akMhmoaARgetCTJJ@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|IA4PR10MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf192bc-3ef9-401e-aa89-08ded67b7bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oDi/DLCgjAfMBDF15jEODbbi9bsDV2/mX/TS02mCbGooKHrlmSdI0MM9a++Ygwbni2UXgQaWKo/og5HS51Qgsft7BuEczZJ+zXiqy637y28Ig+B+kfuutPNTyKpi+Wz/8TcQlEt6h5X5rKe44cp61W59c6jUD72mk8OPjIClUv6/jUHdYtaH5eGIQbTY92Jk36AEx0efLOWwyI6qGkks85jZULAKTVSx/Aza3a6UD5TYWy+u57RJJnaDSDDMh9tAzmteSvEhcUCptsOSotiyvR9sIo4vdXNF9U1+myhJ6AJW6xyfvXi4xoixXEzLtBO1l8rUSM9bH1WpZRbVgRo6p6zrDL/TUNaJElG/obd3xjpuPE0rSKq09kD/9KvVLlmlufX6/tJgzSsLvjF+ALnC9etKmqxXQHMkNBYEPsbf/tyEJuwzr+yTLrAJivPVRG9gGG7gyCsgGr+cdtXCcA4xY5wv306mqsyTLEE+ouIaGllUgnDdf900HF9zLo3Xvm73xtaOPntCcEn2ylLy6DOx5fi14as0rcZSZNL3lK+c1dDEe38cgrEc43FQqKTTIMhNo5Rx2h914EFopXiL+pm36sjn4FwjopEZOS2gGLB18gXBMPhCF433KkdAp4oPnY78vr9qC6HC3VSlQd7XVCXM6lXA7chA3CburuDUCc/y8So=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZONG5ZMEs3VWk2anJPRC9ZTk1GMXgwZFJZZFZCbUptM3BCUWVLN0VUd1B1?=
 =?utf-8?B?VnM0Y3BFS1FvLzdmQTBrTHNjUjN6VjdVTUk5MVd3Rm01Y0RlMzYvdzk1dVV4?=
 =?utf-8?B?NHZ6Wi9SYnpjT3RMb2ZpNTBIejZDQnB1WGxXVEdVVjZDV2VxVEFIWmFwVE1w?=
 =?utf-8?B?SG9LRTRLK3F1d3M2L2FQcCsrU1NSMUYwT0ZDQkRPRlpYMmZpOWdWVG1oMytp?=
 =?utf-8?B?MW5sakxsVUR6UGpkRk9xZU00SVlHbUQwUkY4Z29NZkN0M2tMMTM2c1FZaVRZ?=
 =?utf-8?B?MkpxZ3NtTk53eFdZUEp6aGhTMHA4OXdEdThyWGExNEtDUEtISm54UnFUY0xH?=
 =?utf-8?B?ODhnWGEweHhXV29LZnJxUkhvYzFXY0xTa1FkekdLUDJBUEtFWk91ZFErbVE2?=
 =?utf-8?B?akdDSlBmbUFjQmZYY1N5SzhwSUMxUHUyOUg5MHludmxzcjcwendZZGZ3ODVi?=
 =?utf-8?B?WVJKNWh5cWNPVzkxOFh5aUhDUjJ2WnlRR2tVbm1JK1p3OGUxdURJVkFZckdu?=
 =?utf-8?B?b0pSSS9ObWxueWZ3Wnh6YVBiZ3RYMUc4cFY5M1pjcnp2a1JQeGUyeHJQNFk0?=
 =?utf-8?B?R2lCWEUvbDlpQysyZ0FxMTFlTXdiWFR2YkE3WUliS212cy9tNTZuTGt6YUxO?=
 =?utf-8?B?cTR3VC8rYm1sTlJ2SEFNN1dXcklkUjQxY3h2MThhNzhzQVR0bjVna1FWT0dX?=
 =?utf-8?B?MHNFRWhEb0hkdHZiRm9lVEo5eUs4dWZXenBIZ05QVi8xNEI5S1F6Z2NUbGZy?=
 =?utf-8?B?YnBPVUFSTkk4RGlkRlFQWkNlQkJpUUdLN1lBQXlVMEtFdWsxVzkrUzJMZjFJ?=
 =?utf-8?B?dERIaEZ6Q1JLZVhwcHpmS3hsa3ltZDNseWhzUVhCR292TW41VTIwQ213RkVa?=
 =?utf-8?B?a3Zld3kwUUxBU2E5MHlQYU14NEErNGtSRDNyWEJsNmxaM3hJeXNEYXAvR0JR?=
 =?utf-8?B?bnQxZTJCKzAyVTFaeGZZMkFHeTN4SnRrdnMxRmpYZ3VCN3Z0bmZsTjFOZUNr?=
 =?utf-8?B?RDY5YkcrRjlOWVdkNkx1YXEyY3gxaGc1Z1J3Uk5sVk8rTWFkcUwvWjJmVzY2?=
 =?utf-8?B?Wkk2OFFzQlh4SGg2eXczcWY5SGUxWmtmUkQrclQ1TW1JdnFsWjBNOHpDSHlm?=
 =?utf-8?B?Ung4MXJ3MmF2c2RxWHp0K0YvWU9xUGtPOXAwQ2ZWOFlCalIzVCt1dFZoUENM?=
 =?utf-8?B?RVl1VjduOEJMVS9rRC9BNHRKSGs0ODQ1TmZ2NzhJQWtZVk01czRTeTd4YTBj?=
 =?utf-8?B?NS91aFpNRXJXZHBDZHMvOWE3Zk9QTzFiRkZnVmJwYmVSTnAya00waXRBRjNX?=
 =?utf-8?B?SW9LSWs0OXVGNEtvQ3pkeDlha281dDlTa3JUUjZwdFJzT1JMaVN3ZHdGajFp?=
 =?utf-8?B?RUNuVVMyS2s2NmdtOXFYUGQyNEQzVXV2SEs0VEJZbjhudWEvcTlGbUNocm1v?=
 =?utf-8?B?ektxRGRsMTVCMDUvVEdrNWF3QkpUSXJURzNVeEZZdWJia1FHb2c4cXpESEVn?=
 =?utf-8?B?WEE3T2VLWmc2T2M4Qm1jMmM5RzJibEdybDd6d3RHdVRvU1pkYzFsOEpBNm9r?=
 =?utf-8?B?S3BjRXdFR3pBZTN1a0FTVThPK25yUE1QbHBEMmwybTZMcG5KVkxpVXhnQ3hP?=
 =?utf-8?B?bHp5a3VqK1BwRTBYdDR5RncyTmxrVFlCZVRod2pEOSszWDhQRW5LYUR3MWhZ?=
 =?utf-8?B?OTQ2QVhXeXhpVDRHUVhrMUxiTmtneSsyNmgwUFl4T2hsSlNkVDFlcFRnTWxV?=
 =?utf-8?B?WmVaWU1DRXhQSkx6dml4VnIxelIvSUhTQUtGQjlNdExBQngwbkU2MmpkYmww?=
 =?utf-8?B?a1pCWnZQSnBTVUVWY3g2SC9qYjQ4ZUxCTW5CMjBac001RDVRQTJWMEVUOXgv?=
 =?utf-8?B?YlpYM0dRVk0vaWlKaWhnNUxFS3pFYTlwS05jTU9NU0VGOUIrUTlMOFppM3ZG?=
 =?utf-8?B?bUZ5akdvbW91MjBmMHNJVWRmUFVuL29xM2dsZUlmdUdnUkVQa2ZZTTVuOUVu?=
 =?utf-8?B?OWtuNW1KN0xuSm44MG10aXQ5bDhOYVc4SHMrcGdZdENjdXlPbW9uWVllMWxS?=
 =?utf-8?B?eUVRR3hMVGpRMVBTL1Q4QkFkOTJTZ2gyLzlHcWtjUlZLdlhEeS9udHdGWVAz?=
 =?utf-8?B?bloyRHVCVXRtQWdDZHJFK2hRWmw4MnFLNlZvcDJkSG92UnZVdGkzYXZFRlA3?=
 =?utf-8?B?dlNpb20vbSs3VzNyOUhvazc4Y3BnQjNvdHc5bklYSVpvNjBJb25PT0V6M2xK?=
 =?utf-8?B?NnlOYTQ5ZDRxTVAvN3FLZWNITWZVUkR5andFZUZZdUV2QzRLemx1akpNUlpC?=
 =?utf-8?B?ZytkV3k3dXFPVlpaWlIzS3BWQmhZdVh1OGhpbWFkQmorRERxOGJNeTl4NXRU?=
 =?utf-8?Q?Lmb9NmWWLJNAEySs=3D?=
X-Exchange-RoutingPolicyChecked: jXYw5a8MugMc9x9WXPmTb60SD9wuTMWaroLVRV5YAXj03r1XbxzGfX4Mn879MuWecb8vOA9VmZQw6DtMZ/QYD2eGEIGkYdQmNaWd5jKE3MxJxf0XX706yzmoFPjimrLHcpH9xP/NS1hT5iZa/47l+KDG+LXCWZ8pJZHQKG2KGmInq2IVwj49huJEod8e4Ue0+nGK5a3okoGtO1oYHTRarHh0gDWzu24Ij2Q4BlX7teCzl+HXKoypjcmkjtwVZVHAOJKbt7ZWOZ9jZVM7JaxUeDCH772tstEdGItXrPwyxNBlWfBJz3rI7SncmEqFV4KTNyYxAmbwZakwiMXI0gHzxQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5lh0zPSm4spU69avyQDx3Xp74y93afyC65mjxE3sNpI1Rm5+fOGAtD1hQvxt0kXMbVLdUnIEwbI0oejKNyP0bgv29xOqk3e/1YMsB4RXLWbvAUUwBUwjXV1hXjQTF8itjp9JUTXqlyA873Q9wdkGr35HhsGL1WKK1ky3lW1w0OlRvnDKd0ev1kQeMi2l0r+nEXJWUNO3R/yBoCexnGsea299nobgSuw2K4/FNHO5+nWckDrGATJ63uyifUShcqLKvYpYjwof0J70O/DpibVMRDdJ6Hd0Fe9Md6+fpRJi3rmZf7KYF+sxOpo8B8S3Ds+dZBDGcFbgYGD3Qaf5+I+LmVu8Yys75qywMwfYMcvs1MG85+uC8ZKYWo1On0Cbv/kJcSR+iBS6FVu58SfjWHC2daVsplFqoHLnYGh+btvLUOZDRAy6T/sW9pyf9Mze0s9j6dYAdfVaz1zrPw3PXmJAC9UErK5J2wiEEBABJKucDsB4GpePw2BLFzXSvLzEfGdcGrL8HWdZbA3nUPeP4UonXSmMY0LG3VwxPxA58OAoHOzvvTFoviF5uMdHh0kFXnE0rASD1kU5I/UxjMtLYmCg+4To+6i8c1SR7Z/gUkYptkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf192bc-3ef9-401e-aa89-08ded67b7bf1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:44:58.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9APwUKb8hWipuGOI+vCl4+TRge8qFXPb6tVDiQNCU+FgAS2iMhC+tUD5bE4w9HtICqDMcyox/zDUBeRZqXrzEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606300066
X-Proofpoint-GUID: Bp4YLNZdNCJUoCJIJ5lSnmhwcnAAZia9
X-Authority-Analysis: v=2.4 cv=FvI1OWrq c=1 sm=1 tr=0 ts=6a4373fe cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=PLb9wB4lmlLMmzVnDhcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Bp4YLNZdNCJUoCJIJ5lSnmhwcnAAZia9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA2NiBTYWx0ZWRfXyBWVMM0MF/1N
 eNObEOIPTCzPWwJy2s2I9QBOIeda20+WtDuKfInap6noNUXnkEle0ZrDJhSfLlcZgmsF+x42jHg
 e1MQFQXyFuin7xvsLTOtEAkLu3qN5598/Uf69/4ckPGyZ/8QKkU/
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA2NiBTYWx0ZWRfX/YlyP4Zcn4w8
 qqwjzlblVVNn3QS0ED948Wi9zpZQo5fuKMZcqPCFp+1ABrLnW3wMHIaMN8tHQzw4TFP1mFBnakn
 SOhMyB+3IPNHxJXcHNnAFIwG9CDHWuCuaGbatusa6La7S+jRHL9tOYK3EOUVS1NcMvOTyXKfKl1
 TTcK4MkLnCCfW/zwktuy4nD2L4pCpXk/1MbH8OJkvTLkb4ouAOsPuVkiG2ju3Qk8OceAtmBHUJ0
 262nwQjrrwC5SAP4jBtSzuJzcZOZriwqarHDCxZjTKqLYzqk1sLj8sC6n4JaryHBC1pDWN8Wgqe
 jQ1uDUNNHaHILxAbaVeoSzuIHweFZOg5vOhft222lbHf1sIMmjOkovkt8LxTus9r9rpuGLncz9I
 lnvgYueb2qhIyknOXV0A+L67yuR6LkTmATwTs03OK165cNHBjyG56MFdbJHaWAR8iOBIWsRUc37
 cv+oQDtY7e7hkEVRZhg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_004504_527620_F58BCF37 
X-CRM114-Status: GOOD (  18.31  )
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

On 30/06/2026 02:55, Shin'ichiro Kawasaki wrote:
> CC+ Alan,
> 

- alan, who is no longer with Oracle

> On Jun 29, 2026 / 15:30, John Garry wrote:
>> I have noticed nvme/039 for passthru error logging intermittently failing on
>> v7.2-rc1
>>
>> For failures, passthrough kernel logs are missing sometimes.
>>
>> I had not noticed this on older kernels.
> 
> So far I do not observe the failure with v7.2-rc1 kernel.
> 
>>
>> I do note that the passthru error logging kernel code uses
>> pr_err_ratelimited(), so this can hardly ever be a reliable test.
>>
>> Is this a known issue?
> 
> I wasn't aware of it. Do you observe any kernel message that indicate
> that the error message, like "X: Y callbacks suppressed"?

No, but now I find that the missing log is not occurring, but I always 
get the log with the unexpected cdw10 value

> If so, the
> test case maybe able to check the message to see if the test result is
> reliable or not.
> 
> Alan, may I ask you to share your thoughts about the comment?

I'll check it further

Thanks!


