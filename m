Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24550C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bq4nxhdkdi0kdenlVbgoq6mtI8OUGz8na7GBkH8UT54=; b=2acBz9lfkKvLO/SR+eTbW1Pu3l
	OjuU9uw7xoRC8OUUWT2qnmbUmL1+W45E4uNhk0VqXP7B9ao1+6dGTkbV65VWitI6lndbHZd0zXzlf
	kZNjqMSzl0ZunCxhuHCtdkuTWLsJiJf3Dr71d/aLG1KjtSAFhFQ8S/Ydswjpapzkj41gt5f00ODZq
	wn/h1J9x85kaiopucJ3sSG4JnBGF9arJZCaD/QXFB75OGwXcd+jT/mTAdLKVrBHn8NhFKr/NjwRnJ
	1/GfECSy7KnZob988bHje1deg0p+9ahvtQJK1eABbqLMjyUzEpsG4iSCyQBAxcAFmOpw84x826zwo
	z6YSk7XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSuQ-00Ddck-MA; Thu, 20 Oct 2022 10:36:19 +0000
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com ([40.107.212.62] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSdh-00DSlg-EX
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 10:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOZYc7NMs8y5qDPWa+zYYwlvWH+nFy63Iij1MS7OzjKSBMK0IYmwrMtin3n/L+wVxkDL92Bapzq4jZvIZ494i/yi2Rh+TH03Wgkn8eSegDsSMZxLU2z7PiInmaS2zYNIt+TSGBOiDUY9kXU0fi86pCfFwYfEyYiFgfVHogh0wsyOs+71Wg248f10hLc3DFAQXsBsHbzEKGol3f4iyzzUFx/JnOIrDfRTJFrA+wE4CKZbD9PhdsmeK3ZkFJsn/QFyKlta6nrMa1z/0svEo25ToG9WIPBL+k4l8D4G5yTaBqUU6vOjT3jcLIkqa6TDtI0X7dSerha+ZRNyvwxytNR8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq4nxhdkdi0kdenlVbgoq6mtI8OUGz8na7GBkH8UT54=;
 b=J23UXC4UYoxIdChwH9XU31ScuNwc1IpwcNZAtHo71OHGXs2Lw5usIgv++MxJkqiIYtaEkeI2ZOF5ZfdvD+WbQOJ6dNJAuOzXPg9/A6vHjG/eW+Ye27ny4lWSZQPQEHySEKRYpJinSEZIPhpt+5FbNiWf0KkxrMg7CbKCDL6z8F7LXYsWYyxuQtnJX1t3475kdLEuOWmMgVm/fp+wHHSknV0Q0aTZrB2iCjWDKfsYTtPgae9R1hg/2KF8Wj4HFDClyRSw3grfeW1hOuB4ENwd4IfSfLsvTXIf/Vq084d/epNAJlCcoDUcG98JcTL5cNnF2uAhPVpScpXR5uvyu6IAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq4nxhdkdi0kdenlVbgoq6mtI8OUGz8na7GBkH8UT54=;
 b=VelAZh3PsTcWB3xaW9V1xiSBG8VstCfGWg4E7a4v62n5waxmPpEW3aAifFwmFz7iuqdLABldPo6/LD0sAN+e5+9IKoYkeyKvuaLnfn2tdBp8a4DcMtyuKjnDIEdhX3jNEGtDb0YUEbis4o7MM05n0Ey1tTpE5+8LMugfgGRVw8DT6tk08zA5HNCh505GwHmJlUt124hA19OBHG6/9kwYUjRUXHneLhg0iT6le6t9AYjJdD5x4YomCYaykvtcU+KBRbGw8azarsLrq0jf/2qraiAlNSBQR8CWDLnvbmrGTt6dHTcLTnuqYi7NV8Qaw6vYpYIoz4U2xVH8YrlyDSKgHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 10:18:57 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 10:18:57 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com
Cc: smalin@nvidia.com,
	aaptel@nvidia.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: [PATCH v6 02/23] iov_iter: DDP copy to iter/pages
Date: Thu, 20 Oct 2022 13:18:17 +0300
Message-Id: <20221020101838.2712846-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020101838.2712846-1-aaptel@nvidia.com>
References: <20221020101838.2712846-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0661.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 397099e2-14ae-4fdf-b0b3-08dab2847f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	53LsITuSpmHvBR81KSpRxKG33bK93vZq4Cc+H/56zPAHjqLzM25Hk6QKL0RcK0pb+17331fKIFyfCWFATBqPeLpMO5h+Hc/CmoYvYM/bMmc/6Bz/tdi8GMUV6P+MWUrJSZQdWpqfcp40mJWkPAhoRq7iV7jaa/VAEhYKaD78zTjBu4sxMXmDpIsyZRfcqHTFExGzriccSc/Adadb1LQg8/H2ycWnU2hhvgV1dBmMa4Onp3Suyo3byH0SftzaKnnimZP3PEuasXCwg/NY1opPhk/f5JJoppSt1iNTxKfCsE1GiWs95VxdN6wyDpm9hfrSorIyGBZn90EaEguKUxWhWkY8P1FFAzAHqsyu0yRYc9hAapYAuD+RbrTA9fJ5AuJ27W/iDma5/Q2Hm7oEqftNcgJVpA0I/+Ei8S23+NC4O9FVmeUkmcJZyDqjzoxBqy89UmWExi0H/cpBxIz1UvsfIyJLUSt+5CN0XjSeIbmSYdZQl/vOe1wiX+0l/9XLAZkPMXVpz7UpQ67x+L58N+aTvdFWgWT8QW2sz9vMt/vm5I7jQwzWSsSFb8L8uJb0dIFs29eaXKS7EJ/MN+6Zvpv1OONggBkzH29duDrvAhjLa/CM6wRurDnJIW/ODaXr3/yfJ9BWeXNEr/lTfgtDGkXEC7itEC+XBUBCDeCQveT/Wm887ns7rx474I8E30us2vfyEOCnQRTB7vhf3kJGXtud30EFh2aa4IfdIr/j8OosB/jEKCqCaKNROVVeBvOBSoAE
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(921005)(6486002)(38100700002)(478600001)(6506007)(36756003)(2616005)(4326008)(6636002)(86362001)(316002)(66946007)(66556008)(8676002)(6666004)(186003)(66476007)(5660300002)(1076003)(6512007)(26005)(2906002)(8936002)(7416002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?gOMxAwGLjM50M7NGbB2wGI5+Dp+ZpbfIkNodoGAGPB6IbKQ90Y8w7l/aVvW4?=
 =?us-ascii?Q?g63htzWMTp3sOuDG3YDDZIrxt01zi0NAAM4BVHLyCE+6YpyglX0ZHEq5R5M+?=
 =?us-ascii?Q?mHfEMVRlBSBv5sq0ZvMVycx7FxZvrUkieky7sZQVAlBlIDVBUIlp1NHOO/wY?=
 =?us-ascii?Q?0xqY+G+D23tBQHVp6w1DV4faZFbBJYjby0VvNsCmytQYjV42gy99FkNL+kEI?=
 =?us-ascii?Q?Wpvi9bZe8zqh/hTKf/Kh4r8/XNzeqZSI86T61IQtYznORNO+ZV1xKnkL15Mb?=
 =?us-ascii?Q?8OJU5dJLIJ1OSfZLuUVPY2kWJbDEcxNfMMK8ZMKvMNJ/cIfr2vYPbMrIiBo+?=
 =?us-ascii?Q?BvQ19Ph7Z95Q8t5VjmZLxnGm97oQNv/qWm/lU/H0yDzyf7qhPli7MJOKfCeo?=
 =?us-ascii?Q?8JjV4bs4QxUbIAOQ6Kc8ywp+dLqBrs60pdpH2lHBCl/YCyL+lAB7RGyq1SnI?=
 =?us-ascii?Q?rq/9hRq2GvUR4zNbrVy9zx7hdEFL3pAP8gWF1KWYZPyJ9iavMePaJtbeK0MM?=
 =?us-ascii?Q?vOuse3+YirvOXk5oKPETU5oepAbDc3uNVZ0WqVYQdV/LMPeaV2JCBArPmpFY?=
 =?us-ascii?Q?wwkb6SbphHDSNhQuAdLEaVdtfoSR2WFc4DXr2/tVchzMNkaHlcSftNHWr4hh?=
 =?us-ascii?Q?h03/w3RgEOLLXsL0CWmnJZHzV7cRH1UrxmA/Z0cZ9V7f+L6kIjsk82dtAem3?=
 =?us-ascii?Q?3c3Hz5fGjU8j9OQMXBxw7NzBfGfaHOBAJxkOGaf/ECAGk5UrETcUVlCngEVE?=
 =?us-ascii?Q?TImu6Xwcrb9iIMlnbvf+QD80PbmJZUmiJWMxrS6VRGYQcMfL643UHv7qkKzh?=
 =?us-ascii?Q?3+ZocTPAbsb7VPDfylpcM/GHVRa2eHUzvRKAbQC2uaFBkMoYT+iOjx2d5ZN9?=
 =?us-ascii?Q?/1YGMZ/puwU8lWiTdgsgBhQKr8wPfS3GRtNptvjX9wX51CKHgDLJB4CS7eIm?=
 =?us-ascii?Q?9QDt5vbpc2ndJm6/T0y4RlKxSFTgGxy6lYYdoQKa9uzdFH9p514j/fD1G2fn?=
 =?us-ascii?Q?TjJauU8qjqp4v4dN/chHugdJlbdOpHLv+1zu0NaWhkxUwLz58IFrOMTGQ6Wk?=
 =?us-ascii?Q?yyYX4pEe18vXWkGxO5DskzJHjFGFDKQ/LYWuu/+cfhBSax9kA/fEtNfURniV?=
 =?us-ascii?Q?jIgVnEZqsAkgRHifexP9fiGdoHQOZbI6xeSyq6x5kby2szsE3bpq+BvViAQw?=
 =?us-ascii?Q?ucbBT9v4n7iPBhZem5b2eHoo3dxoIN6Gr5+fh0w/oR+Lx9jpSZ+6FqZ4Q/6G?=
 =?us-ascii?Q?RZhL7OniAIRBty4H77dxpmNVPc9CIQ0zBQk2s82aTpncKVuz/+Bhs41FDd9b?=
 =?us-ascii?Q?PUixS2wwEW7QakP1H/nNBsfNgNsHkPkmWbO97bBYCGB03AfAUvR0OsM/++er?=
 =?us-ascii?Q?hphFqtol6lU+7IS+NJjhxbOPnb83pv2TkHGiAzRXb83ioukYXq0+GBflK46E?=
 =?us-ascii?Q?tkPrYcOepu5cXh6bDfXnDS3dTrZXaZqJ6VdUyRuSjCA6qdG2PWE/ZKS2Mw6n?=
 =?us-ascii?Q?wv0R5TmK1sPLD2w1z+3ta3fFTVtr4PSMbkf46DkrjGQbCj4j531wj3rutpyI?=
 =?us-ascii?Q?TEO2Pos6tmMWuoY2QJHM2hrDY7tQ4/kO2evgKfSW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397099e2-14ae-4fdf-b0b3-08dab2847f77
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:18:57.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLdTPBLLbnAHrKOMC0ZY5U7ehthel7jClm+gi4Q0/sK2MlZ/o73V3oZSbSfEZ5mD/ySdaG9WWPMvn6/bMov9+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_031901_586083_92260C90 
X-CRM114-Status: GOOD (  11.62  )
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

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC writes some of the payload
directly to the destination buffer, and constructs SKBs such that they
point to this data. To skip copies when SKB data already resides in the
destination we use the newly introduced routines in this commit, which
check if (src == dst), and skip the copy when that's true.

As the current user for these routines is in the block layer (nvme-tcp),
then we only apply the change for bio_vec. Other routines use the normal
methods for copying.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c3ca28ca68a6..75470a4b8ab3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -526,7 +526,7 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		might_fault();
 	iterate_and_advance(i, bytes, base, len, off,
 		copyout(base, addr + off, len),
-		memcpy(base, addr + off, len)
+		(base != addr + off) && memcpy(base, addr + off, len)
 	)
 
 	return bytes;
-- 
2.31.1


