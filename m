Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B23FC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:From:To:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GOMjilG8yc2z1xLa58surk8ZNacup6nM0l8p+22e9WQ=; b=eENp2o+hbBQW3E
	/PJGV/Ha8Wl2EyzF87lRlzvIKMOQbCDcrOrmfGGfiF+qYIGke9g5IFkVUVW+hjvlPW2PqRcEN/sfb
	XjQ4vIAeiWpqmGvLmVZzvSORaEZPiHBgess/uQi9WHOEHSM7uVpHbjsZTbLnGn0aybg5xO05mf1ul
	eYJtPNXDmO1g8S+biNUFgF90fCVAOfAYqPMFiaDujA1T3qnJfgCN2tOEUK70CakXD/9r7dRUbLXZQ
	xyIDvMBeZweRgPeW5nxGb8QhT5CurNKly6gtgLN5UvDmH3kbra7o/+3z63N5AaqrgidoIAlJOOq6O
	tr6UnG8CSG3Vs9/y4Xfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weD0k-0000000Esst-2sja;
	Mon, 29 Jun 2026 14:30:58 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weD0h-0000000EssW-0jga
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 14:30:57 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TDufpq2076865;
	Mon, 29 Jun 2026 14:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=GOMjilG8yc2z1xLa
	58surk8ZNacup6nM0l8p+22e9WQ=; b=Rr1sZ342ihkek0YNv0c9HxEo51e3om/5
	7G2eozOFtIfhufFjwtcxHVoYW6IfTQO5lnz7jooxERZO4+JCd0QXtDxCnqnIe3kv
	DlSa3LSeEZI7FM1Gs3miwbwXY2m2bjnswVTOUekf4Svwj7wjVFaGXnDDoY1I6Zbs
	JI7Z/j6ELWxFb8p3sGk742M2gHvA6+D0S2zpfbsLJLLcNJWbIA5Vx0QsewLidz00
	2Tl+I6mAJPu2Ke4EKAxBwxSgb6sShTVcoJIRROFVd8zXvNvtydFO1jhuiEUYLmTG
	6f5qYNj3v/+/kCxQNW3hH6oyoWMh20KnJv5A9xnV6pDnWndbZ2jyVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26kya8pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 14:30:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65TESe8O029397;
	Mon, 29 Jun 2026 14:30:52 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f24yp796b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 14:30:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8WWM6hrQzvMkLCqsqYDn7IrEEKiqvHjTWsSwmFbayb757s//PR0wnyDMluGamcTyY5QvAXi2pRR4FfEpHFnP7zKxQU0SJt3jEnW0/5E9mQalVkCC/Ezk26EIW14PdRuFGexke2mxhhQ9ZP/0GUCD6ZFLsBHNT0k8Gd7qcJ553wy2UjRqxOmJq6DXgXveGlV44CWQG704Gi6FANoWjEbvEdhj45ZNIjnfFJxRkbZOOZOzlFmquJwGQZd8n8vBlht6P02uo/ahSTnPvw08ufdeqWQy4YCJN0tjwTY4zH3wgaR51ZFbZv8TqdMZf3gQP/Cg9pTJUqK2zJTYFtXxbJJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOMjilG8yc2z1xLa58surk8ZNacup6nM0l8p+22e9WQ=;
 b=rOQa6b9+MIJGhV35pqJavQSOXN+YZI9MPmq6xjAJY3gFLdXXy+qWg8RufVsjH3z7YWnXVqCNhpEpwyXxCdmdbetGJXrcfjTOjBXsltnLq2PajgINkZA4EIgU/9q/Q7k1AK7v9qladdqjIKrv6kIoMOEHSb6H991eRHLarPCXxS3+Ud17UjfBKx4o4zXc8NwUgowMYePZHKvFqQFqI0wHaKzP3xoFTipjnZqjPTDvAwcgOTIysdGN0Dhoq9MYl6Wg1Fugdel0+cxacdkGf9aKbGkaPi72nQCX9QVdyDJBEmIu3m2awLLWXYTAg+IsQWxRRp3VHCdQP4Mq+NGP+xztbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOMjilG8yc2z1xLa58surk8ZNacup6nM0l8p+22e9WQ=;
 b=JEnI/DO31HRxzG/UawaTTEkUsy8CmfqAE1bDjGLSHOAj8iR1CGHiRXAUEBwHBS0p/+6LExMjvgZUowViS4/QXI0VrfmRREkMXEZfqEjyZPp0SiQ52XlwDkXy+1H0e0Abb9wCgrVt1CnL93LpsnMAxbRuUynOBjCPQ0USw0/beiQ=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DM6PR10MB4395.namprd10.prod.outlook.com (2603:10b6:5:211::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 14:30:49 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:30:48 +0000
Message-ID: <0f6beb6f-3d3e-4408-be8d-5ed36cdc2c56@oracle.com>
Date: Mon, 29 Jun 2026 15:30:45 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
From: John Garry <john.g.garry@oracle.com>
Subject: nvme/039 intermittent failure
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DM6PR10MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bce39c2-b0b3-4f26-4bc9-08ded5eb0377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: wF1y569teVB4tjMlRbTmYeGwfFgoPxAIvO+vvm1pvq1oF2kSrY0aeELtkfmjujNCjw6YoK8572eKGznlRL44cLhjlhLVWYQ9q8p8H+F2b0z8pcSDa3FLo6A4aaGkPX0SVAISTp1c6uqqycNahV9QSuTzLuzZFJ4jNxY85ekEKKYVLSm122nPtSr7Uyfm9fVUYu6aGohVwWVFSKjqOxLtDHMo9u6I5Vv0t4P4mTkb+sDk88s+Hja918r9pJ36CrTOGgiNvpcxTL8nt9cJmhhMUcM40V548Z/4oyYBZjGo/oINvlyiyfmjJeWB9t2AcKWgvY/tBmcISrQ/wi3oM6LBCLXeOsqSnV1ESFEU2r4Swi5cCiFTLYJlXKFv2jUf9Tv0T7a2T/j5KCEyRXmLUl5pqpDkxNkTLo+mX1d2m1OPqoCh6WFWNBfW+YP8DeBALwEhANRTDN7Xz/uIlZbklA5q++1wN3Wwysf4rd6L9TqoWlXoaCZaqrgXUphvCU+VBky6XjgWJEQmS8n4rmegC16DMcvaCwYrM/OTWSBokzFSQubcLyuygI0YDk99MzYJ0TKsX1goB0XNoiyT0dfiofFZwWyC9kKxjrQs8fhvZp1zolkgG/PiNuP4MuK7PAGsLG6AE/IhQLESee0Wqi90pn9zZ7vwZXboDVA4wMMe4V53Ul8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1ljc1BuU1ptazRiQVhkRE5IZmxCbWg0ZDR1NmFzTGFvTk9Cc09HSmpiWlVa?=
 =?utf-8?B?OTFtazR6Nm5hWVBwT3JFeVhMU01GQTRSSEsxVUtnOS8wMXlvYUhNSkFsUEVC?=
 =?utf-8?B?Q05wNnhVS3lETWZNQWx3RDN5RnYvWExyeTNhdUFFUS9yNks4dXRWZWI2akZD?=
 =?utf-8?B?RHYrZnBOaEFMb0x2M3BWUUhLUHdhU3p5WnBuWWxFaXNkZHlTRE9pb0ZDTjV5?=
 =?utf-8?B?MTkvU0lGMFduTVFva0VROTd4aWJZbDVTWGdmVjNYNkJaY0RPdjVGS0JiMmFM?=
 =?utf-8?B?cG5nMmllVHhBbVRyZ1UwUVhCZ1lQN1ZZQzNCTlNpZm8zS2V1WGc1TDYzc0Y5?=
 =?utf-8?B?QzRDbGdDbWQ4MWFvRndNSCtrTGxHaWc3WHFrQ05NbnkyeXZtZ2lMYy9jWlFn?=
 =?utf-8?B?NG5GeENjT0lUQ0UxelNTcFJLSHkwWDVPd0MzalRzUEc5TVFqOUNxM2VPVEdn?=
 =?utf-8?B?Z2t1VkFDaG9BRTNmaWZzMW5sd3pOSldoSkRmOHhCQTc4Wm5rMWFzczZuV1Uv?=
 =?utf-8?B?dVJXQUpNUjZXcGh1bXhXTEcrdVRteEhPRzJiRDVvbVZucmFVQTkrUVlYVVVS?=
 =?utf-8?B?T005NFc4YThMSFo3WmdPQjhqKzUvbGVpWDVVUkVHWXZ4ajlHRC9BbG1hR0Zz?=
 =?utf-8?B?YmFHeU9kdi9MRjdzeFFUQ1FMVkNwd0l5dWpIUCtqaE1wMy9QR1ZPY0FRMjFV?=
 =?utf-8?B?NkRUaG1jSUNGbHRHSzg0TXpGN0c5cnI5NC84RWlreDVNZFlzTkhaMFB3ZUYz?=
 =?utf-8?B?a1p3MFh4eEdLNTU3VEdDY1FBZjNmaE00blhKeS9QbStab1o0VnpZZjRUcndl?=
 =?utf-8?B?VVd1M2VDdUVDcFZLT2lqWkdNdDh0Z0Vnd3JTSHUrVDkxWmI1akVlOElXVHYx?=
 =?utf-8?B?MFhuMXdPTFRibzZNTVgvbUhicGdRdDhnYzcxQ2JMeWFpYU5TVTIzTzZzNktk?=
 =?utf-8?B?bGk2cE1CSWt0OFdJOFRKN2NCOE85NVZSRkVkQWdEM0xNNmVzM0V4WTFMQ1dY?=
 =?utf-8?B?aG9lMmNxUWNRQUp1clN1cTFId0dzeVpZMk1oeWJrL0pWNG8ybC9WTWp2cnlJ?=
 =?utf-8?B?UExuZjE5Rm5HZitCZzRoblUrOVN4MHR4SmtkZTg1R2o0d2lYMWtLNHQwaGkz?=
 =?utf-8?B?MFpPUldhWGtRYUtENjJnVXZFYUhqQkFzYXJFVGQ0VjFFaXB0bGh2SzFBRmtp?=
 =?utf-8?B?OWJOaTB6U25aZytNUU40K0dGd3RNY1Y2MGNGV0tBZk43RnZVL2VyTDFGU0FB?=
 =?utf-8?B?ZDJwRXBSQUN6ajlMUDQ4NzA0TlFYTzJrdG1MUlR0ck1PTDlwajloTVZnNklO?=
 =?utf-8?B?SU1Gb3JFUzhOeGtDV1RKd3FzRkxiTmJGWk1WMExYK2wvNWtXcFlLbTVHM1RX?=
 =?utf-8?B?K3Q4VVhOQnFEMHdGTitXRmVhTTJxQ1haSUNvUDdBemdxTi9KVEpxQTFCT1RV?=
 =?utf-8?B?cnV3UmVpWGREMEdNRXFKUG5rMUhiM0Z5NDVadHlrRmtlNnJPTDBLb0JZYWVR?=
 =?utf-8?B?QnRMSHdMZEthNHNhN1Vta2Q4dm95WTFXR1o3TWhkdUpwVURjdVdJMGhSdWZT?=
 =?utf-8?B?cWpaSnowYlovOGhaU3dCa0duSVlPRDVDRTg3bEJRTFBpMkE3aHdlWHErZFlO?=
 =?utf-8?B?WUtmaFBQUGorUzJXTHFnWDF4ZDFLK3h6VSt6bjRGTnVmZU5oeFA4bXhHcUJt?=
 =?utf-8?B?Zmw1NUp6RG5uc3d1c002d0dlSDZiQm00K2VuT2Z5RDdjU09NNnZrbGJjbzhv?=
 =?utf-8?B?SUZwTHpJd05PSGU5WnppV0N5SjNTVUM3eU1MMFlMUjhqMVdEa3BRRVR2S3lN?=
 =?utf-8?B?VGk2STY1MTB1TjA4R2JERmFaRjliaDdqbmh4UGE5RGE1WDBUVVV3YzV1RHpp?=
 =?utf-8?B?K1dqdDIzZityTHNYd05FaTVWVldVV01ZMVUwVXJYeUhLejUzZVNYY2hSbFVH?=
 =?utf-8?B?MncvTGRXNjFiZjB6SnRUa1JXVVptRkY3M0xicjl3UmE5dGRqUlUxTGt0MHVU?=
 =?utf-8?B?NnJrN0tuczNsZitmeEJ1dm9ZajdqdXNiSWtDZ00vUkdHRFdERzk2MXpOTzAv?=
 =?utf-8?B?Mm00ajh4bGZvWkNHcnFyNk0wMCt4SitFS1BBMUxZM0FKK0Z6bGRDeWpUeEdI?=
 =?utf-8?B?ZEt4QlZzN1pLcnlTYS9sRmtnTlRyQ2MyaHIySkYzTHF0aEhSYXBUeUJ3YVJw?=
 =?utf-8?B?bHpEQmhQSjN0bE1ma0lYMC9SSE9FR2Z6OHVUa1RtTVZtZTZLU3YvZjBlN0l0?=
 =?utf-8?B?b3h2VkhmYnJCSm9sZXhETFI5TVBUVXdQYnV3QVp1SzVQcjFld3krd1lVUUwx?=
 =?utf-8?B?QU9kWFBZRlBrWjJsM0l0bjVEVUVvVUlMYmt6cVRjNVVpbCsySG84SkFvdE9p?=
 =?utf-8?Q?6i/JHhwlkKM1A7mA=3D?=
X-Exchange-RoutingPolicyChecked: QiJshHmEr3xfl9y6slOb86FxLO/8GpLfiYg+jAWhI5ViYrD4KOIuZI7OMX8gn70l2GsvZVnoFQfbVC7QZRaLWMfCN9BHDG/WHUkfxSOUN9kuMvgODicllpR46KJgCyG0URJ3ReYrHS2afYU+Y5lDZEkXGObEuLW0vJvq90NJBIGaFn1usUULXSqVjZGaE8KXcYcJ9a4Y0coC/fjpXJx2RsxJ8TRcUwfWFElsTmu8XH46FY3Fk/vU1aD0MVlgO/iYu6wu0zF0fN2UYW8R6YAuQMNG/yjCGuFlM27By1eM2rCYCiNgcb2MlBcws/R/K6+Vqx4fREYIeRN1sKkkliTuKQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4i/oOk1AmlAOILBI/bN8BeuXQwdxm6qoyj4jfqu3eEe8/tq6huKJjA6PtHwmii7OaJ5tsj01Vk3TSmwEO8WjjGlrPJWA/XK//rDDj7bJvL7HIX4oHdojiq8RLS305LYcnDham/j5qtG2z3N1xVd5K3OUtgo5CKJyHaRVSnmLFjykDfoJDsQnWRs51zlGgKk3YEtTj3PGzO1V2Z1l2ai/BfxNW8PbbEZp7tbt4oxPtzisUsJXuEQ0I0SeLesrVL76sljDvRGLv0nous1GYDCdOrb1BhIICjY8htiNaeC+KOqLpeC6vU2mli1eFOUBPVqQpUmELuPM3CrI9ilvqkRMGKVSpZAvt1+cBs5fxgaPICjlZBN3DvlGcMdWJAYvR29S7WehiW563fZpuyen43jQjf5DKurNSc1J8m9h+/hCIz/RqxEO7qKVMPXf1y34xBJdDE2Zenw23Z0iGyIvQsMv496ylzfTe6W+L3LyaCTuHCN87zkN6XCKXjUTNDaxSvBDLQCVuJ22c/FpF4CMgFRd+JcrfmiDDnpxjnliU8Qm9p2h7gCj16Mnwoa8tE3M0ZFv2i/FkNJr15dJ6ae3Uc9gF+gi7+xVvdQdMd8+ehqJanI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bce39c2-b0b3-4f26-4bc9-08ded5eb0377
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:30:48.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22Ctz0szjlL2LXLrbg7AHySdVuRPmMhlBq7sEJaiOiaO0k8rznidT9Ygfx0vAwlhZfIfEXaXNLqD7F7e3B8atg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=943 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606290120
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMCBTYWx0ZWRfX2Ma07+niTdQt
 S5fdIE9W7Au4lxRj+QFadC6rAu1z5aqn/IqTvYE+b8WhBMXPLKQi4ZxE+Nhp/a9l/iCq/RHAwLe
 NOq1lpDqGPlf2GHsMTWg1lSdj7wBpauoa4PLYG+I0FlaZh3vDWXT
X-Proofpoint-ORIG-GUID: WczBdDlOG9dYG4XcTM3BmB6GqQc1NRRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMCBTYWx0ZWRfX+ttTfyBHaZBr
 DW9zYi+53n5Z2625O76Q1HYPj/ssyl4HpIqUmE2M85xBypEgSjNS+F4qICPeBdO3yjBW3cli8Tm
 Q3SBlHi5SY4tkxaUDJuSiqp/mrUyUBQP4TBC/5pWZuRqMQgOEDCjeXcNb03ST8VIfA43pJ5zh6i
 xMMSw9y+kpVb6zqIYwH3YOfvhyqpx/c1ODSO1QHJbhIbcVw7oLhXOEUuU2/Icn1b/0E63/uq6jG
 iwC5ojlc3H/LV1kzrcviZKidBrqIpSX8GjIYq87b6AfEd3NO4Ic1nJlv4G5L7viQBNO8haIU88p
 8strWlK8H05WJbGt3DbHcrWXGz7bZqnojxygM6bToiaMRyIgQclCHQDsu7qdA3//NYlS5JFLLD2
 9bwL8lI6xbdfj+P+cA7Kx5aa4FCvQafEdD5bdxak8CBBU0/Q23Yg+my+9WncF2/9F6xhf3WLbtx
 ELQB39ouT6xTWp7LlUXq2dX3DLen7jtoIKXbOp9Y=
X-Proofpoint-GUID: WczBdDlOG9dYG4XcTM3BmB6GqQc1NRRq
X-Authority-Analysis: v=2.4 cv=ROaD2Yi+ c=1 sm=1 tr=0 ts=6a42819d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=4OgXmTEfTPrtLV9FYG4A:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12312
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_073055_248195_149859AF 
X-CRM114-Status: UNSURE (   7.97  )
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

I have noticed nvme/039 for passthru error logging intermittently 
failing on v7.2-rc1

For failures, passthrough kernel logs are missing sometimes.

I had not noticed this on older kernels.

I do note that the passthru error logging kernel code uses 
pr_err_ratelimited(), so this can hardly ever be a reliable test.

Is this a known issue?

