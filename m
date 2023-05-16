Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3102AC7EE24
	for <linux-nvme@archiver.kernel.org>; Tue, 16 May 2023 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/xFBsvb/OmCCah1ervhaf7jtZcL9dzbDGbW/YObJ+w=; b=RnR1SFQLK52iEHmT0S2yVjF0Qa
	HGKWVKTG2BbAWt8Dg8uz9MSEnTlz7XCusiBXpyn6NX0X3IiooXxRwDGiZ3hdE8EbtTQHDcRNzFpTb
	L9uqf52ECxQXOFji6adYydEv0pnnZSYgyRxKklekJl98OJRgGP0vYGQkRtAAROLjLTJ/mc+0PHr6t
	/hi0Gbc+WNL27hF5hD98g0Sxw1DYFNn2OU8uePoe3WyPFqkvYb45XVt7IAb1yfbLriKh/Kygbuvyr
	PjggyjLi2PjJ2FXX0J9kCbXs4h4wJ2uSI32zdEhgThAv7NHTkmhyqENR64zciZ+tuTtglGb/gl4xL
	Cjkl7/vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyzpb-006pGN-2A;
	Tue, 16 May 2023 18:55:31 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyzpY-006pED-1H
	for linux-nvme@lists.infradead.org;
	Tue, 16 May 2023 18:55:30 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so79902455e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 16 May 2023 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263322; x=1686855322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/xFBsvb/OmCCah1ervhaf7jtZcL9dzbDGbW/YObJ+w=;
        b=TW91y52ZVwjY8tlkfIIxvwq0KmwqktfLJToouLS4RMuywVhMqBgnjKs9L5sfBn/Y5I
         jB08wzqMbyng4yYhE2+1AmBeXe+JUFQ92Zdaayd2+LbsgwdqBXbjucnhI6nymiE2ZXit
         6lBNOROF5+rf4oOLeYnsagnfuc5a8hU318i7CoFWf6zXEejbu2951sGSHwAAP4H0p3XD
         5iRzIcI3edhLgLNEPfDyP3yWHjOeslhbIQ1+fzGnL3jKygUL3DIgGFRzt/lbmd5BF+Hf
         d92vXmV/dbaWK6lE6tv0usKf2wDUZwDt1mDr+Xd6Rx7lT8rEWWw30EXPqDWAzH2K6dVH
         Y5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263322; x=1686855322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/xFBsvb/OmCCah1ervhaf7jtZcL9dzbDGbW/YObJ+w=;
        b=JZcrC32qlAunTQNxy5JbnVb/tRJzblWQwvtzbEMHPY/iV3855KhYubsr/lGJejhDBn
         46l/Wj7xzRUt8hBDE1cRAM+cZpKDkU8ZS8Qd/Ni0dkYtF6diROtOZ2iZ81pDPJMbDJhF
         VRSBPI2DXhL/RAbgsTKHmIhW8/Cq2QseIvh9w5DnvHiO25WmDaqX+JOy92rpG74T/MF6
         lghzEvv5IkhOKk18h13GgJkYvTHb1vcsCpLxu1drtJ+5YQsH5oCWqXzC8mniiqrs/N9c
         LyUkRg8UUCGCSxC4hDV3x1xtve2zBHhFA+lb2AsxcOpoJSSDm2JOVhmE9zqkGKP0vb0M
         v0hQ==
X-Gm-Message-State: AC+VfDz4NJxrnWW0Ra5WVTsPEU69RhlBvHzxFPpeRmplfjlpVK1W8eC1
	t5dYQUgvNXySvzXijVYjQYI=
X-Google-Smtp-Source: ACHHUZ7sm7xU7fDLQ3R+lIEMorQEICVDfIudZPUw/GTQxcWISWjmjbvVnCjx1Z4gKznOYHgf/4k4tQ==
X-Received: by 2002:adf:f291:0:b0:306:3bf0:f1ec with SMTP id k17-20020adff291000000b003063bf0f1ecmr28940733wro.7.1684263322254;
        Tue, 16 May 2023 11:55:22 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.233.10])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d6543000000b002fda1b12a0bsm267785wrv.2.2023.05.16.11.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 11:55:22 -0700 (PDT)
Message-ID: <65514f94-ac70-08df-a866-fe73f95037fd@gmail.com>
Date: Tue, 16 May 2023 19:52:23 +0100
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
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20230516100000.GA26860@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_115528_434888_A2881B89 
X-CRM114-Status: GOOD (  26.55  )
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

On 5/16/23 11:00, Kanchan Joshi wrote:
> On Mon, May 15, 2023 at 01:54:42PM +0100, Pavel Begunkov wrote:
>> We want to use IOU_F_TWQ_LAZY_WAKE in commands. First, introduce a new
>> cmd tw helper accepting TWQ flags, and then add
>> io_uring_cmd_do_in_task_laz() that will pass IOU_F_TWQ_LAZY_WAKE and
>> imply the "lazy" semantics, i.e. it posts no more than 1 CQE and
>> delaying execution of this tw should not prevent forward progress.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>> include/linux/io_uring.h | 18 ++++++++++++++++--
>> io_uring/uring_cmd.c     | 16 ++++++++++++----
>> 2 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
>> index 7fe31b2cd02f..bb9c666bd584 100644
>> --- a/include/linux/io_uring.h
>> +++ b/include/linux/io_uring.h
>> @@ -46,13 +46,23 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
>>                   struct iov_iter *iter, void *ioucmd);
>> void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2,
>>             unsigned issue_flags);
>> -void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>> -            void (*task_work_cb)(struct io_uring_cmd *, unsigned));
>> struct sock *io_uring_get_socket(struct file *file);
>> void __io_uring_cancel(bool cancel_all);
>> void __io_uring_free(struct task_struct *tsk);
>> void io_uring_unreg_ringfd(void);
>> const char *io_uring_get_opcode(u8 opcode);
>> +void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>> +                void (*task_work_cb)(struct io_uring_cmd *, unsigned),
>> +                unsigned flags);
>> +/* users should follow semantics of IOU_F_TWQ_LAZY_WAKE */
> 
> Should this also translate to some warn_on anywhere?

Would love to but don't see how. We can only check it doesn't
produce more than 1 CQE, but that would need

nr_cqes_before = cqes_ready();
tw_item->run();
WARN_ON(cqes_ready() >= nr_cqes_before + 1);

but that's just too ugly


>> +void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned));
>> +
>> +static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>> +{
>> +    __io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
>> +}
>>
>> static inline void io_uring_files_cancel(void)
>> {
>> @@ -85,6 +95,10 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>             void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>> {
>> }
>> +static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>> +{
>> +}
>> static inline struct sock *io_uring_get_socket(struct file *file)
>> {
>>     return NULL;
>> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>> index 5e32db48696d..476c7877ce58 100644
>> --- a/io_uring/uring_cmd.c
>> +++ b/io_uring/uring_cmd.c
>> @@ -20,16 +20,24 @@ static void io_uring_cmd_work(struct io_kiocb *req, struct io_tw_state *ts)
>>     ioucmd->task_work_cb(ioucmd, issue_flags);
>> }
>>
>> -void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>> -            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>> +void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned),
>> +            unsigned flags)
>> {
>>     struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
>>
>>     ioucmd->task_work_cb = task_work_cb;
>>     req->io_task_work.func = io_uring_cmd_work;
>> -    io_req_task_work_add(req);
>> +    __io_req_task_work_add(req, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);

--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h

+static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
+			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
+{
+	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
+}

That should fail for nvme unless exported.

> Any reason to export this? No one is using this at the moment.
>> +void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>> +            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>> +{
>> +    __io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
>> }
>> -EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
>> +EXPORT_SYMBOL_GPL(io_uring_cmd_do_in_task_lazy);
> 
> Seems you did not want callers to pass the the new flag (LAZY_WAKE) and
> therefore this helper.

Yep, I wouldn't mind exposing just *LAZY_WAKE but don't want
to let it use whatever flags there might be in the future.

Initially I wanted to just make io_uring_cmd_complete_in_task and
io_uring_cmd_do_in_task_lazy static inline, but that would need
some code shuffling to make it clean.

> And if you did not want callers to know about this flag (internal
> details of io_uring), it would be better to have two exported helpers
> io_uring_cmd_do_in_task_lazy() and io_uring_cmd_complete_in_task().
> Both will use the internal helper __io_uring_cmd_do_in_task with
> different flag.

That's how it should be in this patch

-- 
Pavel Begunkov

