Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45D0C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sP1AJlaC0urkwAzGkSHPhMNGvD8pV2TUkpVWholQImY=; b=LKYMQBR6zKpYqypC3K/tdHFoU7
	taEBC1C2Y+p4UyIbnFq0A4aeR1x6qLwPROjK244v1mxzotw4ghU966v6PxSw7QOCO1n73qCej8LZT
	n9HBBf8rsBr93gcEIkL22TiUK+JSvHMh1LDye8APCuE/OSDKPZDtCVVXH4HaOu6zEGTaBhe6ZnAdP
	Mn7wjnM8tyxV3CCe4z0Bb6Mo5oEkoBAmkLPqBorZiThCzjDLJnRYO2k9RkFcFwYf1PFQyhwus7NsU
	UuyWctUcZSKBUen9if59JKK2CC4c8HloSwXlCxsP+C0LcfnO64p9kdFVIfSRYevG6tBsO6OgjDKtP
	kWrirX5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3I9-0000000AVyp-18fV;
	Mon, 19 Feb 2024 13:02:41 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3I4-0000000AVle-37ME
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 13:02:38 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8OEx7010905;
	Mon, 19 Feb 2024 13:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=sP1AJlaC0urkwAzGkSHPhMNGvD8pV2TUkpVWholQImY=;
 b=YGriQ1eozKPzAT5Mkn5kVQsZUfJYzJv6iE3NVyt77d3jABEj1Hom2d2qoT/MBxi3m5Rp
 +yAIkxBQjdE1Fy802P9SBYSIWCRS3rFOKcgjnbOfyQXxTv4nwfen52IgnW1fbsUox5k0
 hxJZVVo6kUj1Lk3MdL5f79Byd66nif7IyBwGww+f6QsW0RP7IeHupwrKDvhEqg6mdmvF
 zeW0Y9I5+kkBHP7IRKAFf5ofZ1uo66VbYArj7TxGxhzpWHYpmOS/EIRGQI7hDK1h93Yx
 IbJfGvD+HflY5KrKAxUMvbATyAai1IivJaUXmJwXU4crTQjmnzY6lqexNCgM0j4BrPJE vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7ec4gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:01:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCP5Mc039639;
	Mon, 19 Feb 2024 13:01:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak85w570-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPyc6xb+3H+sAjxkvoqDmWh6UlaGusyEd6aF/dzFFQaCLbRIHNRPSCS2uERi9WRHkGoSX6QkAQOb3jkVSSnFkCue9G4Ek/7IBzCDQ8Fv3+2yeSxvp8z8Ke7FEK7q1oY7gapgvMafeRtY5rg6HA387bPMRoIShoR1eJB02gvXsE/eXyKGFZENhxtv06r7aoysFf7uwMNni6M/k0EsPY+salBZsSMuG2gaRbQs7YWNAnEShoV+u8e33+E1hNpWUyAgHWQTNcpaow1tszwarwzW2Wze0CPnQGHKxc8KhgdwwafIZQnQkjRWm56Qo1+/XqpfaqxzoGXRb0+asyti9tT/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP1AJlaC0urkwAzGkSHPhMNGvD8pV2TUkpVWholQImY=;
 b=U/GtbnFktwjuI2m/31erBJ5FccEFCHfVWyCQksPxEO6M0AQngDphstrtAGZXkEUbQs776LDerDgm4kuvZug1zR5qVtYXN3n1nKWMp6+sjQNP2+x8VIbGqEJKq6WLa7azB9I01uhcG6z8D1wzencL4yKn/Y4p1rdQxx+0nts5hUyuctbv7Zxm2ctiDNxOTDoVQecMhfQdxmxrNTGAWVwzdwbmd4D7qvAPlPws1qjgYkgffiybDndd39JVn6o1T03pkIRqusmbQcCnW2B7tDBjH6jxE/y2TlDvWZ5vJpaNgOTO5ajALzmsXkzNYvA2p5PB0G71gtapy+TWL6rOHiM0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP1AJlaC0urkwAzGkSHPhMNGvD8pV2TUkpVWholQImY=;
 b=mQVbaLMu23/FkT0DhoCApzQkQZE9KWT+1izPOv3BMzP2bby9x98mImQcKI2UgM2WcifNgeebxn4tGBnnhvi7ww9rXtsL3Yk0enuEF4lCkT9xn/5Zt6usB8OD+1TWhTEcWAu3A79uBmyL5UQ+O0YS38KL1Of3xI3PmA7ZA/0H3qQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6894.namprd10.prod.outlook.com (2603:10b6:8:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 13:01:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 13:01:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ojaswin@linux.ibm.com, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
        nilay@linux.ibm.com, ritesh.list@gmail.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 02/11] block: Call blkdev_dio_unaligned() from blkdev_direct_IO()
Date: Mon, 19 Feb 2024 13:01:00 +0000
Message-Id: <20240219130109.341523-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240219130109.341523-1-john.g.garry@oracle.com>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:a03:331::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d83d116-7507-4dc4-94d2-08dc314ae766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRF5lxhbxRhN1UwBNoeivj/0vEBBFD9av4q6DUq4HDiqoQmrloMgBkJwRFqqkeYppavJd62it95sUnZan7DgsCaLDxdGk6Rh4fM+UgZm0jRMkqVkthI0yYb+pKtPWEyYkwi/pno6MBJ3TbWCtbv3LTUEfOwkPnuQzG6vSNUeFpYK/wPZpBoz0R9iI8J8xci1XgGKF8HAfZaZjiL9nfEsIQKgy6U9Bn753rUKrDi7csndRUiems10W7DfUvYmxg3BN5rRuIZIep4v53t/8t7U0CH8eoypETYu+Q/3EJZ3L1ba7U7fS1Wzc6J8J/kqlVDNJm75Kaw0vtNniv50Li2uNhQIK5wPOKZlhrDK5e2/DkCcuNCkeE6d6L39lCI0Lwh87vXAGxumBYVtKXMXUzbrliBQtMFhGHJ+h/5+kFQOl3otVkpAoopLoe/MNzhyevjDWYvFGKk1nBIEnbSjL0DeaArM0JmC0WPjOQXP2dP5k32p0E8an/sNnOo1LbttTUL777qqWAjgCNOLCxndDXZ4NVs3yen6O78PcQg4X6L6VDbZn62xy6AvVG4YoBaJFTgCPiKpCCwGSwn00fY7S4id72P0HUInchK/sxZ+uAReCSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ChN3plqrxb9bWMX6vXqAvqrZGV1fzaIgqoD7iFO2xVomAfA1H2ZbtH+1gDY?=
 =?us-ascii?Q?6cnh33DJXFOfXm2/G8O9dvK5FOD2LcPYrZRZRLgmtAkXMJxMeJpGJmLCV/y3?=
 =?us-ascii?Q?MYVVMn7d6Y9XxFHccAWLZ9h/BHIiJSjC3Kl24TeIo6jxEYEcVxDY1e4YXmQW?=
 =?us-ascii?Q?5ZJI6KH7uJM5PXHa5iP9Ziji/EB0kWU8Se9xNvCUKOzh0uMen+C/sgHchft5?=
 =?us-ascii?Q?vQ8LKTtuk76cpyQFwnV5Xj9Ljldmat+7RKXnM+xgxf9bIPJjqa5LhUfwfypq?=
 =?us-ascii?Q?SMdfwNQueCEN2tWm0klFpepQfiDZ28msYfHDmhQ8U20oC9U7P+KQaqK+K5vv?=
 =?us-ascii?Q?Bg1F29ZYLvjEZvRqnIxCTj1Xuzh/UzuUORdrtGE1PW65QSazaK1y3j6crLyD?=
 =?us-ascii?Q?lEC65sfMKSNKzBSoEoizxZDyArQH3WS5N/Zy3yt9UtAevaWR4h9wwZZhAmtK?=
 =?us-ascii?Q?NnFuZuLEq1pPEqxIg5Y6M7iIcHycs8GlrgTOuNs1wA47Lg/qoYI7uV11W3Bw?=
 =?us-ascii?Q?dR+c4JxECgIjrjuTMVX8ce1DtFUiiIUSyo3Fy4BwR5wm3At8VLQb1hceF/ne?=
 =?us-ascii?Q?Iau2E8NyD5+ETl7Kbjj8z2vaMTNLI4AblS3tKEiYOe2I48fUT9awrz3/AjwW?=
 =?us-ascii?Q?ao6YfpC7PQbu5uDC7k2c+3MBzFv1HLlzNvEiALh25kHdHuLOAzba6Wew1Z6H?=
 =?us-ascii?Q?01a0itRTljBrSXonQXUUZ1vmeMZDOvO8vlP39buC7wVBpqP9kAm824rw++6L?=
 =?us-ascii?Q?PocW2I9uTrvcNWEIsnTMcJsGCuyPZlIGGl3XFuYc+D1zwkRBwUtd1fDTZPHC?=
 =?us-ascii?Q?MhFaWZPBws6epskeyZ90p6M3zkIhOloMkg87vRSIQK/MJMreQPbVGRVMDDGg?=
 =?us-ascii?Q?35F8j4ypCTtrcIncwVvyzMbWGI6f+rlWaf8DGBj5rJgHNmvn+Lww+WbDFe3G?=
 =?us-ascii?Q?ru2Vc+5/vC+EpiMVWjE3BtGo4kktuIjYyt1pYnEwRRZ5kEOpLfocLDkh4Rur?=
 =?us-ascii?Q?H7QWJc5bK6a5wwwQTj5ryEIjeaP+oHbrnZ+53BPkJs1QBagC5HkulQeyAwOg?=
 =?us-ascii?Q?KJ5/Pnq8GzKMujNVQnIVhE9fLI/yVlKmokRBvrY6NzPIomgPuwt/dNQSwtiY?=
 =?us-ascii?Q?WiSdnqS8Mfrf5pWsc28B+VylzOB6C03wnJ2DNhfkltcIEViBkaFLI0Wbp8uu?=
 =?us-ascii?Q?3j9IuXnUWlFn9HdS1FPkwZaHTRR9onSy1wvbTH/liu9P7xoFPtTiXyEcuuid?=
 =?us-ascii?Q?uwr/bfEffKW/1gzFOczRzaH4UZud6vnBTWuDFhZlniojwTWUxqDfYMJhjUJT?=
 =?us-ascii?Q?OaOza2TEvxvWRFpnlXbl09N3LPsYkXwZkOdfzf91GD0rRCfcHzkyIpM+NirA?=
 =?us-ascii?Q?3Ir2SDpqdYffK6tBYtUolFLdX8fxTgUgjcgHiVue6vxCc1c37V+/xmA9xL+4?=
 =?us-ascii?Q?AXtqNmEevFeMwkZovoO9lOycwW5px7n71ZHRuEQrRqCk9s4n/aKEuMV9BGN3?=
 =?us-ascii?Q?GtuD/yo8PVjB4cV0F3ty37Cb25um7prfM46ua6b/A0R2dD5Pr7cxuP9ivmkU?=
 =?us-ascii?Q?VR7P5VIsNuvHPPnb2qq2+4slf4K1EUlgG7hqUtLaRF6NwK2ZtFcBBWJEQC1f?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RoEjpJV8yM7P/lSdav4fkHmzSpbRnQx81AsZYyMoxPh79aqatCK2sshkl49y0lXa5qG5ETw5Jd88NCc5rJQl5X5gr7ydtYj1nl9rZspbS3bCte3859+ciLdHfeAuxzaz11Q8R6nB6yXri8gpZ5WpSLJPhFes4LsBJiVtHkOFFeCMxYXQN529oqXA62SmS7S2LNjp7bzMD/CxH+oDUWQJvcUVnaRM3gGgYXF8Mv7SmfuWA4V/0cDObHn3O8G5YH09hHdlTFoSoZGSVZC7ttgr2ov3EkBDJwYRpL1Hc1H/r+lZqQMVQH4f6RjsDZe29zjCS90IOSGawnfYkDCGiUUctaPlz4STQ6k5ozskch8EIrH2eP8juABuoeQRbjQVndPQGwuozzukFioQrXu4o0x01fj7tZ6WNMlAwgQxwLh1G1q4gnWsiBggJtIF6T6X8T7C2DeLUGNpIl4nf2vEP3CNLqJhSAoVXbzkuPUwdFZiyf8zNA/4j/K5ral5qctreaAr9XQK2QHxiZyitOoSN3uE+zVBv/uBAxlsG/z3FKi2mZ8XiL6mSdrLYDosJU5EAV5f4GYGAaimEvCJNDod9PPKf99tWbxKtraWJ7AxaMxvBuQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d83d116-7507-4dc4-94d2-08dc314ae766
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:01:36.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pw9nuGcInqkxmxtu0vwaxEwcdOzwSwCCGMVw6mnEabV0X0xi5JEfW51aZmxWqrBylzPsYQVoPaOrWdiLXcAVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190096
X-Proofpoint-GUID: o7h1jLOmm7D_1Y-Px-c6UCE2kVVPIIxJ
X-Proofpoint-ORIG-GUID: o7h1jLOmm7D_1Y-Px-c6UCE2kVVPIIxJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_050236_933618_3570D292 
X-CRM114-Status: GOOD (  18.20  )
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

blkdev_dio_unaligned() is called from __blkdev_direct_IO(),
__blkdev_direct_IO_simple(), and __blkdev_direct_IO_async(), and all these
are only called from blkdev_direct_IO().

Move the blkdev_dio_unaligned() call to the common callsite,
blkdev_direct_IO().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0cf8cf72cdfa..28382b4d097a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -53,9 +53,6 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	struct bio bio;
 	ssize_t ret;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (nr_pages <= DIO_INLINE_BIO_VECS)
 		vecs = inline_vecs;
 	else {
@@ -171,9 +168,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -310,9 +304,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -365,11 +356,16 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
+	loff_t pos = iocb->ki_pos;
 	unsigned int nr_pages;
 
 	if (!iov_iter_count(iter))
 		return 0;
 
+	if (blkdev_dio_unaligned(bdev, pos, iter))
+		return -EINVAL;
+
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <= BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
-- 
2.31.1


