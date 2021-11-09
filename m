Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9544C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 14:24:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F40661053
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 14:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F40661053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SPO6nxk1VMjKPW2exZXI1sKBL3SJlFWX5mlXpTpbO7o=; b=LJXNB3+UKOhd6+2JL4gi0B3H9r
	p2DGERBFAHYjDp02ybQoIwvE9UY8nC4Qnv0QcigIRR9a16f6dF6Se2+4wBNs1mAybEiO11/XDzYyL
	F7N1nGaUYVo1MOQmoDCHEDU57kTOhHC9jIqK4yQkpbr9S8RNyaOddPSxPGOPZNwnIWjf49CLDXJh+
	LIiminiKTiI6IvLjQEYrzvE1uNBuL9d3w3uPmSckWAWj9rNon0Cj109IyMyXpDU/yU6sdYFkhmnjH
	wUZOhAIYVA+/qYEv8NyIaMHmzELPQCq1BftNYCZufA2VIfI/BVXAmeayPw4KqWSxb+bho2lGwhHo0
	HuMcDUqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkS2V-002PMu-Rr; Tue, 09 Nov 2021 14:23:55 +0000
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com
 ([40.107.223.84] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkS2S-002PKP-22
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 14:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMnMhRsYMvW2swwGOJ8bAqFwCE9oeWGThpeklYmJSrja3urmfnEK01ZxDmtW+p6MDo5cMa/jY5TEpWks7+M+BzjZxSWBxfWsUdnNNujxetvgMHtqGpzU8aNqQUat3w+/5OwJqkH0t9/viSUnZ1uQPof8lODeU/ZYeruium7Se/fz9Fh5/6yU6G0VGodRYWgIPzDk9zV1P+wZMD9muy6D/4AeztohK0DtoyQ+lzJ5MXaJxYSQ1Xg1gbeYwv0ec0TM1yc+MvmppJKPFFrYyEtIitrs1NgZIjFctj3MlZ9XaNWSeXr9HKWQOc28o22VqlKHxlB/A/ximvpKzAOswUzrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPO6nxk1VMjKPW2exZXI1sKBL3SJlFWX5mlXpTpbO7o=;
 b=LphMP3mPppNgfqNgpy5gpHi5irjuiEPRPzpgFFwXhSIcZ7ghxMA5uEuizHVXVE1ugc0J1RydhRnzRAl5jj/dZp4NTr1MqGOZrMzufV2FQYbs5LIfNGOOD71bxfnAs3vWR8zTDmopOionzGq1zEfYRc6Z/oUJH53oOmgBVHvQMAaqyl299oQduht6aqreUyT9QLikOWRcQJVZFj1YuwsbkHFd7dZsrcqAJpRv8WRah1rTvaZYewOu8cqI4lPeZWR3ip2u7KaHo7pJ4lIl3S82PNJiFf4n4drr1dzYm4qMd8O007hdVJMba3TU3RsNQy7F7hV2SVCcknMQZetRnUi65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPO6nxk1VMjKPW2exZXI1sKBL3SJlFWX5mlXpTpbO7o=;
 b=Vmh8TcY71gOTQJTxUV9TiIickdRva5uIT0vvVFb7+sQmQz8Fw+ntI2zWPIxOd1wHz0sgD9YoC+p3NA1XQLxw/4DnlIO9WjRDakd18SJpsjHaz2rqsx0uZ6W+E4IiWQUy/ZXOyGulFyYWwQFEK5HT6qYtH8ajmdOdXNVw3kv7Yr3BbgYdeQ3RYl6PCeTdoSeKJB/gmDYpLB8KCnGVk5j4OsPCb1Z72bikddvLOtnSG3B6NkGGdugSxfdYVO7AQmrDbo4zwLKAK5OpHyD2weQN2luTA8WQQGB0lQluir7jOeXkxkUcVfPjFChouj6FRAsjOp+NXu00B1t2BOjsgj6kvw==
Received: from BN6PR1401CA0001.namprd14.prod.outlook.com
 (2603:10b6:405:4b::11) by MW2PR12MB4681.namprd12.prod.outlook.com
 (2603:10b6:302:12::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 14:23:41 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::e1) by BN6PR1401CA0001.outlook.office365.com
 (2603:10b6:405:4b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Tue, 9 Nov 2021 14:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 14:23:39 +0000
Received: from [10.222.163.47] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 9 Nov
 2021 14:23:35 +0000
Message-ID: <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
Date: Tue, 9 Nov 2021 16:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>, <oren@nvidia.com>,
 <benishay@nvidia.com>, <borisp@nvidia.com>, <aviadye@nvidia.com>,
 <idanb@nvidia.com>, <jsmart2021@gmail.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211109131510.GA19713@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea641f2d-5a3a-4c26-87f6-08d9a38c865e
X-MS-TrafficTypeDiagnostic: MW2PR12MB4681:
X-Microsoft-Antispam-PRVS: <MW2PR12MB46817C5DC12E6364A851DBBBDE929@MW2PR12MB4681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sS/N6AUjBXpYylGMaStKMgGpx/BGbwMONGeItkhNgl7hmqhxDoy0gtjy6Srzh1BEN25wjG2+yT5KHOCi1hbul/zx4IF/6E9tUVuTbzkVTcpmbknEi8ChB+4iBbb53uEx2UTWTcjvH+EI7EmBd7u/DDRIDhlxHYq7ZI/mn9A4ww0YE+AEYnNxgp02PH1hTZlM+48RbuweocUXzKJysIoMFU5mXpJ22SA5znj94A26i3xl6kZ443LYo6HD1JvbshqfhKlJWDK9rXyZ240XO90IWdg6PZx+RZVu0OIvm899dGkx6PsRdun8A9YwePcuckNB0Y6N7GcstaZMASQQT54yqzOO9/LPoNZW+kfOfwazzpHDUe7PTE6l3jx+MCHNohqlIOegi2aKuuDnH75LembVHtR7+XBiZD0WPMaUxJPWVCp3DrA9shyrKX85WbX92iv1YEBalvay3pg3NtGDM6cOcR6ClOR2vArxb6V5ARtWM8xTgMvDTL/RgbzBvniwMr0QA9eyNS+RLUr8FVEQOjKAmzqovLWFvvc2yd0hljqy/LXS0yPZC2+rtXnQISQrzk2f4a9mGIoE7Gh3lDuYuRs03Za91WSQZi53rUnEdPAk3mqimVVi8uYVZVpns1qyvNB8+nTi1B28re4b6+RdrSl/bhgLkHvkUNPXFTiINBgX9JxlVcvkmHQmE3qCeecI2haREChpl3d1wq/EMStlQHAnwzayitiqhcS+wa7x2VgnmCo=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(4326008)(426003)(36860700001)(508600001)(70206006)(7636003)(2616005)(70586007)(16526019)(336012)(316002)(31686004)(8936002)(5660300002)(16576012)(82310400003)(4744005)(8676002)(26005)(186003)(47076005)(6916009)(31696002)(356005)(86362001)(36756003)(2906002)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 14:23:39.3167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea641f2d-5a3a-4c26-87f6-08d9a38c865e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4681
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_062352_153694_A6CE3AED 
X-CRM114-Status: UNSURE (   6.57  )
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


On 11/9/2021 3:15 PM, Christoph Hellwig wrote:
> Max, if you can't point us to a broken target (and yes, it is broken)
> this will not go anywhere.

Any target that uses Apple device as backend can be harmed.

Most simple example is Linux PT target that copy the sqe as-is and 
passes it to the NVMe Apple drive.


