Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEEBC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 20:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+O08z54mvPSqvPAAQGEKHXyyVBA/A9PwERI3ChK1M6I=; b=Kmt4kIW0x158d18PGTLzXwdIkT
	tQVwoO4iFqMcGKRcpfuFby8IOx6p1goeV4LOVNh6F32TwDF01mYAxvhSV5/V/hlKRmibBdwLffzf8
	ahGvbDqMZHIYTIRS8AFWb7PMxim/Dj1JBt9e3hXRg5nKle4CpQkwr22yvqe1zQLpMb2m89KeDPujm
	elxaTenknpesYASMqD+dVX8t0yHN5xHPbWLKjGobB9b4g/TV0Kf/95aUrBLaZ0a9N1/cXaGYSvcTa
	K8Ul7xIRvay8OjHSL1reND2JUVpbAvV/NnvTCU/CAHYlFYmiJhDdhN3BBuUt9d9K9+6u8nOhiksQM
	ACs+K7aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0pZy-004j7T-27;
	Wed, 08 Nov 2023 20:55:14 +0000
Received: from mail-co1nam11on20604.outbound.protection.outlook.com ([2a01:111:f400:7eab::604] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0pZv-004j6o-1P
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 20:55:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7OXzPocYMX9OFizUQpD0KatiwoRDA47WLjawFfmDXK4tEXCgqVJIyrDIc/xGv9p+2qqkmWYo90U/VKYTLNvMA/jM+rZgrDXffE6Dbv5BlWE6ltC8j2q5dstt1DW+FFLpU72Kb4cj9VbBiCUX7FcqFEREzGgjmt+x2qTxCzDeTSfAkpQ1lDv6mtzvjdgpASjVOt1PkcnK8YSGjIG5cglZbg9vPvZ8M/E32fBpw59WDHxUh1r5bgyW1WqP9xdh/SRd2PD1lKWptGY5ZM4eAEpg7ty0l31UhDRQpOw02GkYYBaVSMIQIidyhbTkL/h+hEAYKk0LiuUCurm20AfNWw5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O08z54mvPSqvPAAQGEKHXyyVBA/A9PwERI3ChK1M6I=;
 b=DprWk5zO1RUZNimvjKAd590LioyoyArG+nOUrJA29G8muW2HtrY/cjQB0ZuczBzklwAyd5Ixy/Mnm0ZcFeoS3Iy6QVBpNDnmXCFFpqaC1NjYKgJ6LV2MTrV1otI7USmfDnUBRp8ONdnlraRjEXGP2pToNpr8aMaJxCWGx9TGX4ROuugvtWRAxapK+41JCEFoEAAPfcuHIxK/RT5PPsKUnoWjuEIaJ/rGxefioWpi8V+TfIWFkdXu7HjOyBn3npFjIjXzG6RjdiFVkDecVppO5K2k8/vTHMDZ2/tRX3AEVKDFD97wNG9nXve86ERg9NC8r8lqHmPN8dGYOONMB0FuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O08z54mvPSqvPAAQGEKHXyyVBA/A9PwERI3ChK1M6I=;
 b=eLqz+eOOL+nhIcN6xMCVtp7h/6OThqS0+K/nmM8SUgXXXWnHgaLV0ee891230GGwTJp9XXbb/ep5lQjtKuKUor1QgztkWZqs3sYUwV9aRPj7e2zQm8vuN5vW/6rtidXi+tXR45WZ8wizCCd6TmscKv/YD3Ot7tizuWbDJsV7TMhHVsPv5AeLNWOQ7V9otpE6jTTfHtsydfnTzuJOxNzHVaCI5+5zLIYV20lF1sO03RmuCkZMb+/+KS9vLhamzgbuvYblpgMN8lCIKyKx0Uw32g3LEx8DHNtVrA7E5S1zUWJyIoD5wX0vNK9k1EdDZ2bk0PFdcDWLUHSIOvKYFuCZ+Q==
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 20:55:02 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::47) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 20:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.19 via Frontend Transport; Wed, 8 Nov 2023 20:55:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 12:54:50 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 12:54:49 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <loberman@redhat.com>
CC: <keith.busch@intel.com>, <linux-rdma@vger.kernel.org>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2 kernels and latest 6.6 upstream
Date: Wed, 8 Nov 2023 12:54:34 -0800
Message-ID: <20231108205434.5284-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
References: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 125531b4-41d9-4a0d-1e4c-08dbe09cfa3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prMIe4v0hU5c2grX/wuAPFAVq5zX/nX5efYmBPhJmMC79rieZNGgvj/Zu1IAet9oHvk+unhxE5cbmg4gjWSIVBkV2TYtfvR8i3jeiwOTzeFZ/KZp+0c+cPi+GZeE1nIIPDAWxud6yrYZRzWlIJicjx0bxBf8lMshM0jH6gEz4UcE8uR6472h81qSwmWvUTv1IlxEOOSoItJ2X66cMCKEDlA9IV62+VkcUmSHqpiY3MDsIJ9cDLxJN2i8Zqkmn80RG9m2C/8lg1d3qd0A1ti8M4AQOUoVK+vtONT5HXLAUidx0AWwvHV57rv3+9PObsNjjZ5JxP7O5FfVPfqiKoSdCD7i0/jz+AgKww/2AePIvCJMcuBdFIq20gNd9zildyoXZ+lowagvVWLkhIK+Pa5F+tPfsNsDi1vh0989zNM3b/t9H+0bJmEnn8xQwT/h7coDuZBiV7c0emPMbRc/z9CZCwlnj30K3aFcEfUNN0Qz0tDX4Hy0wkSXUNuQcfEUSJcFJWVmi3HRcQjF1/2v0LpaXveiuYpl/CKweRzlkWBsCd2o2+0CpQiYByGWHLdDtlLlJT6Tc9T4f3Cbhwm8Kl5zQSQXWfNLCafPGqittUhSlMv+BFbVASzGBZejos1yB85qKLs2E+MiYPy9ABJw9uyoksDeXZenlwatTZybaEw9n+R+MyWVBfBOfdNHYwJQ6T+sYSJ3++SNk9uuxROVBXtYm3nf8t9/EbrL1smMN8VYqqO3/N9oG+RdE85vXPXlVw64
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(19618925003)(40480700001)(40460700003)(41300700001)(16526019)(1076003)(4270600006)(426003)(7696005)(47076005)(2616005)(6666004)(336012)(26005)(7636003)(36756003)(356005)(82740400003)(8676002)(5660300002)(4326008)(8936002)(2906002)(558084003)(316002)(36860700001)(54906003)(6916009)(70586007)(478600001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:55:01.8855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125531b4-41d9-4a0d-1e4c-08dbe09cfa3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_125511_480721_CB3F6D56 
X-CRM114-Status: UNSURE (   4.70  )
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

adding linux-nvme to the discussion

-ck



