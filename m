Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3791C61DC4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nuQoURfAXs9A5j0AqOjbcqJ/uEhP2cikdtEm7rYNDss=; b=32xSGSZBrkCoIFa5pTFOQCys6z
	AUhZ4YrzbMud5kVl6IdujPG1cv8e0VVE3dmwtogCbv7eX4xQFL6DAGBhju+NeQAImZzpHSJv7s0Kz
	1AoxRLH4CjEWbfbWYEDvczblDSEjrHz6k1Z/fi9oBH4vKGJ2suX0s2BKt2OBjbaaJ1fh6lDuF7QbG
	UPbf7iUDsqForLoG4k6jc+oSxndwxutTuMyp5fTOq8Xbh0qS7+FQtisK/z9Em8pug+ZcDkjeM2GXg
	f2Q4Jsdt+nH7MvWWUbTpZok/glYzUY4ljo2gfnzpmq1vO3IxWymytkt0hi//J8S4x5X6FNqMm6JQQ
	iMU2qS6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzeiS-00000004atB-0F1J;
	Thu, 27 Aug 2026 18:20:44 +0000
Received: from mail-japanwestazon11021073.outbound.protection.outlook.com ([40.107.74.73] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzeiM-00000004ak3-2M8h;
	Thu, 27 Aug 2026 18:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN6PAQnLJXYG7vTfsNJqAm9Xg/cpJal2JhxyCH8K5OOupI5jt0YGwaywxVfbAykbga940RZTAm94MANbTkxa9FCP+Hh+VqMpMuC/3kN2WFgD+omffVgzICLMBu9obaft6onzmG/xEi5b7hU6pkIyheamhr/wBsnKRVGhz7exjuH4k0Fc9/7A3EDgj5UF9lKXOKB9v/oOiEAznyt9Kgmnv+mpqzfLnDNXL4ociZCX52qiZtD0fu6jmIIdSuppeFDAnJKFMITUQOswPSvQ56zExo/GjFxzrwWZyUu4TQU3J8pSFDmVvI5rP5lyoMjSCTs9Sc9AI+jnO9v9SsDNrF7DLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuQoURfAXs9A5j0AqOjbcqJ/uEhP2cikdtEm7rYNDss=;
 b=RCm/YwB6i8xLFC5JeF768qjZz8BxAE0xZhbQehk/9+AmG9I2eHcr++w4lezkbM8bc6aOZ6BMKBQVLoV3qQ+1GsGnkO6wwEnB4uiYIFzCJ+wxMrPCztBnSZiDVx00HWzIkCOAX7eT5hy24v071dLi8KmEmiieklK9+m6371dsl6omyLirpPaaMvdXUnkBbf4d4kBLD7xZBDRpdreo3gjclnJaBafMgYQfACYZahNZpzgxvfdKFdUTU9+jPYxhE352CqEDGc5DbnOs0Q1IdKIve37+tEshQwAGeVOsFJ9i/wFDPC76gEbmYlYREpzTNmxHxVOszPHXwC3vA20tHauPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuQoURfAXs9A5j0AqOjbcqJ/uEhP2cikdtEm7rYNDss=;
 b=LDJ2wCVc1OqSXxdOkVj8bGxNpR/ZHPdZcLSLXBlUZj/fVNpNCepS8ZvgXzl/z59OWw8KuVagb9HiQlPpuT/f7QpfhU6p6uXSV2mdM5vIef4n9qmvD23Atdwi0sQY/pgcosoZE1aWof5GZV9jVckm4PvhMDUxu6aBJE6JzJo1/jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7058.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:20:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 18:20:19 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Aksh Garg <a-garg7@ti.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	ntb@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Date: Fri, 28 Aug 2026 03:20:12 +0900
Message-ID: <20260827182012.1984960-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260827182012.1984960-1-den@valinux.co.jp>
References: <20260827182012.1984960-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0062.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 767b165d-8e99-4854-2961-08df0467da29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|6133799003|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1/u3Su6XtZGCUL943Dkk90/z5sN4Gm6VnMMmas8DpKYpc4QqgOtplnpfwZ0xAwl3dMRFnb0205LjmFeCb0mhHZmVMZ/7O4xvIu0Gq2GFQm+nhRfiZR9ARm/B++oq2hZl2mP2DvWG/1N50rjdrmEjdZZbSVvWiwMOGwV72N5M2rw5pSTstWxqqjdEd8yFn9Qf/XayUXCh/GaFvrCc519vj5FW2ipKHWaCuDgjCweepSwGT8hqJwmEdn8IeI1/P1mmtDdtBdhAEmtI7W2PD277kKEHS8MZ+RzQljNM7LLMQBqMvewkd4UJGiIIaAx0zQPvLUZP2AZQRyiw34fywEWcvYv7UHs1UvJACCTj2SE3fDN5Puq/KxZHytp69KH1UPTHd7R2WcljG0bfci6PrEBd8M7XxLWy5ZPd4l1t2ReoTu4rBn97NXxFwOQbv3MCfp9glsGPNGcQNitiVzugrXUhwg0qW9wXr3Ve3ncpp4AkraMasn4dyBtTG5WEy9m7YcUrGFcjQSSWcNTG5R5proy2dFPUwHh5A/sXnUq6z8TLRBeawi9o2uK4PVZlx5C/mKFWI+20rofxct972tyN6MpqXervlJyWS0Wi/cwb0mqexiKjvlpwJ6tP4mRJzb7UZiuulhHHJwgobhmtlXGXjW+VZUs1L1enyu7Qas1uEBlqwOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GHzg8pCWiJgjweSBvsTYhvji8HHDPH90XYAADlBs2lWdBokaTiMJDK/2K2K8?=
 =?us-ascii?Q?JghxJexBwzHNfJ2VSLw1o/pnrt1Eyr/jU4T+y/ijFduL5DcQ4zhSjLCoPgGw?=
 =?us-ascii?Q?SLLaRbTdHFA5jjyT7C+V26EGJJrxYL15d0/GhOOlESQfU/BDFuE78XCkaDHv?=
 =?us-ascii?Q?txt2Md2h+FKqttnvV8gqpJV3j7c3QV9KxAk0MQm067GvHQkRl96sQqbt9RZf?=
 =?us-ascii?Q?cMijG6yRkuKU9MpAfkfybpaMKH1aMV5NvUgjLkjxMd2iVBm62iPe52RCNzwX?=
 =?us-ascii?Q?sM0jkHEXURxGnjIlfYuF7YdzH6YD6XobIjYcnTAXjjIh9D8ThqB6WGgmpDaQ?=
 =?us-ascii?Q?ZnI3vj4wINi+N6zg0GiIWEXBS6gFKPLI67WPUdaS9XleXxWFZ2CMZRnAMNJr?=
 =?us-ascii?Q?07FoSxJlxyG7OgXntrr6YCE+sxmnXKN3aYGsrZH6BsohA0r4c28atci9fpzy?=
 =?us-ascii?Q?GFYo6kvHc97g6lNRoSTlRq+HPoH1zmSAp/wZ51I9HZgITGFP8jfpr5bIcMGv?=
 =?us-ascii?Q?VpnsKfLOey8yy7BkM4Leh/IAQfn6fqa8wyMUuPwSRSCelVJA3vn1b+QvYR6r?=
 =?us-ascii?Q?XwOivgQzJH6j0+kjG9inlVjiq4yqd9BX/s7j2rWj02N1WVrXWq2doKkh7AUO?=
 =?us-ascii?Q?dOMHced7mp28xfYHf/SrrCl4yS8UtxqjPaAReley6ZShTq3c1ZsEW2NAZ7EW?=
 =?us-ascii?Q?pt/iXsyHb73NoJ2erQHfnLXnGOgs/M1MCaj3vuKfilbsDsJ0e/xNPiC0lZOf?=
 =?us-ascii?Q?MFcHH6teE6lwly4v00maqZefN6yyGQAQDthGp1Va0NkRabGHSh4ze2aqfbTi?=
 =?us-ascii?Q?uVk7rZF3sp9/vaA80LUSCM8nwQDLugDFXPTsdECMwlXBNVymL3a1bNBOilhb?=
 =?us-ascii?Q?WUQpVxHnVbh5ZFr/dZaHWCI1n7TvxA35X1xpg9p25SpYbnYNxUtzlKFsuQXU?=
 =?us-ascii?Q?1WXjxvNN5B/+rxFEsEjixh7e/ugGG05Dwt2XlyyAifWrHVJ68zlUnUQeLnbT?=
 =?us-ascii?Q?jQB57jSaSA4w2Rd1HbMa8PWikdS+gqaAfYfe7CVamsJ0FexgTh4FDdI8YB9E?=
 =?us-ascii?Q?ESxUpcAefKCuUnx3V1uqcFJxgGXR0fGTtxpi8SwUuXRkG3dqqgL+8mXI7ot8?=
 =?us-ascii?Q?nCfKjOVMQ6R3GEKPnz/gEATrWPtA7JV5wZ03Ypy9W7I87Jda2LDhHDLl5Aw9?=
 =?us-ascii?Q?P/+loA94WbEn22WoJ3gUWGLrPNkcq0G3QScsr3PIE5hgZD5b+6GHpZUTomc+?=
 =?us-ascii?Q?ItG3nTHuSQrOsu+MuRhRU+DJoHgA/JfIRsjQUe8Z84aSegokYZWtICis4MBk?=
 =?us-ascii?Q?e/G+s33ir5Kq1AYBiadNe8tKfPv5JjcSK1aRzU/95QQ/ciCkBRvR3uNfmFbs?=
 =?us-ascii?Q?/B05TL7PXDMRbg1xRJH0K+8I2g9PaWfaZFs9WHyB4q+ksuAlNkZUmfQrhhs4?=
 =?us-ascii?Q?BNMKKJkWufeMMrX9IE3O9C/tuZNQbY9FJGsO7xZs55JN8P+PDKCHpg08hNft?=
 =?us-ascii?Q?Np4N0PDpY7L65V0N5gDOpwYtGNsbg7wrqOVIw/Ckuye+Swv7Jr6cTh8w/9Xd?=
 =?us-ascii?Q?+sd8awpx1HDnXEv1tegl0AGNoGjMxYUBVkaOYQXjsvHSSqnmPmsSdAEHLnET?=
 =?us-ascii?Q?SFaYyxH31Gzq1jkeTD9oNNK3xmPEC+2pYP0R2xqXXkDB0d2qYBn0xW/aHak0?=
 =?us-ascii?Q?3WuCQhdUXee0GfTGINplLfa74JGXy8MmKkcp9cTXfJSwEzRCl2JS/686/EDv?=
 =?us-ascii?Q?NCZeTK2WdaypgC3p+ayXU4KBfvie5m1nrscKbcZ/c8naQX+D6z82?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 767b165d-8e99-4854-2961-08df0467da29
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:20:19.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qfya+bfu86m+Mn/Cdq2Zg3/x1fdSTrAmMqmwSUmDPnRxBjJJc9BdADPLIO02DWAPFds+yvbYgKEx7AolzebFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_112038_616764_052D6913 
X-CRM114-Status: GOOD (  22.42  )
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

ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.
When MSI-X is selected, the host does not program MSI, so raising it can
issue a write to an invalid address. This was observed with an IOMMU
enabled on the RC.

Configure MSI-X when supported and use the selected type for peer
doorbells. Use the hardware-owned layout when available. Otherwise
allocate an EPF-owned Table and PBA in the config BAR. Configure db_count
entries to cover the link event, the reserved slot, and the doorbell
slots.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 67 ++++++++++++++-----
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c3caec927d74..d9622a5d4710 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -148,6 +148,7 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+	bool peer_msix;
 
 	/*
 	 * True when doorbells are interrupt-driven (MSI or embedded), false
@@ -155,6 +156,7 @@ struct epf_ntb {
 	 */
 	bool msi_doorbell;
 	u32 spad_size;
+	struct pci_epc_msix_layout msix_layout;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
@@ -303,6 +305,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	switch (command) {
 	case COMMAND_CONFIGURE_DOORBELL:
+		WRITE_ONCE(ntb->peer_msix, argument & MSIX_ENABLE);
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_TEARDOWN_DOORBELL:
@@ -439,9 +442,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
- * is obtained from "spad-count" configfs entry.
+ * Allocate the control and scratchpad regions described in the above diagram.
+ * If the EPC does not provide a hardware-owned MSI-X table and PBA, allocate
+ * space for them between the control and scratchpad regions.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
@@ -454,7 +457,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	struct device *dev = &epf->dev;
 	u32 spad_count;
 	void *base;
-	int i;
+	int i, ret;
 	const struct pci_epc_features *epc_features = pci_epc_get_features(epf->epc,
 								epf->func_no,
 								epf->vfunc_no);
@@ -462,6 +465,29 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	spad_count = ntb->spad_count;
 
 	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	if (epc_features->msix_capable) {
+		ret = pci_epc_get_hw_msix_layout(epc_features,
+						 &ntb->msix_layout);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Invalid hardware-owned MSI-X layout\n");
+			return ret;
+		}
+
+		if (ret == -ENOENT) {
+			ntb->msix_layout.table_bar = barno;
+			ntb->msix_layout.table_offset = ALIGN(ctrl_size, 8);
+			ntb->msix_layout.table_size =
+				ntb->db_count * PCI_MSIX_ENTRY_SIZE;
+			ntb->msix_layout.pba_bar = barno;
+			ntb->msix_layout.pba_offset =
+				ntb->msix_layout.table_offset +
+				ntb->msix_layout.table_size;
+			ntb->msix_layout.pba_size =
+				BITS_TO_U64(ntb->db_count) * sizeof(u64);
+			ctrl_size = ntb->msix_layout.pba_offset +
+				    ntb->msix_layout.pba_size;
+		}
+	}
 	spad_size = 2 * spad_count * sizeof(u32);
 
 	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
@@ -502,6 +528,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
+	struct pci_epf *epf = ntb->epf;
 	struct device *dev;
 	int ret;
 
@@ -521,16 +548,22 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	}
 
 	if (epc_features->msi_capable) {
-		ret = pci_epc_set_msi(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      16);
+		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);
 		if (ret) {
 			dev_err(dev, "MSI configuration failed\n");
 			return ret;
 		}
 	}
 
+	if (epc_features->msix_capable) {
+		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
+				       ntb->db_count, &ntb->msix_layout);
+		if (ret) {
+			dev_err(dev, "MSI-X configuration failed\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1512,6 +1545,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
 	struct pci_epf *epf = ntb->epf;
 	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	unsigned int irq_type;
 	u8 func_no, vfunc_no;
 	unsigned int db_bit;
 	u32 interrupt_num;
@@ -1523,6 +1557,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 	func_no = epf->func_no;
 	vfunc_no = epf->vfunc_no;
+	irq_type = READ_ONCE(ntb->peer_msix) ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 
 	/*
 	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
@@ -1536,16 +1571,16 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 		while (db_bits) {
 			/*
-			 * pci_epc_raise_irq() for MSI expects a 1-based
-			 * interrupt number. The first usable doorbell starts
-			 * at EPF_IRQ_DB_START in the legacy slot layout.
+			 * pci_epc_raise_irq() expects a 1-based interrupt
+			 * number for MSI and MSI-X. The first usable doorbell
+			 * starts at EPF_IRQ_DB_START in the legacy slot layout.
 			 *
 			 * Legacy mapping (kept for compatibility):
 			 *
-			 *   MSI #1 : link event (reserved)
-			 *   MSI #2 : unused (historical offset)
-			 *   MSI #3 : doorbell bit 0 (DB#0)
-			 *   MSI #4 : doorbell bit 1 (DB#1)
+			 *   IRQ #1 : link event (reserved)
+			 *   IRQ #2 : unused (historical offset)
+			 *   IRQ #3 : doorbell bit 0 (DB#0)
+			 *   IRQ #4 : doorbell bit 1 (DB#1)
 			 *   ...
 			 *
 			 * Do not change this mapping to avoid breaking
@@ -1556,7 +1591,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			db_bits &= ~BIT_ULL(db_bit);
 
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
-						PCI_IRQ_MSI, interrupt_num);
+						irq_type, interrupt_num);
 			if (ret)
 				dev_err(&ntb->ntb.dev,
 					"Failed to raise IRQ for interrupt_num %u: %d\n",
-- 
2.51.0


