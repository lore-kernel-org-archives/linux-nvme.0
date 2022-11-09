Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9664C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-Id:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JLiAC86vG4WYDdUjgWv2UDQgPbPNG1L6lq4y2pSVnuM=; b=2oMBu4jQ6XQIYz8Inw1BA/51mv
	H1qk9IgZqihlTI0lXY5894lmBshovTG+8/ntqHzTlFWmzwtCS47S9qz3JNKWVsLf6I2/9zo3efYeo
	QfilBrscN6vMePzEO4c8C6Y9kv6jGdW4J0lpzypFyoFObFYclOtekJvuK98ADcLQUz30Idkc1ge8H
	jaASc12JA8RdEdvwa6NoKdUAZxC0CnAnj6XDGYoeigFDhHS9JpZiWcsl57MPgHjb2VHw2VgbK1W33
	hwUdqdx6esCGqmBlwpdxs+hzOMBeYCzsPQFntuJhSvty33aezwb1XMfh6VojsghV/F8Y5GxZE21fa
	ShSrdSKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbVA-00AGxg-JM; Wed, 09 Nov 2022 03:11:44 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbUq-00AGnt-Mx
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:11:28 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A936fmo020815;
	Wed, 9 Nov 2022 03:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=JLiAC86vG4WYDdUjgWv2UDQgPbPNG1L6lq4y2pSVnuM=;
 b=vTQ0hJhflrledgQCrD2mth+K6c7r0/GucCUnzvU+JSDCh1/LqJht4ic2k0lntQguKcn3
 FLIKrJWjsEYC/9LNz9QPAHUgpcPiRVJh6yJ765xPhiWpIMBQW6IFcS5OMLPZfHMTyfWH
 z0ouv9MrYta3s5ECn3AL9rMM30kfUKsvb5j1o2/XoKra9zLqEy9RZ/KDeqyd+PG75x0k
 3/jHdD6NVezP1Fj8erYkwajwTLq/kWzmR/KCO3OYkVmXmgCBaHFwu/qS4dZHfd3beA3m
 E4EgDrwU47kAHZS8mrrWbonWgYcG6jdXisjixoX9j/CFG1+L7trKggRczTzG7LhlXwzi 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kr400004w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Nov 2022 03:11:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A92huOc036292;
	Wed, 9 Nov 2022 03:11:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcypndxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Nov 2022 03:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLHmpbvu41arCuhCep4cFlJMTxXo6iWfznaPTprwMeAK+ZcyNPoyhL8jNxuL8cMKaD1OC2XgGiq/TM6PMgDQ/RrquyP1Q8RcS7BAjsWE7Ju4DfqM6a9XUa0YEE3A9DPbn2to5s8TEzwwMZieVqZxGfJY3NlStw8H8uy5eD1t9Z/IeqnQVJX2XPVVCu7s3fwKjO2bsQst5NRVibnCqoHkVWIJS5CZSE6rS0Kef72Y+SSjfVYv4d6Yv7m/J8KDmCqhcle4MY7eyzVkK6JVMKS6oA8Il6VgbCEa6VILrjkhdeG76iY56i4dFxFAv1IlxDrZBfBoYiLh0/LWSi0vah1Qng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLiAC86vG4WYDdUjgWv2UDQgPbPNG1L6lq4y2pSVnuM=;
 b=DB4Zyi7lxsjjD429RrQDtuOKCF0Rknzh8wZYYudXkXgSIlfYbQe4/epWyE8xpMB7AdWnt0Pcw/XMgVRGf4kBUMC5kyjY/Uv/JxjqVSrt714uGjz4XYPXk4HoT1QtioeqP82AmAUtMTONk+iTSkIqiWGwkDHHnDthVhommwgUVmW1vqVQpCQ0h5WeZK9S7y7d0hXpIFosWYpTjITf9UniuyEY8i4P7ysyU5flIkw/Q3a3/Du+xOtrvoqY6MIIP/OB1knMG3EDazp65ej4a+GDTuaE3jX0fLNA/a6rPe3ehOw5GAHDh6y1Gqr7ZNSq/scV49M7jpmzuxXRazPRaK8Ovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLiAC86vG4WYDdUjgWv2UDQgPbPNG1L6lq4y2pSVnuM=;
 b=RAJsV75jrJcWxIt39Ig/UW9BraQWLUky9htX67wiLCy+jXwYkwIWBykOxdKfYCk8S8BZRQuXU3Cl5WGQamylA1wJrr9Y15LFqaPI96quSVe6wkfhLVSfP/Wun+nOST/DU5tUohMS0K0oaCMgJCqAqsVCsB5F8JNzJDr5BeuB02s=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH7PR10MB6033.namprd10.prod.outlook.com (2603:10b6:510:1ff::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 03:11:09 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:11:09 +0000
From: Mike Christie <michael.christie@oracle.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 0/3] block/scsi/nvme: Add error codes for PR ops
Date: Tue,  8 Nov 2022 21:11:03 -0600
Message-Id: <20221109031106.201324-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:610:b3::9) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH7PR10MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8b2b07-0f20-4967-cd43-08dac2000c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	yvbVRfA0fHJxLBLdoBVs+zsE7Rc5hQTQNIuJxbjXOAdFzWEh8PKMqc5JxMbq8LddzllgtEp8S79ObnIHh36Lib4lb9cAOwD3xg0AZSn6jAnhHP26cptBwjjvO3NG/GdrEXw5Qt26u7YN+/mTFwQHecs5klFLo5lKvRWCAfVjyqRotl9W0FG94nl4T62QephbEohdIQLxuQ/N6KC2eTK1Y8P6s3VNyEBBWPT70v67Y1678kd86n9oda3r2/28cc77NaQ8jQxI5a1L4Zm7mf2JHsMgKwKs4WjBwSwrYEUy5jhRsEALvwTTJCYzf1lDeqJ78tH6bKR0HEfkXfpvjvD8BHaGMVRnV8rurxa+Hmxie2bnxB+VbstsR3lCMDsz3Xplo6f8Z4+P2wlBIbuyxJRsjxptwwpzwmLj+075Wl+5dFv+iYeFoRTCGlhQ7VE1Jhj2W7BJsXU/LUyYOm5NBPct0LxZBllrbQL0BirQnunYPdNNaNgQBFpNwkSt4KjySNKaTgBrIjsiM79r+1RCRuni652CfgterMvbZqeKZ1UVsFInZVrEhITeaW4GVQwEdh+TOjjBoLL1+6Ks7PgMHuZ3FDcdBCVwhngVBIBwFTXQu6XVneeWfGAFxtSJgxUs2at2IqzkZMorasHzgmokPxBzJ92O5YdBz0mRNgALl04ew/X+i1OWHR6dqV2NnWv06Y3C
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(5660300002)(4744005)(66476007)(66946007)(8936002)(66556008)(478600001)(41300700001)(36756003)(6486002)(86362001)(2906002)(186003)(6666004)(6512007)(26005)(6506007)(2616005)(1076003)(316002)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?cE4QSd/Wu7te70Wuv3QjQkTCm6kUH6PwAEBIo0ZsGoWogpNK+99c68hawB3V?=
 =?us-ascii?Q?jaPl1JL6e1jbnDEqbigdMSqJBXjfRbsDVTGSTEpE8nNaSOoFWphdTi78Imp0?=
 =?us-ascii?Q?OjpL5LAJ82+k3iVqRRNxPcXp669Luid3TfqfSeIe3yFso2XQkCRaf1oZEiTz?=
 =?us-ascii?Q?twCdm8HyJz/U4fVuUuDMw55//oTg22p6hTjoRcm/zpCoylTpU+U41PkYbPS6?=
 =?us-ascii?Q?BgNaXJKam1tuATbK5NnRc9Tvb2VVlj0rMf7l/rzEGzv6esNXmMLGw1VfuMEV?=
 =?us-ascii?Q?mpNDWE090nQPHGGcByJ9qijFD2W6FTgEgfD2FSk0tUj+slJ4m/1O4r5RlLI9?=
 =?us-ascii?Q?pgZVqophOZv8NzG6Ke87RSr1srTkZRcCi6NqEc5KUFup/iH4BIrMTqmkP5TA?=
 =?us-ascii?Q?OvbBZCXHsEN0Fpfh2TiP9+KuEoWr8aBV/dDnTKce5C8BVtoOCjg17L2kmAFb?=
 =?us-ascii?Q?jBlx06QsgwcN258t/+31vE/yofmBnwVHWfOKkw+kHJ5+1RaIil4+g8feFSBJ?=
 =?us-ascii?Q?cjWIU3aM2KIpAk1i1C/+WfbP2M/T7PORU4p8BfGTB7lvGHBv1r7tVaGh+0UZ?=
 =?us-ascii?Q?I/uw7AW8wErAdpNXpBUFDgkud4vd+jzE2pZMfG+r7ijGkDmeOqvTlEC79BOw?=
 =?us-ascii?Q?p0LAaDUMBlyj0ygodg3PBuFZMX06vCsSZLuQO4VqWZgW+Cri3kGQCexPQ6dW?=
 =?us-ascii?Q?FHO48zpR2aH8/6pmPYmR6BzIxi3lmqn6oX2ig7OV5SSE1U5u//Qqd7UyVcyZ?=
 =?us-ascii?Q?Ee2ZQaQLpAvzBZRN13+0ZTGFPqL4WalJd4efrzZ1obrVOrSRbkSZc7ZqnJmG?=
 =?us-ascii?Q?wN125BrWDUVno5k0rHo/BHFX6/jdW0PDmOadapE7c4I23bMIA4MhwHjed5eB?=
 =?us-ascii?Q?sEOlC3b+1pna3Z1a5qBWmbMpuZHE/hD4ZuBsqTmR0OuRK0cZGJFiIpywhEAO?=
 =?us-ascii?Q?Tsx6fbeBRQky0GTwnMoLztlyXKyGJymGsN8lC/xH81fYlE0+FbMu/geiJgoq?=
 =?us-ascii?Q?9fGOnSLi0rP4rs6IPxrdc0wSz2aDgn/LVRlNWBraoqZup5gvUNZAD0nCrcz5?=
 =?us-ascii?Q?rd6XGLRAFsUkuuYHu/zv5qUz5QG2V+pGTc+Mmj9XJDN74meXR3JzF/HyCXWA?=
 =?us-ascii?Q?Q0mTm3Jl+vJ3AfDgFOZSwdW96gkUZ2VCWatsQSQR65MmEz4prJv3wtOz02rt?=
 =?us-ascii?Q?jBThdIyJClva3jTz7MVLrf6EF63/38JxprxCzivgOhbQ1VOakeKFQuxxpcYe?=
 =?us-ascii?Q?7C6MmsZqyxul8UDmldKuk2mLuCUO28CblLmOr5t+OgRltz/du8dmytk96Itr?=
 =?us-ascii?Q?OW6JB8SnDUwuR347l4gaUyheq6RA9JFKS5ZvtpUesKQ7Y1YT1uE2XAgwsc6/?=
 =?us-ascii?Q?JCMyL22rAMt/jCvrJJTIDtO1jv3U+Q4sN0U4r5N4x8f1hZcByLsrjXTxexvC?=
 =?us-ascii?Q?h8zrxk5/5fKWJv+Ugfp2YYOvHF/XEvNcsyiOPph4Aeu5Q+jjMublHdr3Lirc?=
 =?us-ascii?Q?D/S38P6+Np4dLWPEPJrOjK1JtjoZDb94vv3EaO2k7wltbNO6tkSkkkMcI+dB?=
 =?us-ascii?Q?yjKSfZdTuFTNlyyAWFKw23yFqQNyVCD7NfTgypXrReHVRXqPMN5LF1SGS5wV?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8b2b07-0f20-4967-cd43-08dac2000c4f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 03:11:09.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp+4jNC7AA4Z2Cm5gr9KEUB58UNnCluCVMQeEHBT788gZ7zvdgc70zAc8cISPNfVQSWGu2P58JW949R3cCP2ME0Dw64bZ9DrFF7pG4484kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090021
X-Proofpoint-GUID: 5SH8V_N0o1IQcecqT7uqc9EyaKdlqcu5
X-Proofpoint-ORIG-GUID: 5SH8V_N0o1IQcecqT7uqc9EyaKdlqcu5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_191125_643835_A1D4A723 
X-CRM114-Status: GOOD (  17.38  )
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

The following patches were made over Linus's tree and allow the PR/pr_ops
users to handle errors without having to know the device type and also
for SCSI handle devices that require the sense code. Currently, we return
a -Exyz type of error code if the PR call fails before the drivers can
send the command and a device specific error code if it's queued. The
problem is that the callers don't always know the device type so they
can't check for specific errors like reservation conflicts, or transport
errors or invalid operations.

These patches add common error codes which callers can check for.



