Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B909C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 12:08:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0A76115A
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 12:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A0A76115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XA/bmP5xM1KZkeHLX5YjUm63cg0eupan4EZ53OAxEMI=; b=HpvwMr+7/ARZ8z78WkNepi8I8A
	YqkyhLBWiWkqok91dWJTnPxvGGdlGsv36YedyiNd0nZU5hAnEvYdI+bVh9sGPIQyH46WRGPMBlu6O
	WQN1sykjt+4/7SlU/uOO5OZLgTk7KqVTpXOnuDXQtNmyJAKiUWQmf5/hK45HkjPBDGpGxXa9yOh0T
	CS/TvnAOBZge7TxmZNyWflq+zrMDoiRo6W0x6/lbdqtx/zJGrBOe5Qhtpz/gM7u571b2CzOChCk6b
	2iE8eap+BVTdm5IoUHeK6RaSQfMJprg+H1Lkc15zXGZPXYaZMJdZmA6wZbuQ3T8JjBZYFGUVLUAek
	gmtxNpVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkPve-001vDU-Dv; Tue, 09 Nov 2021 12:08:42 +0000
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com
 ([40.107.236.65] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkPvb-001vBt-OF
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 12:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3hDgC01vCn9jJW1KAMxiXHs6xXepqhyOWM4lDA4RYTqGDcIW65pCD6mwtQg5nOoaOnIpnYgYrZW8g0ub/P2kSzaBCmeNB1wDF/ITFgw6TqgSiO4i8+7LZ4YF211k7AmRmM52yMX+OeZAVMeyuFX/QAmtzPviQMsPxwXXVukKkWNVACjlKp09o6sUDuxmaLRBAosJZLT7s/AFlq3KVAbrHdIak13EfaAprBgiGnVHSPVwBorQS2FpTUyDkMWptQ4EQ2AqAo/RIbpHSOCo57xHYlFUE2nf6DpzsSS6BsrbzVW9KZPQi4G+7GM1CYffI1VZAFzNH+szZD5ZDn78Pqodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA/bmP5xM1KZkeHLX5YjUm63cg0eupan4EZ53OAxEMI=;
 b=LHA25mEnwLmP64nBfhhDq2a7V1m4JkinQlwtAQmYLEPpLxDl8CuluYyF7XTFnYXiYnlGDP3rni3kND+uF5wQfE7fpDbWVDK70K1VDYDe/DjBMZ/1wfVaMC825oCm0zVxJ48PnlSfLfzivL9tzo59jg5t22qYLTqWiPzYXJrnBBjZDIYmW7x+pY2HZgnJZsL08pqZWXuXncQ3n4LuL9YrmeFAJCMFCV7Qv6ZBy9rTkFJcHVDPJVwaBuhuVzK/RLpWTXk3eTXjT6rgFWkAOn62s0A4DNjvCYOoBmxuREMYBIBGS5jD7wGcxOegvU76f1wCe8UM2TSy9rq107dUOr2hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA/bmP5xM1KZkeHLX5YjUm63cg0eupan4EZ53OAxEMI=;
 b=fA7HwFEcBj37PdRaox++jXCYtnCz8rSfwgecOkUmkIMwFACMF5i2lMBoRt/YA1uCPy9rCyUSqLwEMsPllcto4CpsPGz617xnTvFxk7trGisG8Cc/mwou2Gug7/N7jf9UmhZsd6DHegr1+zrEuPcb3ht2Kk96M6faI+J17H6mbHjfQzs6CelKvDsSfK3GCJdnIgqFeejDWgYTNkAYxngesDza3hxRZQavfS1j4pa2zlQKEUGrH8LPSEZL4av1KX9QOXougcFB3ndyfRdOG7e4lxzKj7TjI14+ceclMDJHTIgpGnhiKzRoqvGZYu23TY9hWewEPooijWvEgJiDcVPsBQ==
Received: from BN0PR04CA0145.namprd04.prod.outlook.com (2603:10b6:408:ed::30)
 by BN6PR1201MB0145.namprd12.prod.outlook.com (2603:10b6:405:4d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 12:08:33 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::3a) by BN0PR04CA0145.outlook.office365.com
 (2603:10b6:408:ed::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Tue, 9 Nov 2021 12:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 12:08:32 +0000
Received: from [10.222.163.47] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 9 Nov
 2021 12:08:29 +0000
Message-ID: <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
Date: Tue, 9 Nov 2021 14:08:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211109080903.GA28785@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ff5faa-b798-4dc4-890d-08d9a379a65a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0145:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01456867084873671A91D062DE929@BN6PR1201MB0145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZgv1H+zV/5aFVcz6jmBBrYhY5mUMRIln2RQ2dY3g6yliEOuZIV1bdcA6zYMwmodoMnDe+dGvtJArm/X4KPiHhQVe7uD0VQtdzbQVyMjKNbBsYHqgMsNFi0DhvoQBhFzKqwLmqNubnm2g6WFCDFLk0sfgjp3z0b7AtXmwlN0ZVlDRnwXdSIwrfeFGfGZrDxhI8XOSHJhh4GVjuUqSj4eki6U6VcyurhoYrfT75TSqYPkmGtQoOAVF4ZqDsLo2s2pMOJGI5tYGx/T9odVsOfPEaGw5nyHsmTnJSQpmz7ReuCcp5h7XdybtoitE8WuczLVDOTSD9psd9Jlf9ZQI9c5w3kreT9WeQq+pnCzbYcNkkdQT0vi58umvnHP+9QgSkdUP2yFPGoFInEZXNWy/cj87MSsi4xsJTxcitA6+NG7U0YQH35nc7dneQPCfHkD6c9uPiX7MOCuHVbQeIf9jDS3C4pA7cJNsCK6+ZmlYb44OTyN4iBK2eBVnSfxm8+G8d56Wgp21Q2RnNHh3U90905YO9fHxETdQMXUBOOJ0gi6VSg1MFpyoKauesOtEvHTp4Tz7RBtPgwPgxHtx0ekXlKLq/5SP6+d+VQlbqG8sIa9a4qutqi8vCuT4lOYpk8WseprYYdt1ZdsezOjlG8tq0vmKJ1op5Mdn83rw1DLD7T6HwgcmJ3bKfwzDEHoQ1KFc7wN+OvQvmPUP+rcZVWjSRavRHL3Vl2iGpiSfbjGKXDpkkc=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(36756003)(2616005)(31696002)(2906002)(4326008)(83380400001)(86362001)(54906003)(110136005)(31686004)(53546011)(186003)(26005)(5660300002)(426003)(16526019)(16576012)(7636003)(82310400003)(316002)(36906005)(508600001)(8936002)(36860700001)(70206006)(70586007)(8676002)(47076005)(356005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 12:08:32.5338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ff5faa-b798-4dc4-890d-08d9a379a65a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_040839_834465_9E23433D 
X-CRM114-Status: GOOD (  16.16  )
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


On 11/9/2021 10:09 AM, Christoph Hellwig wrote:
> On Mon, Nov 08, 2021 at 08:45:11AM -0800, Keith Busch wrote:
>> On Mon, Nov 08, 2021 at 04:46:57PM +0200, Max Gurtovoy wrote:
>>> Hi all,
>>> Commit a2941f6aa71a ("nvme: add command id quirk for apple controllers")
>>> was merged to fix a regression in apple controllers that was introduced
>>> after merging commit e7006de6c238 ("nvme: code command_id with a genctr
>>> for use-after-free validation").
>>>
>>> This series is comming to enable the same quirk for fabrics controllers
>>> that used the command id index in the same way that was probably used in
>>> apple controllers.
>> If there really are targets behaving this way, then this looks good and
>> necessary, however unfortunate. A TCP target triggered the need for
>> valid tag validation in the first place.

What is really unfortunate is that we added this code by default and not 
as a quirk for buggy controllers.

This series is just completing the initial commit for genctr and gives 
it the right flexibility for smart sys-admins.

The genctr patch broke working controllers (such as Apple) and added 
conditions to the IO path in SW.

Also, controllers/devices that did some internal optimizations (such as 
accessing some task context using the cmd id as index in O(1) instead of 
looking the element in linked list in O(N)) to improve performance will 
now suffer. They may work, but performance will be worse.

Similarly, there is a specification for max_nsid and max_supported_ns, 
right ? exactly for these reasons. We might consider same specification 
for cmd_ids.

>>
>> Are there really fabrics targets behaving this way, or is this series
>> anticipating they might exist? Apple disregarding specs is nothing new,
>> but I would have hoped no other targets would do this since most vendors
>> care about interop.
> Seconded.  We probably also need to document the broken targers in the
> nvme-cli documentation.

I don't think there is a list of broken targets, and broken is not the 
only use case as mentioned above.

We also don't know the target that cause the bug in the initial genctr 
commit..


