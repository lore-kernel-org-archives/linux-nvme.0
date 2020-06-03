Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD134C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:01:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB5C2067B
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h9xZjTMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB5C2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TcM4QP7KJZXZ6PpSq9aY9zo0bdVvqUzQwkr2JNCyLWs=; b=h9xZjTMmJnRkx11oaX3O/kDtC
	rjQRr4zE1ycwjIFr0uVHSTkNWXeVtv4Ppq1fxKqxZdR2QCkH7qglaZTZlvwX3vTvnaZ/n7AvuPVi8
	V45VlHVtqVJ7lF8wxAqLSxXPlTlhiTBn4iucOh/bu7s304UmO3LwIHBC3lQWaXQOsH04cbSGrmFJc
	Ijx32knfEbNjcg2/2RF4Ym42QJrl6qQXynhhw/kGGDjd8udyOwQeZ6dh88Wc/Eh4Se3W8xtkUN1y+
	uSdlzvWi/s7pBYXfMK/+COcoSJs1i8gn3ktCbMap6otwSg9UGCli5osplxa330iWY0gHsMT/PlDVV
	zqON90DTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgaW6-0005fH-AM; Wed, 03 Jun 2020 21:01:42 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgaW2-0005eN-Vh
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 21:01:40 +0000
Received: by mail-pf1-f196.google.com with SMTP id s23so1014324pfh.7
 for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2020 14:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oBP1cl/SCRQmE7ucinddH3TyiMapleL5BWlwlPqWTKk=;
 b=ISrtFMSFvp2LGbetYxCtvtLIwBO97e95Z8GOelI0zMvuB32jaOTyJKjipKKEp918++
 kQNrwEpfpR1JnOGTqRwmtZg1XWOy39aDwGp4jPUoO1iUNU2BihZpZIkGUL8mEj08zgjg
 ZefNMynRlev4rCU4UO7s7VWjy4pRuxHpUMKfSpqTVDIUBWIDDw3la2UNNrU5RcHEAsVD
 4vx+o2zSpO+V1nN/j6Udr2emDnbbjH/REcIwDx4eTTIkvEeiQT+clCkYu8H1UGyxr2mf
 QBO7mpcVI7w/NSbrdtxMe5R3ji6cZU6PVV6VfQdO/GMKufVZ7YlSdP9WpAOU7ZNOTauH
 LCuQ==
X-Gm-Message-State: AOAM531mAKBt1+9nR642d1n91i66YNig0gyXIjPe6I+tGv9QpNjeJs0O
 yVCIdEjV/WUWNwnzBzw6MdVkeW/rALA=
X-Google-Smtp-Source: ABdhPJzaKRvZBjdYUC/bl/EwL/OUjV8n89jtGjAfQu8VGAWjjxuYoO8Ldz11MGc6VP/+Vf/MNl1LOA==
X-Received: by 2002:a65:6496:: with SMTP id e22mr1232727pgv.63.1591218094997; 
 Wed, 03 Jun 2020 14:01:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5409:1488:6d95:bdff?
 ([2601:647:4802:9070:5409:1488:6d95:bdff])
 by smtp.gmail.com with ESMTPSA id b74sm2262105pga.31.2020.06.03.14.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 14:01:34 -0700 (PDT)
Subject: Re: blktests test nvme/003 fails
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
 <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fddde27a-eb61-7031-a067-5538e0fe3243@grimberg.me>
Date: Wed, 3 Jun 2020 14:01:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_140139_022513_90362932 
X-CRM114-Status: GOOD (  29.36  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/3/20 1:43 AM, Chaitanya Kulkarni wrote:
> Bart,
> 
> (+Sagi)
> 
> On 5/27/20 4:55 PM, Bart Van Assche wrote:
>> Hi,
>>
>> This morning I updated my local copy of Jens' for-next branch. Since
>> that update test nvme/003 fails. Is this perhaps a regression? This
>> is what appears in the system log if I run that test:
> 
> Can you please let me know if the following patch fixes your problem ?
> 
>   From e2b5e0bc63d6544feda4354c92c6c9fab11a3649 Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date: Wed, 3 Jun 2020 01:31:26 -0700
> Subject: [PATCH] nvmet: free outstanding host AEN req
> 
> In function nvmet_async_event_process() we only process AENs iff
> there is an open slot on the ctrl->async_event_cmds[] && aen
> event list posted by the target is not empty. This keeps host
> posted AEN outstanding if target generated AEN list is empty.
> We do cleanup the target generated entries from the aen list in
> nvmet_ctrl_free()-> nvmet_async_events_free() but we don't
> process AEN posted by the host. This leads to following problem :-
> 
> admin sq at the time of nvmet_sq_destroy() holds an extra percpu
> reference(atomic value = 1), so in the following code path after
> switching to atomic rcu, release function (nvmet_sq_free()) is not
> getting called which blocks the sq->free_done in nvmet_sq_destroy() :-
> 
> nvmet_sq_destroy()
>    percpu_ref_kill_and_confirm()
>    - __percpu_ref_switch_mode()
>    --  __percpu_ref_switch_to_atomic()
>    ---   call_rcu() -> percpu_ref_switch_to_atomic_rcu()
>    ----     /* calls switch callback */
>    - percpu_ref_put()
>    -- percpu_ref_put_many(ref, 1)
>    --- else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
>    ----	ref->release(ref); <---- Not called.
> 
> This results in indefinite hang:-
> 
>    780 void nvmet_sq_destroy(struct nvmet_sq *sq)
> ...
>    789         if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
>    790                 nvmet_async_events_process(ctrl, status);
>    791                 percpu_ref_put(&sq->ref);
>    792         }
>    793         percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
>    794         wait_for_completion(&sq->confirm_done);
>    795         wait_for_completion(&sq->free_done); <-- Hang here
> 
> Which breaks the further disconnect sequence. This problem seems to be
> introduced after commit 64f5e9cdd711b ("nvmet: fix memory leak when removing
> namespaces and controllers concurrently").
> 
> This patch processes the ctrl->async_event_cmd[] until there are no cmds
> available in array irrespective of aen list if empty or not and uses aen
> list entry if available.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>    drivers/nvme/target/core.c | 16 ++++++++++------
>    1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 6392bcd30bd7..40d80b785ecf 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -135,15 +135,19 @@ static void nvmet_async_events_process(struct
> nvmet_ctrl *ctrl, u16 status)
>    	struct nvmet_req *req;
> 
>    	mutex_lock(&ctrl->lock);
> -	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
> -		aen = list_first_entry(&ctrl->async_events,
> -				       struct nvmet_async_event, entry);
> +	while (ctrl->nr_async_event_cmds) {
>    		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
> -		if (status == 0)
> +		aen = NULL;
> +		if (!list_empty(&ctrl->async_events))
> +			aen = list_first_entry(&ctrl->async_events,
> +				       struct nvmet_async_event, entry);

Just use list_first_entry_or_null

> +		if (status == 0 && aen)
>    			nvmet_set_result(req, nvmet_async_event_result(aen));
> 
> -		list_del(&aen->entry);
> -		kfree(aen);
> +		if (aen) {
> +			list_del(&aen->entry);
> +			kfree(aen);
> +		}

You already condition aen when setting the result, just free it after
you use it.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
