Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31A8EF9002
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P/5lhk6C8jE/PS2fAtX4oJhx14kIa3UNBGxkwqnfz2E=; b=ZxbixHdv+e6LpYPTiUgDGM/Bas
	6Qj3FfDlMREXj6BZFWgP2T49b3RMX6XfzxQbEv1YgDEWJVckVDRVCtcGVTmoH5nLjlVXyFNBn1Miy
	YHERlLme/Ixq+H+37pfz5Wf2jywCi/hcMI67wLchSPnTvr9vSARJ6Dxz/z5KdRcQl9PBJMr6IIeEr
	Pu0vypye41JkUiaA9i0Vii3Lc628ZC3vUD9wCoPRHBtCVDjqhawaFewsQTf7bctNN5yhQBYw3I/XA
	FVBu/KwSlyRLVsmQtV40/VnMdrFjj7dS8OSrzXRrWLB/o/V2aGQMnZ43Xz25zyxqIVx5VCxcMt9aP
	tOt8ElpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxp68-000000004lv-0mO0;
	Wed, 04 Mar 2026 16:29:20 +0000
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxp65-000000004l8-1QkY
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 16:29:18 +0000
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-40438e0cba6so1459904fac.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2026 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772641756; x=1773246556; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/5lhk6C8jE/PS2fAtX4oJhx14kIa3UNBGxkwqnfz2E=;
        b=NZ3ecvX8yHvZ3UuH8COSUvhQjZFJNhbMeEhSrxG8EOPmkHeHgYXKTLW5oa7jRQR126
         uBWakhmsF/4U6+6lFx2PxoRjw4/Oms2WQk+n9fhmLkxB3sBkeuvBUhKyK8G8ixKCzIwq
         944K3Wf36J0AMzQFukJV2ukwFHzACHs9R4eTP9PrkGBbcSxcD81r5aX5HCwgNYGhHEGh
         oSiaBsNLYxFKHSyqbd33RulI8h0xgZdP9dK29BYaQRp8hAknOle8mmLhKvoC2UbKWc/Z
         fF8zBetHQSw7Wz6U5B4024zPy6yqjajZNzm9KjSePMro992wyy4jv70LJlk9z1EvJxnI
         7hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641756; x=1773246556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/5lhk6C8jE/PS2fAtX4oJhx14kIa3UNBGxkwqnfz2E=;
        b=h8sEzvBRa56vrrIEqiYZG7QF0qB0Bn7vrBMrbF4g9Fv6Cudcnju+XxxZxiaJ1t6B3z
         aCqQXpB9w0svU0PP1wyCAXKF5jzfMbGH01vFU+TJEVJExFUgLi4nBL2Ii+LH1+ITD5wn
         1gi38a0rCny2HXnng8FR8rVTjgUARSrZNokMvA95BjfQXc2o127JmaJLNF95TnJ+prjV
         uXyhtkMVtaA39ky3hG9h1yT59UaE5StuakKrQvC5rNEiw2hDQKIgLe3IdD7og48aUNXz
         ak4r50guAF4e153mNfa8dD6ydnRs+PTWiOBofKJnFdzkx4WUpkdG52ywiGocjd843IkT
         BsRA==
X-Forwarded-Encrypted: i=1; AJvYcCUn1uq1tyU6vdl3E10lmPYErkhYipGNScqHWOzUIAbSfg1YcxaGJrf2GcBCeQ2wzC739DaAZUMGf34S@lists.infradead.org
X-Gm-Message-State: AOJu0YyLVgH817bl4O9xW0R6yfIPxhDiU8G23DQWlt7vImaOxT9XorsU
	Umv4PeuNXMG70uWPp3W8YIJZ4Ab74lCt4NwuF0ZHu86COVzseCkSia/RYYirUcJ2LRwsUu6QBLW
	hAAseBy4=
X-Gm-Gg: ATEYQzx5vATIxcwbu9SHM8nt3oXotrCwK4HMP4HVfm/KRh6IcEvDMTTvziYwIJgiIoh
	inY+Df4HpH1iKnI3duNvaTODolhOsPsQgC4vr4kt2Xy91/EenuWLA1RUSo+nADT9a69JXdXMyDF
	+t0b0+KA8A3H8efQjngZ70CYcvnjQRYMCHNekj/Dt78sUZlGzM27mDV0GhvY6BzIg2uxoDbQkj7
	J7H8hnBpgLQoXG0r5CD0eybONWJaG3TtFgBjoO9JAbnfZuIu/YMrZjduFfdTPiKlrsf20KKruvk
	Qj5FD/LpJJ754Ir9FX2BJb735QyI1j62BiYmBgzAGNYif3x6guUCxnmuhljQKZIm9dpPM/koiez
	9nOk7dgSsDb2Gmn6ZwDo6Ou1FXYbZA2Ua5rL3P1+vzOYRNIgEkRqHDSph6vMxUSZ2Rx59HcS55/
	LI1+LC4XimRYZ/wzw3LjBS6UyXeqk/S7UBtqXNXm3qfgg1k9KOUfqLZ4yl/O1JBtqEUzu6KWIKL
	XOPrhii8M8g9/atmwS+
X-Received: by 2002:a05:6870:d68f:b0:409:5241:8abc with SMTP id 586e51a60fabf-416ab5fd865mr1373419fac.20.1772641756143;
        Wed, 04 Mar 2026 08:29:16 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b24dsm18350522fac.7.2026.03.04.08.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 08:29:15 -0800 (PST)
Message-ID: <a6591d03-3707-4f1c-b1fa-49f010f98d53@kernel.dk>
Date: Wed, 4 Mar 2026 09:29:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] io_uring: count CQEs in io_iopoll_check()
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
 <20260302172914.2488599-4-csander@purestorage.com> <aagKTanM5Az9UDsJ@fedora>
 <CADUfDZozycFBPX0kH=22Gda7njM3xVmL=Cy=zCq6cfXY8JH_dw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZozycFBPX0kH=22Gda7njM3xVmL=Cy=zCq6cfXY8JH_dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_082917_530931_BFBEE3B4 
X-CRM114-Status: GOOD (  23.80  )
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

On 3/4/26 8:46 AM, Caleb Sander Mateos wrote:
> On Wed, Mar 4, 2026 at 2:33?AM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> On Mon, Mar 02, 2026 at 10:29:12AM -0700, Caleb Sander Mateos wrote:
>>> A subsequent commit will allow uring_cmds that don't use iopoll on
>>> IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted without
>>> setting the iopoll_completed flag for a request in iopoll_list or going
>>> through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command could
>>> call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
>>> io_iopoll_check() loop currently only counts completions posted in
>>> io_do_iopoll() when determining whether the min_events threshold has
>>> been met. It also exits early if there are any existing CQEs before
>>> polling, or if any CQEs are posted while running task work. CQEs posted
>>> via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be counted
>>> against min_events.
>>>
>>> Explicitly check the available CQEs in each io_iopoll_check() loop
>>> iteration to account for CQEs posted in any fashion.
>>>
>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>> ---
>>>  io_uring/io_uring.c | 9 ++-------
>>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>>> index 46f39831d27c..b4625695bb3a 100644
>>> --- a/io_uring/io_uring.c
>>> +++ b/io_uring/io_uring.c
>>> @@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
>>>               io_move_task_work_from_local(ctx);
>>>  }
>>>
>>>  static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
>>>  {
>>> -     unsigned int nr_events = 0;
>>>       unsigned long check_cq;
>>>
>>>       min_events = min(min_events, ctx->cq_entries);
>>>
>>>       lockdep_assert_held(&ctx->uring_lock);
>>> @@ -1227,34 +1226,30 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
>>>                * the poll to the issued list. Otherwise we can spin here
>>>                * forever, while the workqueue is stuck trying to acquire the
>>>                * very same mutex.
>>>                */
>>>               if (list_empty(&ctx->iopoll_list) || io_task_work_pending(ctx)) {
>>> -                     u32 tail = ctx->cached_cq_tail;
>>> -
>>>                       (void) io_run_local_work_locked(ctx, min_events);
>>>
>>>                       if (task_work_pending(current) || list_empty(&ctx->iopoll_list)) {
>>>                               mutex_unlock(&ctx->uring_lock);
>>>                               io_run_task_work();
>>>                               mutex_lock(&ctx->uring_lock);
>>>                       }
>>>                       /* some requests don't go through iopoll_list */
>>> -                     if (tail != ctx->cached_cq_tail || list_empty(&ctx->iopoll_list))
>>> +                     if (list_empty(&ctx->iopoll_list))
>>>                               break;
>>>               }
>>>               ret = io_do_iopoll(ctx, !min_events);
>>>               if (unlikely(ret < 0))
>>>                       return ret;
>>>
>>>               if (task_sigpending(current))
>>>                       return -EINTR;
>>>               if (need_resched())
>>>                       break;
>>> -
>>> -             nr_events += ret;
>>> -     } while (nr_events < min_events);
>>> +     } while (io_cqring_events(ctx) < min_events);
>>
>> Before entering the loop, if io_cqring_events() finds any queued CQE,
>> io_iopoll_check() returns immediately without polling.
>>
>> If the queued CQE is originated from non-iopoll uring_cmd, iopoll request
>> will not be polled, may this be one issue?
> 
> I also noticed that logic and thought it seemed odd. I would think
> we'd always want to wait for min_events CQEs (and iopoll once even if
> min_events is 0). Looks like Jens added the early return in commit
> a3a0e43fd770 ("io_uring: don't enter poll loop if we have CQEs
> pending"), perhaps he can shed some light on it?

I don't  recall the bug in question, it's been a while... But it always
makes sense to return events that are ready, and skip polling. It should
only be done if there are no ready events to reap.

-- 
Jens Axboe

