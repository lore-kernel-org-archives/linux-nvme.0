Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A69C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J4IgmfYHHo0GaHiGLvp8gmzkhhytlbty2B3BKNEutxE=; b=ToASWtOEmdGqQdpz51IW08YUDN
	26nWOzf8BfTFgD+564ZGNe+DdHvHgKO4b8XQhX494DHNRzci9ybi6JGfhaonGX5tYb3apeM0kf5y8
	a+KPlB8QZ1YXc6cAM6QLr0NrZnOPgGNvmW4r9biRZI6LFClnZvugbCqv6rJ39fqxF5FSMe3HCUbv5
	QRPNS4o6Q+gphUMj1x0dHoWaZ9hw2od2eRX1SFNZoD6OiPRDex+FB9CT19txKYPVj3RWWu9hvI5XS
	7ibLP+cTh+L76UUwLhWsd+BJLQ9CnUrUlfKPet2/N3wkU9C9+CfccUSlHQXZUbyC9lHS84Y/j47dy
	PBf5Zxpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFeL1-001tJ6-Lc; Thu, 03 Feb 2022 15:47:59 +0000
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com
 ([40.107.93.56] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFeKy-001tIV-GI
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 15:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqvkN3EwL/FjTHs9aWfNtWqCS2RNjKj+Q0OA8W4AQwQ54qFHvnG302sQpKmdyKX0Ah9WYWiWm0UJih+CcYa4Z9OqDXtydaUK0bQkRH0WMZDTpld3kfDxFKWgTfAtj99mlj9lc4DzeWPMTw85sqHVZdb2XGLPStZALS2uJrtP8XM7wj30pHEfYhH08HExW/wVSiRUC3sObWXMEIABaWtuwmj6IywoX+DPg45wncZNv5kNK4WdayXmVsJZu3n0ELDbMrPssh+bpj1hvA8ZMwGlA1DI9jLHvAR6QL6NGyyutHuI+6yieLw+NaBBR3MPVlit/ydAyE3HeSxAn4VxhnqXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4IgmfYHHo0GaHiGLvp8gmzkhhytlbty2B3BKNEutxE=;
 b=TTNstPiOqaouPWkUdYk9EVYPXr75Hz8bQpdoTkf59jJ/eZIfrrgufWau+beHohT95NM0FzrF9vw9ivl3e1qFo4LXLAtEZsiojPgk+KFdQamjHCbAaIxqRYfl46fguEm1iQYsAtLuG122nBtxoNmwU26fpwlNKrTXhqI4E8f0tzzwJ69rpSIkJxN3L+Wmoyd+EKxVW5B4Lv2hN19bk2i9oMTcWWgKGBpBUyClmE9xumZVtVPmYir68JwjtUNpUCLZjaXECYTpv84KFzHhD6sTl3FHBpiTV7TLNZB/EBP5ETC0NbgSHrCmSrEOgN7dHlDXoQTKqAczN8WV7kv2hXdMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4IgmfYHHo0GaHiGLvp8gmzkhhytlbty2B3BKNEutxE=;
 b=jDhZe7DdYO80CIoL1OiVjTt0skcbksNXpr0GL3tsXgPXft6DbKPdwOVpol+BIxact+RiKodmPped9DX2/kb+IjtlIh9yWRriS8Ve+aGx1EoeCFJrmpRrMu2r6ya0RrZR0bsuNW2V648Z0O1cbIuE4+wuRxGFu8lXZEMbTLtgu7K72YIybpZUIj5IeK/p0HsOj5LuwTYBqFX2nKIQ+30Fxcin2uvHRDTfC98yzkp8YfpHxK8ctowCqhj1D3o1txhPiVSJ8V5HczOcXj0E+5+dHpdV6IsBor7t8XBjRMsFLvxcRJLhhyOost4H3bZTm6krzaWJkVCVwKuTDAd4wr9cbg==
Received: from BN8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:ac::39)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 15:47:53 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::13) by BN8PR07CA0026.outlook.office365.com
 (2603:10b6:408:ac::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 15:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 15:47:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 3 Feb 2022 15:47:47 +0000
Received: from [172.27.11.222] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 07:47:45 -0800
Message-ID: <33761c8c-78da-8768-3a8d-bf4dbfcdb4b5@nvidia.com>
Date: Thu, 3 Feb 2022 17:47:42 +0200
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
 <b6b0d486-c1e1-bf8f-6720-9245bbf60815@nvidia.com>
 <8287fe04-b6f6-8bb6-c538-3c401da600c0@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <8287fe04-b6f6-8bb6-c538-3c401da600c0@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe74fcdc-81ac-4bab-ba78-08d9e72c8a7c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5205E1FEA9958601F0DAB449DE289@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGUqAXZGuFV05vLoSL9YbPMbD/lbLKkdHX9pUXQ4u1yufNJWAPZci6MXoZh35hqi1HdM6/dA7wEzoCIcmvhxwQb8GhZc2CbRE+w6jTLe9ifj8OEwYMdN0Nnn8DMjwFBAdnAHpqa7kIckF5xrTcjVY1r7loshFoNhehdzynmpQfzgrS9fWmF12+xY6o849tkZY4jDUhdYoJavbZdoS3AQDXXQxOxOL1hZRvrKbWt1YnJIy3DCpSUJyCPj6f4hUMiCX1KMQYjt/EloVwnRN+GpvdVMP9r9EdoTqJCkJKlXA3MLLfPSI8VEJvt8X5mqYPYYR1TEeng1W2nDKv3JQSU78+pyxICVDTdssXzfTFZr8w28fUFrusmcJhPGIQl4o52kFWe32V+z4GOp7r27MIkltmyKVO93irPYIq7M1TIr0wectYnkzi52/ueZXqDfgwJvlp4VsjGVPPirUNWO3pYxtSHX1WtxqaXLihiY0QcDKMcj0HD387NnM/n43tDp6nha0iIRHiB7wEv4c7tog/dnV+3OV0WIuJWp+74i2dmqUlKbMiNkExQcWIHhlhaN5OKg0wHW45R+XfyCmfTICg4Ycly1/v4r6mK8uJ0k/aAglo1rRkZQbyrkEEcDbUkKS0tS8yeXKmXnajWiO4FLdZpG+EviJfvMYlx1JCgPNZsWwBZCvmjjM0jRwEUkL4XODkeKvREVZQwn+ghslOfzBNN8mtHdLiVzIBiZ0E3GbbsHebCZpehx1+35shksK5btEisU
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(8676002)(8936002)(356005)(82310400004)(5660300002)(2906002)(86362001)(70586007)(70206006)(81166007)(40460700003)(110136005)(47076005)(16576012)(316002)(36860700001)(508600001)(31696002)(26005)(186003)(2616005)(31686004)(36756003)(6666004)(53546011)(16526019)(426003)(336012)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 15:47:53.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe74fcdc-81ac-4bab-ba78-08d9e72c8a7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_074756_627882_B7F2E648 
X-CRM114-Status: GOOD (  10.96  )
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


On 2/3/2022 5:03 PM, Sagi Grimberg wrote:
>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index dd18861f77c0..c11cd3a814fd 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -4251,6 +4251,8 @@ static void nvme_async_event_work(struct 
>>> work_struct *work)
>>>           container_of(work, struct nvme_ctrl, async_event_work);
>>>       nvme_aen_uevent(ctrl);
>>> +    if (ctrl->state != NVME_CTRL_LIVE)
>>> +        return;
>>
>> any reason you moved the queue_ready check in the transport drivers ?
>>
>> Is it redundant ?
>>
>
> Yes, see the discussion with Christoph

The discussion was on the need for local variable, wasn't it ? not on 
the need for the check itself.

But yes, I see it's redundant. this flush you added is actually 
nvme_disable_aen (like we have nvme_start_keep_alive/nvme_stop_keep_alive).

I think it would be nice to have similar naming like we have for KA 
(nvme_enable_aen/nvme_disable_aen) but the series looks good 
with/without that,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


