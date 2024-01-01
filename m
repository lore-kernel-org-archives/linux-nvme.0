Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43553C47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HC+ZZ/7kh5fsh+ps8dhRqrolwZeMH8UcY95aA1c5tWs=; b=nPCl1LnR9tvdbrUJbQ+ilLtUVJ
	rSC79Q44xTqR+zNui9W2aR0cRhXOoU35XFNUDvEr2RHQnzmt+9URjs3ZYkBer7UZPQtenmfPjBR3Z
	KQHDZdKOaDjo+1Kq6/QXK10ZPlSlFBptoob6aBCDFgfZGR8S6BmxuHomtRnfT9eEjUTpWA7ncNQRy
	fg4r45CdQwLvHdID77WRKk0O+JLXd9O3VGeBByUO/5GO+wKeXmhOv0DbbVyJ5bCMEKfd5I8CnAqiN
	/jJDTv+Qgh257ZDRnTIQNAdojjPgcXAwsdbEmK9+t7Vs3zODkcv8jidTpXmfslenhvk5Hp1K0agxU
	HihGXSJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKFeF-005tya-2I;
	Mon, 01 Jan 2024 10:35:55 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKFeD-005tyD-1R
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 10:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0dYePYrb0lmWCzYEmpaqCoq5eaKphdkRfY9TSAW976vl5iJYkGNd/IxpT2hr5vHCHyndARXyfZQ0rW6GEp/C6h1b7P5yQTqhLAZqalQWxrn680d4oiLlG6Fxz0w8c3AhMLqak7sds/3M4qRKEn0tut2UngsFF7PpoQ24RbtZwHVeVLaga2pjJ5qzEOQoiw+syW5vsdtce61lAMxWOhFSS+A/42hluKafr1YmokwsZM7fB1XAdtCRUSUzXoPS3AMMi8vTr9S0fxZms9Qc7pOd4yAKa/N0DdClXuVq8L7V3XYTnQG7gTDSWjU5DJ1X5/qPkDJrv/eu1pdIIzPhDJndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC+ZZ/7kh5fsh+ps8dhRqrolwZeMH8UcY95aA1c5tWs=;
 b=d39WaXlUZCiZzed1E4iaL2KgvuRg6xzkiswW9Ap62SclJ7+7xfFlHtx9vaBJNDyYVUXgQaxZPDbRKQF11hXDtQAVCKDpOBj6XICPnSrq+5hVgpSU4Bya8VxXO9ue5cBMapnlb21kGcK7Q1JZE1FVoMFd+CJNrFYiwDopydiFEHOA4SfKCtc7P0Kc8VuRv0qY4/LCtnqD9LgCrCQRZtIJbtNnA6zsxz1Y5vpMvd+HDxjD9ryde+uzKgRrTdNN2wzmYm+eX5EMngp1Z0+8byv1Ul8oDdag/vYjlUlh4ngO0HYY0lqEH9M9ceSIKLksFZzXuyRf0TsKAw/dzcHZKIF/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC+ZZ/7kh5fsh+ps8dhRqrolwZeMH8UcY95aA1c5tWs=;
 b=F6GTznZjP14rPraMlG+kLSfTb2Ne04ps/7qzqxP2RUMcynkalZo9rSZzYVj06jFqcnz7UcuoocaeyxY5yDzchJkvcelZdnrl1pO6noEUZddnUy19cP2vTRZCGP7n0aYovGU5G8ScwxPyO+teNnNX9qIThckSkuq3Ood6FAppNay4I5Ulk599rQmzVmcuuV6b+CpTM+q8meYauTcS8j0g9jitkacwmaKjolVP49S+BJ+AhU2GXsa9D3hePd+SZNvL4mPHgZrboPP3PfQ//cBtc6f4sKZTB7wZnceNpzn6NMBHAFsaIB2JqhiSSEl8AiSHyhr6eIp6uBSkzec7pXeRZw==
Received: from BY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:a03:1f4::14)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 10:35:43 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::5d) by BY5PR20CA0001.outlook.office365.com
 (2603:10b6:a03:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Mon, 1 Jan 2024 10:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Mon, 1 Jan 2024 10:35:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Jan 2024
 02:35:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Jan 2024
 02:35:30 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 1 Jan 2024 02:35:28 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <hare@suse.de>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme: remove unused definition
Date: Mon, 1 Jan 2024 12:35:27 +0200
Message-ID: <20240101103527.8034-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 6653ca38-0181-46f5-0aa6-08dc0ab56809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqybkVrRbl3i2uZeNCNE6eNH4bIdxAqpsq3D+a/s9uSla3VbVkkPS39x4nOyl37JocA2wd/08kT/Z4mNGDLt/ZzgUpgdKZ7rqoa5f4/ElKhJDeeZSHOEeRvZSQZepc/oZdaCIKd/pfSf9FagB6u7QugYneJezoPWPYF7ljmD4E0P1TgpvmbWPoVsreuuielMYR3uppWFr9qqnfTVGQAtWKgU+EgZfu1a64YO+UqJzxmIUFA+vz+y69uZnn7JcYYdN4hTn6CEztVfdjJFoGV1fsnGgiQxYsBguOCFaV4DLYUd1EQoKS2FJFA+yq2ShSPvfQtEYmiXmRqnWEMf8n0Z828PT15VCLyYtAKHWqBBYrMX3BcgmVyWClRfVM2hTqV2mRzq9LvqguyOxxPovUhGFRDT+luys03HGxZx6NubvYeHV/ChNxUzwkM5Tj6bXS46lBI9N47dtUWIyPqpQngiSdQC2LfEsnvVp6eP3jrlbeamP5nin0jomL7UeT8965cm3hWlhKEw10onvJQT1kM19JhuxJ1ebgXrX0ZESc1ttvTlc7O7bY49gr6Bdv1ZTXhnfxdl7gMZMA2APvV/exySC0AgW8vNdMvCUwzlmEO9K7sG4vB2zN5uQ5+ivygh+kEqLeF/xcbrhgklp8Dy+f6C2Irzb6HjatWpGy7zAK/Ch9m8QcbRqPP8nqPOg1jEurCNcG6NJOClwee0gSAbFnMm6HkBmgRVaAuwLK77/MqfyzwyWDC0XaHZrzo1EV93dOE2
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(336012)(107886003)(1076003)(426003)(83380400001)(26005)(2616005)(36860700001)(47076005)(5660300002)(4326008)(4744005)(41300700001)(2906002)(478600001)(316002)(70206006)(54906003)(70586007)(8676002)(8936002)(110136005)(86362001)(7636003)(36756003)(82740400003)(356005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 10:35:43.0392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6653ca38-0181-46f5-0aa6-08dc0ab56809
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_023553_510115_9D68EDA9 
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

There is no users for NVMF_AUTH_HASH_LEN macro.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/nvme.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 44325c068b6a..462c21e0e417 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -20,7 +20,6 @@
 #define NVMF_TRSVCID_SIZE	32
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
-#define NVMF_AUTH_HASH_LEN	64
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
-- 
2.18.1


