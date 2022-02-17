Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EACC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pwVgJOZ/Ol2g92l1rNwj7a+wNfyyuDtSekzqAfAwkvc=; b=VSNgN6zcn+pspaeG+5qZtNPr3g
	PbrjhUK7UQVAKt6Lc4VsLnm7CuASrvGBDLuCPXZ3NhEZYTXjQmh+/ttDG0FVVn16pv4G/pq7nMwJd
	ANPhKjB/DxZsUodHPDB8y9gBMRhH4FhFwwJ8tzvuEg8dfFkGpsojLoHeRAJ7jQv4DSlsDrB0ISMTt
	hR3xU96gH51BmzpbA/jCtdEHh3cbrQoAddPTxAMtU2sTWQvPCt8dWAEdUjhIkqI56X0I5ztmAJfDn
	FtelLvIe75yORAVb63C6NNVlN2iQ4ULPUExKe2hdXeaKxTo9YLodmaNbNxf4njAOG2JJcnA9FJgX3
	+qNCiyRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKj3m-00BLaT-Rc; Thu, 17 Feb 2022 15:51:10 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKj3g-00BLZZ-4z
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 15:51:09 +0000
Received: by mail-il1-x12c.google.com with SMTP id f13so2556849ilq.5
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 07:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=pwVgJOZ/Ol2g92l1rNwj7a+wNfyyuDtSekzqAfAwkvc=;
 b=BkwggVnU10JDQWxf0JnKO9utjcsknKkwPF8vRW9V+RP0ljb6/Vgqzn69Nzbny5ko7d
 kr1CWU2UYAA2BkyeZpjj84Na/34cjbfqJDKg/WPkO1UR1V/zhabIrn85neKd/lCuZhYx
 I4FQrKjBotBkJNeSGkSQpTSsP4EMuHN4izvbWHYM9A9B4OkUE9v0UudZjdMNt45Z4cVr
 GCBGc2JqoSsogs0TC0u0bSXpCXxEyeL6ms62LpLTSToeKQ3Ym5sOgVz2s1dCWI3gJX3b
 s6J5D4KOmAtz1/pFdc9L/EuyXoxTIObNaUUh5ihOF/WPLquk862o+T/DnssZsrhuhpkR
 hWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=pwVgJOZ/Ol2g92l1rNwj7a+wNfyyuDtSekzqAfAwkvc=;
 b=tJa0gz18NFWxP9hps6JhrDYxwD2vvUSZSmzMVVSlJlBNzddinUCMxcUajdR4a4XOHs
 n7WvzVExWF4jIG96SjxDenDOhsmCMYzN0QsfoiHYYABCJ+e0jDuesplKhUex5VtcXR+/
 UNdpYWJT8AkZ6FXKG2UEtMbpIN3PCoEIMTzd3rt4vTTLHbXsPf/IZ/V8EDT5KRaQGH5J
 WbIjatIm5Ejhjvw4U1mK5nu+p5NFl9nFQ2B3fzMoD47EVizTDTmsH4CuKunIQR4X7QBa
 n4jvKoPVu7BZXpn4QVvsMY6brYd8c2qYii4pa1PfzSIH5/DsYXE/qR/XxmFb4F3xajEp
 oDmg==
X-Gm-Message-State: AOAM53348Kub+4tVx5LuQPK3025TaG/XznOc2zbBH8kVTVUgocfi6NwK
 8Eky55k1kKGMEM3u/WB+7slaSg==
X-Google-Smtp-Source: ABdhPJw0DRDT4raNzuDfpXbF+2DJuhvhqILxEiWgssr6hFUI9RMbPFGX8naA7JjRWKu8d+XR9Wb8vA==
X-Received: by 2002:a05:6e02:1706:b0:2ba:fca5:eb2 with SMTP id
 u6-20020a056e02170600b002bafca50eb2mr2402874ill.267.1645113061999; 
 Thu, 17 Feb 2022 07:51:01 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id u12sm1978969ilg.51.2022.02.17.07.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Feb 2022 07:51:01 -0800 (PST)
Message-ID: <b11ede2b-b737-f99a-7b31-20d6b4eccb42@kernel.dk>
Date: Thu, 17 Feb 2022 08:50:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC 01/13] io_uring: add infra for uring_cmd completion in
 submitter-task
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142228epcas5p2978d92d38f2015148d5f72913d6dbc3e@epcas5p2.samsung.com>
 <20211220141734.12206-2-joshi.k@samsung.com>
 <Yg2vP7lo3hGLGakx@bombadil.infradead.org>
 <CA+1E3rLpKp0h2x7CoFPXwsYOc4ZYg_sqQQ+ed8cJhq77ESOAjg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rLpKp0h2x7CoFPXwsYOc4ZYg_sqQQ+ed8cJhq77ESOAjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_075104_229510_2FEA3347 
X-CRM114-Status: GOOD (  18.82  )
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

On 2/17/22 8:39 AM, Kanchan Joshi wrote:
> On Thu, Feb 17, 2022 at 7:43 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> On Mon, Dec 20, 2021 at 07:47:22PM +0530, Kanchan Joshi wrote:
>>> Completion of a uring_cmd ioctl may involve referencing certain
>>> ioctl-specific fields, requiring original submitter context.
>>> Export an API that driver can use for this purpose.
>>> The API facilitates reusing task-work infra of io_uring, while driver
>>> gets to implement cmd-specific handling in a callback.
>>>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>>> ---
>>>  fs/io_uring.c            | 16 ++++++++++++++++
>>>  include/linux/io_uring.h |  8 ++++++++
>>>  2 files changed, 24 insertions(+)
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index e96ed3d0385e..246f1085404d 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -2450,6 +2450,22 @@ static void io_req_task_submit(struct io_kiocb *req, bool *locked)
>>>               io_req_complete_failed(req, -EFAULT);
>>>  }
>>>
>>> +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
>>> +{
>>> +     req->uring_cmd.driver_cb(&req->uring_cmd);
>>
>> If the callback memory area is gone, boom.
> 
> Why will the memory area be gone?
> Module removal is protected because try_module_get is done anyway when
> the namespace was opened.

And the req isn't going away before it's completed.

>>> +{
>>> +     struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
>>> +
>>> +     req->uring_cmd.driver_cb = driver_cb;
>>> +     req->io_task_work.func = io_uring_cmd_work;
>>> +     io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOLL));
>>
>> This can schedules, and so the callback may go fishing in the meantime.
> 
> io_req_task_work_add is safe to be called in atomic context. FWIW,
> io_uring uses this for regular (i.e. direct block) io completion too.

Correct, it doesn't schedule and is safe from irq context as long as the
task is pinned (which it is, via the req itself).

-- 
Jens Axboe


