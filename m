Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD216C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkDaVN5otml0YbBXCubaItSaiVGF0Kji40pigRhs3uk=; b=tA3W4Gf+hq36egrjKzI4SF8HK7
	gzIPq8rDokpS+4RFhcFtvFffmF31ebK1CxpPsjExCN9nl+l/Q5zg9saEIogTBHPDgui99deFvYhJD
	JFPSdGHfExafdAqjJWZS9kAcnttmCOAMZrKIGjtDx9oiTZS28C7PstXGknHBgyyQ5BelMCghtr/zq
	Z2jZ8qH73A29BJTFe0cdnYHmO10Pv0kgUgCHvBxOgQqaOSvg0pnGy9XMMXPkOlAqbaNkNBzOdSnW9
	N/iTyd5ne5iV2IkbPNSt22v03vRLbh/LnIh20pwXoAZWtZEo7cT5ggJU4OsZYmxRC33Oy5NFKSwFe
	HNIzZGOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjE8E-00000008v14-307s;
	Mon, 13 Jul 2026 10:43:26 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjE89-00000008uyr-2Zd7
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 10:43:24 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CNF4jP038724;
	Mon, 13 Jul 2026 10:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FkDaVN5otml0YbBXCubaItSaiVGF0Kji40pigRhs3uk=; b=
	qaKz1sRMFMcaRGmJyOte0C/n3VeQiIqDbsg0NPWW/pm4TvKomx7e06GgLcA6CgeJ
	BkDYJt6pKinT7DTOOvlE/6DBtvcb32zZChb+PWwacr3tpJFfeATUklPU1T5eJ8VN
	m3zIr5URtFeq8ByPR5q9pdAIeSzg8jneUtel6aiQBqR2a05jTH9qn7AnKmtt1jGE
	g3vsmD31M52DJVt0K72NEfvRPBChfEPAWQsfRwz439Pi1LCOU6M4gOAsZdY+QEf0
	Jw9w+di628cDXoPZuZ88VDpMTNwgnj9Smf+eOvTA6kUKh5UZNCLTPOhbBKnVrEIy
	bBqUG5BeAYEM2bIzc1EcJw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbep31xjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 10:43:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66DAh7MD014722;
	Mon, 13 Jul 2026 10:43:10 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9cde17-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 10:43:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af/RJ4dDm4En57QsQ3HRplhWKguOs9Hh6BTSUXI7rrZbpiaX5zGYnVc3KnPjR9P1umo+o29VfoGlSUq3t0pfwQpv9wPEkfbHahKVdxcWd805dX7by96+0gCMWwPx0PQlRAes3pLTYzF2Bec95ktpnBfPAOwHINAaiDKbvpOiGj2l8u+XCZrMZ1lxuRpfTPUaGnCGrtCu64ZQ7ZLaA2+/qhT7fhwo6P/0gGadpghD0S/oMmhEO3ZOLRCc2nH2/D6P85KkZCxtb8Hhjgv6kpqqIXb6VhWwns5BYCEySLuVJl6VOMAwH/68i8KHL8orKnkXmIyeLaJ0y6xrZepjaY9w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkDaVN5otml0YbBXCubaItSaiVGF0Kji40pigRhs3uk=;
 b=JxIbxiayGfwln2sRTwNyDzpX5SNLJsA9LEcq89/kGBr7yhSt7mZScAvQ+Iqyc8tk3TZyMGLzsj39kZo7q/ZqNKQY2Xgeu1xEOsyl+KuyxK+shzFt3To3DCCy4meRxxXVSSyFY7pudGkgA49ErLIs+wtAK59ggQ8kOaZmQhas/zoPvl+568aMzlXOy9DoEuL+qmPAh0ipUswcsqIJPcJyUDX1QU2Rr/bsAXwI2TyaQPAN5dy5bdrv89OqH/ZnXghIItTnMjQe/oAHtMdrEVemPTrhMAFkpo0jIMjKuhEclVuzFdFu8+l4or8NVY/3F+a4ROQVNkYs60qFZmdHsx2ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkDaVN5otml0YbBXCubaItSaiVGF0Kji40pigRhs3uk=;
 b=c7wWy5YviyIwTt9zeUxPFaeYJXskjnwiC0Q9dJxqMonBST9ANPSsFCtvcHu7xzgygTXj5J+3sYL101kO+uFB3AE/j34o9U8/cn5Wnb7rx4X4ezjIJJ84za0H0H0yKo/8c6b37Xaxx4oY3LFEy622DOK97dlzMaJ7aR5xduDeXug=
Received: from PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11)
 by SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:42:54 +0000
Received: from PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d]) by PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:42:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 2/2] nvme: fix cdev lifetime
Date: Mon, 13 Jul 2026 10:42:38 +0000
Message-ID: <20260713104238.3034640-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260713104238.3034640-1-john.g.garry@oracle.com>
References: <20260713104238.3034640-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To PH7PR10MB6228.namprd10.prod.outlook.com
 (2603:10b6:510:213::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6228:EE_|SA2PR10MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cee97d-6cec-4926-0a61-08dee0cb7e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: RADbn5gLwLQ5+WhjDthazdqldHfk9lg0VERuprWKxpg5KziksvB+InyT+yZ4SCWZE80ZU4dAy6TZoqaAyLIb6U06dHWGSI48l+JNwaBjgicrE4Ql9G1HqFb490fARzHu0uNCFqC4KCpRZwdJH0W2IYc52X3MtcDVqSOTvnSVuO0cm0BQeEw9ncnlhFq1YonkCHZ1wVFw6X1R6ujzIT0CnGaCKjEAU72DZbmYBR5g+mD/JgG4yVd91313JnN9dXtxsMfH2r6AiXjRWha+y++SN1mYackfccqVs8+MpbmgtETCk4AxuyrEjejwoIrkNYsJBKHf+nxKljnkmzFUX0MZCjqN4nqvD1JuKzRWKmZw/JvvOzpuVmiAPDRPYzImgIZ0+4i79RNfWN9tgvTG8PDow8EUL6Ej02/HXGCwOStbCpLTR45Ejms2uFKQA2QkIO5NfIJt98X7dEZdZVMlyOMyRt/9AfLnQCszXLf4nvgIbXtMhxf4VqhnpCU8v1zorb0d8jZXxPaWca34102AK1FV0OS24MfbbqaVsqoFtDNvBIW07gfKds7Fv1nfcwkUqqQSTV6rQgmgNjalO1F5LABQr1c6QPKsah3fdztp4SXEZmtAJrtcCxgFI3PUufEAxzot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmbolVkAi2gkRCcG8FoyqVXVHJRMiHn/RGCrsA5CVrnjfBArCdXhJiPKxWaJ?=
 =?us-ascii?Q?V74oB+H1pW4T4Eao5psEMPJF8CNF22wsWcs9ucNaoKPyEd+874bwswc3cSDT?=
 =?us-ascii?Q?13q1WcyIJFAvAJZCvEB9KSfMjrGv4/djuoTCz9MxAd650JjtoP/mkzjdL45Q?=
 =?us-ascii?Q?Npxnz47QuTUkshJ5IbHTTiMmrTXNqNVmXcYsvt1aLLRfd0aU0kfN8mU9mSY1?=
 =?us-ascii?Q?LUPO7E8cVy7xgsipGnzstWwaviziekpBmbw7aR1HJ6VeQ7pTxwH01sBhIJO4?=
 =?us-ascii?Q?urnpe8pYCSEpvmC4nE5S2xfXLYBzwlw0hNfdC8IrzFWvzMxtfZ2sekJ/2Mt5?=
 =?us-ascii?Q?AIWMqrCuyZmHE9yG10Q9H9g2EO+Vlt89ytY70Tfnq2wdLHA+mLndOdpDClrX?=
 =?us-ascii?Q?Q2QwKNGkGIuTE5R4lS3+H3mkpkenVGbm2fpoWJIktO1uWROMCbax7hJN3klP?=
 =?us-ascii?Q?FttT0NRclBuUGbEqyLIk2IEZNksOl3Jr13Zyb8JH9G9MSN4H4XBWV30tGItd?=
 =?us-ascii?Q?kq8MPiw+D2Pxu4U4Sagw4CbexD/UQCtuo13i1aEfQinv015D2cbnsVBSyXuj?=
 =?us-ascii?Q?WRIgSpwxPP4CxA3qVTSZQ7HcrxQYMs/NJsJqQI/q6lulIXIn8yiDnElsyTlW?=
 =?us-ascii?Q?tj3AhLk9Mj9eApeDI4XdyVls1McMU+uUcaFsaYq/SR9B86Ka7cHG6Kz4IW4Y?=
 =?us-ascii?Q?2sQWUHR3aK7utq71X3ufCnt43f3oGnlrYud+reL/TUcctOYi9mH/sWaJfm8G?=
 =?us-ascii?Q?JZgHrvdXay+M4Vo0HyD8uTcaIwj0lbyyLOikgdiu7cpuONjo7ieRc2rBcO0K?=
 =?us-ascii?Q?HUuphEArnv1Sn36MWyKXhIX2z0cfiVWnHmoa8PiHH5MhU9jNBiHF9jjvHf/8?=
 =?us-ascii?Q?wOI4Ehi00EhjDdYnAlqvDrusYAy6mK3dO3meuPv37bU3AkKpELNYDHE8S7sR?=
 =?us-ascii?Q?8KrBwkTiHAOYyHBukgp9nGtr5NWlYA1jkxo3Rop2UQRl46Il8TwRx9C88+Oq?=
 =?us-ascii?Q?6kO+x13/nU4r/x/QFKcBiC4mhkEu3g2JsL9dpxImLDsnTZHUJhoojbNIB+hH?=
 =?us-ascii?Q?G9QT+kVgWivePaNhucZcwwrH2/xM2PtYfjPfbD3qGT/akf7WztRPgBR/GVxe?=
 =?us-ascii?Q?eeQV4n+0BVFhI3YeSMh88Ref1eR5VRmVzM/Z4Le6w5jyX42qMKZzY2D6Xu8s?=
 =?us-ascii?Q?MrfouNa2zDICP+MNeQDrMVaLLXbzAdUxodhYY6cBH6ktEcQAVeuYmf9daadz?=
 =?us-ascii?Q?kuPoJk+NEvSRjwkzUThV5OVyCHPDfMjVQt9/DpfZIGeNSONhbPYlCBo4W/Ma?=
 =?us-ascii?Q?N2cfSCKsh7s0y+22feeIyGQK+cuLRDsogQdq8eA7VDWzrwXLtBceS9CcySy/?=
 =?us-ascii?Q?ZMNd4wh1HRKx79jQ+B3Gq6ewwoXnF8BYFfPKkkX6V6aIg6gMYnuD9RXwPt/a?=
 =?us-ascii?Q?C+pYf/oLH1x/v67+WD/9K86Gz8aqyuRLPbqjBXfOsP/JamyI72ACOD9T+2u9?=
 =?us-ascii?Q?QncsY08Nj1z/xYV48y1GF+fE/OCJOQDkaZwWZ6pjCA0xCLjpvnTVLYkN3tD4?=
 =?us-ascii?Q?WY65+5yST8mScsPfz2fybUNsPHA5WskW2aIhZSo4oXJnW5hCv5Rdaaid8cTm?=
 =?us-ascii?Q?VwrpB9EX+4ofv+QHGF02Arft/UcZm89rmMP+Jvri5lzIfYLAiCL7m2NYa0Wf?=
 =?us-ascii?Q?uo+9qP4cTr8SGByODWZzixV38pi5uoK1crdUSyIQZ31qvg0sN5lsdcdZBLiS?=
 =?us-ascii?Q?pu9cfIV6HQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: h9vH/CApsQcT6JAxUjgSwGkRN039doxwnoawlG/zCfJ32Nhoq/x9LHUbKD263xbws3l1TiKv4jcPGzo2sgpLQVrfVfHRguRv+QmMZpu9P1wB/YrRrYhYiiNt0LWTW7Z47yBGUX91VYVHzBqwK3MacGBFkYyh0gwImIUG12GVeA4ikkuDLgywznbMMwKPCrtlhWkH5Q/vjXb3M1tVK+9KDvuuihXfX5aqW8i5vVdC8O6rtMwXXhkLOulc+GC6hctpPQIGiWi2NfeQhlXkh20f+QqcPE6RU/C3d5B/AF4rx/4mwM7Mf7JcwlOoby0vyhIwW2Guum9TTOJ5vPHNz0m11A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wtR8vxN1LwsFbephdObBBmXm8M9q5u5VBp/IK0+xXOsY9rpgNbxDOYY1AZE/yTMNurP7VhCB2SUB/mXjFGUzzHU/MJw9OcflTJmna15qMpoo6H1TIv8FVnUUPrwtDn4wUO/pYpglgfv/ZNC9MG+IJkO6hc1heKP8ZDb0hOF+taQJX66DJ1Xw5jnL4pcJcqjNyhGv3xiHjABC37jjtUXvr5CClTiaACTjTqZr28tm9XnF1e+w4G2y4vdhxo57UyFxTb6yQ4p88p0O8T8TVQO1kRq64PTtQkXmWBvPO8uEIJUpf7sbVEbr5YVBih4L9U7FRJyL0XmvxMwmHcV+qvtRCyMTh9Q0BLLZy/1f0iHSHt9Vu+AIaZqEKogNXpEjOrXxf0i5QOP2cWIbC8MNZJMWAQikmfoHBPlLGfelNBoyed710mas0Naq16h9ZNYWPTcCHJ2vCJTrCqBdDeLDb/ka1vhkJwBOdqCxiNGnSOAb2UlPoNjFWqCvxysComB+fqw1Z1E8obsVZX3qR/ajF6muGW0bL9VRs0eX46Yt8mfC3CujM9hoToRIJOz4KGjPyg7l/ilPI7D9OcUj1G8ZbZ9+S/gRic/kj3JApBcKEGZN+JY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cee97d-6cec-4926-0a61-08dee0cb7e6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:42:54.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0+jfmLDYev4oNhwhwMvhglxaesmyldIA/RYIAsK9LT5YIYbODn/6MWWHQjFhYeI574P2qVlOUmlrWoqrFUHhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607130111
X-Proofpoint-GUID: eillyEKZeNez7AUDjztqZay4C4wvT8iW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfX6pjufDjSZKTv
 CwL54fYFmEHO7jyYfhm2/bl7+FoliGRKzNFsUQ4dU7TnEfG7iZWp9NUm/9mDE3VJ32z320H6JZr
 ropJtgEGKiCDfZq7Zhchg5f/Xp3G8efEIR/uJzrWDtKk4DAaXN3D
X-Proofpoint-ORIG-GUID: eillyEKZeNez7AUDjztqZay4C4wvT8iW
X-Authority-Analysis: v=2.4 cv=dYawG3Xe c=1 sm=1 tr=0 ts=6a54c13f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=mQViX6CVFjoW4UvNsSgA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfXxozovBiOv2oK
 0H4OMqMXj8ruX3MM9e0R3tEVH3heRikOmtMiRM7GWoKH0Rq7d0nLeZb5luPGgoVAUElytRlMOww
 +hVfjzrTKYDQJmVNot6ZCGTirXOifDFtQ0xXY5M8Tq8wQnfHnlcARZDHf+FM3te3Jn3GS824eH7
 s0+NX1N3yiibsje00sZAKU6Ebb3SmuvQFml+GTJPzo5uFiiJfStZ/A4YOA0dB9b2TJXugwxP5Md
 b37MB87WEUooi/5YoLD/byNDe7/bnNIb3VOHe4nshKRLoeLDtKdFvwFJ47pGO3ZDrAJZ8C77wCo
 al1nMzOgH4aYORBpfaChLE9d2hhPYhv+cnp9RgKvwN4ruc3+3HlHwOgTGkPJTZCX7VDmIqiDCkW
 eRDUeVpfS9TKMXhjW2yHNB5JUMhj30DBP8bE0LO4RmQTn3OW19wTtYlHdT2e04Yno/F8c64KAi3
 xTu5EjZd+QM5vI85ODA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_034321_862629_1D6F4FEE 
X-CRM114-Status: GOOD (  12.74  )
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

Sashiko bot reported a potential problem for the cdev lifetime in [0]
- the code there is heavily based on the NVMe code.

Currently the NS head .open and .release file_operations methods take and
put a reference to the nvme_ns_head to ensure that this structure does not
disappear while we open fds for that cdev.

In multipath mode, when we teardown the NS head, we call nvme_cdev_del() ->
cdev_device_del() -> cdev_del(). However after cdev_del() returns, cdevs
already open will remain and their fops will still be callable. As such,
we can still reference the cdev after the nvme_ns_head reference count
drops to 0 (and is freed).

This can be shown with an application which delays between opening the cdev
and issuing the ioctl while the NS head is being torn down:

# ./ioctl_file /dev/ng1n1 &
# waiting 10 seconds ....

# ./ini_nvme_teardown.sh
[   21.221718] nvme nvme1: Removing ctrl: NQN "nvme-test-target"
[   21.274609] nvme nvme2: Removing ctrl: NQN "nvme-test-target"
# now going to issue ioctl ....
[   26.549285] ==================================================================
[   26.550841] BUG: KASAN: slab-use-after-free in cdev_put.part.0+0x3d/0x40
[   26.552352] Read of size 8 at addr ffff88811e7fa170 by task ioctl_file/237
[   26.553805]
[   26.554227] CPU: 3 UID: 0 PID: 237 Comm: ioctl_file Not tainted 7.2.0-rc1-00004-g6852a10e32d4 #921 PREEMPT(lazy)
[   26.554236] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   26.554241] Call Trace:
[   26.554245]  <TASK>
[   26.554248]  dump_stack_lvl+0x68/0xa0
[   26.554266]  print_report+0x10d/0x5d0
[   26.554276]  ? __virt_addr_valid+0x21d/0x3f0
[   26.554287]  ? cdev_put.part.0+0x3d/0x40
[   26.554292]  kasan_report+0x96/0xd0
[   26.554300]  ? cdev_put.part.0+0x3d/0x40
[   26.554307]  cdev_put.part.0+0x3d/0x40
[   26.554313]  __fput+0x7bc/0xa70
[   26.554322]  fput_close_sync+0xd8/0x190
[   26.554328]  ? __pfx_fput_close_sync+0x10/0x10
[   26.554337]  __x64_sys_close+0x79/0xd0
[   26.554344]  do_syscall_64+0x117/0x6b0
[   26.554351]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.554358] RIP: 0033:0x7f938c067727
[   26.554364] Code: 48 89 fa 4c 89 df e8 28 ad 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5bf
[   26.554369] RSP: 002b:00007fff49f05980 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[   26.554376] RAX: ffffffffffffffda RBX: 00007f938bfd7780 RCX: 00007f938c067727
[   26.554380] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[   26.554383] RBP: 00007fff49f05a10 R08: 0000000000000000 R09: 0000000000000000
[   26.554386] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[   26.554389] R13: 00007fff49f05b40 R14: 00007f938c207000 R15: 000055c148471d78
[   26.554397]  </TASK>
[   26.554399]
[   26.575612] Allocated by task 100:
[   26.575871]  kasan_save_stack+0x24/0x50
[   26.576157]  kasan_save_track+0x14/0x30
[   26.576418]  __kasan_kmalloc+0x7f/0x90
[   26.576668]  __kmalloc_noprof+0x281/0x6c0
[   26.576938]  nvme_alloc_ns+0x7f7/0x3170
[   26.577206]  nvme_scan_ns+0x508/0x880
[   26.577449]  async_run_entry_fn+0x8c/0x350
[   26.577723]  process_scheduled_works+0xb6f/0x1a00
[   26.578034]  worker_thread+0x4ad/0xb40
[   26.578283]  kthread+0x34f/0x450
[   26.578501]  ret_from_fork+0x563/0x800
[   26.578752]  ret_from_fork_asm+0x1a/0x30
[   26.579012]
[   26.579124] Freed by task 237:
[   26.579335]  kasan_save_stack+0x24/0x50
[   26.579596]  kasan_save_track+0x14/0x30
[   26.579855]  kasan_save_free_info+0x3a/0x60
[   26.580131]  __kasan_slab_free+0x43/0x70
[   26.580388]  kfree+0x321/0x500
[   26.580591]  nvme_ns_head_chr_release+0x39/0x50
[   26.580883]  __fput+0x352/0xa70
[   26.581095]  fput_close_sync+0xd8/0x190
[   26.581350]  __x64_sys_close+0x79/0xd0
[   26.581595]  do_syscall_64+0x117/0x6b0
[   26.581842]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.582176]
[   26.582286] Last potentially related work creation:
[   26.582593]  kasan_save_stack+0x24/0x50
[   26.582841]  kasan_record_aux_stack+0x89/0xa0
[   26.583210]  insert_work+0x22/0x170
[   26.583442]  __queue_work+0x7b1/0xfa0
[   26.583682]  queue_work_on+0x77/0x80
[   26.583921]  kblockd_schedule_work+0x18/0x20
[   26.584207]  nvme_mpath_put_disk+0x42/0xa0
[   26.584632]  nvme_free_ns_head+0x1c/0x160
[   26.584904]  nvme_ns_head_chr_release+0x39/0x50
[   26.585208]  __fput+0x352/0xa70
[   26.585420]  fput_close_sync+0xd8/0x190
[   26.585677]  __x64_sys_close+0x79/0xd0
[   26.585924]  do_syscall_64+0x117/0x6b0
[   26.586173]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.586505]
[   26.586616] Second to last potentially related work creation:
[   26.586991]  kasan_save_stack+0x24/0x50
[   26.587246]  kasan_record_aux_stack+0x89/0xa0
[   26.587538]  insert_work+0x22/0x170
[   26.587770]  __queue_work+0x7b1/0xfa0
[   26.588010]  queue_work_on+0x77/0x80
[   26.588247]  kblockd_schedule_work+0x18/0x20
[   26.588529]  nvme_remove_head+0x3d/0xb0
[   26.588787]  nvme_ns_remove+0x4b2/0x930
[   26.589040]  nvme_remove_namespaces+0x29c/0x410
[   26.589340]  nvme_do_delete_ctrl+0xf3/0x190
[   26.589611]  nvme_delete_ctrl_sync+0x71/0x90
[   26.589889]  nvme_sysfs_delete+0x91/0xb0
[   26.590151]  kernfs_fop_write_iter+0x2fb/0x4a0
[   26.590452]  vfs_write+0x929/0xfc0
[   26.590688]  ksys_write+0xf2/0x1d0
[   26.590923]  do_syscall_64+0x117/0x6b0
[   26.591171]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.591498]
[   26.591605] The buggy address belongs to the object at ffff88811e7fa000
[   26.591605]  which belongs to the cache kmalloc-4k of size 4096
[   26.592409] The buggy address is located 368 bytes inside of
[   26.592409]  freed 4096-byte region [ffff88811e7fa000, ffff88811e7fb000)
[   26.593205]
[   26.593321] The buggy address belongs to the physical page:
[   26.593701] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11e7f8
[   26.594250] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   26.594743] flags: 0x200000000000040(head|node=0|zone=2)
[   26.595093] page_type: f5(slab)
[   26.595312] raw: 0200000000000040 ffff888100043040 dead000000000122 0000000000000000
[   26.595810] raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
[   26.596309] head: 0200000000000040 ffff888100043040 dead000000000122 0000000000000000
[   26.596806] head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
[   26.597313] head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
[   26.597813] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   26.598317] page dumped because: kasan: bad access detected
[   26.598676]
[   26.598784] Memory state around the buggy address:
[   26.599093]  ffff88811e7fa000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.599559]  ffff88811e7fa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.600023] >ffff88811e7fa100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.600485]                                                              ^
[   26.600921]  ffff88811e7fa180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.601390]  ffff88811e7fa200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.601855] ==================================================================
[   26.602374] Disabling lock debugging due to kernel taint

When all fds for the cdev disappear, the cdev removal path puts a
reference to the parent object, which is the nvme_ns_head.cdev_device - see
cdev_default_release() -> kobject_put(parent).

Fix the lifetime for the cdev by making adding the cdev add take a
reference to the NS head and drop that reference in the
nvme_ns_head.cdev_device release function.

The same problem exists for the NS cdev lifetime, so resolve that issue
through a similar method by taking a reference to the NS for the lifetime
of the cdev. Note that nvme_ns_chr_open() -> nvme_ns_open() also takes a
reference to the NS. Now that should not be needed, but that code is
common to bdev ioctl, so keep as is.

[0] https://lore.kernel.org/linux-scsi/20260703102918.3723667-1-john.g.garry@oracle.com/T/#m67265e2906d617acd2743c0a00809246d0cfc506

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c      |  7 +++++++
 drivers/nvme/host/multipath.c | 22 ++--------------------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd45e42be0f5b..822562264d081 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3899,6 +3899,11 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 static void nvme_cdev_rel(struct device *dev)
 {
 	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
+	if (dev->parent->class == &nvme_class)
+		nvme_put_ns(container_of(dev, struct nvme_ns, cdev_device));
+	else
+		nvme_put_ns_head(container_of(dev, struct nvme_ns_head,
+				cdev_device));
 }
 
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
@@ -3964,10 +3969,12 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
 	snprintf(name, sizeof(name), "ng%dn%d", ns->ctrl->instance,
 		 ns->head->instance);
 
+	nvme_get_ns(ns); /* Undone in nvme_cdev_rel() */
 	if (nvme_cdev_add(name, &ns->cdev, &ns->cdev_device,
 			&nvme_ns_chr_fops, ns->ctrl->ops->module)) {
 		dev_err(ns->ctrl->device, "Unable to create the %s device\n",
 			name);
+		nvme_put_ns(ns);
 		return;
 	}
 	set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8cb417036fe17..c850a4bf73801 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -630,28 +630,8 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
-static inline struct nvme_ns_head *cdev_to_ns_head(struct cdev *cdev)
-{
-	return container_of(cdev, struct nvme_ns_head, cdev);
-}
-
-static int nvme_ns_head_chr_open(struct inode *inode, struct file *file)
-{
-	if (!nvme_tryget_ns_head(cdev_to_ns_head(inode->i_cdev)))
-		return -ENXIO;
-	return 0;
-}
-
-static int nvme_ns_head_chr_release(struct inode *inode, struct file *file)
-{
-	nvme_put_ns_head(cdev_to_ns_head(inode->i_cdev));
-	return 0;
-}
-
 static const struct file_operations nvme_ns_head_chr_fops = {
 	.owner		= THIS_MODULE,
-	.open		= nvme_ns_head_chr_open,
-	.release	= nvme_ns_head_chr_release,
 	.unlocked_ioctl	= nvme_ns_head_chr_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_head_chr_uring_cmd,
@@ -666,10 +646,12 @@ static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 	snprintf(name, sizeof(name), "ng%dn%d", head->subsys->instance,
 		 head->instance);
 
+	nvme_get_ns_head(head); /* Undone in nvme_cdev_rel() */
 	if (nvme_cdev_add(name, &head->cdev, &head->cdev_device,
 			&nvme_ns_head_chr_fops, THIS_MODULE)) {
 		dev_err(disk_to_dev(head->disk),
 			"Unable to create the %s device\n", name);
+		nvme_put_ns_head(head);
 		return;
 	}
 	set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
-- 
2.43.7


