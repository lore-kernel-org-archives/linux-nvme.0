Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF3CC7EE2C
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 06:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZoGLQoVoNWQM8AmMrY20Ik2ci+y8NtJsIfVzd3jEJ+M=; b=n/gE4vol+H6AvuPf+t6RSroWWa
	RQulE/FKPZn3SGq9wAdA/sZP3+/cqcbze6CS16AU3djPnA/HuAWr3rARglluLcd/EQijIQ0cB2CNU
	759udwK9MUpOyJzn17mBy90BcmJ/431G8+f51Hl2kzyK/UGfqcg5nFGF1CCk4aNDiqQn3cTuWVFpD
	y4IiKs5geWpP8TVovZk/2XbOFv7WouIekq9oInPhUBO6hGB/Akweo1QwbRyTf1ycQgBArqP2i+hNe
	I9ZW36GodRwSj2EMIULtKfico4GcFFgroKXq4ig0rstZ3kLNWc2DJRSzfBppDd7LGo9up6854UTNb
	/UfqG/lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q644G-00ERf6-2P;
	Mon, 05 Jun 2023 06:51:52 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q644D-00ERcP-1l
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 06:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY6bWbPzw3A7sj1xWfg6n7AtoLj5ZOe1Xj1VunmMKBvrEyo2olStzlyHl2cjO1raILcWwYfrV+yBFKGEy4HE/6F2Co4LdeJAK2+qCg1Qjr+5PiOpFcZd4zv/RI1MLcBvCAQZLbH2cxwzNyoks8JftQ7ySPh5JaL+8SwfJYPcUjmxv366Xq3/Au9c96svVoMJtr8UtZtuoQ4P9qahYBKdPCoofeJYO1cPBs84PLMzQq0R57jbz6Hlc7rcJhPgrXXOo1ULmbUS4cnG2tl80DIXSIim8nZ4QnQT0PVoedmKdVGoVcqLsaMRlWevRsagNQX08rMO1GVgyuXrSZcj41XnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoGLQoVoNWQM8AmMrY20Ik2ci+y8NtJsIfVzd3jEJ+M=;
 b=ZZv4aR0EkKmeAR8VxCO4HRJe7XQjIlC20XADOY5PEEl4EzNhS8Xh3AIaYGxgfIE3R6C0AoOFrpvxW1jSG5606yAXG7IXEIxxaCgS1Uyh4hlafzt0ImM9y0X2LfQ6/K9OSCTei/ohEAeFQvoYKdkseycnxSv4sI19e9KOj+qM6Seo6OWCWbXi6zd8F/DIMiOEIuN8cCtBDhTKP8EjYnOs46v7wZumuOCLOZkwkji6b0phKrJwwoI12XWKiXRQAaP2l+SBoF43VTqNeGoUd7ge2KjdvAvr4xsKOpLB4PUe8anhoakpGS1pSkmZoX+P6iDIsE6MEeM6AETnKIclINQSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoGLQoVoNWQM8AmMrY20Ik2ci+y8NtJsIfVzd3jEJ+M=;
 b=JYqNYa4AOtoyn1fzdPSMHUp6VEXWC6veofqtMQ9QaWOtOY+a2Y7g/VIXRH593/qWYLIyTsvQKtu9F0cHQZ7TlnreCW0gL2wzrQrk7lREPEe3iT+htyvI72H/ObcZgS5ohzgGReGetn3rlqzLsexh2kOXrA7wR1QjKrg7uk6k8KSouO+29GXL2gsDQykBGvQcuWKT/hmo8yJv/jFGJAFEIQbU1jf/K0fmxl6A9KXVc47Xa1gbWdqqr0UrdiYB88cwlIwX40lQ0XZjOEvqHbGAP8r0NuDsuFUV8a6UHhcz3TubSsimcM+GU38S9L+8+VtmidbB3/2vFda3MZx4mnLvaQ==
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:51:42 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::62) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 06:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 06:51:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:51:33 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:51:32 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/2] nvme: dhchap_secret code cleanup
Date: Sun, 4 Jun 2023 23:51:23 -0700
Message-ID: <20230605065125.47563-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 076bbb40-cc08-475e-f68d-08db65915165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2GfRIXQW1cl1ZxpmjXlbbEI76uXtmu0Ib+qNAwP2aDXm/nJ4tUydQLaEFbWBTewhK4/q2J5hp1KlBpFX8PwK+Ek5oTnb3BNZKxYN94q8kZ/jMoAWEvdmC9X0hmqsqD1Vn2Y0S51LfnqLv5nMDH3qgjplevQwkqcXKimDhOHamQ38UIq4J3Xrb+pI+HM5gLIA967LMgy/QDR62w/X9VUmSDF/VkFl3CP5MHgyeIhL/GAp5HyJXPzin15+7vfvk/NTAzE5xfgO2b82T8/mJgPO9vH9lswbHJHtdrVqp1I9DkHtDwJ9+nYZcq7ztSIgnnoECYZu1bQEspu4WAwO78aCJ45huCURXT5ePV1bDxpXjEgnPCMS7b3qdI1+HNhDNqceSGDFytmR79l30t3k0r1CIxhrfAwObW8xpNOtgNhOuf1cKPvevV8dYKIRpM+NOac9h5J7iQlW2fK/t5OCBrd91AGBN9qDxETwJarW4NFTOISehUWhMGTt1XaBQXk4B60jGdFtusxJaj2eihq2tJvL83dokJqkyzqGs/k2M9UFK2NDrYxc+yHuSR6xnIbv8eOTla6XFP61irziYX7w2tDW68RmEUHqZKoNa9DODNu/m0xhD9Rnx9efeSAAjSfYOM97iDxWQcpw9rhI2j7D8f/BGPBccjqrQ0Ou/OIafYV8+W0X52HfV2YeezEtzy05xBvktArMwIHbPJgy02ni5bHAK3Ft40woYT63lbT3osIeTkmI+YVFxuY7fQfzj5r9wBwS6lmub9MIwhsldd6OmWkXQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(47076005)(336012)(426003)(2906002)(2616005)(36756003)(82310400005)(356005)(82740400003)(7636003)(36860700001)(40480700001)(7696005)(316002)(41300700001)(6666004)(5660300002)(107886003)(8936002)(8676002)(54906003)(478600001)(6916009)(4326008)(70206006)(70586007)(26005)(1076003)(16526019)(186003)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:51:41.1326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076bbb40-cc08-475e-f68d-08db65915165
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_235149_593962_8A28BBBF 
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

V2:- Merge patch 1/2. (Sagi)

Chaitanya Kulkarni (2):
  nvme: add generic helper to store secret
  nvme-core: use macro defination to define dev attr

 drivers/nvme/host/sysfs.c | 145 +++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 90 deletions(-)

blktests (master) # ./check nvme

nvme/002 (create many subsystems and test discovery)         [passed]
    runtime    ...  20.419s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.090s  ...  10.111s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.156s  ...  1.465s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.221s  ...  1.810s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.059s  ...  0.058s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.042s  ...  0.034s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.171s  ...  1.465s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.143s  ...  1.432s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  102.360s  ...  96.545s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  56.073s  ...  68.359s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  83.236s  ...  84.890s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  66.492s  ...  70.922s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  3.964s  ...  4.239s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.507s  ...  3.763s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime    ...  12.382s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime    ...  12.338s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.117s  ...  1.440s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.128s  ...  1.451s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.125s  ...  1.430s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.125s  ...  1.434s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.171s  ...  1.756s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.150s  ...  1.449s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.134s  ...  1.414s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.122s  ...  1.431s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.126s  ...  1.435s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.131s  ...  1.438s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.127s  ...  1.433s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.262s  ...  1.579s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.140s  ...  0.211s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  0.894s  ...  3.968s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.015s  ...  0.013s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.171s  ...  7.909s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.460s  ...  0.741s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  2.891s  ...  4.897s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  0.724s  ...  3.126s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.241s  ...  1.854s
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.804s  ...  4.087s
nvme/047 (test different queue types for fabric transports)  [not run]
    runtime  1.849s  ...  
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    runtime  6.254s  ...  
    nvme_trtype=loop is not supported in this test

-- 
2.40.0


