Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C23FD5F8E
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a87nGLqgP5/UHXBuBuOzml0zmuZoUk1ydLoFw8gdgyk=; b=B45Dtn3NTXnfxGYxArTcM9w9RL
	UTjBnL+9w7TS+aGZ6y5t5CPnWiEypiEqON8KDpJXzRKkPPcb7r1LFGwExP6vIu3SKS0PpbwRTRbmG
	3RN7GHf7PFzi88A6DSHSMxcyZaXPwC3cVnorv5kiPnyrKqW0iZKEcdZt+aRkpL4OPbh1V0ym3Pekk
	UKCqnE24Jf8Z0I0z5yXjIV8ivlBeA3hjBJgdlcyxha7EhOVL706eo0KsA1h3mlQ161FZgtWnMt7Rt
	P1T9Ykooi5Ye2x8P7b3P0HTUbMQKroXYNXlucEMvXn80ko0x2/nET6iLzhbx/XWiOm6mHTMKwfQ02
	rFc0pH4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANtr-00000008UWy-4C0A;
	Wed, 08 Apr 2026 08:04:36 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANto-00000008UWC-1tVG
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 08:04:34 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386eBHq212566;
	Wed, 8 Apr 2026 08:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=a87nGLqgP5/UHXBu
	BuOzml0zmuZoUk1ydLoFw8gdgyk=; b=ijlhlXCToizwMFi9i6YMimppIc+ipmmn
	2Fo70Ums1JegJUOc00bBWDqW+JyC+0w1FeXB4ghGeYbwcDh9qDKUC7wVIcEwgWgU
	1ImPsFJFwR8Fnv2Re+QTQPynCITTyuMsQMtIFhKc20XDrxa3VXHRUh+rb996V5gP
	Z8TlIspTknKHDEhzukj6PCdyVzNJnevFa9KpwWkXvIcxq+x2xwfvRjhT2CqQIL9W
	wO8zMgLVxSAuebyJxluLion8+R+bQ74atoSyoeRLt3MxUvPaGXu1qPLfpUpCAlFS
	a8mIQrFqZMKCIkzlpoW5G0IE+xh1ZgSSHQguHhTQNtZwQ44cuDfWyQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqau4nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 08:04:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6386iume007344;
	Wed, 8 Apr 2026 08:04:11 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmejffew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 08:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5Ruf8F0kBlrSGGRdf4EzbXU4Q99QES6RfevkIviLG/7zipqTz0Fmgmr8UnhVtVTc+5D+HD/nyqHxQNZrE6db2ASM65NSf0XWpUxqqO0T3NGzjTUwbl6HZvy6KRz1ci5HnEJcEihfDzVhmeTDv8Rhst5tDq/SbzQUtdA014RNMa5vOWkjNi7lSjnoUrsT+Pc0JuQtnwva5EhzdmHRZHLDozNj49tGEfXtwfQ+lBqRSNk/JwzbSZa6i7JKVoeVa4BX4Dgf+K3gD3dqy3FJYXml+EUalRKs4QMX5QiUIwzf3F1gpsD4o5XLgpHpycJSTq52JQkGIRATdVTAvKR8+Jouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a87nGLqgP5/UHXBuBuOzml0zmuZoUk1ydLoFw8gdgyk=;
 b=VqO5nVHnqQ/460t9hwdQIj0h7czmA78jZzjBXMvMxrEtpgV1L2sBz6zawrzZlhnR2ayx1iMIxlAsaZvdtBiEVtAuNs0XuwP4RF7nOM1QRTurFhTpbIWm+BgwJcTAlYVU1/XRi3mHyFBSGXs6j/cOouxvQ9pYKDDj4JGChorDjamwth8lgKzKam9UBXu72hRHXlTqjYI7gHbX7KXI+fPzwSqDT8sHoz1bq/kAoFyNZQERmdJIkXXnj/NDK9fDbMalK/yJNpM9H8ck1a4pmxBBRloAGax7JXFqz0RuuSCROpRgWDaLIZBo1zJfwxynrNNPVBaF89ZqAkqtEFe7FE5U6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a87nGLqgP5/UHXBuBuOzml0zmuZoUk1ydLoFw8gdgyk=;
 b=CllOM9ZI6Ok0cxjmJCln9bEWyPapD0JQ6J/j6aEx6gE9MVdMcAPobnrzS+/RBGu1aOSC3weSibgb40k0GqYq7CGHpCqpDPV8wUGpFBsXkKIRGmzTzCPFd6Ly052k1KUIWLExFI1iYdKMJhVVWpcUlE3kBJMWIkTs5NkgrM2+AyM=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ0PR10MB6326.namprd10.prod.outlook.com
 (2603:10b6:a03:44c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 08:04:08 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 08:04:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme-multipath: drop head pointer check in nvme_mpath_clear_current_path()
Date: Wed,  8 Apr 2026 08:03:57 +0000
Message-ID: <20260408080357.3072749-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:610:b1::26) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ0PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: d3efa4ec-8a60-41de-891e-08de95456906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: whX475IQSKH1N9MENSa783Zwa4Zr0fV8B+20PMj7mPPPOE6HGCSlIf+ACenlTOZDLNhTA4VdkA+Sb+tvkjwxj0tGcY2o2gALO+oVvK4zGr8ytrqQZkYJAWLiAdNYUQghdK10Ne5T7Ri/lgiRCKLo3Tdt4Vihv3TB54BAR90Rqmzkv1IU/8v6n9kogTcw+bUOp9yDF3BS1GRT8qZlB1zc5grOQnClYIQQ9tJl10Trhnas63ph4sn0JayWn+lj/iSiRDqa21mF63RHiUV0YEs5bKkRFhXMWJbfUG0rk2tJLxsgYsbWLT5ABFTganfIrVnEO+sMJcRyZ4Ie4BQ3IJWKfLoVB8nIE0l+SeaCjkMwfzrqmpTcZyeKWd0cjjJoEjqThmITJdYHhCPbDLhVY5JERsYjm4B4aV6yeTnc7aoFmrm9FIeXWo3uC5Q2aiNB9AbGXR2aEtfaHwWvV+/1ZaiFUrXNuCj7biWx1ToUInLF6VWP46POZmeDRvGg6wAGkAGUGeQZHX0rKeoxXhNUFdQk/Olt4jrpxy9kr5s09EJqtkVkyotcTF/irmX3HN95FgFwbaA4iMTAXXng5cLPvr8r3r6uPI/gi8QDgo5p0OYPazRX5lVClDgVYrljXGIkZq3E7LVh1ujbhQcfvDy0qwrj6hLWIctxJ0iQQct4f4g8ChT3LVhMP5rZwVveDgxC/34h7YXg3U3voQJ25vVxhrAPC/98gh5NHs2KvybmT0a4STA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skS0ItU9fyHejATt7DZ6kUP5vw/jGBZKX+KfR0ZsRaiGCh+ixr7DphXVXOY9?=
 =?us-ascii?Q?5S3xSriMx7Q5rbXLAWL+FxHTCn1jNbDTiDzeQPjZtZZ5njSoU7kbpldSIsde?=
 =?us-ascii?Q?eoYVz0fhsCkqBcsgICU0mwON3IhpdmD60QpSmUf5qFjaLKSfqnTfwkTepLyG?=
 =?us-ascii?Q?fyb7upa4xF53rkSewtyolE1J9PVum5p0mhafS03rN8f4EwGyJpHmG0iXzo0U?=
 =?us-ascii?Q?EGDJdglnEW2kfYPqq6/oUg8yT5IiWv8z2IOY30jUPGxiQmeazYbBFfGv6J2v?=
 =?us-ascii?Q?HKglC9NhAMHa+oRbHc5jfI4A9XVedmy0UOXXkUJVOmQhAGg0M+d04qRv1nhh?=
 =?us-ascii?Q?O6qzBgcy5gC5c3rQlDv/a5ZBP9+ESXfg2fCJS4Tjm181gBrlxrZDGknnhPLl?=
 =?us-ascii?Q?1j9o3RkHunZ8WaBiUYw0e8UIP/Y72ug16s+5shBd0M3gTZ9U1i5FJuoD+iR6?=
 =?us-ascii?Q?XFkb+0YfRksJd/aFomfRpdPS4XDP/AsrIvbKQQo7qjs5Zgmi51qFuRFlss6s?=
 =?us-ascii?Q?4u3a6rW7gpMSr/PiWtNyRBKBzFlhblpn58kUN1YBlxsx01pu/Kp8p+7krWbh?=
 =?us-ascii?Q?u5hBgCR8xLrdtlCAn81GkFQfwKMb5+7lxewS2n3eTg6m9YuRXnYtRAO7nxCY?=
 =?us-ascii?Q?f9CSlyEUSyW2Rz+jZ4c93NBYw6x2uW/QLY8378MF993B9ACl/e6ktq9UR6P6?=
 =?us-ascii?Q?Hm2HF3IzTzDiYWKasgKDLxq5Y+9XwTNqSNZ73USP1PdSe4/4/dWvhq33Ybt0?=
 =?us-ascii?Q?UcDk+XvDwMccLjPcluRE3L/F6ZtfdumlfYps60i5wzbyVsSUeRJOGiFzlR6x?=
 =?us-ascii?Q?iVKZ5Kajrt2e7dc/AkN56+nrH5Gk4Vu3AT96ePZylHB0AUriUPD/T1fekSNx?=
 =?us-ascii?Q?aGynEwGueLqKkK4VkKh7RVoQnWTunVeYyS9Wzurzdfbiv7BTMK02otVp3cfx?=
 =?us-ascii?Q?yQiziATUAYiC3vXun8LUUv206RXYja9vzmrhDBOzzZMKAVDCBInzr2lEB6av?=
 =?us-ascii?Q?Ed9dsiYMoFig6xmntY2su5o5JlxpkEEw+vXLPm2vd9U36U02Exa/DZxdyHQ7?=
 =?us-ascii?Q?l7g1n+J+DehvHbO+YISC3Lotq/i4DzB0c8/zEmVkMeEVEfrAuncygne4ngP/?=
 =?us-ascii?Q?DAQ6RefEzsELP8nOFfxyl0tyMFQRyayZGxl5kJdgijevlvCWkJhxS+uZtPku?=
 =?us-ascii?Q?XHokl6cKnUrcGiWXW1ckYu0zCazc/wGIKc8em/2D1myhhmBVv7Xb/yn/Bl3b?=
 =?us-ascii?Q?GsCnVJeionSzYoaI1MnLesn1MIZgPtsBqOedh/rzm/IULqvPMMQFM9MoHJuS?=
 =?us-ascii?Q?XkizBLzGn/fHT7evPYz79AqlTEhykB7GvVFUwfBZb0W8yYwj/e7vL9IzgO0S?=
 =?us-ascii?Q?Dz2AFgcNywhDN7mIhwsmd4xwWN5P40O/hQyIoxkuxTzazBJ4s6iL0BJJDeGU?=
 =?us-ascii?Q?TStFk2P9wutXqfUPGWdp3YitpJB/dCJz0ZVpmDrNmNfFL9v96nNlkX85tFx7?=
 =?us-ascii?Q?3r9Pun9Hz4ZpoIhsReFgL1awAarwtI6Y4+uwt8Q+KQNlr6ACfH1KJw9iDKBa?=
 =?us-ascii?Q?iNoAPVA9eYlZ2BHwVTwij9Wkk8o4nF9+O9UC4qQr6ALRoP837cGUzV6nzJ2N?=
 =?us-ascii?Q?O6z9RKbfDyysa902y22rNc82gFBDscFm7rmDYt0onZzMCopUy9b+GozdT3PW?=
 =?us-ascii?Q?vD7BLsyidoBDi6UzuKwhyUtJL5wE5QI+xlgze1X0clpWMiotlN5QK8OPX9Mh?=
 =?us-ascii?Q?XaTXarQGlg=3D=3D?=
X-Exchange-RoutingPolicyChecked: OYxSUE2I24Hh3gMjmwyCx/LxJp3oWGtZ7sTfcGBuITeyCc6j2Yh4sUuKp/joy6vugNcIULyrAXS0NCgbEk18B8pYvv4xcIq9j6qbjw608cnFMDSUYlqll4XWuf+hPNjAPgiHnX0PC+LXpdzcCWYk+ROf3fYb4myRU+MRP3bUUMEYhTIJxTpzQydbHXrN2yjhL8eXEDkIRppYYJKd2nWnrJrkqTiDb6il95qcxlUYDfIqzhVsyZ4uZpm0VjmnsKbJtySGtyvKk4AMB1ewepfl4ixflOV12cwJ65qWb3bsIe+/1CnpawWGfp6cI8PSdYsu2wib6uV0MuI4Rx1olzMj0A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NJUpfatO+9yAaOT/Yxem0N2CaaqqwCVlvoxeBuIvYN6Xe5JG8if8c+IP0IgdePdCgyVL8/vNrcn2f+sKgSOVq2cxU1pZncVPjSLRv2C76v+wKdTr6/sVD0Brn6yK3Q+T1K6DbhEOxalNpIyx1K0Hn1nT1oRZRH2JoXomrHXuYLriGuWmWqcFaYZYhvexGfDLc8Y2dXbCXCTW6cWFvoAhPQFWPVOG5nq+wtqRIJWC5Su4BR7+28hjHtPR0QFBsS5pbeNUuUkAQplabFQzuiPI05F+iFHg12YJxhdHOKm6SXQN5XcnPRtURChhjbrDjx/bKRIHZmIqK53YTFZx9I2TvfXmqLHAMlPyVFyGa9JiuvLThDstrCVrcFy/FM5akanRgUJw5uxDh44uyH9HTfAqqJBEGKIeFZPu0RH4aaToGqcpyVBLqKWgDHrxOi46i7lgl5z2xAYvrl2W6aWBoDqdOE8MWZuH/4b/Xdx2YQVTaIWSigsxuTO0hJPzkehvN8nZiJGVWiZg4Nae3PqgoE4fbzngoMEELU03kzqCGXBzKQrTiLQA4OuLKJhQ9QE/JdDwaMY/pAdJ4HyaJT4l+AXydWtXL1EWQxB5hENcJUf+5RA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3efa4ec-8a60-41de-891e-08de95456906
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:04:08.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMC8xMGiMC4mz9vezdE+N6ceFOMbRk7INCPEZmY2X0tmvK5Y2ByAGRMIvrr1mwCizF4EB1izgYgxSYsjhfz/dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080072
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA3MiBTYWx0ZWRfX9fxXa5NYEdMC
 f1BTSnMX0uOkoB/Ehh4Ae2JGr+kl/xS8zVYWsJn3ny+WKbzbWXAVFU4BGSDCQBecOszX5itLtir
 JIXTic218OTOHjUnJi2lODya+4esq3C3LYhDKZ7FK0n8l9fM6ia8n56rfrUS7uzOmuyAgkzVRct
 63TfSYzZt2aubgTpYlV+552S6TemAZHdXEVCCuiQgCpsQV0lxVlz13JcGxLKdhg2X0D1nma7N0a
 OG2Xa9LEgeHj0kAchq0cO1iN7kTX/gV6Xq75SLeAshDbs8Gtg92udWGA3EL3HjVHOTjmrbGXuUR
 lHZOQW8F8StMW5VKuFSccs3d88tGe/jp1AH/sSFtS4FLYKAttURBntxEyz4gPZtjdW4s+7Zjcy5
 fYRKiueMMNXCnkay0hY+TGXd0y/4sOvdoREvnCCqUln2ZBhIMP50QzHuwVMfXnVA7PpC6gS58qu
 9Ec6rlHuebVWUWQjHlLy4tdSk6BBPpTBec8UeefQ=
X-Proofpoint-GUID: 0Qn82aawBXCLWfsvA0Uikq4WOT1jaB-x
X-Authority-Analysis: v=2.4 cv=Oux/DS/t c=1 sm=1 tr=0 ts=69d60bfc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=rF75BoWYeksgwheecR4A:9 cc=ntf
 awl=host:13825
X-Proofpoint-ORIG-GUID: 0Qn82aawBXCLWfsvA0Uikq4WOT1jaB-x
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_010432_723959_CB54CF93 
X-CRM114-Status: UNSURE (   9.09  )
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

A NS will always have a head pointer, so drop the check. As proof in
practice, all the nvme_mpath_clear_current_path() callers also
dereference ns->head.

This check has endured since the original changes to support multipath.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ba00f0b72b858..263161cb8ac06 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -231,16 +231,12 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 	bool changed = false;
 	int node;
 
-	if (!head)
-		goto out;
-
 	for_each_node(node) {
 		if (ns == rcu_access_pointer(head->current_path[node])) {
 			rcu_assign_pointer(head->current_path[node], NULL);
 			changed = true;
 		}
 	}
-out:
 	return changed;
 }
 
-- 
2.43.5


