Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB3BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:58:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6E561360
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C6E561360
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYkmL/SBrVR8Y16IYZK+1s5ZVTVaIBmG+u74TEQdd8U=; b=JNzfO3nlscj1h3tcXGYWiLDJ/E
	kLeB1XgjNTvLhgmX2cO7vhgn1m/uvxDBHKE4fg3oLVcNXFj5s9Nd1Ms7BaGmotH4lK/RYoUNZQXZt
	+EEVjj4xZwtoM3NfN21OXjvKyrVUkF4evhnPwr7uPy0SPUMLZRe9Wf5dVnIqW4g5HszYMDgfHh7PQ
	LEjgFPWLS12AKAO48gNxJrmXWY0Yw1Xs/J/FLXL+89Xr75xvjf27ZJmSkwfxEFozLeiIPgrnbFfcx
	lS4FZx5UTsDWsfvWM6xNoEflTv0GSMQTM0uW1XnQvo4rUlkYlAN2kdyYj4+NSYHU8tWopK9RQkHw4
	ZBQ1PCtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcohM-001Ka5-4d; Tue, 19 Oct 2021 12:58:32 +0000
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com
 ([40.107.93.59] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcohI-001KYh-O6
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpw1piiWeQs6WVaS7G7B1Jj7CotPrFLxJklK4ZiYpFEowl2AQ0mHT6YMswERrZEqqrtEy8ybraljshBU09ZUkMd3R0zK5RwrZz2lvMtgIKSDPmqZcgdPXTx+zlj2DfX/NeKE8bg63ka4s0GwOl7sZrN5FgFhj4oaFfFHaizTtVA5xVUG04Jg+1/BLY5wDMFX9CwsgP3i7hUqMAaY3JqfqB7UyRIlreYgUGRZnOcCG1SAvSmrIi/BvZazcHXP1IQXy+ii+mbsp8ZTq/WR/g5GhAH8QiAZWy0igxT/JTwDFWom2st2uT+PlUNMWs0/RUh/fIWihkPCmGHT+/yqax14cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYkmL/SBrVR8Y16IYZK+1s5ZVTVaIBmG+u74TEQdd8U=;
 b=WR5iWglu5kB5GZkWkSdlLgPm2q8Td4fM4clOAA6QspynhOK+27tIHSHrkMfAPSoxZP6c/yfD+Ei6F6LXHnbOnyxMm1oFGaS2GkzrNwKvrbuwMrIsdm+VoCI9iUUolaKHOksnPWcce063+9ESsjJqfOZMrUmg9owX6feeER4Wcw4aElqiBxj3OJIzLXlR8qWyLfHZOQDJu6g1Dk1DTnjoQd9itFU0sm3T8+RliyPyb6Ee7sFa3+GNm2dkmmqjfpbGzJWb9q74MGea8Ok8SNZ2gc/UH6DOQp/COM6pXXjSZ8K0d37pLHO66r9fi8g/rLlfEiF/Oh+aVUvPEmEQAJR0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYkmL/SBrVR8Y16IYZK+1s5ZVTVaIBmG+u74TEQdd8U=;
 b=Jc5q1l0nsPvV8rFQ5NghVKe5e9nsGFwtKtMrEdbc/m3/n7F+AxGEE1P8t1wcW9thCypfbU0HUn7gcH+8wWFJZZMqQL4NO5c3Y+FAEDQBFHNNpJbqFdbZqwKwKXhhuso3hFyB3PG0mvHklwlJgqug+cZBP6T49MlCVlCdGXbCfCn2Dkee3FBE+6m4WrQ0912C/bBIeKLVqCVVthSRI2ZNSpHzES9yNroV6EBb5cq/89RkRUOErm3FGuxprLweJrp5nPyPkPZ/t0lB0DkpTRjsRFS1H7QuK72QzVn4mCFu7wFfXXZIwmIiR3spZVj7h6gRi1ojuGsgC5HjIJQF/MojcA==
Received: from BN8PR15CA0046.namprd15.prod.outlook.com (2603:10b6:408:80::23)
 by MW2PR12MB2378.namprd12.prod.outlook.com (2603:10b6:907:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 12:58:24 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::b1) by BN8PR15CA0046.outlook.office365.com
 (2603:10b6:408:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 12:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 12:58:23 +0000
Received: from [172.27.13.79] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 19 Oct
 2021 12:58:17 +0000
Message-ID: <d2a7a65d-f98b-97e0-6035-a06c75da24a7@nvidia.com>
Date: Tue, 19 Oct 2021 15:58:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/7] nvme-fabrics: introduce nvmf_reconnect_or_remove API
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>, <kbusch@kernel.org>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-3-mgurtovoy@nvidia.com>
 <97e9e1ec-701c-fde7-809a-056b89655d99@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <97e9e1ec-701c-fde7-809a-056b89655d99@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c69c4fff-0548-405b-cbff-08d9930022ee
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2378166560DC6EED105B21B7DEBD9@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hJncyIQfdW/FM9408u3LsvLSuq8W0YaVjUZA1J3sIi+m3kMW1oQVXmCB1eQAh3EIGPU+F+df0E6mM+PkMm10mBA+AGyxQ7oRp92zkR8yiyRwu/P5+eCKsTVT0O3yjBGkRrBOy96jkaDegBcC67RHNFhCz2fl3ArEskegRyFndwLBX/yPMmzNEjnHUvxhpnt359wkoDrhqKkEhgnjteuVmRd58RbNYajyUvZiSsE0omlZiQGBLC5slM6yFM0w62Fm1TtXPouoItA8I+b05ez1SrhHXu93Y6kiDEDt2CSRIkDIWVisMxu1KrmF2oyRw+nzgmhclAmZm7aZSh9s0+dyn9FlqjUiqR+2S7HxqH6kgvPk8jzjWKVFh9iOUxxdevEs9HqH6IDQkdz19RhvXwCxoZzXWa9QvnBdR2NvHDL57F/53wOXMQsMlBYPMsDNZ7/Ig9X49/XHzB8nSRCF0HSpYIEXMUwKWlMMNfiX26n6l6cdnCQ4eeJDWeAVPM3bBXMylehDwW8Gy0o1i0lwyuLM+D0wxhNgzmN6e550rIKsEm9nLDxInVPMBHfU7gZbxPMZGkUXH24CQOw9aPttfSh+qTSi3zUtbgc3xqNvbyAnCGXl80jgKjxqHOn00KTbVeT9nWV+Kd6OTthU3bYXjauinBexQjJjcLa7acdZWfJWxOwcUN3DdGVokqKFy+UWBidDWgS0fSutuzSWHTTCe0M6J6oAKNzHyJH1hbFINGimxc=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(7636003)(31696002)(70586007)(16526019)(70206006)(86362001)(36756003)(186003)(356005)(82310400003)(53546011)(36906005)(2616005)(6666004)(47076005)(5660300002)(16576012)(8676002)(2906002)(110136005)(36860700001)(4326008)(426003)(54906003)(508600001)(31686004)(26005)(8936002)(316002)(336012)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 12:58:23.8557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69c4fff-0548-405b-cbff-08d9930022ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_055828_812422_EF0FCFF0 
X-CRM114-Status: GOOD (  16.19  )
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


On 10/19/2021 3:36 PM, Sagi Grimberg wrote:
>
>> This logic is duplicated today for RDMA and TCP controllers. Move it to
>> the fabrics driver and export it as a new API.
>>
>> Also update the RDMA/TCP transport drivers to use this API and remove
>> the duplicated code.
>>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/host/fabrics.c | 21 +++++++++++++++++++++
>>   drivers/nvme/host/fabrics.h |  1 +
>>   drivers/nvme/host/rdma.c    | 25 +++----------------------
>>   drivers/nvme/host/tcp.c     | 26 +++-----------------------
>>   4 files changed, 28 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 668c6bb7a567..4a1ef67c6fb3 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -472,6 +472,27 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
>>   }
>>   EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
>>   +void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
>> +{
>> +    /* If we are resetting/deleting then do nothing */
>> +    if (ctrl->state != NVME_CTRL_CONNECTING) {
>> +        WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
>> +            ctrl->state == NVME_CTRL_LIVE);
>> +        return;
>> +    }
>> +
>> +    if (nvmf_should_reconnect(ctrl)) {
>> +        dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
>> +            ctrl->opts->reconnect_delay);
>> +        queue_delayed_work(nvme_wq, &ctrl->connect_work,
>> +                ctrl->opts->reconnect_delay * HZ);
>> +    } else {
>> +        dev_info(ctrl->device, "Removing controller...\n");
>> +        nvme_delete_ctrl(ctrl);
>> +    }
>
> We need to look at fc here as it does this differently.
> Can it converge somehow? if not we can add a callback for a driver
> to override it.

we need to start somewhere.

Adding a callback to override this logic is not a problem and i thought 
about it but decided not to do so.

James and other FC developers evaluate moving FC code using more core 
functionality to ease on this driver.

This work can be done also after merging this series.

This series is not related to that.


