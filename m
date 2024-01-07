Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FDEC47079
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jan 2024 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pSXY96fDeHKKu400ivchZVSC3BdtWWTpsB1HQyRAHP8=; b=ZKvWStGJoqCsDHRYIgVo2VAWqg
	j74HvY2RSQf87mxzoJI6MEfHeYqDfsVggOgFGuw6vhhqb5W2qThq7Sa3s9i4vsqf7SxOa5LrGPsIt
	deLDtreYIdveLlXCp5xEoPqYbdyqqZngpeQrexwbgz+1mSNkdiS0tAJa4fmV/qFJNlIl5WOTKXSJ+
	KNJ3WH064QnZa2k5HS5P/4yZ8iXYI/Hgmr8VtIQSnJE7uJO32AAro/DwF//02/BngzwTByA5OUBoM
	pS66l1jWjM0QgkTJGU0/PFflZbwLOxaFusIfOwy5P4Jq+Z4tg92XiMw6eZ5+mbpyPzZ5PLbCK6jdk
	r2P+7NiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMH3U-0026pH-1V;
	Sun, 07 Jan 2024 00:30:20 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMH3R-0026oZ-2J
	for linux-nvme@lists.infradead.org;
	Sun, 07 Jan 2024 00:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9PoS3FEVUMjci/7QuzJaGrM+Z3QreqHy/DhBZOqwcdz3+43+No3OyOaLsJQ/o8qKndbZEg9JHMzMLRTnLBO8fRfEgqP7OWLDe5+f3UHMWBDT25VapYK/ezivAh3QrR+YFDoRcBxSD0XdXg4enc2U3FxCh1CtM1Wt5W+XbQ/7zgxytr5ULNcS5kfJB6APHEzeFUfGSC4onBidgE5aWQWK56mKYvnopXiHljQiCjfUOB6xjeMx+RWXv6GtKcK2iI1J0fNoe5m92yKq1kCP4Ei0Er/b4uHWfHsAJ8BZDAOypVpl8Y9XEhwAT0oWyq8OEM8iVg01GoJF0G3oj9z43nIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSXY96fDeHKKu400ivchZVSC3BdtWWTpsB1HQyRAHP8=;
 b=jm+ZSYVSZWJS1EjQ9aFVRspB/4TAZvlPSQGMdoUd+8HV0EbkJ/u/QubDOHOmO+TYH/29/a8rfkNgHPUP2LOzzXCGNUcaxjGYWHTWQcDxJGvcTDyVbtfTydMAppVzLHkI5Qw8BPmG2M7u+GbfBA63KQl5Zb65mm1T8Plt4EcsUtzwIR3bjbxJeU7w0mFdJtXL9UNS8cDxHlg91NTOq23vqk5Ip4iWxwf8809CtGOSCBHDzR47euEthdyxapuS4z/2rhlTOaCuOALVXCppkWcShmYCbHqchki3yA9uVgKwhOUmVcdRDlGcV3MjDJ75Vh5GIBtpEkTdcp0RHBNpX4KEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSXY96fDeHKKu400ivchZVSC3BdtWWTpsB1HQyRAHP8=;
 b=WIQTMIv2VFK7wvhoCTbGSF8aHDXNe5eUOc16TA3/u55NNZ6Em7O4Zz0H6m1cFdsVvNpwVNfrOWXAg+pCU/PVipa857+GuPZ7XMfxGSS6IBCdz+UU+ubCZC8gFpvCLiLfeBkda9xTfLYcLgdLNU76fuNrR/2Kz9XBxSDqGnP8QZLh4qvP0qp6Rut/Bs17KqpP4kBq3urs3hhBostNdbH/eFdtp0BjbbMsQ14yjhYyQhGr8fFOw1HdA+2qYikSaSK7pbxo7+/C0dSQlnjm4MaKa8Hg9gWkr6RhyuHH1SPMqCfP0SdTleiQ4aCBBDypMEnxWK+dcPz1J2hYElAQbDiLHQ==
Received: from DM6PR02CA0163.namprd02.prod.outlook.com (2603:10b6:5:332::30)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 00:30:06 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::3e) by DM6PR02CA0163.outlook.office365.com
 (2603:10b6:5:332::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20 via Frontend
 Transport; Sun, 7 Jan 2024 00:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Sun, 7 Jan 2024 00:30:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 6 Jan 2024
 16:29:54 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 6 Jan 2024
 16:29:54 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 6 Jan 2024 16:29:53 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] nvme-tcp: enhance timeout kernel log
Date: Sun, 7 Jan 2024 02:29:50 +0200
Message-ID: <20240107002950.6233-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240107002950.6233-1-mgurtovoy@nvidia.com>
References: <20240107002950.6233-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdbbda8-9f8f-4b01-fa6d-08dc0f17cc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjyAz4obACAF+6nAsuCPsiF+8RCK5BMeMN+gr/cTyeflzQL9UhG7BYwhX4XQvzUXZNlEgYS1O+CMAhrjR1P7ZcgpKx75hiXEVxXK0EZdWMpUuD2RQFSd/CCvIMoxHI0QHOmzQnZCdFncMHysl4P2tgq7nzMZpy4EVRnOsREtOdGxtpyU39MQ2FVFxrkiZj3wG2Ac/QMUKjFTAN9MQ7zqK4LVLJNOZV7CMUnWK/LMlf80VNAlZTlbG/+nuFU/F3Ub10Wr3EFGfQm9vukzyNyGG/X+yT9rI0crfZ44kkANLX9E3b6c19RukLfodDUbejfy0liR1N4JPM2NvRvYiRFdfXt7ncFjQ4Ir/PEMPHkBQqqoGSv1GdNkTfvSeD0EzYt4mCdrREuY1s1ggGQI8DV6pY4qTwvokldS+L0kZPxafg/11dKGaM1U4oMZAk35r+7iRzUEVreDlx/EERreEIGN2wM3dSbvumEDf59fkoWsH8xnWhQs1r3knh5Vz48q8O0JWtWcO6Ih7S9rS2L09M81jAeHeiMQkumD42wx+ptB1A80L0N42+ghLY6+jhUZSzM+Fj7CUVBS09FCqVk2z6b9TlBhx0HMCFRs8JcryvWz0KG6hcH41hyQDVu5WguMNeuSvuYJsVJlIssIGDBfZcGkg5zQUenDJa+LEaJ2t3Ch29LVUk/8kaRISPoEV7T6Rl5CzLpv/QfDDkjTX7LTo8eOGk/a1CFne+s9U8JF1OkdTdI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(336012)(107886003)(26005)(1076003)(2616005)(426003)(83380400001)(40480700001)(8676002)(8936002)(4326008)(316002)(86362001)(478600001)(70206006)(70586007)(110136005)(82740400003)(356005)(7636003)(47076005)(36860700001)(5660300002)(2906002)(4744005)(41300700001)(40460700003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 00:30:06.7244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdbbda8-9f8f-4b01-fa6d-08dc0f17cc74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240106_163017_759172_4AC1968D 
X-CRM114-Status: UNSURE (   8.25  )
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

Print the command_id along side blk-mq's tag to help match commands with
protocol wire traces and logs.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5056bcae2f39..b234f0674aeb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2425,9 +2425,9 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	int qid = nvme_tcp_queue_id(req->queue);
 
 	dev_warn(ctrl->device,
-		"queue %d: timeout cid %#x type %d opcode %#x (%s)\n",
-		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
-		opc, nvme_opcode_str(qid, opc, fctype));
+		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
+		 rq->tag, nvme_cid(rq), pdu->hdr.type, opc,
+		 nvme_opcode_str(qid, opc, fctype), qid);
 
 	if (ctrl->state != NVME_CTRL_LIVE) {
 		/*
-- 
2.18.1


