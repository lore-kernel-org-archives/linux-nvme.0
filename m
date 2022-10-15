Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AC3C43217
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Oct 2022 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tgFFhCialWr4mD22RM8DiXF3aOmlNurf0eAlggxVF5E=; b=gsdbthX/rhnGSQvl08wQ7CPytQ
	wjhR5t+otkPGw1pp6ZM4MiYgZfvCYVcRnDyAiETHYLX0RQJkanr786GgzwhNyGpktqKjMniWaEN5i
	7EF5/E3jEh/oTHEhwZg+sJFOHvFya7WLfxCQO/tmX6sD0BKW3pWIdKODVF8QS5lWIuUwVvajUtJY7
	+r10amTs/V2d8PAFNbbiGGvkhvdgQOgN+OgkqGAA3bb7jxDBX5yXh3Purq6bS3CWYfIAVliDra2yh
	B3iprvKqKpTKjlYIE04MtFbLUTy09oFnRr9yhligvCC38V2draoca9ZiKggIJSE96kla0efahbpTg
	erFd5TXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojcVJ-00GdK3-84; Sat, 15 Oct 2022 08:26:45 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojcVF-00GdJI-9E
	for linux-nvme@lists.infradead.org; Sat, 15 Oct 2022 08:26:44 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29F7Uewo027901;
	Sat, 15 Oct 2022 08:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=tgFFhCialWr4mD22RM8DiXF3aOmlNurf0eAlggxVF5E=;
 b=ygMGPqpkgtJWCimGxisygftjhlcPmsPjmP0rY5FtdFnWRSPfulYT5O45UmN5e+pPKiRt
 BquyBGnMI8/KFLJGVPy4llHycKllswr7qVSLEqplIIoKrPozRiniZHafpuSIC5VTgJdB
 jPnLOVZuZgrUa92gl/M7cChQVDmrLWMEoyWlLr41gT5bSHj4lEfsSH8VtEJNZiLI0l3S
 f85NqOm5TVY19zOK9DHDT0upRJqC1ssa0Gfx1js7MVS7I4f96aDRvFuoEjBVxLpcofv4
 OVZ/gIrhFz/PLSplSua3l0HmauhjFNa3Qx2ORnHYOsdN16xd/0XKTQAN1aicK/B3r+lo nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7rgn82qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Oct 2022 08:26:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29F3Dd24030740;
	Sat, 15 Oct 2022 08:26:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k7ka1d3ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Oct 2022 08:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEtkIM+Ac6eAIj/riyLEkGpkzGoaprm+TW62m8Vn9kCK4DPJ7bsCtWYGCKWNvfb0BljBN4JxQteLyYPiKPu2oJ9C9ZPO8TKFj7FP0eSf1h3j3od7DwYuL5cOom+7nbriTTxPPiSuI53nl633Qem1NcRIo67fPw6hPt2koRkJZR8+kH4PKSJC9tewN5+FeqLuepmk3BkFCRBUff+kTwL725ioHUccMS1bIG+ffYQvkBMoamcGwDp2FL4fqZtE+QvkOEIm8AalKv2z1Wk+Ng6RL5BgInGVlcIRAhp1n788J3omD6X7BSiNHDU0frW5cpxHB4moR9QxsI+k6vb/m+iC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgFFhCialWr4mD22RM8DiXF3aOmlNurf0eAlggxVF5E=;
 b=I8mik0iSTMK0FlVg8qGHjLmgd+awtfnCUeosC7ogeNtQ/biyP08A9wuybIm5nRh+2v0NwXvg4cDrtOphol39Ll1LKJYaioQK1Nds6vPn6beojJR+fNJHVldUGS6y2/bQjnOfHBq+6kE+RGcJSny/ty3c0FIizlL64k+FQLyckyXjM/2EfcCvhYRhFsfhrYpox0f7MwxbHAAZepvBpAPyOe+YGIwvN92pgh1OOvVuM7KxgnPRjarA0WJSuQUwnbLCcCR/mNZKN7YVYSIwbmmD5UtTsRy3Yu58a5Qsf951cRhH9ExHhiByIGL+pQmCsVf8zeVaeu9EMutIc6iENJtwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgFFhCialWr4mD22RM8DiXF3aOmlNurf0eAlggxVF5E=;
 b=j3i7+ZOrplwUWEY6UR4+1g4ZCftKjjfGBPzOc7D8qOVRSWs+vqlSA4ieti5vzTp3wujEOBWskrF9GNINp0f4by+8ZRWPONR2NdOO/7KxJWcYLLJ0ur/7AbU2AQrYagfqz1QAYQM6ZfwSdpKjzsN0qTKfaTZ7TlsFMvn+3Hvhnwk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5595.namprd10.prod.outlook.com
 (2603:10b6:510:f7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 15 Oct
 2022 08:26:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Sat, 15 Oct 2022
 08:26:08 +0000
Date: Sat, 15 Oct 2022 11:25:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme: fix error pointer dereference in error handling
Message-ID: <Y0pulP9Xj/mQINCh@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0097.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 832b2803-c0b9-4269-8087-08daae86e88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ilgHuCmlBEifovH6c8FE/y2TJ0RH8x3/tfvxjuh1aPIuthIbD3kPGk+mf176DzNUIarq1td7KmFlZ76S/kmNpsja20r9XdJYomIgafKB3rUmyMKmjhp6v4pqXg18CnlC/X6I9+xvmEPJK62oKINvVYmwClxAkEWpfsE4xZ8CFdO7A24GahrACR136n1224K6lwS6pQ7EgTFJytYLVid5HNXtaUWOzb3OFXzqU8cBR3gp5S49j0R0FN4g2GNEvEO3iImzWXRetSRTYjT/U6C1V6mkLoMsKJkQV3hWT6NwvEe3D9a1SdWb2HU6FMX8sZQ8FKs3S5dR8CyW4g4tjR5qJLFlt61cDtw2f6A1aU5AFUKv1DE4BCnPpRwH85XxCRMADasf284BWeMqfgEzTDDvKqi1te5/nehz1FZqxbqaWHD7h4uaNPuS2ieKTY5kXMDm/8PSaHLpqBiqDggSCiRbxfl1koPsGocQ9lBHmW4OFQ1GL5udSGrhCvCL093P/xCFKgFivAHyDNhdWPXNZoPUz9LQXyIWv6Uq/jnr/OP1JjY0CAeBG8x5bj+/17fwZ9+cULmeG6O7caAmn2HZzAhTGKCv4cFLnM+0yHHpUXTlWfMjCbaPPZKXk1OhaOy+MI9C3uOXq/PQShrDuf+aJCK67GN3eiiVe9mCDJaur2EliuI7zIjuzBK1b5AtRgt46e4FbkBuyGSsOSWLGN0rIz08tg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(66556008)(54906003)(110136005)(8936002)(38100700002)(4744005)(5660300002)(6506007)(186003)(86362001)(66476007)(316002)(8676002)(9686003)(6666004)(83380400001)(4326008)(6512007)(44832011)(478600001)(6486002)(33716001)(2906002)(41300700001)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?/lcTi64afjPYn2wTrBneqNqeq1+rv1Zqp4Mg7oQawOcRvPh4GcH/oWchyi4Y?=
 =?us-ascii?Q?+KYaMdZmXtiEoF/5vIRMDk7C+DK4fckdSlqG/xWa9VP+G2qZeLVRNlzBGtyK?=
 =?us-ascii?Q?vKMGjS8ez2UfP8sk5mUPHFipyi6Zd/30oD8i19s7d6zXfro6dIzgJsAzx6Uh?=
 =?us-ascii?Q?M7/iu0lQn2LXrC0PMAp88T5bqxJUy15Evk/BztpP3EQH/y0tEGnTlyna6TKP?=
 =?us-ascii?Q?wLEub/6/1tvtJ1GnZSlBfcV77LPsIVtNYpjz+ls/XNVBRc07WOfhzH0HTFgt?=
 =?us-ascii?Q?b68/FdVY23l9t9zjXBJIn3mGgOwW6w7MMpQCPXvCn3ZsxoNyABi1G/UXYjT9?=
 =?us-ascii?Q?WGpStCj85FT6o0w9W0o8xZ/ixhhQKcSSL8ZFHMzQPTRxB1HjuCfcn/WP5HOm?=
 =?us-ascii?Q?mC8c/id2bih0sXL2zjQLS1SxcOlEblCcjyXZGD+xf5wTbH2JTQZgV/WWEFiP?=
 =?us-ascii?Q?Zmp4j2hIl9owf/YYW+ufIICgPjBet4mDYbucrXX7a/upWXAlTlpbR3ZF3GdW?=
 =?us-ascii?Q?uaVnrhnCSwZdIrUHEN2RiOMKn7raxVEoGA0mnFiOY3v+0F7ooiJDint3+n4y?=
 =?us-ascii?Q?pjuSoBbntiC28OKtERijZEAGDHUeQtfO7rdzCOHcdw3a0c7IHmiF08G6Nce4?=
 =?us-ascii?Q?d8Ulrdccj+cpyobWbMfvZ/5g9pVfPeIwLQWcC5v1eqD6B2qxkE0tIENNJTFq?=
 =?us-ascii?Q?7CvxlBNOvgIJQSoalF/wK63Rea2jDViBjme1i3waeiGIGA/3REhB+MsiSmNf?=
 =?us-ascii?Q?Qz7gpSqpweOFekhFDs2VLHXTsKLiivyIJEMQi2paInKfJV42zfsqDYMcPOKL?=
 =?us-ascii?Q?P6ATqSDdaaDUjKLSe0y0PQ1aVKEKWYoY1LIAjdR/S13q+I80xGt6CsjTofSB?=
 =?us-ascii?Q?BjrIKq9br9bzxiUPEEEb9AxuU6UzNQ0jgu8qf9B+KBepTRqSjuQ5XliBD7lA?=
 =?us-ascii?Q?GDP03gE8xP9glfc2ctj0QXv1j4LLv0qXyY6JUykfGpcw+yAAL1lqAzLEQ4Qx?=
 =?us-ascii?Q?FcP6UsmEAwoov0TJneHL2BlCMuaGwb8Zd2KMkNCnB3lW+IKOFHCR+O5N1it/?=
 =?us-ascii?Q?sK0Dwq+7MHcihRT67L5bxG2QUiz7tJpQdHzDAbSI/Fb0v5gy8uX9wNSAZUNy?=
 =?us-ascii?Q?M4gtU+cGaxpzn2tSVAFrA1fBkq03t8T30WF/R3WzwmANf68XY7F9slTdvvl4?=
 =?us-ascii?Q?puh/3TmkH5KUvbiwebbLM/OgLMFjBbLNx/xTpuc2ptIItyLy6YjZNteDZlmv?=
 =?us-ascii?Q?mBc/9x1/5hUDpZWkMuvkfwsnpj8JbEKteuH8gNl1oL/c9RZXthq9X5uz6bHs?=
 =?us-ascii?Q?itxR5RfPuP+KW0+U9xcsZ1elRs2X4je36bXkqs+HN6kuUMOjWAOGVf1qj7I7?=
 =?us-ascii?Q?pgZOqBeCw+xu+SX001pVzhUHCAFs+8Kmg2RhqEr2QozmBWK7H2orwse0fz2u?=
 =?us-ascii?Q?nzLBZIi7cc64RlIEUmswULyNn7scrQvF77SSvAYFpFAwI7OeRm2tLZKy/OsR?=
 =?us-ascii?Q?tp8+RStEsaQCWRsiPgaseEs10kIGOpCUv8+dJjqjrBQ/4qJ3+EL2un2QlDhF?=
 =?us-ascii?Q?YhkEcKBkRadAwjgY/BArnnoIagqPH3XbHBzEV7U4zHU8WFXLKPE7TDuSJXPq?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832b2803-c0b9-4269-8087-08daae86e88e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2022 08:26:08.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ez9GuGK54dEZNk5ttF4AaVB43x4h4fxDI0alxbBcmDg5A6DGvygoeO0ZiPkp2xfE9paK/41OpZ2MfxsLn7EvcamZZSMx8OZxC6dqhJMtZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-15_04,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210150047
X-Proofpoint-GUID: -UC5zzufANbBsgoAjasu1hICT4hfqGNq
X-Proofpoint-ORIG-GUID: -UC5zzufANbBsgoAjasu1hICT4hfqGNq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221015_012642_440304_4EEEACFE 
X-CRM114-Status: GOOD (  15.61  )
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

There is typo here so it releases the wrong variable.  "ctrl->admin_q"
was intended instead of "ctrl->fabrics_q".

Fixes: fe60e8c53411 ("nvme: add common helpers to allocate and free tagsets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c1..9cbe7854d488 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4846,7 +4846,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	return 0;
 
 out_cleanup_admin_q:
-	blk_mq_destroy_queue(ctrl->fabrics_q);
+	blk_mq_destroy_queue(ctrl->admin_q);
 out_free_tagset:
 	blk_mq_free_tag_set(ctrl->admin_tagset);
 	return ret;
-- 
2.35.1


