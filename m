Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72494C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 12:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BslyW3azVhFwrIBuIQLLzrL1OeXsP0P9DJsf/sU+6uQ=; b=t9HZhQ1YbVMuHnMaAEzf2sdLFb
	AYCOibwijlsG7lvkcedK+rX+s580pf+KyEOzlA88odJLIF5qv1VYrfZeIObq62bO1Zn2lI2gPBSMO
	dSK01omVqL2IPx7++R8N21dAGHOS6kmWjNMpyEDYSLxk9vJ5mkZJLX3LCdHPl7Tdlyzyh0ulwK981
	yIgCiupconZ7eVGqPnFLNNghHxsmf2H6u0gMQGNjyseZ8ZN/2913tslell1QlqWB+/hEFcgNqQO+F
	La+m3d/uczPVZ25XvN1swfEkPLlIj+0vRjMvTN0Z4aPfoB4wPvJo3YBcZOQmXANjwHa/fILEQDXyj
	zLth/uxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzFtQ-009jYx-3D;
	Wed, 17 May 2023 12:04:33 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzFtM-009jXS-2Z
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 12:04:31 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96652cb7673so102432566b.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684325066; x=1686917066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BslyW3azVhFwrIBuIQLLzrL1OeXsP0P9DJsf/sU+6uQ=;
        b=rm9OHmiDVP1QJk6J16mO59QPy9fwerd3FG/UjBtTvV8Y9sdYIhnq9N2CI1BCx70AZh
         F66IVqO8tfC/HOZzx6rSZCNTkGfNd8quQN9h+s7j9ZVvECjFZty7yl8Kw6GIRagCNeXq
         lsSzB7WeAKkM8HiPZBsXFS8vJ5A/sTUMnkmA3J5IlWjWAggc38+NZSZHPQDVSShJ/0Mz
         pdvbJ2voqH6ARSmbGa8p9bbnf0k4ITB1tjmB1uyJq6SYVqvLRb7fXnQcUyRqzt5MmMkz
         jxOcUeE7k5OwGRn9GxTHZGTYKaZT0/utHYUB1WU27wJDzh+k+Xvypv7WbTeBZH48aUqh
         wKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684325066; x=1686917066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BslyW3azVhFwrIBuIQLLzrL1OeXsP0P9DJsf/sU+6uQ=;
        b=fvF71PqpLZ7+bcu6efFsjIidjJpIwneiUHgiO4QA9WC6beBt/qhnkcjWeaJViLD4mX
         QC4/wNajNJWV8321WgVJ7gg+ST7Ci3wg9mrqbcSqgfRpZgs11B0+pUPH4XjW/Jc0K6hT
         82lQn/r6JUK6CYEskvrVmyJJ8fT8xHi/J77D/jxtcx57rkHlP1NECaQV3hGIeH7oLNnn
         HNaYOWtGXIafS7arM5zfsLWN7lnD3BFdDhlWdxLAVYNdO3Jg2ifipqOK6axEMtGxiZtv
         ffl6J0cdYnC+biMEHldjyQLQvnWIi6ijIsV+LCwDOUhTiGJy7OEN7/GOVTv3pBP6QkKz
         s3UQ==
X-Gm-Message-State: AC+VfDzxuljjTmGLio+QAVlKnYpzseWrol14LJGK32fx/6kxc0YMTm6N
	0cJgjzrdCjG8LD53EgCg1mM=
X-Google-Smtp-Source: ACHHUZ6Vb8Mndz18ScrfOcEhBtCq6lhLmFWGPF8kO8nmUDoS7Cc3+QJYqS1VQjZxgnv2mj0vn4FpjQ==
X-Received: by 2002:a17:906:6a25:b0:966:6316:683e with SMTP id qw37-20020a1709066a2500b009666316683emr33626205ejc.5.1684325065623;
        Wed, 17 May 2023 05:04:25 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::2eef? ([2620:10d:c092:600::2:46a1])
        by smtp.gmail.com with ESMTPSA id l17-20020a170907915100b0095004c87676sm12236116ejs.199.2023.05.17.05.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 05:04:25 -0700 (PDT)
Message-ID: <fa9e5708-73b0-2fc4-9477-316185900d6c@gmail.com>
Date: Wed, 17 May 2023 13:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for-next 1/2] io_uring/cmd: add cmd lazy tw wake helper
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
References: <cover.1684154817.git.asml.silence@gmail.com>
 <CGME20230515125841epcas5p3e3cba6545755e95739e1561222b00b4a@epcas5p3.samsung.com>
 <5b9f6716006df7e817f18bd555aee2f8f9c8b0c3.1684154817.git.asml.silence@gmail.com>
 <20230516100000.GA26860@green245>
 <65514f94-ac70-08df-a866-fe73f95037fd@gmail.com>
 <20230517103346.GA15743@green245>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20230517103346.GA15743@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_050429_948260_8B63F17A 
X-CRM114-Status: GOOD (  24.89  )
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

On 5/17/23 11:33, Kanchan Joshi wrote:
> On Tue, May 16, 2023 at 07:52:23PM +0100, Pavel Begunkov wrote:
>> On 5/16/23 11:00, Kanchan Joshi wrote:
>>> On Mon, May 15, 2023 at 01:54:42PM +0100, Pavel Begunkov wrote:
>>>> We want to use IOU_F_TWQ_LAZY_WAKE in commands. First, introduce a new
>>>> cmd tw helper accepting TWQ flags, and then add
>>>> io_uring_cmd_do_in_task_laz() that will pass IOU_F_TWQ_LAZY_WAKE and
>>>> imply the "lazy" semantics, i.e. it posts no more than 1 CQE and
>>>> delaying execution of this tw should not prevent forward progress.
>>>>
>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> ---
>>>> include/linux/io_uring.h | 18 ++++++++++++++++--
>>>> io_uring/uring_cmd.c     | 16 ++++++++++++----
>>>> 2 files changed, 28 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
>>>> index 7fe31b2cd02f..bb9c666bd584 100644
>>>> --- a/include/linux/io_uring.h
>>>> +++ b/include/linux/io_uring.h
>>>> @@ -46,13 +46,23 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
>>>>                   struct iov_iter *iter, void *ioucmd);
>>>> void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2,
>>>>             unsigned issue_flags);
>>>> -void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>>> -            void (*task_work_cb)(struct io_uring_cmd *, unsigned));
>>>> struct sock *io_uring_get_socket(struct file *file);
>>>> void __io_uring_cancel(bool cancel_all);
>>>> void __io_uring_free(struct task_struct *tsk);
>>>> void io_uring_unreg_ringfd(void);
>>>> const char *io_uring_get_opcode(u8 opcode);
>>>> +void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>>>> +                void (*task_work_cb)(struct io_uring_cmd *, unsigned),
>>>> +                unsigned flags);
>>>> +/* users should follow semantics of IOU_F_TWQ_LAZY_WAKE */
>>>
>>> Should this also translate to some warn_on anywhere?
>>
>> Would love to but don't see how. We can only check it doesn't
>> produce more than 1 CQE, but that would need
>>
>> nr_cqes_before = cqes_ready();
>> tw_item->run();
>> WARN_ON(cqes_ready() >= nr_cqes_before + 1);
>>
>> but that's just too ugly
>>
>>
>>>> +void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>>>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned));
>>>> +
>>>> +static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>> +{
>>>> +    __io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
>>>> +}
>>>>
>>>> static inline void io_uring_files_cancel(void)
>>>> {
>>>> @@ -85,6 +95,10 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>>>             void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>> {
>>>> }
>>>> +static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>>>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>> +{
>>>> +}
>>>> static inline struct sock *io_uring_get_socket(struct file *file)
>>>> {
>>>>     return NULL;
>>>> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>>>> index 5e32db48696d..476c7877ce58 100644
>>>> --- a/io_uring/uring_cmd.c
>>>> +++ b/io_uring/uring_cmd.c
>>>> @@ -20,16 +20,24 @@ static void io_uring_cmd_work(struct io_kiocb *req, struct io_tw_state *ts)
>>>>     ioucmd->task_work_cb(ioucmd, issue_flags);
>>>> }
>>>>
>>>> -void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>>> -            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>> +void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>>>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned),
>>>> +            unsigned flags)
>>>> {
>>>>     struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
>>>>
>>>>     ioucmd->task_work_cb = task_work_cb;
>>>>     req->io_task_work.func = io_uring_cmd_work;
>>>> -    io_req_task_work_add(req);
>>>> +    __io_req_task_work_add(req, flags);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
>>
>> --- a/include/linux/io_uring.h
>> +++ b/include/linux/io_uring.h
>>
>> +static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>> +{
>> +    __io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
>> +}
>>
>> That should fail for nvme unless exported.
> 
> But it does not. Give it a try.
> 
>>> Any reason to export this? No one is using this at the moment.
>>>> +void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>>>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>> +{
>>>> +    __io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
>>>> }
>>>> -EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
>>>> +EXPORT_SYMBOL_GPL(io_uring_cmd_do_in_task_lazy);
>>>
>>> Seems you did not want callers to pass the the new flag (LAZY_WAKE) and
>>> therefore this helper.
>>
>> Yep, I wouldn't mind exposing just *LAZY_WAKE but don't want
>> to let it use whatever flags there might be in the future.
>>
>> Initially I wanted to just make io_uring_cmd_complete_in_task and
>> io_uring_cmd_do_in_task_lazy static inline, but that would need
>> some code shuffling to make it clean.
>>
>>> And if you did not want callers to know about this flag (internal
>>> details of io_uring), it would be better to have two exported helpers
>>> io_uring_cmd_do_in_task_lazy() and io_uring_cmd_complete_in_task().
>>> Both will use the internal helper __io_uring_cmd_do_in_task with
>>> different flag.
>>
>> That's how it should be in this patch
> 
> Nah, in this patch __io_uring_cmd_do_in_task is exported helper. And
> io_uring_cmd_complete_in_task has been changed too (explicit export to
> header based one). Seems like bit more shuffling than what is necessary

Ok, I'll check, thanks


-- 
Pavel Begunkov

