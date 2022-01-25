Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7040DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0gtULyhSrSgMNbUq1d/XblN/mRHI9XkeJN6eFSEU8Q=; b=zeE3qrKOi4zFfInLTp8nkbQvfG
	/iVhviiwST+u0uAwgk6G0l7eMZJ9gebCTBCoQjGgKCqDW5GDhF3rpfXV/sZz8slE2bdJG/54fymIR
	NE866wyslWU4Vm7NdTdYHIdxCRqmibfa5AHfpvJpnBQ0+3n2/jR192zQxEndCAzbi7rq1eBbhfeJG
	sBr/zVDwvWxNDRpowQ3/7y/YAjm8VsNPLHcuIL/Fl8MsR/8IzdZeyqmG6N7DiIMi/m5c3BQubRVAn
	SDzMLP44S1R4+vg99+1v1AO/CYkiJ/F7Lz1D26tkkH1n8bObysLkwQpQVeMQLkIVRYwaC/fyRhxPA
	1Es38spw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCNKQ-008Eli-GD; Tue, 25 Jan 2022 15:01:50 +0000
Received: from mail-mw2nam10olkn2079.outbound.protection.outlook.com
 ([40.92.42.79] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCNJ1-008EVu-Qc
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 15:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llYxGhwS+T7ko/DDUzH7N5a4KBKk2uQ38B52QdaomSs9BbM0MJhtAdGWZQ8J6R9ZFtfhW4Dp08Qyz4VsXsUwHHv6P4tIy+fi7YYAz+XPA3bCqu9N3fFqCr909uuDCvvI21/R78WroEuMNqCwafBm38uVywi3i8aCBFlnBakg8GyACL58RSnrKJdUAEcsFNSOyj1HgMvKEJzm5zhUOFDpntnyjNpVi0g+UszX4uguHsQAZu8cVnY9I1DbtPhNLd9xaK09gUdyIkYlR97KBB+KuLM654zFPonqokXpq2zj2Xojzws9g8IcQdUGqY33UU4a03SZo1baNqZIgNf+/D/Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0gtULyhSrSgMNbUq1d/XblN/mRHI9XkeJN6eFSEU8Q=;
 b=ktzJiW8HFdrOKUegZImHviFQJdxNvY7f2W3F00m+3Yj29PbO98jlj5Uac8xNdXJC7xGc3MYOu13uc+Q4bFvfqtlqqzOCwMVh+xMZje2LotlpfV8R0nI9y1F5qlRxw3lYCfhhWc6Ln9St6OL5YSv4nvZRNB7kb+KFEI3KFi57LyUtLA8x0sytuQ69821OTAYSfp6eMa818BLmTOdHL0HTp7a/hMBmMjdc4nwCdLMAM4OHELSgQ6I9I6sMN3nIhmz2VQV/6DQytceVtBVSl4hwTgaBRbzexC1pfQkG8IViWE8ajWqyp1wLoIWaGsXnS4eM/cznN736yAvCkBCpfYj7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0gtULyhSrSgMNbUq1d/XblN/mRHI9XkeJN6eFSEU8Q=;
 b=oML+D7qoSOv1uNAg6uG2M5nCLC4+mOJBAyvhabwRwYO4jc88ugcmMFSiOCDqleuFjX00pxVHSslSM4JzHI/7hvZAvtjCWxWKxQ2pMEeFCkHngNN4D432GkQm9GqS4xm7qSrkUu9urBAvk4r3Fzc32jRrY5i1fdLwsKaZlacIg+9DyGtMLQIQox7nfP/af5wrSKrvJkZzy2gIf0b6AIzoOKM9IG3gGfRS3brPfmD0whkfHdjIHLMsQei/ulJb0sEXz9X3L+IPFs1eqe+9R/Yb7215FWBeY6cZmPSXDsMjUyeP5JPIvuISeq0nBzY7hOtSOnzm+p/gu7ftsuaF8egAtg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB2590.namprd13.prod.outlook.com (2603:10b6:208:ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Tue, 25 Jan
 2022 15:00:22 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::8078:8a78:bc1d:43f1]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::8078:8a78:bc1d:43f1%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 15:00:22 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 2/4] nvme: add host symbolic name
Date: Tue, 25 Jan 2022 09:59:54 -0500
Message-ID: <BL0PR13MB429181ED6E81FAC7DDB801E89C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125145956.14746-1-nitram_67@hotmail.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/422GbsaFOEzNVKfLEA4/zeJHSeKpydj]
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220125145956.14746-3-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e338c9e2-3c87-4325-c47d-08d9e0136935
X-MS-TrafficTypeDiagnostic: MN2PR13MB2590:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCWYb3yI5RgJQg3hyhp9UUAF3Wi7B7yooqTj3ubkqCgk2b6zUDV1R9jnz0kFHv282UdaZ6fJhUS09CdbYGdfWG/ds/qOMdZelHAaeXx528pSC9jJXR5lJHK+be+La8HPjzIKk3MyrZMdWSjYzaykww+E4dlRAXKkUONF3RfwCoxJH51v5bW99lCnymDdeXskvbeejlr/CvoIiMUJKPBFANTiXuUwOBNdArtg8NuVYCqGcNOUlVnQ0sLUC5gk/DtiS8NU474LI1H7hhH/Gr/rJ7NDLAn1Ekb5kSEnUSDdIumEttshEhMr7A2b9+GCV8MoSfEWmLpubk5n4uRRcUWIopmmTri0Ax176HPpATPJmc8xyON2wtB8B0Cb9gPeEPO+FjgxiMea14GcDol/nKngB9/R0TEQy/oHZGPAv8N2uQ9zeK9v9aS4vewqjkPfPQV7dn56VRe1ssyOpkumAJ8AByAuIWEcmdHt4joZNbMObx/SmUcYavALv+0uAZLEFNAEljwJilgYQL5uSIaHpU8n8b7jsqA2lJcwPRjXzyFVc9xuYwGltC4awj3bEl/s2pxq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IEk+inFfW1AJqB3ynalFCOsIUffwVd3r021/XUMi6JXQS1AqZzXLM4j4vvy?=
 =?us-ascii?Q?ywypLb6m1zJ2yVEmTTkMQ4O+neYr3Hi4Z7fs0lgTbF6i1JRIsBBdhSrHLCaS?=
 =?us-ascii?Q?SN75krJXbjHgIK9DIDdzkPBOn+hqvN/iOcZzwS6JKtqvdw19AwS2AxvzXisE?=
 =?us-ascii?Q?Y4tjPdhrA9Qs1bnx8SonbJIyLSUvqUjH7x8j80vyOYXHcq9BgK7rkSqm6exF?=
 =?us-ascii?Q?buT4bi9bsxvi0+T5xzGVm1+PhsRDT8OkFrB1r6CkbeAjA6Ta1505h5I3dMfq?=
 =?us-ascii?Q?UR25ZdAcf0hWTF+i7OTgecpYqcXphJGa/qDnLAqD+GL2E6vf9OsTaGLbC4+C?=
 =?us-ascii?Q?J4aCle8J8jWdXWd/S1XVwoeAWnJZWbVdstPZKhY3LvxW7tGMiGWrVasCEcJf?=
 =?us-ascii?Q?ZtWop8YJA9fBghAx0Eb6/ji9tPDXvNfaG2+REXOStu5st3Iq9Xz0u8BUtZbM?=
 =?us-ascii?Q?44yGOJBVceBgEYmLL0pvwur0SAaPiwR0rvrBV17U2MBUg9unsIb7eG8kIGWU?=
 =?us-ascii?Q?1GeFV9JursU8FwmGXQo2mHuAbHjezYgIUkl0VIxeif72byGOShqU7cu/9OnD?=
 =?us-ascii?Q?wiD7/OygyZP3w0PoXBoiTL87zsJh8SSbBN13NvwpusA5rIeY3b0kzqePDuLn?=
 =?us-ascii?Q?hIE6JcPzvLBW+ippfu8v83iSnUiHd4Gz5M9AQhkNzuYZ+kPBpRurTg6X/7Mq?=
 =?us-ascii?Q?x8ayU45P89PDxIMCxffYPyAozbeEidSxh/XETGA1YCfaXaYUvx0Or0oSokBn?=
 =?us-ascii?Q?+QXJfjsz4TygrXNPF7PUjihSfhoUTulZoYk3VxFXci2Bfi6L+mCZGRHvuBpu?=
 =?us-ascii?Q?SeEtFm1YMuzt7UwRVAgr5++dSa8UMjhAwhIhv5P3S/FSig8tbker+KUxfM1p?=
 =?us-ascii?Q?iP/lZA0zfRbybQ+Nng3l63h2sr8i/n5zlSnCiEiYBLMFMp++scMZVmEYJFwx?=
 =?us-ascii?Q?G4hkEX3awOPezXPyBYP06Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e338c9e2-3c87-4325-c47d-08d9e0136935
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:00:22.5486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2590
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_070023_900375_D2A5FC0F 
X-CRM114-Status: GOOD (  17.87  )
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

From: Martin Belanger <martin.belanger@dell.com>

TP8010 introduces the 'host symbolic name' as an optional
parameter for explicit registration with a central discovery
controller.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/core.c    | 14 ++++++++++++++
 drivers/nvme/host/fabrics.c | 17 +++++++++++++++--
 drivers/nvme/host/fabrics.h |  2 ++
 include/linux/nvme.h        |  2 ++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd34b92e8e9d..cf5d9984f8f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3404,6 +3404,16 @@ static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
 }
 static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
 
+static ssize_t nvme_sysfs_show_hostsymname(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ctrl->opts->host->symname);
+}
+static DEVICE_ATTR(hostsymname, S_IRUGO, nvme_sysfs_show_hostsymname, NULL);
+
 static ssize_t nvme_sysfs_show_hostid(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -3531,6 +3541,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_sqsize.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
+	&dev_attr_hostsymname.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
 	&dev_attr_fast_io_fail_tmo.attr,
@@ -3553,6 +3564,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_hostid.attr && !ctrl->opts)
 		return 0;
+	if (a == &dev_attr_hostsymname.attr &&
+	    (!ctrl->opts || (ctrl->opts->host->symname[0] == '\0')))
+		return 0;
 	if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
 		return 0;
 	if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7ae041e2b3fb..040a6cce6afa 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -540,6 +540,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
 	{ NVMF_OPT_HOST_IFACE,		"host_iface=%s"		},
 	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
+	{ NVMF_OPT_SYMNAME,		"hostsymname=%s"	},
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
 	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
 	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
@@ -556,7 +557,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		const char *buf)
 {
 	substring_t args[MAX_OPT_ARGS];
-	char *options, *o, *p;
+	char *options, *o, *p, *hostsymname = NULL;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
@@ -830,6 +831,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
+		case NVMF_OPT_SYMNAME:
+			hostsymname = match_strdup(args);
+			if (!hostsymname) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -864,8 +872,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 
 	uuid_copy(&opts->host->id, &hostid);
 
+	if (hostsymname)
+		strncpy(opts->host->symname, hostsymname,
+			sizeof(opts->host->symname) - 1);
+
 out:
 	kfree(options);
+	kfree(hostsymname);
 	return ret;
 }
 
@@ -957,7 +970,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
-				 NVMF_OPT_FAIL_FAST_TMO)
+				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_SYMNAME)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index c3203ff1c654..494e6dbe233a 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -38,6 +38,7 @@ struct nvmf_host {
 	struct list_head	list;
 	char			nqn[NVMF_NQN_SIZE];
 	uuid_t			id;
+	char			symname[NVMF_HOSTSYMNAME_SIZE+1];
 };
 
 /**
@@ -68,6 +69,7 @@ enum {
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 	NVMF_OPT_HOST_IFACE	= 1 << 21,
 	NVMF_OPT_DISCOVERY	= 1 << 22,
+	NVMF_OPT_SYMNAME	= 1 << 23,
 };
 
 /**
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 82567d493c51..3b47951342f4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -16,6 +16,8 @@
 /* However the max length of a qualified name is another size */
 #define NVMF_NQN_SIZE		223
 
+#define NVMF_HOSTSYMNAME_SIZE	256
+
 #define NVMF_TRSVCID_SIZE	32
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
-- 
2.34.1


