Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD014C44506
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 09:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=boYadVShqt9ef9fOV27lFWxfri0Wd79Isgogiv61oKM=; b=IDJA7wXes2CS/65IYc3z1wB+99
	lS0TdvNE/J6Y9hnGRpPzluAdm7l1Dh8D1GnkNRtJjbVbm8oOaLl5hOXneK0BARVXQkKUaeDDqI7j/
	EiBGxaJOPBpDveR5vG2OGV+W+WIYxGmNzcZc5gXSZmvaCvqHzRY/uMKchTXl69AV76PHS4c1B5iR+
	KFLOyalSD4CUGHwC6fHCk+IhuJJ/XxaSrj6wKyl8EOO8b8FGLafXUqTwhTOB350XCOkHfLlZeKS+J
	S8fUOLTQ3ZWWD1x77AZGeSvlGljlhTyMqcN5JK1GquMR68YVArjN1Hx8ifu5R8BCBuz6IAYsnuBZ5
	0ZyrvUwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjClr-00000008hG4-2XHS;
	Mon, 13 Jul 2026 09:16:15 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjClo-00000008hEW-0k8L
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 09:16:14 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CNe7s9113390;
	Mon, 13 Jul 2026 09:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=boYadVShqt9ef9fO
	V27lFWxfri0Wd79Isgogiv61oKM=; b=NEPQogFJnKBBOHCQ9HCXKoB1gofySVUQ
	OwOKJYwTOnoSa5IewbYTn1SZKJqdgnuag2nMYd5jJjal8A0/eOUxTAVQd8RqBvaF
	p16Esa08lp9DF5rRP/PigM1Fauq4Esf96cGguXk4MjF8sh6geTksVwKbF1JXLUF7
	sgjJV/5MAGUb71nb/V24MwFAXpNtzpZEAiwyXEVSTpUlkhBBrfvAS4iTmkbge8yV
	4s6u7YwBsewWpKDARCgvJzEnfhz6/2DFZFl0K+Als6njnevSQXxI+fGcDAjbfm7s
	ojOs0pi1vAD5zNalPSzRs5SCnGIRnU9ubiVeNmjvxAy11eZDL7DVdQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbepn1u60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 09:16:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66D9Dh87006816;
	Mon, 13 Jul 2026 09:15:59 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9ptsce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 09:15:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqB2pP6dpJykqRyk5dCwtHVnZkfCLmr5+gn245sXyAbedo+5KGAiH1M8JiDIlMBp+oi/crdaKjGZmXy4QzHggQKMNNRpy+CwnfvoBh5XQcppR7OAYWXE5CxAQpr59JgXCfRqYddAlm7gKoHmONkisb3kBPRDexIuu+Nd0QkV6ajuZPkxBU9lFl2qpW+6VOc3tL8Ztzk2CFE4Rjf6sigKuaBvcv/7idnhBYFx7LY0s7pnbmu1H3mxn2Cf+FbY0TX6L0S7agw0RlgPXEF1Pe9jm32vWpgwAcO0BWasVTtrEGDra/Oq/LZq3Gz8nIB6m2F8gwNXFu7SgNUv3jun3nyKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boYadVShqt9ef9fOV27lFWxfri0Wd79Isgogiv61oKM=;
 b=PGiZ3V0b7NKfUzg8WfhfRm38RHMliCWIIsuIojcoB1xtY+NTdIPt6BOPlCRs6xEFPE1tvoikvL8BW7SDrG5gZDgxbgk7bNcincYcYye4HXZ/q8MA+3qlZH9+5B3PAZhEa2LWjSeIW/DYNoXatkYLh4I1Po0wJ0YxzyP5tcJiTVaEsCc38snaNHdl4xRRgak564lGvBweZTLRdqpFIp0bpdZMhtWPnVcCeXriFjeFCtlaxRXmK/jjgjHWiSJjOEYiVoZmicQc+6x1/fKCqv/b0Dk6rJCiiv9+6CjKVSZ3dIw4sxOVMdTC836miawgM8RBx+EtnV/pVlxSEE8M/gkjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boYadVShqt9ef9fOV27lFWxfri0Wd79Isgogiv61oKM=;
 b=orX03R4gknNOnpzKL7TTaPHDR2Hb8lFTCWIbAJrGdWp+UPNwL5C0iAkm/I3tjep+ipV8AH2SMo4Ip1zxjpsRP56djTdhBgXl0Vr8CJOoB6fbsqrne0e37lLapVyqpPzyOw1bR4W5TckcM8tzFokFIaw4nAyS7bIjM8us0eR54+o=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH7PR10MB7695.namprd10.prod.outlook.com (2603:10b6:510:2e5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.18; Mon, 13 Jul 2026 09:15:55 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 09:15:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] nvme: fix cdev lifetime
Date: Mon, 13 Jul 2026 09:15:46 +0000
Message-ID: <20260713091546.3013427-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH7PR10MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: b180b1b4-1e3b-4e3a-c631-08dee0bf5751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: BJRb1KPR9bS1gm7FsfEdtXJJzsA7d7D6Nm+LuLlgnO0BxA1LoeQft9GZJvppdLJycsYvacGRp8brKeO/p8sG6o4bNVgpLNkd37JQ/mfzcQfAH0FgiCUNYi4NJx45dagBoyrVkyvUf8sK51wPkOJ20hh4/j+EPsWuwpcaGRAKYX7p1RvFMjyce8AD0B7+tDOzWALd3YzQISh9BCb/5N/840Ay9He44mHefhbHDaIWva/UoqTyMg+FeBArTKIzF1fNOAKst8kzN6+fkkqy2eL5rsF4KA3Ua/p/v8iWxCUwCHIEu79AttSGIcnmCP1oWF85fB7jYjsnfBInV4NIv6x6Kly6QNSiK9AQrU2wrfki6Tv7yobLcxbK1zlUg8B2AU87LGx+5OXpBR7gTAW8KRYWPvbUty0HuuiB/gDjizRidGoYWhV5erFzjkbY7JW3817b+xe99MwzVwjgztJNX9VS+3MMo72VvSWwwTPXc++dy+0watwDm/wpCDO/CSlJD4PgWpVGyJYUU6qz5B/9igeqHLlYzJaJfnSOLPyRLJVMLFu0fga9yqT10SrdHjjXcpqTHCrs8WerI74xU1byEDA1DBhXn726N5g02S90lX5TA2ahtV+7K2mscTU9qdPTJzou
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DghaSDkHvnZDU2Rs6IlgT75n6w3Xr9foXQ5vav64qMph0o45Y+iSXinA0/fr?=
 =?us-ascii?Q?qyDdDdyVEQsUk83Aag82z7a92+mYGbNAh0aVW+TNszRXH8jz7DGDUuASacrv?=
 =?us-ascii?Q?m5ZgGOHHjVceXtEjgWqv/lNtS5HCoZX5kjCvYU3g6aeULWs81Uquqw8mk0Tf?=
 =?us-ascii?Q?6jnjBPDFrfM9lZU6SQ1eUgJO0WcCsw0lMzcWWH4FwodWOYvZ4dvyt3kB9udq?=
 =?us-ascii?Q?WXDAO3Eg3cQEYvtSKo/dKbAmxFzqYYs4KTzNoIOwShk6A8OcWGZCPbD1CrZq?=
 =?us-ascii?Q?u2sWvUPZUSUdbP149vblGE0913y4kVTcqUTtK80Y97nrVK7tG0M/sLwAJKzl?=
 =?us-ascii?Q?DDZI5yQPQgoPsKpRUN/BBZmaH8rd+9PEZybrQSN5tX/OPvRnoiiVIxBuwNuK?=
 =?us-ascii?Q?K8sjJ0pFOQA+cMX16QOLcNnqPiexHyMbMXkWzDhJiyuy+D+frRz/iZjOWmDY?=
 =?us-ascii?Q?HRQeqrkXeUY3be8PZA1twVw7WsBpBZ7ghMPz1nKVTVnrc5U5GuxHSai+B4Ws?=
 =?us-ascii?Q?ct4zJYqQE+ZjAHqNhxyg3IqHJAa/ZK8XK2NiXBOZTL1JPvAYITH/YFkMcDDH?=
 =?us-ascii?Q?ULSagtv2oupV427e75Jvojrign+WQ3Uf4QYUgytDizEaDAgovHT+fsP5fUqH?=
 =?us-ascii?Q?XIXBXtZ1Xn6G1k55y47r3V+U9H4cn/ysnyLMA/SgXsPFlj0HRwjboUj0EVwq?=
 =?us-ascii?Q?dxGBrgiSifmzvnUX6KtwCARTJ2d4SGWClg3VIO2mpkjICQ3K5NL2/GxrDedQ?=
 =?us-ascii?Q?pkddNxfNvZRj2v2QiUvjjgNmuki3PwPpE3+5RpQ5/pctdBhbe8ngdgfJ0SqB?=
 =?us-ascii?Q?DatuYOGi1Aeq+/l+ERFDVizD/iM391TKtaL5hcNRIvytdxSps3WBKJJRCD96?=
 =?us-ascii?Q?jydLVnVeBjkj8432HLJJU/sBf1gzfdH4vcK4brSArQuEZR5AijIJOzMZaa73?=
 =?us-ascii?Q?lYJXyw1CgAwqTSzdEK3waWdQJAsPArBTqV2CkLpo8+voxeSwbracexdxAiQI?=
 =?us-ascii?Q?1v79VsnFPIYcFAdgAbiO/Xs+Oiom/jV4FmzNPrx0+dfjbTr1OvK7fPgfK/C3?=
 =?us-ascii?Q?0LssNGUwLphmBVFMmW0rup2C3gOk7mH0qkE8861d4Xc2JRdqTSwlyzcI3LjU?=
 =?us-ascii?Q?6rtckcucb1Gf+GVxkSFh5LmJIiKsYTtUCoN1eQoyAwDbZtyWXEwIwCgLvdCZ?=
 =?us-ascii?Q?50rROcBb9YdjUPbVZCS+2KaqJc2s5a4lD/Ij5916czzSFAPb+YA9f3oLyvGZ?=
 =?us-ascii?Q?YzMMjVjS2i6mB3F1Zsd2FI72Sa8S8Cp6FYLW2AnN7Fp/IfrITw9Q4QXfyYpd?=
 =?us-ascii?Q?XH/FhSafdCSJAKOn2yjNvHDEc+IsTsxz6/rrkBgsz9Q8MJgfjUvQC6RL3rLE?=
 =?us-ascii?Q?TduLxUQOx9SMIJkykOhlWKPQawDyu5HW0HtfVL2mVOUTwMRAeaNsZPsDmf5H?=
 =?us-ascii?Q?ClAT1qEABsFNkvCk4rt2k9Zfnu3KZjZWytO+opuNxaDRdSkxbtyyWDHKlnNX?=
 =?us-ascii?Q?qvzivB6hNrX99oKhH2oVSHmHxWxzLJeq0+CtOY/00PmENn9+1KvuLP59eQxp?=
 =?us-ascii?Q?Ewd1Uzg+3rwo6N4bGQwJ2fvPo14q5cAyLh2zVhzBS7bCdX90hA3GgB0Hb6s+?=
 =?us-ascii?Q?/+eKruE6unV9Bg9c1EB1EjFzyizIsTV6oL5Ocd9y32nr6GBxrUSbWxIsOXIt?=
 =?us-ascii?Q?sCX03WRKLUyMMfFP9vZx7eAlChwfDDMvCvB7xzHd+wAuSZemfm+uKxmCarPP?=
 =?us-ascii?Q?MSR4eJQ9tQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: K8xhG9PanQVGD1Fy9Tgdj4QBDZQRbvdJnyZx7sXRG1vAGKdVMXjwhZX1sUgANrbLKjuBt1VvPAgMOnj6BEIgghTTHYGePt6hWoWQ8k5WwWlhMXp2smUW4DXgeTjUyD02eI/tHmCr/JR32jg8PnmFZh01B4n+rohJa2xVJW3W3DVQc8AeKVQwR214nCzV7Dn30cwpcitYWfxPgpHnk2vnPIf0orUtgJqXhXkcceA+vxFrIzHOHnNPSR1RNMbnlgRyrG/KTiYhI8XvH7sHYJuvuEBwtMlB5FuE3uEkTF9nk/2cE1UHKnjjTWlPsdOyEr+tkY8S5+6e59Y7o0BG1gPK5w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fWPaL5jH0hMxvErDS0o9018eWeCu+JHpLCwJRKPO+NX1aMKemaCXaCUXooZmXerfEMhZ7DTpyuoFLEKceZTPAf9BlJbzeIHj7bFJH/7K1w6QxyOja3mVgsn9QdByhF0h1gUkMSuEEJBQO14gHgB5ucttGeEeC0ueoZxT1JymZuJdNJ22iEa/RH5/APWfX1Oz/Tp8a8ttR3qKUnedvSM3LUKyLac4VZr/v/zut/zwdNSp1iE35647y4i2rRBuwuESUyJa1BMB0j6TpsauHwssF2VqiQ0vnOOhD75NOMaqLjJ7x2VLfP93Oo33S/QD+Kz3Q63uo90yCxZelJCmF0XS4fKjTEDiOaf7A1nrqwymqVMz5QSqcQv4+BdCBJaLo5ubrOBhOORURuYrMDsAOD0dBc9InlndkDRa1zIBTaZIvn3rO+C3W7aIEaMzIATumsHealVKybw4eJiedTJT8U/RIxn6cgiSTgrMn/fh/0TrRpPXxbVQKA07YwwyfxZolFclsD9eo4eIasMZp/azJ7XHLn6L5zaGhCSsjwbtp/CGXG+MU3kzN+aOu9NwOtEvnGiyapj7wzIKyOeQSF8cfHFRyOpyM7+xSItHM21/o4tQnZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b180b1b4-1e3b-4e3a-c631-08dee0bf5751
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 09:15:54.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9TaIkDFPxiTlpA6CRsj8BzuIMCygEcgGvvPZKGAvf7D2uiO+vjslKNsrUuL4D41yMyGMg4gGY6Ms8Ls9HqYsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607130096
X-Proofpoint-GUID: zQ9e-SlsSJQWbfBhKhz2--RkOH5h2GQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5NiBTYWx0ZWRfX7t5sbogU3OS5
 ZCoKQStL0yDJBTaz14I3RS1ogpuF1xUIM9ucuXR4Mf9efhoEUe/XxiSB/NB1fQS9g+2jZIwJYAt
 fO4LUJa0A7njIskwR6+Aan0XBXSA55Od6NgUuSgr1QR2fcP90M/Ts2TFZyIFybBGe72E3/JXffb
 jPWpPgMVElHhwSg7KZhVaulnHLeceZ5ij8t9wFDlPZOd276IfYTLuYJvWiHa9zgOZjh5c6TV/49
 VewcwMF/PR0KgzkMDOtTMv7TN3woqOyGbpdd9uDoit/VwCckyQk/VdJB3kHw0bV4w7YWxp4rPMv
 EybbZmzepot8HffE6yaicjrwMw8HuDD4f/Pu2tr3nTO0HV5ez6cmazBSoeu8JtW9Hv7butmfwX8
 1gEdL1qMYv33+Jd4RXRH3c80kEz0F4SNUQbVL7AJFUzHUSmoo96Mib0+u2Tx7n3/rt8MvbtGpLk
 z0sx3FQDwfZkscNfzorA/my/k2oC88M2chndqumU=
X-Authority-Analysis: v=2.4 cv=bJom5v+Z c=1 sm=1 tr=0 ts=6a54acd0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=mQViX6CVFjoW4UvNsSgA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13633
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5NiBTYWx0ZWRfX8me1QWmxFEor
 fuKog79Yf8nuqMbJg0nAbNvRsE+60NGlVXIzmZUkQzNZqaVD2PF7OKpmBApQSVxRe3TMKYHQzBW
 7lOma6D6LMSh3q9N2S6N4nydnVuycx0dy5uMTslRwTQ2hkESjlbV
X-Proofpoint-ORIG-GUID: zQ9e-SlsSJQWbfBhKhz2--RkOH5h2GQF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_021612_437139_AACF29E3 
X-CRM114-Status: GOOD (  12.73  )
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

This can be shown with a application which delays between opening the cdev
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
Differences to RFC:
- common release method
- fix NS cdev lifetime (as well as NS head cdev lifetime)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index db0c8ad4628a7..ef5bbd5ce9270 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3894,6 +3894,11 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
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
@@ -3959,10 +3964,12 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
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
index 56587ae59c7f7..820ec2576041a 100644
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
 
+	nvme_tryget_ns_head(head); /* Undone in nvme_cdev_rel() */
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


