Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A00C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ybw3/juzrtcH5gapwTZnN/k9wsHBzLLgavnqAXc3UQY=; b=uGde9As56bZ7tcyAIEKwuUaVxE
	WrJdw8azS6Mid4pDMr5YnRGVUvlGKCCv6MuHVAFoqqDtHrsaXAuS7FyM6Cs/fzNVB+tB44Y4EsHO+
	dvp3FMsZYXCtwyaTLHIob4Vycq6QGno7QWT+pLNYYbqpgkhq8/9ImKWqBD0BDFSoOTjWORsgLVKPw
	b76AEUG1Z0XYHQ07KctPNXqodB/cjHjJSzdGDbSl5wUnGfF/yJECDHj8i+WeIVF+MYJrY06R9dQDp
	alseemR6hnWGnv904RiMsUV+IF3oVBPmYJzNtcDiNeZ6Tvb51Esi0m6GvCotWIfKWVHhmwLyEMjOT
	46cOC/9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQVE-00EF01-RL; Wed, 28 Sep 2022 06:25:04 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQVC-00EEyF-78
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:25:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso450782wmq.2
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ybw3/juzrtcH5gapwTZnN/k9wsHBzLLgavnqAXc3UQY=;
        b=U4Ip4ujdG0+0ElSSX23Uhvi5KMYk8k8AnsVSKGs3J+vUtuCrCf31YoFB/znNidUIGY
         F3FVbRnqRFjeq8K4x7XXqQ29B4DEELfEznXFKkjM1zzSRjIGAIU9My5RTrt1klxh0Ej8
         QexA93REH4fXfYiRzPuOaedbzBiUPxHqUDIhWwz7K3NwHU/+w6MQiu7Z4KyZfUUR0KAq
         8VBvyZejAe8JB0H9upkzPC1J9G5biqmWczYeAsOxulY2qqdgl6j/t809h8ylq7yaZpmr
         aOAHxgcEGgZqEjnl/yMn4zYmo9r93EVDtTofg4/h6219HBVSK7irzCnXCmVDdcUXpGAH
         3S8A==
X-Gm-Message-State: ACrzQf3/Ayk4osGFdNkn6w1Yi/Z6qc5Y6oByC6nrQ0VkxvT2S9ukV43g
	6OXyTRHl1/GiKaAN8++3GvhNyGxqIfc=
X-Google-Smtp-Source: AMsMyM4EkTGOWHSSy8CW9BTVooQRdgXp0Xzddawntkx4s/hFXDpNu5ZsVZGd0OQ9YYTCAUuomDqCYg==
X-Received: by 2002:a05:600c:46c6:b0:3b4:cad4:7d3e with SMTP id q6-20020a05600c46c600b003b4cad47d3emr5520689wmo.78.1664346298820;
        Tue, 27 Sep 2022 23:24:58 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bk8-20020a0560001d8800b0022af865810esm3163003wrb.75.2022.09.27.23.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:24:57 -0700 (PDT)
Message-ID: <509b1722-66cc-0c16-058e-25ce1ae709f5@grimberg.me>
Date: Wed, 28 Sep 2022 09:24:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: nvme/tcp: infinite loop, livelock, and OOPS issues on disconnect
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: linux-nvme@lists.infradead.org
References: <CAHex0cqsATq98N3xevr0-vEcKBaRnTV1cm8einZ925CYyJNcsw@mail.gmail.com>
 <c7c90d39-2c4a-afea-ace4-bc3ae5f584d7@grimberg.me>
 <CAHex0cqc0UNWz4CzzJzxRvji=89BZiVKQFG3TF=espy72Ga54Q@mail.gmail.com>
 <dea45ad6-a5da-b9f6-a851-22fc4e5ef75e@grimberg.me>
 <CAHex0cqz1yvN6qnrb-UcqciB6K6ZwjY_vQi06RyqKA3tUsxqRQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0cqz1yvN6qnrb-UcqciB6K6ZwjY_vQi06RyqKA3tUsxqRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_232502_296068_9FD7C149 
X-CRM114-Status: GOOD (  22.76  )
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


>> Thanks for moving to a recent kernel.
>>
>> Based on the stack trace, the reason for the hang is that
>> disconnect is attempting to remove all the namespaces before
>> starting to teardown the controller, before that it flushes
>> any ns scanning to not compete with it running concurrently.
>>
>> but NS scanning is stuck when discovering a namespace because
>> adding it as a disk triggers some I/O most likely for stuff
>> like partition scanning etc.
>>
>> The ns scan is stuck only because its inflight I/O never completes,
>> which is likely related to the errors you are inserting from the
>> controller side every now and then...
>>
>> I do see a possible race here. that right when a transport error is
>> observed, error recovery is scheduled (err_work) but before it is
>> executing, delete_ctrl is starting to teardown the controller,
>> particularly calling nvme_stop_ctrl() -> nvme_tcp_stop_ctrl()
>> which cancels the err_work.
>>
>> If the error recovery is not running, nothing will fail inflight
>> commands if they are not failed by the controller explicitly.
>>
>> What would be helpful, is to know that once the issue reproduced,
>> if the ctrl->err_work, was canceled without executing.
>>
>> So if the theory is correct, this fix is warranted:
>> --
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index d5871fd6f769..2524b5304bfb 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2237,7 +2237,7 @@ static void nvme_reset_ctrl_work(struct
>> work_struct *work)
>>
>>    static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
>>    {
>> -       cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
>> +       flush_work(&to_tcp_ctrl(ctrl)->err_work);
>>           cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
>>    }
>> --
>>
>> This will make err_work to run, and then it is guaranteed that all
>> inflight requests are completed/cancelled.
> 
> Good news. I ran with the fix proposed continuously for three days
> without reproducing the issue.

Great, thanks for testing!

> Is there any specific instrumentation
> you want me to run to get direct confirmation of the bug/fix? If not,
> I think we're all set.

I don't think that this is necessary, the fix makes sense, and it does
seem to address the issue.

