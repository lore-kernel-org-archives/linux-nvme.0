Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBA6C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 14:30:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B836504A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 14:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B836504A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2eQ0B0+PpBCZf2z+LdDj6wZZB8OvtP8pZPqqYbbIAPc=; b=Ikr29dP59P1SfNY+cYbzJY6Cx
	JQ29DfH5EfXOVcdM61o0ExxJlsyn8Rc3VAm+kMppnRC14sbexaent5hJouzTEPEpSutecJPnNt7rP
	N3q3zpAGZLRXdEwq65ppEDpiQdO6YmDzk/J4EFAphgHLs2xlzWRMPXj8UcAy+8jwXBeao48r61Ney
	rsOP1EaLlbO3TOLv2Q/LVGztKO3N2LCtvfXLo/CpQSDAB+srXCc0dRmnYz6Ryc9bolOd9021i8UQd
	5jaoINSpBW6IFhC5vXR3KdJbuFfOg5ph0WEXbm8TXLQp9JMIgcxSFtOM40WtPf0VvJVm3E1gFB7C8
	IqjHKD1Cg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMAhi-000xBL-IQ; Tue, 16 Mar 2021 14:29:50 +0000
Received: from mail-co1nam11on2073.outbound.protection.outlook.com
 ([40.107.220.73] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMAha-000xA8-25
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 14:29:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWlKWCvxn33aKn5rGgLVp24l5zk/7er/ErupDA8relJ6sUO3rJB5ysfe0KYxJ+ih38tv71/nMfRMBZrvzmAm4S0FAArmtROiyTWyZokf74LEP0VtjmddQQ4XzlphhU+J0Sk3oq0WErGuf39gBz+O6E3EtVASSruhkcpgb3YTkW64afOWqWtSeiGSkLbYS8voms4CGGB5pddfs96YZLfNEGXNWYM7eZ6iMc1gSt8dEAZ3JtSsXRSuuYU3F/EzxVIQnkk+0tarSw2nvfgzsHvlEDgCmgNBcT5Sx4yYdTknuh4SDGrbIB1UPTuj8eaiVRDlSLCoggj4jcdXa54lqNe4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykCXfeo2GBqJ+B7m9+55cz8Odu6NDkAZynU6HELsQmo=;
 b=I+ooqu7jpGUQ3OjGCWDBsdlpveUTAQ7sqF6crbyFeytW5hunS9CNhnFJSXMiysVVWyFfThMXbShfPFuYN3eF/S+nbx4IB2JQ7rM5IGr+SRD+yB5PXSva67aCd9VAu76j4ZytL6JSUa0m8fPvVB4nobjn18IE+nvRQ0Ikz6uh123Ubu7EgXywA7lo3/DgAeNn6xKIdV6s5heRKg+m0OnmUDwA4jFhTd0zu2np2OqgA2hFCXB2s5a06bgqPO8YbTadDmFHCb31eZcj6joFuQ23YveIrsfM49o7npgQ30zkgM7SKGjbQPFCHgUUwMC1FCQv/y7SfCzD0ktCOo2wa3d1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykCXfeo2GBqJ+B7m9+55cz8Odu6NDkAZynU6HELsQmo=;
 b=gGvd50OQFjHz1ksMEHP7JO2ZP9ubR+d9p1dMVCtGqbwb24kBkyNUbeSWoKQ9HHtn65xWJfAZRV+0uA76ooRUtWb1TmBD8T84XLDQtZ5YNleRXOE1NIzvpftoI1YMeOsONVfukJTuFGanRPjDMWB9qrDCRv/MF1Qx6+bY4EhXVqnJldiG28rYhIXgGNcdCN561rJ8MDEWtVshav0mm1GM23oQQiDLqIMBismqgy3/Kv/kwvK2VhDPKLCnKmJGwkYKM+Mg41WUNdOTjjCng73nQHArOPak/sw4RM3eUaVQjoIFpZXzHNZvwE9t4UZOXnV2lMqB1N7ZfGe9yFQZu8YjLg==
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by DM6PR12MB2634.namprd12.prod.outlook.com (2603:10b6:5:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 16 Mar
 2021 14:29:37 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::96) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Tue, 16 Mar 2021 14:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 14:29:37 +0000
Received: from [172.27.13.197] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar
 2021 14:29:35 +0000
Subject: Re: [PATCH] nvme: fix Write Zeroes limitations
To: Christoph Hellwig <hch@lst.de>, <keith.busch@wdc.com>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>
References: <20210315093438.66082-1-hch@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <854ece5e-4c1a-4f41-0c26-32948b21eb6b@nvidia.com>
Date: Tue, 16 Mar 2021 16:29:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315093438.66082-1-hch@lst.de>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1a7d476-977a-4a02-4bed-08d8e887eda5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2634:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2634F17C5C67C999710A1FC1DE6B9@DM6PR12MB2634.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYUj2CiQ29xBJ+xl16pLhsNjVJReXf28pExWebxmR8tJjPLP21pjDQtDBwd2Gh5r4l2CgXXksabbqbxxNO99oxG8uB+m7NDtJltYa+ascetbgqDaBFuHKAkIlC1gnAXWE8vGjEiNZp9AivL/Mq95/zepgt/z/EpAZ6GCZNxPwS/5Onu5m4WMgXrVqt1hVJQ1CcUChIYrayLtJrV9VxYV6Tc4K0I1G7tP8dY6PhLQsbE4SGTcGPCsFwabonzCIMGFLQFW7rOXcIYBD6N9vVzcQybTOXnME0zDdyIMWRB3DGrR5kR7akyAbAGTq7NwGLD/rQ9EOErnI4qN85vKPMQiHsAu7igVQbS0zxnqgpSDX8SG10lyVR2irmIOIwI/iEhXh/MD1uWcfoVSCdPJ2IqM52vOqvDT2DqVMIwiFoGoBZ99YMV/QyDA23dIxpPVxlXdNfbbwY654699/xBL0iKCwYdwQM099ZkpGzUjXwpIPcMMEkJUN8LyPTXoTL7fCLKb9HSs5jd/x6jo2jOXN/0M6caSNVBHHexmBTnDk+ZtSmAMVnweBER3myT4lP/g1uLqHpdK0djufkuMa0pR9yLVMWiBDjYLzCN69++r34taooBEY7tvHBwTVnfkuQdsdsVOuEgcsZBu2gf8BW+1mT9vvH+RBg5w9jEdnaJsiIwE0Iyc6y4m9W6RyCun3kRHvRYoLcpbk1unEXZly/3GiCPl3A==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(2616005)(186003)(110136005)(336012)(70586007)(36756003)(82310400003)(7636003)(53546011)(6666004)(478600001)(70206006)(26005)(356005)(426003)(5660300002)(86362001)(36860700001)(2906002)(47076005)(36906005)(8936002)(34020700004)(31696002)(4744005)(82740400003)(316002)(4326008)(16576012)(83380400001)(8676002)(16526019)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 14:29:37.6518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a7d476-977a-4a02-4bed-08d8e887eda5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2634
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_142942_585926_8FAA2042 
X-CRM114-Status: UNSURE (   8.83  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/15/2021 11:34 AM, Christoph Hellwig wrote:
> We voluntarily limit the Write Zeroes sizes to the MDTS value provided by
> the hardware, but currently get the units wrong, so fix that.
>
> Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
