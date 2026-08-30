Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AA4C61DE1
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3WNNHF7lYyS2TBW5PE0cD9mT6hyb1l48RWryCsJHmME=; b=Hxv3Fg5EfeM2rsQXBsl7YMlmF3
	Rqwa017TE8tidr+7FWSzREpPvhUDjoKDKHfq2ge9X0LMFgD+BrtaGtBJIOU8dJyk7TMJFlx9FMlwy
	pAgTMbC9n3RzTzSxULenYexAvA5qnosLCIxgsc330wYBUN2+PuJcSDZfCEWvYDy2Dcyfi0xlu2nMp
	U2zctAYy6g+KBQ5PbiTZNpm54QOdZ8Z1o7AifEh0uDfvlEu1XTNqnTW6hPgB/lbKsnTXU8Pnm1iUi
	PiYh8RM6cvyARy8cgy4+Dl2LVuTBYFBPFeEiG52A7Gqj7RfydumhlMu2nrvNU/w43/1jpyZfLY0VT
	fz2tx4zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0hKa-00000007qBK-1LjT;
	Sun, 30 Aug 2026 15:20:24 +0000
Received: from mail-japanwestazlp170100003.outbound.protection.outlook.com ([2a01:111:f403:c407::3] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0hKW-00000007qAR-075Y;
	Sun, 30 Aug 2026 15:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs8bTSii5feFe4XqD4P1yi3XVpGYMZmwL/L8ef6nt63kCipNyfoVGS7RiKehgrg0xiObQZDkWCAe197q+1X9gyoXUu4NrA3PJfvNPKqQeHH3aG0cRhoQM0iKBmaaOAvkPlQLtdKRGwWmYx7F0Tq6RkEM38CUM25ID5w6e0XnqPPwW4JJa5Qk7NYitiJzItZp4MNTi+FODqt2o0BUr7y7RzMJjYbBZbG9vv9Y0u7UEmYayuW1YGl+pBW+pDbAdIzASuseNUGBFRbQJBUlyg0gSwm4wemqxZFflwEHemZkb3TLju+abDHw7OMfdiRWPyGNuqbC7Sq5Jjs0xvmqvTXXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WNNHF7lYyS2TBW5PE0cD9mT6hyb1l48RWryCsJHmME=;
 b=Qt2MVzxej4BwJNuu4E7L6ilDIkw/5DzRR9GciqY4KcPFXbTpWYqndXkE7+5aCzPYHjeUjE49pZQ/lUf04aiMamr3Wz8Mi5W/p2KnFu4F5RCtClL8e5jKNtNHehh1QREWwsDtTxY32ySjDQHIBbiUqvtDSH3l7i9IvAQdesh3bk0MyX0AIpDDRqidXAAT9qlQZr3iOQeMvjwBOyfj8xdjY8NBHARyrY0YT4B8wdRSI0R657qI2+SGB7KJl+hEsvF2lgTUt9bFEQHg2fknmGKCFOpUwB7bgyBgPm+VMTwU+yledxDatt49bPNgv4IuG//V99kf2BaGIH+NGX5b2c2lCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WNNHF7lYyS2TBW5PE0cD9mT6hyb1l48RWryCsJHmME=;
 b=koG6+8DHPaeWrBeEZRNwTdd6O9/0IHXLeMtC5ZNnvrkpJrI00GWOvqLosx1Hg2h1MIEbLY73q0kl/Dg8d1KFFHrJh/dBq0Od8yOMYJXZXQfrZ5gf7dueMNPjD2S8F1f08D6350+9IxvWcnIm6pTd86PMpVjOQ6K6FwJsdcEAhGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB3211.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:214::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:20:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:20:10 +0000
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
Subject: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table and PBA
Date: Mon, 31 Aug 2026 00:19:45 +0900
Message-ID: <20260830151948.3547577-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB3211:EE_
X-MS-Office365-Filtering-Correlation-Id: a324e9a1-cc4b-40ab-a3e0-08df06aa2e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|10070799003|366016|6133799003|10067099003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: dLsVeV6ltjDavMOEvjAcIRlVEDIehbasRSRMtJjqE5FU45wtknrC6CH8lEMHV/j6nPTs0mSz6abYHz7hm/YVIVKoqSQ1Fvhvd+s9oMYiEO3UW5O9oq8VFdI/6RGaG0ZXU/xgxwf1trx9tncXF1wxRXxqTn/GXE57I4zZsmLuIaBEQMK8jeBbp1qAJP5+8Gr4rfQG/6CWo0dC1kZp5X3T2OezVbrihE3TBWtjWlCzU0WmpI2TFrrM65TlL135sjCaItlGlPj5XRTMMihnLSnltpKfTL/FSCjY0oWp01gpSZEAcQNxVGtbJztSb4Mxzdd+Tuj96W9NjkWAAjWrxVujBEzLHnrCcmi7J6+c16H/ySGgg9aIP8FQ2rWKt+T9bUY7/9LhEvUwI1PlNsnxtj7hKKIKcLmc6sER2gkj4WCe8lAZrZCl2/DbfFBK172ZraovrHpfldp7HhA/Ecb5DMMLzwZu7KwiXPjjW4lXEl19GG4h2SqSoBoBIDbAdlFc1XZxLUzm3NYX4IuPiuynfaCwoD9DYMhNBWD3MST31xSi9YtMZ90Z6GPTN6TO8FXgw9x6qPaxal1VxQpWXiOFdHKoH0NSL5HbmVd+OSU44PeAFueDrB/LzfIQNRilLpG5bU0r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(10070799003)(366016)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4mbSsum2TIlpSaYuKK5Z9uGBvM2XW0d+mUcSvJMc2g9yAk0JBSZpQelPIbch?=
 =?us-ascii?Q?piwU8YxKdg+ZpJg7EbDwDN+CVo+KqtLPuSeUBys0boFJLZixeEwtW0l8EahT?=
 =?us-ascii?Q?OeQXe46p7Y+f72oQIff7t4C4DoeUW3dusZfudpoQ05EtwlTctlmptk2/zxiA?=
 =?us-ascii?Q?rnP+BzswYzLXtBajDN23iEm3HAk4i3cqEomiA1zODLwLXXoxBO0CIWLLE7ek?=
 =?us-ascii?Q?LTQ6EYY/KoFMS+KvDIfsAPkae+aWkQHCil+NBshgZBANfVq6++i99DNBZoMT?=
 =?us-ascii?Q?khSX6O/CiUjf1s5yR+jE806SPMkUD8O9cspUHUnlZ0+vlrnp1QsAj3urHWbx?=
 =?us-ascii?Q?EsMki/qi/TyIkWLsuJ8SWeywOwkotfpCY7Zy8hYywpY90uE1JRLVLLFy8ji5?=
 =?us-ascii?Q?E64FPPzenoWXC3aF6oQBViXDceE31PnrTt3yc79+yoSlDB8K/VyAnCHcRNYv?=
 =?us-ascii?Q?Ct9LjzZTRjNi3f3fJa2PftvOYA+AHfiYXxh3Rqtu3A9eg2Vx5Usrjr4mxwPr?=
 =?us-ascii?Q?1n9Qjl4X6BxFR1R4p1b/fgAqcWnYM8ym0QoYjdP1OqOw8V3JdgRIjhrs6HLt?=
 =?us-ascii?Q?nSOUB9+hkqEMweDK3H5hlEhK8Fs3BbG3qEjPusTxaQssmyj16ZC5w3YVWPHR?=
 =?us-ascii?Q?uGHR+gh6ZkkWVA3rdvEbz6lQJfmjX6v/JmEirHA+xde3FL1Q6WMBZVSlkd3r?=
 =?us-ascii?Q?KCGITYHDXxCBDyWwu9aqqDYqTNB3JR/YI5onSdag3jIPFDqhVPa45nL/+b0J?=
 =?us-ascii?Q?eEWrAIqdjqWVgs7NGGKXvorBgLvYn8uFczwNdg9z6vrXCDW5zQ8M0M/PEurG?=
 =?us-ascii?Q?RKCHXmtlplR+l2eAY/sfUdW9fHRN3SVfi+KyMrD+0EhpjRN6IlGUsXfmTC6K?=
 =?us-ascii?Q?X95P1HqZUyzZ4hC2UNKaXRsnxy5waTq7F89bnksyO/K7rjb8XC1CczlEpjjl?=
 =?us-ascii?Q?HDp0gN0PnzJx+QfBvSM4ObOb/XTmosKw69TFtIaIWfk11oIc9s1o8de5Id0g?=
 =?us-ascii?Q?trYHFO3v/2Ffg7f4+TnjY1GyoewA5MQL5x+nb6Fy1XolFwEGHwD9TLLHmj1M?=
 =?us-ascii?Q?tEZJPo8NQ/W3NxRpwBY4yQ38RBpM/pgNVTNz2uKWxsNIxy1xinHiM0pbal1F?=
 =?us-ascii?Q?pxNSBGbZtUN8S3KvfEhbRm3KqZfdPRh4Sw4s7Mkf2gHiwF/Hr7RYsOTrhZE2?=
 =?us-ascii?Q?z03jJ3ANOTqaTWTS2xug9vHC7LAEwFfVkS/jN2GmyXNbTEg+5g/JfEA/RjYZ?=
 =?us-ascii?Q?rbHUuX71ejGbxjsHc+ROcACCv/BVShNkiZY0IeeSKq1UesNZcbHeClste+rj?=
 =?us-ascii?Q?qZiimfEjWWOAjoUk8nE0TEJZ4a+Yr8gUXTHOiZEKf1r88otOIqnPmzh/ymk2?=
 =?us-ascii?Q?mR1hITiH0CahjOo8cYYBEoKLTSU9MV8F62lyxOSJT07kz9uEMYGSxfG1yYvy?=
 =?us-ascii?Q?36uE+rZcuEeGezQPM5rwvcN7PDYEFq5BAHZprCyuL6VLKTMad0jDIisWW0wz?=
 =?us-ascii?Q?Ww+rRgoptdnRURpDrsPpiw3Ecm2GXK3znD2pEhEpp0I3618DorUTkkxLy+cg?=
 =?us-ascii?Q?87iRdZyvU36NEtJ/SGfHdSNp+GslEXHkhutZdbbkra9ncCoPZcEppQx7AfOu?=
 =?us-ascii?Q?sDhYQrDLq98+E9dYx3JCErSwTAQ//27Nh3nkygIDv7vBWu/CPyetXMmTNhiz?=
 =?us-ascii?Q?1erjdkPgLbmaLfdJ4wFukdYX36mJ+ajBhH9H1mvSerMOSwhqQR+fd+CCVbrE?=
 =?us-ascii?Q?FIUIrkqc/aDqjq1bI3J7z8vYumRnRHy7Sv9dPpV1dxSWzS/1vLbT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a324e9a1-cc4b-40ab-a3e0-08df06aa2e6d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:20:10.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZib2Rvvx7SjfzHaeYtqubhfYgquM2HlnWEbR7LhQYlAZ2p/a7HLpswzE5lDvPxGqKrbzo2bQzO2DD0qifi0ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_082020_077146_C4E17EF2 
X-CRM114-Status: GOOD (  11.96  )
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

Hi,

Some DWC endpoint controllers keep the MSI-X Table and PBA at fixed
locations in a reserved BAR. On RK3588, the MSI-X doorbell uses this
hardware-owned layout, as discussed in e.g. [1].

The reserved-region types for the Table and PBA were added with the
Tegra194 description. The MSI-X setup API, however, still takes only the
Table BAR and offset and assumes that the PBA immediately follows it in
the same BAR.

This series passes the complete layout to pci_epc_set_msix() and adds
pci_epc_get_hw_msix_layout() to expose a hardware-owned layout. The core
does not select it automatically. The choice stays with the EPF.

A hardware-owned layout is not a direct replacement for every caller.
pci-epf-ntb, for example, reads host-programmed Table entries from its
own BAR to set up peer outbound mappings.

The series also fixes an interrupt-type mismatch in vNTB. ntb_hw_epf can
select MSI-X, while pci-epf-vntb currently configures and raises only
MSI. On RK3588, selecting the fixed BAR4 layout also selects the DWC
MSI-X doorbell. EPF-owned layouts continue to use the regular path.

In short:

- pci-epf-vntb gains MSI-X support and uses the hardware-owned layout
  when available.
- pci-epf-test, pci-epf-ntb, and the NVMe PCI EPF keep their EPF-owned
  layouts. This avoids unnecessary changes and reduces regression risk.
  They can use a hardware-owned layout later if/when needed.

[1] https://lore.kernel.org/r/aY2q80zeRKSRO21H@fedora

Best regards,
Koichiro
---
Changes in v2:
  - Return an error if the regular MSI-X helper is called for a
    hardware-owned layout. (Sashiko)
  - Collect Frank's Reviewed-by tag.

v1: https://lore.kernel.org/r/20260827182012.1984960-1-den@valinux.co.jp/


Koichiro Den (3):
  PCI: endpoint: Support hardware-owned MSI-X table and PBA
  PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
  PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

 drivers/nvme/target/pci-epf.c                 |  16 ++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |   9 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  30 +++++-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  28 ++++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  30 +++---
 drivers/pci/endpoint/functions/pci-epf-test.c |  17 +--
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  67 +++++++++---
 drivers/pci/endpoint/pci-epc-core.c           | 102 +++++++++++++++++-
 include/linux/pci-epc.h                       |  25 ++++-
 10 files changed, 268 insertions(+), 57 deletions(-)


base-commit: 0a6f72eda328c773324555491e1ad7f0b0153155
-- 
2.51.0


