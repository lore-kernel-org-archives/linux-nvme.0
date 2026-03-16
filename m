Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EA1F53D9B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rNqYWrRFGodaMOG+fMFfMLFfzEQ/Hrz19UG5a14j8/I=; b=41w0wCn42ha1I1KvjiuP722L0M
	4vWesJ1q+Zy14Qx42dJlNYBBnEAwxbEUhteAx/Wz33SBj10vRCS5kpp1WAy1eBpQfhxUw8JMwENkj
	NFZH+tF/Z/bIP8qS6zLyaqzRJQy8DmnxtHw1jAh5X9k0cGCTK/v7fkUNiiXPBcOm9wsNIanUHcV+G
	mnsZ/ddkmPmCWKAfjbal0Vkae/f4YB8mcS6sEcE+tyXuiYTmqo7C55vLVgiFYl9nM5UPaTX0TrRFK
	G7bkZ7gDWkVP6E9RYIhW92kQUtgUQMIgMqS7rKBP9hSzDK7QshUIaWZYzKCsQPBhiBA5wsKppTm7I
	gvqdaBQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2G9p-00000004ywV-2CRr;
	Mon, 16 Mar 2026 22:11:29 +0000
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2G9m-00000004yvH-12X1
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 22:11:27 +0000
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-4043b909ed4so3202056fac.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Mar 2026 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773699085; x=1774303885; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNqYWrRFGodaMOG+fMFfMLFfzEQ/Hrz19UG5a14j8/I=;
        b=SAVS0zYkbe5+IPs7nxRWmjJ3j8da4hQZ/JDWc+stCKx4iqt0uyKy9v8a7naR1EobAM
         DD9PDGJv5akVjtfETHjXE3jQpmArq8IPRLxuAU7rm7ZFiUJkFXGa/55yft+gXYMwsb5R
         3FUpohcz1lhuz4ZSe9rutIu9QD8UwohMGTeViqURWGYD9uCR0H/21zwbiBDiPliva0Cc
         NvQOSilHhCBHSTc5Ase5qy8W411YBnutsGlDl6prC9nzbUMV5UJD04NFFlkqdFuryxA/
         S3zxyBEkKWbvvFl9ZtHLxAza50EWnBHqkg25PIzJaJXD/a2Wf0RftOgqI2Rr3fs19Oam
         Dymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699085; x=1774303885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNqYWrRFGodaMOG+fMFfMLFfzEQ/Hrz19UG5a14j8/I=;
        b=ZOchDY9kYuWUBhLIMmvS6IdrVImXr3fwzhdZw/pW9BC1ZEHw4qv4zfa7KyGeWBEH0M
         /1UF0oUOo+rCXKZkBqHLqftBO2vNZlHZKea8BCPKGDm62aCM6K6n0BPRC3MhJJtZn4bR
         SGsAlP6AWLOrh9FerpJOGV/UIO2l3tBVv3DsPTqVSc8uiXPtx5INeF9YbebHygeasJAy
         Gxn8WdZ4AkPRCySx++2wfHKDYdYklZDp8FcKQGqt4oCiZ6YmvVXJe6nvzJbDTSrcdy5I
         5Li2mfTtB3e8XYq5RxphVZ1eMpXzIfbPrZ2M+PilCwihBvXr7hTWfEvVQdDqAYy9fyfU
         sQiA==
X-Forwarded-Encrypted: i=1; AJvYcCUOCbahW6NzlE35Pd0YdijI0W/Hm5wuQNlIuknS3aWKbo0bn5LqTkQWZy4te17vwUjxWZhwJW2wVX+M@lists.infradead.org
X-Gm-Message-State: AOJu0Yxy8S8mW6XIgKZOgg0mhJtZVcMMjbyM/h2npUs2rrcmMzJPBKL6
	Fpa5AdJQU3JI+5DP6muo8tA9ZszyxMh0I58ZOP/iasEBevoE3zGUwEYZEfRs2rQy/E4=
X-Gm-Gg: ATEYQzwD3HZBE1oRIgRVvELPq1A+s9c2pPPTcPRgVugkEuIz0Tf5ksglnjE0ff9FewG
	Vv19xMB89sc/vAoEePARI0QfZ8di0Gi0DqvNXtwf/1XjwMSBbaD8CehdRqFGYoSvIvFfBnnUo6+
	YCdqk22zAApGVeHuDHMQo8MFDq/Bu3xklPtLCKu03i+u/nIPYJIupC55BQxsFSj/njFuxXm+U6/
	qp/JbvHqeEE4xxy9ugU8vY96L6lucWBAs9IU0Asa0UpudZLOgtih4paVFjOi/VLJfqAtRWfHgyz
	h/eKv7fXwo8EUSso+Zhgw/VKvMaMCnJkY3IlJ9mk8rpP3p1DD7H0DUE2sNSzj5HHt0CkRDEb4Xk
	BgmgrQ+Lh3ZN0YUoenfyWFmY/dbf81tDI7Dj9vXRX2Y/kPVOV5W2Yjv7Lq9dlbkEFXNpRm762Ip
	Q6X/4qf1VsLQ2aG3ArHNjnVeLtKbf+HwbUVEnxVIezuegLk2yyXbgdZXOg+kvJbanyGJXHVkRm5
	sqxHE7UaQ==
X-Received: by 2002:a05:6870:63aa:b0:417:1726:9076 with SMTP id 586e51a60fabf-417b93c709cmr8308716fac.29.1773699084609;
        Mon, 16 Mar 2026 15:11:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6e82cdsm18056067fac.18.2026.03.16.15.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 15:11:24 -0700 (PDT)
Message-ID: <7dfb5a9b-9af2-4463-b9a1-0eb680fd6c47@kernel.dk>
Date: Mon, 16 Mar 2026 16:11:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] io_uring: count CQEs in io_iopoll_check()
To: Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
 <20260302172914.2488599-4-csander@purestorage.com> <aagKTanM5Az9UDsJ@fedora>
 <CADUfDZozycFBPX0kH=22Gda7njM3xVmL=Cy=zCq6cfXY8JH_dw@mail.gmail.com>
 <a6591d03-3707-4f1c-b1fa-49f010f98d53@kernel.dk>
 <CADUfDZp0shyZ5FqfEcwbi0tHXOFqwqZKRvwQW=heR-yvaOaw0Q@mail.gmail.com>
 <aauO72ocnZRhJkiA@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aauO72ocnZRhJkiA@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_151126_305843_844CA865 
X-CRM114-Status: GOOD (  29.98  )
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

On 3/6/26 7:35 PM, Ming Lei wrote:
> On Fri, Mar 06, 2026 at 05:38:15PM -0800, Caleb Sander Mateos wrote:
>> On Wed, Mar 4, 2026 at 8:29?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 3/4/26 8:46 AM, Caleb Sander Mateos wrote:
>>>> On Wed, Mar 4, 2026 at 2:33?AM Ming Lei <ming.lei@redhat.com> wrote:
>>>>>
>>>>> On Mon, Mar 02, 2026 at 10:29:12AM -0700, Caleb Sander Mateos wrote:
>>>>>> A subsequent commit will allow uring_cmds that don't use iopoll on
>>>>>> IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted without
>>>>>> setting the iopoll_completed flag for a request in iopoll_list or going
>>>>>> through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command could
>>>>>> call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
>>>>>> io_iopoll_check() loop currently only counts completions posted in
>>>>>> io_do_iopoll() when determining whether the min_events threshold has
>>>>>> been met. It also exits early if there are any existing CQEs before
>>>>>> polling, or if any CQEs are posted while running task work. CQEs posted
>>>>>> via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be counted
>>>>>> against min_events.
>>>>>>
>>>>>> Explicitly check the available CQEs in each io_iopoll_check() loop
>>>>>> iteration to account for CQEs posted in any fashion.
>>>>>>
>>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>>>>> ---
>>>>>>  io_uring/io_uring.c | 9 ++-------
>>>>>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>>>>>> index 46f39831d27c..b4625695bb3a 100644
>>>>>> --- a/io_uring/io_uring.c
>>>>>> +++ b/io_uring/io_uring.c
>>>>>> @@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
>>>>>>               io_move_task_work_from_local(ctx);
>>>>>>  }
>>>>>>
>>>>>>  static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
>>>>>>  {
>>>>>> -     unsigned int nr_events = 0;
>>>>>>       unsigned long check_cq;
>>>>>>
>>>>>>       min_events = min(min_events, ctx->cq_entries);
>>>>>>
>>>>>>       lockdep_assert_held(&ctx->uring_lock);
>>>>>> @@ -1227,34 +1226,30 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
>>>>>>                * the poll to the issued list. Otherwise we can spin here
>>>>>>                * forever, while the workqueue is stuck trying to acquire the
>>>>>>                * very same mutex.
>>>>>>                */
>>>>>>               if (list_empty(&ctx->iopoll_list) || io_task_work_pending(ctx)) {
>>>>>> -                     u32 tail = ctx->cached_cq_tail;
>>>>>> -
>>>>>>                       (void) io_run_local_work_locked(ctx, min_events);
>>>>>>
>>>>>>                       if (task_work_pending(current) || list_empty(&ctx->iopoll_list)) {
>>>>>>                               mutex_unlock(&ctx->uring_lock);
>>>>>>                               io_run_task_work();
>>>>>>                               mutex_lock(&ctx->uring_lock);
>>>>>>                       }
>>>>>>                       /* some requests don't go through iopoll_list */
>>>>>> -                     if (tail != ctx->cached_cq_tail || list_empty(&ctx->iopoll_list))
>>>>>> +                     if (list_empty(&ctx->iopoll_list))
>>>>>>                               break;
>>>>>>               }
>>>>>>               ret = io_do_iopoll(ctx, !min_events);
>>>>>>               if (unlikely(ret < 0))
>>>>>>                       return ret;
>>>>>>
>>>>>>               if (task_sigpending(current))
>>>>>>                       return -EINTR;
>>>>>>               if (need_resched())
>>>>>>                       break;
>>>>>> -
>>>>>> -             nr_events += ret;
>>>>>> -     } while (nr_events < min_events);
>>>>>> +     } while (io_cqring_events(ctx) < min_events);
>>>>>
>>>>> Before entering the loop, if io_cqring_events() finds any queued CQE,
>>>>> io_iopoll_check() returns immediately without polling.
>>>>>
>>>>> If the queued CQE is originated from non-iopoll uring_cmd, iopoll request
>>>>> will not be polled, may this be one issue?
>>>>
>>>> I also noticed that logic and thought it seemed odd. I would think
>>>> we'd always want to wait for min_events CQEs (and iopoll once even if
>>>> min_events is 0). Looks like Jens added the early return in commit
>>>> a3a0e43fd770 ("io_uring: don't enter poll loop if we have CQEs
>>>> pending"), perhaps he can shed some light on it?
>>>
>>> I don't  recall the bug in question, it's been a while... But it always
>>> makes sense to return events that are ready, and skip polling. It should
>>> only be done if there are no ready events to reap.
>>
>> Ming, are you okay with preserving that behavior in this patch then? I
>> guess there's a potential fairness concern where REQ_F_IOPOLL requests
>> may not be polled for some time if non-REQ_F_IOPOLL requests continue
>> to frequently post CQEs.
> 
> IMO, the fairness may not a big deal given userspace should keep polling
> if the iopoll IO isn't done.

I think so.

> But forget to mention, if non-iopoll CQE is posted and ->cq_flush becomes
> true, io_submit_flush_completions() may not get chance to run in case of
> the early return. 
> 
> Maybe something like below is needed:
> 
> @@ -1556,8 +1556,10 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
>          * If we do, we can potentially be spinning for commands that
>          * already triggered a CQE (eg in error).
>          */
> -       if (io_cqring_events(ctx))
> +       if (io_cqring_events(ctx)) {
> +               io_submit_flush_completions(ctx);
>                 return 0;
> +       }

We should probably experiment with this a bit, I don't think it's a
showstopper for merging this.

Caleb, I think we can stage this for 7.1 and see how it goes.

-- 
Jens Axboe

