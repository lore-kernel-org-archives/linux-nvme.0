Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831EEC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 13:12:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9DC651A2
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 13:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9DC651A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vNZXzRxKDVmgVzA92kYJXnRh8L5NMf2HH9NJie28lKc=; b=Cc8f79KWUmYEz1uVkFJzxBVW7
	bH4uWR+vXXL44wdTzg1huqBRX+I+ZlRMvrC777QVyh02KEdSJkm5l4YuYFptiJmHbFXDMh/FaYiaX
	1zsbMLocP6kNVCN2YUtjhes5adCwrl4qaGS0WvvgRYbmS7qLjW/d7ADz5+tg9YIB9vwmVuX0ngk2X
	spNdfB5otsAKA7E16+eZOT+fMdVBn5yLFm8AmO0wj77ZcUbWcCyxbonb2iDR2rEMOSelPRd5uDE/9
	o5944ApbxJSBeBKAzgLS6uOD39VSPjzE733xL8LoJ7HLMI/FBoPvOkqf9cGeY9LgJqXmuzTIgDOKq
	TLOJZULpA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJFg2-00HMq1-IL; Mon, 08 Mar 2021 13:12:02 +0000
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com
 ([40.107.94.42] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJFfv-00HMnt-6Q
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 13:11:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd+YpgpFnNWAYGSzbC5zIn6XGy8dxm+hWPBSREgMP5DREdKfT0jQp/g5OIjDXGumewO8x91h+NrvwhfWTCWOSmOPIg6O7J93fFZX+NjLR29CgnwAvFW9JD79eMzEPRiy9IoiqOP6NYj8+EToX3i27OmlDbOsB6YbR6ha6xCD5/oeyYX0ZD3c6ynGltd/39H5APpHXaUQ1FKouyMecAOe7nXcXfzb4QEL1w2nYtMoiOHDLUJnAB5pJXJgV9sf9fIA4QQDbDCbfmdkU7eYlIF5MzGEgtl7ieyryrGAq+5iqd2+FH+CcucJ6/YHgSgBamTymhqPFISmeuJWAPjWRbTagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwzPdTwB2bATb1teArFPb8WJzhhapb5OQKWkL5zd9Gs=;
 b=aUlI4JspvoF7dLz1Yv0NHvppU5L5V1mV25DyBg55zr/aaWzABB8z02mi9jdaqBzaJs8xAG8ug907KwSsa2+KiW7LYEgLUHj4yrtsNuro88x16ZZ9YfC8extQiR28kqas82o8/neLtitb5XW4+T/VP5JJ4MtcP/w9yO8YTexY/aPXPOpRVAqJnl84L/bnUK/1fE1qdvjJf7WpZDfgBhnNyicD4zpkxYoBlt+LMAuCXgb4usT//o2Y4PhQDCQUoMcvHMrva3apgh5d+dTdYayKcPE68VF+Q1xLUDqsLOO9efO9gvtyT3m5MVsVd1oMra+2uI2lNSwwJPmJK0eF+ZINew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwzPdTwB2bATb1teArFPb8WJzhhapb5OQKWkL5zd9Gs=;
 b=w8yhOYRnRBWnSbGr8HNLi5CfiT7P1B+naEk2mxDVHtLYqOPow+2AK3qvZXrv7va6EMPCe4R9kdQlyAbQIyfVSPg6QgINey5dDG4wUq55fgYgHH6RBlrklVa2dYyFb7j/oxNPfozIGucBcbhBx47BlQ7fcx/N5oS3lDHoHLO9a7k=
Received: from DM6PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:40::22) by
 MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Mon, 8 Mar
 2021 13:11:49 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::f3) by DM6PR03CA0009.outlook.office365.com
 (2603:10b6:5:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 13:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 13:11:49 +0000
Received: from [172.27.15.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Mar
 2021 13:11:46 +0000
Subject: Re: [PATCH 2/3] nvme: sanitize KATO setting
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>, Chao Leng
 <lengchao@huawei.com>
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-3-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <c2fb8d9d-6dca-6666-d7a5-ad3f43c815aa@nvidia.com>
Date: Mon, 8 Mar 2021 15:11:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302092644.80701-3-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa0140e-7f46-459a-59d8-08d8e233bbe6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4533E38FEF5320B5EF4087F8DE939@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pV1wfcViNUodrPP5pfNUEVVQ9h2MEbc69xp5A9p7kehuxMKLIBpeUqJWdQVk4fVY3qYS+YxqoorWmneqQ0trMUPRL0kBlOQd+fIkPpK/ud3Cr7yUpFkubC+9XHWxQaTeczlcgq5aIN+DqU8c5CSK1CVoRTmpg0vDpumEth/QjI3YJfgoo1CD2qAx/EHEfjO+otX0FPdUJ5DEg7JWo3+91BkLLs2+Fip4lPYYpJ4sezEvM05B+5g1dmy/rU8MEq07dkXjK5MyRno55rFpt3A8g5h6JMFJVS8TRpsUGFK8v88cqwLVGcn+rxX7Gi1cEW0af0d0nA2sdbMjn+YQquJFKeyi3uS/zfClzZz2Zi0dgLivCZCQeVqftWqJEMP31mWSoZhY6YO0iBJGqr9TydinDc63oFX68OgiT6mQJJULUwL1r9wLHmREKUp31PHDymWYOF8/TlFlmdbDoEVWyi4zf+CPV9ertcRfuBohL7yeAaAAisuuwXKEEgrKh96N4Tj4nDah6prK70gT913XfG0jp386r565PN+Cd/8OSwM+y6fCeCzY8jFXS/InqYevx5of2zA0FcP3m/WYwjWih9zWoFKWRymNqRUVAIcdR35aZXdPssDfZ5nFJrtmNL4EdKcaIkGhq07Zc5m8EZTYw8jrBqjUSJzffFa6B0kK660G2aNXCxdR/0gny3qVLoQmhBBK9XcKUB6KgDPDAEF+FPNhQuC7bp7yvJsSJ74IyXZzgY0=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(83380400001)(53546011)(2906002)(47076005)(70586007)(34020700004)(82310400003)(36860700001)(54906003)(110136005)(31686004)(7636003)(36906005)(316002)(5660300002)(70206006)(16576012)(31696002)(36756003)(8936002)(186003)(8676002)(86362001)(82740400003)(26005)(356005)(16526019)(478600001)(426003)(2616005)(4326008)(336012)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 13:11:49.5221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa0140e-7f46-459a-59d8-08d8e233bbe6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_131155_591522_1488E60A 
X-CRM114-Status: GOOD (  21.33  )
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


On 3/2/2021 11:26 AM, Hannes Reinecke wrote:
> According to the NVMe base spec the KATO commands should be sent
> at half of the KATO interval, to properly account for round-trip
> times.
> As we now will only ever send one KATO command per connection we
> can easily use the recommended values.
> This also fixes a potential issue where the request timeout for
> the KATO command does not match the value in the connect command,
> which might be causing spurious connection drops from the target.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c    | 9 ++++++---
>   drivers/nvme/host/fabrics.c | 2 +-
>   drivers/nvme/host/nvme.h    | 9 ++++++++-
>   3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f890b310499e..6d096d41a82f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1223,7 +1223,8 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
>   		startka = true;
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
>   	if (startka)
> -		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
> +		queue_delayed_work(nvme_wq, &ctrl->ka_work,
> +				   NVME_KATO_DELAY(ctrl->kato) * HZ);
>   }
>   
>   static int nvme_keep_alive(struct nvme_ctrl *ctrl)
> @@ -1258,7 +1259,8 @@ static void nvme_keep_alive_work(struct work_struct *work)
>   		dev_dbg(ctrl->device,
>   			"reschedule traffic based keep-alive timer\n");
>   		ctrl->comp_seen = false;
> -		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
> +		queue_delayed_work(nvme_wq, &ctrl->ka_work,
> +				   NVME_KATO_DELAY(ctrl->kato) * HZ);
>   		return;
>   	}
>   
> @@ -1275,7 +1277,8 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
>   	if (unlikely(ctrl->kato == 0))
>   		return;
>   
> -	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
> +	queue_delayed_work(nvme_wq, &ctrl->ka_work,
> +			   NVME_KATO_DELAY(ctrl->kato) * HZ);
>   }
>   
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5dfd806fc2d2..dba32e39afbf 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -382,7 +382,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>   	 * and add a grace period for controller kato enforcement
>   	 */
>   	cmd.connect.kato = ctrl->kato ?
> -		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000) : 0;
> +		cpu_to_le32(ctrl->kato * 1000) : 0;
>   
>   	if (ctrl->opts->disable_sqflow)
>   		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 23711f6b7d13..912830389997 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -27,7 +27,14 @@ extern unsigned int admin_timeout;
>   #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
>   
>   #define NVME_DEFAULT_KATO	5
> -#define NVME_KATO_GRACE		10
> +
> +/*
> + * The recommended frequency for KATO commands
> + * according to NVMe 1.4 section 7.12.1:
> + * The host should send Keep Alive commands at half of the
> + * Keep Alive Timeout accounting for transport roundtrip times [..].
> + */
> +#define NVME_KATO_DELAY(k)	((k) >> 1)

what will happen in case k == 1 ?


>   
>   #ifdef CONFIG_ARCH_NO_SG_CHAIN
>   #define  NVME_INLINE_SG_CNT  0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
