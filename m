Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340B2EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 09:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4jQlsF4VS5XkytwZjmbfeFb6WoEk0rjs6SWWnI5tDpI=; b=PJGTY+0Gax9GyS8g9p8s5oiNhp
	eduGnrEgLaL5IHEeiKL5C8U6x/pwjoBa3vASIlA3iKCIobSTU/z8z2BE7pOUkFzWCHKEEEkDcV/am
	Io3fkC6BJOnN1TCrY3snoNlKp8IVv92dqDrkacMpyvkwW60vE5vc1nRH+Sja9BVo1Uxyv84EvYyeb
	e19P3QlLOy95lcjEvtD4ScdozxXMYFHMpW7f8RCRMNnQ+zBzSmIpL668S6uVvuRGGycvd3JjE60wB
	lpBJpiv9ohELwzG0KutzR6XY0MxUQS1Eokcocyih9NgluN8KDMJaymzV3L4bcEedQcLSzJucHFeLl
	F6wHg2jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ9JX-00EE3U-0X;
	Tue, 11 Jul 2023 09:05:43 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ9JT-00EE2N-2A
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 09:05:41 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso11561825e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 02:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066337; x=1689671137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jQlsF4VS5XkytwZjmbfeFb6WoEk0rjs6SWWnI5tDpI=;
        b=H8gXkQFvBsH7MOMdVGw35B/me2+CE+7D/RiYJcYVvNt9nqH6kmyziKtf6OxaQ+PgVz
         kLDqaKUr5DINJh//YqvvIOOIYZeSxtkWrdws/Ac4VLVD4rK9TWJm18IQAmZ3vYwxvaCQ
         +YHZOgRooomez32cILyrk8L37lziU01225NSjsr0CtkPN8I0tJZdsPIA21W5O34qJ0fx
         fMQjEzYmi/677d3tLGcLHb53Hvp5A2N2coxwKYL7QzZvkQDe6guhnIc80IlmL0BJQoov
         wTDVHVmXr0+2WOXseKO4rUDa4QvtJG6v2542k+KDfkfrTDsvH3al85Qm2jnOOPEvaldk
         WqJw==
X-Gm-Message-State: ABy/qLa78chFoh1gaAcApE8864uR9D6Ea9OA7Ft2SI9uELp/jPQs6GYe
	1Xnseq1EpApMkCVOyqSnXGg=
X-Google-Smtp-Source: APBJJlHSOhgLS0Qpj8pE/vvuOXbBvsXR/Q2AAJMHknyOY0FPWHCnoc3NCcsjSlq6RiJa+zBT8whgVQ==
X-Received: by 2002:a5d:56c7:0:b0:314:1b64:1919 with SMTP id m7-20020a5d56c7000000b003141b641919mr11964093wrw.4.1689066336627;
        Tue, 11 Jul 2023 02:05:36 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q14-20020adfea0e000000b003063a92bbf5sm1663226wrm.70.2023.07.11.02.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:05:35 -0700 (PDT)
Message-ID: <930baefd-3424-c620-1b99-c912ed381785@grimberg.me>
Date: Tue, 11 Jul 2023 12:05:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/6] nvme: tcp: unquiesce queues after ctrl state is
 changed
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
 Chunguang Xu <brookxu.cn@gmail.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-4-ming.lei@redhat.com>
 <c794c9d5-f665-3d5e-edee-7dc36ed69bad@grimberg.me>
 <ZK0KemgHZEkvrA8i@ovpn-8-22.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZK0KemgHZEkvrA8i@ovpn-8-22.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_020539_716734_AE85B573 
X-CRM114-Status: GOOD (  23.14  )
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



On 7/11/23 10:53, Ming Lei wrote:
> On Tue, Jul 11, 2023 at 10:41:46AM +0300, Sagi Grimberg wrote:
>>
>>> Unquiesce queues until controller state is changed successfully.
>>>
>>> Prepare for moving start freeze into reconnect work for preventing new
>>> request from entering queue in LIVE state.
>>>
>>> Before removing namespace, unquiescing queues is done unconditionally, so
>>> it is safe to do this way in case of state change failure.
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/tcp.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index e414cfb3433f..e68bf21af348 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -2109,10 +2109,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>>>    	nvme_stop_keep_alive(ctrl);
>>>    	flush_work(&ctrl->async_event_work);
>>>    	nvme_tcp_teardown_io_queues(ctrl);
>>> -	/* unquiesce to fail fast pending requests */
>>> -	nvme_unquiesce_io_queues(ctrl);
>>>    	nvme_tcp_teardown_admin_queue(ctrl);
>>> -	nvme_unquiesce_admin_queue(ctrl);
>>>    	nvme_auth_stop(ctrl);
>>
>> This is potentially a problem. It is possible that auth work is
>> running in the bg here, and without unquiescing the admin queue
>> the the auth_stop may take unnecessarily long until its I/O times
>> out.
> 
> There isn't any IO queued to nvme before unquiesce since nvme_cancel_*tagset
> cancels all inflight IOs.

There is a window after cancel and before unquiesce that requests can
come in.

>>
>> I think it is fine to keep it as is...
> 
> If ctrl state is LIVE, nvme_check_ready() return true, then IO is
> sent to socket before changing ctrl state to NVME_CTRL_CONNECTING.

a) the controller is not live because it was changed to RESETTING before
b) nvme_check_ready() will also fail because the queue cleared bit
NVME_TCP_Q_LIVE when the io queues stopped in
nvme_tcp_teardown_io_queues.

> So unquisce has to be done after state is changed to NVME_CTRL_CONNECTING
> if we want to move start_freeze into re-connection work.

See my response. It is perfectly safe to keep it as is.

