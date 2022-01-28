Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23442C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k62ULdvtdlm31bN/5pLoRTHBHWuFw08PQBxbikYD6U8=; b=EqzsP93IMtss1VlfRATWpoXQE3
	Oam82dNsPLxdULRSyISEUWu9XKcpJba+JnX2u5hp7raBmfweuQkFanTviUzWcHcMzUKWl7fj3cRCv
	VNaCKY54nc3bfi8sirUW2EnlabYGG6Kvu9N9bxvnG1DwXd8Swz0QsE8IqgkFFOKtvfF9rY3YiheAi
	otwskrj7782bTmW1LGtK7Zb2Kx7r/AoUWWUsW8pnxyX8/oSMNcfOgcU8jIIMdQjR+mS7Uj3EdhQwG
	TSYL9xaE19tfsMuJY26ZcK/lRgeY91MK22iDCxPD76SFyE/1bV/3nzcRAgWCecUVYZCrHBhqmsLsU
	p9AMdheQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDMzj-0014og-Rn; Fri, 28 Jan 2022 08:52:35 +0000
Received: from mail-bn1nam07on2088.outbound.protection.outlook.com
 ([40.107.212.88] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDMzc-0014n3-T8
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 08:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFMi3MBdpccgrxf+WMR8Jy1A4O7ey/N+sgSRZxF1G7NiEBuJnfuK0Qw6kt2F2SyLm+82XWG4h0fZN5CyCrc6uoCt5J8+TsQfYMl3u8eljCgYaJg466H+6P0+yDbWbZk/lZtsSdnnjwgeA0JxpOAdh1TFGjGK0yJucIinAdC6DXmv1l7RdiApvLrXk1em3rsBGPe8qHPKLqBf0aI1rAWNtz4/hffA0hh/4+ddfMyRZ7wKlVPTIa6S5vVOsM4SWpa9V+y4cyJMazRD+NHdSQhPta0rvP/XQB1GezEPtmMcMvfbF0GARWkYLhGJsFtYiTyBCt3nk7uPugpY7T0JskCMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k62ULdvtdlm31bN/5pLoRTHBHWuFw08PQBxbikYD6U8=;
 b=CHlEJgjPJFDXbGU3waMu9B4FrvxvaYX41wsdllwnCIDFa03DF/zVYdVyH1+Fzr1mK7zxMQBCBolqJJASo7RIbTgAgZZ9V/KPTD0lQNKxw9y5mQZrILbTccIvLXmf3NftYSTCzVPiilqFFVvKhnORYBWdI+KSNa0IjU+owy/3XnqreL6ZLUbGVJgVUrgSC52BdvHhjDW4A0VGhPV14NB8H1y0JLtVJ7toRa37fbbJtYXxOvz+uI+cDEMT4AECMzbglfJjZK1g3vNBYltTZBJJQJ3Gkg49XW+2pq+tW6wAgy/sFez6JdhpxRQI8pU4TVJrRKF/f49tvMXdcgXBZtzNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k62ULdvtdlm31bN/5pLoRTHBHWuFw08PQBxbikYD6U8=;
 b=fI6M0XfbLRZhXg4HaNx2S503Kc1hXQm5RBNzJvrqjT1Xn1p6ltXtvTobuao1wnJ/u0XNL8vmOHWRZ0adIK7fF4fWMxetWOhO2AyfR/Xv91kgLj78n1gnU2BblNKHHqHEyYqXprVFbROwaMSu2pH54hmH57w8cVQU///SFUyYgSUvBDc3EPDgymctd6vXdUKVf3EZbpbyza9i4RWO4GTo5MqIeNJoOVDuxfT011wnhnWNoqjO7XZIR08pghDeojoMOqi4A6gX9bSemiuxk/jHFFyfgexOvW4irUo3p8zZqYTvxXVeFROXpI4IgxJQGlrnYRelVCXILdylgyjj6UlCiA==
Received: from DM6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:5:1b3::36)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 28 Jan
 2022 08:52:26 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::56) by DM6PR17CA0023.outlook.office365.com
 (2603:10b6:5:1b3::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 08:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 08:52:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 08:52:24 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 00:52:23 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH V2 2/2] nvmet: allow bdev in buffered_io mode
Date: Fri, 28 Jan 2022 00:51:48 -0800
Message-ID: <20220128085148.11638-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128085148.11638-1-chaitanyak@nvidia.com>
References: <20220128085148.11638-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e496a95-e309-4eb6-928f-08d9e23b81b6
X-MS-TrafficTypeDiagnostic: BYAPR12MB2984:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29841EEC041AEFF6E21F1E68A3229@BYAPR12MB2984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btgxj3Q3aO+DIllJJ+loTUB5Ks6ekgXjGcqPSGCqAHI/pjjmdK28PcQLWQ2DQDOEJN6nFJz0XqKFZzPNYc8gHpTgRdMZxceKWsui8JXhePFRhs37LDS1DkCs/2OiMH7fEsGsHOFGJlibV4q1rfyMQUP/TDL6R+dT2OQr60rm/JmFeV7ja4+vb0rhgmmXKpctvAc4tq/uIOsvGCjzVj5E/ConYv8sCKy+W4Wd3ZEEwnTT0178gwKX5vRCjSdANrQboXpiFHen6PncFM/yPzI0JJNFLhHgyIlkzKfarmwVz9jT00p0EWOOyMxLa44peqH6h/bDutMSpamywwBlQfsnRhauASgi12gsuR/MuvrXsbbxfrh7XHnCnNPDuhQJwxmlGyx7K4YFAJlQXILg2O5R0GJ/tf5zw7Y8lHNm9sDqz6dYbnvRkBpVeIfYqfHy/j471pJoC0ku4OuzAhQAAXX4o5gg5/mSzLzhsy74qLX+zQeYmP40OLvIUVXdiXbtTyLQBy3yChpPRJBjR5fON9Vy+Mz9JXVoeDAFkSziKG8AslhDd/Af/63pSzm/FxFofkxe/HzX0W1/fzZ5Qwns6D8OQshx77Uo5+eV3KrwPRzH9CElbkLZulHZniWY5BfuT84pvUHHpsPDMa1nsxueB+ejqWNKLbfPXf5vWlZm/T6TU82uhp9G/FqQrgw8I6kxZU/1BCAE1cnmjhgWAvPWwDyJ9B/fn8AHJrrG1Oecsbm4RMfl8S+rbewo7nDXS+l4WYAKemXUNOf/y1PDI6lcP20PNLRrl+9ISOiOolHT+P4Heu4=
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(70206006)(2906002)(107886003)(186003)(47076005)(508600001)(16526019)(36756003)(5660300002)(40460700003)(4744005)(82310400004)(7696005)(6666004)(36860700001)(8936002)(54906003)(336012)(70586007)(356005)(81166007)(8676002)(1076003)(86362001)(2616005)(6916009)(426003)(4326008)(26005)(316002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 08:52:25.5715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e496a95-e309-4eb6-928f-08d9e23b81b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_005228_977253_014FED47 
X-CRM114-Status: UNSURE (   9.41  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Allow block device to be configured in the buffered I/O mode by using
the file backend. In this way now we can use cache for the block
device namespace which shows significant performance improvement.

We update the block device ns enable function and return early when
buffered_io flag is set.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 70ca9dfc1771..7f6dee625f7b 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -76,6 +76,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
 
+	if (ns->buffered_io)
+		return -ENOTBLK;
+
 	ns->bdev = blkdev_get_by_path(ns->device_path,
 			FMODE_READ | FMODE_WRITE, NULL);
 	if (IS_ERR(ns->bdev)) {
-- 
2.29.0


