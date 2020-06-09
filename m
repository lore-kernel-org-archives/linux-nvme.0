Return-Path: <SRS0=KBoe=7W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC163C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:21:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728672067B
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZaCh9RT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728672067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cH1bWr+NujDH+z51YQPoz6JX1RodzOAq6zZ08nwhA70=; b=ZaCh9RT+JVVamWnWKbqICjozG
	wzG8WeHxPpwWvj6KuziR+RAqNrNsZn6Cy7XIs6aHFGU6opB8Uu3Z9xRgFTdj1dXN2EcsHocQmYnr8
	tDG7mgREJ4lnqhcYL7+VpK+ppQKHSELleIWRZlNj8GFJagCKwUYxHNcpFJOl3P6z3we1MBohHPQBz
	ArzNudibsWH+e9I4bSjrBsBPzF41OBqsmrSOY67732xfVw+0q1za8Qlhus+FyjpLbx2aBSq5SZVaI
	DlLrNg4no8R+IXeAgYFLIrWZOcTHbGOKpZGzrp8LsAxFwzY6tVCgiAnkxosty9YP/15y0Ih88hXo1
	lgmTQc91A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jinZ3-0004Kh-HH; Tue, 09 Jun 2020 23:21:53 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jinZ0-0004KG-P9
 for linux-nvme@lists.infradead.org; Tue, 09 Jun 2020 23:21:52 +0000
Received: by mail-pj1-f67.google.com with SMTP id ga6so59812pjb.1
 for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2020 16:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0yxQbLgmZ5BFXfHW77rci+YXBQ5dBs8nGmDAqlQIrsI=;
 b=q5f8rUqk2m8io0GJubrfGfl3K8uKZGzODuTLgEfCeuwqaZYADTSgPYvrTzlKzfPQsT
 Bfn1OFhfWMeuF9Fa92jXPokI6b4UYzqRo+YwKjW0vFzUVkebWfOE9Gq008LVPWEkGFKM
 Tkn97Abnt/aHpsc2ky4X/LZfqhxtAzFgP8uJwE5tRUQqHPHaGQUsg5k6x7/ZIxTfDAFe
 /In2YLTyU08ZakDg0czeqygZCKMHUucaaHBSt7ERHSkTPPkHUfbwjkaBQY21cQc3gu/V
 0yvb2WSvigO12fXislWzsA9qexK6kSaruyxvfUSXXjXo8khHHqufnvNQm4gbMzUObLw9
 43ZA==
X-Gm-Message-State: AOAM533OTQjwjb0W4fvZG3HgOvzc2HYnSs2Ha6vnyXEaaW+vE8tZ90u/
 U4BuuukA2/6UkMRElzFnqQ8oXEFqZlQ=
X-Google-Smtp-Source: ABdhPJwOkHJPv6TIgBUsF76t9EZLNoWfHo4gqkmoUPNO0tJBeE5V4MblqkiAzxEMi3KmewMqSDkJkQ==
X-Received: by 2002:a17:90a:d083:: with SMTP id k3mr189074pju.8.1591744908776; 
 Tue, 09 Jun 2020 16:21:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8d09:1feb:aaa3:3f03?
 ([2601:647:4802:9070:8d09:1feb:aaa3:3f03])
 by smtp.gmail.com with ESMTPSA id r202sm10775538pfr.185.2020.06.09.16.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 16:21:46 -0700 (PDT)
Subject: Re: [PATCH V2] nvmet: fail outstanding host posted AEN req
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200609231942.47808-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <183bd810-3904-5be5-3457-d63d5291c247@grimberg.me>
Date: Tue, 9 Jun 2020 16:21:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609231942.47808-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200609_162150_821858_0054D327 
X-CRM114-Status: GOOD (  27.40  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/9/20 4:19 PM, Chaitanya Kulkarni wrote:
> In function nvmet_async_event_process() we only process AENs iff
> there is an open slot on the ctrl->async_event_cmds[] && aen
> event list posted by the target is not empty. This keeps host
> posted AEN outstanding if target generated AEN list is empty.
> We do cleanup the target generated entries from the aen list in
> nvmet_ctrl_free()-> nvmet_async_events_free() but we don't
> process AEN posted by the host. This leads to following problem :-
> 
> When processing admin sq at the time of nvmet_sq_destroy() holds
> an extra percpu reference(atomic value = 1), so in the following code
> path after switching to atomic rcu, release function (nvmet_sq_free())
> is not getting called which blocks the sq->free_done in
> nvmet_sq_destroy() :-
> 
> nvmet_sq_destroy()
>   percpu_ref_kill_and_confirm()
>   - __percpu_ref_switch_mode()
>   --  __percpu_ref_switch_to_atomic()
>   ---   call_rcu() -> percpu_ref_switch_to_atomic_rcu()
>   ----     /* calls switch callback */
>   - percpu_ref_put()
>   -- percpu_ref_put_many(ref, 1)
>   --- else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
>   ----   ref->release(ref); <---- Not called.
> 
> This results in indefinite hang:-
> 
>    void nvmet_sq_destroy(struct nvmet_sq *sq)
> ...
>            if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
>                    nvmet_async_events_process(ctrl, status);
>                    percpu_ref_put(&sq->ref);
>            }
>            percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
>            wait_for_completion(&sq->confirm_done);
>            wait_for_completion(&sq->free_done); <-- Hang here
> 
> Which breaks the further disconnect sequence. This problem seems to be
> introduced after commit 64f5e9cdd711b ("nvmet: fix memory leak when
> removing namespaces and controllers concurrently").
> 
> This patch processes the outstanding ctrl->async_event_cmd[] until
> there are no cmds available in array irrespective of aen list if
> empty or not.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> * Chnages from V1:
> 
> 1. Isolate host posted target controller AEN cmds cleanup into separate
>     routine.
> 
> ---
>   drivers/nvme/target/core.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 6392bcd30bd7..86d89b16cf48 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -129,6 +129,21 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
>   	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
>   }
>   
> +static void nvmet_async_events_failall(struct nvmet_ctrl *ctrl, u16 status)
> +{
> +	struct nvmet_req *req;
> +
> +	mutex_lock(&ctrl->lock);
> +	while (ctrl->nr_async_event_cmds) {
> +		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
> +		mutex_unlock(&ctrl->lock);
> +		trace_nvmet_async_event(ctrl, req->cqe->result.u32);
> +		nvmet_req_complete(req, status);
> +		mutex_lock(&ctrl->lock);
> +	}
> +	mutex_unlock(&ctrl->lock);
> +}
> +
>   static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
>   {
>   	struct nvmet_async_event *aen;
> @@ -786,8 +801,16 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>   	 * If this is the admin queue, complete all AERs so that our
>   	 * queue doesn't have outstanding requests on it.
>   	 */
> -	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
> +	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
>   		nvmet_async_events_process(ctrl, status);

Why do we need this at all now?

> +		/*
> +		 * Target controller's host posted events needs to be explicitly
> +		 * checked and cleared since there is no 1 : 1 mapping between
> +		 * host posted AEN requests and target generated AENs on the
> +		 * target controller's aen_list and async_event_cmds array.
> +		 */

Not sure if the comment is needed, the call is pretty self explanatory.

> +		nvmet_async_events_failall(ctrl, status);
> +	}
>   	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
>   	wait_for_completion(&sq->confirm_done);
>   	wait_for_completion(&sq->free_done);
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
