Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907FDC54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iIHcXsYLX97/zn1+UZB01xMQLYgv1FxOVTNL17E+9aU=; b=JWH6jmQOIv6LJjiAJ0uv0xxsjU
	75TLbx8PwrVDs0TZFVjZgXvcjdycVnYHaG3yBBeDwLB+YS+M5L1+bWjrIx1nKFKW5vAgJMhjEJLSc
	Ygft8MxKTiwQytz8MHAM9cPLeXp9nRO+5+R7QQPg+VtRAzeGk13JWCK+8sCxjXTQG04ony0+4GkGT
	vJqyPpFa3lw31QPRQu1zyyUF43vx4/3q8GkBInJzUFAuGqLAuFSvWEMscKvnNGTa1NdouBrvnJ2YU
	LqkKL/YMTeY12TXwlKaVvQwifYbvlW783oJEpY2jL3bvKRdpm4v2jZL4gcjGcgIelHqM5r2jxjJFE
	IfF41w7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCnv-00000004YAI-1v92;
	Thu, 07 Mar 2024 12:24:55 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCnt-00000004Y9F-0rZA
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709814293; x=1741350293;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hKLAdq1BKrsiC/KDVO7Id+p3a0WH0aX+GhxB3aXQDyU=;
  b=NrFKLqjCc4zBqJUgkB9SL17VjYxLHokUEc+39DRwQ10hq9FRSjztUuiz
   T3XoiKZzT2JVhGMJbyHDlaRRV4KVvdU9xLcrjyM6upsMOhJ090YeNVajz
   JS9AAs93pwWvnhmXgpdgbSljaBdzIRxZSXuhWVUQigXw+4UIov1/GZBKJ
   s+6Ryjwz2rIcmwsbQZxNO8jNdK3B6zfqiSst++C39NaEHzWUVCd/SfzFy
   x41SmipIKtyDHtlAj2vNoEAeQOXdWDDD0Vg+v8ou80OLO5TmNU/nTxkvG
   ByZOrE6KEEqI8K2Mj9B9v1eXIZBhbE/AMwtpHM5f5bZRyfRprCfFaBDR8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="29921154"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="29921154"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10027075"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 04:24:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 04:24:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 04:24:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 04:24:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 04:24:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgDT9wnWPeojujKw92C4DfZAKcFKbLDSLcxMJFRLSwhdvf31Em6csXx/29vyuqCjB/mYKLmsG8U13h/U0Yz3j4TlIoLNkNmAjUEAwWvZoBaIh191IafX22MmtYTHeNPJSs1MRCXkRVcpKxZQ65hHj4aOrLmEfHB2ue3YJiUii4WM4L/wIrBEK7geNWqkWo1iKcssWx9+Jb4yRKNy2O2d5BpxrJTjH0Yqp6GY5ZdVykVQskC8xAO/h/v5saNXKVSUMDy15QSKnkjSFzFNcRojPQ0L5T3APEfi73oNu47Annt0HYWnN7dpLwbpJQiJnDMsUBCCtpfzq0G6kK2SRANafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIHcXsYLX97/zn1+UZB01xMQLYgv1FxOVTNL17E+9aU=;
 b=FlDT5/io1dcQleqsdmeNqhsLGd+w05e5L6rJc+dqhGdOPieFYXlBG2LqQvFmK4PGqht21hL+czRSXn1SjsZI5u7vU9q+7G6DU3h9SllUtMSXv1tv3bH4KjcXkap8/4dCb8iysIOnmd8U216UlD/ZUtkStrrLl3rXzWiA+gdl3rgODUCDnZmH/S2XSRYLaCVy0voAVcYhfDsS+9NAiiC7vhHlLZL/JbyxN9a+8rAQI+RNpJZMM5Q27V5g4C2rZiOkOjvdYbFfAlBe3Q0AVJIz4i2R36rz6Fqkd25bWo8VDgvr03fyk+yzhDp/HRqG5PEMxykTq6NJS5M1qLa6hnRWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5569.namprd11.prod.outlook.com (2603:10b6:303:139::20)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 7 Mar
 2024 12:24:48 +0000
Received: from CO6PR11MB5569.namprd11.prod.outlook.com
 ([fe80::6a89:3353:2e9f:890d]) by CO6PR11MB5569.namprd11.prod.outlook.com
 ([fe80::6a89:3353:2e9f:890d%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 12:24:48 +0000
From: Konrad Sztyber <konrad.sztyber@intel.com>
To: <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, "Konrad
 Sztyber" <konrad.sztyber@intel.com>
Subject: [PATCH] nvmet-auth: fix dhgroup negotiation
Date: Thu, 7 Mar 2024 13:23:42 +0100
Message-ID: <20240307122342.146405-1-konrad.sztyber@intel.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0148.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::15) To CO6PR11MB5569.namprd11.prod.outlook.com
 (2603:10b6:303:139::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5569:EE_|PH7PR11MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e90e3d-a86e-489b-0686-08dc3ea1947c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQnzJFFkAoeASFXCwJQH5+JaB/iKQj8OiNzmDyARM7KGEJKdhOT45Xa5tEnHD6KlkpnFd/v+xTKjlOcSHm2T7B4BZpRpLh2Nlb90/P8UNdINg5Ypu9lPrpTKeq4f8lWjR7FGThRQDQy+VesnopscbjYcXw14kfo+5sN3G1ff+ODk8g5yi/lQjbt2dHbkSAwMHNOh3UJHI9p+Uc7o0pT95qUMmeMtGR6sOTz03AQ41tQkCDr4Td1cOFPrwfFM0v6dfbKEGESWmJwoRLgA4s1uMlQErGN8ajuRI9hrjnZ3eVknDpy+17qgO4GFI2oZ4ERtNOsPg1Lmuox7Kl1wVDlcKtibAEFBs+66H5hvem0eYwPndjen5w0tPWKi+UOsQ93JIdr2EkGbmp0BFPNzjfqrGdaLbnI8Weg2vsapv3yVjwgTyw+Xi3fPi54Ud+AW6ODcskOO+mXLa6ErYHn+xKTgbB5s1JzkFPl2siySXdgYU4Y9OFh9W4ox4dYuQsw81RYXQcEOIl8zBIpDLpog3EINGx3y6AXwrHIvOdmM5FzvD66bVuJFvp8RAmQ/WzU/LTpb5c6/omCRFEK5ub+9Kbnz5HjdfzW2d4EdXlmNYY0drWX8D+Z6MJPSd7miKrCUdubTzJBS4nPwTxNiCe+HsYjKW69DK8xrxnjON2OIxKWrvlg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5569.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/4DK7bxjH48fdJ3x94pIU9WUkPBcet8H0hSnRa36hSrt1kn1IXirMIcT6Fp?=
 =?us-ascii?Q?ufPV4ovjtqV96vTj44egHrfk+P0aheIuQvsAaQORAH2L4kcGWCE6//Q5IXp+?=
 =?us-ascii?Q?+eY00OMpUF8rNzcoXFQwLQYm1REyp6NLuGAsUr8Hz7++mCZMlw7nEIqcLrCI?=
 =?us-ascii?Q?qoJeFLWDQwIXqAcUMTBwn+T/BlofHmiE+ZI2X8YCnfjuivLYVtk/yb/i22Ma?=
 =?us-ascii?Q?WdHpdSzY4RqcM/MRIb5suyLMELQp4klpQBVeu1KvUUJiq8DzArwpy6PgQeYs?=
 =?us-ascii?Q?MuCDKIgM/015BWsG7wuBoatdlgLtf4Bs0d7CQ4ATT655+5+USOHkJHzSp3yT?=
 =?us-ascii?Q?ZmynHMF4RIx21UCdjPMF1ajmE4jL4tzi2hssykDy5I32/Jnt5tFENnXQThL1?=
 =?us-ascii?Q?ciHyvh6HQrUXOoP6qFj5yVkFapEEkcYjt+sJUAxUEWFItuGJaWdmoc6G7zDa?=
 =?us-ascii?Q?/kmwAqA5SEjXaD8XHmyR+l3tiRP4X4C1lo5aFMs/UCtUsD7X1fr3Q9db9CqS?=
 =?us-ascii?Q?RAxqdP7ybg3d/F2UqiggsDwnp+FzPknNB06HzFrZXt4HmyqA9dzY76s+b4AJ?=
 =?us-ascii?Q?otZo2/zEBZzO6z5Z5W5mG0n6ULG8gsZOelabTKctUQOrV5tKImN3ro4qDhS+?=
 =?us-ascii?Q?ukkmjg9ijYUp0fjj5lzhFHA8L/ss8RLXtAA2JzrMyhIvs5m2GlaHWf79l9Nh?=
 =?us-ascii?Q?KTUx9FioLJ4pxIhmwq0dHjdpih4ZAqKZj8pADVDhLAlVyCxiMCWJNBywTiZy?=
 =?us-ascii?Q?tCgNYgS4UfI6VrpvSbLihCTX/qaNvMIH6dTXmmtWOBXrexPYqDsBTE2LK/3j?=
 =?us-ascii?Q?J0zDxy9bqCEJWuyjMdSMI8mmrIjDQXk3mKEOKBpXWNfBICIWRgzqAm4HcPLT?=
 =?us-ascii?Q?fdlBYzlpCnzSUatc5LFoc/UXUpsCCuwyfxipo11Vp+fLaAFT0FtmwodWL4m5?=
 =?us-ascii?Q?unG9SWDFw1/4TlsR/SCZHMMUL9khBGM6C5o/W393qQttog/0T+Zm1mqrlCNe?=
 =?us-ascii?Q?8Tfl9IZiA4Vt49eo9F3lyIDepwlwFMpYg45oE7UILxqxsPkt2HDAB9QRA05t?=
 =?us-ascii?Q?gfGH/Du0gNFWcAFYNK04YVTeI+DNTbadszM+ny3JxLq6ASph8G6m/wwBRfQ0?=
 =?us-ascii?Q?lkjoIsnpXgMYE1E5naASb9P7agrXrW3GjcAST56K/u7dTQyYFhdNdwzV92zq?=
 =?us-ascii?Q?JFHpUrGYqKeu7dntdE/hwMSc8n8QDm2tJiaJyGPqA+HrVupZ3iaeqHMR88W0?=
 =?us-ascii?Q?TTGjcqwARjDmvUfBlQPW4rKd0nr1K9VwbZAa939D2c3fe/mLSlX5PXqjVfWc?=
 =?us-ascii?Q?u5I333bjqQAEB3aQh8Ea9OoUVCc3yDhc4r1NkXXtyln9Som/T3V3vyi3LY0D?=
 =?us-ascii?Q?cKzPPGiL6uNY1GjxWuuYAUpTn9rEK2FnU7sCbYUyknRDKKtBFrsSVQh9lkT6?=
 =?us-ascii?Q?e30AjX9rWdZd2KO6Mepxik+/WGwYDChbV5nFLKznwP+S+wBR2UdBKbpbg3hZ?=
 =?us-ascii?Q?uJ50g3ZOJpNbxNrYCwLcA6mP3IVXuCVCE66yHsCWx+crBRhdbkhlLWngzlq7?=
 =?us-ascii?Q?kZNqBzm4tH/7Hmw7yCD9vvg4GvmEQT6IXbO6/2DDNRROC7XIkFfkt15OWWPw?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e90e3d-a86e-489b-0686-08dc3ea1947c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5569.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:24:48.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bIAGjZWjkwE2bxouzYKFpBD3nGdshV8Si8bRdlFy69ouhdTCcD2UtGzGclOLXlzYrGA5rTK6W238C/TnB1IxSK25lUxqeC4pAbwnykc2nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_042453_287700_EFF287D0 
X-CRM114-Status: GOOD (  12.88  )
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

There were a couple of things wrong with dhgroup negotiation.  Firstly,
the condition comparing host's dhgroups against configured dhgroup was
inverted.  Secondly, once fallback dhgroup was selected, only dhg_id was
updated, without proper dhgroup setup (e.g. generating the key).

Signed-off-by: Konrad Sztyber <konrad.sztyber@intel.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index eb7785be0ca7..40038a6624ff 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -81,7 +81,7 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
 		int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
 
-		if (tmp_dhgid != ctrl->dh_gid) {
+		if (tmp_dhgid == ctrl->dh_gid) {
 			dhgid = tmp_dhgid;
 			break;
 		}
@@ -101,7 +101,9 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		pr_debug("%s: ctrl %d qid %d: configured DH group %s not found\n",
 			 __func__, ctrl->cntlid, req->sq->qid,
 			 nvme_auth_dhgroup_name(fallback_dhgid));
-		ctrl->dh_gid = fallback_dhgid;
+
+		if (nvmet_setup_dhgroup(ctrl, fallback_dhgid) < 0)
+			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 	}
 	pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
-- 
2.43.0


