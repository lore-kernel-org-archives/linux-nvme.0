Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBEBC77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YDnjcxnQTzwur7RTC37aJ46zWHNxrPvUAmdaGb3XV8M=; b=H0f3IIkv9d2QAuODGM2Glt+G5Z
	NUUGi8cWGD/G1RHdl7mlCntZbuYIesXqYKNsovrtxPJg+rfQzLt/7Qyq53dfZ+9FD8r2RUUp3ri0m
	/BSymwUKbSPNbVAeQ1GIJB5B30FUneCwW+9uTyI+kybOZieHvgmo2LHBvDSGgjG4mBXOT+bXGQFeM
	0RH1sQlytmCO6JdDrazkJw4kK4gBDZ2XYimYzjObYexbuiaRF5zvH8HQIfOsD7DuD+RYstcVYy5oU
	pfE8l4rcf6E+KocayUWC3jhYQFtslLtmVM9+puzgHUxZuuVHyAbA4BidIKRi7ivtygz8Gg4OlT+2O
	zh4xdDig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUuR-00COcH-1f;
	Fri, 12 May 2023 15:42:19 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUuO-00COaO-2H
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 15:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEP/VYLA8i0p/NGqhHqvuZA3Hna4084x1zd8spAWf+7Sk0C1uRQPD7oViqcZmnaKrqit04HfSkt1RhYzDmZEJSO0lOgOHGUF1pvCIKZX1camcjdjaOH/tWfN4IbvGe1VAQlL8F6UbrV8DKR1jt5kEqhI+wwOnWAsBYxnOXVnXwgjyldYp6Sh6vY8XvYJaxCmizU9avyZJbdaqTv31ys1vsbOALNvriOk2w9J0uqRgxUobwYtVHevOJSZ08XROnftW7Y5hIVtsSMt5tWkwJh8SAT4uO7mFWpQTA1pA9G4TMBhe/kjN0u0Lm4ENso3g9YT+j4gb5mGGp4ONE98Cqjs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDnjcxnQTzwur7RTC37aJ46zWHNxrPvUAmdaGb3XV8M=;
 b=Muq/DjkMQUMs3XQs9EyjroIzzE/Ex/LdZ5pJy28nX+lr5meDhvI5KqfvWSiGGnJOT6PjWf7fAPoCSzBSl/IqOjD+Hy5ISbOm28puPffzIObgR2bNQ28E75MMkzVTUTVZfSyB8FlatdF4avnTk2rVN1Kr2KisSnNGaL+4/l734HcaQK1GBdki+n47mxnjW+1PMwXg3DEWbTq0YpKHdq0D/kL3qPe49SG4yPmrBJuVL1PTAnlM3TKeA2NbygCw7NUitu1x8xgQVn7jymJX+Hgwcc7JoDndULdQET9NevlQZESaox4k5pYUgzFuqY4wDSOHH9SXF6eaGDC8gp/f8vl+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDnjcxnQTzwur7RTC37aJ46zWHNxrPvUAmdaGb3XV8M=;
 b=AudHz6PzvreACPtQJ6g9dhUdkEdW4oagWUtubDmvWePVonlB6M2keN7K/7W8mZ1uhziKFed625+6fzicqg5++yY2wGpn5/77dNItfULwzZASBBpbg4BLtJHZEPMM5elZgx+5NZhbTe2Dc3H839KCPQ+GxMg5kbGSesNvT9FiQuBTd7Hb8PrLwHcqQyOMXMQn+9eBx45ayEUPivY5NKzU4Zv0RNcWJSBYphITqT4l424uEqt5m2sevKAlJBolBX9fF/ys9woC9kPycTIPjcOLhq7Moy0NrqFKCX9tlj+yPTC5zCyZpTKF6krgkKMp17CHucoNi+PibFn247JbUl6wrw==
Received: from CY5PR18CA0026.namprd18.prod.outlook.com (2603:10b6:930:5::35)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Fri, 12 May
 2023 15:42:09 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::6d) by CY5PR18CA0026.outlook.office365.com
 (2603:10b6:930:5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 15:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.11 via Frontend Transport; Fri, 12 May 2023 15:42:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 08:41:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 08:41:59 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 12 May 2023 08:41:56 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v3 0/3] nvme-fabrics: fix un-expected behaviour related to hostnqn and hostid
Date: Fri, 12 May 2023 18:41:52 +0300
Message-ID: <20230512154155.38694-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 5814596a-2cd1-4958-035d-08db52ff7206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	c/1LEF8l1hjmFAFIWLrRgc+Z/KHxA4LbEEHVbTlnoDZkVNbXBDr2cfA4riQazugJiZafoqYH6ngA9XrAkiaCUQeNVq+uoBxk88HW6eax9omyk1jVUz6EJrPoFl8FZHnrkfpPs69ORijvIWUg1xU4xwlPvFb4LEorMpGmTCLMGus2svymg8LPS+xyGEFr4pKWVvlTAH1keJCfKu4JwxxNnybwSR3uqyV9Y2UR65jZpvLz2yK8+iOIdV0Siq/ntZiKBHTy1HEKaP76564QnGCEYMXPrzOqnrm8d+50tC/yIM3aXtRq35wmufMVFbsmSzRuNKdOMvgI7aVUNdwB8MuDcXNz3bNnWSa2c7l9S7EcRqeMJf1Qh7f7EkiKNqkEpBHl60ovkCOBw3TvF9BK5quXGcFC0sRoMNTUMrGhMGx1XUirs0yf6qNY1Mh0/KOLO5V2SArhM119trQ4A0T4/DmvCTRhARI6gsfwr7pdXWNr0NPE5Xay70w/uJ+GgNsEamUDrDfg1MW0qLV35kE3N6L0powMvUhc0gq8wVlmUOB09oKqTl3DLXKeRBghdHmLjaGEuq/1WhXJf2w/oyuvabpURm5gYEyrv7p62tUHDF/o4+bJdMNg8Il1B/RoOfdbSw0CiUjy57RLcR9WN5xaQpYC2aToNOfbwmhfVOJ7GDoswSCpvKmo/wP8xAiMbxvrS3dY1be4exP8yIZopO3Tj656uqEhRG8OKSQrUGTsux7qaNN7S84Sk+K4QgoWxaSlaI4t
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(8676002)(5660300002)(82310400005)(8936002)(54906003)(110136005)(36756003)(70206006)(70586007)(40480700001)(82740400003)(316002)(4326008)(478600001)(356005)(6666004)(7636003)(41300700001)(186003)(26005)(2906002)(86362001)(83380400001)(2616005)(107886003)(426003)(36860700001)(336012)(1076003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:42:08.5098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5814596a-2cd1-4958-035d-08db52ff7206
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_084216_751394_C7BD2C01 
X-CRM114-Status: GOOD (  12.20  )
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

We've decided to implement 1:1 mapping for hostnqn and hostid to have
unambiguous host identification even though the fabrics spec allows it.

These patchset fixes the current behaviour.

The first 2 patches are some preparations and cleanups and patch 3/3 is
the actual fix.

Max Gurtovoy (3):
  nvme-fabrics: unify common code in admin and io queue connect
  nvme-fabrics: check hostid using uuid_equal
  nvme-fabrics: prevent overriding of existing host

 drivers/nvme/host/fabrics.c | 172 ++++++++++++++++++++++++------------
 drivers/nvme/host/fabrics.h |   2 +-
 2 files changed, 115 insertions(+), 59 deletions(-)

-- 
2.18.1


