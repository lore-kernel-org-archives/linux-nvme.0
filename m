Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C962EC3DA5D
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fy7JqxvWubOU8G8nGkj9K3+kqwvFSWwcrQL4bVFXx7E=; b=ULcbPZjxjdh1qsblNIfJyGXLiJ
	GTVOAHA/8CaVo5gbwQ+HqIZSfr+9cNvbKDI9ci8pQXpymQ7ySZLyZJ3Ls5ULdEdilu/hVCvgLllrI
	H87IyvPv3PoBNLlgJ4SlszghSz7pxTDfr0yzeNq0JkkiaCzYr75TiX29eO3mAZX0XwHzs2FQpESmH
	fCWwWEo6u2Lqj9a26RYqgWQOuc7lEf7mH+oIT27EwGmdl8ZoxdkVE0WYa/QE/dEWPMrEq7lAhVU4u
	T87Ltov/voXQ0YPm4dl/Sw+/b9XY1lZGiQ2FX/yy0RjytgwS5iGV+tGj5facpOIn65bphUn9jjlWi
	IjwYs9oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVV1U-00000006kib-1xxX;
	Sun, 21 Jul 2024 11:46:40 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVV1R-00000006ki9-3aPE
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:46:39 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426593b99daso3025995e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721562396; x=1722167196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy7JqxvWubOU8G8nGkj9K3+kqwvFSWwcrQL4bVFXx7E=;
        b=WT/Qm0Zyvi4XCu1kFX99lkJiZ8eZcsYIa5uY502vdWXcH8tL4mY0Ms0/PA7FWIcqVc
         8TfLvRDBG1YeI3BTTMM0ZUp/i4hRM7tcoTOjb4xFq/c2kYfA4WEcBsk9/LVONli2oOHg
         gMNejP3kkRMkw1oNyMYDzENDnrwVciX1WV2vjAtBKQ0XXmmVe1STMmz8DK+8Sk9/sNNl
         RCXF8i5+i4+mElKjY4cF0uogWZxrU5Qr5oitS24oARYqxOAQ4woNEtgP9V+nPEvikDmh
         XwGfnWaEeweWdX2VuFB/1rY9n56zJLEunFd4mNQhWkFmk7ZSN1QhLsbCLzFDvfdh/Aj+
         u3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6+juWhfDIlwgiZEvrX7p2zQSFjb87UUkPuDAoafGbujJu45R0K9jCzJR5sfrcoANUPkV4KID/3p2cl6q7Z4GRmEqF0ppmL9UoXF5HGs=
X-Gm-Message-State: AOJu0YxJw2ROynjw89WHF4z+Wr+EpeIzpXAi1OpdgI2iYwyUrg9DYqqG
	JOYCTPfaJvo7hGf9Jpg32uS7B09LDTk7U5ptXz9xDXkLprIQx9UPW9dGGw==
X-Google-Smtp-Source: AGHT+IE5xljxunFIi2ZqzXnsvLdLkYefFxKNqo79di4PSeVHH0w3UBqicVNITDEB+3OIkp8E85S4cA==
X-Received: by 2002:a05:600c:5108:b0:427:9f6f:4914 with SMTP id 5b1f17b1804b1-427daa727dfmr21714175e9.6.1721562395844;
        Sun, 21 Jul 2024 04:46:35 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm115863455e9.1.2024.07.21.04.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:46:35 -0700 (PDT)
Message-ID: <7846613b-f7c7-430e-a453-e0023a1f5667@grimberg.me>
Date: Sun, 21 Jul 2024 14:46:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: reduce callback lock contention
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-7-hare@kernel.org>
 <9b8b57ca-83ae-43a4-84c6-33017dc81a32@grimberg.me>
 <a5473f69-5404-4c38-85d9-ca91c5160361@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a5473f69-5404-4c38-85d9-ca91c5160361@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_044637_914164_AD8F87CC 
X-CRM114-Status: GOOD (  18.86  )
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




On 18/07/2024 9:42, Hannes Reinecke wrote:
> On 7/17/24 23:19, Sagi Grimberg wrote:
>>
>>
>> On 16/07/2024 10:36, Hannes Reinecke wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> We have heavily queued tx and rx flows, so callbacks might happen
>>> at the same time. As the callbacks influence the state machine we
>>> really should remove contention here to not impact I/O performance.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/tcp.c | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index a758fbb3f9bb..9634c16d7bc0 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1153,28 +1153,28 @@ static void nvme_tcp_data_ready(struct sock 
>>> *sk)
>>>       trace_sk_data_ready(sk);
>>> -    read_lock_bh(&sk->sk_callback_lock);
>>> -    queue = sk->sk_user_data;
>>> +    rcu_read_lock();
>>> +    queue = rcu_dereference_sk_user_data(sk);
>>>       if (likely(queue && queue->rd_enabled) &&
>>>           !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
>>>           queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>>           queue->data_ready_cnt++;
>>>       }
>>> -    read_unlock_bh(&sk->sk_callback_lock);
>>> +    rcu_read_unlock();
>>
>> Umm, this looks dangerous...
>>
>> Please give a concrete (numeric) justification for this change, and 
>> preferably a big fat comment
>> on why it is safe to do (for either .data_ready or .write_space).
>>
>> Is there any precedence of another tcp ulp that does this? I'd like 
>> to have the netdev folks review this change. CC'ing netdev.
>>
> Reasoning here is that the queue itself (and with that, the workqueue
> element) will _not_ be deleted once we set 'sk_user_data' to NULL.
>
> The shutdown sequence is:
>
>         kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>         nvme_tcp_restore_sock_ops(queue);
>         cancel_work_sync(&queue->io_work);
>
> So first we're shutting down the socket (which cancels all I/O
> calls in io_work), then restore the socket callbacks.
> As these are rcu protected I'm calling synchronize_rcu() to
> ensure all callbacks have left the rcu-critical section on
> exit.
> At a final step we are cancelling all work, ie ensuring that
> any action triggered by the callbacks have completed.
>
> But sure, comment is fine.

I suggest that you audit all the accessors of this lock in the 
networking subsystem
before determining that it can be safely converted to rcu read critical 
section. I suspect that
the underlying network stack assumes that this lock is taken when the 
callback is invoked.

$ grep -rIn sk_callback_lock net/ | wc -l
122
$ grep -rIn sk_callback_lock kernel/  | wc -l
15

