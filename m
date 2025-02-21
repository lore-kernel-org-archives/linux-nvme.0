Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5AEC021AA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PvxBRTTA9mZIgTD7KFLWMcDQe/foBZACWO8vpTvo5h8=; b=YIoTfzZ0lg8Szjx910MtBQsWbm
	6eBLWE4xhoRCMQ6rPWEipRjsIoNSymE6A/vf+CeVI8CtRVDi1Tp8ihVEibMA71ekQxlUhBxt4nA6Y
	zS6Vvdt4yny/jWFHJ5HqnLVjvjlVgOXHm5dqZspfsnae84m8+7JJwVUAIL/AHd+Da6mOzYV4bE+PN
	vs5qeEcMMpU+QgQEdkam7t9EJabzWe4Ekuc2sqaGv+Q9V5H5yqliHWTDpzRl0rJmBSTwt0NYlh8JP
	P/a7TlK6/LLa1ZDwrB1mPuE/U2W7yVu4RK9zelrB+cBXOTec+raO8wnbSg8IPEHV9uk3HT+Oi3k2m
	qZGD0ylQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlPwl-000000054nZ-1s1n;
	Fri, 21 Feb 2025 10:07:51 +0000
Received: from mail-bn8nam04on20626.outbound.protection.outlook.com ([2a01:111:f403:2408::626] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlPiT-000000051hL-3y0w
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 09:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtFJE1rHlFtl1h1/r03DER6zz/60w5IEYSkDDNfaSMWcTGctd6YxN5W5uJGFpebssUBDogf1hzSqurD1RXczydqFKr8sRuu5CDiVWasEY2jfgMWlWnkwIdMw5Xbu98ql4UsmUBJeux4Yu0X5ZmtAma+XtOXbaFYWjAUJqjkiGeRTujgw3nXCDwf2KO7ORiu5CKQB0oncIbGTd9NvCz3DXkAfaKzHtDYbRgFhPmj/Gj4cfREic+5ISrMZjPt5ANaJs6u6xSH6egpthSN/a6KGCqWM+vDieM9TNOM32EvuzyARI5zNuSgfGUC8BjPeKelGXE79JW23cwPGmw6HpZ7jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvxBRTTA9mZIgTD7KFLWMcDQe/foBZACWO8vpTvo5h8=;
 b=Ra8ejpjXpr+7qUI7RdavxCZWwbpHnEprIINKdZsoUlxyKdYLfDNoeSzQO5iI/0qkBHnmOFelAr7SrA2bKZ1U3dS3/LsxedpwR8DHU/ILcbrackFYXo0px6GsnJhLS8mWwRPt43S64sP8LUvNzY0epzBEyADYkZGAjudyZBU7UTA0u9Hi/mJ03DxXuSPEni6uruiciDkUFT7d2gwSr6gBk7ukbrD1EOZfenz5+Ny96jMqGqZ8ySIT10jc//SkKEJP8q0eRLcMRMAYOIQIRYfAdGB+87FOoHwCN0K0DezBqZ8esasY570Zu0WMPb17vFWgM42TL+ReHIPEE6zBQoKSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvxBRTTA9mZIgTD7KFLWMcDQe/foBZACWO8vpTvo5h8=;
 b=tvFW9xX/06wKojA6ActerLD93+XJf7rC4mmrT0sLLlWBnQbCiWNJwTTp0aMIEcuUdTOC2dyETDb7Iq3hnNY5Tz4KjHQgpzuyGEjHIBQwF+i/LPqSHErlqhBci2WqX0+aIMhMwDxasWOiZ74tK76yVhKOk8i+wXzURhVfhEA8hv8OY6qfIVZgBoMk7pCgC8NsIZhIDpVvISk8PhgPldKQtDCAOjUwvELuY5fxC9iTwwENoseglAf9KwOjQraiTeFyxaYg7Gsad1xZDt91pBFV03P5kE+RFJVkZG919SOFE6xW8Hd1ll0K907kNxXP9exeD25DVrIJE0PEJWZbKWShCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:01 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:00 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v26 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Fri, 21 Feb 2025 09:52:08 +0000
Message-Id: <20250221095225.2159-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7262ba3b-e722-4c7a-58af-08dd525d86e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pEDw+S6KdNGtYLDf52oM+7kBbt7vZVwt/nmr1ZzX95zmTwZKSA4/TFJHhMGn?=
 =?us-ascii?Q?R/bygLe2YFR97O/Fk2WZcf7XvJ3o1pHwiymJ064+NMTsu3IoBzM1AHupfdtf?=
 =?us-ascii?Q?nh2p50jyg4B0rRwtUmkXVVW8h+2md8j4PHo/VcRItXldmGYsSBm9LQt4PP3Z?=
 =?us-ascii?Q?4kNMQ8XB3o4oXlY/UxPhfAbGe3STeolBM2F4z6unY/E7CiYLkLjGivVUK7G3?=
 =?us-ascii?Q?ZbOFnp5TzBknYnaMkYWV8C/6p+4JyOqEbzM2v/3JOSc9nSzxG37OhP7I9+W0?=
 =?us-ascii?Q?kMdJ6LmGQYzRQa880licTjHqBjVe79g/Z9Hg8aUeSwJ8OOReztt9cG7qRHYk?=
 =?us-ascii?Q?41QJsEKpP/CKi0kNWsvo+gJyZUEZ0EWX4NCJkpZauLb7Pb9WCSTYJ+AZV3VH?=
 =?us-ascii?Q?8faZImM+FqmoODJgobnhXqKvExgxzWjctg9JMimTNs8H/pwf8KV3tmzE4nNH?=
 =?us-ascii?Q?H3nEncX2JMzIQa2ewFk/ih4zce+aPyp98mUaj9RGqPMlm9NjGYILMdqd00oW?=
 =?us-ascii?Q?MuaEs2KcMd9CMPCgzvf8iKAByc0G1/x/7HSbPOSOfCsrYyM0ObBiijSkA+aR?=
 =?us-ascii?Q?O7BRRHxQapYoR+GKCnr49CXPaxrWazIlChHtKdcMAqQwDfF0eHgKiEqy9Nxh?=
 =?us-ascii?Q?G8ku+8nIGSEFSW1/csekGTlLSQ5Jl2Wy4tcTzty85jW77Lie0CBtg6S4hUJR?=
 =?us-ascii?Q?0GSGH/3v6oMm/zT1aHcRNueq4N3KVzWXciP4WcBP1eR4UrzXTxvUqf1WJ5cS?=
 =?us-ascii?Q?c+UvU/hzN2RBqWNQGgqWblT9WO0Io0yWNTSgOZbRute0tr+7E+OK4WHpWB2u?=
 =?us-ascii?Q?6A2IBoCtYhW5gem9YAU+dwVoqLRkbMKxjSL4SMoGzBbu6f8pq9L/IJc6xtk2?=
 =?us-ascii?Q?X2j2T1HLKVhfabgev2Nwq0RS26RrWu7oIQ+1bxu/Zf1D6ge6xBExV+DTlTSd?=
 =?us-ascii?Q?1lEr5e6AdWs/28jUe7nSWm2J2q2rRcDUpR6TiSrBa01QSsJCVuKE1wSbMcKP?=
 =?us-ascii?Q?RvfoQ6+umBlXvONkpd5EMgytUN1Rt6L8DW1BqWeDL2mv8PwbwItzZLxD5y3s?=
 =?us-ascii?Q?j7JxBugpQF3wa0V6xCkesb2H3P10lojDPA961HdXq10aFUCW3mOU3ojLX9qU?=
 =?us-ascii?Q?HX24Z87MtTt3rbR1miiSUhrV6YNYeKK/37dumergxHvBwMeAW+zbHYfKVeEp?=
 =?us-ascii?Q?P5hIiQFpl4lCd7xRei5BzO6D+kpz1KUxZMrxy9wMp18JPUH4KkegJ5j+EKzv?=
 =?us-ascii?Q?1A7E+bAMljvITnBUVMJsghefZ2nHIIGi31e8wX96hLHHcgx+HAj3d23NY/T5?=
 =?us-ascii?Q?Mij8rMfqDs0b5f93JKlAmC9J3HlPK9QRhpS3gGD3baTCTxafbxM/b2N8i7K2?=
 =?us-ascii?Q?meah/njNYm7VLhFPSFyR7ZJomQIH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JgLFwZPNqcRBw1Y666iJiHCaSOA7T1ZhjJmVx2i5Ucv/cGFe9Z2tlkMexJo9?=
 =?us-ascii?Q?qFynBdcxKqO8XPWHPdRf2O+E1LDWapHj7COeiaH+kCfPyPfUID7KB1KrzhRZ?=
 =?us-ascii?Q?OpOfWi1Yuzb2i1VJXS3fPGAJdAh04ZpEqlvUgXWzIs8DpFUvj0KGemVFlnAd?=
 =?us-ascii?Q?iMreZ3AXALb+JNbx/v1N3MGBeYkASGjACRJpLiMThWtyqpy67JVqDNWaRyz+?=
 =?us-ascii?Q?g20sYjHd4lHFrtLWkUNEv/TOYjJvbRODVZiFVeokdqcrDajfVXSIkVtDBkFY?=
 =?us-ascii?Q?CqlYWtPgVD4P3ctVyeGQ19e56E0UeOF11MXaT5Pr5yhaKIM/FqPYuge7KtWK?=
 =?us-ascii?Q?GAWVPSoDxdi6v4Z16GRoS9jgPLQ2XeCBHeJX5s8wFYWb+L1SpIERilnPf5u1?=
 =?us-ascii?Q?+stJRXK314MZkJZ5G/QiOwUPoF41AEmmVQhdfZmEIcbUGpl6YXVnJZNt/ub9?=
 =?us-ascii?Q?G02TSouh3CJ0E/iX02dS574mx+y5ryiqlzW96yDkoc3k8bCT0OKJW3ac6mNH?=
 =?us-ascii?Q?RH1GpslAHEG2tqaaTscWHZYvzBMjKRYEWj/YRQMYOIHYPeb1JZgQH0+/4hKo?=
 =?us-ascii?Q?C3nI3BWBJBponxVWBKezd7+VP7Tk3m3eRaTLRzMdBKBfxY5tcUDQDHDWr5th?=
 =?us-ascii?Q?iJTU4+Y4r8qsj7kyvkoIiC/ZjZ5HeZEurSHCT20BQl0SujeJpvkVWjFjxj3m?=
 =?us-ascii?Q?PsQf83bS4yBmmLp1OOeEYTixlvBahSxgYR9SYX4duIDl9Qp30/PJGlKxpHs5?=
 =?us-ascii?Q?MuTmtaX6xuvdA7+fObpLdB4s9LjX3wNG+mPNN/l1E4KoQ7uCUVECtWA6YtWE?=
 =?us-ascii?Q?1QqHkRccA3+jkAODZtLXPqUY/R0zLzEYTlSMS2ghglPUUlf4UhdCXC7+Xsxw?=
 =?us-ascii?Q?kHA7XHBpvpOdhAb66lunHser+OhFXTuxXJ2k8UZN/LXQgisypt+h1AOcbiQ7?=
 =?us-ascii?Q?Y1nnHVHMtF/hoUkblIIT6Zbyws+g5oKilZeXr44upWpdwLXU4L24CWZ/elC5?=
 =?us-ascii?Q?ZLduQ8lDrURhvNkRUppVI+jlt/9DFi0HABF6FNr05+CnSY1s1liNFa5eQAuD?=
 =?us-ascii?Q?5ZUaZsGKTLweIo2JTF5eCPpprpPBxZ5/yc54i8UV+oY2W3+d8+nCC07M9oBs?=
 =?us-ascii?Q?b+iFD+DWcV8U8eB1stXWMUC9N3Iq9W9u3+iWPueSLmxhYKdGnSxbCCYd9FGO?=
 =?us-ascii?Q?M92HEPrVtXsImPr7Lb1u+WK1ymp0YQd/4afRrvGtr89YSzVhATvuYLq1oPjb?=
 =?us-ascii?Q?aVw13+1TW49IIf3XHSwRgUVhYMeH8b/vSPocAhnLtamms6xi0F9cOvxrHxTz?=
 =?us-ascii?Q?7C9+Bfw2DPD6kUPf6LL+OMHAiyXJDbJMvF8B2orlsS6reXLkON0rhXI3H1Mv?=
 =?us-ascii?Q?W72PtjlgX0RWb8aHjbog1D6OeQI6bURT4rK1UzH47vHKdDXjkWRKKJl+AlIA?=
 =?us-ascii?Q?BWp7HmNY0W0Ta+wX3sbcZm/+Kuo9xOvFz18fQ1mLXHsUYAq4aLsr9VJFh8Dz?=
 =?us-ascii?Q?6vX3XUV+OAvgKH/8F52lE8Er6jyyqc/dv7o1Gkx6Dml2zdA24gdN2uXfY+US?=
 =?us-ascii?Q?mvKrGm9VF4WvYh0sL171LoOmd1iY4A5dQSsF9dF8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7262ba3b-e722-4c7a-58af-08dd525d86e1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:00.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riZMgCDOQzwBITURaCvXtesASHBgPVgxTQFoMBHapn1665JvcY5bJUgdRhPuB5MVobmJmJaYUvtjndy1pg88LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_015305_990249_180D0BC0 
X-CRM114-Status: GOOD (  10.36  )
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
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9ec806f989f2..4474ac512d6a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


