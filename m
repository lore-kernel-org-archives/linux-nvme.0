Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C967C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qHKKHJWiHmyBLmPeBQsZ5yWs5TPVwW7ARCEk4srpoW0=; b=Nyt9wCT8nD/kEp1X9rtbX0LfDj
	YKPHUj7R1wEqo6uWv2tIt2K2eEw5HZRlN8mZhsFmibqjWLkRBkv6k2UNxSdPKH53MC2R3+EJQiYh1
	MMHSuol1iExKvqUDdtokDkt4+cr6jwhJXzRNl/ogQ30H08DdrjD74RqdMMeO8hg/+mGzALnCKh1S3
	a4pl+SZiaKOrFa5u3V4iat2P7MSOpuGrsZ1XqEEe+6Sb1C1MbFgsX/RxZgsHxYeDqWC6FXlwrZHYe
	4TZdnbesW8zhvPGEnvncgXhNcRYA3vN8SKk2+fXCmVJ7P38GQAX0u9g5AfBfIg5frOd0K099uo6hy
	b1u2AnCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nnzMI-00DLKO-D1; Mon, 09 May 2022 09:07:14 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnzMF-00DLJ9-V2
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 09:07:13 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2498JwCR022574;
 Mon, 9 May 2022 09:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=qHKKHJWiHmyBLmPeBQsZ5yWs5TPVwW7ARCEk4srpoW0=;
 b=wNCXZGmZ21EjExly2sef1vcizf4pmjbLDMYOO8xOve7molBB20Bgu1yszlFLk4WMsCl1
 Q9iAoFProXGByGnaXBoFjSHgsTuP/OFUzQKSbg67ZB9jHca+XiFoIhBqj7RnR9NWoatN
 OVXD6lOeJD/s14PIBoWsGm6cZkXMrOKemn5LeCr917D0OTdEwZ4EO7b8EBUXl0Z18+cw
 5Z9bVLwoKbKLMgh0Mq0xMhJgZMXQswmiQIjb0i+dn4xyZvbtDZeRVVOtnqeETHMHEV4F
 rpdu5sJAllmWpduGA7Q/lfB71V4K/wFppR3PZ7j4UqVoTYtjhpQFwKtONyFd7PQSvjxy pA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatapsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 09:06:59 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24995LCH024922; Mon, 9 May 2022 09:06:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf70prrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 09:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPVWu6DBpTdIdP8kh/ztb5dcHYKgmPgCJ0jDcVJEBp4qYfL8m2jkyW46ArfpgpRu0aNB1DvHFIV6k0JXLV47eVC5Gd92KJD1JgSS1a9MF0hTla4AizkMGjh5tQc6b/H4jeP2gFMaQq9zuUlKiZVwhyEsSIHCvvYq8zx624Et4sepLJ+GoJ9ajeMSYXges3uHmyew3Wtq03Ib0pT5cJ7iW0blR2k3fuFAij92OrCaEZ72z6gzmiiE0H4Qn915V33J9AinbwWLLua4ezuzO/r3u8wcjbZEGWqOUZVJhFSo7jqzTlz0CWkgA29WU7owtm1+0wZbjaPvolAW6RCaMDD8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHKKHJWiHmyBLmPeBQsZ5yWs5TPVwW7ARCEk4srpoW0=;
 b=SKpEsr44rteT3Wns3K0Q8NdZHNiw6LcEsQQ4MSQOfjyEwB6P2nwQtZ/3VgWlZlVKMO/djoDUBJIbN7cL5KseV4J8wfle6oUBpMw1Y3f6kZBBeFXU6puoOP9tNwlmtcWcKL1nl41Ybi+/muigFee0P6eRsRoLJCAgcMeiz9gn9xomfDw/412AxSJNFAGXSZOQqg1WKLC3TY4+6BuGJS+VSkc39wUjF/5uFudzqtOj0KGkAxwkrp2Jy+uxR46ec3rzYKZniJfIrj29vxUUi1K8pe4dZ3k+1Oq0vkULheKD7bbtR/jIyhvnSPYjahl9luM+oGtJ3QRZ5OBinV36M0HIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHKKHJWiHmyBLmPeBQsZ5yWs5TPVwW7ARCEk4srpoW0=;
 b=XYbus5HLlr/dIOZdXe70YUZp3P9sh2qmYz+tbsWAtRnY2ShkJN9jT/OE/hdcJBj/kdk4D6W0iLK0wjZ3M4Hudb+f4ndj9NRNdsY7LHq/wGw+fPGcf8ykgKGKNTXTsI2h/l5K7oETolZ4Q0Lkxe3HuYY9Ea/WkUOwv2i+acPWsVI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 09:06:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 09:06:56 +0000
Date: Mon, 9 May 2022 12:06:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme: uninitialized return in nvme_ns_head_chr_uring_cmd()
Message-ID: <YnjZovrfnF0YYuvN@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0192.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b4372eb-bdf1-40c8-e4ff-08da319b4444
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45423165CB9CA7C047F128C58EC69@SJ0PR10MB4542.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21lnURvPJvUK49OI363/yaqElzCY4CVt6RwiauiXptBoy0jIKfSxwLpGkNtl7jF7h0cqsRZXP2Wyu604UsK+wMqD9V58bQ/yymZTTx2Q9e08xtfmhQTn03JVlQXGDE2Rf+6Wk+f4oLyg4aRwUj8Qgty7EhoHArBzupxQTktqYxAyoq6E8tJ05UftBIx8j93VcP0gZl4RWrzDgoNHIOHt078qOoW5jibeVSFwBVNsEORE3ZiEDUqFyzjSbOAHDiY8iPy7eOddE0qu6FZbuO9kveJz+18QzMY4fvphFcABhAfLOfuhTKuhzmhKwI/W/UERRmKqYXNZAlqBD5c8o7bTEgdpqVviZ4D5Fj7FS4BYvT5PdMRJfm84DluJAy0LNykgM44rrC6UACvpt572Mh3d+aXpTLFAZ3MyuJjGfKvaajVus0hchbTaXrDvodCqNFfwI5pieNRuVzo1o1JzhOhp5xrN4ci+yMGRs20B/FvzJ9tKQsuwjs7mVEl/lkosTzcJ01jfRA0/3oj5BsTZpqm/JvaVLS6FZyhl34fLS0XeHv7pBu+5aQfkL1DxKaiE6iIjczrAJVF9AWgqSVwcTH8Hsg1R9YNdXRIV3snJcgSWVC75pS2MyOJs1ddHrW2guuE6Zh6cHRstyQ/b8LCngz8uf3CuUy4gCelMlrhHZXDWq/e1zVIdO0i4YL8NmjgNx8eASqYUnLqeQHMEHFH8beREug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(33716001)(38350700002)(38100700002)(110136005)(5660300002)(83380400001)(8936002)(6506007)(86362001)(66556008)(44832011)(9686003)(508600001)(4744005)(6512007)(6666004)(26005)(66946007)(6486002)(316002)(66476007)(4326008)(54906003)(8676002)(186003)(52116002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AEV9KfIAq2JMmTWiANE60JFAbt4/oKFWwB9nd1Vp6kIfZQIiFjYs6FjUVjeE?=
 =?us-ascii?Q?v9WPLk4fIvD6ZkuT/KOh6a7cYslMf6pbUH/sGQFGaMmnZ+2bDmZd6XJhFYWz?=
 =?us-ascii?Q?+KAcK+maAFeqXkEtCO7+KQy/GFYcrKLyMKHPfqbFkLZyfZDbZZNe8oC8cumZ?=
 =?us-ascii?Q?pYHGnRCUeXRaH3V0bv/E15rrcqNE9Vy96sF8ZUxmDcr5mazVvLDcNx69Y+Jx?=
 =?us-ascii?Q?SheXPLhHvmwrqbZwBHsszieDAOYC5LJMn7SpaQNBDgxhEu6RoMD5Whk/LNKd?=
 =?us-ascii?Q?frfC/as7rTLN6MuPam7yxu9vXu5d+bBHHNzqSuQkFgp4YnmaUdwkmUJAIxiK?=
 =?us-ascii?Q?+ymJ1tIInbGNBWPHXZm0XHdv3sUmA7yM9ToKj78tB0FrGM5HzpaH8bX7d5W0?=
 =?us-ascii?Q?rvVYTZ6LOQ+CopwfYfY0b/S0gVsCWonYonY6MzkrCwz4tBfvksXbbzmQFwjq?=
 =?us-ascii?Q?royVmWjKP+9tV7sY5TR+ok1+tk1s6IUxUMVYdl9cl4tDBeY9IpV7oZNQyo1e?=
 =?us-ascii?Q?7kkAHIKVDAaJL5QsBPCmt/nvdvUxytZWTGfd5c4079Vg6FGqXZFBcrswhvlo?=
 =?us-ascii?Q?ds/nYJ51YW50OyonCfcfFajstjD4mbGQLqtNqRNxi6qlqmp71ynQ5KNk7qzU?=
 =?us-ascii?Q?yDRo/TYXrwERlfT8QzVUZJRJL2ZLT2cLYt0yLw1MOM5m7I4pNKpULmMzCbK5?=
 =?us-ascii?Q?gDzIiBlNDpfh0hCthrpdtcVfmh5AP8eRxR4ik9n8WYarBSJ2ogPyGBCzOuBj?=
 =?us-ascii?Q?jGOG9LlZzokTtlPtClRXxmHutFnTIke3PBm061Nt+QvEpCQrzfGdTn6+/jLx?=
 =?us-ascii?Q?HSqiSiWREYfxu3ztBwwwXzvZhTjJjXGmB1c+XPzRtwxe98h9/bR+/UC4d7/J?=
 =?us-ascii?Q?mTwuL2adAtGCic/Z2wwKngluBGLYnX8qtWKkHN5WHaFY2wLRfikHMy1EheRE?=
 =?us-ascii?Q?ZJkGeqPH6UnoquDJFU6PVY5hxYRCOsNHBP1kDAjnIfjHT+5LnRJ2ACcUWcMR?=
 =?us-ascii?Q?ejbfi4cmESZjglRBdvVk45LxsKIXzBuVkfUMXbeZkf032hCxifrdineCgi6S?=
 =?us-ascii?Q?6ZY0kpAksbwaQIZrkU2CPPD0Qx+pbqP2pY6Yzz+zyeSGu1Lb2WWv2VhGEnmJ?=
 =?us-ascii?Q?X7NX5k3idvjyjHDViKZf/G4kxPWuyLzJrObKFLJjGp/cP8WuuTInysYtB5Ii?=
 =?us-ascii?Q?aHKswEMCkmbLQZavmuH+En5fodCwuRXrLZvb1CM26wmVfmW/BCl8qtRTSoqi?=
 =?us-ascii?Q?mS8dhP4Cil5dGzOESoQ2kfAacx+1wxry6PO5r3XK0j8DQ9295q44hmLktoeX?=
 =?us-ascii?Q?sQeqEpEC5RLJ/nFh8OEQJjJcPIoHzl4w1UUxoLLA6s6dSs+7v7JRWQnSvas3?=
 =?us-ascii?Q?XjHL7fIstVBW+ERm/NwuccG+pSugV3uPrDwR8tKwykTly+ePluuC2d4UvK73?=
 =?us-ascii?Q?gWR2i/5zoQsPfwNvEl4KlsaXQvx5XYyZDAqBE/llRdYCB2me4PCnwZnk752H?=
 =?us-ascii?Q?1qI0KY51715B1PwZVENZTlb0hiogLJPII/VmGm8ikvM+8Twa8rw/+D9Wq1dc?=
 =?us-ascii?Q?roIzXJAiW4q8O7/eRL3D+EF3P3HSPGxXfeEoAsdG9lOipsNZClTXPTKbnTFX?=
 =?us-ascii?Q?1t9uS/tAqnHdzDFehI1T+SlivHJrtjM76uBNNdsdSlgwLH1rg5L8PI+MKqnb?=
 =?us-ascii?Q?QYYXEkZ9FWwPp8k/1xw7l2gufbTsnzsbl+ZPeQb8G9bcE0lT1UJ9Z3W7MJxW?=
 =?us-ascii?Q?7Gdw7D9FH2BeTYfCrXUaRw8AlmfsMGg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4372eb-bdf1-40c8-e4ff-08da319b4444
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 09:06:56.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8ZTFIjUvP+ro782it1uDRzLYdl1xWMBTlXSzPX6v/8Nxpo0gasrY0D73oU5ioQYcWqDaDDAI7jAWwwza5H1cj5EvRhMKcQh/QF3XMn5pGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-09_02:2022-05-09,
 2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090052
X-Proofpoint-GUID: HEshBcKVCKgQ8Ej17ImtKCZrHCHvr_Xp
X-Proofpoint-ORIG-GUID: HEshBcKVCKgQ8Ej17ImtKCZrHCHvr_Xp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_020712_058546_4114962C 
X-CRM114-Status: GOOD (  18.01  )
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

The "ret" value is not set if "ns" is zero.

Fixes: 86116c2f6fee ("nvme: wire-up uring-cmd support for io-passthru on char-device.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 4b91e452768b..c118559d47f0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -688,7 +688,7 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 	int srcu_idx = srcu_read_lock(&head->srcu);
 	struct nvme_ns *ns = nvme_find_path(head);
-	int ret;
+	int ret = 0;
 
 	if (ns)
 		ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
-- 
2.35.1


