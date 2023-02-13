Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AFFC636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AoQuAdyRkWJkwkL4dx4uGGjrg+rF6oVP5L+6m2+4qbc=; b=Yt0pgHuThAqzLWIzUdosWXaebA
	onc0KT7txPsyDJHtKVuTq8vym/sunoR5sMlldOXN8KRFjgQpwtUkbJ3Qg+hG2Ak0xSi5RtfWzZGbm
	RwCyyE//KHh2LD5weh1qORdJd2i8KsPVzem3aoIcREsyIECtBcGr8vQJ8d4jLqYxQjSCOYKZzVnt4
	UTOh7hBeiSA2F8Wggl9+UYmJs59BkGL8vsfJpGxn/yDOeReL8CtCI5xXn41edE1TtjnugQo6KM6CG
	OePQXy34Ek1Lc+BBAYsQEnk2E8QJFBB+K7ZbcNnf4xmu+eb3cHDvYtUkMX4NYoKn0H7TZkFeaTD3Y
	FhXWwY5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVli-00E2QD-L7; Mon, 13 Feb 2023 10:09:06 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVlf-00E2Od-5R
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:09:04 +0000
Received: by mail-wr1-f46.google.com with SMTP id r2so11524238wrv.7
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 02:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoQuAdyRkWJkwkL4dx4uGGjrg+rF6oVP5L+6m2+4qbc=;
        b=IoN3vURpOJeJtBDSQgbMx3XMkuHLBntd1zu2whdWzKQrMesirTSpYqkSU+mWqTZtX3
         ueJYTaIgFdVb8SVskeopqUeVmpuH+amghgbupPuuDzGEkdVZeMZhyfWd9Gwr2tibe0MH
         4GRtCV/fnZfSTKW8k1vSYgoTdruE1OlU4md+gCbsfbYxw1VzbwHhfVXHLBUx+sVWWcR/
         iukoyCzpjX2yX2ciLgXkcaNYSuRfkVQcuixvFsInxwswMjhbyfmxZAEVq3M0PQtMcbLb
         o59/SZpKqOVuaO24wuNb7j1Ez1rXRbCKcqfpKiQhwTvGaP/5J0pG83fgI8A+zeuEkqhg
         qSDw==
X-Gm-Message-State: AO0yUKVT3jtp0CFjAGLB0sVSskYC9l/mMtBWIUu/rAWh4O4ihfmXTYzF
	beOmwtfRo0vo/NztcaF4gWE=
X-Google-Smtp-Source: AK7set+cZELKdICXxvegYsh7M+ZDtM05rKTBXovEv2vdRBemLZKwLAaCeLT7XGIKRaMvzduqxdmtCw==
X-Received: by 2002:a5d:6e5d:0:b0:2c4:80a:e842 with SMTP id j29-20020a5d6e5d000000b002c4080ae842mr10760637wrz.3.1676282940388;
        Mon, 13 Feb 2023 02:09:00 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x1-20020adfffc1000000b002425be3c9e2sm10205353wrs.60.2023.02.13.02.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:09:00 -0800 (PST)
Message-ID: <7b2319ab-9c87-1699-4419-1b4a2d3cd715@grimberg.me>
Date: Mon, 13 Feb 2023 12:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] nvme: move result handling into nvme_execute_rq()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-4-hare@suse.de>
 <a2b720a1-962b-5314-2475-8908a877b943@grimberg.me>
 <118c9ac2-02b1-8922-9dac-d20364c01837@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <118c9ac2-02b1-8922-9dac-d20364c01837@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_020903_226903_E81B3915 
X-CRM114-Status: GOOD (  18.35  )
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



On 2/13/23 12:04, Hannes Reinecke wrote:
> On 2/13/23 10:59, Sagi Grimberg wrote:
>>
>>
>> On 2/9/23 16:38, Hannes Reinecke wrote:
>>> and simplify the calling convention.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/core.c       | 16 ++++++++++------
>>>   drivers/nvme/host/ioctl.c      |  5 +++--
>>>   drivers/nvme/host/nvme.h       |  3 ++-
>>>   drivers/nvme/target/passthru.c |  3 +--
>>>   4 files changed, 16 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 78da9c6cbba8..11faebe87764 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1004,15 +1004,21 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
>>>    * >0: nvme controller's cqe status response
>>>    * <0: kernel error in lieu of controller response
>>>    */
>>> -int nvme_execute_rq(struct request *rq, bool at_head)
>>> +int nvme_execute_rq(struct request *rq, union nvme_result *result,
>>> +            bool at_head)
>>>   {
>>>       blk_status_t status;
>>> +    int ret;
>>>       status = blk_execute_rq(rq, at_head);
>>>       if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
>>>           return -EINTR;
>>> -    if (nvme_req(rq)->status)
>>> -        return nvme_req(rq)->status;
>>> +    ret = nvme_req(rq)->status;
>>> +    if (ret) {
>>> +        if (result && ret >= 0)
>>
>> How can ret be < 0 here?
>>
>> Why not always take the result, unconditionally?
>>
> Yeah, right. Will be fixing it up.
> 
>> Is this really necessary though?
>>
> ??
> Yes, it is necessary to return the status (if there is one).
> Quite some callers expect that.
> And no, it's probably not necessary to check if there is a status;
> we might always return a status here. But for the result I guess we
> should be checking the status first; I'm slightly hesitant to blindly
> return the result even if we have a zero status.

I meant the simplification altogether. it really forces callers
to send a nvme_result (or NULL) and convert back. Didn't see that
it dramatically simplifies the code.

