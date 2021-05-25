Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE9AC47086
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 22:50:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EDA610A8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 22:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EDA610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OMKWmYzF3OKgDmpg6y02dptlkCrgkowY5JzG1c1nRSo=; b=cSQYuOawbWS9KNB4esBhnBR80+
	4w7oC33NNX3M3xPmzIh5r/kxc6M4il1C1+N5FKmNi2WyepKCYdPRVdKIf9x9xASCbHoeLvRzx0N2q
	D5C3XSDK31QicZbekvkdqbPRaxgYVs/5l7lwiZ5azzwnJNwbWQ0AV4/KL543JrUYa9mU/8Sqv5pHB
	Gp5PHaxNx50sgxPi9wxL/8XPqu59/ohBgvOSYZ5TWq/+OV2lLFHXBfLQS9luQfl4BVcZGk2ogUC+5
	rLZV9GAAOeVO9w5pa1Wsd+/kllg0QwqRD8dQg4jbJzSMU9zIS00KjFiqI3h9qxD4SfE7WGI8yjElr
	AzBJdtcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llfsl-008wAL-Fz; Tue, 25 May 2021 22:50:39 +0000
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com
 ([40.107.223.58] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llfsh-008w80-S8
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 22:50:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGpKYMVNmxywZ3UYDJJGK5FcKdPlWFSn2VIPq+5mE2YmXy3b/mfbebIZ8oiPEUi6pypkLVrKoX5x8iUSDQZlQGu7n1MqP89hrN+hpp1ASDnUrVHS3hPUF9j+lPcvRHZj//Dhwq4WtRRhffwuHlZFfGdG7SEcbOVcE8nvskyx3Xs8yOLBGwhVnRacu8ZcM6TPs6z4T3x/iu64bHSUfR3+0iQqqekYVwGrrJ+UmTlsMJJFhSSubHH8n30X/w6uZxuoK17AhI+htRskP/C2id8G60ywNMH64VBvnqaQgSearHvJBOE7hLJX7aQa80WKhFWoNyfDFbu36UbZPbSuUGPqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOWh2+oq/jqZAHOVc2IMX1pEC1il+JU1yz8TUwdIBgs=;
 b=T3kTj5GSHjdCjcOQyQDgHxTOme7wEjB29BRGE5/ZXhr5/ECwfiY03w1zLW78d6mo1X6bSJ/RVJU9cSzfm6G+xlf5zjfRNjyt5IYzQ6iR2cCA/GqC4xHnx8URxSPuZTQgrOfEmGfVH6Xj7FcS2dlMDm7hnokaYv5GUjEt4M29agrq9ykxTg5xX46Ao+YPFmBbARuZ+NF18CJfuYiU1vfawGpVLGrh2wC9wL75qV6CcAS8HDtohNf7bx0+04eitlrF8w9RTtKXsvca+cSNwZGTfc7lkNFF+WkghbMOuhYRugPEFsZbRe/R8pE23+BGaBjHrRjtSPxTSQ1OLx3dz4Y1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOWh2+oq/jqZAHOVc2IMX1pEC1il+JU1yz8TUwdIBgs=;
 b=pcJc7B08xo/kp9swm8uxAwoGTW1JVCcmjgVvkPy6pTnZhi2pgUQYW9+qK/DM9Dqv9rJ/4wBSQwIATO5l0HJH/YZkb6kVw9ekfJ2YRQUXTeaSzl9F78Juj9lgI8w6VpLJOB/eo4AHtF//PSb520ZXWTxfwqZ/WtuC7MpaeLLDh9GlEZzLiat+QXtzyvwQJhrRYiv76JskI7i4J8WEdQuv7o8BlcGGZ1AsX+yGJnhzFYBswDaDpIIulW/LiqYT9ehZVFqf+6y7JvtIvOqlUGygih6XLHD/EssUWMc+Bj3NxcOoGX1lyvT8SMJ62asURLysVhUi7j0ko0w4lY6emgMFyg==
Received: from MWHPR14CA0050.namprd14.prod.outlook.com (2603:10b6:300:81::12)
 by BN8PR12MB3012.namprd12.prod.outlook.com (2603:10b6:408:64::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 22:50:33 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::9a) by MWHPR14CA0050.outlook.office365.com
 (2603:10b6:300:81::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 25 May 2021 22:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 22:50:32 +0000
Received: from [172.27.1.41] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 May
 2021 22:50:31 +0000
Subject: Re: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
To: <linux-nvme@lists.infradead.org>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-5-sagi@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <57030aa5-976c-8d0c-b6ee-7c69fb5f807c@nvidia.com>
Date: Wed, 26 May 2021 01:50:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519174340.1144806-5-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79c2733c-c118-4342-22a9-08d91fcf80dd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3012:
X-Microsoft-Antispam-PRVS: <BN8PR12MB30129EDD73AA3557BE0F62CBDE259@BN8PR12MB3012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNHsDd/09aWDI9u4MpkNqUaXQCMHnxPVcnhAEsH+pSflHBf/TrVoIDbBLKVcRydchL0OEvArR9Dm0lIWkVEYcnOZfagnmj8b/Vg0oNpNgQ3kBScJU10SqLSz5oYXpG5QeqGNUSMnkeIgeX4x8Lw8rqByETMzKyBozfkMGeDhyxSM32xoote2jPibBkRlqxwCuF39aCZ9jj5VQ2A8nFvGCC3UovToIcZ+YfdkLezoAFjUspZRRfaXLSg76hQ1TTtVcG0nts9v+iml0hIhKvOIdztJl0Qd1ZzGPWeDCtYr9w+16FdmjW5C1CbhajYp6Io/AktxnK9zTo2hJhq7dGG2MklVcbYpKdVE35PqZC1Jxx7ZryMi/3WJR5ynxaF86ljq33+pmIf2u0jRnBDN7+7c/YpMHu0BHIv60NCkBLPK822vXHIeh93ZHUJQ4+zlgn2xDOhJlB/U7xCk/xj2QRfR8xfuWlAjjbIJJ0wVWEQZ+WmFJ7Ztt0UE0OZpD5CHwwc7O2zjntYzLyfNHoqY2RVE6ECxppnXE9Z1+G/ySic/oqxICNJOAkt2CMh4aeUsuATexEhDOyHnfjM7NKY/oMkwAS6FH5w351RMAQvYkZ36MMfhXCq3E0OSGVENA7Z99+EvSxwSHyXm1YuA4sp+pm6WAB/AN09OhjFTGM6+p3J7anJnY+8o6BOeq04gLSHQ8M0H
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(83380400001)(47076005)(36756003)(53546011)(186003)(336012)(6916009)(82740400003)(8676002)(70206006)(36860700001)(16526019)(8936002)(356005)(70586007)(7636003)(2906002)(26005)(31686004)(31696002)(5660300002)(426003)(36906005)(86362001)(16576012)(316002)(2616005)(82310400003)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 22:50:32.8863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c2733c-c118-4342-22a9-08d91fcf80dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_155036_099263_AF7E6A9F 
X-CRM114-Status: GOOD (  29.40  )
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


On 5/19/2021 8:43 PM, Sagi Grimberg wrote:
> We cannot detect a (perhaps buggy) controller that is sending us
> a completion for a request that was already completed (for example
> sending a completion twice), this phenomenon was seen in the wild
> a few times.

The bad controller should be fixed.

In the past, I've sent patches that check that sqid match in nvme cqe to 
protect faulty drives that might send
the completion on a wrong msix.

My patch wasn't accepted since it added an additional "if" in the fast path.

Now we're adding much more operation in the fast path because of buggy 
ctrl ?


> So to protect against this, we use the upper 4 msbits of the nvme sqe
> command_id to use as a 4-bit generation counter and verify it matches
> the existing request generation that is incrementing on every execution.
>
> The 16-bit command_id structure now is constructed by:
> | xxxx | xxxxxxxxxxxx |
>    gen    request tag

Is this new specification for command_id ?


>
> This means that we are giving up some possible queue depth as 12 bits
> allow for a maximum queue depth of 4095 instead of 65536, however we
> never create such long queues anyways so no real harm done.
>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c   |  3 ++-
>   drivers/nvme/host/nvme.h   | 47 +++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/pci.c    |  2 +-
>   drivers/nvme/host/rdma.c   |  4 ++--
>   drivers/nvme/host/tcp.c    | 26 ++++++++++-----------
>   drivers/nvme/target/loop.c |  4 ++--
>   6 files changed, 66 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e6612971f4eb..8308dd1e9e3f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1006,7 +1006,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>   		return BLK_STS_IOERR;
>   	}
>   
> -	cmd->common.command_id = req->tag;
> +	nvme_req(req)->genctr++;
> +	cmd->common.command_id = nvme_cid(req);
>   	trace_nvme_setup_cmd(req, cmd);
>   	return ret;
>   }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 05f31a2c64bb..e6f72c82582d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -158,6 +158,7 @@ enum nvme_quirks {
>   struct nvme_request {
>   	struct nvme_command	*cmd;
>   	union nvme_result	result;
> +	u8			genctr;
>   	u8			retries;
>   	u8			flags;
>   	u16			status;
> @@ -497,6 +498,49 @@ struct nvme_ctrl_ops {
>   	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>   };
>   
> +/*
> + * nvme command_id is constructed as such:
> + * | xxxx | xxxxxxxxxxxx |
> + *   gen    request tag
> + */
> +#define nvme_genctr_mask(gen)			(gen & 0xf)
> +#define nvme_cid_install_genctr(gen)		(nvme_genctr_mask(gen) << 12)
> +#define nvme_genctr_from_cid(cid)		((cid & 0xf000) >> 12)
> +#define nvme_tag_from_cid(cid)			(cid & 0xfff)
> +
> +static inline u16 nvme_cid(struct request *rq)
> +{
> +	return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
> +}
> +
> +static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
> +		u16 command_id)
> +{
> +	u8 genctr = nvme_genctr_from_cid(command_id);
> +	u16 tag = nvme_tag_from_cid(command_id);
> +	struct request *rq;
> +
> +	rq = blk_mq_tag_to_rq(tags, tag);
> +	if (unlikely(!rq)) {
> +		pr_err("could not locate request for tag %#x\n",
> +			tag);
> +		return NULL;
> +	}
> +	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) != genctr)) {
> +		dev_err(nvme_req(rq)->ctrl->device,
> +			"request %#x genctr mismatch (got %#x expected %#x)\n",
> +			tag, genctr, nvme_req(rq)->genctr);
> +		return NULL;
> +	}
> +	return rq;
> +}
> +
> +static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
> +                u16 command_id)
> +{
> +	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
> +}
> +
>   #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>   void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
>   			    const char *dev_name);
> @@ -594,7 +638,8 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
>   
>   static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
>   {
> -	return !qid && command_id >= NVME_AQ_BLK_MQ_DEPTH;
> +	return !qid &&
> +		nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
>   }
>   
>   void nvme_complete_rq(struct request *req);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ac26d242b630..7398c5a76956 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1014,7 +1014,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>   		return;
>   	}
>   
> -	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), command_id);
> +	req = nvme_find_rq(nvme_queue_tagset(nvmeq), command_id);
>   	if (unlikely(!req)) {
>   		dev_warn(nvmeq->dev->ctrl.device,
>   			"invalid id %d completed on queue %d\n",
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 203b47a8ec92..ab5b7d175488 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1727,10 +1727,10 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
>   	struct request *rq;
>   	struct nvme_rdma_request *req;
>   
> -	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
> +	rq = nvme_find_rq(nvme_rdma_tagset(queue), cqe->command_id);
>   	if (!rq) {
>   		dev_err(queue->ctrl->ctrl.device,
> -			"tag 0x%x on QP %#x not found\n",
> +			"got bad command_id %#x on QP %#x\n",
>   			cqe->command_id, queue->qp->qp_num);
>   		nvme_rdma_error_recovery(queue->ctrl);
>   		return;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e189715ceca7..cf30568c9bbc 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -487,11 +487,11 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   {
>   	struct request *rq;
>   
> -	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
> +	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
>   	if (!rq) {
>   		dev_err(queue->ctrl->ctrl.device,
> -			"queue %d tag 0x%x not found\n",
> -			nvme_tcp_queue_id(queue), cqe->command_id);
> +			"got bad cqe.command_id %#x on queue %d\n",
> +			cqe->command_id, nvme_tcp_queue_id(queue));
>   		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>   		return -EINVAL;
>   	}
> @@ -508,11 +508,11 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
>   {
>   	struct request *rq;
>   
> -	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> +	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	if (!rq) {
>   		dev_err(queue->ctrl->ctrl.device,
> -			"queue %d tag %#x not found\n",
> -			nvme_tcp_queue_id(queue), pdu->command_id);
> +			"got bad c2hdata.command_id %#x on queue %d\n",
> +			pdu->command_id, nvme_tcp_queue_id(queue));
>   		return -ENOENT;
>   	}
>   
> @@ -599,7 +599,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>   	data->hdr.plen =
>   		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
>   	data->ttag = pdu->ttag;
> -	data->command_id = rq->tag;
> +	data->command_id = nvme_cid(rq);
>   	data->data_offset = cpu_to_le32(req->data_sent);
>   	data->data_length = cpu_to_le32(req->pdu_len);
>   	return 0;
> @@ -612,11 +612,11 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   	struct request *rq;
>   	int ret;
>   
> -	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> +	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	if (!rq) {
>   		dev_err(queue->ctrl->ctrl.device,
> -			"queue %d tag %#x not found\n",
> -			nvme_tcp_queue_id(queue), pdu->command_id);
> +			"got bad r2t.command_id %#x on queue %d\n",
> +			pdu->command_id, nvme_tcp_queue_id(queue));
>   		return -ENOENT;
>   	}
>   	req = blk_mq_rq_to_pdu(rq);
> @@ -696,7 +696,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   {
>   	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   	struct request *rq =
> -		blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> +		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
>   	while (true) {
> @@ -789,8 +789,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	}
>   
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> -		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
> -						pdu->command_id);
> +		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> +					pdu->command_id);
>   
>   		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
>   		queue->nr_cqe++;
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 1b89a6bb819a..9f1f5d572960 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -107,10 +107,10 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
>   	} else {
>   		struct request *rq;
>   
> -		rq = blk_mq_tag_to_rq(nvme_loop_tagset(queue), cqe->command_id);
> +		rq = nvme_find_rq(nvme_loop_tagset(queue), cqe->command_id);
>   		if (!rq) {
>   			dev_err(queue->ctrl->ctrl.device,
> -				"tag 0x%x on queue %d not found\n",
> +				"got bad command_id %#x on queue %d\n",
>   				cqe->command_id, nvme_loop_queue_idx(queue));
>   			return;
>   		}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
