Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE96DC7619A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 05:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ARkFXf7X90HaMdYcu4wYSRzsJ39sjm4F1mGV+uBT/M4=; b=jZXChEAF0F1PJf6qSVlIYfzpgI
	tnvwcYL+n8Bh8seUmcV4nKBiGXNDm78oECwshaVVVd1y7/MN6sGsYwQZqhLvczRW3Ch8r4V65smRa
	5YU3JKZS+0kpQlMhwBg2EmM+uP7dYr06AvtRRPxv2kDLoOWaDdtU0XPRfX+t4ZQO4J01QHwD6wOCS
	mXOTZ0kOeyh+HlJnQ6rLIcDj2Qu7Yc9i0e2ZVrchThSPZ0q5guF0gG7ynU39GGOOOgSJ8rQU/u4Sr
	kb6gOk5jBGVzKRwpnYAAEgwPF2RZef818Spehgqq4O6LTp4Sn6P9hLUWUzH9MxXcRBCCw5a76cvfu
	RE31EZLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfYD-009pfs-3B;
	Mon, 27 Mar 2023 05:37:49 +0000
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com ([2a01:111:f400:fe5a::61a] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfYA-009pf4-2w
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 05:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QixgLH+0jwwI2tg8YkivbDf46aoGBGSmhiWRyycBgdjEY3/UG6wYf15TdpkLm3wbfXmSIToolxrTLCI3N1331kceCYqvFElgkfMpa0x/EaJ0GC6ITNgzERdk+Uv0cLcVRAkcxT+2piJ96khMZHKr68HDbIXqIYyPpv0h8UvqRqoOS0RrrX1CEXmo4alx78Ir4k95Sn2ienBJ9GgPMCFQvwAswKrEceIs5MjqovEzJ535rudfYbG7b595tjWRTyVyJzSTtuKdhix3r3alr4Ih5FxnNBOBHB0lXsphuY9kBr4qBVHwilCpdkV9i+i8w4OToxGlZ/uWessRo0Kfa4KP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARkFXf7X90HaMdYcu4wYSRzsJ39sjm4F1mGV+uBT/M4=;
 b=aOemFIrQJLSHgWuZL1nsd7FcpXyLczLKwPDmoneJGRx38+elpzdl+S+Xc8UmdRqzsZr6vHJWPou3ZMhVixH31SLAsGJ1Poh+DA7JOLPeTw7Vu5axnpegqADvLU1oDp5UGXemj+UEh2Yn4+iw+7yI3rDWexJGsodL3Ws6z2BYm/8ggoWlfiaIenDBoMpIAA2pbde3+oscqNTw2vcZyneOYzm5XN9oIHcWuEFvwaty/+ul6OJSM/ecxyZ8A5FRkP9eNhYSMerQuCKaa9QTO9r6F1CvhYv1Cs3GqNelpJxttpYkLWj83hFZMeQT6h/TNRvF/p3Pqm1SVZIPtRWwWVIjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARkFXf7X90HaMdYcu4wYSRzsJ39sjm4F1mGV+uBT/M4=;
 b=sZKNQ63JsrKwxIl6GBxkJAgqGdvGogE6LjaQp3sCxUayMTVPzJw+Ymh1H3ygKc7uKyEmWALlVPrERSO9r1GOsGKrYOP7JnjnC5la8M+9uTeHB1Vv1a/fh6cYG1brCXdScUX3i/Xvv/aHqpjH9jmPTBMemNHvg0n7iJFkzO53IsRV3OAutMs7E7S02mN8G7bZLyB8KQj1Qgt8EqQ41DiXiYqObSBv+gqB8Ea92zbDQLVbP+7jjErMDD2Xx8E/rRVeKciaoiHo33qWek3itvCnWRBtmSuzEaMoxuzO8h8vaHCzauE3HNv9B/Jdja+7sIandtptmlxeyETpPH35/D4+0g==
Received: from MW2PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:302:1::31)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 05:37:42 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::63) by MW2PR2101CA0018.outlook.office365.com
 (2603:10b6:302:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 05:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.21 via Frontend Transport; Mon, 27 Mar 2023 05:37:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 22:37:33 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 22:37:32 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 0/2] nvmet-tcp: add module parameter check
Date: Sun, 26 Mar 2023 22:37:22 -0700
Message-ID: <20230327053724.62363-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: fe53d93b-f9a6-4b3d-d3e9-08db2e8562a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gH0N/SZ+DCuCAdhIhe5FPjBxm5VzI75CR4jejeCa7Y3f3zIela6Qb1t87tttzm8IKjEh0jR5Zk154VBtUcCDmDZ1PI9zl1qCZ4zrSUk7n97Cf7cb14U7eV6u0RnDRfbmMuiC699y5n7r7lDrTw2TIGtQZjqt9rCAIx0m0oHg4r7Dzivm+LU6eBrekFpKcINvnslUrSlJESrbDL0JhpmE9Wj4Z+RRrQDbQzX0po3H2eaxAQNHJqXMjCwtxm9e87+855xX+/WGnamAgvBZ5UsR0jTFusz4d0Y070hlDrVSo/8Gnz05cG/l1Gu1PjtN0VBQkXIJ3d9UjPbutOCyKSbXr9PL22xwL6ZyktBJ+EozUtGbGyV5Q9DfgiX8cM7K6BNXR5boGMNcD3EzRUuDE4olt8iEguva99PfuGFSzhaS0+OAZs/LW8jgrU182hb2EIiv494fqr87otHRN4DlH4I6vJVhBWpLk7tjdvxfk1CN8w8bkEFSBs/SCZiuwyzLC6FiVSQh0JsqPNpgvb0mtfrEVP1E/l32hcD0XF8pFhsQL8ihydkuM+8uJcZDH0xpVBl1PmFtK56RDlJfOIHcFu/2exlPeDsyuoXUvvw8MriuUiVB11RlQAZvU1dJXGWK8JNTP2PSMW0dZrU09r5NlS8hrGgaNc1pX4e+LLJgT2VTnRrHUsr7BobIQT3uWHGO3Fn65hOz9B+NywvMtMTIIKB62r6GA2PsBAAbDYFdIWv39QLIIt1lo1vdKzXk9TTU1sUrWdbdVvz4fAmRAbcmyPGH3g==
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(2616005)(1076003)(356005)(36756003)(7636003)(8936002)(54906003)(316002)(26005)(4326008)(6916009)(186003)(16526019)(70206006)(70586007)(8676002)(41300700001)(40480700001)(40460700003)(82740400003)(34020700004)(36860700001)(7696005)(83380400001)(2906002)(82310400005)(5660300002)(478600001)(107886003)(336012)(6666004)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 05:37:42.2722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe53d93b-f9a6-4b3d-d3e9-08db2e8562a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_223746_974606_F1D6ABC7 
X-CRM114-Status: UNSURE (   7.10  )
X-CRM114-Notice: Please train this message.
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

Add module parameter check for the nvme-tcp target to generate right
error for negative values set by user at the time of the module
loading instaed of allowing module to be loaded with those values,
that created confusion, simple testing log :-

####################################
Without this patch series 
####################################
modprobe nvmet-tcp so_priority=-2 returned 0
modprobe nvmet-tcp so_priority=-1 returned 0
modprobe nvmet-tcp so_priority=0 returned 0
modprobe nvmet-tcp so_priority=1 returned 0
modprobe nvmet-tcp so_priority=100 returned 0
modprobe nvmet-tcp idle_poll_period_usecs=-2 returned 0
modprobe nvmet-tcp idle_poll_period_usecs=-1 returned 0
modprobe nvmet-tcp idle_poll_period_usecs=0 returned 0
modprobe nvmet-tcp idle_poll_period_usecs=1 returned 0
modprobe nvmet-tcp idle_poll_period_usecs=100 returned 0

####################################
With this patch series 
####################################
Applying: nvmet-tcp: validate so_priority modparam value
Applying: nvmet-tcp: validate idle poll modparam value

modprobe: ERROR: could not insert 'nvmet_tcp': Invalid argument
modprobe nvmet-tcp so_priority=-2 returned 1
[21625.237738] nvmet_tcp: `-2' invalid for parameter `so_priority'

modprobe: ERROR: could not insert 'nvmet_tcp': Invalid argument
modprobe nvmet-tcp so_priority=-1 returned 1
[21625.268026] nvmet_tcp: `-1' invalid for parameter `so_priority'

modprobe nvmet-tcp so_priority=0 returned 0
modprobe nvmet-tcp so_priority=1 returned 0
modprobe nvmet-tcp so_priority=100 returned 0

modprobe: ERROR: could not insert 'nvmet_tcp': Invalid argument
modprobe nvmet-tcp idle_poll_period_usecs=-2 returned 1
[21625.412338] nvmet_tcp: `-2' invalid for parameter `idle_poll_period_usecs'

modprobe: ERROR: could not insert 'nvmet_tcp': Invalid argument
modprobe nvmet-tcp idle_poll_period_usecs=-1 returned 1
[21625.446106] nvmet_tcp: `-1' invalid for parameter `idle_poll_period_usecs'

modprobe nvmet-tcp idle_poll_period_usecs=0 returned 0
modprobe nvmet-tcp idle_poll_period_usecs=1 returned 0
modprobe nvmet-tcp idle_poll_period_usecs=100 returned 0

-ck

Chaitanya Kulkarni (2):
  nvmet-tcp: validate so_priority modparam value
  nvmet-tcp: validate idle poll modparam value

 drivers/nvme/target/tcp.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)



-- 
2.29.0


