Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0E4FD8779
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 01:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wLngegFvX4b1A6M7gXF8x6LDEglu2szAu+mVlUeGgM=; b=0N9MfRFFE14HUE2EX9CZyiGx8n
	+pPylsiQBFTGEaj6SX9v8HgQwzb/pV7gm+7KtOYtj8wHrPDfRraWxZR3bk67N5sM/kTLVlG7J1znV
	qicNyCdbxcN2gtKHzDBpnm6XCvNhFKzPmUiWWhOzvj7eVvwN1SgZS+YcFBZOEmHAevRHJLe3uYAdu
	367iChAjkfTz7wm+XucWY9Qp6FrMSOYtZOlSsc4IHgyeuQnMyvIKIeLnnDR+Xt2hfHeliHHr1YSF7
	oy2jnLGUH/rMkf8EAXBZcjYOAIytt70RTKhaDvYPgutHQsCs3Qyb13ASy6fnLOHy+0MHo3hxwwP4b
	3h43SOKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2fgQ-00000007YtC-2J3N;
	Wed, 18 Mar 2026 01:26:50 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2fgN-00000007Ysi-2NGn
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 01:26:49 +0000
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-464bc03efd8so4167640b6e.2
        for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2026 18:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773797206; x=1774402006; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wLngegFvX4b1A6M7gXF8x6LDEglu2szAu+mVlUeGgM=;
        b=SEIJk8m5PDZA2KpNe9nXIAH/RkRAQck0yKIvCKm1zI2samzl93S5PtE6R8VagapdmH
         V7dp6GP/wsCGkmEmnGF466gnHzfST+rcWIN73VQd3XHiZ8B6rhHgF3Q3iE3kwBtQv3Mb
         ON3IkkdzDHpnhXZEfxOp6ZGamVxt33BLGvktNA+fbj2/JGqo67Cf9BxB2xyzuy5iGwfD
         LIfwnm8Sn0O9FgnMx9HQLRB70PKbOuRUFODpGkFZoqH9QFUvo7F1RRjzxy4kTQU06dZP
         h03cx0/1qEDDl1gEMb5LU8877nMO5j0U2Em7MSGvyN7v8WOxza/b8PRXwwcHyXjhlfvi
         713Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797206; x=1774402006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wLngegFvX4b1A6M7gXF8x6LDEglu2szAu+mVlUeGgM=;
        b=mbo8yJoHnggwsx/AXvn+6a/sOEW8HqERWSNsgC6l4VZEb1ZGi2kK+LSu7zPfXfz6N9
         u6Kzfrir5NRQv21gSe7Pjf3kP9IEma46NYAyURwdvXNhIBlegspS9Olq+jgZJIFJBufW
         xt5Tgl8nMDibnDVjOawjGDdpNZj9HPwMPUPjmZHMlZTgFv3Bhqt9I/IIA19bFLO1eB7Z
         vJensKx80mpa7qQtSXc87jyvLpPg1IIKG7t636rob7n3RUvB9VKYJFBkg1wNQv7VUDsk
         gnpXRN5CmatlEyv6nCSrSugW7YpM92sSXdniYT+AGP/lxWHID4w6ZCepKxeprvaIMly0
         9soQ==
X-Forwarded-Encrypted: i=1; AJvYcCXexL/HDw97thG/UDmvrbE/Ppppo+gS7F/pK3m3wv3MRzlWWteJbayv2u+I5v3M2kXj6XI5pkZHx8Y9@lists.infradead.org
X-Gm-Message-State: AOJu0YxWzRUvCUeAMuj7jG1Q7mDBpV1pU9+GbZNvIUNR7L5AUhYApYzS
	KeqpPHlePWGtY+W4F8Tk2Xo8YS7ah9mXI0bzB/SEgzctgoB7gpYjq4fIcnpoyZjNofM=
X-Gm-Gg: ATEYQzxjYEyBmNqiwqc1Uw1+RXDoseHVAKTH6Lz01L2zeFkrAzg9NXM+vdRu9o1MtEC
	jyFG+h1vlhdzA5Juh4vhb1NhTZ5wsjfW/m19luHif4OJK5rn2AWmmGPY+pSSZ01xSJAoCiQZ0Rn
	Qv22EOpLVzyGE8yb9Te8SBVLs4CfuHnzZiKQ4R8QKHJDFNgtQHCmAQbetBBGi5YR1NF/FU/8BYF
	sSD4ANyy8kZ8V4tVAzVuYEoXWLw6wDYs0CzKaJfqHrFvGlINXTwYTC+IKz4g0yZcDWZD4ErUUBR
	WIjywkTp6p8BiJwcXo7daB9siF7bE9lKv/nNaHtV9oiC+k3QTfcGbqjcr2IDuIz2jYqfQrDg6rV
	tWQSWSgywHGfBWqiAw4QTJ7GUSEzC6tJCWx7k8jh0S1g2IC6LzRB5q6Nc+A2jCAfpbju2W690pe
	elH94SONYgBCKi6z+UV9zag5sY15AVu6jk00hqX4tLQmrEzB/ncnugwK+FA4/wTy0qRXG0IP3Dh
	tu4SSwOtXJIORhlP8sa
X-Received: by 2002:a05:6808:1308:b0:467:880:7441 with SMTP id 5614622812f47-467ba105148mr976117b6e.18.1773797206154;
        Tue, 17 Mar 2026 18:26:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467baa8dc58sm800637b6e.12.2026.03.17.18.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 18:26:45 -0700 (PDT)
Message-ID: <d5f37010-dc05-4057-a913-84ec621c5ac9@kernel.dk>
Date: Tue, 17 Mar 2026 19:26:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
 <177369928494.700746.8101380068186003544.b4-ty@kernel.dk>
 <307e4126-91ed-4ca8-9eb0-3f24f1490aa8@kernel.dk>
 <CADUfDZp-Fq4TAdOcvjwSO4G3sZzekzVsyT_yMsoC9D-2=5aLyw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZp-Fq4TAdOcvjwSO4G3sZzekzVsyT_yMsoC9D-2=5aLyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_182647_860254_C2FCDFB0 
X-CRM114-Status: GOOD (  14.33  )
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

On 3/17/26 6:47 PM, Caleb Sander Mateos wrote:
> On Mon, Mar 16, 2026 at 6:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/16/26 4:14 PM, Jens Axboe wrote:
>>>
>>> On Mon, 02 Mar 2026 10:29:09 -0700, Caleb Sander Mateos wrote:
>>>> Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
>>>> requests issued to it to support iopoll. This prevents, for example,
>>>> using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
>>>> zero-copy buffer registrations are performed using a uring_cmd. There's
>>>> no technical reason why these non-iopoll uring_cmds can't be supported.
>>>> They will either complete synchronously or via an external mechanism
>>>> that calls io_uring_cmd_done(), io_uring_cmd_post_mshot_cqe32(), or
>>>> io_uring_mshot_cmd_post_cqe(), so they don't need to be polled.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/5] io_uring: add REQ_F_IOPOLL
>>>       commit: 9165dc4fa969b64c2d4396ee4e1546a719978dd1
>>> [2/5] io_uring: remove iopoll_queue from struct io_issue_def
>>>       commit: 7995be40deb3ab8b5df7bdf0621f33aa546aefa7
>>> [3/5] io_uring: count CQEs in io_iopoll_check()
>>>       commit: 3a5e96d47f7ea37fb6adf37882eec1521f8ca75e
>>> [4/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
>>>       commit: 23475637b0c47e5028817c9fd4dabe8f7409ca6c
>>> [5/5] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
>>>       commit: f144dbac4b177cfd026e417ab98da518ff3372cb
>>
>> Caleb, want to send the liburing tests and documentation updates too?
> 
> Sure. What type of file do you recommend using for non-iopoll
> uring_cmds? Most of them seem to have relatively specific hardware
> (e.g. blkdev_uring_cmd, nvme_dev_uring_cmd) or kernel configuration
> (e.g. ublk_ch_uring_cmd, io_mock_cmd) requirements, as well as
> requiring elevated permissions. Maybe io_uring_cmd_sock would be the
> most general?

Yep I think uring_cmd sock commands would be a good choice. Bonus points
if you write the test as such that we can easily plug in future commands
we allow with IOPOLL as well, as I would imagine we'd expand which we
allow going forward once vetted.

-- 
Jens Axboe


