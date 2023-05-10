Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB24FC77B7D
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k1F2/QitgZUKr8c7kr2KOHQK5EWrmPHKPy2FQj/UUfQ=; b=PMtkBrgOIq+f/GCqxYEdSU3VsX
	8jp32tc0jGGF3/i/mewjBsO1AUqPCNGL5gN24fhuTfBsxy0w1/l7IrCfSHFf+Seut4AceyyIlGQs0
	5s2vTJLGqj4uTTaY7zFCMVJnEz8vlAmOB4P3ay44MrGvIMf++FVrvCNqENx0h1M8sqx2Z0Gepmpmo
	Byxy4DlknVyC0pHkNwcQtqk8CWd29Md3JNN8OUebS/J3M8cepfuyaStNDUW1xKKAkG5446FuQUPKM
	bKQPW9LI9t6bEFzkgrNJN3qNxkXDYJjPn8Ku7pQNlJpUT8I/N0Bt9+cjSULUf+Q2UbqevzMb5BJOk
	xZ+Q5sZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwo9Q-006hog-20;
	Wed, 10 May 2023 18:02:56 +0000
Received: from mail-dm6nam11on20607.outbound.protection.outlook.com ([2a01:111:f400:7eaa::607] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwo9N-006hnv-2a
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 18:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ/WrhgTk8YR6yMknk/ASI/dMQZhlaUC2Qr4vMx2RQ+ngDrndPLyVi3YB0kHyaIm8g4yjT+GPy9KwRG8buei6K1tJmWVydoGjXONrGmeaV7k+6mWljsVvC5dTupoo0OHWbPkhn2Rn8U9d+KWzCXu74DfBV2T5fqyRhruHsVbIseLfoV4E3MAfjq1wMgIHg7IzfTMey5C1r+xucYGmzuKqCJmXI+7ITzvMvRMAwjShWe5UyxxdKv3EP1Kl7calJLdA/ZbC7RS3x2xgJQ3jVxxUuwqBoFK0Ie8qw2LVlNBMHtWacTaijqmy+C9Xltc9OCQFbUJmJ6ratSeM6GJM7kmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1F2/QitgZUKr8c7kr2KOHQK5EWrmPHKPy2FQj/UUfQ=;
 b=LDziWhXCdrT4JpnLrPbuWzk4SUwgruWc6RPBlhbxfCjOE3YvF4pm3SLwvNk15MSfghOqphmHlOqEIquFDWIorEEEK6784M9sPH5FKydgRnLStbrmZG17y2iT4WNMU0KEcCGfk3PvIul5gFYG70N0+b2pWMmmzSVDnqsEtX7WabTnY5rbbaCucDHsgjzQE19I97+g+mLWQB9kHAYWcILwmqUMgzaO4tHSi+rxJpptRiF0Dn6677dDJCmLmeR1HIsAReDepSL1o6u/nSbEovAGdss9cGE2oUeqO9CXjNcp8P8IruqYbSQ0UuIkbLiJXS9TCIZ842W5WC5ktAxpAMNfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1F2/QitgZUKr8c7kr2KOHQK5EWrmPHKPy2FQj/UUfQ=;
 b=VpNOGFEC16BnXWloBcBNNu39ZbMSQMm7qZrqk50s7ih/2hMLFkPA5+8hnHGVgbQnTY//Of9KzuPw31EoIlRKC0KlLklNJ45Aq5kb0Y22KJ69t7FxKYYVPjZPle24UEVA0G0LWfsBmfcuv6V1i1t5rK7xCJWMrTmj5zcUTc+ueJDSR8lce6oHWLO75PqKuS/xP99mG+V2FhCmBBVtwzRdi7dB2u43Q2+s+o++U+nnXQbCbs4nglZIkVdTMVDZjAkR1fsHzm9kkFjIoPKLvGSz71UTQA4QhvYTA1WubM/MrV/Dsn0IOdcdNzEOShV9XbOboXJRvHSOalJDxVa22y2HJw==
Received: from MW4PR04CA0086.namprd04.prod.outlook.com (2603:10b6:303:6b::31)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 18:02:48 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::82) by MW4PR04CA0086.outlook.office365.com
 (2603:10b6:303:6b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 18:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 18:02:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 11:02:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 11:02:35 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 11:02:32 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v1 0/3] nvme-fabrics: fix un-expected behaviour related to hostnqn and hostid
Date: Wed, 10 May 2023 21:02:28 +0300
Message-ID: <20230510180231.18865-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdb8341-fc57-4501-72fb-08db5180c308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Odhqc9xNSTsbn+NA1Dddn56oDGkedQwBiIvKbNl83ztR0T6Ek50gCfUUDgL+ieveUb5wp6dgoVCc6kYNH9D7u/TXcasFlj5Gm9CXrvlIujDS/hVhA+D/IKM8+dDZfH8eewba8djjuldRez1bPe89q86+XGbsDp8Fyue1D20+aymltNEKJOk6pXs1i9eWz16YMAC92NR5b6mUWM6+MHvG9rPd7wf9PGmvb/1Itv0C9Ch/rkE17/ygPp2nux1DMzSZU/KmSnB12wKVGePqJm2Hy6WmtIz3T6wvnmBNq2uqICxmEviVt5rrdAcEdrd338l92rXeFmykkulq5LDtzcju76OYoMImAAkEpSq6fYRdd8LbswcDZK21/mpniyY88kVGaUCBSfMRLopIPpK3DTMdoQ23ztup/E61oykyFhN7qj11+dkV6ZkbZOQ5f0kclJPKTS1MCEBv0+Fcz0nVct5jTMmEyhw2EKiTR55/HVVQCOuHe0CkhfW14ulV+xMB6+ux7A6Z3+fs6fNy6b8IEaKTLELc0qIwXvHNQUagZYKW9L/2Eu1vFRa5To/EV+trCR5XV9N35oiqJoS2F+PM3no3Q4mTuMUU4jonSZPxi+BTmLXJ0+XFMh6+zBP1IXnedaiC4157mULFW1eqUiTRdafRNZ/tgcBFw3DgwqXHr+5mTLWq07Cw1LHT76T2OJfe6Of3gKkQMu2+wAk7ITlbJ64Mq8fwxVyvpnp8mkXyPnP0V9oZImYW6A6kYNdGViASHRda
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(7636003)(356005)(82310400005)(86362001)(82740400003)(36756003)(40460700003)(41300700001)(4326008)(316002)(5660300002)(8936002)(8676002)(54906003)(186003)(26005)(1076003)(40480700001)(2906002)(107886003)(2616005)(336012)(426003)(47076005)(70206006)(478600001)(110136005)(70586007)(36860700001)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 18:02:47.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdb8341-fc57-4501-72fb-08db5180c308
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_110253_911150_7FC51707 
X-CRM114-Status: GOOD (  13.60  )
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

Hi Christoph/Sagi/Keith,
I've noticed that we are having some un-expected behaviour in some of
the scenarios of connection establisment related to hostnqn and hostid.
This is specially around overriding hostid for a host.

For example:
-------------
1. Connect to a target with default hostnqn and hostid (after removing
the files from /etc/nvme):
    - # nvme connect -t tcp -n testsubsystem_0 -a 1.1.1.1 -s 4420
2. Check hostnqn and hostid
    - #cat /sys/class/nvme/nvme0/host*
       1791bca2-af3c-4e17-a310-6fbdde3b59cb
       nqn.2014-08.org.nvmexpress:uuid:fc4e5383-ce5c-470d-9889-4adbc2dbe969
3. Connect to a target with given hostid from cmdline:
    - # nvme connect -t tcp -n testsubsystem_0 -a 1.1.1.1 -s 4420 -I 77720af2-ce59-418b-82ff-7c9df0cea35e
        Failed to write to /dev/nvme-fabrics: Operation already in progress <--- failed on duplicate connection check
4. Check hostnqn and hostid of first controller
    - #cat /sys/class/nvme/nvme0/host*
       77720af2-ce59-418b-82ff-7c9df0cea35e <--- hostid was changed !!!!
       nqn.2014-08.org.nvmexpress:uuid:fc4e5383-ce5c-470d-9889-4adbc2dbe969
5. Connect to a target with given hostid from cmdline and allow duplicate connections:
    - # nvme connect -t tcp -n testsubsystem_0 -a 1.1.1.1 -s 4420 -I 77720af2-ce59-418b-82ff-7c9df0cea3bb -D
6. Check hostnqn and hostid of first controller again
    - #cat /sys/class/nvme/nvme0/host*
       77720af2-ce59-418b-82ff-7c9df0cea3bb  <--- hostid was changed again !!!!
       nqn.2014-08.org.nvmexpress:uuid:fc4e5383-ce5c-470d-9889-4adbc2dbe969

This seems like a wrong behaviour to me since in case we try to
reconnect the target will see that a different values after
reconnections and this change the expected behaviour to keep hostid.

According to the spec:

"This feature allows the host to register a Host Identifier with the
controller. The Host Identifier is used by the controller to determine
whether other controllers in the NVM subsystem are associated with the same
host.
"

Also:

"
A host that uses a single Host NQN may employ multiple Host Identifiers
to designate elements of the host
that access an NVM subsystem independently of each other (e.g., physical
or logical partitions of the host)
"

These patchset fixes the current behaviour and allows one to set
different hostIDs for a single hostNQN but not vice versa (as we would
like to enable the target also recognize a logical partition of the
host).

The first 2 patches are some preparations and cleanups and patch 3/3 is
the actual fix.

Max Gurtovoy (3):
  nvme-fabrics: unify common code in admin and io queue connect
  nvme-fabrics: check hostid using uuid_equal
  nvme-fabrics: prevent overriding of existing host

 drivers/nvme/host/fabrics.c | 163 +++++++++++++++++++++++-------------
 drivers/nvme/host/fabrics.h |   3 +-
 2 files changed, 106 insertions(+), 60 deletions(-)

-- 
2.18.1


