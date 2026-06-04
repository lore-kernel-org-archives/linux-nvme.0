Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48385CD6E6D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hwO6QK9Megv61XnM0txdrdEf604cfcaVxWYbLQGJkUQ=; b=wvAiN3SSpamVRZbvqhz7ZBCpfF
	O42/xtAhL40MxmubAzuO3YmdE++wgcWaE+k23IzHJA4bH+YlHT9Nmwv026aSQ2EUXEOnKT2pmAvjL
	zZgmq7cRKgLGO03utVe4FY8/Dcs9IAaXPlSkQqD4awDjOQB/NBO/U3J2rMA38mRtqDB/MUZcU66uV
	waYcgL+Odo5Gzrne/UB2y+OAzAIJtUO/kFwMR5zd7Jih+FKc71DhS5itgCAnBcgFVA8k1k9D3BN0C
	v9oHwBhnwOWPlMOCYSd8eYUjMaeJuwy2I8KtED4QJGGZC0PUkN6bVDbImp0ev2oqGtlR8/2StcYMu
	t/8+Fjwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV9XG-0000000GwsU-2g3N;
	Thu, 04 Jun 2026 14:59:06 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV9XD-0000000Gwrp-11xV
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 14:59:05 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654DkYw82541788;
	Thu, 4 Jun 2026 14:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=hwO6QK9Megv61XnM
	0txdrdEf604cfcaVxWYbLQGJkUQ=; b=QzFO+36hShKm5QQgXTYqpnOpFmlwmola
	A0orWzAxvtEsngUlpHDqVdK9jHjM3hBtInz656NYUckK5TEUDwJKfht/f1yqjc9y
	vyxLtMYPWuUIqZoRc+tzNKUExcFYnHkEpBkO43xXMX91uj2NgZpZRTF3IXAYYDnS
	DQUiQKmtkfbjvedimrdiaqjgwyLNuEjmoj04x2Fiej2XsSYGl4bK8vpNZ5o6AbOg
	FtHUQeFJBzOdMui9PjSs9vZ/7IKf1UUtXvonnfCSsn839vpF/NMAnPgFLrs2i1IX
	MmzwOYHaFjzKKcxG9wdooTnHdsaaJU0VQhVrl+nL43AMznS35v2RJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpp20bcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jun 2026 14:58:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 654EjLAY036309;
	Thu, 4 Jun 2026 14:58:47 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ek324ty91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jun 2026 14:58:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjndjSChqG1nRcqVz+75kNNRbWDEneNH8WArTi717M+9BQRhgH6Z6KFnZYr9BvJjNYCt2X3JYfSSVS6hPGaPJNf3rzeLH0p/vIWUnbk7V0bHjTYXIuKDXXT+KvbiP5YTIFXaOujrR4RKP9NvplHQOxANfsOzcJA5rUWqNdgcmWxlyVel2FCb10dDsl2XIrOiimqncgzKEEVzpu9lviy8N8pKSRr0OgIDkDPhDFSqfQEz5EPeuFcXDpSGuAUS4gwMstmfp9BOTwIc1PHo3Mx7MjhRpzPhksT1ExnXz5MNW2rCB3Ztdfn5DWdVt9pPgl+9V+0/sINtUoyQr/yYPDbxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwO6QK9Megv61XnM0txdrdEf604cfcaVxWYbLQGJkUQ=;
 b=WOvVPZvoX9x3BJ6MPESUxT/zjKWO/TDe112iKpdfcuW385BtD0VWPHtgtVTzFPw1OTR1c506Qy6eVMB2eUew+UGS8FokZliY3b8OKyMqPFY29t/nl3UJFmAmXa5JNL9Fqg3QyyapAJgpY7LFa/GWtnXZJAMh5e0rldW6iotBmQKMDwbbtWGogKqpHjojJZlmdz5/0rE4IhsPeWWWuSTQjMJGUjZUZGi+WgCloDisec6WomKRPFdnkrVYV9ZVQ0f4AdXErbhflNhY7x9NqZz2WaI9wHOkezzkFgzeHPM2EZ3U/dpYmce+kiRVhExUvW1XZZcKh6jPlWqBmIR06rQ+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwO6QK9Megv61XnM0txdrdEf604cfcaVxWYbLQGJkUQ=;
 b=u+f9lhg1JZPkih0TMEG4TpoFUFpdn/Nb2raMg3wcf8hDl9vjDjw11cXJRyuOUbN7pku/QNpkVHo8r8TWUleNNXhjeWk3FqjSqSUuSlzCHfmNks5vW4LNelp7NySVv1JNHsVUY+2BKHlAYi1eJlcwhgQNA3Fix6BHImw+SysQTbY=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS0PR10MB6127.namprd10.prod.outlook.com
 (2603:10b6:8:c5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Thu, 4 Jun 2026
 14:58:44 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 14:58:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: quieten sparse warning in valid LBA size check
Date: Thu,  4 Jun 2026 14:58:40 +0000
Message-ID: <20260604145840.948130-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0059.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::10) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0903caff-6fbe-4d38-af07-08dec249c5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: SEsyl/GIw/P1NHuZVrkqvBP+NH7WsnoPpDEolsBMuScXRTAsXvFwWwl0BockmOA9czYjXKJR5nyl5tutboT6SQ/QB+EFvufkjO8ms5OXZs0f8z9dCLACkBge77m3Yr8MhL4c5NyTsu+cUh5eZwI3BeOeYAOoP1Xs6o020PAY8e4yOpeELJPoRIzwECrvmCPkEJ8G7mbMNCv1s5TW43RhvMQkkNttVOoaii00EsoV+a0q/TfAKXaxMPuqAOg/Ozm8ARwVGcK0G3SXgM9c3ShcsYPnh3BBZvAWOL+1zHVYfZvrEW+Ya3/1mzuPelbnUj0MCSwuxkitAraiFDXa3pG/d0llMlSG0/hhe53An5fj9UHHOMPzP5olVk4tANOkmYsJfSg6yyGFogH9MhdDOslBS/Ekp/G114msXkS0zpKJUn96ImfvEsQ1e76wkN/XSzj2+JZ4kFaCGFTGFxJT4gTBRlnuGK4aua0+hzZeO8NwFtqBZkQAtA+k6M2DzhbmvtQQQMbL1Wwhq8XTEG8x6bEs5zYIQHCkpXdyPjV3gOpy1OoxoR7b8M09Lpo0tf93ewtylodbdHHOFMu1sUIGrXDClxAX2O4tVzmE5MqCQ/fo8tOzVC8cxhzMM3vb+mdyyR+jJeUVv2f02oZyHWfL2Ap+5XXAIGO9ZC6StCfhdVNTZhPO+nYDAALp7vCFJfSTnljx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlqHJhNOtwnuEIRg2JSfk8rzMtEGBoJtdGRpOGaqfnmf9qaRtte7KEcfwxU/?=
 =?us-ascii?Q?H8nw95WcDar5yAQWfumq4QfuCCZGpA72yg9x3abssoXyFXwGK2Nx7JH8Hziy?=
 =?us-ascii?Q?5U6NBHLRqUBEAjQqx9Ld33IXxwckUs8YoP4LCM7HlOVpBBoIO3cU3AiHhcbM?=
 =?us-ascii?Q?z6zZbU9XmBQxRL+/DXPQtieVIsMOrHUTX9+KgmsRmTuu+ANjGL1GyHyMfKie?=
 =?us-ascii?Q?ISCWieXb6NMgQggSOLoyehYFHwlPMNWlrWGjWrRzNo2k39l5p1gxl9/CKp2B?=
 =?us-ascii?Q?+UW9hkTfWPdUVejDUBzbuPmO7geEEaPvpCD35M4uzRBxDBC00mv4RKjFrrtN?=
 =?us-ascii?Q?/2eMh9My87n6WuayN4Rzh7Pe0MC1BAbE3cVqdmwS6+L6xYNkmfhwndqazms9?=
 =?us-ascii?Q?ml6JAg6+XwBG89E7SSq/WbA9ZN1tCAQfRX1NH4tz7B4yfzYmyHCUrD6glc6n?=
 =?us-ascii?Q?gqh1jgOzyuGqjD8CB6D0UKtNbfuxryxSE4b/BBK4O9Gs4BcgDM/z9cQQF7It?=
 =?us-ascii?Q?jTaRxUKYEUPuW7brHqulXw896fzLXzPnQ/b3kEi0/3+z6MLjT7lsLSx8JVT6?=
 =?us-ascii?Q?dHg/ss1UdpAtifGA5raCO11ARED37hvvyFFhv4iRPv/b2NraP6JehCceD4FL?=
 =?us-ascii?Q?MSEDO5hG1wmvZFTB6kZaxhFBPZTi8wLoMa5wb+QbwCLIh0BP1FB6O21QZwlh?=
 =?us-ascii?Q?XSKZfRRQO0yHrzVFGDCjsb3zheykNfbE5PKJbu6ncHvhMVAtc4745nBmUudD?=
 =?us-ascii?Q?X1Uf2eUbEaY+OEXd4Fux9kABzxeCffbJEM6Lt3yk19NSegj8FqtlgJOInL1V?=
 =?us-ascii?Q?PYpZK69wXD3qK9SiD6lFsPYIGs22m2rw42eGOjB5hQTKSSygGa25czwqurY7?=
 =?us-ascii?Q?8RgxUrbSiDSMrPZbhXd2V70djdpA+0UpUbX8czDqKVq9v/mXvS/QBDDANAYT?=
 =?us-ascii?Q?3gTNF6vrSUe8/oBfee19s6ipgnz0XzOXmjiZHl3/pZypiZRaExL6t2IXbyBh?=
 =?us-ascii?Q?zPhfL6BTt8Day4mwFoobvrp5iXujmOYRY8vCZzLPRcGNrT0LcLfeV0e0fBft?=
 =?us-ascii?Q?Eg1Iw91mhWTAPQNvlH5B8tcIQwrfpYyb03Z8KnJlIymyy7DxhgeD801LY85L?=
 =?us-ascii?Q?oV8jDh7ulw9ib+rJEIp/gHUlxCfK4od2YM2/TyX8g/Rm5X27MbbMNlpCPKqC?=
 =?us-ascii?Q?HfSGjtU0NbFb2n+qkFNA2jvm9+j+wAapW2DS4LHmAD4tP2oi8NF2FPr443qx?=
 =?us-ascii?Q?DZRa50OXjD/1IuTw16OcNWzXPgoSHu4ckIYyKgcyL4A5ltGTv6U6+Uu/56+6?=
 =?us-ascii?Q?GxvRm1MR/2Fi8bni9zFJV3ts86FFydmMHOd8MdJ6F48U+iYh0/izf3PJUZ4+?=
 =?us-ascii?Q?Yq1yxpn7O/Au+OLjfoInm2fB3mvtu2/O0j8fIz5ArP3R9qTZUVq2hz5jhBvn?=
 =?us-ascii?Q?QJ19gqNYsiTAxU0lU8BerxzKns65TaQhzZouRt36mkkYK3RoJfzgvrYMDXKf?=
 =?us-ascii?Q?8P0xB1IFd78Pj97foWstFalNsGd8VaZPTzWi7i38b5jvN/RWalxoupEqoeHw?=
 =?us-ascii?Q?s0JtZZTY5KDwefz4wRWAuL5bViPAdJs/++X7+3o3SUUAz3lZ261aHp7jnEx1?=
 =?us-ascii?Q?a2q9rRxZeewaSTN5v2F+gkej5fNzaVOxIGp5FUouUjfmf9a60kT0jKLwzC1k?=
 =?us-ascii?Q?VDevXWNudVBR4GcKhIpw19M/Eo7NMzHMnuRbRSsoHdy39MepnEWeGZsnJ1zr?=
 =?us-ascii?Q?jld6yLkGAQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: S86czldvgVTjdfxd1R9DYLhjvdvfgXEK5puFXId+1M6nARpFJnQuG9ArZZB1clasNdl7V0226yM0FwZ5OCSl/mTuUAuMWnmhLqUuMermQRF3vzGJw1nj4oD4fKHC+XKWCEh+eMqLDuO9aPQVvRUM9HU2CoU2CA9IE9EPmIua1AVN9hEo/L7+aJ1QlS8e8BsfS4eYQ7z2DMoYRXLK71uPvOv4CIb2G2XUEKLnGyxtJw+8468CXu+RJop9puYjUBsXzD0141tTnTQD7/wjP4BZKkV8A6CXOrYZsHku+fWkJZqo5QxHzHJQJp8HvEC7sXHrhfUxbMBP3eyme0JPaVvnVw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Aa2agwwNoF+U35nQz7jHeVj/kdODxdARs873hPOFgaDDcEk2TGYM3Nei0En4d/Y/TG5e2Pa+vbun7MTXQw20KySuBtjpyUN2/6jKZVSNxWUHpWvGe41LNHcRM1p2uGA6Z1ua/L/v682kcQytcmW2CSTu37aM/mnISwjxMvjs/eET3PxB/pnvALNrn6CUnbwQG1TTJAJ1mtAgLx2GKu6LKX7vEa3pq6Ed6BtoGvnwdpJl2QurgwDWVdOrx8C6+KLji7ylPWdmQ68ktjqmYxHSEkPl4CJiKHZOIaOVrVKfg7zW5HUwwDoUKwgi8LIdz+AqFs7lrSmOEVEZCnmZKastzebH4d0cXlblJ1Erp5bvB91j0ciTCepLPv1Ra1ZpKzjKuiUyh/hoTJcSX1dzuO5tZ9ptQqbrVByJv82hvldJJqhUM41aIuDZMHZi0F1br3h4DVY1dGUU3DqIQAFgdpzuw7PVkQpbEdsRoSKQrqxbP6ibOn/W4/UMB9MU69o16A6u6HUa1fhk5oFa/4XkP1FZu+j/dUynaMjj3yUhaSRmBylb8QsZUL6MUUFsijgbQgsdQQRQop5hamaSmDC+ShmCu4TkdUqng3uUQ+xLJsQTF9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0903caff-6fbe-4d38-af07-08dec249c5e0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:58:44.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zy7/pkYAQqtHoLaAtJKatSXQNVZLUsJ0D+cE2B7C/0jXDkJLR5o336IrHIw8O/m1t4EGmMJlIlLJkZWddbQo0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606040144
X-Proofpoint-GUID: G6ypkNobHSeZLYiSOFjs2naSJ0mTwc9_
X-Authority-Analysis: v=2.4 cv=BMWDalQG c=1 sm=1 tr=0 ts=6a2192a8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=Zxa-kF15Lloonj2IvKkA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-ORIG-GUID: G6ypkNobHSeZLYiSOFjs2naSJ0mTwc9_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0NiBTYWx0ZWRfXw4doWD+FBfaB
 OhFO4JpeipGfU6vc+Y63BTv1NfavDJuxq9JTkj637tiXPHEKRWqM9ZGfrJyqlktaFj9ALml9bga
 dy3ZCUwF9jwW+eLmrSMMbWRO+cE1w8aZZ4sfW1LelzKer6YHcDfkInVpi+On4tvz4DVo+NGMBMs
 r1xd9Q4kchdiHgWGTbKCc904iHsU69Fc0/yr68gJbiv8OwhD4AXDhoOTJ2SNj1Mf27M7gEv+ZQl
 kM3aP68nPaIsVA7Vra7PqPatmJcDsj1oyK3sF4dG3RBr2WBjiQZQNN0/hCd54ZUbcpQdpQwXpSu
 /ZiJdT014P0OC+/jonfzlVqDFblexpGdqUzNc+p9I5HS62sBjfvxmmvgsFbX1O0QmZnCwK7AphW
 c0EJgx5i8K7MdNYZijagvDVf4uVjDH1v+D7980n122r+t6UFtEd4ldyp60FPen34n8/2q375Nnk
 HYkw2M/wDMzVWTbvKjpxN+abuL8WEomoN0f1J6z8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_075903_407267_DC0E45B0 
X-CRM114-Status: GOOD (  11.21  )
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

Currently building with C=1 generates the following warning:

  CC      drivers/nvme/host/core.o
  CHECK   drivers/nvme/host/core.c
drivers/nvme/host/core.c:2426:13: warning: unsigned value that used to be signed checked against zero?
drivers/nvme/host/core.c:2426:13: signed value source

This issue was introduced when using check_shl_overflow() to check for
invalid LBA size. Sparse is having trouble dealing with __bitwise __le64
conversion when passing to check_shl_overflow().

Resolve the issue by moving the check_shl_overflow() call to a separate
function, where types are not converted.

The id->lbaf[lbaf].ds < SECTOR_SHIFT check is dropped as
check_shl_overflow() is able to detect negative shifts.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efaddab8296e0..d37fc70fe48aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2379,6 +2379,11 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	return ret;
 }
 
+static bool nvme_invalid_lba_sz(u64 nsze, signed int shift, sector_t *capacity)
+{
+	return check_shl_overflow(nsze, shift, capacity);
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2422,10 +2427,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
-	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
-	    check_shl_overflow(le64_to_cpu(id->nsze),
-			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
-			       &capacity)) {
+	if (nvme_invalid_lba_sz(le64_to_cpu(id->nsze),
+			id->lbaf[lbaf].ds - SECTOR_SHIFT, &capacity)) {
 		dev_warn_once(ns->ctrl->device,
 			"invalid LBA data size %u, skipping namespace\n",
 			id->lbaf[lbaf].ds);
-- 
2.43.5


