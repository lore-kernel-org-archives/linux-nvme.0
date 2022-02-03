Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCFFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pyIJJxwByLpv05ZQIBt9m5h9PQnn0yR1iQZVDJhzeiA=; b=Ou7U4qyISmf72IZFLuHG82XyJi
	UH7J7phe6yTMpx6JapW1bwdNwm0Iea2/NGJa8rga6r0CMrUEV0RvJ2ZJlQ6BXFuv8UXAiny8QSdeD
	A8kzy6FiP8oCjK0hCqw219fSK3E+I8ySLa5qg1XxqVOZqdDYkUkjgkKoyivuhZvzvWCP5pt9NWF8S
	Lf3QWSEjKfebP4MBTWKQ8j22iXO0dInUp+qAVoGcgd7YJsNZz50xXNj0umXlIOmFEEs9rVcLwk5pq
	LHVSEPqjnlkRoqdHdia97s/FOMiTorjyEVT2YO1zJ2xX3hYswUK3piQwg3QNFemNKDu2YAhAahWPV
	xXOcXqgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFdKU-001g86-OT; Thu, 03 Feb 2022 14:43:22 +0000
Received: from mail-co1nam11on2073.outbound.protection.outlook.com
 ([40.107.220.73] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFdKQ-001g72-DA
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 14:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Isb3Wa/LC2xn433JCW8El6QJXTtHZ8CQUAxd4UEU0VA3aIi++AgsyKILscUIJIMuJfqUDLCfzKiaTXH2WNcKfJNChI5ZyrEe4PPJYyUxgnDKT+uq5+68Cubx1QOjNkdK/lzhHs+Z/+sHzBsynMK0unjW3Cnwj8eR7a7ULQVkqaMx3Ampv111XnHjQhaH/qDcxuL2qJJUGkGrTXmC5Cyp5TwtS5YycSW61W2P2BvJUKQ+e4tFhZEWbFQ8nJFtivNCkakHSVdzr8YwAyfAX4EVrg2OwfoAnETz5wvuY6W7ajDI/izAHX99X+YfBPhxh/5/fuvWYjDetJjGMufYuWPbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyIJJxwByLpv05ZQIBt9m5h9PQnn0yR1iQZVDJhzeiA=;
 b=F9rAtkEmvtwX6wR8ez/4fe7RsJEtSxl4OT16v5gJUYmkbSTrveoDfNunGTgp07H0bFvpMY5PrO8a1laVwE9/YlUoQL7kUsYhUF4EsOCIGUqz7A2h9se3M49eIwG5XW3INu33uO9BdDmA73+6hxNUwDNbDsAjVWPfxpzTf13fb1c/6TS50pFlTTFn9i3wCQvOgPI18K5ISzcSjZWDkSbg3doIqn5I7bga+3uPck2JD6sVSHl1SrRIjD8zmetFWTPhQOwib4WNjil/ef+5HiYG07q6QK0Wav47gNCeYIRa7isUboIq+Pjae3CVx6+REa8hSgSyfe+a4ezxxrTAljZYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyIJJxwByLpv05ZQIBt9m5h9PQnn0yR1iQZVDJhzeiA=;
 b=VHFnwLUKyL7E3JICAsx3KK+FZjr+vIZSoMjqG7c+wkm9J58oYKQPxKCfrhoWttMR5GQTl6viKg+2JdwpyIlAh0Bay/eg8YV8vvI0UQyWklf6vmCjwKoKdtA8kxUm0Vn4aJxQ/gTpFA7WPvPXtHfWbsZ+suToLZpiAGaEVQT16NYQ65mLB/g2lZvojBRiOQbdsmSMjTMJcpSwbbicB7m4yZtJr4JIKmrfo/Zdf5GB6ZznqqL9DBUENX/JYeTk0SRdcvfgxyfq6jiV2vKIPzhiqQVEiPQnMhLiHZSEd7plEk2an1Q9vmK3xtjxlkjvqp1/czsLXMtA+iMjWMtdJnUZlw==
Received: from MWHPR12CA0056.namprd12.prod.outlook.com (2603:10b6:300:103::18)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 14:43:15 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::e) by MWHPR12CA0056.outlook.office365.com
 (2603:10b6:300:103::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 14:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 14:43:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 3 Feb 2022 14:43:13 +0000
Received: from [172.27.11.222] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 06:43:11 -0800
Message-ID: <b6b0d486-c1e1-bf8f-6720-9245bbf60815@nvidia.com>
Date: Thu, 3 Feb 2022 16:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/3] nvme: fix a possible use-after-free in controller
 reset during load
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: Chris Leech <cleech@redhat.com>
References: <20220201125421.177942-1-sagi@grimberg.me>
 <20220201125421.177942-2-sagi@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220201125421.177942-2-sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 730a0248-8181-4d7b-1937-08d9e7238240
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB507720851483D0E703A14846DE289@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSO5LvEMIejzpKnFWEKRw6EPBkYqBgqGTGKuC/qi1PR0tzbXRMt1qcB/Ls4T6kODX1KzY5A9+6GVHFNSMZbL5/zzHB5YJwvqZjF/Yf9g89i4tzRfwophKidzzgFXC5ilnAOXnCbpy9qS3aCQdS1Ju3uNLLDMwmUe0IM/a52WJ9EO5syRmNbbWvlDgNxUj+QJuN4YcyG7FMelmGVl4L50gPtWjdga3n/1yWEwC83MlhZIDBvGWuIJ3wQSoQXl9U2zUEWMt64V3YWRK+9vpQTm6hfjjC4hYYqUTF5KwMjmBGgEO1XDgKp/nL/nZ7Kc9lKYCkZV/Ecng8giq557yRlO+BK2uWIGssn7qatwn4zqzNP7VIQMuHVIzwXm1OOGQJidkQxeOjNuyILtXIJxsAbGOMlnavkNmtb7BwyIn+X8ZSFu1rgt3LZvaH0aexnBwC3KTrVjVWHgoKgzuJtksEQxPzW1sBTUNpqwYKs3mXNDFF0mgnBi7d8IaUyY3XQ1xEsrNJIL+6ztxCMtdgJtSg4Ii86MLvTrjCN98qx0Wt52cj60SD/jHLt5XrgyHE4+olkKH25uwIl0zSuNjH136cqORIJwjB4iHhRUY1NWoxIW5yyaDOeTw/eoXSQxcp735WV2v0baBwfYTPG8f1gs9/haXjloC1N58IGAknfklcp/BblVZxQYD6tE4o2ArDpRIwNeM90WjLul/X0JSCubQsaEaDhNt7fvTow9g16JTWhoJX9UDtfIzzdYeTL4eAfSnCbg
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(508600001)(31686004)(36860700001)(316002)(4326008)(8676002)(8936002)(70586007)(70206006)(53546011)(16576012)(110136005)(36756003)(82310400004)(5660300002)(426003)(336012)(83380400001)(31696002)(86362001)(40460700003)(186003)(26005)(2906002)(2616005)(16526019)(356005)(81166007)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 14:43:14.3652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 730a0248-8181-4d7b-1937-08d9e7238240
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_064318_528548_93E055AD 
X-CRM114-Status: GOOD (  19.58  )
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


On 2/1/2022 2:54 PM, Sagi Grimberg wrote:
> Unlike .queue_rq, in .submit_async_event drivers may not check the ctrl
> readiness for AER submission. This may lead to a use-after-free
> condition that was observed with nvme-tcp.
>
> The race condition may happen in the following scenario:
> 1. driver executes its reset_ctrl_work
> 2. -> nvme_stop_ctrl - flushes ctrl async_event_work
> 3. ctrl sends AEN which is received by the host, which in turn
>     schedules AEN handling
> 4. teardown admin queue (which releases the queue socket)
> 5. AEN processed, submits another AER, calling the driver to submit
> 6. driver attempts to send the cmd
> ==> use-after-free
>
> In order to fix that, add ctrl state check to validate the ctrl
> is actually able to accept the AER submission.
>
> This addresses the above race in controller resets because the driver
> during teardown should:
> 1. change ctrl state to RESETTING
> 2. flush async_event_work (as well as other async work elements)
>
> So after 1,2, any other AER command will find the
> ctrl state to be RESETTING and bail out without submitting the AER.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd18861f77c0..c11cd3a814fd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4251,6 +4251,8 @@ static void nvme_async_event_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, async_event_work);
>   
>   	nvme_aen_uevent(ctrl);
> +	if (ctrl->state != NVME_CTRL_LIVE)
> +		return;

any reason you moved the queue_ready check in the transport drivers ?

Is it redundant ?


>   	ctrl->ops->submit_async_event(ctrl);
>   }
>   

