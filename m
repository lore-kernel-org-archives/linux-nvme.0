Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC7C47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 21:57:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18271613DC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 21:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18271613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HC+T2jT4ZjcfqjnLNK0yIpC1AYNkJaDWuqfYX1aZCQA=; b=rRktRyIa+eU30v/s+LwtRz4hkx
	bpvTArWG9D1a6gYXquZ2Luy6FeKp5Ct8TCYjosPywsb090ykkfUf+hR5N0B6c92hyf8BOJDqSgUZE
	jXHdHzVwWXNby6s8Wdc6vkkrW621metDtzF7kmLjACEai8b9J7qQFkBKGESVbKBnLAI1nn4nIJ3GS
	D03VhdIVZ9Pc1pARW1JjS0xJSNV2gtEsM4+Tqh2XiTf90l6gIF88viwPcA0dZED1UH0VFU3hsB8Ud
	wAr01kxiwLeZ+B26g9MyshLhoHUV/ntJgDE7vnmS7zyjTax8w7KVjmWpl5gKXPLXAT8rsV+NyuS1N
	Wtxg3/nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lm1X1-000IT4-Oh; Wed, 26 May 2021 21:57:39 +0000
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com
 ([40.107.244.85] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lm1Wy-000IRB-RH
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 21:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuR9UeQx8j5qWeZywclpW8jXdEL8zmFJzcfOBbinfC3zNuHoavnWIGezvmYhDKkBGiriD0iYos9hYeoI4L9KqFwXDrZG5O5FPbc9Jouh8ep3KLJKX2lA3JFLkHzr6xJTXmx95/Q/c4M5gkwefkRdv+xcxcnB68d/zaxBM9Q8Tn+uivhiuHdsZ54lVlot/kpyQVmLtdIKX5peXT1IRzxIEgrTDcoR2U+x7oFZ40/r5x6uGljOR09e0o47UevRx3Vvrx/BUOdYDgeN2lnNbxpmS5bjd7y5k0SClDJzGYGXwpCMHqX6/Pr8EsDcJuveDuj3OgOjaOygF2Hfl7icKpw69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skY1iNmpzofIWuUFL65EzakANphalX/WA2mqEgJzX5g=;
 b=n5MbB8oxg7gM6lEWRJl4POiifg9Uw63rClM3e8TB0OFB7EfaDC31L4fv3TFQcOQlhj/F9eLaPvflyk1ojZ/V54+SfG5PQETK4qnFz+vLOn/rbMcJZX/G7agtMPeRJttUGKs4Qgw2YCpqemE7E5dqVitfvilidoBH3excBBuXbPPm1KG56NUMgqoTjESyThSXPIpc/GuVrgIZoYkQ7UswjriFivy/18dNxYGuE7yF6eSiCICdiQWNaAgWfNkt2End1d3UipCX3shUH0zTDDy5gLFuA3AHT/roP1NNFTIoQRwCFdKgDslffLZoNwYoOhQR96USzzJ2lh/dbVFsjBgTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skY1iNmpzofIWuUFL65EzakANphalX/WA2mqEgJzX5g=;
 b=XIrullIfmUnLY8PoagjmpL/w9DABsjV3RdDlfFncsoP98O+qE5o8AQHhEBqHTFJ47AcO2z/BGxFWnm73BobCUaGRmS21iqTEHJqbLiNc47/7tjoDt/kZCAPYvQOipsyMXplHro0fyjpsklT26Z8S2Wp68L79S29YT5hcUiKgEszaEACUa3jDEdCMka9wYLiKpT/5OdZ49Vr1Zb//PLVz/Yn1ghRxvslr7xVaCNUsgsP/6U5+X5mcvUoDHdsYMGJ1nfYibDKN6bPkfevxG7ICIoMT+XlZHfEIdCwfo/0mIQGbCY/lbrvc0AwXRQd48/of3z2b0JXfmrMawYQ+yyiBEA==
Received: from BN0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:408:ea::31)
 by CH2PR12MB3845.namprd12.prod.outlook.com (2603:10b6:610:29::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 21:57:34 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::b0) by BN0PR04CA0086.outlook.office365.com
 (2603:10b6:408:ea::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 21:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 21:57:33 +0000
Received: from [172.27.0.77] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 21:57:31 +0000
Subject: Re: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
To: Christoph Hellwig <hch@infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, "Walker, Benjamin"
 <benjamin.walker@intel.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Israel Rukshin <israelr@nvidia.com>
References: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
 <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
 <YK5W7F5DD4grBZLB@infradead.org>
 <3c944010-a9e7-cab2-07ad-78d50c8bd82f@nvidia.com>
 <YK5wh91yAcOlu+3J@infradead.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <638819e9-8d4f-7b00-41f3-75062e4c076d@nvidia.com>
Date: Thu, 27 May 2021 00:57:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YK5wh91yAcOlu+3J@infradead.org>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b89846c0-8a77-46eb-cf18-08d920914462
X-MS-TrafficTypeDiagnostic: CH2PR12MB3845:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3845CEA7C3458CA15C48E86BDE249@CH2PR12MB3845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkayuVRnRbJoD8W94FFyxmMwUFzlEG7GEix7oeI29iHP6dR9O+8XutueGHnUwZfkm+0vt+wtpmu2HFxw1M5OFWjE3NDVu3d7sblc9EA41Le3zjaGKNjrCHZxa/8ACIvhPMk0M84rYtEuMbksX1e92eFptJcKy07QMnkqIP8pTiA9oFMxcRMhNbOgHeNAu93L4f6Pdnc8zz5NdzNVfFX+P8eqEoGS5An2VnDYBTZQRVGet1bpHoRIGLYF4xeGmQ4pPtBSHVyDe6MLl3bHEbHWdFZtf5CQib74vkz3w00jPcHhOZLxiJ2g5MbhEW0IGrGC9RiA6B6iDbAnnDfuwTknPML4GRRuVpK8D2XYWsv6MB5Xkd6B9WTb48r6dA+MAF9OtAfX+FZ/HSQdfGx3EX/cC08uTd7moe8N9D7fFu3v7k6UYczMJQqXUkvFzkW9GehF1vGbHZWzX8ymTiaXCK9o0PDzTJHQ8KB0RrZiG+dj1kEcsULxWnXS3BTxlpDTdkSnyHElFbg0MgJiiPfgcQeeU5FvSDcuZILDwReZpXJ2dF/i4oQiBSo+h4CRgcrD9L4+P/Yyoo9wgvGLzCDDfoypTrQxSQSx4ZiW3YbczZEpq0iXf47ryuGTFmM1k1fV6+1a7Jsno0AEClPydaaWiHMQaFxkPLfj6DXKyLhHw1e91rqxxshlponI1wPjvcCn0X16
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(478600001)(2616005)(6666004)(8936002)(36756003)(86362001)(8676002)(107886003)(356005)(70206006)(26005)(70586007)(4326008)(5660300002)(53546011)(2906002)(31686004)(186003)(54906003)(6916009)(4744005)(36860700001)(36906005)(82310400003)(7636003)(82740400003)(16526019)(426003)(16576012)(47076005)(336012)(31696002)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 21:57:33.7529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89846c0-8a77-46eb-cf18-08d920914462
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3845
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_145737_058773_C95F56F1 
X-CRM114-Status: GOOD (  15.17  )
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


On 5/26/2021 7:00 PM, Christoph Hellwig wrote:
> On Wed, May 26, 2021 at 05:49:41PM +0300, Max Gurtovoy wrote:
>>> We do need for_each_sg here indeed, but you also need to keep
>>> incrementing sge for each loop iteration.  I think we can also
>>> drop the scat local variable with just a single users and all the
>>> renaming while we're at it.
>> Is the above fixing the issue ?
>>
>> Seems like code refactoring to me, right ?
> It fixes support for chained SGLs when using inline segments.  Not sure
> if it fixes the original bug report, but the current code is broken.

ohh, I see the usage of sg_next is missing.

Well the original bug is for sure using inline chained SGLs but I 
thought it's using 2 sg_nents and NVME_INLINE_SG_CNT == 2.

maybe there is a split and the IO is using sg_nents == 3 ? and then we 
chain.

Let's wait for Ben's test report (Ben please make sure to fix Sagi's 
suggestion with Christoph's comment in your test).


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
