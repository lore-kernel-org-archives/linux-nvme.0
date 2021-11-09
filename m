Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D932C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 16:59:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E791D61152
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 16:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E791D61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V4qKeypOqiXsj5cS+Gds0AH06figAaV9atKcoav+Pn8=; b=lB7EUWGE3Tuw46gEvtuHyXVbGe
	gdJYcXKZ5+AWbVVvc86eSS8Uid9+ZWu7e0B/DPtLoHRO/12iYsNNzQU+w6M5unpvoATdx7F8agYsz
	5dvipJ2e8pTDaD/ThXIiUHXrx98k16EzHU4CLHoCYC/fP9RGCbI49K2zGccWz6s6Hr73gcyqsorz1
	9d4bwQQVMIutwCtC/NDsLA6nrss/s3wtotFDjR5k+VqaggFed2K8kUs8g/+8NZxUUiPxdE+fFUCeu
	0F7qJwtOwHD8IKVrAWDA1ChYxANxLFeEPQc/ZfLdX0twYIUKBltxAOt0fbujUQA+8p6BcUwLXjVEy
	xFoW4ovA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkUSx-002oif-U9; Tue, 09 Nov 2021 16:59:23 +0000
Received: from mail-bn1nam07on2077.outbound.protection.outlook.com
 ([40.107.212.77] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkUSu-002ogg-AU
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 16:59:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo8vTqttKDBJcJ6lcQ8DisDqFfqYQ0sjBtEi46MO0Zh43+H50+Iu1tyRJXZOjUqLZdQGXe7onHTsOZ+IEHy68JD23+yTXUz5swUU3Ij+wkrbAy2QBbl7M20Z8LCpbStDdrSpRlkOFvgFS9xH3I7oO06NYkOiNNvB1ZbR/KG7HPfeXFU4cUJTmqKnwRgO3CZwbZaRUnrG/wc18MR5APD7LnYY0vN76JHG9boPi1C+Mx5E48+j936hQ9GHudrbjujLEMLjmKZ4H9MYdFyW+LRRdYptAMgeMHbjGIDb4etSu7QWdMajturandtfaS1rVWGy8jmQSiA3H0QE3e8+Y6D+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4qKeypOqiXsj5cS+Gds0AH06figAaV9atKcoav+Pn8=;
 b=PdJS4h6FMSxTXECfumRJYtpn0ueWDc5uAbV+0GTzsnIVw9BGSRM1Q1+tRFH7gOPCuPmzRU3mJ6BBpI0Zgd+y+F98IBm8Zx89lmchX7wo/WXHhGoMeoPaLPLczLX3tozeWPOJzyTyNg7TGltyuI8hSWhRfZy5mDbwptgQ8tmmMbVinyERwgKjDknZRBSnoyjVgVHgqNVqaYQl+PoNuE5FA61nl6LGnS4NVy54qcDNaVKRHlqkgFq7aZ6HOsWXRQtzdA8xrD7OmhxF3paYVjPKi1H+SKR/0ABJIMQkl0mG7o9FfRqDSWA25kFqqyT7HrbvjXZlCKfDGD3vhNzPxwlb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4qKeypOqiXsj5cS+Gds0AH06figAaV9atKcoav+Pn8=;
 b=KtI1cFQ9ArOWzQa2Xp58Q2+cnwcxem4EM0QSEKLzzhVFXoXhcCNvtmz06WcaSmd0IBdOeV1Ry3pVgdR0LpznTPtQNxuwAbRXhaISSudjZ0hI/0zLrGsOeHlcm991WNXK0R0JZ2FUC+mvSBfbmlX5mU7Dwla7mT5UlDNy1Tfhr6jFA1unmlAavJQix5fQ4kfdvCnq/gcS9uUTX+5Lou1t2G46ysgO0S938rblzmmEecxj53nmyj7tQAVaT0i9j+ryAUeFbHwKqp16LoizqmoncSVbro9REaXx38K1h2/ZAg9Aumcgsh8p6tLpbp7foVndoKi2QdPx+PSNt1DhWGJeXg==
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 16:59:14 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::a3) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Tue, 9 Nov 2021 16:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 16:59:13 +0000
Received: from [10.222.163.47] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 9 Nov
 2021 16:59:07 +0000
Message-ID: <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
Date: Tue, 9 Nov 2021 18:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
 <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ad675d-440f-4f81-c1bf-08d9a3a24242
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53378C8C027E2B604704489DDE929@BN9PR12MB5337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8mlmY2DWCs+qA056+v+L8wDUg624A5mN/29DIqBJXms2PlKH7uwwcLkKNSHMiDmkpdL5aQrm08MIN1GAEvUQKBBjt8eR5RZ2VtLGQ61fT66hHhpMTt0yvrVZIKySYLS38pmYo7VeDfdsx5uPQ7uG8wiML4K84erA5uhhgURzVlUauKcN7zcxJf1VkXUYg2AcLsyO0n1BtGvg+Y4yuZCSUxq4cL029dDflHk6yqIWAiyfQHEKFcVNdyZVX5KenrKLb6oRxuH6tHmg+dRkN81jkFniPQycEZ7TIHwfC0lP0UH8LMh7d07cCST+eir/FahC0Z/D+h6MWKWIDWbl3FVsW/okcyjeFBAZJzeYIKgv68tK1usdmonQHpT8h4xPZBfqJBMfYUzlURRaaaXOCnDbH4W+TQFPVs7mH7u4NSsQ/Nc7nmGUOotrFqPugzJu5RCRAvbk5IPRwrDWpy/byhRrkQ/QzI/nR9QR30Sd9LIVTMXSG0WxlHcpR+z72r00ZeWQdTRPHhjE1VEu51NqVC2GwhQr2MrLv6uZW5ciL+UG2nQaUdhkRxjRvdMbrvEjQ+hmtLhPJhdQc/E+6yjIRwmpRm8viX79csC1kF4v0JXoPNPeaVXXTBKtOVB+D0pP10RAKSElGW4NRahqD15BFxWHCxeF1GpULgxs6UzuWs9eaVtMPyPf8e19jd+/Bkrl5pNCdDIdpQ6tgHx3XPUYzo0n6SkrTmBfissSk6hjdPjG5A=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(16526019)(508600001)(2616005)(8936002)(83380400001)(16576012)(36756003)(4326008)(336012)(8676002)(31696002)(426003)(5660300002)(31686004)(47076005)(70586007)(2906002)(26005)(7636003)(36906005)(110136005)(53546011)(70206006)(186003)(54906003)(86362001)(36860700001)(82310400003)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 16:59:13.8318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ad675d-440f-4f81-c1bf-08d9a3a24242
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_085920_408896_75D2308F 
X-CRM114-Status: GOOD (  14.24  )
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


On 11/9/2021 6:15 PM, Keith Busch wrote:
> On Tue, Nov 09, 2021 at 03:31:02PM +0100, Christoph Hellwig wrote:
>> On Tue, Nov 09, 2021 at 04:23:33PM +0200, Max Gurtovoy wrote:
>>> On 11/9/2021 3:15 PM, Christoph Hellwig wrote:
>>>> Max, if you can't point us to a broken target (and yes, it is broken)
>>>> this will not go anywhere.
>>> Any target that uses Apple device as backend can be harmed.
>>>
>>> Most simple example is Linux PT target that copy the sqe as-is and passes
>>> it to the NVMe Apple drive.
>> Take another close look at how command_id are assigned my Linux driver.
>> We obviously do not pass it through as that would be completely broken.
> Also worth noting this driver has always defined the command id as a
> __u16, not __le16, yet we don't have any bug reports from big-endian
> hosts.

Right, my bad. I thought that the pass-through target uses the same id.

Linux PT target works fine.

Bad example.

Linux kernel world is covered but I still think we need to add this 
ability for fabrics controllers as we did for pci controllers.

There are a lot of vendors out there with their optimizations and 
solutions and by adding some code to cover a broken TCP target (that no 
one said what is this target and why nobody fixed it) by default that 
hurts others (even if it's spec compliant) is not a good practice.


