Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E57C282D0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mB4ZqVADYwmoooI46OVXo5ISIlo6f2T7ljtMKnXChpk=; b=GAS0eY8Ue3HRrZVrVilrB8fpJn
	nYki0XyGcIS7pYjQvFph9qUJAGUdct1SmarYycGp0h4xPgK/5xY5NRMFf/2Rvzt4aWk4H8BWpS45I
	HxeBrGHcnhmRMZN3A1KQNhcE3haDpof6WwCsRLdWztJRATMcpDHFaeLf2Oq/KCwkNadutb5rR1B/8
	kA2tZ6AhnkKNhnLVyoOoi+GBw3X2168xPlJWyVqFX17uw/JafT8TXEIfWFqA+MayBVi5sLgYj9c5x
	NIUra/N/Zfn5CZ7FzNfod73Fy75tOo+NAI+0NIUQ2keqIm243O4YNbfwbtolmS16MOSY/gAr5DyGY
	4KWtGeYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp2VA-00000000DIX-2J0y;
	Mon, 03 Mar 2025 09:54:20 +0000
Received: from mail-dm6nam10on2062d.outbound.protection.outlook.com ([2a01:111:f403:2413::62d] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp2US-00000000D6W-0mCa
	for linux-nvme@lists.infradead.org;
	Mon, 03 Mar 2025 09:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR+l8Rdy200Skh34ELTKkZzBXrrpg7IUfa6UCEn5kegDHaNKYZ4ct+xmmBg8ys/wfJSZk3TDbTqfJ0XWXI8mAQntp8ErJiO8QAMfeGtTaosXfMsoRNzGSwVpZB2LgRO7eFnWOGj9gz6DI9l9swdY5cHNblYv++PmOKJ/UlgRwM2rLiKkmx2E+z2VQucz8vAvcfLZw1NcyrbKcwGPrPs+XmuIxdNmO9E8lB1SQIOWOoW0XSCaGMEx1rWPw0Bsup/VEWdDju5nfl9yACUre2qiJzmRWIgZfvcFcm/0JDyiK7gGFl6Su+aD2XIMK+7V4xCEy6GRJA0zXT8PFbnsd/ZHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB4ZqVADYwmoooI46OVXo5ISIlo6f2T7ljtMKnXChpk=;
 b=NkS4AGTOtjOpcbv1fNhuVk3snQIed1qpXZ9bWn0lZIqpHZS+SWFW+060l7UGamGODRRzhkNGT1RaKs3/SVrgU7VPASknaRaULokCnC2AbsxoCqYELeWdDK6CSZEtKKxY6k+rvFt0QN2rQwRQRVit3NULn5EM2em4m+PSHphw7ZXpIDRG4DzfrIotOJjjHIBNYEWXxevw7tnvWEqTOmIAZzd+V6JsWM2dDJmpAxJAXh/K4QiFsPe5XsaEABAgUK+eEgOuMZx4lgujmJGS3kxSxEYZ51UndxyaGD3BFN4H5YbUEjmrXuL9ZTGs0sXcWj7qOpBdwakWQtUWy8EW0Q23CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB4ZqVADYwmoooI46OVXo5ISIlo6f2T7ljtMKnXChpk=;
 b=keDWlX1PT/3Gaw0+VoyMygckICuynOh4dRjImOa19IMLHQeuFJFUe13N2cTMpE5bJmezNEQMcfHcZcXebqm5i6nczjX4eQZtInN7lUETrIMdyxI5riA7c59FlnK+ZMpUsnVmu43402XfpN33/hQmEjXXg8GtMQ5N8PmlsxMvRpcUZFacgl8PTJcF6PIMXdVI+8faPWWQG5I6BPLu8TVuXcDGVF84ymN72H4LuVjZ7xFMRzu67JcS6mTW9jkK6gPDn/6PC3qA8kDEOCTCKpEheknMza932dLkVD2DwG4MPqOcX2dHZS1Da6H0ZGeHmsjn6p/2LbBQYW05y0QeJiqrVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:31 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:31 +0000
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
	tariqt@nvidia.com,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Subject: [PATCH v27 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Mon,  3 Mar 2025 09:52:47 +0000
Message-Id: <20250303095304.1534-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: acbefb5c-737b-4f29-9940-08dd5a394171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NjmP2N+JMhSe0Zc1seNIUJobjHpmO8SwT2SsI69qF/0Cif2nTHtYgROB08ub?=
 =?us-ascii?Q?J9PODpodb6UKdHewOKgguFtJijhYMolqyYdsA8tLsJ6s+VZkfO60+5FcmCQn?=
 =?us-ascii?Q?fF71XoATQEGOwJ1zl8yMOzgNJefq+H9voJXW12fpgXzpaq3NSJqRUrgCw4oh?=
 =?us-ascii?Q?oqnlo34D6gpGt2bTp9waVwRsRhWviKVakqGSd/RLYzdTfHLRoUTa0Oi4NI9Q?=
 =?us-ascii?Q?ytaRCSNMP3KHnQSrw5qzWS14YWhjrGqbvJ3lkfMJeWMugRQWao50i7GSTgpj?=
 =?us-ascii?Q?m/bjymdkZ/CAzG4uGszEKOv0TDx5NPPJhGhLDeT1v7LmCBeU2OvSzg7fGX3u?=
 =?us-ascii?Q?iWt7aZhJ371Q3eLbVSmVMk7ui79kI7OJ2DCGWEeoCmjxxRYyeIY7w1hpePDk?=
 =?us-ascii?Q?J4UxhBblVydE0CVtg3X5PRviIpnhEdnYmgezlp0k1/McXjFaFl3ba6WR/aoq?=
 =?us-ascii?Q?ov+GNBssyZciDV6hI1SHQgqs28A+zoQLTTohdXk5DffEEiArlDbbCF4A9rSw?=
 =?us-ascii?Q?TxkImaz5BNK6oBUzeHjvSe8PvJg8jK829OY+RWnMfrk9i2nBCfp3B5XDj6nz?=
 =?us-ascii?Q?a4vDRT+lGGv+tzeGQLUcLu8KZKl10lM2IzUX+hBncxT7FANTToR0BM77hHoz?=
 =?us-ascii?Q?B2RYGw3FS9El1tP6HZKBIYPGy3KNNg1hk42tIwnhl/XhwmDLBXicyMl0+I0k?=
 =?us-ascii?Q?AIooqtl+0diYhE/H/zMehiuMlOs/oqDuTRzcHHzvlQVOwDnKFQ5YfNLasR5i?=
 =?us-ascii?Q?xuwLuM54/7ebCwVlLj3w9tjZNX6+lV1tj4FH1Qn09GOd1l7Hm+iElkHQxE+k?=
 =?us-ascii?Q?/cvJG/D0SvqrzsNbHVKqHnp3LTm0fCNALyrY+uecbAC20J8BLmJOffnVIAg2?=
 =?us-ascii?Q?EC38K2Ve8nzrCpKIDXuLlDf1VD5No0VUlTM8+U6U4zwltnvx/U6hN+sMvnMG?=
 =?us-ascii?Q?ZtjSArgvhuUg1tQkfPea6hgozwKhABehVhYyGLoKamxkujlwfMRo1rPnFlI0?=
 =?us-ascii?Q?dkL74VWdOsSbep82Rwgh2NHwtjJ0MXg8u2uXjn33BcDmPV8k7XhzF5xcO3XW?=
 =?us-ascii?Q?iKavS9pdu0Fc7nMbNpwHbFByStpNuokGS4yd8OkSgAUdDmfYtzFOdS+3w0Zw?=
 =?us-ascii?Q?1tuwgR/bHUgNn6KZQ3jgLkXCCp1dFC0dtw5pQgsn8zQ6WxU+sbFkjDwQzJ/E?=
 =?us-ascii?Q?MWZVN1GNF2FRQXaihzml5qCg5pEghYEi5jyi4E7ZoRZOVbO6HLzOVoKzOnll?=
 =?us-ascii?Q?Aw/R40T73YHUrqMgwvBTxWRpzFupIiUNFDv1xUAsKahLF4dR291UOP14HDtL?=
 =?us-ascii?Q?bl3kZU6VPqKf7YFJ+HxFnB3Gqj1AqEuBON6/YIiBeh89OQ7GxwaCfY44p9Yp?=
 =?us-ascii?Q?zbAqa1pxA/Rb8tCZEZAuOU9sKbbu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKmZ4VXiAAzlspGp2UjElydF4CstPos/gvysKYweQQL6J2C4jpxo+5HA/qi9?=
 =?us-ascii?Q?2vraV/W2Oa7306OOuLYmGbR6/H8RMbfSlDWsYrYCybG5wKqIBYdCZXmPhS+F?=
 =?us-ascii?Q?G2qH3xwpUwrvdiWES6PYE+lVV9BxQduDHlroVXFaAQ8Ju5ZcGlnk+dFjP2wR?=
 =?us-ascii?Q?DBHYPpu3NDYO6xNiR9jtlqFD2K8DaLX9emHDgYKlSYZW7mh8LSbRGiDu7e3L?=
 =?us-ascii?Q?mtNR0IvvYJCzXP82w+LzyRzvuiLpaLdyZ2dzp5AVyQTQIOluiODxlurHl82b?=
 =?us-ascii?Q?Gew57R4okmGZ/grv6VJINrhspXIq2IYg8unpK1S+Wto+aMuEiym4o/8NetAg?=
 =?us-ascii?Q?qY8Ip0bLf8JxDXkhXA25C+keDd27nhCkLvaGfODlTTOGxY6gmDbAHD7xri6z?=
 =?us-ascii?Q?vUO74hutkpOUHJNRf9Jt4Zpa7AS3OVnt4f8g4lF4C2L9egqI6hi/0Vr10YbP?=
 =?us-ascii?Q?EHlyfTenW8R760s/odLQnLT55czDQIpP3drV2RRY+rCPcgywUxl5mHNW76Wi?=
 =?us-ascii?Q?7NsHGAVF53f5/j3/cdr1ped3gl6zn52pOKb5ZpmyR8t6gVpASrYGA8R2W7rI?=
 =?us-ascii?Q?BSXw3MbsoG9Zn86Jk2tn0weewbGVw2tBKDa5VeDGR0R32v2tcm7yYFUaRslu?=
 =?us-ascii?Q?19jgTqv82ss6QWIW9PB+svZNiUshbYWL2gwTBk6rZWE+vjZ5FGisq36Ezx6/?=
 =?us-ascii?Q?Wc4YCbI1hl86TgIhs7x6unuwWILD1xiaqo5ytkuGDKaA7QOOhSSmKlLyL13r?=
 =?us-ascii?Q?yV6UTwm9Kpv7Ee3DSwX1O1SnCUKi5AtM72cOLWv0Z9G1Z+IA3/LZrQ0Ye2hr?=
 =?us-ascii?Q?MHXW8QsbQ5ngqJ1GGKzY64y1POFldGpUCER2QUTJEPO8yGa6t4I98A03RW+8?=
 =?us-ascii?Q?l/e/w1Y48EUkcSgjBtVKQuFbr1XArgLs65TcbRs7rlHacQPA/zzepP8fb7NK?=
 =?us-ascii?Q?JHE+/NrXNvsG88q7/58v2x6h+tPlQ97iDML+IOCF4Fi0TxU2r4k03d5PoPNA?=
 =?us-ascii?Q?FEwViibxRtTcDQ5P0i79Hjy5ZOsdu4bd5cRksMx2xIa0ckCMOYOa38svaPC2?=
 =?us-ascii?Q?kIUob6nu8PxpsCgp9rhxAao6GwmOhrZ/noDKVQv6IQkFBJWx06zY0OQ2FIJ0?=
 =?us-ascii?Q?eBKDYkbjb1wmwX4Dn+LnibqDz5WKvB/uvgzawVo+v+xniOrcYPDrMo/EogMU?=
 =?us-ascii?Q?n6TzYHcz/EL7X5djnYCKRiM6unAaTlxRrXl/jUNbZNK/jP2prrs3ZysV/gz0?=
 =?us-ascii?Q?V/Cw/SWhy9NU7BJr6/Uo7xa5bLJO0dtnAYOdMuLnzQbgdSWiyusvAXUkDp9K?=
 =?us-ascii?Q?5rGuD5qOFO0s7EXRvUmIZtqjMX3ydM93rwmPmQ7a/4M3y97NfVNUaKdBTjRU?=
 =?us-ascii?Q?AV4qsSkiISapajuU6mzumjAL4P9cmoqO/HJNpZyLdsCOyKBIF5SiTgnTvoKW?=
 =?us-ascii?Q?RfijgZ9G76xm2mK17qCwt7qktc1iaXHAk4VBt1tTTHQS+xaIhHe8rSmsmLNh?=
 =?us-ascii?Q?D8puMjCwLqcC8NigyA+R5zeznswulADfVBEzj3ATii0rgTlVBVOGKWgwcAIP?=
 =?us-ascii?Q?phgeY7VuE1t9vrvJKCcL3ZR7hH9PrOfOPP7h1jtT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbefb5c-737b-4f29-9940-08dd5a394171
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:31.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj89Y91cRo36PRkOZFbyDTq6sGVVLQK6U4KSUvSBtOXrMscHu1+o1Y1n9D8awLj5pIzLbyeKoBEstvXpjWdDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_015336_229421_3C4E6A7C 
X-CRM114-Status: GOOD (  10.74  )
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
index 65f550cb5081..94caddc02515 100644
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


