Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072BFC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fx7O8dUmIpefc4EohRyosmoIs/jE5W6Q6kMcWP+Bd/o=; b=R24bt+gzNpvnxsVOT3dMOs2T1P
	h49PLE1klBRxRYxLxwxZhg/xUoeKSoUmLXH9XexUG0pbNjG4UmXld0TELCoPVVlVb/PP6+1rv315M
	cYXiZBqwYSfBksK7njx7SkH7UafeKL2jGE+u/JWvwi6yKwx5vFfG0NfTpq1GyDXtjWP0a6tM6V+Rf
	I2C1VUIm6stOGzgoBFTGGAsX3wSf6AEIz3IP1PT0XbE+OAPrfLQFXBAPOr4DpmHgKOk5F85qRvQxd
	+haiZQ8sMK6srjXyc4+JyfXCbn9pPqphBdv3Yt5S69v1XLxK1F5WxE0h3UAYzHPQeuAorG8kVGSCb
	xmc3kXnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFkO-0019yw-2w;
	Thu, 23 Mar 2023 07:52:32 +0000
Received: from mail-mw2nam12on2060e.outbound.protection.outlook.com ([2a01:111:f400:fe5a::60e] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFkL-0019xr-1p
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD0K7EFam6dM8V3R7lq0ElgboOZ7locD8jRFNGtbETMMPo901B8VUO3EDp5bU7zEUEa3tiEqPiTDUW4PRcCYEGub0HeTqEJwNJbbD6QpcanrcY6I1bYe3FuV0iuxoKGa6Fp1MFImSfneRiDDqBCPTcADRJDZRUz3Xtw1ZA2Vfpdcf8AJpY68aNnYGmJLXw9tP6bWNgGh0u0HxgxXlShq2yXs00WRRg5hkZaiX8xPHuxi1R1+iyDOsoA5LOk1a1FOTNLterLikSc6r9n6h3fmTuJaUMJQG0ht4VTjnfDcdtWNiOBAV13RjKxR8pHSWVaHQvAnD0J/I/eeXoouzQJmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx7O8dUmIpefc4EohRyosmoIs/jE5W6Q6kMcWP+Bd/o=;
 b=FuwB2QIfKl5ay7ru2misHAB0yPd0uXabmjTWvRA1BPOzcRYzd8Bg/n4Tmiii+GYSoSn/kWsLGSkzMErywiakAIAgcqs1k/77MUr9kQ/rNPfkgYj2sSXOBKm93zrfaUxRAwThiay/3280K88tsURWJGqQ2p4Ny5dCOrnlXX6FQzpjbiNenMR1SBEeaoo36oHISwiNFMtQHUUrDN0g9JBQtK2VIwj5KTvnIZ5bZFmhgj4A1IefomUbzgtn9BGJwwiWWBJosaf1E5LvvBYGmQ62Xn3vCRIhjM6dIjWfA3R947zGjf57KKSl3Il2UP2eXRi/RRUywTaDwDCPqEuTHgtMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx7O8dUmIpefc4EohRyosmoIs/jE5W6Q6kMcWP+Bd/o=;
 b=QygJTCO/Y3Dkl0BcDw+JgKRkOgKDnkXS31lJY4bN14f0ntVLLQTe16snJSaTLei1BagJpwxSyERj2Yys7gahAU5Z1MH6Dcv+X9UVe6+p/eS5tBv+8OG8JGM2zYgnPoakQg54o0FPhkiD8NslEP1GzmgdLBWUro+ZCB/M4yQooX50qwxSeoX+bAqc/h1ohzwiaQ2MHt+TOs6OJKIQgM0SXcbT6uGqpcgAu5pX3eKp/ZCv1lCf/cOkC/VFw8D4O3jVY8eJM584Sw9/sPa96bzJrbejXewqF+hoxBCqc1XJ1rKm+LF6GqI4lcg+Ir5RWsjT+5Pm8si9BXEvzAVS1dcApw==
Received: from CY5PR15CA0059.namprd15.prod.outlook.com (2603:10b6:930:1b::28)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Thu, 23 Mar 2023 07:52:24 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:1b:cafe::cb) by CY5PR15CA0059.outlook.office365.com
 (2603:10b6:930:1b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 07:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 07:52:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 00:52:12 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 00:52:11 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 0/7] nvmet: use centralize req completion for log
Date: Thu, 23 Mar 2023 00:51:56 -0700
Message-ID: <20230323075203.824096-1-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6747fd-9072-4bd0-4613-08db2b738a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	TaaFMtPRhwNo2NC+8gjN3qLVRVWC/JncSjNVIkkrh1JRpaqAputLgg8gvlPQd4hc7hommwAJMLYV2rC70RV6dqaTxEDAQtHU35n9xxSeICxZiKUobwZgAqQZgd6tiTWJ5FQIgDXh6995RoYvzyr24dODMpOhvU2c/fwsdPN14ymXX9yJFls7ZYWdSDoKDPyitM2lW3i+snu9Fm6PTrddM4edAZ7AGP5zno29JHdvgeK9nyrc4efdY/L3eu8q8lZqRdeH6SbKs4BNniz24+TwVEfoB4AuzfKNp4D2ovnLYUy9S2jAbEnS3tmStpX3MwSrCgj0+R/PPrxtT1B0K3EBekxj0BCFyFTdbKXwn1DWCJ4m8Kqnwe5GEjUNqbIIOLVva522dRyOgUiRl+2yHVyhtOpmToHDUlKLGhoVEa00fDxizOMG2EAd4Cr2/+pnGr4xN+A6IQf0QQrb0rJdHsD5CzZ6BTnaGPDp5c5Q08bEiZxyXmO0ysTXTLFCyzxNo2VP97N1fyJPGuRQjDpL1CuDM7QDWJvMwokUJE64sVbTCdO5KfPMayEn/kemAmlEsqS2DjvhxYgCfdVbh/h06iclwZFBeUolFum0QuuOv9IhIX8p+xLxSehcJAdoHFfoU+dRqsWxpCg2QddVeUtd26Ax9eHtrKXySLMMJecIKQQJgcerUfz315Un2cFKFpFcchYeW7q9GlEPeUEkVudKU+ChN3tVyrnMXlMrzYbJC+jokLsyeWd8Xrgf50p9K+tGgm0X
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(186003)(1076003)(26005)(47076005)(7696005)(426003)(2616005)(54906003)(316002)(478600001)(83380400001)(16526019)(82740400003)(336012)(107886003)(6666004)(4326008)(6916009)(8936002)(70206006)(41300700001)(36860700001)(70586007)(8676002)(30864003)(40460700003)(5660300002)(36756003)(2906002)(356005)(82310400005)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:52:24.3713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6747fd-9072-4bd0-4613-08db2b738a50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005229_647736_4E24A064 
X-CRM114-Status: GOOD (  10.59  )
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

There is a repeated call for nvmet_req_complete() in :-
nvmet_execute_get_log_page_error()
nvmet_execute_get_log_page_smart()
nvmet_execute_get_log_page_noop()
nvmet_execute_get_log_changed_ns(),
nvmet_execute_get_log_cmd_effects_ns() 
nvmet_execute_get_log_page_ana()

Instead of repeating the call in the current log pages (6) use
the nvmet_req_completion() call in the caller function
nvmet_execute_get_log_page().

Note that this is not the new pattern it is similar to what we have done
it for nvmet_set_features(), nvmet_get_features() and their respective
feature handlers.

This series is passing basic get-log page and blktests as below.

I've one more series in this area, please wait for any other cleanup
in this area.

-ck

Chaitanya Kulkarni (7):
  nvmet: prep to callers req completion for log
  nvmet: centralize req completion for err log
  nvmet: centralize req completion for smart log
  nvmet: centralize req completion for noop log
  nvmet: centralize req completion for change ns
  nvmet: centralize req completion for effects log
  nvmet: centralize req completion for ana log

 drivers/nvme/target/admin-cmd.c | 73 ++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 34 deletions(-)

1. Manual execution of the log pages err, smart, fw-log,
   changed-ns, effects-ns, ana :- 
[16817.567503] nvmet: creating nvm controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:e78b2b4f-b1dc-4266-95ea-854fcec1738b.
[16817.567608] nvmet: nvmet_execute_get_log_cmd_effects_ns 203
[16817.567611] nvmet: nvmet_execute_get_log_cmd_effects_ns 228
[16817.567621] nvmet: nvmet_execute_get_log_page_ana 290
[16817.567625] nvmet: nvmet_execute_get_log_page_ana 322
[16817.567632] nvmet: nvmet_execute_get_log_page_smart 142
[16817.567638] nvmet: nvmet_execute_get_log_page_smart 165
[16817.567666] nvme nvme1: creating 48 I/O queues.
[16817.571704] nvme nvme1: new ctrl: "testnqn"
nvme (nvme-6.4) # echo 0 > /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1/enable 
nvme (nvme-6.4) # echo 1 > /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1/enable 
nvme (nvme-6.4) # nvme fw-log /dev/nvme1n1 
Firmware Log for device:nvme1n1
afi  : 0
nvme (nvme-6.4) # echo $?
0
nvme (nvme-6.4) # nvme error-log /dev/nvme1n1 > /dev/null 
nvme (nvme-6.4) # echo $?
0
nvme (nvme-6.4) # dmesg  -c 
[16832.390334] nvme nvme1: rescanning namespaces.
[16832.390346] nvmet: nvmet_execute_get_log_changed_ns 238
[16832.390351] nvmet: nvmet_execute_get_log_changed_ns 254
[16836.279322] nvme nvme1: rescanning namespaces.
[16836.279350] nvmet: nvmet_execute_get_log_changed_ns 238
[16836.279355] nvmet: nvmet_execute_get_log_changed_ns 254
[16849.107716] nvmet: nvmet_execute_get_log_page_noop 45
[16859.728750] nvmet: nvmet_execute_get_log_page_error 51
[16859.728763] nvmet: nvmet_execute_get_log_page_error 73

2. 
blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime    ...  20.017s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.083s  ...  10.110s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.450s  ...  1.434s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.794s  ...  1.776s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.070s  ...  0.067s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.028s  ...  0.028s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.469s  ...  1.480s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.452s  ...  1.497s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  86.116s  ...  85.324s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  70.376s  ...  78.223s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  73.964s  ...  73.261s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  67.237s  ...  67.202s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.229s  ...  4.178s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.749s  ...  3.711s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  13.430s  ...  13.294s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  13.388s  ...  13.481s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.434s  ...  1.434s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.446s  ...  1.455s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.429s  ...  1.419s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.428s  ...  1.446s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.790s  ...  1.762s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.468s  ...  1.445s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.433s  ...  1.438s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.411s  ...  1.423s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.424s  ...  1.428s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.476s  ...  1.426s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.427s  ...  1.425s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.550s  ...  1.568s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.225s  ...  0.222s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  4.058s  ...  3.986s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.012s  ...  0.011s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  8.056s  ...  7.861s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.713s  ...  0.711s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.688s  ...  4.685s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  3.203s  ...  3.147s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.657s  ...  1.712s
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.953s  ...  3.980s
blktests (master) # nvme_trtype=tcp ./check nvme
nvme/002 (create many subsystems and test discovery)         [not run]
    runtime  20.017s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.110s  ...  10.123s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.434s  ...  1.138s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.776s  ...  1.202s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.067s  ...  0.064s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.028s  ...  0.038s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.480s  ...  1.154s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.497s  ...  1.129s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  85.324s  ...  90.112s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  78.223s  ...  79.330s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  73.261s  ...  77.092s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  67.202s  ...  63.555s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.178s  ...  3.822s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.711s  ...  3.433s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  13.294s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  13.481s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.434s  ...  1.119s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.455s  ...  1.139s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.419s  ...  1.115s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.446s  ...  1.117s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.762s  ...  1.160s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.445s  ...  1.147s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.438s  ...  1.107s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.423s  ...  1.108s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.428s  ...  1.113s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.426s  ...  1.122s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.425s  ...  1.126s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.568s  ...  1.258s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.222s  ...  0.118s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.986s  ...  0.820s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.011s  ...  0.014s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.861s  ...  7.334s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.711s  ...  0.418s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.685s  ...  2.533s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  3.147s  ...  0.695s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.712s  ...  1.068s
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.980s  ...  3.739s
blktests (master) # 


-- 
2.29.0


