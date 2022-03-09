Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F34C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wLrUIrfrvcXq9tpWtAcIAD/O3cTzbozr8dQQ8hgwtKI=; b=T2s5PLAjuV9jBq/2xB81t0Udmq
	48wabYMmujx4AMBwCRbceG3TRpTrE87JCehJ9hpzXxu3xZBcIECmnaWumjrmm+nY/dq40yTloja9v
	aPpipJ0se58LrldCmPd7aNvBsi2Gv8RdBO9gQEWiTqksEBiLM2pWvTHsockVni5YQndvj3ztqlLsh
	v8HfddZXcZI2OOty38nJ231EBMxOchRdfT4E8iIc5QkJRXltBaWNnA/mr/yUj/Z7rvBuoD/Oo8+Rs
	sTr0dwUPlKmBypJjC5/9sfdZwgTWjd00mgRaEkOiGqQ1eP+lz1NSqJsB1dtZNLq2rBukoKrsSegGH
	qvq11cag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRznO-009hc0-43; Wed, 09 Mar 2022 17:08:18 +0000
Received: from mail-co1nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::606]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRzke-009g6V-8D
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 17:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcokulyDHsK9d1BhI2MeU2wBswJSpKLoZGP8bOSYknsqpxPW6//epM5yWEVI9xzefCOBdX1FhfF5SdEIES6uHJDAY9JekAPdgqky45F1aPdme8MnedNeFZCdyiWRIXubODMfPlA/hvNWDmOuGpVfftkmULJIaCQXJXedXp7ts05UwszC+MGQFh444IIVLW46LISszEo1Y2brsFX8yOy6aQB4aKZ5OxwJlbvtUd3JXxWVUU7jT61Yw0FACyq4uPtL7bq/h3y686ITKACZwo6Bn6zeUCIGDIJP6g3/FCW4oNHF0zPANilhxoo7atOJBY9bLosX0Sm4ukJK+gtZGx63Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLrUIrfrvcXq9tpWtAcIAD/O3cTzbozr8dQQ8hgwtKI=;
 b=ZenbrkiJlqcXNFPhKRN9z4VHMRdIZnBRn/WVi6PxmR4aUQn44JoasyUsHoZOrcd/xdCPPrWOJF3Ci8WEQtKdkTdvzoMpMFBpjMdVB/NdRk6VdAL5IydWOJpz+sjwmHAvWuLU9l3mgrlLo3PUQtvuNA3e1aZeCET1zkhOcGu1F72MGy7B6cK3pCUBDQgrh12pBsYC6Bs1hhadnpX11te0ZR4oV8Osr/tpJk+H92w7c9RY0t3dIdZxI/8VyeQgbsndZYd48c4yqnBbUnh3xZyTt+iiV2ImgVlWbDD1RZegL0ictXrroVv9f3p4GAWwdiPsEeZGjxUvvwRVJ1L8gJSaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLrUIrfrvcXq9tpWtAcIAD/O3cTzbozr8dQQ8hgwtKI=;
 b=V074fgtciGyk2XntxnWkYyFiKrF3YF5/kMEgwSCGDCPix7e3Ll/hL+gwStAfdJ3Sy0pPQyqPrcbl1rH9grcnQRUkxwgeJ54RxkSkUKNOHMcZkeT4e+LuOUemffFtaOyZtsimz4FtDDCSKOty/bw7zeYNCyFdxrrNwUf0QQOLTsendiYDIrB41CsuU4QLZBcRvFRYI+bXgQS7qr/hrNj5x8ekAAN1ybhz1hMwAUZmduaYGk/MEvOZ1M4cgRmqSJ5L+PGZC1RjsqsFYmGxojGNjdLuutmgPS6Zq+SF8NrWds2ZlPHQHC4tgrOkPggqFUuIOUrOBpuLAqGu53jhQWF+Gw==
Received: from MWHPR18CA0035.namprd18.prod.outlook.com (2603:10b6:320:31::21)
 by DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 17:04:46 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::af) by MWHPR18CA0035.outlook.office365.com
 (2603:10b6:320:31::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29 via Frontend
 Transport; Wed, 9 Mar 2022 17:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:04:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 17:04:45 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 09:04:43 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [RFC PATCH 0/2] nvme: nvme_setup_cmd() cleanup
Date: Wed, 9 Mar 2022 09:04:35 -0800
Message-ID: <20220309170437.4448-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c352c46d-642e-45d6-a138-08da01eee960
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25839694C4E41589090C7033A30A9@DM5PR12MB2583.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fl072EOCkLZf84GHM8PZ97vzspRJ2o3EMFKND8cz4C4R1TkuJyHI72XECXBWgaWLc2u/HkkU3CTjz9rVY5dYa11Bu0wfC5Ek0/6r965LzYdek2nGE6VdAmPxtyQCJGNAtaG4pv22xhF8UttE4QZ2jzlNIZ9JqBtR7t7D9uNChcxeIbBCL9hy8UhDxBGqMRUQaaLTHuFesX21Jc2RStHcgyKx7egw7XOsiT/hZS04VPJEHTS1YgvRHI715tcKbp8PfYGsQUFUXCY2bEN50I69E9YDxPzWnEPAEVh4Xe+gMkiCoHjFJCYMaWxZovfEbEue/PgG/GJQTkNgoXpDxODwcy99QJ1Ys0URyLlRzimAHK/jD9cORZbWNW50Fv/un05Mjir62tcIeyus583bw02YB/0ihf6v83Q7oh66sJkO/YUxzWC7pyCUPHv+5AOdjWmXmmK5ujv4AQjmYNRV6RGh3BtemYE+wixjEAOs1qNQXkso5dhfICmTti7BeIlawD4nKMR2Cgv8aaBmWgAqovSwaIqwG5oryV7SF1yKzH22CkKJOSDg8vIdxUrLU1euE6TmKGpetfAIt5o7a/IG6i8aCqsRG2udJyDI6XNfW+/UCLgvhU/t7/yWQuxeRfibGuzRfpy195YeXVT1yg0V4S8YKgoG9j40W2piKQqZT4BSu+gOH+BIE8eD2xiQwlRVxVWRmsA3lsKCcASiTIoZ9ZfJQQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(2906002)(26005)(5660300002)(336012)(82310400004)(426003)(40460700003)(186003)(508600001)(16526019)(1076003)(83380400001)(356005)(81166007)(36756003)(4744005)(6916009)(107886003)(54906003)(316002)(8936002)(36860700001)(70586007)(70206006)(8676002)(47076005)(7696005)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:04:45.4521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c352c46d-642e-45d6-a138-08da01eee960
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_090528_341205_C5FCD3BB 
X-CRM114-Status: UNSURE (   5.94  )
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

This cleans up the nvme_setup_cmd() so that it reduces number calls
to nvme_setup_zone_mgmt_send() and nvme_setup_rw() along with removing
an extra parameter to those functions.

Full this is partially tested code.

-ck

Chaitanya Kulkarni (2):
  nvme: derive zone-mgmt-act from struct request
  nvme: derive nvme cmd opcode from struct request

 drivers/nvme/host/core.c | 27 +++++++++++----------------
 drivers/nvme/host/nvme.h |  6 ++----
 drivers/nvme/host/zns.c  | 13 +++++++++++--
 3 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.29.0


