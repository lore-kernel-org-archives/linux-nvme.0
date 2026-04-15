Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FCCF4384E
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fFYWmumaoIikItgFJpoGNJzTKbSZqciOMOmXWw6J8k4=; b=vRNknA/Gma1Di9gi2+MkSM2Zbn
	mlbId/QhitD6+Oj5noY8MhbUGA5m7qHfSllZk4iQOM52ud5bt8PX7ZTh1mCQd36ZOAGQZh+3KPodg
	U309CLyItTck3RQdLuj2ZPVte+Q8GlhE2SGp8OC9EOv6zCMJqwRKXNkwutl42sujUsEKW7l4EruhE
	k8ATIjP9+2MN/MdpWgEX9LUTnDnNa9g1oMSwDP2QxobZkPQAAuwXA/RTfBe5n1kiy+ZWW/4eZVp+p
	BRibV6InrjRML98ow5w+DOaHl7wbV1e9uga8XOe6Tfyc53e2TF5zLuDLIyVK40YkAJsFZ880K8WvV
	ptTrne1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD2Zg-00000001Ll7-1rMk;
	Wed, 15 Apr 2026 15:54:44 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD2Zd-00000001Lkg-3sUK
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 15:54:43 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FCgOcg1255145;
	Wed, 15 Apr 2026 15:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=fFYWmumaoIikItgF
	JpoGNJzTKbSZqciOMOmXWw6J8k4=; b=Ef6H5USOz83KhCRPvr2vHsLKTIF1E8Qr
	FtSpIg930eDAjCkX7ZMgpdjGnCHSOyTRT2UVtUtXr1aDVfCCs9NzdJRuoaAl/G7B
	X8Xn1jiKNYuLdBBYSolgSiOLJJQcZd02N3DhDhgnDOG4yjE3R173EgI9TZvQ9p4F
	T1RTPzauMg8WnH9oRVMCKAHpvlMkAzJ5SSQLgsBuijuAEGyioHOhxaycWvgL+Hjo
	Lkp5HxbwFUFZBTRY9ia40d3kNEb11NUutBReiM7DfqThKpHIqP4gFJ5v8Sv7y2Wj
	9mNuWE12+PJzOC9VDRR81q5yuaG4K93b9Jt6JyTGimcFSuSymotL0w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85jnhhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 15:54:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63FFsP0Z015568;
	Wed, 15 Apr 2026 15:54:31 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dhyk0dm2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 15:54:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4Kd5MNEoMA/O0HCFpScgdmH8+BhLwwam62durqtvAm/ugGFkyiVEfuIxRAZU/2bCf4vACwHBTuTzszzEn+yn2bd1HUwBB4MST9M+a6LPhfTaiZskNYY+qUt4OVLWDjx3uKj168uCQIaiYONKZFKYtzIaSKzpWo7+DcsTVdUJ83FGVMy2eZCefkFVx17sBgpd5Pi91hGs9VbOuO/ht7m8F2DKFFaWK6eukYgu3rjyLjp2/Jx9pWYBWGoXQoy+wff0na3gq383D1G8ESk0mkIKJHW3gOXx3V/OkwYVYKs6G9UJuaDJvPz4avDgDQPYthSZ2koevVhIcYUT30QV21cpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFYWmumaoIikItgFJpoGNJzTKbSZqciOMOmXWw6J8k4=;
 b=GyF7zPgn4IiTKQiRO5IKQJ+kNvKZo8SEbTjfg8eAFm2AjxYDfJrciIB+Qn8lOu70dRKgkrWJM3Yeay2x0O+TScD2dTlQuuLf7bZ52iVlucOAV+EP5d6aCm/oOXQ+RDPJvsEPZDa7jihdqhaDrVZTyj60ZQtMXwJBwoiF9fbyLpmiASVA2UFrk9fWoP47xqywRvbY5sY9hHyRLcLuSLKQOU09cwwEFf2eNXhKiUInXnwbq3QrHDH3X1lILtkPtPcbPn5Tvm+DH+CtrPh4kYurt/Xn+xMugFLoNGqUc9yo9+dssaOS/1Qm/8a7LlsYYCATCAvAW+MMWoNXbGTWvKLoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFYWmumaoIikItgFJpoGNJzTKbSZqciOMOmXWw6J8k4=;
 b=fuH9E05F3YOvDFvWofcEObBLxswAYNyT1ezgK7lrgZl7uud+p9yo/RjPo/CB3Sksjz49fRHQC2k90gKoFJsXZV6F14yYxHr2hybxLj2X0uG8uAEpo9o6loy4E52fs90wduvnliUCG9shUqL0tzIznGtRU84PkcuK9AxW2hTzApU=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS7PR10MB7155.namprd10.prod.outlook.com
 (2603:10b6:8:e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 15:54:05 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 15:54:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org
Cc: nilay@linux.ibm.com, linux-nvme@lists.infradead.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme-multipath: put module reference when delayed removal work is canceled
Date: Wed, 15 Apr 2026 15:53:58 +0000
Message-ID: <20260415155358.1517871-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:610:52::15) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 96153dd9-4d20-4f51-8ae0-08de9b0738c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: rBLvCK9U2jhpvTiS4DXMAtfQu/02GJWs2YdY3nibX77r1X6hu8wyeo0Vgtj0kGvBrGjQ8hsXKP4LgpO5zQ9a0tdkYHaqcRRHA2jWsc3fGU8LNi80Qqv8Lu7EwEHKbn1eRNgM2i0hCPV+PdDJ2RP3ratMkEEGBG+lcw1co7B6KeN9qPSzkmuN36Piw7b6gvHtTbuGodEd9rRcaluxLb5acfl2NpeEQjktNQwuEwdMYMKcczVuNg42WxsqFWnlXqaXRleRARF5UKjYxibnSNmYJCFQ+gi3qM0d6idbTjdyLt+OAFNVCX410d6awN0et3nLUG6uxkS1/hbG78hcZRb1SLiv7F21F3Y9jGZ34upz3zfsrrmMuyPES/IT64jPbVE/dQFfIx8hthk5RB1tRUV+QkV5weu4+57YRw2C1GsLI2uDE/XQASMIMLB46IS2QaA84pF1ds+jebnswUGJiggC1LDV34EWt5Q3wmATBveD+9QAV/Gg3oHEYuKoNK6blUGU1F+W9q8AiC+SRY9rYwM/EkicZ3YT6y3Iv8K6/QTwHWkgtZdvZjG+fNnTO86DpiPvj/MgeWWD4jRCw3HUY+cbuP+K9nwdQYU5syPx5e0P146dynlthmxgYNUPMUIrEpD477y6HHxCP5lddpqBeKDGvmjukiynKvqDMGzenTaq6IEQlzGScMVqdU5VtQOn7Evp0jp6qieMrPymgOL4V4v2/H99bZyxI2Pi1Rq9iGsyX/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLDCmze25gvF1qoJxxkzqvxSVcUoiSzRVJU+BLgt6KWZMU6QxoSRP7OL2h4t?=
 =?us-ascii?Q?ZYGrzwXUODkjQ2tMHil6HvvEuPm21NkW/4px5W4CogCISMI+9Kbhc1gn5aQM?=
 =?us-ascii?Q?F8zINNCWzKaK1xmQZ6XUIuF521wBstq7f1yrylfif/8Tsak+DoEBUfHvvtOq?=
 =?us-ascii?Q?OrjF6tdYpQ2L/FYY6MyzZsgAXyUxOLA3C3B4GaHauCbZxwleHZrbZ5ZOTUGt?=
 =?us-ascii?Q?iIZjrBf+rZf4mSBSi85eAnruXJKI7wyT0sRp4vJtuZ8/dkAO+3agNkqmNTAO?=
 =?us-ascii?Q?TAtD1ZuzxI62B39POB37195GDmy0IMDVhdFq0lA8KP5t+5wfjXVJFPFK3Hbl?=
 =?us-ascii?Q?sGjhGTQFCV1wU1eVl/E8AiTMtaH1pc0wTTM2evPdr+iCnQOniejsvKZBU7Ca?=
 =?us-ascii?Q?s7KtHGUhz4lcTNOHebLdpcc7WkfJqxkBZRrXjjimjuQSy5FvfNd5HB1phtUE?=
 =?us-ascii?Q?e2jKMD+kgugDwivyW69c8acqsaOCZ1uJzWhauJkG1tEdoROnup2jryZJHZ1e?=
 =?us-ascii?Q?knhsM/TTYF+x8IoS/ZzDVkriwApQozj6QuuJHJDGwoV+FJwm3L2wvQnFcMvV?=
 =?us-ascii?Q?lKphskPHs9R3fgeen9+WDmjSQ0kxFWMvjzdlsha054smNNs/5T5jwl1XPcQz?=
 =?us-ascii?Q?fHwF3jbSGAS4kP6qi7n0DXSxGVHZJU9CGpADwABnC4fk9XZo0CKDrB10MGnH?=
 =?us-ascii?Q?L4tmUVIClTksWEnkg94LRbzudvNGh/+H/+FfVJzP1kNlEER/mN6hUx/5eRwE?=
 =?us-ascii?Q?ogZb8HtuzbNkstdPrPRRyd7T3yeo1T9eyERhvrOmq2oPURMyYlEIBZqYDiiA?=
 =?us-ascii?Q?p3sA8rgTgAlYCI9rOnKrnJ4xaGXRUU4VZZbY1aQNVJvv7QhoTj30jz0pWRl5?=
 =?us-ascii?Q?kInGNZBKq3Oe5/n36tj/g9Tv8yiv1AynMn8EM3mVHc3iR3Wko8RCbDTbAnjn?=
 =?us-ascii?Q?Rl+HInKlrxEPfgYVra9JJnAkiwChrU/C0/f1ZdA2gq6NZwoZoQNKyenIig6w?=
 =?us-ascii?Q?QAtU70/CTlZct67+TLOMA9/pmV6a2XuvHf/wcizpk2QijMy7YbAwqB0qtOlR?=
 =?us-ascii?Q?v6OaDukjNFlmRhWoiD5E63D/jOQNFJxGhc5mGBNPV2LelvkkRKZBx4lLbCKL?=
 =?us-ascii?Q?M7K14s5hkueJ3R1vFrOGelpwYLtafMnZhZ6c7zb9fqjLwhNLMXNdI9muBw78?=
 =?us-ascii?Q?kgyd9YIAIDKqejKxImKTbySxfTu946IslrBXjvYBb4EOPIYcTlBQDSX2iMX2?=
 =?us-ascii?Q?UoPGyWhfbXxkjqbLpX3pqXsR23Y55mOIeyq9F8Wk1K/FCvIhcJ8kjvOSrmHa?=
 =?us-ascii?Q?qtacUhWKHqUBNjKVd2kd7y0Gx+lyqLgldnwRGn+D5axbnv6uj93R6d6D3HEI?=
 =?us-ascii?Q?zIab3yGmbpKz4XpVe6CFaKqOptj1j0O2gOD2gQy5rtH0X8LrG49qfvG0piBl?=
 =?us-ascii?Q?qTcdZF6Uh6VjUa5Bg+p4PL8VJx1nHD7Mimf3Spugo7hDKvp/RQ3IhB6MianH?=
 =?us-ascii?Q?2dd0qMCSeacmeYduOIO/hsAMXHvae3DSU5W1PbSaJxehmK8GjU5n8Jq7t1K4?=
 =?us-ascii?Q?oeH5Kv3Yy/f+ZZpCSJ1h2QlC1Lo8Ro+1Y/aLnWwpgXyJZMkl5LTEC6WPW6S9?=
 =?us-ascii?Q?/88T6y5Xq7mOVnYrR7IW5GwjhCVIpHItJ2xeOFGNDHqTirAYMjNr14l+Id9o?=
 =?us-ascii?Q?/VEZDRkx4nnCHojAIuvrJtwCLeHW7f5h7daRzfinYPOZ6XV7TtdppmnLiPXe?=
 =?us-ascii?Q?JhxlynEfi1pjMwXNX0VatrwJrmSR7FE=3D?=
X-Exchange-RoutingPolicyChecked: kowg3nKzDP1xUhQR8oQNIAGbHn842YmI/OQ44yu6ghyPWuoQBNeO+zjnzcxXx0Y7Zvr7ncLlArB3VVJcNvPfWVEW6sCOcHXbLjpmn5XZfHGkpKWP2HcmqXgFuaZQt5cE52CmkaeIorXyXSA1ylfYiZ9hlwHriMel8FO1RkoVAtvuD95ukSV3PZTV/GO0FQ2jCf5RJULa3xqvFXx77B60aSOKb6Lj5wnEGRgd2DwuKtx5ExiNcVUMajcG9CJjzpbLlAdp3z9+FibJ0liNfWqVm6YUwyVm5A4QxE+uXsnxzsqPQhPdscRp7C1hYGqNREZR29SWKCgoq6RYFIyqrgxMdQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eGkoYYlampo2SvqFixvaNs4DLPO2SC0N9ndrZl8UYe+NzVvug6Ga6MhH2uSf0gagCbTEUw4ZTXIgKKkod4yu6hBboJc8A0qv4W3OWSC9OTNet9287uOlQQ/lDa05feC1B90BUqvGhjY6I+YHLRoq0i4fFQr6n2xOdf1hzIbnm+FZNhnOR8/8gatGPOnV7bs8cnDwELxuI4MXCxRrtLoV7n/vQzA+ZY2CFPjOoXv6nQ3YBtN+ED8I8dbswd8D/RrMFuAD9FLAAUd8unF6W5/UgR8aqLuTBzlHisNVjubzMPSmnDlMNi5ch8QWMqc7yQGN3eiIjOyDdeV41EaWzq9GlaGD0imGFcT2PbWxDcH2OYhdeVyunAc/CPDK+FoSTFA9jMk/WwpXIsDXIEjDaw5jyCRBFbd1LvDMGh0ZoHyf0DvE2Ej8u4fkAYKmw60RRi+lbraEKZAI2DDJd9+EuELBE+uDKEooPhdccWDEpAC6Q+T9UtwlgXNo+YXMG4RucKv1+b+qlIlhJfIIhMn8cpibaiUTQxy4Dbl/z9w8RUNAvS6NNMo7NZrNoGZZ8OIgWpATqJV1Kx7ySLkNBlHResFfU6XAwV9coboObzwGI8dxTpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96153dd9-4d20-4f51-8ae0-08de9b0738c1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:54:05.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjZ3+QI5W84Abdd9m0wqnoIR2KrUxxZMj5IyMUcNeNANW8JhqhntaWy7sijdMBdpMsDn7Da1K3lve3r9AV0jzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604150148
X-Proofpoint-ORIG-GUID: 0HjmuKieo9ZIlWURc_auGTj7kVCQKYnL
X-Proofpoint-GUID: 0HjmuKieo9ZIlWURc_auGTj7kVCQKYnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE0OCBTYWx0ZWRfX1iTUImwd1GqZ
 JgkEDrjKuZF/0xO2/scAqW51hJVXFHYo0JTTa7XaMnrV5yJQ5RQZrRiTKA8fG1P0igg5UPS8S7s
 qqfDzkvayNal9WT+iNl5oPJ+VXONtAwIEZUfTkDVnvceLo4Omtx+zhLcIcjPhJ4/i1p/7rZ6BZR
 IqHfluNraacyci3WLAzg95diE6T8/y4gAZ5qll6kNfCgfVcNntR+KutLECvT9S7z5BDR47kKrXv
 GURXweQCh1SrlDSE7yyoeJ4slAAwvx4UUvxliVJ8waj7vF6KU0A+qtV7ojCxTyJXvY5I5wjOyk8
 R9z6t/YTmlS3H823AZhaYnzEeRDDELgdMC8jsuh3hbywoMwi9lxsWqZN0iFX8exzcEjO90vHv5j
 I9E69llupIhlOgB5LAs4dlj5zSOtiOJPc75KE8maXZKq/J3Q4ScsnSrw7UqucT3IeAfstGMKViY
 NTmXKwIu6Kexri01seg==
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=69dfb4b8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=0daMhChr7JUPJKMrKoMA:9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_085442_076409_37C5AEA6 
X-CRM114-Status: UNSURE (   8.85  )
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

The delayed disk removal work is canceled when a NS (re)appears. However,
we do not put the module reference grabbed in nvme_mpath_remove_disk(), so
fix that.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0d623476e36f8..fead3b7cd4bea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4083,7 +4083,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 	mutex_unlock(&ctrl->subsys->lock);
 
 #ifdef CONFIG_NVME_MULTIPATH
-	cancel_delayed_work(&head->remove_work);
+	if (cancel_delayed_work(&head->remove_work))
+		module_put(THIS_MODULE);
 #endif
 	return 0;
 
-- 
2.43.5


