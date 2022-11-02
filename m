Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE88C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JeAOm5nxU/lGIlsr3jLX78fqtGENOV77paT3CASWDwI=; b=tc4Gfqu8cFGpXuqTKSZxxHqT9P
	sBrhus6ACBhv8iccP47332jjKwMuHEyZsfPShtvD/iVCdXkr3rNPkFhKXa/Gqf6MnX5y/5uL5uEu5
	8LTdxTmlDgrNA88WZgiTf5ecsBz/fPGI70okF0Q7McbqVpKJBn+OhDLYbcX6WZpcbFZuOrnPlwKoO
	ZcxaI+tVv7GBqv5+so+XDwjG5ENx+0Ix7oB4sW9bE5mQk2QA+3xZ/TVDcq0FJQr9BDu6ZQcl0krqr
	HGBS8SkG0snz9beSuCiM/kxLPE1R8+cbYwLA5XvLP+AoeOwLpnrObjlhLIFoEbO2CjZWNBGZiG5bL
	ktvBFisQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8fw-008jAU-Ld; Wed, 02 Nov 2022 08:00:40 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8fs-008j9K-BV
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 08:00:38 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N2K7J6pwLzHv6r;
	Wed,  2 Nov 2022 16:00:12 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 16:00:31 +0800
Subject: Re: [PATCH] nvme: retry commands if DNR bit is not set
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
References: <20221102073650.58245-1-hare@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <88b18b60-aa99-82d0-fc7e-bc65d05792c0@huawei.com>
Date: Wed, 2 Nov 2022 16:00:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221102073650.58245-1-hare@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_010036_762981_714872AD 
X-CRM114-Status: GOOD (  20.57  )
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



On 2022/11/2 15:36, Hannes Reinecke wrote:
> Add a 'retries' argument to __nvme_submit_sync_cmd() to instruct
> the function to retry the command if the DNR bit is not set in
> the command result, and modify the authentication code to allow
> for retries.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/auth.c    |  2 +-
>   drivers/nvme/host/core.c    | 29 ++++++++++++++++++++++++-----
>   drivers/nvme/host/fabrics.c | 10 +++++-----
>   drivers/nvme/host/nvme.h    |  6 +++++-
>   4 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index c8a6db7c4498..3b63aa155beb 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -69,7 +69,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
>   
>   	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
>   				     qid == 0 ? NVME_QID_ANY : qid,
> -				     0, flags);
> +				     0, flags, nvme_max_retries);
>   	if (ret > 0)
>   		dev_warn(ctrl->device,
>   			"qid %d auth_send failed with status %d\n", qid, ret);
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dc4220600585..d0de1a85596a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -54,7 +54,7 @@ static unsigned char shutdown_timeout = 5;
>   module_param(shutdown_timeout, byte, 0644);
>   MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
>   
> -static u8 nvme_max_retries = 5;
> +u8 nvme_max_retries = 5;
>   module_param_named(max_retries, nvme_max_retries, byte, 0644);
>   MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
>   
> @@ -1016,7 +1016,7 @@ static int nvme_execute_rq(struct request *rq, bool at_head)
>    */
>   int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   		union nvme_result *result, void *buffer, unsigned bufflen,
> -		int qid, int at_head, blk_mq_req_flags_t flags)
> +		int qid, int at_head, blk_mq_req_flags_t flags, int retries)
>   {
>   	struct request *req;
>   	int ret;
> @@ -1030,6 +1030,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   	if (IS_ERR(req))
>   		return PTR_ERR(req);
>   	nvme_init_request(req, cmd);
> +	nvme_req(req)->retries = retries;
>   
>   	if (buffer && bufflen) {
>   		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
> @@ -1037,8 +1038,18 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   			goto out;
>   	}
>   
> +retry:
>   	req->rq_flags |= RQF_QUIET;
>   	ret = nvme_execute_rq(req, at_head);
> +	if (ret > 0) {
> +		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> +
> +		if (ctrl->kas)
> +			ctrl->comp_seen = true;
> +
> +		if (retries-- && nvme_decide_disposition(req) != COMPLETE)
> +			goto retry;
> +	}
>   	if (result && ret >= 0)
>   		*result = nvme_req(req)->result;
Reusing the existing retry mechanism may be better.
We can do like this:
Do not set REQ_FAILFAST_DRIVER in nvme_init_request If need retry.
	if (noretry)
		req->cmd_flags |= REQ_FAILFAST_DRIVER;
		

