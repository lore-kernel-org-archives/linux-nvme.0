Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07ECC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ieuhn9jTRuKKvMn7RFxaUUxSM/q9MYDOjyYB5ppbKic=; b=hIf7AaeGid4xT9hAxtaaX6U03m
	M2u5tpcC1j82oiQdw9s2qUs6xChN0t6XmWTHhvX+7GD06LUUKDOfCJ6faf32gUcSEzvzNakyLeAlr
	9H5N0yK4qQvPW+Q0pinYVhIs6FIbCZ5GQptXs/gl55ssJf9rlh+BlBZu2cNK5OLtah8wT4S+xFlub
	oWGC5jngp90zGmmC3xIYtn2Q3oh2DJa4YNgrCSuv5LXGh3ehT9kRvLf0E/lL+yDJrCmEhm6g9CUcp
	Nx4O5HzkhJ5Ar3GMCOkABpyJu1WiPh6jrA1YN3MYBHRLSEjq/pRB9g9wkl10Y58/B19UKnvbRG4U/
	HzIMKBMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nExI3-00DG22-0i; Tue, 01 Feb 2022 17:50:03 +0000
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com
 ([40.107.243.83] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nExI0-00DG0D-HY
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 17:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZaIdczmEgebPX00P9zeq72gTIhp3SNylCqMhml+CbYK0Qazqi+l5BYIHPUYugdtSk6hJH2M8QeCXxq63QoajjYYaZjBcUnV59oRdPot8abICpHasnhpalgSAbrAOqb/B3bOa8w7sN6bZWcCQwngnQ4agUGPIk98WWngvwX4JvBKC7BM5bR1nVde5bI9NQ8wKswAAWKLiCcYTAYH9ZqItHVXHXpA4+wpD8BKYjOKM08mZi1edNIWGsU0PQb31Bu4CT3wk/NJZRMzHhXyCfO8CN2azMjDXZbTrqU1BpZMFsPc53LoeANbIB8BhwB8/40WSNmiS3W8FDnhqj+N3FWYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ieuhn9jTRuKKvMn7RFxaUUxSM/q9MYDOjyYB5ppbKic=;
 b=UdPRNrAuG4bDQWrA2oUKc55eiQKAoc36U2LBXawu83zjv7XDXgn5Nh4bUiYt/PC+WbrkaZrUi319ZLz2ATo5BKJ7JvIDCilc+DtPws/QSwA3hkfMjj55TjTFZy2CNiC+MilZLRy5euC1+AswfuCc9CnPhyyAJKubopli0EH8LX+bUdj6/rK3218d0sia6WLVW7spdwUB1Smeh19SX7vFzx16I7oVpBR44sXs2aiqK+q+0KXM6wfk0TRWLDnvM6o1MoAc9uUvDTmrmz7LrPLOR+BXeteF2eH9SEz7b4g+/QEhJzdGwqFSV8l0zh1Ft0OXL7AWvui1YU1KTL8lSlT18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ieuhn9jTRuKKvMn7RFxaUUxSM/q9MYDOjyYB5ppbKic=;
 b=TkRH5pAkZ5QIi65zX/RejBVI4WoyeFdoHKaA3kbd0ouBILuHVPBRw4dOTYig/a7EV4V4lVrsKLpmgW3S3kfbnhc//fGrGQnPu030leLiVwceQg8nnhYG24vTPBP8ZmEj/v8lLFrL627ZEkOTwaVBSmgHkikFoHG/ILo0xWFRjTlUFg1n2IP8Vt09oXnqGiuVxTKv+iweCbxwUEgcCt584GNT1y/cJSe5Xqdjn5rIJu6Xj6DXT4SVs1pukJQizEX6cfyGSVjoZBRHcOE0nEM5e3efGeB/darwwOsvLkWA+84ZJaVKbtmUW9ULpWSKTAG78Q+qYfLPyxWExmoFtpgdKw==
Received: from MWHPR22CA0033.namprd22.prod.outlook.com (2603:10b6:300:69::19)
 by BYAPR12MB3559.namprd12.prod.outlook.com (2603:10b6:a03:d9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 17:49:51 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::7e) by MWHPR22CA0033.outlook.office365.com
 (2603:10b6:300:69::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 17:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 17:49:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 1 Feb 2022 17:49:50 +0000
Received: from [10.25.79.72] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 09:49:47 -0800
Message-ID: <cb05d4e8-381d-b624-b867-d42e424cb341@nvidia.com>
Date: Tue, 1 Feb 2022 23:19:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>
References: <20220201165006.3074615-1-kbusch@kernel.org>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220201165006.3074615-1-kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a54aa2-1694-420f-e263-08d9e5ab3f0f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3559:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB355921417A1BEDBF9557D359B8269@BYAPR12MB3559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSpIwSxZ6cb26T7Kw2gj5R1ljzKml9Z1fEc7DoF0raVytq2+GaPTIWLgRmj9CGsZuJEgcx4HMWn2gnqH1645xq0Om1gsXAeFSUzRArqJxqs/VAoSWFQdwqbl2WJf78SqdOapf0i9iOVKqSIwF0TuY8sR35RQ8e3AjvMEIrEmyjs8rbX8N3nZpj1IEQlr4IgokIVuxth6MBnO40TZ1ILORPXNQqAe9ZlFEwALOmB6bdqYNsDJUnX5uTdcCk/LEgS8hyDj7P/NHB/3/4iZdNg1hGu8+xvVC+7KuwkqzEpx0YJQMeHfenVkkUaylr2ncMVKwrwxL0Ak0eNYELPtaNnOE513l1krUmLzd8Qn681ZhxxZYzQxPxTcwxpftQpDoRrlwtk9eUWXQrdZ2inVe0u+Ir0cG/YnzA26h74NIP+MeaYxAHHnymnTMnw9dMdX2FSgBio3maZ7h0b/mJcKFd113ho0H9DIAA5L8UhyAX6rAUjFcTWwnVEpB/47/9wncxPNfk1V2qMS31mJdduUQ/+DnCrV8c7OCouhuea0ahUtmx8hqKZo0s2Xc/V1xUQqx9eiVYFpB0OSchNaGhFMiZwGoj+13hcbNP9u3CFoAtUM33tPtI94T334ia4iPEVy8qgJT2L5XY+l6b21hfBiE6yM1t+toLMySognIIkHtlm1Ke4ic3uz4aqEAZKiqfYPeq/u4ShXOGAeaAD9JaUxlXdc39f9AzivpJwXO2f5PvBqziXEVy54x7iqif/h9fLifsff2y7iLUnMNOilvBI2pH9yWRwkeTXmg8zBLhE8GE+i+g3QemHV1WAFRmnHF2fxdtxZcBJ8+GMf0CFgHhJBq/nkyg==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(47076005)(86362001)(40460700003)(54906003)(83380400001)(53546011)(31686004)(426003)(5660300002)(110136005)(36756003)(31696002)(2906002)(508600001)(36860700001)(81166007)(15650500001)(316002)(8936002)(16526019)(966005)(186003)(8676002)(2616005)(82310400004)(4326008)(70206006)(356005)(70586007)(26005)(16576012)(43740500002)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 17:49:50.8716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a54aa2-1694-420f-e263-08d9e5ab3f0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3559
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_095000_646379_EA7DEB3F 
X-CRM114-Status: GOOD (  18.17  )
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

Tested-by: Vidya Sagar <vidyas@nvidia.com>

Tested on Tegra194 platform with a Phison E12 NVMe drive.

On 2/1/2022 10:20 PM, Keith Busch wrote:
> External email: Use caution opening links or attachments
> 
> 
> There is no complete set of attributes a driver can check to know if
> nvme power management is the correct thing to do in a runtime suspend
> situation. Every attempt so far to optimize idle power consumption and
> resume latency for a particular platform just leads to regressions
> elsewhere.
> 
> Default to the simple shutdown since it is the historically safest
> option, and provide a user parameter to override it if the user knows
> it's safe to use for their platform.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215467
> Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/pci.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d8585df2c2fd..7e25cdef09a2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -103,6 +103,10 @@ static bool noacpi;
>   module_param(noacpi, bool, 0444);
>   MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
> 
> +static bool pwr_mgmt;
> +module_param(pwr_mgmt, bool, 0444);
> +MODULE_PARM_DESC(pwr_mgmt, "use nvme power management for runtime suspend");
> +
>   struct nvme_dev;
>   struct nvme_queue;
> 
> @@ -3094,7 +3098,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>                  dev_info(&pdev->dev,
>                           "platform quirk: setting simple suspend\n");
>                  quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
> -       }
> +       } else if (!pwr_mgmt)
> +               quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
> 
>          /*
>           * Double check that our mempool alloc size will cover the biggest
> --
> 2.25.4
> 

