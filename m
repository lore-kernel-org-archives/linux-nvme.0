Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7601FE7717B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEkjaBFN6bFN0SYaBG9boKuGJbuRL2X5cdHeCjirrSc=; b=ffrgAwhk4ROHW79Pz+uWg1+VH6
	wDtEKMOiYLnzgCvJUVVo8aIUGOUcXQ7dn74WyZo1fsnW2sZMX9SZXejd2MmFoxdvJyGaCVCfeCq/l
	fXkSNTEYTahplv66mcDjeWsDyv0Zp06Dnnbj54KMXb6lxR4azU3aNcpZf8vuCQFN53THRrHesvrUW
	3If76WC4C0EokRJkMihYE810Vcju6ZIEdaNvDLdDetXI4ZkbIoGID6eOmgrCaHFlhPHXz/p67805g
	RooRp2OcxIf6LezYbeKjHCaRdRL1rre38wFC/8HpcHvxs/b04Xla7BY+rzPmHlQ/X0+5yJgwP/GNv
	Kp+z0gtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJYks-00000001lvA-36rE;
	Fri, 06 Dec 2024 13:52:26 +0000
Received: from mail-bn1nam02on20626.outbound.protection.outlook.com ([2a01:111:f403:2407::626] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJYkP-00000001llO-1xjV
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 13:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMitzZAj/KAIvtkp8Oz614E1IRdWYN+cyy+p7F1c1cnFlm2Xz7YL+c/2UegJkERv9hAkHlytBWBfsneLwxi1s8/v3Is0zVGhwUAn0h9i7pT+eVsFT4Xn2DIig8UuG57xktXKoco50NfiXYeVkKJqOsLszphbeufcLiWiWFWYNW3wgF6VVu3pMk5UxXOBxjjyKGQy0nOIV1KCww91E3UWe5UD4GLRqymM0xOajZb8c5/OmEzTDN+z4i5ze3sWV/cql1FvQNzrH8SOxBygUpZmgPlQB/wf23x50rYkhDkNL+lK4A+zqzSX22pDTURStpWRdvaAadX2RXuVvZwTPsFCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEkjaBFN6bFN0SYaBG9boKuGJbuRL2X5cdHeCjirrSc=;
 b=s7TXV5dd/hg4pz2OWJK9ZtkalSFlYORCFhHVVvV8ZyE3pogM9ZNnAIKXISWpyfOgi/fS4Z3kdGrDl8ODvdE7rPaCWD7GakQC3KUvNXgkwnW81azr1v8xT4dzRROP6f0txOiDmZcpjbSw+4QDS+jEbeEGIoZztjzmziuBBz+wPpBgIcm1K7UYJaqevrrjM8ZeI8SJv02Ma3G9MkZxHVubXKmucHavMek4ncZ9l22xQM/QzXQGcX88ZDp2I6gf1UU2QdhKeWPT8Vt/NApK4bIu5BxJ0ynUvijP1kb+8t3gTP+vgsFxqEyCOlNaHHsbSfyC/np9qBi1hMJvqheSwA10jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEkjaBFN6bFN0SYaBG9boKuGJbuRL2X5cdHeCjirrSc=;
 b=dTSoDrn93x/zRyNyS2IZSEJ6M0LbjwtcN2HitoBP7kzKX/IqqLJn5DXQ0iaY43/hqNoB9E3p+jrRgyonUbEMNclXn+fRkoQXkTsxrcQb2i2KRXLrFiAAzCCFezK3RCwdZyi64oio2B2J77QjH51NHjY6aO32Q2Qw6peTKBFVfpBEy8pQ+jNQX5Wm7NsHgBEgFTDrP1IRA87IYaAJw1l4q+68MDzXbbxZA8fNnScHpLbAbkm4xw42lNMbnsaTV5bJkiJH48R31GW6Rpf8T+N/MPAT0PYIKtg/c/uye6U262C3joTK2Lhywu+qKjoAU7CXL6ytJDt7h4ItUnpOEtjzew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 6 Dec
 2024 13:51:51 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:51:51 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 3/5] nvme/030: only run against kernel soft target
Date: Fri,  6 Dec 2024 15:51:18 +0200
Message-Id: <20241206135120.5141-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206135120.5141-1-aaptel@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0c2c9f-338a-4a83-469f-08dd15fd22e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZXTpLsa+xoklWVym8GCdsx9R9ZnBuswKjsieDydCJnH/o17WQE5Gz5iYqMGV?=
 =?us-ascii?Q?Fkmsf/TIu0ZD9D896FTwKZ239xtQ4/YOp2nhwHba0ZLCk8d17h3eGPNv8UPX?=
 =?us-ascii?Q?OHjRZoRvFv5mvrKpv5VbmS2EeiegGlJe8MyFpwfho9wZX1siTvvNCDv/LtTe?=
 =?us-ascii?Q?4zhaEBl6F0PvBVjTwGC0yW3Hpx7fmzE0zJacq1yBSTs8bVWS3VWR6kBDiRu7?=
 =?us-ascii?Q?rDr2jtxAeqx3Ql1JqwfqBQ5lQNBhaLWUBPc2Mh2tCMP32GYIhFYoQrcurSsi?=
 =?us-ascii?Q?EQqiNgDlTNlyr1nQSvteX5cdZHE0CA6ya1XVGcGGlOIjWJgILdNF7e1evYEW?=
 =?us-ascii?Q?FF65a1jT2uGu5P9/s1Vt+ZdM/Rl8qdMTS7/3jFRmeqn2sax6Oiyvh1el4yB5?=
 =?us-ascii?Q?leCghWEelgcjUlJA0J90AAsrBwA9KJBMZn6nv4+Wpvimc9pofo/+4BUgga7X?=
 =?us-ascii?Q?dMmHtiQngKnLQeHiQV0AR2KUx3Mdr0auhv9SepaUZ8O1uI9onfBnNC4VJK3H?=
 =?us-ascii?Q?kGCsw7E24NO/8SRjiGzMH4BiEt0HigBuveuh6MNc8PEh0YNH/2xa2JVDRRGo?=
 =?us-ascii?Q?FRiIHe6BTAQNKvIO7q22iBUXrKaD+UT7SBqW41l6A5JPMHQvVQ35vgCLeRO2?=
 =?us-ascii?Q?8CVBm+Ljoo2vBqYqG/j6k9yIHik98QM1EIolO0i7J1LITwpqXQCfnSbcVboH?=
 =?us-ascii?Q?cQ4LGjd6oqMUraxNcK8exiJEuPgnChvi/V2VMQWf0crU/B9quuXmlrqymxiV?=
 =?us-ascii?Q?9ISivLsci7Ga7Plw4XZIy0Bggopx7m0yfB+q8E76Unrye2xVBlsybp/Oaf5g?=
 =?us-ascii?Q?zUC3tRloAgLt0E6I+ozCWB2LDNjWswooJUIEibjKQzalxS0pOoZFQFat/Bml?=
 =?us-ascii?Q?hew5jPemngb/JioufB8ykrGnIcm5uYiS/54sq/WUisF/IF1Qj8BzVGs/d83d?=
 =?us-ascii?Q?krJPc5aQFObr/bx7d7o0yVC7PHwm/sgi3/DHBTuwMMLNKNR0Qv1Yk4w9eYt7?=
 =?us-ascii?Q?aO48ovPRslU0UCT4s9ftuhsIOOqGLUjSWn1rA1V4iLH3u7piL1JOunr0kdJe?=
 =?us-ascii?Q?FY5/lsU99AmWxxdiK+QPPnqxrrJP84EyNTxNlG6LO/7/nERENrXIxvPCC9Vm?=
 =?us-ascii?Q?Z+YzUZG21J2hQpjqOUSMj7OwfUyvhsuh+DqnIYTt5Uy1IATW1lRf+FcLZKZC?=
 =?us-ascii?Q?ZE1v3YQtNuY5eHVCm0sMS89JfSpzaqX1ufY+g1eieJ9hrfn4Ifq+wr6wdKlE?=
 =?us-ascii?Q?DA5YRxgTwj8MfSntN4Wsybc8gYODDa3uxsrMdlR36xXn+i41q+DDPtr3Z86z?=
 =?us-ascii?Q?z0SYF5LyyzglTzG18dV5taDC5keBK7iazg61T0A/gbXBfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaAGNAmMZrCEKyrKkcaCGZ72RBxrrLoL0b8bA4MLzo9X/92lzrn49OyTIC8+?=
 =?us-ascii?Q?flpKzoXVAvlod3zbVGyXms4ma4fxwGpE9vv0Z6JscHyEc2N3fgEZPMnxJmOM?=
 =?us-ascii?Q?xoZxOGgXZHzb5X7ntPqXy5PcHHFKXQo8OZg4N/H2eLaiuR94xO9tBo/RpO/T?=
 =?us-ascii?Q?TVsk8+/+izI/p5I32huFQ0w9nfa5KZ19u2Dj+QP5BQeSnLsm6exA6R1FI1Wr?=
 =?us-ascii?Q?3x675SaSgshAmfULSm/HIlyduuaCl132wvy2qnM0oFJV430QawfRlc8Yen1j?=
 =?us-ascii?Q?gS6dwCqCG6TE/7MyLlH845zdV1TvhIx8jBPiI+m00++kTbubRKbdIHbbYych?=
 =?us-ascii?Q?ND0xbjyvZTj0y8+BFZjYQS9qZuw+6SzS9Ef2OfZ23QkSKXyQVLJ22RjnwqRB?=
 =?us-ascii?Q?rd/s1o0EA/wR6MaEONENCz/nAnYvNO+ELG8wvX9/OPrFPP/onpnTryUGbTrU?=
 =?us-ascii?Q?kGabVhaARTnsVuWJIFwPVZxZxPwT1jwQvOI7YhXlWJ+JHCS6ERXQ2VW7hIUa?=
 =?us-ascii?Q?MhoXgDRW7XZW/W8VWOcJI75gI9cuuJP7QM+b29jF63mlqlSNk7rWWfbDDSd5?=
 =?us-ascii?Q?w5uMXcLT55lvk5Z9Ts0Sq+GD+OKl+q/cFDESMUTZv5KKd2Ip1/InGWf+es0v?=
 =?us-ascii?Q?sIRMnTqEb3V1GaZNM9FJZcxAr66pxjQ4MpTRPT0qETsAj5GtCcx4xCvmxfLG?=
 =?us-ascii?Q?llNopLMP12zYe67A4KynnormMNz4gtGkhLkVZUd5AGN4vveyWcnAC6qtWPlT?=
 =?us-ascii?Q?w6pjPgMcSjeuAtUPFPmmo3isVnRbSd06D2auUry1vb+6RCJT4A8nvwhFoTU6?=
 =?us-ascii?Q?/x1zZr7J1Xy9jeZW2OvugNKULKBgrQ0gokeGlcj0wc7hVUyh03GkryEF4BLy?=
 =?us-ascii?Q?HxtgsOjGRgU7Y8qVXJpepYPoV/Y/TLKlLZk2+GDKqRNOoeriKwIBoP7V2HK4?=
 =?us-ascii?Q?sUij3dUGS3zQiV1WqkpoxnEJSynHb/PRsq6ymNWjGh8O3F+1zm7Rsq38uGUM?=
 =?us-ascii?Q?hEQR6HzuaCjQEwR0+qj+CNbdjRfFbjociKmPkLuHtM1hX0gh2q/0r48xY039?=
 =?us-ascii?Q?mSEjeTjwNy0W90eg2/8RAe+Nw+zBMaoqgVdcX34CHZstSwSKcCxDFcaIxOKj?=
 =?us-ascii?Q?tI/8tnzMl1twAU7YyaIOWsndUIMw18n5T1h0yrPUSDpocCFq1QipQzHDqSeK?=
 =?us-ascii?Q?TWoUGILLXyuUDJHN1vIAr9Iqj1qk/uhtqBt1c+VfEFBokuupdH0WyEbnRTQO?=
 =?us-ascii?Q?/RLJUfD0Jp+Ayg3pBOCvS4tKqdBtA+WeNb/rNiHq2sC/xp++nWtUQCxqTSHo?=
 =?us-ascii?Q?FI271yowOSzR0aetl67GVgmQjlqKJkHNsL2l8Kohms3q2dmB7lm3q6QIjLqo?=
 =?us-ascii?Q?xDZlb7ogz3mHAI024lEOBYHk0m6FISTstbKUg1Tn1WeUMv5f/k2zieulTbII?=
 =?us-ascii?Q?diIF+FXaeGnNsoPB571QLj5hHnEMGJvhlWux6oHijT9mrEtYlVSYzrskQavi?=
 =?us-ascii?Q?XgTpW5G291oNZct6CSWyLIJLdd1wLAis4nzdOt12cPEroGLNT15XPAZHzd9Z?=
 =?us-ascii?Q?ZZt281r/PrZ6h/QKxhLHohMdGgRlWtmUER/lqNZP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0c2c9f-338a-4a83-469f-08dd15fd22e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:51:51.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8YRT7P0O8lNcI4Q4Aa/0B+HFeDJsq+F9DMtBhGh3kC8CNTiaO9lyBE+Jetku1URmwAbvgOGf2vRaHSBBrvbQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_055157_508160_7D487BB6 
X-CRM114-Status: GOOD (  12.11  )
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

From: Daniel Wagner <dwagner@suse.de>

This tests is exercising the target code and not so much the host side.
The problem with nvme/030 is that it depends on interface to interact
with the target which is not covered by the standard. Thus we can't
run it against an arbitrary target. Just skip it when we run against a
arbitrary target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/030 | 1 +
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tests/nvme/030 b/tests/nvme/030
index 596e411..fe74849 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_nvme_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9ad9a52..d1a4c01 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -191,6 +191,14 @@ _require_kernel_nvme_fabrics_feature() {
 	return 0
 }
 
+_require_kernel_nvme_target() {
+	if [[ -n "${nvme_target_control}" ]]; then
+		SKIP_REASONS+=("Linux kernel soft target not available")
+		return 1;
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.34.1


