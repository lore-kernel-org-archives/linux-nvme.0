Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1528C48260
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 06:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tLMN4QwtZhL2PbIpQ+sVrDN2gSRghxaZkKlOpZncBvE=; b=AM037h0Ze5xVv/E4BtYGqOdEik
	J5+na4n+DJJyPuWVySpUDdhVuWKV2cEXTnehq/SU+vzLpIsCVqPW94n8MMFgUos+BrSc77s9J2mTZ
	vWDjuyudApzpr/3UZUEbuUMLjXFzH68bCUUBLzTzGRwIhSRVMNGqMQ5mWCCWI+fkFmVidfa+YzAtX
	eTfwKa5sY8Qqj7eJNuMItFq4qn50/KpWmnOXUh04P6hUOvWkXX09WUQOxj2tUzASd5ilNL7tRwZz9
	AMg0Lesn4dpKqd8WaCbyqdqFdfI0+q0n2kFvhcay3ND6vKqvLqikrF7tUJvMk6QtTAscVD7xtc/cJ
	OVnQdPRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXxqP-0000000CnH8-48Qt;
	Thu, 08 Feb 2024 06:25:09 +0000
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:200a::601] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXxqK-0000000CnEM-1FAJ
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 06:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXYNnCt10IIkcIEjI3iGhyiyr9muUQWHezCRbeEVX+gzpinSuJhAawWNBEmGF+A8YodqPbCP+c96z4BcMISD1CxexCLThgTAwVbHhK9gdp2JrxLllHo4qXgbN88BecMOnQTR3qTfi/2VASva8l0iqzGD2lXunCpxJyZVyOWm2OPhofy1X930JJeDJhEKq4mY71eAuC2aO0QnrUfvqoc3OxKJPKFGCevkLhMym89cLK83FegbOYGuLWI0wKc3qYWpytAI07Sr1dsqi/SJUrFyJYwO4Rj8gntKxVMvVZpn6VIlJPJSCJNf998OPJYe5t7oKs+rqtKNS0FFZfyn3ibcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLMN4QwtZhL2PbIpQ+sVrDN2gSRghxaZkKlOpZncBvE=;
 b=USWLlhrEqzmfAgPgvweljFNzS8Jb0MIQUjJtPecJzazDQ03mgBNJiYNmEWWJh906rIGhFLkt6xBBdvy8rZT33HFYOU1oe8RYzau0j/VGHniVU2/c+G9v0ddEcn1ma7hzZhmoU+uDZ7uwvPdthklGsguEmZdIBX301EanQAEONIoPDyWcSWUmyM4gXkpOuEYBWmLsMBeLdBAJR/G0gv7tzxkqmV1a95ngQYrPf3VZ920i6Fe6GXBF2pb3HYlbXIQCCCzA0qiw0DjPX3R2G59z9Xd42Vo/EvHrUjTIuIiHRvpLrbeyxGgg6VWTX67kwJzJnk3y5Z2P04CMRsRorVDBBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLMN4QwtZhL2PbIpQ+sVrDN2gSRghxaZkKlOpZncBvE=;
 b=Qns6Qu7D9RgHErvx722bBkitYiQZpjzU1+7/rIxS1EBuOxRVEXerK/4Q6rk+BM51KSaTI00y+/qNB7KfYXvDzJsRhcnCmUTxHlxRx9EbbnmLJ2blrGCmEi/Ly4eSQ8GSQ0rwtwc1wpayBwK7lqHpxLSpcyZxLnyE80qplXWqUOJ9OA2/X0QWRiBWRJaqXdU4eEBML6eB/e7v8KVc2jiJgJYpBTO7VOdYTYKc1ed6FwQiUMoJpu+yq5LV5BP4y72SviTZ0oMYsFSP9E7SUJ5kWb8g8kbVSZ9ZS1GD1TwIqM0gV4TLSgoCs20oypCzo8PtC6iattjIQVCZnB/SbNKWBg==
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 06:24:52 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::27) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Thu, 8 Feb 2024 06:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 06:24:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 22:24:35 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 7 Feb
 2024 22:24:34 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/3] nvme-fabrics: add post connect auth code helper
Date: Wed, 7 Feb 2024 22:24:24 -0800
Message-ID: <20240208062427.31255-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: a3488b89-c9cd-4e85-94e4-08dc286ea86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCOthTXC2RFSa3GN+5ViVZHRLC3jpJI4KUcc1C0DHWEFMnhKH0GyS1ks+Xks/XUktMYBldICHPfF3t4O9r8DVyLwTDxwibm4npLgzmiTZn/3L+9JzgsoVze5QgeBlSuNaKMvTn+QclFA+TjbxDL9jxLX7CAe6sXNCohaNCjElvoOjIKnNAtE0rbkJ6cUVCNvpwlV9MCT3/1wQEbvLfnKU2CGozky9vnzUUk7Ej01IhdtdFVnabAXLJGV3ao49XlxTnwOL60uU81FIh93J/RiNH65gNDTwHbLuh571gnyPnbne/adYFEQqJW9wYI8LPkdJaHAd7albqHnuyvbtrQb5cxvwqKG2LEqK2Q1F/UwcXcvB0zy10yHuV6u45hhBW+2RlRC+Ca8omoTtwKuoeXGu71CapqF75Bo5mbwuAVYzW5klp5YIkb65n5jzCgArFyY6j1FjA93cHCSo9UXBSIQJ/p/5zaP0AT7GTUX7K5EtDicGhs1jU8Hu+lPY5fMUK5n7GGoAVilntY2HPtlBbkAIs69m4MAzW7fVjuVC50Q10wWqrd/crb+pq1QfVDINrBmXbHCMARtktYzgPUnaA852YGkTdonGoVfU59nhl6abM0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(7696005)(6666004)(426003)(336012)(16526019)(107886003)(1076003)(2616005)(5660300002)(30864003)(70586007)(6916009)(36756003)(8936002)(4326008)(316002)(70206006)(54906003)(26005)(8676002)(2906002)(478600001)(41300700001)(7636003)(356005)(83380400001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 06:24:51.5407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3488b89-c9cd-4e85-94e4-08dc286ea86c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_222504_464184_BD1EE02B 
X-CRM114-Status: GOOD (  10.01  )
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

Post connect command authentication handling code is repeated into in
nvmf_connect_admin_queue() and nvmf_connect_io_queue(). Moreover this
code actully belongs to authentication and should not be a part of
common code.

Add a helper to handle post connect command authentication. Use the
same helper in nvmf_connect_[admin|io]_queue(). This also removes
authentication specific code from a build where authentication feature
is not configured.

I've tested the code with and without NVME_AUTH configured with blktests
they are passing. Below is a detailed log.

-ck

Chaitanya Kulkarni (3):
  nvme-fabrics: factor out auth code into helper
  nvme-fabrics: use post connect auth helper
  nvme-auth: unexport negotiate and wait functions

 drivers/nvme/host/auth.c    | 38 +++++++++++++++++++++++++---
 drivers/nvme/host/fabrics.c | 50 ++-----------------------------------
 drivers/nvme/host/nvme.h    | 16 ++++++------
 3 files changed, 43 insertions(+), 61 deletions(-)

Test Log :-

=======================================================================
* With NVME_AUTH Disabled :-

-----------------------------------------------------------------------
nvme (nvme-6.8) # git am p/nvme-fabrics-auth-post-connect/*patch 
Patch is empty.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To record the empty patch as an empty commit, run "git am --allow-empty".
To restore the original branch and stop patching, run "git am --abort".
nvme (nvme-6.8) # git am --skip 
Applying: nvme-fabrics: factor out auth code into helper
Applying: nvme-fabrics: use post connect auth helper
Applying: nvme-auth: unexport negotiate and wait functions
-----------------------------------------------------------------------
nvme (nvme-6.8) # grep NVME_AUTH .config
nvme (nvme-6.8) #
-----------------------------------------------------------------------
nvme (nvme-6.8) # ./compile_nvme.sh 
++ nproc
+ make -j 48 M=drivers/nvme/target/ clean
++ nproc
+ make -j 48 M=drivers/nvme/host/ clean
++ nproc
+ make -j 48 M=drivers/nvme/ modules
  CC [M]  drivers/nvme/host/core.o
  CC [M]  drivers/nvme/host/ioctl.o
  CC [M]  drivers/nvme/target/core.o
  CC [M]  drivers/nvme/host/sysfs.o
  CC [M]  drivers/nvme/target/configfs.o
  CC [M]  drivers/nvme/host/pr.o
  CC [M]  drivers/nvme/target/admin-cmd.o
  CC [M]  drivers/nvme/host/constants.o
  CC [M]  drivers/nvme/target/fabrics-cmd.o
  CC [M]  drivers/nvme/host/trace.o
  CC [M]  drivers/nvme/target/discovery.o
  CC [M]  drivers/nvme/host/multipath.o
  CC [M]  drivers/nvme/target/io-cmd-file.o
  CC [M]  drivers/nvme/host/zns.o
  CC [M]  drivers/nvme/target/io-cmd-bdev.o
  CC [M]  drivers/nvme/host/fault_inject.o
  CC [M]  drivers/nvme/target/passthru.o
  CC [M]  drivers/nvme/host/hwmon.o
  CC [M]  drivers/nvme/target/zns.o
  CC [M]  drivers/nvme/target/trace.o
  CC [M]  drivers/nvme/host/pci.o
  CC [M]  drivers/nvme/host/fabrics.o
  CC [M]  drivers/nvme/target/loop.o
  CC [M]  drivers/nvme/target/rdma.o
  CC [M]  drivers/nvme/host/rdma.o
  CC [M]  drivers/nvme/target/fc.o
  CC [M]  drivers/nvme/host/fc.o
  CC [M]  drivers/nvme/host/tcp.o
  CC [M]  drivers/nvme/target/fcloop.o
  CC [M]  drivers/nvme/target/tcp.o
  LD [M]  drivers/nvme/target/nvme-loop.o
  LD [M]  drivers/nvme/host/nvme-fabrics.o
  LD [M]  drivers/nvme/target/nvme-fcloop.o
  LD [M]  drivers/nvme/target/nvmet.o
  LD [M]  drivers/nvme/target/nvmet-fc.o
  LD [M]  drivers/nvme/target/nvmet-rdma.o
  LD [M]  drivers/nvme/target/nvmet-tcp.o
  LD [M]  drivers/nvme/host/nvme-rdma.o
  LD [M]  drivers/nvme/host/nvme.o
  LD [M]  drivers/nvme/host/nvme-fc.o
  LD [M]  drivers/nvme/host/nvme-tcp.o
  LD [M]  drivers/nvme/host/nvme-core.o
  MODPOST drivers/nvme/Module.symvers
  CC [M]  drivers/nvme/common/nvme-keyring.mod.o
  CC [M]  drivers/nvme/host/nvme-core.mod.o
  CC [M]  drivers/nvme/host/nvme.mod.o
  CC [M]  drivers/nvme/host/nvme-fabrics.mod.o
  CC [M]  drivers/nvme/host/nvme-rdma.mod.o
  CC [M]  drivers/nvme/host/nvme-fc.mod.o
  CC [M]  drivers/nvme/host/nvme-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  LD [M]  drivers/nvme/host/nvme-fabrics.ko
  LD [M]  drivers/nvme/common/nvme-keyring.ko
  LD [M]  drivers/nvme/host/nvme.ko
  LD [M]  drivers/nvme/host/nvme-fc.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/host/nvme-core.ko
  LD [M]  drivers/nvme/host/nvme-rdma.ko
  LD [M]  drivers/nvme/host/nvme-tcp.ko
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/host/ /lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/target//
/lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/host/:
total 868K
-rw-r--r--. 1 root root 404K Feb  7 21:55 nvme-core.ko
-rw-r--r--. 1 root root  56K Feb  7 21:55 nvme-fabrics.ko
-rw-r--r--. 1 root root 112K Feb  7 21:55 nvme-fc.ko
-rw-r--r--. 1 root root 114K Feb  7 21:55 nvme.ko
-rw-r--r--. 1 root root  88K Feb  7 21:55 nvme-rdma.ko
-rw-r--r--. 1 root root  91K Feb  7 21:55 nvme-tcp.ko

/lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/target//:
total 672K
-rw-r--r--. 1 root root  59K Feb  7 21:55 nvme-fcloop.ko
-rw-r--r--. 1 root root  36K Feb  7 21:55 nvme-loop.ko
-rw-r--r--. 1 root root  82K Feb  7 21:55 nvmet-fc.ko
-rw-r--r--. 1 root root 330K Feb  7 21:55 nvmet.ko
-rw-r--r--. 1 root root  83K Feb  7 21:55 nvmet-rdma.ko
-rw-r--r--. 1 root root  76K Feb  7 21:55 nvmet-tcp.ko
+ sync


-----------------------------------------------------------------------

nvme (nvme-6.8) # cdblktests 
blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  23.465s  ...  23.259s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  11.270s  ...  11.266s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  0.497s  ...  0.486s
nvme/005 (reset local loopback target)                       [passed]
    runtime  0.823s  ...  0.814s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.091s  ...  0.100s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.065s  ...  0.064s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.473s  ...  0.494s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  0.469s  ...  0.478s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  47.916s  ...  33.407s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  119.908s  ...  164.147s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  52.679s  ...  54.561s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  124.248s  ...  113.872s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  8.983s  ...  8.090s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  6.830s  ...  6.528s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  12.838s  ...  12.955s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  14.244s  ...  14.219s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  0.480s  ...  0.467s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  0.502s  ...  0.492s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  0.453s  ...  0.465s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  0.455s  ...  0.465s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  0.848s  ...  0.816s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  0.497s  ...  0.492s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  0.465s  ...  0.471s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  0.472s  ...  0.455s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  0.463s  ...  0.461s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  0.469s  ...  0.476s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  0.473s  ...  0.467s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  0.650s  ...  0.641s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.262s  ...  0.240s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  4.253s  ...  4.202s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.020s  ...  0.019s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.214s  ...  7.094s
nvme/041 (Create authenticated connections)                  [not run]
    runtime  1.943s  ...  
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/042 (Test dhchap key types for authenticated connections) [not run]
    runtime  5.685s  ...  
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/043 (Test hash and DH group variations for authenticated connections) [not run]
    runtime  25.815s  ...  
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/044 (Test bi-directional authentication)                [not run]
    runtime  4.107s  ...  
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/045 (Test re-authentication)                            [not run]
    runtime  1.689s  ...  
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    nvme_trtype=loop is not supported in this test
blktests (master) # 

=======================================================================
* With NVME_AUTH enabled :-

-----------------------------------------------------------------------
nvme (nvme-6.8) # gitlog -3
d87a49459fec (HEAD -> nvme-6.8) nvme-auth: unexport negotiate and wait functions
07d1e5bc0664 nvme-fabrics: use post connect auth helper
1c6fad4ff587 nvme-fabrics: factor out auth code into helper
nvme (nvme-6.8) # 

-----------------------------------------------------------------------
nvme (nvme-6.8) # grep NVME_AUTH .config
CONFIG_NVME_AUTH=m
nvme (nvme-6.8) # 

-----------------------------------------------------------------------
nvme (nvme-6.8) # ./compile_nvme.sh
++ nproc
+ make -j 48 M=drivers/nvme/target/ clean
++ nproc
+ make -j 48 M=drivers/nvme/host/ clean
++ nproc
+ make -j 48 M=drivers/nvme/ modules
  CC [M]  drivers/nvme/target/core.o
  CC [M]  drivers/nvme/host/core.o
  CC [M]  drivers/nvme/host/ioctl.o
  CC [M]  drivers/nvme/target/configfs.o
  CC [M]  drivers/nvme/host/sysfs.o
  CC [M]  drivers/nvme/target/admin-cmd.o
  CC [M]  drivers/nvme/host/pr.o
  CC [M]  drivers/nvme/target/fabrics-cmd.o
  CC [M]  drivers/nvme/host/constants.o
  CC [M]  drivers/nvme/target/discovery.o
  CC [M]  drivers/nvme/host/trace.o
  CC [M]  drivers/nvme/target/io-cmd-file.o
  CC [M]  drivers/nvme/target/io-cmd-bdev.o
  CC [M]  drivers/nvme/host/multipath.o
  CC [M]  drivers/nvme/target/passthru.o
  CC [M]  drivers/nvme/target/zns.o
  CC [M]  drivers/nvme/target/fabrics-cmd-auth.o
  CC [M]  drivers/nvme/host/zns.o
  CC [M]  drivers/nvme/host/fault_inject.o
  CC [M]  drivers/nvme/target/auth.o
  CC [M]  drivers/nvme/host/hwmon.o
  CC [M]  drivers/nvme/target/trace.o
  CC [M]  drivers/nvme/host/pci.o
  CC [M]  drivers/nvme/host/auth.o
  CC [M]  drivers/nvme/target/rdma.o
  CC [M]  drivers/nvme/target/loop.o
  CC [M]  drivers/nvme/host/fabrics.o
  CC [M]  drivers/nvme/target/fc.o
  CC [M]  drivers/nvme/host/rdma.o
  CC [M]  drivers/nvme/target/fcloop.o
  CC [M]  drivers/nvme/target/tcp.o
  CC [M]  drivers/nvme/host/fc.o
  CC [M]  drivers/nvme/host/tcp.o
  LD [M]  drivers/nvme/target/nvme-loop.o
  LD [M]  drivers/nvme/host/nvme-fabrics.o
  LD [M]  drivers/nvme/target/nvme-fcloop.o
  LD [M]  drivers/nvme/target/nvmet.o
  LD [M]  drivers/nvme/target/nvmet-fc.o
  LD [M]  drivers/nvme/target/nvmet-rdma.o
  LD [M]  drivers/nvme/host/nvme-fc.o
  LD [M]  drivers/nvme/target/nvmet-tcp.o
  LD [M]  drivers/nvme/host/nvme.o
  LD [M]  drivers/nvme/host/nvme-rdma.o
  LD [M]  drivers/nvme/host/nvme-tcp.o
  LD [M]  drivers/nvme/host/nvme-core.o
  MODPOST drivers/nvme/Module.symvers
  CC [M]  drivers/nvme/common/nvme-auth.mod.o
  CC [M]  drivers/nvme/common/nvme-keyring.mod.o
  CC [M]  drivers/nvme/host/nvme-core.mod.o
  CC [M]  drivers/nvme/host/nvme.mod.o
  CC [M]  drivers/nvme/host/nvme-fabrics.mod.o
  CC [M]  drivers/nvme/host/nvme-rdma.mod.o
  CC [M]  drivers/nvme/host/nvme-fc.mod.o
  CC [M]  drivers/nvme/host/nvme-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/common/nvme-auth.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/host/nvme-core.ko
  LD [M]  drivers/nvme/host/nvme-fc.ko
  LD [M]  drivers/nvme/host/nvme-fabrics.ko
  LD [M]  drivers/nvme/host/nvme.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/host/nvme-tcp.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/common/nvme-keyring.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  LD [M]  drivers/nvme/host/nvme-rdma.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko

+ ls -lrth /lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/host/ /lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/target//
/lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/host/:
total 920K
-rw-r--r--. 1 root root 453K Feb  7 22:07 nvme-core.ko
-rw-r--r--. 1 root root  56K Feb  7 22:07 nvme-fabrics.ko
-rw-r--r--. 1 root root 112K Feb  7 22:07 nvme-fc.ko
-rw-r--r--. 1 root root 114K Feb  7 22:07 nvme.ko
-rw-r--r--. 1 root root  88K Feb  7 22:07 nvme-rdma.ko
-rw-r--r--. 1 root root  91K Feb  7 22:07 nvme-tcp.ko

/lib/modules/6.8.0-rc1nvme+/kernel/drivers/nvme/target//:
total 732K
-rw-r--r--. 1 root root  59K Feb  7 22:07 nvme-fcloop.ko
-rw-r--r--. 1 root root  36K Feb  7 22:07 nvme-loop.ko
-rw-r--r--. 1 root root  82K Feb  7 22:07 nvmet-fc.ko
-rw-r--r--. 1 root root 390K Feb  7 22:07 nvmet.ko
-rw-r--r--. 1 root root  83K Feb  7 22:07 nvmet-rdma.ko
-rw-r--r--. 1 root root  76K Feb  7 22:07 nvmet-tcp.ko
+ sync
nvme (nvme-6.8) #

-----------------------------------------------------------------------

blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  23.259s  ...  23.870s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  11.266s  ...  11.259s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  0.486s  ...  0.490s
nvme/005 (reset local loopback target)                       [passed]
    runtime  0.814s  ...  0.831s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.100s  ...  0.093s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.064s  ...  0.065s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.494s  ...  0.500s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  0.478s  ...  0.480s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  33.407s  ...  42.649s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  164.147s  ...  135.533s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  54.561s  ...  60.786s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  113.872s  ...  111.774s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  8.090s  ...  8.491s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  6.528s  ...  6.853s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  12.955s  ...  13.062s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  14.219s  ...  14.426s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  0.467s  ...  0.484s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  0.492s  ...  0.491s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  0.465s  ...  0.488s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  0.465s  ...  0.467s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  0.816s  ...  0.870s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  0.492s  ...  0.484s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  0.471s  ...  0.492s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  0.455s  ...  0.479s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  0.461s  ...  0.471s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  0.476s  ...  0.480s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  0.467s  ...  0.485s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  0.641s  ...  0.654s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.240s  ...  0.255s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  4.202s  ...  4.317s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.019s  ...  0.018s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.094s  ...  7.208s
nvme/041 (Create authenticated connections)                  [passed]
    runtime    ...  1.965s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime    ...  5.932s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime    ...  35.733s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime    ...  4.437s
nvme/045 (Test re-authentication)                            [passed]
    runtime    ...  1.732s
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    nvme_trtype=loop is not supported in this test
blktests (master) # 

-- 
2.40.0



