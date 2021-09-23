Return-Path: <SRS0=+tAy=ON=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E6DC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 19:47:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02F36124B
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 19:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F02F36124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w69iY6568kCkd+hfsTclW5v+U3x58mAMg1Aft1XTMsc=; b=BUqn5tOnA7HAwqV0BfLHMHwplv
	uFAQuu5uVRq9/2/uiEo2lYexkQx2G5MNf3KC+BhWDtrCcvl/K+7+APJ97/YKSnBRg0D6SJzWGdFN0
	zy0clftuUcF2E7FGI7Zk7QZxQ7SngsD6Og+0zryYfz88GexklQ/r1PyLz5J7uXWN6dvRxBr9X0loy
	DozUJ19qaeoqOTATw7TrEqtovPT2syWLZ8h1DIPJyJNu2r1txfeJnLxqpYa5lLRLGaqFAhzZ6AbCw
	+KaUymq4TYvFKSuEs/fixV3XYJWMG6JQN6Dg0saQ7u174nNxKxVdNXWMsHJSuyy7EJKcLoW1jHWf1
	vepS11cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTUfw-00CUJJ-NC; Thu, 23 Sep 2021 19:46:32 +0000
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com
 ([40.107.244.75] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTUft-00CUIn-60
 for linux-nvme@lists.infradead.org; Thu, 23 Sep 2021 19:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAlwieu9dFbSRs5OmqUpJ451D1Z2z7c5qlrelHL+QCNsgC0Rho7Br9cGF8X9d63TlxVwNbaiMi41FQlDUWKCk2ouEEqiYUOSW1xzvrc8E+TP7R8S0doG975cJDq0Wyl0Qp+zBqHKhJlnCdoldyhfc2dFo8SuMWVBynseTCtzfbKc/bq0YiHeaQ4DZPgqph8ijHGfNqzZlsc2dhwdNXDZEPrQtxbAPaIsYWx/qIMZNZPZuTYHAqNTBY9dro/r8QW2ozBCziLwXkgblSUvFyi0IjbY16bmcWwnR5Iyj8N7yuqRH8GUg1SsJiIAFFfTM+FZSZufEUyC5qbb0K1OIdHYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=jyzXjnT+9LB3QnLnZROyv+ufV2nHs5YCj1mpc6RyX+M=;
 b=VIQO717klYD7kJG+D6pY54k/a8CTAHOM1k8NXNjmxk4oZZi3oH5VtNFR67GhB09y9j6rxv1qSTuIJEj73Ro5PmkC348WnjgYTzNJgMKn/beBz6ne/5S0B7PUyPRvPcKmEssU4FnWm3EvN5zPUDrtzv8qXa7rqGamXZYZMfuI5hERlo+faiwASKQ6hwKI8+0o4tFWVfRGTreAulg3LqOO/PUz0+m4/wz6xz50eJBfWS81dxwkVnlu01LD5rVSxVS+Al69EsvJ0jx+FvD96nA7lt2NHW5CIKJw/ZgQ/ERk41Xw/lPCRzzFIhoVWLW7+EQhHtp4Gyzp0LaEdW2ERRcgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyzXjnT+9LB3QnLnZROyv+ufV2nHs5YCj1mpc6RyX+M=;
 b=fDCwencZ+kb6ew6RL8i5wVYCnRswvgnYn9oD/6weEs6FJf07YFG6hMnaQ5MsCq5VZOLorYWfLHAyS90NARDWz7MPLa37ryQ20lYFKX9rKgd5LemGbHHPYZBp+i0gNzFIhRoN6odW8DWwAnktY4611XVfFruaA4QetykbNBLxIWNlzy8rLtiMcRINSLPACMApAz2f0osx02WUNHuVimDVA3U+3/YkiVtQJhUYU07GJyFtByUz8ZVpCrZiFPtytOvlzDHxT9Mv8DByNCdwhNmAuNWSdtuYUT2VQyC8faKDQWWSDtmVeaCtl/+3WANveGuuD47xno9VNXLQgtKRTw4/Lw==
Received: from DS7PR03CA0149.namprd03.prod.outlook.com (2603:10b6:5:3b4::34)
 by CY4PR1201MB2500.namprd12.prod.outlook.com (2603:10b6:903:d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 23 Sep
 2021 19:46:26 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::b0) by DS7PR03CA0149.outlook.office365.com
 (2603:10b6:5:3b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 19:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 19:46:26 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 19:46:25 +0000
Received: from [172.27.15.96] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 19:46:23 +0000
Subject: Re: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
 <20210923101744.4204-2-mgurtovoy@nvidia.com>
 <a6381c90-4eef-a9e1-2156-9f7539f169ea@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <3475a373-0cb4-b9b7-2da1-580505dee29a@nvidia.com>
Date: Thu, 23 Sep 2021 22:46:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a6381c90-4eef-a9e1-2156-9f7539f169ea@nvidia.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec3cc4f-f31e-4bd3-f3e4-08d97ecad460
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2500:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25000912D2BF2B56B59ED6E3DEA39@CY4PR1201MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHwm7G1sDDbVU3ANpObyd61QNM7AJ5TbZnQHdvQdumKZo3sU+V5WDk0hWBAQSH4I9OEia7fuAkK5jtk444K8y5ZcHWruZGbG+UDpJMQJoPd3sSDOk92lmAgY5GlW0G1az1BznqJa11tUhkBYbh5M24Ui+a3tu+C2jGpm5SiD6yrXWFdt6nE3vYNmq9x/C6azFlOK+mQWQBeRGFXi62zckWBFtL5VDoRDCjS0kIwHQ7vDV6heTd63rINoiIQf7opfw/BwjKRMkHr7HZNXTmuth2bQPL/qWlIPdv4V+envpzF1TbutufMTIr9KkSRLyMmOYzR8iCHCAOV5beJX/ZoKJSfDARxD6oskk9alJi8LshgN435Ln7T7nGIIP7QSvuOjQQwMDZdQearWcQ4SsSyJwJZZsa5ReBkcD+80KkABYF+Fzz5OfU0BRAJ97f7DP5UTqc+xR9e8nVaCur+c1c8p7/j104ELC4/DRhx5SP8gF+OuTUaJkFUIrs51vR1mr18117HQILuErhbqFq9+mjHBeIATK3PKiFaHa2pe5pL00EiGeXSMd9d1M0F0uZ3qbRTv2DaNbSDDmAYqq10Iwz4OUv2ycDm0Fn/FUzIsOu7xrdPqJ2ttFj6Qeqhoz5nw1o39TPOQUhrwjThRzlH5lsSnPEXXd/waYNH1uooc5vitfKvxbJPxV8+e4uQsCdpYxkUIg/QI/B020+5fv2LUd2n5z+UcCw7Dv1QhWG/Y7GObGb4=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(316002)(2616005)(336012)(70586007)(16576012)(31686004)(31696002)(36756003)(2906002)(36906005)(8936002)(426003)(53546011)(86362001)(82310400003)(356005)(16526019)(508600001)(5660300002)(186003)(7636003)(83380400001)(70206006)(8676002)(26005)(110136005)(47076005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 19:46:26.0233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec3cc4f-f31e-4bd3-f3e4-08d97ecad460
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2500
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210923_124629_468417_17A0D556 
X-CRM114-Status: GOOD (  16.12  )
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


On 9/23/2021 8:20 PM, Chaitanya Kulkarni wrote:
> On 9/23/21 3:17 AM, Max Gurtovoy wrote:
>> This makes the code more readable.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>    drivers/nvme/target/admin-cmd.c | 3 ++-
>>    include/linux/nvme.h            | 1 +
>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index 4ee9fe134697..92d81dc5906b 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -380,7 +380,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>>    	 */
>>    
>>    	/* we support multiple ports, multiples hosts and ANA: */
>> -	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
>> +	id->cmic = NVME_CTRL_CMIC_MULTI_PORT | NVME_CTRL_CMIC_MULTI_CTRL |
>> +		NVME_CTRL_CMIC_ANA;
>>    
>>    	
> So we actually had this discussion before to keep it open coded.
>
> If I remember Keith had already sent out patch for this one...

I don't understand why our code should include constants and not macros.

And if so, let's do it for all macros we have for the spec. We need one 
policy.


>
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
