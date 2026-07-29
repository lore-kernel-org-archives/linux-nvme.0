Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFFFC53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 18:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YOHS21N1AzrVX0OqRtDT7GkOzGdrAV04ukzCET3/FQs=; b=sJIYF+5YjdWLVNV8qarB0B8MQm
	Y9dhYEm55tS4QV7Ch6y3kppfzTOw+7f9Tj5FNQcvdTnJRMwMCO3pn8HLjmc9lOVyq8EeQ8Xcv7mpF
	3RIJ0F0iKwizfC5u7mC2ujhnYZTSMUxztpKWWS6ipLtba52HNVbBikvS5DQ3Q3kVbEUfBLn2hKKs1
	wQfTvNmnxj9DKgHsPDDjO0h9AZ56+i+MzURUf2+5GSLEIWkwzxqjK9T1MEvapIrMj2iq5hZOKcK55
	eSnX473xbhiVnmtFQ/b+0qF2Bo2qn+l4JKZIFBgM2fZRYNgUca0Yyu9eqe5FzOJP5Bh/z5+WjA0XU
	c0ZYsHHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp8vq-00000008o0E-4ApX;
	Wed, 29 Jul 2026 18:23:06 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp8vn-00000008nzo-3qsz
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 18:23:05 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDWjmq3036885;
	Wed, 29 Jul 2026 18:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=YOHS21N1AzrVX0Oq
	RtDT7GkOzGdrAV04ukzCET3/FQs=; b=OImvIs34zo+yLFn9L8lu4kGcn1lS4O8c
	NZT7tYvXOUUsbPNHbj4k1oXGzoey+E5JHkn3TY00Lqy30vi7kRh0/Gch8Pzt0EZ4
	7VMhQcrBScoeq6yL2lD+DWVhdCWCME009klKTsilfl0D5i1Au7Mu/vtbRDXa7Htb
	D74XgGJX04oOOAdFCKI0U8yM3uEbUOKvgPr2EcuMjZ9K/4Qf4NuoNmWF12dxmjGb
	M335YmrVJNXu3wQkUxbHQQsHHWx4cd+RfiQlsdl9wBIpEDonu/mYDlP3MmaeuOwi
	ZV8L61OrWScb3AThBxi2C2k1xmfq0CNYKQ3pHBCHf/Y+SRBLcwHGuA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5xxf02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 18:22:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66TIF5a0010998;
	Wed, 29 Jul 2026 18:22:54 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fnhem8kd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jul 2026 18:22:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0slkBD8B1mWdpXioV8BS7vJhkA/kCtCPIpch8fDLkaZfNh4kMyU01I97KYogfxmALsMpErYTZ0UnBOF7rINsseXKu6XzEk+trBTOPFFNWtbVJ7RZDyxFJDfnenZj4v9mBFkxFnUA//YmmTCSpIvYo4CFgjHTly9T/6USQ4Fv9ADc3M8APjI8fjCS4MdLwMgB48kilImTyG9Wu5SlwuJTbFgMSQnWG7Yc2kx6oMaA9GqwK9+1wdtLiImVBKaBKtChNoZJaTXAmYiawNZ+GsdlpyEJsjJfCn9diLv5QHvTlfUFJoCiAkj8LjbzEIfmfFmVCZvtEAMYDSJHDdsfTtAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOHS21N1AzrVX0OqRtDT7GkOzGdrAV04ukzCET3/FQs=;
 b=pvrFynlMFEmoggMBNgeG5qJVibJtfz3i9jxbNAICnqa3PipGG1kTN6t/Cr2aIvC3AEYzlri6qzkTiIuVxodng7mQyjDJwdW+u6kOww7m/khOag40yJpIwdOFPdzOiefxr49A9EX8ZRtQAa7F5nd/zRsi7L547RBN1oaI4lkWRzCaofj88qZkAYb9J1Zi16RL307wHszpAxytqVUC39o1J3mxVXMEYPtvraKObb85Yr1ALzrnsC4j0en6aamFru8UJoRHErAitBz7x6+56tPKximzvjOjuGCsvl9o69jEFaEFBH3nCd7pLSE8SCfWtE+7IqE+QdtOOOOQaUqkAt62vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOHS21N1AzrVX0OqRtDT7GkOzGdrAV04ukzCET3/FQs=;
 b=tS+nyONWZtX17kZcwwxHRpfquUplLbYDSMhbVxcizpHt/lUNW5+Zn7/Ge0nw9jMyUYSM0Cp8L9DiqM/B2uoKKSRDMAmM8yDZifo+oskNvrnIk4rDIqvIFyoT4h2C1Sw6YoeZIsSUohhe0vNwe3hF+gfeoKaRorDOrWs5LlKkeao=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.13; Wed, 29 Jul 2026 18:22:51 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 18:22:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC] nvme-multipath: don't retry adding head disk
Date: Wed, 29 Jul 2026 18:22:35 +0000
Message-ID: <20260729182235.366634-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:510:5::15) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d18cc4-17f7-4925-bb5c-08deed9e6636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 8Vp/YT2JydsY4tWO2ul0OwK9S0qJA98RFVukeOXikebfHS7qnpBKUk6L1uHEjO9wEw2pIB4xm2wI726UtY+YCBBflaqNb3X3unky2zXuLyWuAwev4pBNtVNkJCmu3uNhDV2zO3uf4JtGmhBCkCUCj/sfgFYTHQ6Oz/7xHweBCjSigYsM1hjMxTDzQUA/uJngtLYJBiJ52dY0JF215sXU2gyItQdKdLtMlQ8jqKTFJfx0UJuLwpvt4neA+HQLEnlqkrTwnGv9E32zhLWMkCEYglD+aNzMkAM+E7opTLkBhDWDcwB6BGF+NV39wJGOKelVzLYDnJexfbQhSC5xU3hZZfrn7ZRIpG6r/5zClWXN1ASpbpuMdAw7rbp2UTfT8pUnQRr6ryq5hepYnFj8I9ZyrO6uCF+/TUfyB+QmcR2pjccOVqVQ9yBsMyBg6Ejv/GE4V81W1oR/Apoz15BzwqAlmhizkWFPs6B1pBLE5r7NbOFduRym6X8pUmPq5ZgHGLyAln1+8UDhmnRzuG/2JhmWNp51IVsof2GOFU0zz2LQqP7dzLzOP/o/+aiscYuLPnda15956QunN+/ej9fMH4sWLTiM+5tGMWdKTHmzWFVTIKPlGP5gvkRkFEKzf9audYX3PGdzbR/yRkZMZ/qCtm23j+ZB1Q65q3Cy3dXFx4DxjFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NsU0iBhKUo41Fm00to90TGjX7MOjyd5la6VN3aL0+3zo06oRj2xbN6WyqvQO?=
 =?us-ascii?Q?n9iiL8pwFRIX4hkOLC3Cpv1i0YWkLkp4v8B61paZ3Zm8OCsZq91zR6UHtTXD?=
 =?us-ascii?Q?GeE1oQAikjPwiiZkJ+/W8iIU4hPQT0PKuW0kDeHB/hoJEMIpPDSQaITu3ZxB?=
 =?us-ascii?Q?jZbJb19eXASdROBOpmR40ZLH8DphqtJgSSEkAgPIZUDd3TpQEmopBADfVqvw?=
 =?us-ascii?Q?u8eGGN5I8jxdYXy7WyHKm7kVmF0zMA3PTvkrFnPrIsdxJryOHBGRqn5djmLj?=
 =?us-ascii?Q?SFLDMuWGf+7/4sFx4BhEYZQ6zYg1es87hutoGzStLX/wDeqX48x4dpfCEhN3?=
 =?us-ascii?Q?4B4uuNWUUzsMLP1gtVGADGJOfAdiZxJNPWnlfipr+2wqGO3JkNm9jvR58pzo?=
 =?us-ascii?Q?Vu7UrOm5OqPKPkcMzhtCVehhYDYZP0+Z3uHr4I1Dv3DolcHhmWEUPf3IYd30?=
 =?us-ascii?Q?q2qfWwSaSa6yGD+XtjIX/Z7Q1OnbfoGeOPTgYnT3OLgKDc0vWbTwtIpQMruw?=
 =?us-ascii?Q?P4mfc+ygvX/AYEETe6pnpB8OttFKoUm/3CLTtZWA5ePsv0LzDzaz1hz+IhmW?=
 =?us-ascii?Q?ziGF6aMOsuk7upoXucV8+UbT0/Hj0ortvIai5I9xsRO4jFqgeDPnNN1Qb2NO?=
 =?us-ascii?Q?17BxyxSrjT+1wDswTF+IpW80poz5PFBpvNT0Bbz2eep1kefmlw1TH46Dx5hE?=
 =?us-ascii?Q?XCxrGeM2QN1at5F/t7Vypx/c27Mwq4FMv0Z2II6CBdO+8IbDhPCl81Lh/fnh?=
 =?us-ascii?Q?43MMdMONB1jLz4JfmLDirq6knQxcSh2LLV3dQHro/rGec15L6FLAOUl2cgJH?=
 =?us-ascii?Q?HQksJZLxpf6tpxbwNZr4k1QCenKKgZIXHAOg52LJdExCS27xN1mn+E/m7GPb?=
 =?us-ascii?Q?ZtP3D1/1h0QDi6a00RBmaw4cnzyAxRR1WmAvdEB7Z6/vNqf0lC3c1KIlehZp?=
 =?us-ascii?Q?fyclMhuKaIyr9RRAhRWWfrK+9VTf8WslQJBCWWuyAm70xzJ/14MmIbFwA+KX?=
 =?us-ascii?Q?LyrB63Zc7LvL85X0eCv68xNjoDs8DLcNOcNBw+2QL02lAWOFbw7QAFWYMGGq?=
 =?us-ascii?Q?THBp5dPvFR5JoAV1HNIrU0FIIwzlrzLhYnkd6o7a3MYtroCueFsxLxwuPJ6n?=
 =?us-ascii?Q?ZXytHhb/mRgsBjiasZpzHuFwYXSUdahF/7dJqrZBTtjw/KdIuSVU7wjDB8ky?=
 =?us-ascii?Q?/u149PrXWjOXfkmLTAvJvTWevCowp00ic+E8MqSTK1FgSoprvWfgDosJrTU0?=
 =?us-ascii?Q?9iZTzmfE+qE4Ze8BqAhPlyMFYm9+eBKwVrBWu7M8NSpMTuo2280l4HGXC+tg?=
 =?us-ascii?Q?jiPGWtg6yu0N+dFN+lw9f0esK/fbYnX5rXtzJ3oAvNGxaFDn1z/bJ3u099ls?=
 =?us-ascii?Q?BSeQhDDZp12XdJ1dj7jq9LHX8InjIGKUK1J9Hny9sXkgbaLiLnNrbE93jEeX?=
 =?us-ascii?Q?qbdMCKNZCAKC7M/2ssyyTBzbG/j3OGYgAaW8ob/NUSLl/xUS6KArReVvLsrs?=
 =?us-ascii?Q?eLZaBPSIPOwVUvJENXphkqwHh3UdDQmBKRaFnV/JuD1urAjYpYjs6vA+chu6?=
 =?us-ascii?Q?gwJn9DS5ekGDdzKQTfOk6om1mcUXOcH4VYlJDMxt02geXlT1iC+xrk+Qgfsw?=
 =?us-ascii?Q?u0XkEBVANISw9I6eJfzp1SoPFRozG5Lonj5GAydL3BpVw2ur0AXfd4/QdutF?=
 =?us-ascii?Q?KI5/93Khpu39QPfsMZbrsvQ6u73LBGHaS9UGYU9e9U24iLMqZpylpW/Sla1y?=
 =?us-ascii?Q?XZzfpmthtr4Pq89Gr5UQvzYT/s9Nb78=3D?=
X-Exchange-RoutingPolicyChecked: b75S6rT00mkzRYf0tVdODZFv5i8cxCObLlOVRcedc3u0PtmGwQC7ctorc8ULqS/Iy8fVVXNy5TY0sugAcO74myjpAZOXaITJCeO90b6vCm6rz8x04n2nViSxsMuTh7BAaoyLOovxehsA66FNSnnK9XR68AxMglnV0yB+c4dWF1zbva48zQbq28hNnYx0wCyCaw7MUDMb72+Ne9xxxne02J58QCjO/ffuYtuGUAcmBqk8ZuHMJj3qdC5Gej03JSXstmntNB3sulkNcWf30gaHMoVcoyW781lqHGqD+G42OAi2KPyJqNfc59gMItlQmKEEB6E+TXR5KxtqTA0kbnHzpQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EGFDg6/Xze9gRsgrcHlP5Nuro/+s2L5lj4Er1liq0cgbiV6qCuLdOPTCdTgMxqUM7VpX3ZMhA85TL+H6IzKPgqiay7CS7nhSGdum4MxV3Nd3qTxNJhm2/gHg/GVQb26bldQWRIt+qH3aggEL5LkVAkQB1F7kxmW9+dDmkA6mglOM8XParTvZ2hxKbZvA6S9OYGJgrzFjUE3jsFKTqTLLfmjRMXKXeJ3Sh+JC3f2nuevwfpdq+AtQsiHneuNTTMrK8O1xze5TGz4hn2N2cyIxnE8le/95zS4mbeUu8FAtuREb8YlEnJVclmAMFxANLR+CDqeWXb/Usc5fCd5cnaPn6DWr7QkYT+V9LN42e/IBN3mGVdD9FF1oaVpO38kQ4S+aSDOTszaW+agDAlJ4Wwlf/FjNMybZzkFuJHF44+PaFLmn4RR4gXSpLRhepBmj5/Cd7xbc2O63CDAKt2a5Q3728uK2U4GEbL/zxlKYZz9DDHKqZHVWWwMZr4XY9bprzs8icvEkwhKUOQmKZrIIf4rwhbKLlemI+DOE1Yz71YIb9atSgNAo0jaHU2JZJ+pQ32O/URMgLk1PhVaQVm3B1V//NCr2Ris32mdtzGmHik4vnUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d18cc4-17f7-4925-bb5c-08deed9e6636
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 18:22:51.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHYqeYCAXOSOwD/UKQRX++8mz2BsAbWsGsj71dtgdXQPE0Xk8y0hYTAsg7xtMJD2DYTwSu0UDcUCsobCiYeqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607290141
X-Proofpoint-ORIG-GUID: rZtDimFZVOP83YrZ2yeMvn7W76aoK86o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE0MSBTYWx0ZWRfX4ZtmQGQFF+E4
 aOjMR+42ihuAKg6916iZ/4+2j/uaYO9lSfolI8Sj/6AR7W06L2eRLbUWls9i8OjjTs3O+TyFgFF
 vjgA7awL5LbFjoe8FVKXlWfzTtjR/Ad93Tni9lADbmUFQy58LizD9cvoE2Jw6NnnJKDfl9XJbnG
 Gompka7Fa+tIfouxMI4c+HvQREuU2iiee/boEmN6wJJmCitK5graIV2c4kct5HKo5XeaHNz/fNu
 AJNdEGILSaUKfWgELOu3rb/Vl94otRXdAgvIYXwm3SYUcwvhxsuh53jqBu8nlLMukWCqqvM6NBb
 jIgn7wGdFUW3ZQS+81/X7TP8+fNyIzdZsTvk44ft1uHs4ZbLogIL2jf3QovJe+mAK0cL6oNMrrW
 KMtSuFUF7JGGhFkk8J7dKpMr2FMq+6RcCRJuQfa3th8TJE0/fzImQo3O9rNguQEwTgYq0Gmixwr
 aoQ344NbiTl8gBH37ZQ==
X-Proofpoint-GUID: rZtDimFZVOP83YrZ2yeMvn7W76aoK86o
X-Authority-Analysis: v=2.4 cv=A6Jc+aWG c=1 sm=1 tr=0 ts=6a6a44ff cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=JcMAq0gCRWZ1H9aCxx8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE0MSBTYWx0ZWRfX//Raf7mXXrha
 aKMVG45/sZaqWV6lmC3+U9uhH2whRXO/DSRX72b5goIXS55JfDXqxrfDhYSxnjspHrMWUt+Ei8E
 G1IeNWLCMb9PXimNRaXyIt/hlXNFvrG5pehD9iWkD7GK0RWJWE/q
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_112303_973929_C68257F9 
X-CRM114-Status: GOOD (  16.37  )
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

From: John Garry <john.garry@linux.dev>

If an attempt to add the head disk in nvme_mpath_set_live() ->
device_add_disk() fails, then flag NVME_NSHEAD_DISK_LIVE is cleared and
we bail out.

However, we may later call nvme_mpath_set_live() -> device_add_disk() again
for another NS or from ANA updates for the same NS. This is broken, as we
should not retry adding the disk - it breaks the driver model.

Add a flag NVME_NSHEAD_DISK_BROKEN to stop this happening.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I'm not happy with this solution, as we have a DOA disk and it would be
better to remove the NSes in this case. OTOH, this device_add_disk()
failure is very unlikely to happen, so we should not add a complex
solution to handle it.

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330f..2ffc11bc08440 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -789,6 +789,12 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	if (!head->disk)
 		return;
 
+	mutex_lock(&head->lock);
+	if (test_bit(NVME_NSHEAD_DISK_BROKEN, &head->flags)) {
+		mutex_unlock(&head->lock);
+		return;
+	}
+
 	/*
 	 * test_and_set_bit() is used because it is protecting against two nvme
 	 * paths simultaneously calling device_add_disk() on the same namespace
@@ -798,12 +804,17 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
 		if (rc) {
+			dev_err(disk_to_dev(ns->disk),
+				"Unable to add multipath disk\n");
+			set_bit(NVME_NSHEAD_DISK_BROKEN, &head->flags);
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
+			mutex_unlock(&head->lock);
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
 		queue_work(nvme_wq, &head->partition_scan_work);
 	}
+	mutex_unlock(&head->lock);
 
 	nvme_mpath_add_sysfs_link(ns->head);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898db..6e3c0ce09cadd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -574,6 +574,7 @@ struct nvme_ns_head {
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 #define NVME_NSHEAD_CDEV_LIVE		2
+#define NVME_NSHEAD_DISK_BROKEN		3
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
-- 
2.43.7


