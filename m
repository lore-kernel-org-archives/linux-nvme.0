Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4254C77B7F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 May 2023 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kI0/HvN8bWzzOa7OKU2SXhVPp7OGzQLe1pbDbxD2SEI=; b=cE90xrWbdtg47NDo41QAEscfKs
	tMNYz+WumcycZMDIghAIx+lDvZWNdyhXQImxcPBmpAH+eRx8dMK2RHivDOnNiPrbRuDeaoQyltqyO
	YVz6mYoYrg0KwFI/d5PLU7wvrNoxbUEFuD30qptUVHhFvgq1X7kx75bJWGljvNWLdLFSODQCGLQrP
	hmNs41sJBTlAac/+uhrpJA9aTMQneczy+hbzh4YTDeci4VjEDnisNkHunI7IjFWTuyTweHAPpohQ6
	CwVy+LHIEJ2WY4xLDCBvLcAaPGrQZkIBVI9HljldUJtAGDVuMuImD/WUHMRfDnfdOWGdRn022uQKs
	Xp7ygzNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyrZi-005BrW-06;
	Tue, 16 May 2023 10:06:34 +0000
Received: from mail-dm3nam02on20626.outbound.protection.outlook.com ([2a01:111:f400:7e83::626] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyrZe-005BqV-2C
	for linux-nvme@lists.infradead.org;
	Tue, 16 May 2023 10:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhtNhZpVhQZ4KiXlWJT3Ek4lec/pY8kioykGl4sWQvoFuL2gxA4VXsdTonAF/7BfQ/8dskMNX9q+Pky8zxXfjXGN2bKetjsBNbSaq02vojJkAydJ9ejk7MQVlzjCdVTGUjwkhl6gLzlEATnW7iDN0dMoLGOc21kKFQfK5d4gM/5TUueTTkPwshESXyCPrGvZp0cwYvZjWlAK/UGwmuPxofJ/gqQjI2vUgBpWBvEIFgwt9OCCOI2WQvIRfBNGTYOy6JnPW/WAnzcnndwMRFSJs0D0/m57+D0GZvEHacwRjFNZmqMyz7nkwAl2F6P4D2RhbHM/sIMB2v55PAbd6HJHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI0/HvN8bWzzOa7OKU2SXhVPp7OGzQLe1pbDbxD2SEI=;
 b=ZThOlet/DPeQyFl3n/EYKqGEAkrporJ95yIWIs2zKHRLmpMSpuGhlka5gWcg0/JGLMMywQScyI/20D4ca/lrqKGaF7yc207lJlLiiLdNmrhYHu+LufzgDq++7H1m6+vV99+dxp0LguGhV3iEmQpS5ol/LgZmFnltREienOmu/YgurensptR3vkN74gzQgy5oQfq7xSs4LjDSbkTwA/KAfYZcXJHoGlIoQrJF6nw0Gda0eNJefCxbcV/bo/NI/Tmr0FDpl563hqZoVVO+5O+JvkWGZC0GOrFA1AZIptdcxr4WmDNIx0/J2kIOvuv3P1UhlZk5kXOypYOD2ONb/mLVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI0/HvN8bWzzOa7OKU2SXhVPp7OGzQLe1pbDbxD2SEI=;
 b=If8WJnFemKLBBJsphOiQ+fCRDAelcRfsDqvjZJL0L7WiHDCQf5iHy+vNei2jbR3Ox/4G56tXy3g5a6pLq5lzznRzv/s1qkiaBRNoK2RtRM92SENwuUUcX6ndptK1O8GnZEBdLajywNCqWu+YAIe9mKQY08Ip9AEZ2R8nNJIVyLMwC/lJgv93L6WnpD9EzKHklAAmhNJVi0l4xPn9iRx8mDQgiq9v05M618ZeyuNKIeLUgRdbUryiMIgtN7677e64AeMDV1mcuCZi1zOfVfgpBkHPZLdbFUEN3W5b7JgpLSK6mldfnAkawtVlHrW3SbzUdFqP8QmgjJs+HycytCwV/A==
Received: from BYAPR07CA0030.namprd07.prod.outlook.com (2603:10b6:a02:bc::43)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 10:06:26 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:bc:cafe::6) by BYAPR07CA0030.outlook.office365.com
 (2603:10b6:a02:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 10:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:06:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 16 May 2023
 03:06:14 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 16 May
 2023 03:06:13 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/3] nvme-core: dhchap_secret code cleanup
Date: Tue, 16 May 2023 03:06:02 -0700
Message-ID: <20230516100605.53712-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fe889d-cdb9-4331-32cf-08db55f5359b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	O64iLBYqMvnrzrnSEf8iYL77yhdNOvK4BmqLYCsawJ3pPbxAuVwxlnY0k0Jxj2VVCrvSnyMvjadv8CAjiWCagE55sH5wSsIhTTGoohkjUL7ncpBzIGbBYWdct+5AJxU7kkEUsJFv4+Zsx2/PR6hsC4uI+P2QCOpndCsJfX8dePv52gj/mAbajMzAnYo2fDvA58Um0b9x13cIHGtfntPIreCGNzNXCYT1MdlQpFqpringw07EOAO7DKlpoFWGq/3MMa2S78tdmz+wfKKI3lwc48vT0XQQbgiIt/mkD8SxHnenlUqLmkuASKeGaPgxb3neBu8bQO/0KNq+WPktiTTGRnBegnZEvd9TvHwRBsG/UzIwGyhmPE/C0MHVrbidjyJxwmi856r1ZpYsN0onKgR47Ea/Mg0qhKb4qzYzrQMIfGUNFsac0ZWAK6If2Euy11NYpIALO1S5UZYanIuVtMWaJbm99WwZrn1YuGatGAKQoZlOwRzkH3kgdNgOK3h9WifXWDL0j43NOlbHuGb7G1i4aZ7BwVq03NkKOLHLGUqEDFOcaYQCRIGkfF6dRNleDZXMw0+5iAWSb4ybRu3rF8PDRTbacA36P1wsxaN5e54yqYAztCkGsWsiXSTtx7KzzmFpSoYBXtqciuDYshhj4h1JyWJmrDXJeeHApGkA/LWkK+NcPszw1waA80sY3+xCSkTNv2rfiHRFJk8S5BKKbwmhuVp8VwM8te2DLhC4UIKTMpxHJvleTx+ed+IdnPuaT3yeBq7zScID4gg4sIf0f70QFA==
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(356005)(2616005)(26005)(107886003)(36860700001)(82740400003)(7636003)(336012)(426003)(47076005)(186003)(1076003)(83380400001)(16526019)(40480700001)(2906002)(8676002)(41300700001)(5660300002)(8936002)(36756003)(478600001)(7696005)(70586007)(70206006)(6666004)(6916009)(316002)(82310400005)(40460700003)(54906003)(4326008)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:06:25.6206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fe889d-cdb9-4331-32cf-08db55f5359b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_030630_766684_50F121DC 
X-CRM114-Status: GOOD (  11.18  )
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

Refactor code to avoid duplication and improve maintainability:

Consolidate the shared code between the functions
nvme_ctrl_dhchap_secret_store() and
nvme_ctrl_dhchap_ctrl_secret_store(). This duplication not only
increases the likelihood of bugs but also requires additional effort for 
maintenance and testing.

Introduce a new generic helper function called
nvme_dhchap_secret_store_common() to handle the storage of the
dhchap secret. This helper function will be used by both
nvme_ctrl_dhchap_secret_store() and
nvme_ctrl_dhchap_ctrl_secret_store().

Lastly create a macro to define dhchap attr to remove attribute code
duplication altogether for dhchap secret and dhchap ctrl secret.

Below are the blktests results.

Full disclosure checkpatch has following warning :-

WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
#62: FILE: drivers/nvme/host/sysfs.c:485:

I purposly did not fix it in this series, I'll send out a separate
fix for that if there is no objection.

-ck

RFC->V1:
1. don't use double pointer based approach use bool instead. (Hannes)

Chaitanya Kulkarni (3):
  nvme: add generic helper to store secret
  nvme: use generic helper to store ctrl secret
  nvme-core: use macro defination to define dev attr

 drivers/nvme/host/sysfs.c | 145 +++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 90 deletions(-)

Following are the blktests results for nvme-loop and nvme-tcp :-
blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  18.996s  ...  19.272s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.085s  ...  10.107s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.453s  ...  1.440s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.803s  ...  1.773s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.056s  ...  0.060s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.034s  ...  0.032s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.452s  ...  1.464s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.425s  ...  1.461s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  88.076s  ...  87.321s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  71.957s  ...  63.395s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  74.016s  ...  82.918s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  74.105s  ...  63.881s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.089s  ...  4.088s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.703s  ...  3.725s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  12.407s  ...  12.628s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  12.318s  ...  12.614s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.411s  ...  1.429s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.434s  ...  1.449s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.435s  ...  1.424s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime    ...  1.421s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.351s  ...  1.748s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.314s  ...  1.440s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.284s  ...  1.425s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.281s  ...  1.422s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.282s  ...  1.426s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.284s  ...  1.439s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.278s  ...  1.445s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.605s  ...  1.558s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.287s  ...  0.216s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  1.458s  ...  4.031s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.050s  ...  0.013s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.402s  ...  7.902s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  1.148s  ...  0.747s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  7.215s  ...  4.824s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  1.338s  ...  7.028s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.513s  ...  1.858s
nvme/045 (Test re-authentication)                            [passed]
    runtime  5.721s  ...  4.062s
nvme/047 (test different queue types for fabric transports)  [not run]
    runtime  2.288s  ...  
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    runtime  5.590s  ...  
    nvme_trtype=loop is not supported in this test
blktests (master) # nvme_trtype=tcp; ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  19.272s  ...  19.055s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.107s  ...  10.115s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.440s  ...  1.430s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.773s  ...  1.790s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.060s  ...  0.052s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.032s  ...  0.028s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.464s  ...  1.460s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.461s  ...  1.426s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  87.321s  ...  84.286s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  63.395s  ...  66.071s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  82.918s  ...  76.218s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  63.881s  ...  71.368s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.088s  ...  4.205s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.725s  ...  3.734s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  12.628s  ...  12.542s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  12.614s  ...  12.699s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.429s  ...  1.444s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.449s  ...  1.439s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.424s  ...  1.427s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.421s  ...  1.420s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.748s  ...  1.774s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.440s  ...  1.442s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.425s  ...  1.424s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.422s  ...  1.436s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.426s  ...  1.416s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.439s  ...  1.429s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.445s  ...  1.421s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.558s  ...  1.552s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.216s  ...  0.226s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  4.031s  ...  3.913s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.013s  ...  0.013s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.902s  ...  7.893s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.747s  ...  0.748s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.824s  ...  4.817s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  7.028s  ...  3.180s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.858s  ...  1.850s
nvme/045 (Test re-authentication)                            [passed]
    runtime  4.062s  ...  4.039s
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    nvme_trtype=loop is not supported in this test
-- 
2.40.0


