Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6834E732E3
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Sep 2023 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVhYgmoQQgwNGg70Yd/OYeT/fhog1Ihoa6b4xYGf9ms=; b=Z21R8iJhquxQFleDBOogAlsKQ1
	iIMszd7OeldC/I+dw8e3tJInm7q+H3JhUABhZhvVtwcG2qVGOWr5Vy7uwwgcCnBJc+9OSApUbqgEp
	0XEgaq+5eIAQFF4ggrd3jyhhib0rhJKpsMbmuonA9KmD05OOJC9ilUJLQ16b8iBWG7ZBwGxuQuOpq
	2+r853D/PCGORpjqKp02AolnO9iskJKSlf3qiqUqHrCYSNIQlFHVoTxiKdM72uDz+q4fS0jmsCAkn
	cBoq2FxjITHXQc4XAu+CfoDlh3fbXGRaMYJQmtqcpWCocBGjsS4kFhpWI3UR+B3yvNLLovaWoAwjE
	LDsb1ICQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlsew-005G4Y-2i;
	Thu, 28 Sep 2023 15:10:34 +0000
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com ([2a01:111:f400:fe5b::600] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlset-005FyV-1F
	for linux-nvme@lists.infradead.org;
	Thu, 28 Sep 2023 15:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcABmG5cnpz4o60+10eQrHX0PxKaAR4cp/4aUlR2hZOjlooxoT+mJv0aFNTnLAulQHuBafJGWAWc3yVdrj86DAetiLV7kXiuU0/Jibj9uDgyOPAQwXTxbzRFpJs6tJfNcLSgvAvAxsT4Ys1SQveT8xSzq5wbpe2apaorMzYsbBR7rnxOc4YuoRr3bPVlJ4Nd54zMztqOBL0kxYkyU8H9Z16CO9BQ37nf0A8Yl1Uily7bSR9V4b9cRqAWRVPl7izh95dby9l/2DsLreUX9JOmuLPXX2N/4NUs2Gogr25LZSiVAdVKs+m1R1r0e+7fa0fVJxIrmUVhvv4+rZdtxFzmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVhYgmoQQgwNGg70Yd/OYeT/fhog1Ihoa6b4xYGf9ms=;
 b=QdX7FKMBLoDDgbNCsl5Or5rOreuu3RKC5T5YnDsFoBH69HaTxpEyKPr24yYV3PsV09I9DEeAeEgdEbx9daU/eWETSj5wztImosNxfzlQtpASyjQMpvezx+BBiLFiA2BwzIuQmj97zJDuXsgeHCBeGHOKSesqnoFadfPQVI0vGgOcd35XhQ6MaEKKvm5h57midcwvt+qGq3gmoGCXGO5gVUQzJGoBLBONXA4OrmO03Gy/Lx6orMITaUcaAZUvqMiApKhVsMdu2rcArlrU4Y3biICykdo9CkhV7W6pVVyDAZqcU1Cb6itrxuj5oYdrGnwPfaXRz8Wt9I+7/jh8SRw/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVhYgmoQQgwNGg70Yd/OYeT/fhog1Ihoa6b4xYGf9ms=;
 b=BNHF/DK1hy0znzxOMf16s56TYmVbiBStOwYtRaIN5BSMC5jcK/W7flR+NU88lbeGdBovgyEXzIjTfG43EI1YXnKyiqqAsgGGNKZUYDM6CAr8YWnkdch3ivbh2kWvEnngRLOBVlpEAD4Qok2gmF6nyDH/GYcC8uL1UV2GbasQCaiY4j5aMEk6aC2zv9mpabtKfyMGlvDkgfipAkcOfShFRGZbZTtzSbrzOYMJNluihqX8A4fz1rRxIKFT56/kyrkv2yyOzlmpRD4MMr2CRzZpSSROgiAapzGQU7qzoaGXDcHIkTQIFM0XPzk7lYAOyBZvxvumsd5LIPYvjE5oN3PKFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 15:10:26 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:26 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v16 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Thu, 28 Sep 2023 15:09:37 +0000
Message-Id: <20230928150954.1684-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d58545-5315-4f2f-44da-08dbc0350ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kn5lxethGYXgGHes7SVCmT3ikANScgwgCpfoQx+h3Y1yh2vTtzmhykFHR8iOvy7uObRtQGCwJwiuFznnJukxe7y2AKimaEcbHqE6UQL7UdWbat81jySTeqaU1mZBhju0PUyKeGR0rAkb1/gdiMTv14tdAsn3/LT3qURZ6Tfyggs4v/uqfD2RKKp5B7002esnMLFkBwjooSVkVOrd7mFIkT1mw6EYGCU7YZc+LjX7RTVeuPdIs6FnLXENpXFrixAkW1a5fcqOKCRZ0laY4rXinTC5bFatfvormMwIgv5yei88Xjy4K9H7+5RWoi1uL4YAaKzhV9JZLZV5MIM0blvCLZGBJpaRl3z5czGV35f31qbhQ6OZ/BH6aok08rXzGFu+rozXeDZV9tIviX8vgI5Pj7E5cvJn/NHIjRpZWgBF0YlC6JTHRqgscY8J50ISAfGPaHKMTHh0YRxHZGJ4tV7JdaZxu+zjQPkDbiVUHcP56jXKyy8Ce13Gu1HoZHOu84HvPDHhv4m3HcY5BMHXMYYhQTQcwMrZnog6CQFX4XdbVl6PEOT5Dt82Gt9ZeOvJV9XY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(86362001)(6512007)(1076003)(2616005)(36756003)(478600001)(6666004)(6486002)(6506007)(38100700002)(83380400001)(26005)(7416002)(8676002)(8936002)(4326008)(5660300002)(66476007)(41300700001)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G30Xw7S6iAimRKFSB6Fx+5gqHwil4qxZkHdkPaJeZkd0QinXJrmw7Jh4/WzR?=
 =?us-ascii?Q?JD4u0xV5cGbH/Y+EQ+aOrIYLJMFQBBhaCiUzAajgFLeQ6YuxQsvePvRiy4Rz?=
 =?us-ascii?Q?BFAGorqydAtJPWb+ZdmPwSAI4nRQH58qt11xsDSC9xCVqvF/VNnR/+fFcNwb?=
 =?us-ascii?Q?/DH881uKEGyxb1UaZ9yqEh971vnc9diV/cH1ZQSHbGBBG/mq9BVpPXngE2OK?=
 =?us-ascii?Q?IHMhZBse6LMOGDP+RnAEjaCi2+4uASLvg6tImmNlTIXLFKYMoSCb6DNeEQX3?=
 =?us-ascii?Q?z5a/rl/HmeLRTtZdTbm4KKVQQ2doJZfxkthVp2/fHU7LLoodeTSlSXYuvnrh?=
 =?us-ascii?Q?A+CpZYASgYnWFvZN8LXgDK1tbfC9c/WvWU+W5jV4C6/eerwPN2oc54kZcjwc?=
 =?us-ascii?Q?V+CrbVVDU/kjqKnzhgwHxhdsMI76IRO3kVp8d1R95pxz0E3h0NSY0YBoe9F2?=
 =?us-ascii?Q?O2Hw3yUvq+jOZGlJJVWgBs0shscDltNO7//zL7nrCa46CzdGEFgv/SQV7/OB?=
 =?us-ascii?Q?1JKYiSYGmtr791GUhMBV4AK2vJHhHhop9xEL8frCvi7NWRqlmbpLMCwHPgsX?=
 =?us-ascii?Q?JJPIaGgx2zqDen7nzPsMn7kA3HswwviiDUqRgR2opVTjakIktEWqnRIUl51N?=
 =?us-ascii?Q?I0vJqUm2OPVHG70z9dEWIbwznmNADBT7m/gjg+aIFArLgOnvx+mcsovlJtiG?=
 =?us-ascii?Q?oEO0e5lNim26r7Uen7aEoFJvUtTfmxMK+/i2uxHIzkn+kfDG4V2aA0xLZ/zo?=
 =?us-ascii?Q?mTxpYjXShShdLRDFRe0c/f6EMx9JALZiS5NAxaPKcvErNxKuQh4g/XaUCvSp?=
 =?us-ascii?Q?+qWxw2GNj3cF+xfwnU1j0UfOLAyu4qpom4ZlmKi0Rzl2zUIPeXV4/0YJPFzy?=
 =?us-ascii?Q?bIxoTsvTiVCPThzF9A7KOYKMnsFA5vhrVMCC1Iaq7vl5n9pQoBUtWsr2bgtW?=
 =?us-ascii?Q?Vi5PgcL8iPKDf+kq4GtBtitcX+t0ra6Qj/pLCiyilANe7w1GcpTAB6ZMQ7KK?=
 =?us-ascii?Q?VtAsXdCDkhce/U/xZC+c70TlWKwRmKREVMJgxPO/xLDNkW5Iv84FT/FRr0Lv?=
 =?us-ascii?Q?LU2am0dzDyu5XTPZjsHWzYXs1LzkIzbm2OLEOMfPxtTlOZl8uKvZCxvuUh8W?=
 =?us-ascii?Q?nRTweyEmTNnn00VV9ITAfPnsqdpx5ULhTbhcD5OJMXIyBY4KKHPF7WYau5/H?=
 =?us-ascii?Q?EuzzuYqZR8wGZ3XUUwP1eqabnw10YyqRNVXIp3JrQ20fKwfijvQIaICpOa1a?=
 =?us-ascii?Q?V4CD1BEph3dkvzmLhP1iwXB1raCD15TmqU9UMDjqYTAIdMgIoCjmMz3b6+BD?=
 =?us-ascii?Q?bEldTUX1LZg6scBrRa1p0tKeNVkzfOAzlBcDXRndTP0vQcO54LC77suSPPaE?=
 =?us-ascii?Q?lTfShuOCGC15VvyKJ3WCKLaNYe6QRx6sVisVSUHiPAzcReFPQwM1FdRuPn+J?=
 =?us-ascii?Q?J23fhgVFv44rHvtfWXVo/qbO5my7qY/dF26GKgS5Rq12sDGqpqvVBYRx82zS?=
 =?us-ascii?Q?Vb6Hm1zcKCR6zLoiGBtkcWL7usvQGJtqImKAJ5/Vyzv1J+sAnUaq+Up5rJCR?=
 =?us-ascii?Q?gryCk5dd7QE9GqylqbUJJ6SQX+ohtEJrWErVh21w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d58545-5315-4f2f-44da-08dbc0350ada
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:25.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSn6Y4J5S6ZaOhurj837LBGpZCPjq3kseuhD7k1ps6RdrL/X/E+YzQn0TK2p0nZEXq9TWPCgN9pEsLwbKR5rqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_081031_448834_0270B46C 
X-CRM114-Status: GOOD (  10.06  )
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

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 lib/iov_iter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 27234a820eeb..279b2c5b1936 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -313,9 +313,15 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return 0;
 	if (user_backed_iter(i))
 		might_fault();
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
 	iterate_and_advance(i, bytes, base, len, off,
 		copyout(base, addr + off, len),
-		memcpy(base, addr + off, len)
+		(base != addr + off) && memcpy(base, addr + off, len)
 	)
 
 	return bytes;
-- 
2.34.1


