Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC31C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0C6yn+Jn2hn9bHpTYIQGfMQvGSUJwmSgN1JbJ6wT+Qw=; b=1j1vnPIUCqCZG+QYYF6hq2CYNC
	pn5ybb7KB1ZRqQg4D+IMJIymBHtX3H9AGM0CuQNCU+RY+BZ30yzF7ewUrKh6Jep33oL0AG6pmVFHQ
	9ephetK1RteQlIl882UF0RgiA0XLC7hzj1J4HmAgrVHTGIDA7rISD7mL1HpZDiKjV35cRQgPEgkdr
	VM0TQa5yCQsLNLXvbG2lptwKvcxKYW6g7wIqSxWtWRozBSeDcgQAN7p3mwJ6jCyUDdhM/wvfuENen
	QE+Yr5md/TaWA7jxupGB4pxw8IGJLaAZ3z3gdEEtQWWgd3AA1xI+SkernntENoPRQf5MYSus04pfi
	nzAILavg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofPYW-0077h2-Bf; Mon, 03 Oct 2022 17:48:40 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofPYT-0077fP-N4
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 17:48:39 +0000
Received: by mail-qv1-xf32.google.com with SMTP id u9so6360489qvo.11
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0C6yn+Jn2hn9bHpTYIQGfMQvGSUJwmSgN1JbJ6wT+Qw=;
        b=UxquGlCPU0Lxr38j5xuVAab5bB4JR6CVnYGjR9TJU5chw7InxO/KyV1T0YpRhUJTtR
         Tyy3DPu5BGyAcxVWu15wE62nScZBCd01Lf1ycu+7fEc7wt6uJimMG3poD5hyOCoun8LO
         q1fvJgEDFwQG/5GNmnw1FmaM6to2K3RlolaOswgn72w2g+5GbVBeOnAW+2jmG/o/7rUQ
         1F9FYpK6iR7JNBjC9xiOHaVqlL4U7rxCOlz1iAzLZ0GLmnXtertHWZ/Q78d6Kb8yoFM/
         l0AQym463rcezixaDAHMg9nvDvYuhjPR+g+hqQnJbUejeNmSERcTx00mQZoCCjSE9yWF
         Aw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0C6yn+Jn2hn9bHpTYIQGfMQvGSUJwmSgN1JbJ6wT+Qw=;
        b=rxqd0yTQIkycTELgxAXfKJ2np2J9NzR/UcIBwwx/9Oi/0fCFNYpi9FJczTgGLeWtvJ
         QnPmJwfd/Uw/yK5u1rcOvIHLIdUJC65YL36TQsm+++6dw4L/7YF7Zc6iHEzIOIDSifne
         tDZASbAGdy2sm7PFI2+QI82sqcZYxf5+J6NTnq+cslTrVlu5+MDUgda9Epixau7T5580
         wWXwyQpjJ6cn73/PsMUl9bZcmsrA5kHb6qrBx2N7BuBqdiwKslBUUxAz3r5nWfN+CInI
         CjVLzOPrprWUu8UmRvkqDWGzGm04hhOEcTPrbfkXmXowfoct83kVlGtfjKcP9sH2S/9H
         ikgw==
X-Gm-Message-State: ACrzQf3abVx9u7lSMnCE9sK2CLu2blCN6elm14aiRR8Z1bDwm7J0euIz
	+uy1jxwfl6ShsfihwNTaKx0=
X-Google-Smtp-Source: AMsMyM4CoyRnuDtKUgrn9x6v7MJeGrWrZeDtxB0bZfhjyJC5KBwnJKsttLVcbw67Oke1SPssDx7Omg==
X-Received: by 2002:ad4:5f48:0:b0:4af:b266:3bbd with SMTP id p8-20020ad45f48000000b004afb2663bbdmr16065477qvg.0.1664819314688;
        Mon, 03 Oct 2022 10:48:34 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b1-20020ac87541000000b0035bb6c3811asm9895482qtr.53.2022.10.03.10.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 10:48:34 -0700 (PDT)
Message-ID: <8aeea62b-c947-6414-bca1-3bd3f427cd56@gmail.com>
Date: Mon, 3 Oct 2022 10:48:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
Content-Language: en-US
To: duoming@zju.edu.cn
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
 <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
 <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_104837_770036_05D16D86 
X-CRM114-Status: GOOD (  21.60  )
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

On 10/2/2022 7:56 PM, James Smart wrote:
> On 10/2/2022 6:50 PM, duoming@zju.edu.cn wrote:
>> Hello,
>>
>> On Sun, 2 Oct 2022 10:12:15 -0700 James Smart wrote:
>>
>>> On 10/1/2022 5:19 PM, Duoming Zhou wrote:
>>>> The function lpfc_poll_timeout() is a timer handler that runs in an
>>>> atomic context, but it calls "kzalloc(.., GFP_KERNEL)" that may sleep.
>>>> As a result, the sleep-in-atomic-context bug will happen. The processes
>>>> is shown below:
>>>>
>>>> lpfc_poll_timeout()
>>>>    lpfc_sli_handle_fast_ring_event()
>>>>     lpfc_sli_process_unsol_iocb()
>>>>      lpfc_complete_unsol_iocb()
>>>>       lpfc_nvme_unsol_ls_handler()
>>>>        lpfc_nvme_handle_lsreq()
>>>>         nvme_fc_rcv_ls_req()
>>>>          kzalloc(sizeof(.., GFP_KERNEL) //may sleep
>>>>
>>>> This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
>>>> GFP_ATOMIC in order to mitigate the bug.
>>>>
>>>> Fixes: 14fd1e98afaf ("nvme-fc: Add Disconnect Association Rcv support")
>>>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>>>> ---
>>>>    drivers/nvme/host/fc.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>>>> index 127abaf9ba5..36698dfc8b3 100644
>>>> --- a/drivers/nvme/host/fc.c
>>>> +++ b/drivers/nvme/host/fc.c
>>>> @@ -1754,7 +1754,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port 
>>>> *portptr,
>>>>        lsop = kzalloc(sizeof(*lsop) +
>>>>                sizeof(union nvmefc_ls_requests) +
>>>>                sizeof(union nvmefc_ls_responses),
>>>> -            GFP_KERNEL);
>>>> +            GFP_ATOMIC);
>>>>        if (!lsop) {
>>>>            dev_info(lport->dev,
>>>>                "RCV %s LS failed: No memory\n",
>>>
>>> I would prefer this was fixed within lpfc rather than introducing atomic
>>> allocations (1st in either host or target transport).  It was introduced
>>> by lpfc change in irq handling style.
>>
>> Thank your for your reply and suggestions!
>>
>> Do you think change the lpfc_poll_timeout() to a delayed_work is better?
>>
>> Best regards,
>> Duoming Zhou
> 
> as a minimum: the lpfc_complete_unsol_iocb handler should be passing off 
> the iocb to a work queue routine - so that the context changes so that 
> either nvme host or nvmet ls callback routines can be called. If 
> possible, it should do the axchg alloc - to avoid a GFP_ATOMIC there as 
> well...
> 
> It's usually best for these nvme LS's and ELS's to be done in a slow 
> path thread/work queue element. That may mean segmenting a little 
> earlier in the path.
> 
> -- james
> 

looking further...   lpfc_poll_timeout() should only be used on an SLI-3 
adapter.  The existing SLI-3 adapters don't support NVMe. So I'm a 
little confused by this stack trace.

Can you describe what the system config/software setup is and 
specifically what lpfc adapter is being used (dmesg attachment logs are 
sufficient, or lspci output).

-- james


