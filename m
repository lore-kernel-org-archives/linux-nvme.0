Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77CDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYwUDi7CaMqmGIVK81jAt0026TJp3h9OqBYfxlYLOrU=; b=pg3P30qkhredm8+yhYQCkrSJyz
	z0bkuRp2zHBL5uHiWxxaV8/mcADfrX1ywqWU88wmDX6YfbxQU429khjfymtvapcDQXCohoBDN+0q1
	Ojwu1SFl8ckg1WESD8y8PuZA/y8Lnbuq9G/d8K6+wEn2T9LvTLuKIY37QXLMorgrWyKzxXtNtQ47H
	JzW98RfeYBZWb4Vz1A/i51c3YcywnX7ALPJ2SQlf2OGHPoor6FXGw7qsHctSB1ZGxj+482M982uQn
	ih4WvlukE0c9KAGbhoM96DFSKOKGPmqBZ135PRtm5vE5zFYEgAByeFUFQbIOGnlK+Yii0ABoGig+M
	To9mwYCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negAo-001obO-1m; Wed, 13 Apr 2022 16:48:54 +0000
Received: from out0.migadu.com ([2001:41d0:2:267::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1negAk-001oa7-Os
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 16:48:52 +0000
Message-ID: <b169b9c6-eecd-5a8a-6545-ad1176455374@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1649868526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYwUDi7CaMqmGIVK81jAt0026TJp3h9OqBYfxlYLOrU=;
 b=nCyl6iIFXemvfhWZQA6cEvQrDeDrkAlzSokXox3zpT5gO0IA3Ya14vubCgud5IoSeK6MWN
 o1Nio3zjrX8TCzYzaMpQndxp1sFK+crZ6C2HVMzv3BQhDy5aAMNOiQ7BfJ5kBI9yZwbx9c
 1m6epQ9lyA8df4jqQJKJWI55nGk2VC0=
Date: Wed, 13 Apr 2022 10:48:45 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220411031249.5158-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_094851_258334_851F8339 
X-CRM114-Status: GOOD (  14.99  )
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

Hi

On 4/10/2022 9:12 PM, Chaitanya Kulkarni wrote:
> Mark internal passthru requests quiet in the submission path with
> RQF_QUIET flag added in the __nvme_submit_sync_cmd(). In the completion
> path, if nvme request is resulted in the error and request is marked
> RQF_QUIET then don't log the error with nvme_error_log().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 449378a96a9f..12302be83a6c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -370,7 +370,7 @@ static inline void nvme_end_req(struct request *req)
>   {
>   	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>   
> -	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
> +	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
>   		nvme_log_error(req);
>   	nvme_end_req_zoned(req);
>   	nvme_trace_bio_complete(req);
> @@ -1100,6 +1100,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   			goto out;
>   	}
>   
> +	req->rq_flags |= RQF_QUIET;
Any reason to not make it a part of flags in the argument list and let 
the block layer build the req with it?

eg:
flags |= REQ_QUIET;
if (qid == NVME_QID_ANY)
	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
else
	req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
					qid ? qid - 1 : 0);

>   	ret = nvme_execute_rq(req, at_head);
>   	if (result && ret >= 0)
>   		*result = nvme_req(req)->result;

