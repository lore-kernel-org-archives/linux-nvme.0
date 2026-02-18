Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF60E9A047
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P6FnkwjeY6brj0/7CWbwbk4xYyhWl9xXSqqcuyfPR0w=; b=eYKk/RC0t+06GSEKjJjex5yJxQ
	1oTYGGpj2FNAV8zdDeomHuQnJVVS8/aoh+Cv3q2RLDOce1le6v3n2VkSOwAsXFgIBbXXD9rqkmVP0
	JTWV2GFgLi1uy7+j0oVdGvA03QHfOQzWlfGc1mu8tw2xYOkJyoq/JM/bZGRF3OJgIDZCnxDFVvL1h
	GjCqOOD0xsSpFkQnFNUv7pw44V5paoq2E2eVLLgS16UPLTcXrLVFR0JFvOfrO1fEwOFcktN45fTqx
	WEHdAhi6cBO20b/sBOenaAwuiD/oJHOiGO1MEe4E1JSm2qFGrtjvORnVB+NtH1zG6NaxG9Xdi8aTT
	4EuaEtkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vskKq-0000000A4k5-1wrK;
	Wed, 18 Feb 2026 16:23:32 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vskKn-0000000A4iP-2egy
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 16:23:31 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8954c9daaeaso76017736d6.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 08:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771431808; x=1772036608; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6FnkwjeY6brj0/7CWbwbk4xYyhWl9xXSqqcuyfPR0w=;
        b=EHm7uNduaeeebRnT6R3luxQ1QZYShxRhaNWyCQqZMrTBsTJdRbHJ9YZI3JdGuRuwBa
         Pqw93cG9HvYlLXmhVGpBQg5GGeGAC15nkcvZlnO0jd4xxxhO9lY/v3HZx4Loqn8QqShE
         Ix6E1HzTsLXldGlhWDGbUEO2iVzLtZD3KtYZTR1hKwPLz/3koNZZ1MNzf5k2bKme4+Bz
         vRtgMzjhMWNaspWTycdc/r8F0tnwpaRxWlhpeUMQFXX1Gf47yUmGDI04WBXWPi35eeuV
         kmAMXlFVsUthuFk5KaIq1cukqpyYlTWI5aUsxwhiiYxI400PoexYm9Mp7xGZ3rqzgotY
         6XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771431808; x=1772036608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6FnkwjeY6brj0/7CWbwbk4xYyhWl9xXSqqcuyfPR0w=;
        b=IZCjDBDY6xAX0lt5+L7J9cn83ymj52vhb5uqDoTBcpIg8c8ytfrTyz+vF53nlfabIh
         0T3/MZMHCm3Rj9kTlfOf3FEuIw/GUlkcuojaW96oLWT9ABx+Kc4WkD3kSaLY7YAeneXU
         ExzfeyHp/gL3W7Hu3PYKeoSwkGquY7arQu8Ws+4xWhtoyZ726FVyI0+2VupxRWq6unQe
         TxT6drhfYneiusAP3rVCXpuwhblrjgoPZszCuNrLS5G104S+CEZr1xjZIAukZP7AUWdM
         SKd9IFoqrYPc7/YTuJGqRfzdzE3g27bKra83sJjo5CbethGpplgB6ds4Tvpd10vjt5iZ
         8Cmg==
X-Forwarded-Encrypted: i=1; AJvYcCWk9OnV4seRiNwLEgwSPXxpvbFqTzKk1Ud1CQS9CZ/e3Yzrx+mhimx153MMdipBedSy9tNXVGo4bqk4@lists.infradead.org
X-Gm-Message-State: AOJu0YyQnVdB5NGhtQHmZ0vTCvPYl5HBU0nOeOvw1RjOj0H+7QSeBu6O
	4d7iELMuoRk62a71fI4Nxy1UgrdzJ+RIwWxUz4jWRPykyLXGwcTMK1IwHbCKJEO5bNI=
X-Gm-Gg: AZuq6aKtUIAS6OFwIcqLVQX6iqh27ImPnI6imio1yObL3XPe23Ybrj9/FgSeObkw9z9
	4GKKMQhLblPxm/+8R6DhiDgHNucDJ1KmjZNmQ6bSbPJE/EdJOTYreolKYWMjwfex7+huhf6OxSq
	S8fJkLGjNIOmeOhR5IN4sv4vL3unq6fbAtOYmnPe+WKLQ5BDa1b9bFTAtJ0poGZiGSaOC7paQyX
	P9//PDtR/dBKxsmJHZxodn38O8gFQXHyx9rCRlK87wF0XasQ8krikP4vhF3QRzALthUtjysGgmt
	7D1xDLZUuUD4KXa4kxSCf/i63vCxv5G+1LNuZtYj1r5oS7mBuM8cAAKd2wugDuPb2XRCIaDdriw
	oIDJTvT6t5XMdqtUSUxLi3EHAgzRXo6pYSvnxy2vPcC8WCS3mHqB5gvNRdjoqz8h6jbJB29AlDu
	ujFoNAD6Vx9Y8zxVDmTwlOvb2z41PWRbLda/9J0QdHcnqKCe8=
X-Received: by 2002:a05:6214:d01:b0:894:85ee:63c7 with SMTP id 6a1803df08f44-89734917c48mr270391536d6.43.1771431807931;
        Wed, 18 Feb 2026 08:23:27 -0800 (PST)
Received: from [172.19.0.48] ([99.196.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc91eccsm189415026d6.13.2026.02.18.08.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 08:23:27 -0800 (PST)
Message-ID: <88260480-238c-497c-bccc-aa1023551668@kernel.dk>
Date: Wed, 18 Feb 2026 09:23:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
To: Caleb Sander Mateos <csander@purestorage.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260213032119.1125331-1-csander@purestorage.com>
 <20260213032119.1125331-3-csander@purestorage.com>
 <CADUfDZr+4hv-vm8my7kbKQG-2zoomG5a1y5Yt9fzxqbvSyPrSw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZr+4hv-vm8my7kbKQG-2zoomG5a1y5Yt9fzxqbvSyPrSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_082329_699383_3FDD9DED 
X-CRM114-Status: GOOD (  26.71  )
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

On 2/17/26 7:18 PM, Caleb Sander Mateos wrote:
> On Thu, Feb 12, 2026 at 7:21?PM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
>>
>> Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
>> requests issued to it to support iopoll. This prevents, for example,
>> using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
>> zero-copy buffer registrations are performed using a uring_cmd. There's
>> no technical reason why these non-iopoll uring_cmds can't be supported.
>> They will either complete synchronously or via an external mechanism
>> that calls io_uring_cmd_done(), so they don't need to be polled.
>>
>> Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
>> even if their files don't implement ->uring_cmd_iopoll(). For these
>> uring_cmd requests, skip initializing struct io_kiocb's iopoll fields,
>> don't insert the request into iopoll_list, and take the
>> io_req_complete_defer() or io_req_task_work_add() path in
>> __io_uring_cmd_done() instead of setting the iopoll_completed flag. Also
>> allow io_uring_cmd_mark_cancelable() to be called on these uring_cmds.
>> Assert that io_uring_cmd_mark_cancelable() is only called on
>> non-IORING_SETUP_IOPOLL io_urings or uring_cmds to files that don't
>> implement ->uring_cmd_iopoll().
>>
>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>> ---
>>  io_uring/io_uring.c  |  4 +++-
>>  io_uring/uring_cmd.c | 11 +++++------
>>  2 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>> index c45af82dda3d..4e68a5168894 100644
>> --- a/io_uring/io_uring.c
>> +++ b/io_uring/io_uring.c
>> @@ -1417,11 +1417,13 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
>>
>>         if (ret == IOU_ISSUE_SKIP_COMPLETE) {
>>                 ret = 0;
>>
>>                 /* If the op doesn't have a file, we're not polling for it */
>> -               if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queue)
>> +               if ((req->ctx->flags & IORING_SETUP_IOPOLL) &&
>> +                   def->iopoll_queue && (!io_is_uring_cmd(req) ||
>> +                                         req->file->f_op->uring_cmd_iopoll))
>>                         io_iopoll_req_issued(req, issue_flags);
>>         }
>>         return ret;
>>  }
>>
>> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>> index ee7b49f47cb5..8df52e8f1c1b 100644
>> --- a/io_uring/uring_cmd.c
>> +++ b/io_uring/uring_cmd.c
>> @@ -108,12 +108,12 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
>>          * Doing cancelations on IOPOLL requests are not supported. Both
>>          * because they can't get canceled in the block stack, but also
>>          * because iopoll completion data overlaps with the hash_node used
>>          * for tracking.
>>          */
>> -       if (ctx->flags & IORING_SETUP_IOPOLL)
>> -               return;
>> +       WARN_ON_ONCE(ctx->flags & IORING_SETUP_IOPOLL &&
>> +                    req->file->f_op->uring_cmd_iopoll);
>>
>>         if (!(cmd->flags & IORING_URING_CMD_CANCELABLE)) {
>>                 cmd->flags |= IORING_URING_CMD_CANCELABLE;
>>                 io_ring_submit_lock(ctx, issue_flags);
>>                 hlist_add_head(&req->hash_node, &ctx->cancelable_uring_cmd);
>> @@ -165,11 +165,12 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
>>                 if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
>>                         req->cqe.flags |= IORING_CQE_F_32;
>>                 io_req_set_cqe32_extra(req, res2, 0);
>>         }
>>         io_req_uring_cleanup(req, issue_flags);
>> -       if (req->ctx->flags & IORING_SETUP_IOPOLL) {
>> +       if (req->ctx->flags & IORING_SETUP_IOPOLL &&
>> +           req->file->f_op->uring_cmd_iopoll) {
> 
> I do worry that the pointer chasing here may be expensive, ->file and
> ->f_op could both be uncached. Would it make sense to add a flag to
> req->flags to indicate whether a request should actually be IOPOLLed?

I think adding a REQ_F flag for that similar to what is done for NOWAIT
etc would be a good idea.

-- 
Jens Axboe

