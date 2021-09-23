Return-Path: <SRS0=+tAy=ON=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0554C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 10:18:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6878E61038
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 10:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6878E61038
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gz8kEQusqhdTf9GjvT0FMgZTj3SwaZ8bvoyfo18qOUg=; b=zjnjqH52bq1D7U
	8HfOExNHDgC7muTzZZXCy1e0T+WEGG1o1RulhyZFoDGivKlXCYOB3vvRATDTbRgYshf7iS/7KldOg
	lElXlcOpOFDXx7IdA2sAb5d05jXp+U8cUM13tRGqIaXVuLBD7QaP9zcgK56cvI7b3WCwh3ZVwvuq5
	ecBDUg0y+BpjGywurRkuGdTzaMszpE9BHgdGshqwlhB7YNdsNubaw/nbdzelkyCctpZ0rC7Df04tu
	c0opCCpf7ylGnnF1lRH0xokYM+OHSirp5TYRoiJ65QVZdH+TRFPFjEJQJQNY9OPM80DmEr0CYvyAN
	qs/TAmt8kR/jXjYFWPvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTLno-00At0q-Oa; Thu, 23 Sep 2021 10:18:04 +0000
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com
 ([40.107.237.60] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTLng-00At0B-9f
 for linux-nvme@lists.infradead.org; Thu, 23 Sep 2021 10:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um6ckk+lJVxEH74QhSR7uC93Kyjw7ILEHaswBojDmpPISt6304cnDYJlGCAqPwxuQg8bMp2FPW12IhIoAC5OOoX34FRyvjSZRZSOlln87w/O0QF5a2W4K1mq5BkXZpSUo22IHONntqhAOYNm8O4M8I/vtGHHe1Ekqj85CJE2sQfqJRpgQI7EUSuzjrzQGjoKgDJNlxx9QpSz3u9jPzgnHtOcqFFY+kzTrDxtXBcU80nzVnKujo0Izh7mc/it7dekkh8vd6hve8kING+t4GAhnXBysXiTzYoDem8WllAjS226iR6ywa4ntqRbJmu5qbxSJ6Boy0krDiIuQd4sPfWoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=chK1ERmU9fvAyAcD7zJoC0eqQvW/qFT8lU9tIGnpDfE=;
 b=J9uVQmjdlJOMieTB4x6BEyiB2ggp4VO7VH3ALhDFdKasPjR+PnCltmT0OfynfX5h8M75sGSGnhxXItY4C6BpSydJRl7SsVvQ/ARrmy3lJ7EiN7dRxvlmla2HLWv3jPI3nezuRSFd4JQ8+LOsQrlkClL4alzPI4FZgq4FMxSUzAPtlk9vvA3J/ifJ8KPxt6U2wDtv7ud+QoGQxhEtpclPqtXXL91BFM7JwaaQyYEkifRMq28C7XGEiTfKcFpsDR4biQlv8SfQZ1WDWDqyVV1SYO8jxxmV1G9WjGOuU6E9wiZEKn2t7v1qAiXfcyHaTwr5UQe2npv4qspRion7z/WuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chK1ERmU9fvAyAcD7zJoC0eqQvW/qFT8lU9tIGnpDfE=;
 b=rBvpLaYI27LMYqXafp2kI/8pcmd8JAv9lfoNZn6bgHrR+ooG7hf5l5umJPpgWx8Rtjk0kQ2fAi7U2yDlksvg/UIwJf/4J4kQ9EdMDYnJ4jKvwyZW/3pVN/zVc64uClbrzK9OpThn2nK+53uKsACScc3/OYoGOMqhVWOXbBXm8DKXvw4JLrNfZfSH9atWSivbMYrKlIA//YxbyFWK6xE6AYmioEx0xh3LgqGam4P7OeA7U5XQWV25TW8mru3p2WYv2fBDXTK2Cg/qFlSOsthNl9Q2s01xNPQbuMWK5ET4uDJhVLhf3Qfa+dKlAiunGXal3ABYz3AT5mJjnRsKXBC0yw==
Received: from DM6PR14CA0069.namprd14.prod.outlook.com (2603:10b6:5:18f::46)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 10:17:50 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::8f) by DM6PR14CA0069.outlook.office365.com
 (2603:10b6:5:18f::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Thu, 23 Sep 2021 10:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 10:17:49 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 10:17:49 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 23 Sep 2021 10:17:47 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
Date: Thu, 23 Sep 2021 13:17:44 +0300
Message-ID: <20210923101744.4204-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210923101744.4204-1-mgurtovoy@nvidia.com>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a7888a-6ce0-4bae-0e09-08d97e7b6584
X-MS-TrafficTypeDiagnostic: BN9PR12MB5164:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5164F8F1D5E09BD90177D38ADEA39@BN9PR12MB5164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DG1RjAjv00UqMD1UAXoJ+bAsJgrX5OzcEs7ruQ9i8r7nk5LU8++Pd8rksOnBFhOdfr4C8XKFDzzU+va5j8+x6xFCcHKXlr2NpJow+DlVarYU8MflYAajJ1TUl1iGpkUpGa/pDeqZCTd/A3jCIPcgZb1UTCNPL2/klvoZaR8LcWhEw7VQzm0BirpBF7PJChvePAd1KN8sclXzCYKclG0sPcFU/TTMsv23CJZYCr3sC2Bjp4681CCV5t6gYm9tryhPT20gDDHMx499MmzOnuKgyTkdqKXH5cMX6HGQzOMASe5lDSzic22W0Caelyh0dtI+OqCwix9wlbeJZBmlm7zdZjmt2BsoX9fSoqIvlW2xsxoS93DpRMNLAHIWA2ioakxmRRQcdXfq6h+RGXKZjYJ3acIfHnHc8hcibp/ii2Rz2ZLvlXmM42FvOvQQ+P0F/eqnXfmWoBIQnra4OD42mubsCbipKKpfBEvFjwbDcOEFwBG6rDQKg2l5iZv5TQF/TcJsvHWsyaHqFdvzF7jR1mIMqa82/8bSnZqPo4gsdigmHh4aMrIUXqGQxjEJC8SMIFGXf4ETUdLO5it+GFGLl2QwHnaGPrreZqtJvRtrZuT69o8LeJ70R6bZWdZTzX5r+n1F99ktGanYzjxQ43ZXr+ocXVMMLOoZY4kAR4S4DrOw8/0X47FlT1SRW1HGe5v2ldwcItru+wWV/+iyHmiEt+DWGw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(1076003)(426003)(86362001)(186003)(47076005)(508600001)(36860700001)(36756003)(83380400001)(336012)(2616005)(4326008)(82310400003)(36906005)(110136005)(70206006)(8936002)(70586007)(6666004)(107886003)(5660300002)(8676002)(356005)(2906002)(316002)(7636003)(6636002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 10:17:49.7826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a7888a-6ce0-4bae-0e09-08d97e7b6584
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210923_031756_403604_656A8EA9 
X-CRM114-Status: UNSURE (   9.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This makes the code more readable.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 3 ++-
 include/linux/nvme.h            | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4ee9fe134697..92d81dc5906b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -380,7 +380,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	 */
 
 	/* we support multiple ports, multiples hosts and ANA: */
-	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
+	id->cmic = NVME_CTRL_CMIC_MULTI_PORT | NVME_CTRL_CMIC_MULTI_CTRL |
+		NVME_CTRL_CMIC_ANA;
 
 	/* Limit MDTS according to transport capability */
 	if (ctrl->ops->get_mdts)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..36662641fd7b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -312,6 +312,7 @@ struct nvme_id_ctrl {
 };
 
 enum {
+	NVME_CTRL_CMIC_MULTI_PORT		= 1 << 0,
 	NVME_CTRL_CMIC_MULTI_CTRL		= 1 << 1,
 	NVME_CTRL_CMIC_ANA			= 1 << 3,
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
