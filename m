Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F88D39431
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HRwfqbHkrV4zWaWbJCJZxR+ZeOVrCyWzIJGDeAyfWLs=; b=lrMWQZ8qcJ+K5AvqkM2XmzHSkW
	SXixCHgfJO7B/bwt8+slLbNqgGwOhUvslqfS+f5+IN6ijY1py/pvP/r7sb1zV8YFl5Farq9l0FBvO
	QSCd6AkA9tY7J0+d+CfMkTTsqzDc25aZEpvxBBNgw/087vYH0BleYyYtfKF3Hg9lC9L1fHckJ/fXJ
	SYcm3TJOYBt+unza2XPfr0At2z5+DkA1s9NrLdC20oMzXqzqBBG6qeM9M7TKuQ+MZVd5XNWRgZ+1W
	s9XEC5PiOaWK6x5Q4oMhbPYKTZpO2pRPtOcttHbgCntrMFyq2lYBUJLEViT+N4n+i9DpyVLrnZb95
	k0Ng+PJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Iom-00000000GJ7-3AD3;
	Thu, 02 Apr 2026 14:14:44 +0000
Received: from mail-ukwestazon11020110.outbound.protection.outlook.com ([52.101.195.110] helo=CWXP265CU008.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w83y8-0000000GJBT-0iXQ
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 22:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/8UjYGxv2lgwUFDW+lquAkJ8Q49p9B/elfU0YAyKZJPjZ3wAuWjTGmq8auKlvceQJRoMorwt6/KTXdy9L/7ncYQeI0/pLZWR3U4yt+t7464Zmpsqn2eGMrjd2Sav+kYEci8nQ+YNbIyOyEIB61OzaDWUnEpVUwnXvJBoiyDWbDDGdpQDRaPvtrGsiV0v0dBgcmoC8RNWbkSzoBDRwKobww1q5NqI9/0eMJvdyT747Vb5PetULd3dOZWPmcCm0NDsR5gykeOdYypLA5Wc1sCL6KU5+TEoFexBcKdRXbYaniyjt1nJyIxm1eqFbddNRXR33+YEkyc/A6XamhKaSwRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRwfqbHkrV4zWaWbJCJZxR+ZeOVrCyWzIJGDeAyfWLs=;
 b=V1ikYujUdk3EZ6tOVjMc2S2TDKOYQ7Upn0ONqvxDbRVDnjpQBdzzxWJ/yVeHo3zkWACIAsWpb/R6ZHgxbho8B2S3wJZHDUo9nSTEcrXZxRAu02xa8YImrNj9yrjBg+ToMD3a8BaQ6vGneneMVnVZKirvB2Z1gm6EskazMNHzXNgo0W83jf5U5l403S0D/sUEwWJX5So0GJ/or9UsiHvYP5ecpiX77d4ujUh7oE9uLKlCjRPFFBUftSne0SOVRuo1lCaPJWusLc8fpqSMyVpiPMjlMgbwBvEb+P3DOnnQBwNoOUpufQcb0r6g94APPaBEe6GnxH5fRFiJngeryJiQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB7844.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 22:23:19 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 22:23:19 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	mst@redhat.com
Cc: atomlin@atomlin.com,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	liyihang9@h-partners.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com,
	jinpu.wang@cloud.ionos.com,
	tglx@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	ruanjinjie@huawei.com,
	bigeasy@linutronix.de,
	yphbchou0911@gmail.com,
	wagi@kernel.org,
	frederic@kernel.org,
	longman@redhat.com,
	chenridong@huawei.com,
	hare@suse.de,
	kch@nvidia.com,
	ming.lei@redhat.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v10 01/13] scsi: aacraid: use block layer helpers to calculate num of queues
Date: Wed,  1 Apr 2026 18:23:00 -0400
Message-ID: <20260401222312.772334-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401222312.772334-1-atomlin@atomlin.com>
References: <20260401222312.772334-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0974.namprd03.prod.outlook.com
 (2603:10b6:408:109::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 273987fd-ab63-44c4-3663-08de903d46ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eWX4bObggC0KXolHlGWxvkzsLKMPfuLhespuQ3YvItCXfcSEAWAJAS4SvzahS0W2kslH5118odi7ig75im9YVC9iccvVZ+7NqUYkDy06ai3pUepF6qgKOYksJJqW2l1zJNNJ8fwouD05tSK6fs/QzBvFEHmveB5rC1RJ1D8pJZzegGYuX9t71nM6TfazTxz3j0FOTKUgk/7oZpQ5osfslqX35QfbB7F4iekOaz6ASjMlzwzSKTvTrlFgi/ZmRENkAfIioqMcudwSvWzu5hEEIt5vKvy3xiReXANj703FlpD8W57LPAZl4MDkxd1rTbF1G9Pko1Bdzr+mj0MqHGFE7W2qpTa8cs7trfe7VExA6+6qdoXb5+fnGgu3UK+62XgcmLipdaq+44cMGF0+3Dt1JfjyPA2H9SAe2PwDsZySqGdmiNre9TUj9YfkEAil6tyr2GAgwmeTPgT5FGIDpzNCbQZbMScYQZu5d3fti45yirsQOY0JV3jERcR0LjcaJBzQITK5LUA0ygomaodMw91dzSH2ECsd8VLbqT9yNTdEaRDDB0s47u37cxfGMu6tMbRuWNQySaq8QzdzpDHC2BUogd77hWUSxuu+dlzE/6YnP4yvlZQkRbcb+JOALnRo4cWx9Ahsv5SdObTV6NnF14aPSVTbNMKUepooDRIiwoGzblEiM01EOToZYtVth+sgH8HxPI+hFYMzgfj4axbb3UaweF3gn4bXM3q1yHKo0FVUNqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rjeuEsyex+je8oytSDOOYUUoaLB3qY8l9EN5PFzWb9tR9lc/USW750fNV6v0?=
 =?us-ascii?Q?8HNY40o1gfcilT4cP33ePEILZdo5N/58F4FFgQ2EY2cfhbNvtgAMzYeil8BY?=
 =?us-ascii?Q?En2BtyTi10GdI85mGzudGzjkJmdGHQX4qs0c2v+/QjRd46G82Bd4Gx3zoJOd?=
 =?us-ascii?Q?WbabTbR6el9e5XVy6uJcQFIprle63Dy75j4FHI13IRn1J/wZDhhrKSuYcNnA?=
 =?us-ascii?Q?ZFlCdcPfAnmFYC9dlq+x/JRAT1ahns29pMiTLIT43wV4Bu+ZUdx5bFls+LhE?=
 =?us-ascii?Q?oR4o31PUWu03WU5/yPToU3/vk1G9h+Q5NgLRVV1bblqs2TLvsdvA8aeF+9jV?=
 =?us-ascii?Q?LZ7rMu4wlRabfdw9jit4MAH+U4iHk8UQXUge8jXKTF8Us+bvKSBoBWkDfbbc?=
 =?us-ascii?Q?DgRlVaCD9ssQ3/PZznY4qCAd51KccCojcve7lEElEfk5jySfJB4pQ3nIeN2l?=
 =?us-ascii?Q?AIPURoUAJ/Tmv+8Cyw/XaJx65KYlJLg2JI+0YmTRSelgxfj7r6NuKavuKc+g?=
 =?us-ascii?Q?IkLNpDBlsi9kEsh3MdBMZr5L7dSyNTKDDOlHo2HwxgqXY80iQ+uF2BsAPsRT?=
 =?us-ascii?Q?hYJKVPIty8rA8Xqm0AjcoGJzIUimEd5AILtqx857nb6vLYQKu1jdnnSOhFXe?=
 =?us-ascii?Q?Rtzi7sru9fKrvR0DyWMJEBAmL2VhzYrsUaAHtiQfocam9p+ukvwVBjOVSBbQ?=
 =?us-ascii?Q?oyg9YJ9q8ilSrb3f7d4sIEbFVPVYkTxC85R9WQESKAWAgeN9rX7EJXotZQR/?=
 =?us-ascii?Q?mPrNeyAEDMjqpjBcyyOsINe50jNVp5tqGC2zlFlG0U0dNgiEBzk4eDVoyElk?=
 =?us-ascii?Q?uZSRIfW6HhBzWeoMQPWFO8P/0LkqpmmNIF0jqa/KwR7RS9THhPKn3AGt5mFE?=
 =?us-ascii?Q?xK6xyUEYEAUA6HjKdw6VBd9TiEKfcDic35RQ4Hd2hqcp+aFVwXniVqAPt9oB?=
 =?us-ascii?Q?1YwbseKVEJmW+3qwTF4jWxJppsZ+hzG+E1A434shi45RSZQbQn4IYMfQqCzl?=
 =?us-ascii?Q?PM2HTVGj00+I4kanm3FuLlN7bs/p/wzlv12A5U6tNtzzpzQnJnghclHGiCEB?=
 =?us-ascii?Q?HqxrX5GZJGHNzS9U4R3y67zcO8iWyR2iwui16UMHrrGYdSy3ZFgLUVtk+dra?=
 =?us-ascii?Q?0/WIDhya8sZGCPK5fFQOMqOPrprfr34TIjZQOnRGHMkh4hE7XhnBtPNg+1MH?=
 =?us-ascii?Q?jvwEO0z3TmQ/rKNp/QAzCmSmpp1NZKdLfJzCahXZI4JlWzOFmh8EH0S2wpij?=
 =?us-ascii?Q?70A0RVkd4lj8PYPyCFTc7fnusuyhKgZcjj2Ibl41/1R9gcFpI6aKOxGs2Ewz?=
 =?us-ascii?Q?hKpXAqMP6T85e53dk3qFjJGQ8lcYGHKnjmdh3FIJYvEzi+s7cVB9j0BoKGUX?=
 =?us-ascii?Q?lOtIKIOjRiksmDKeXRi6zxynOcZ2WZe9kLVqWd3LCApuBvXAXCSY4aTi6Mmd?=
 =?us-ascii?Q?JGQGJ++yNeyCP9ZgbpnvveU25mYY2p12vYEHQFrtE+w0wP08jkSSz1CfS484?=
 =?us-ascii?Q?yXlzavnYGXb8CQc6rPH/e5uPs1ourMXdqqQDka7EHWkXYkJIC/Joabr7UIqz?=
 =?us-ascii?Q?kxGybuwt3Yj/ZuNR4J71OV9PRx9rOvqav6sytSA96CUT2tYN/PqB4o+S+rTq?=
 =?us-ascii?Q?XZfKwOCk8LAl+2Qnf54pd4KWDB67wMzdOo0bvXxPDPYphjCgyR3OCJKuZFfM?=
 =?us-ascii?Q?SOY8Giff4F8EjWqgEjzbNMwxRnnq2hzJYDmvwLdGmpADzIG2FSW8qwco6hql?=
 =?us-ascii?Q?+02IHCtPow=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273987fd-ab63-44c4-3663-08de903d46ef
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 22:23:19.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4RT10r2UiX44OO1L5MaupQOorX2PGjPv0TWRt3JF+ZLfLyU0M7zL5iUItblg5Q7Ofe0kn65/ZRWQ6xWZA3HHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7844
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_152324_210764_A91EB9A8 
X-CRM114-Status: GOOD (  10.00  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:41 -0700
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

From: Daniel Wagner <wagi@kernel.org>

The calculation of the upper limit for queues does not depend solely on
the number of online CPUs; for example, the isolcpus kernel
command-line option must also be considered.

To account for this, the block layer provides a helper function to
retrieve the maximum number of queues. Use it to set an appropriate
upper queue number limit.

Fixes: 94970cfb5f10 ("scsi: use block layer helpers to calculate num of queues")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/scsi/aacraid/comminit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 9bd3f5b868bc..ec165b57182d 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -469,8 +469,7 @@ void aac_define_int_mode(struct aac_dev *dev)
 	}
 
 	/* Don't bother allocating more MSI-X vectors than cpus */
-	msi_count = min(dev->max_msix,
-		(unsigned int)num_online_cpus());
+	msi_count = blk_mq_num_online_queues(dev->max_msix);
 
 	dev->max_msix = msi_count;
 
-- 
2.51.0


