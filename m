Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E72C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=fS2bW7e+VMBcP1Dp8hbv+vP+1cdl4MqtUzMjychWZ/0=; b=NB5mLiLnEuSPr5
	RMiPZyL7EYRAxG/jc7SVU4hz3rD1mT5wByMgiHGigpUG1CdaS3QqXoFxzsrs+Q088prHc4wKWslhO
	xDUKCxH3ynCVZuEblL1zvB0Emg9xDOOouRCgeqD7PkYvK7U7NHq5djkp1cwd1ScMWCs5A9mgXcQxN
	9pOpQ0b9yEjUc+AGI5fBOHmuBO8c0E+QGX5wzLCVtqt0f8SbatA1zPt69QUr3QzavGWC5dqrB4ZU1
	bEJRG7GFiae0I3/dNQb5cOb+d1XXVPqirr4fBE4rr+HbN17sRJQVtAMIH4vHiFDxdetmc4QYGzlGz
	POf03msauur62xzw14EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDOeX-00Ci2x-Lk; Mon, 18 Jul 2022 11:11:05 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDOeS-00Ci02-N0
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 11:11:04 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB3wkG031661;
	Mon, 18 Jul 2022 11:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=fS2bW7e+VMBcP1Dp8hbv+vP+1cdl4MqtUzMjychWZ/0=;
 b=wZdLfvs1vlY8uIqHF4K+/MThcsSMjp6OLliparsT5gnCS3rmSEX5qjCEDGhZCgGdVU0W
 vEvQXFLXBV90K9ZF3BXKMAwm9FS6GaGaduwa+JREqT31JEt4sQW8iDUkuXBIwqrQx2oU
 jX6YHl6zGRc3zQA9yoNielWwHoX6ZmZY3VmHm20CvzmqtLFB7wJ6DaJfXSNXGZAGMHkD
 wdBGwQTRSmsEClCn8PYN4Rr6Ys42uf4hNWZ7FDpMB6ogfrbvTYP+i7tiOINpCaJIDVWq
 /7twE4dY26I52SPjIsaROpRDAH5y9af2Cw9QKllV6RwsipGLeVsYAWYsMrr/rztlHAhF KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs2wt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 11:10:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26I7mdH9001305;
	Mon, 18 Jul 2022 11:10:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k2cn8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 11:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAbkP/P/ZJA+RZHD1ifX7wv+DweR5pEn1cNd63eQqkbPrQ5w1M1Tl0yI8P4lPCjoqp0HGDA0SMD05QRyEL0c3kj85mvfMhQ9wZbZtDDcjb/cLs3OPhxA0Wcxj49r9KQPzDin89BuJz7ogRRUfWk+CGvwf7ndz26hcOWALDY2unb0kgVrcKJRASBDsIXq1SCu1L8iLeyYqSOHddshHRviLMadxFnCPuUBsGn2twH0GGTfDrhiTXt8Hacl0SvZJWWQxmhlVPhrPllFH00mGAfavYBxqQtYrJS4SxQuVYbJvzu94mICD5A8jZSZX582TF9fNzfy5dZsgaJhvlvqXf9t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS2bW7e+VMBcP1Dp8hbv+vP+1cdl4MqtUzMjychWZ/0=;
 b=g5k24n8GYKVeYxrpofAR6xI8nhwjBGtsbWnVF5ZTlIxb68PVKSMWzwqHDfD0xlHkeUzkyUpiwbuXn0ZJv06gwLY/xa3diH6P6VcqAgxydn7pY1QE0PKXODD+Lej1YMIHbzLNF98LhgOHpzpYDYC3NF98OJKT+RslXxLlY5jUCgCXxMTXKJTUX74N8YCd2S3utmJ/kghn1KdJSbJHQaXC3H4JP6d9ff9hjC77zFpYfUnPnLiZhgThv1sdtc//R4PT40Pvy4u/xc7qK9pmmZZthgAh5VbEq+NauyURLcG8VUITfkRn3+t027A2zGIypqBAYJ1os48RW6wmqMivEqUoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS2bW7e+VMBcP1Dp8hbv+vP+1cdl4MqtUzMjychWZ/0=;
 b=UKPLCc8BlNs+QC248RouEZcCKumAyerAnzLtndVI+9CNdyMhDwPdKqqjuXPstJSJ4rWm/DEToR5L9H04yrOLxSl5Jk229P6/jvFLVI0SguJT6mAbhDAQ5PDFilEUvvOsBXzqUCp9EmRh6HQzvmkihJNQB0WJWnmMxa9TMzr1DGY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4674.namprd10.prod.outlook.com
 (2603:10b6:303:9c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 11:10:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:10:54 +0000
Date: Mon, 18 Jul 2022 14:10:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-auth: Uninitialized variable in
 nvme_auth_transform_key()
Message-ID: <YtU/tS/E2W9m+aau@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtU/bFMYRCrx6tgp@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0162.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 938b8598-314f-4080-64f2-08da68ae2ea2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4674:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	TfPfeL5bGjIpGbrWS5XD77AkcAb1h4FkyVeErohnYDYxFdgLl5RFx+3JwOc9t89deaDRp2yc2EeJ6tEcCtw1RSsEks2i8jv/Fwplxxt3rJmL8LUAjoLLQyMuJTQCgwbnrYD554yXLPFU/sc+Jn6HfkTGHmiCFRBe6nDy3j4XQ/ESA1xHV0PyppGtW75BZRgen0RMUNDTW74a9DQt38deXs98kcP09mlHZ9LyjguxniQuhqJcv+WEjLYnuW5yaKhoyYms96EINSVRgKvCc19Pi79w9in/N9Rsfp6g1UVB5Bj6rZLCAepVPWz9ossZPaSYRz+DqdrxRLXCy0LqquI26VtxCBtWa4WnZnZ1UoxcrZjU/Qhc27wvNwtrvCDv33nuBbFdgaYpv76g2Pix0KiqVkDrFF7QvvIkrX9XLpdolpV1JU4F8Ccbr7UeypFzFI78AouK3J7A69k0OMOupdBOKCVlAMmGLrLx4i2OweHghC0JdxbR7xzL8T8U2Hs4ao+DM1OMDYnp0ow317tcdRE7b6vHbiEmbkEjO3f9/HpSU8gxg7CX6xhBoTSYCZPglCh50urtua1N6vYRk2wd/0ipvqrpvZW+pUNgJinI+qo/VRi/33VToYzmSTvlSJsKyV/5Rim5rVWSb4eHT/fY44pMm+kRhJx5oAhQ5vqc6Fjtz1mdOS5wXKtHr7B1fm0QfZvvLLDDuLu/ktAVIqVUlS2tpRGJofTFvXgeVb6Xj0NdORSXeTdI3XeQfRmFbkgG3h4t3/50qp5W+mJbwLueP7j7qTJmA2tjjwl2EQDt+SrWwxGRsIQvVnnWiSxFdhzYKizm
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(41300700001)(6512007)(26005)(9686003)(38100700002)(6506007)(6666004)(2906002)(52116002)(38350700002)(186003)(83380400001)(33716001)(6916009)(316002)(5660300002)(66476007)(8936002)(478600001)(66556008)(86362001)(4326008)(8676002)(66946007)(6486002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?ggkOunIjeqAidhq0YDajuc7+bkj2ZwZ2IJk6P+2HxFXxPQ/V+9DEyDqgoPCx?=
 =?us-ascii?Q?a8JpyIvp/OkNYQ9qvv1mio7FMpUNtC9nSHhxxVGK3gRfu5ROwLqxXBOhaOWV?=
 =?us-ascii?Q?rtzqwAJ8TnBBRkU3fuNuAZCBSpMIVRW3flchjBawTgo9PVc/1djLwY4QSwNH?=
 =?us-ascii?Q?tUKcWvzcwZcud75pDl9dxgAvT0GrO9YPSCY16GbQ5bC9cFoeuFDveCnid4Gu?=
 =?us-ascii?Q?38h6jmaQURZib7d4UHYx3+Mwxgnr+SyEfRfJGj9VbFSiFmHIyIel6mpWcnvr?=
 =?us-ascii?Q?DWJbhn4U1WyBvsW80BuCTuRQZxchKVKv7tS9qTmlq6Qqx4cQEElOm6W82THt?=
 =?us-ascii?Q?ziYcVPs9ZkdgB51M5kIxxzaj53o9s1W20zgTNHwkV01io8056ghy+v1ZSrRc?=
 =?us-ascii?Q?nUX/QR2DskWuy7B3bBzjel6SIZFECpS2EZiQivvMN3hFIT3eYUu7YlJlUdbg?=
 =?us-ascii?Q?cACAKph2fhoocmGn/ts96cwTgFLf3GXRzWqxceOmXuqJ25+aiU0y/ZXNRszf?=
 =?us-ascii?Q?NdZDR5c/fa9BiFX8dWtP+EtH+5/rQ/aBLbDxBlQ+peRaKbiYvvlYgrM5RkwF?=
 =?us-ascii?Q?XDS8cIxSQY71OvkBpQaHJiOZOSsgifOmNteoH0TE1ovBK+WsVAXUrZvMsUdi?=
 =?us-ascii?Q?p3A8dYvcMARmmjN81nGscF5mIZS0mV/CxCOIdw06VsYs+eEgerPdrfoqLDLN?=
 =?us-ascii?Q?OR+gHcRs3c3uo0BLCNfDwwLlm63/vCTfWzxv2WWAsUm4qNnKNmrHHazjn91J?=
 =?us-ascii?Q?vl+NpPYS2EtHDj3DWCDd7mgT5kYgol07Itv15fxNKxV977fSd3/WO7OOyyOG?=
 =?us-ascii?Q?KupGaZ5r5nQt0fjamDDx81IjKRf8DRihmFlHaLewOD4YM7isZlr5Wfg7vpRl?=
 =?us-ascii?Q?1Sy3Cl/z9sxd24K8SPOhHCxbB81mSWbymUlf0IEqcwevPa0Sc/yIGfyi4ydZ?=
 =?us-ascii?Q?hLM/xAXwHMFxa7cuveY4OgfpAqbu3ngHv/x9oM0LMlNlnreqKx468LuqOYFU?=
 =?us-ascii?Q?OLHR22XorL5t6VeeELbVcUmdK8MiH8r2frsJV5RxMsTbcLeHI6MjeAcDn0KX?=
 =?us-ascii?Q?Eh4R/XHW/XU33TcCClMuIHlA3dMSMMOViBffsGt/HMcOF00lnVgYwp81lZBN?=
 =?us-ascii?Q?I0UPcyBLrXY8H/z+d4/uN5mcO3h7EeGQ9gbrWdQPs8CZ3m/umi583W7X/mIp?=
 =?us-ascii?Q?1HDpdrISw9t1GbLraYvtbL1TaFUEQLpCdD7CgSqQCu+zgSjSbRIvYHrsueN6?=
 =?us-ascii?Q?+HzP5iOhoQiOs421cL/eZ/uQPtczHw2aeCX0M+Aygu5x21OoGR37M6k9Msjk?=
 =?us-ascii?Q?M8tzs+ekHbSB1dOtrrgOwWUwrbAqKuxmccKjSeNw+0Qgiq69b25zTGeA78Ht?=
 =?us-ascii?Q?F/Zjc4TawYY6zUpNjVJgcDL6LGENptwTRr74qBUEwPOhAMaMYrWSe6oOAKss?=
 =?us-ascii?Q?+xMX1DAJlRKryjVXS2kr1Ohx2arNvu2I4xiH6a8QXG3FzkUCJKhULV6KKM2V?=
 =?us-ascii?Q?L1peCuih0dwpJyo/wF2pJifiTeelasIClF3FEWlxZcbPFZzqcDoMxECKq1V9?=
 =?us-ascii?Q?gX46qQBUQNU7+I5eBocoaniHAlusZ1ftQ0nBykPhpqwKbCCOAl4e+949k9I1?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938b8598-314f-4080-64f2-08da68ae2ea2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:10:54.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k7yxMIpibu17zlwqN+GgHpzh+YLJwlXvvQCyZGSLSGaPb6MHnb+5C3EKqZL2PhJE4hEsZVzF5xbDehgkPlDmTvqP0V1utdVCoUitf2Nj2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180048
X-Proofpoint-GUID: igftHXbMXlHoj1RlzzTll0-eIdbkmie8
X-Proofpoint-ORIG-GUID: igftHXbMXlHoj1RlzzTll0-eIdbkmie8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_041100_895747_EBC8B664 
X-CRM114-Status: GOOD (  16.05  )
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

A couple of the early error gotos call kfree_sensitive(transformed_key);
before "transformed_key" has been initialized.

Fixes: a476416bb57b ("nvme: implement In-Band authentication")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I wrote this several times in different ways, and kept on doing it
wrong so in the end I wrote it this way.  It's a bigger diff, but I
think it's the clearest way to write it.

 drivers/nvme/common/auth.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index bfb16fec0aed..1890193c7333 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -278,26 +278,33 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	shash->tfm = key_tfm;
 	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_key;
 	ret = crypto_shash_init(shash);
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_key;
 	ret = crypto_shash_update(shash, nqn, strlen(nqn));
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_key;
 	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_key;
 	ret = crypto_shash_final(shash, transformed_key);
+	if (ret < 0)
+		goto out_free_transformed_key;
+
+	kfree(shash);
+	crypto_free_shash(key_tfm);
+
+	return transformed_key;
+
+out_free_transformed_key:
+	kfree_sensitive(transformed_key);
 out_free_shash:
 	kfree(shash);
 out_free_key:
 	crypto_free_shash(key_tfm);
-	if (ret < 0) {
-		kfree_sensitive(transformed_key);
-		return ERR_PTR(ret);
-	}
-	return transformed_key;
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
-- 
2.35.1


