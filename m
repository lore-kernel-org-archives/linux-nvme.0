Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5B1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pgvqwcnvCpHNuqMv9qyTjBk61Rpr3IOpHVVIR7nhl2c=; b=hyg6zAvV9XWN6Gat75m8PjdFPN
	RCbJmzzr6D4GGhxuQGFL5uK/AOP9E9p7Xg4GfShMOfO515Fjg1apcA2e3zruMkc9ZoJ8qdvvLJAFB
	NhVkgqZXywZC2o9kOzdbb3kI+fKchFeKBtedRfVDFJlwPBDmzVPQ+reMJR5/M72hRPp+nvb8mEWF0
	29vvCTtl6zcrpP35a6KpYHZLii1XrYawq3QbUZQzU4/htsRkmGx0TkWgyaETik2yZEhoErwyoDPij
	01V1gMIVRts7bSAbrGn+V63Zqtkg4hZGsGybtvZElb5tVoz3psG69k1OcVyxiHpm9hxHXg+NCfvgi
	76vw8rbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZ8i-00EgTe-Tq; Mon, 14 Feb 2022 11:03:30 +0000
Received: from mail-dm6nam11on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::627]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJY6K-00EMph-Vj
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:56:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCNNzmZL2i6iO92GruuxlTCXrtoSoOwCBMvcWdQc0VMbWz9+tID9pyeMYs27d/NlmLdFWg7fqOWbUXYDQkGQPUFC6Y4lhr22DmEqQ8P+KQUiTrEbFO5I/EQviGCqEvlGNTlwx4ly1lnb7P3ds0eRPEaGf96QTBzYcR13hhyM6dPX7JooEEe2HIo4IUbpk57HZTW+qEA00Tj2yfEwdu8KOp9im1N++OAE4U44GTSNJLf+msrH799eGvHWMMX0o3JD39Tw6ZuXWEbzL9CJmEesfMRjKGoOJ938bOdhR18daSwfUlhe/YjFv3+I8iWUfJakd+gJxJ0bo69zNuCEmaTHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgvqwcnvCpHNuqMv9qyTjBk61Rpr3IOpHVVIR7nhl2c=;
 b=OjHYwgYDV4MR0u5ARFaEHV9hYVB3KZuCVcKPjlhrXwazKh5QegBRZt1unaAxKj2YAnHfFMLRppFsvpQio39Ly3ECpJjcuM8KLW5gURsqkwCZfJaU0BQOkUZaSEiEUGFJrtyVpJDMCh1NgXLymujTwKj6JEWVOvLMuj/EQAahf7L2gAcfuIuXGuN/wUW5sF2YK0IgUoVpAvpBOe4jf+Lm417hlnY+HMh7zyrvHPFaQ0X+5dH0DegNu1xTpf9Y+v8hX4owOJOgt/msGwyDr4vICvPjGV1yXYT9Ko7LoQsd7SAG6dytCdzC6qDD67c+m0PFn1c2yqN5JNd5CmpiQCwZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 12.22.5.236) smtp.rcpttodomain=grimberg.me
 smtp.mailfrom=nvidia.com; 
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgvqwcnvCpHNuqMv9qyTjBk61Rpr3IOpHVVIR7nhl2c=;
 b=Z1Lw8eF2EqTSMsV14dqeykOB/WQYt9l59IHhxTnok2da85p26by2ffYWe+RQcT7/4IolGn+6w5kFA1Yw8uRBU7jkj4a8vAccffTDqK9psAgMATdYWkXfHhlDA9xSw6t2kkGKvOD0dBvEZ+GSTidulWdR1O+wdfLKIDUxgAK4HW4fbIhlWKgIlWn0gbQktsSFyAyowUtcCERW8D79CDBUKjWkf5cFzOCtYqY/p7eMPje6iwfS9DbreVtxAjw0JOQvSG16u3NDwLlXbb20X5t7V4pS1zjmse83uXE9qdYTT9O7Yqu6UyTDe3qGedWrFkihW+Gmze23AfuoIpIC2ptpJw==
Received: from DM3PR12CA0058.namprd12.prod.outlook.com (2603:10b6:0:56::26) by
 DM5PR1201MB0153.namprd12.prod.outlook.com (2603:10b6:4:57::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Mon, 14 Feb 2022 09:56:53 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::a7) by DM3PR12CA0058.outlook.office365.com
 (2603:10b6:0:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 09:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:56:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 14 Feb 2022 09:56:51 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 01:56:50 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <james.smart@broadcom.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH 0/6] nvme: remove deprecated ida_simple_XX()
Date: Mon, 14 Feb 2022 01:56:33 -0800
Message-ID: <20220214095639.5125-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eae013bf-4b3f-4c48-8be8-08d9efa05327
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0153:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0153304C9F0D5AE1A74D8A70A3339@DM5PR1201MB0153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEnskMs3TayHMTcybwx9QqooKSf8B2EfwtYXxL8hYB1IhmKvsLH1+/z/t0v76/2aAvPGei2cs3fODlEaHJAWyiexpdk1j3OVeBeF0sMFzjBq14KfgyR9LQfeddPU3LBp++Gl3/mUFcH8I1RFhnavCaBmALjlCE/pju2hg2nzlKbqRsTd5FxgFrEG8mIR+txI341u8vFcpZ4I03vZz8BvQbMmaI6jEMFNrBL5EBovvY2Mbz9895koUW3tWbccfIRhspuDUqidggXUAiPn9poCJ6Xo12qByORnz5xwHE5woSkR8KbVIjMpIJD1EPhXCwQ/ldObEscEWYex8VfDEyx0+60SNGoLSoAr0KlWfIkgjyBAN2gr1LVFpHrgRsdmSbMz8Hq5MYKOg/IS9Ip/SJbRXrgbBjMQi4xto5HjY9EmD04wE/86XrzmZjx6ZknHcXjrt96sX6RTSsVUM4bCMDGEwnBm0KOeP5L2jzbhUH9R8r3XFFmzu/zxVso7GRywHlnPeUcoqGW0yJroPu8CLGJZh5a/egB6DCbMaqcafACa/Lb70vtNkRGrZ+0f4o/0BEeJ7cROO2S8kMIEKkdvNQolNs27kOHhphpptd++oLH07N7rNP4uMKU3FHWrEkg9bEtPmKOtw+ICKn1ydBPscOutkfc0MUKsdci57LT2rfFVDUWRxrRlPAa8Rqv6lv0hNyiPE1hhlCQK41B0VOgT2HgzALEl4VeDd/7nvjuX6uw4qrw=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(6666004)(6916009)(54906003)(2616005)(7696005)(8936002)(36756003)(63370400001)(82310400004)(63350400001)(16526019)(186003)(26005)(356005)(83380400001)(426003)(5660300002)(2906002)(4744005)(107886003)(40460700003)(508600001)(336012)(4326008)(1076003)(8676002)(47076005)(316002)(81166007)(70586007)(70206006)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:56:51.7292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae013bf-4b3f-4c48-8be8-08d9efa05327
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_015657_074118_856D79FE 
X-CRM114-Status: UNSURE (   3.87  )
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

Remove deprecetd ida_simple_get() and ida_simple_remove() calls and
use ida_alloc() and ida_free().

-ck

Chaitanya Kulkarni (6):
  nvme-core: use non-deprecated ida_simple_xxx APIs
  nvme-fc: use non-deprecated ida_simple_xxx APIs
  nvmet: use non-deprecated ida_simple_xxx APIs
  nvmet-fc: use non-deprecated ida_simple_xxx APIs
  nvmet-rdma: use non-deprecated ida_simple_xxx APIs
  nvmet-tcp: use non-deprecated ida_simple_xxx APIs

 drivers/nvme/host/core.c   | 18 +++++++++---------
 drivers/nvme/host/fc.c     | 16 ++++++++--------
 drivers/nvme/target/core.c |  6 +++---
 drivers/nvme/target/fc.c   | 13 ++++++-------
 drivers/nvme/target/rdma.c |  6 +++---
 drivers/nvme/target/tcp.c  |  6 +++---
 6 files changed, 32 insertions(+), 33 deletions(-)

-- 
2.29.0


