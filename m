Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A438C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 10:49:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470416103B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 10:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 470416103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eajoeTn48kD59S8YuSwo4Fnjhw9pCtFIQETWDUIxA7w=; b=fsFQ7mgV9gAQKrbZ7O4gUzSZMv
	kYCN50UPR/7GP3zKO58O+9Lh57uDdQHAYCnOeied/uOtKEo45Vjmyg5050e3UYePFa8XDstSavEWe
	Q07w8MPW+x+2vLXGmAUACWzB8APqeZq/HzjGCOORfBjX8c6xnTi0SrsVn5ybLZoD3gbImxRUXg7d+
	F+lwMhqCrJhR2WTA9bAnfoFCs07xC2yapHcAvqUDn05lA+EqM9SXPbnfNL0+zxuI+chtiVshvB3nS
	ZhnhMAJ+0kD3/wSrsM3ERlbvSZ6MyEE7+TP6nuF/XwpvhbMaR3PpLTpGYK4/+ldVxVYeVsXhs8pvU
	okczPUTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfgUo-004c76-OC; Wed, 27 Oct 2021 10:49:26 +0000
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com
 ([40.107.244.80] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfgUm-004c6l-20
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 10:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMx620tMn3z5tnq0R/zt+v6IKfEzw7VodzE1redAqcq7npBW8UwDsR5rI2MARKzg1ok5GWnnGCZSLzYGtWEFEXPK3r2Wd5njH73ZdEeNu0k7wajy0S3M3FS710fOgU0qnjSNV1lpFvAh7YelUI1CFoEf7OdsY9Do9g+CbsbhAFk6Ia0jVdzegAsB8b8TU9DIRGGZGivMJ0tgh/sIJRW0Zy9H4Hk5wPdhMM0rKqhb5MNv+f6jt/bZzlYjcT4SInQm8rR26vNjbVTWL7bUNOGa/zAl5yemXZtaLdUZ35UIdvpd3f10ZT9Q1dD4tCyFoavwNnn50/op0dWHL6o2OcgLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eajoeTn48kD59S8YuSwo4Fnjhw9pCtFIQETWDUIxA7w=;
 b=MKPZMrbbOTdoXjVOlI9C9vS1xb0/yJDyQy/1d7Pjr8vEQCgeK2vRNi6SScHphUosDcoU8ntA3+4oyhmeDj29x1Rc6EFO2OEz3rn/2VPYlhDoorebY9OSNdv6RCBzBMkkux7d1UlYvtx1yTVyXOqE8Ep1AnxxWzHbcjZb2DiFx6r4T6UBuUuvfsx1dRsD0hMxl/iqLePZGMm+6BFGsyXqt99lMKRkzLpimOCRZ7AqKO8o7Z9YfDFugyl6Ax6fcrGk4obzfYCogRrsmV9bKCiJ0M0YK0RCfzMmqllxoEBlg20ePJ6/4DqlMIqppqRSWQcKQshFmGd98iqKYH4oSKVOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eajoeTn48kD59S8YuSwo4Fnjhw9pCtFIQETWDUIxA7w=;
 b=bwm7zQ0XbwYXOXReFcrmx6yz3pI76BZQVu26Jv7x3sv55ED+Ybp0WwsXorggsF4Tw6oYnnyIu38mjiPcSZ1Adu6W8Ajw4OOpI490a2sSyWpC06rCpMmnVmet6ch+JYsgGLbfZXqpGK8+BBiCcTdh39sudSriV0zUSRk1yN7IRtx8LVG1p6dFPslXquI1UuO5UfOP87d1eaypfQKeYRJ6UgFC5GGszxgFhW/HG/Z3IT+SFTaUr4JHbfs+5qnEuq9kD4KXGxCqkD9viFfsa2LYGH2okSrTHE9bek2EHFY4WbRmnLDVkkLtFFkY/TCewg/d+VQfQAFylAF0C1N74BCIIA==
Received: from DM5PR13CA0034.namprd13.prod.outlook.com (2603:10b6:3:7b::20) by
 MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Wed, 27 Oct 2021 10:49:20 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::9f) by DM5PR13CA0034.outlook.office365.com
 (2603:10b6:3:7b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.12 via Frontend
 Transport; Wed, 27 Oct 2021 10:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 10:49:20 +0000
Received: from [172.27.13.210] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 27 Oct
 2021 10:49:16 +0000
Message-ID: <41ba9a7a-f4f9-4ee7-3cae-21700f086dd5@nvidia.com>
Date: Wed, 27 Oct 2021 13:49:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: consultation about NVME_SGL_FMT_INVALIDATE not set when using
 nvme-rdma t10-pi
Content-Language: en-US
To: liruozhu <liruozhu@huawei.com>
CC: <linux-nvme@lists.infradead.org>
References: <ff7c0b84-e0e4-e22d-1ab8-1b31a0aeaf3b@huawei.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ff7c0b84-e0e4-e22d-1ab8-1b31a0aeaf3b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9267e605-2c97-4107-77ff-08d999376e49
X-MS-TrafficTypeDiagnostic: MW3PR12MB4396:
X-Microsoft-Antispam-PRVS: <MW3PR12MB439601E91B5C6102339F258FDE859@MW3PR12MB4396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YPogZNxkqYNlLqPjLCfWywGS6Zig/TXaSLW3pu0xup5UfovioTgrT6/PKyre1shvCM70YduZqVHg79ybHwKsBtThXuixP44hmQ6UZJaZe/ERFbQD8uhShsbJFkyyQnnO0qXgxhSTVNR4wOcEpO/eVXVwNR03zlrSMlKCh9UwN2ZaxnkuUjkggE7mqJIuAsFdKLMC1iQoiNba1BYShEBgzFbBEYOlkcFHAYTt+QEIdWl+kFg4ec0rcE3o+t5Lx4XjAtKXmGOeX7E1g0QbpF+VI0v8fUxPlRYy7Al1SNIb4uJTo0+Y6z441mjNLqMem2Zy8reEW6n/izFPlmYBLvPnrlqw2hh511HyCh2KlGwtDrUiBQQ6bUVBlAFuYkVbAiFja7N8F8p7re3vm+MsSnf8pGKDpARJCTYfixaun0qFhRV/HZDodAZl8ZtFIKmCIAOhSw+oONWfyXIhgIcVvzO+n6p922VUJbjSGOyofbVr189JpmQ1tvUoKSWbOrzOyspMyiDvEIbTk1mRaeR15Fyvt3oI75/j3WGiNd98cmRykQs52hynRlAQZAAwlW6IA6RthZtYKZyXExZkgsO8qazCNLLjRtn8N7dDc8L9mouQamChvlEJQY4hfna0qUTbkgfXaUGJZbO9xjdRuNb8OuUubbEj8XKAgSblaoyi32AuIgEMCloodsau6k9N7y5tVinfNxoPIorjVsRXvFH6Frk4XhZ3TeuzsLEmHRCXQ+i7/Q=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16576012)(36860700001)(5660300002)(31686004)(26005)(53546011)(508600001)(316002)(82310400003)(2616005)(83380400001)(2906002)(6916009)(8676002)(47076005)(36756003)(31696002)(356005)(6666004)(186003)(336012)(86362001)(70586007)(16526019)(70206006)(8936002)(7636003)(4326008)(426003)(36906005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 10:49:20.1076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9267e605-2c97-4107-77ff-08d999376e49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_034924_196965_3BD7DF83 
X-CRM114-Status: GOOD (  13.75  )
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

Hi Ruozhu,

The performance tests we did for all the IO sizes showed better 
performance with local invalidation in most of the cases (mainly for 
large IOs, the remote invalidation task is harder for the HW).

Maybe there is 1 or 2 cases, such as small IO latency, that improves 
with remote-invalidation but for now we decided to disable it.

I guess we can add a capability for the device that will indicate it in 
the future.

What is the difference you see ? and what is the scenario ?

Thanks,

-Max.

On 10/27/2021 11:50 AM, liruozhu wrote:
> Hi Max,
>
> I was testing T10-PI feature of nvme-rdma recently, and found that 
> when using T10-PI, nvme-rdma driver did not set 
> NVME_SGL_FMT_INVALIDATE flag in the sgl type field, so the host 
> software needs to do invalid rkey by itself. I tried to add the flag 
> to test it. Turns out T10-PI feature is still working, and I get 
> better IO latency with it enable.
> I read the original patches in the mailing list, and found that patch 
> v1 set this flag. But it was silent dropped on patch v5 without any 
> comments. Is it for any special considerations to delete it?
>
> Thanks,
> Ruozhu
>

