Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0FAC0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xs+y/H49ZYpstA/B6kj1edFZvc3ilw64ChimuGOqo8I=; b=yLAg5VBbbv39Pme4CM6fqxs8Qg
	LpvA8cmrjWLeL0HQlj+3eITGOrOnNABunDXghPb9X4oaA5mBn0Y33g5o7jZ47KF2khzZFYghB4wsK
	L6wHzX5Wir2adnkzdvSFxYHzBaTvWAYWUS0PM4lHTgdYg6FA5LAtRzoNPsw8+RkPBqtY5YWdYI2lR
	+Ls/htHMVky6Y1b+IZxZRxPZF9RE3O3QIDIeUgmn/4+Kbwww1fs+7nKH5U0VGHCJojepyYlV+8a4i
	UtkesApfHxDEe0z+1ifiLLqJZkNLbInnv5gDpeZXuaLZDhr3ciUJ6aIB3V6Vujw0uHJjOxThAIfUw
	ESBHH8RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmD7-0000000ABUL-3eVB;
	Fri, 31 Jan 2025 08:17:09 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmD4-0000000ABTu-3wob
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:17:08 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436a39e4891so11446125e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 00:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738311425; x=1738916225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs+y/H49ZYpstA/B6kj1edFZvc3ilw64ChimuGOqo8I=;
        b=Ffl43z2dctWoctiXbubWQ6XU2rUxSjZVZaS1LO2b66R5WIfIJhTDd0cwbVZoy8me6h
         gGwfsO8ptPqofp1hqvErud7l7ptPPS+j4+jLpInjg/Svcls1N/ItAKyZFJMJll2Y4MZz
         xg3eBx7uXr15Nim5Qv/NRCZvs+R3S12iY0Edv5kSrGssRwO2V0Y8f+lyvedSveKMfDy5
         iNBqSkkMJey1Vc87HIeMzQcyvK4OY5NgDLOE0ZKcX03qybJ8ak+9MNkcZNUEkgHBba0Q
         vdNj3T5j5g6OswFFcvXjMDTJ3bkHn7oRckOvkNhxJG5vM5XNgxuqVnmrjSE0lUYX4Xl5
         uZBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCezT2lLHLWOrbTp0WtYQQCwzFRn/PQFKzckorm0tf+6UGwvFRJSRBx1OClCgbiVctDlBlBFE8tGLg@lists.infradead.org
X-Gm-Message-State: AOJu0YxpjKcBvMIemUCRk3226c6O0xnOJVUr2lVnqW5L5BcECk+Vr0pH
	Sfk9PToRCcagNkqxxl+LzGg+icM4xHKiLkc7BlQl9pOnuXvq5jvv
X-Gm-Gg: ASbGncvNqnbZzjPhMpzX1JdP5pVYBHMv45XtHkz3dsz80pE36A0w3tUiEddIKrkQHNd
	v3zjT9eHVU9MR+AaKyb4INwSJfFiPnPf+ful3e5C1YNSnc/wZEiujIOKfnB2gWDPHEnRbsnnsIt
	xoGdt/UZEIz6JHnZMeCDvT+75SIWkv4LLE7NyZqryOGBzdJik5U7hbGKO+8byv5zPEa2SLxxxGI
	RT5V1hQwoBl6x0XMFfUG2oVwwfbgY1znaJZNSuErugtMPcIUnOkjiKiGPCZNJ7ydW6Xj6fx5uNG
	6gY+GnZdXiNhGGNU+WSrZtLcyDuEwRZEJ3aRInxdng+2uJqzPJs=
X-Google-Smtp-Source: AGHT+IF1OpcgJDoHfSd3dhQkUQD+i80JnH4gDdzqTVCiryEFOtuQTWcP2Iub7pMlPll9uNC1B2SB7Q==
X-Received: by 2002:a05:600c:1d27:b0:436:5fc9:30ba with SMTP id 5b1f17b1804b1-438dc429771mr97301215e9.29.1738311425237;
        Fri, 31 Jan 2025 00:17:05 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc6de7csm84088275e9.32.2025.01.31.00.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:17:04 -0800 (PST)
Message-ID: <3bcc6e3f-5172-40d4-a4d4-b0f914b9406b@grimberg.me>
Date: Fri, 31 Jan 2025 10:17:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander <csander@purestorage.com>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
 <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
 <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de>
 <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_001706_981820_8527074F 
X-CRM114-Status: GOOD (  34.65  )
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




On 29/01/2025 0:02, Caleb Sander wrote:
> On Tue, Jan 28, 2025 at 12:28 AM Hannes Reinecke <hare@suse.de> wrote:
>> On 1/27/25 18:38, Caleb Sander wrote:
>>> On Sun, Jan 26, 2025 at 11:37 PM Hannes Reinecke <hare@suse.de> wrote:
>>>> On 1/24/25 19:43, Caleb Sander Mateos wrote:
>>>>> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
>>>>> checks that the return value from recvmsg() is non-negative. If the
>>>>> sender closes the TCP connection or sends fewer than 128 bytes, this
>>>>> check will pass even though the full PDU wasn't received.
>>>>>
>>>>> Ensure the full ICResp PDU is received by checking that recvmsg()
>>>>> returns the expected 128 bytes.
>>>>>
>>>>> Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
>>>>> split the ICResp over multiple TCP frames. Without MSG_WAITALL,
>>>>> recvmsg() could return prematurely with only part of the PDU.
>>>>>
>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>>>> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
>>>>> ---
>>>>> v4: keep recvmsg() error return value
>>>>> v3: fix return value to indicate error
>>>>> v2: add Fixes tag
>>>>>
>>>>>     drivers/nvme/host/tcp.c | 5 ++++-
>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index e9ff6babc540..56679eb8c0d6 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -1446,15 +1446,18 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>>>>>         iov.iov_len = sizeof(*icresp);
>>>>>         if (nvme_tcp_queue_tls(queue)) {
>>>>>                 msg.msg_control = cbuf;
>>>>>                 msg.msg_controllen = sizeof(cbuf);
>>>>>         }
>>>>> +     msg.msg_flags = MSG_WAITALL;
>>>>>         ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>>>>>                         iov.iov_len, msg.msg_flags);
>>>> But won't we have to wait for a TCP timeout now if the sender sends less
>>>> than 128 bytes? With this patch we always wait for 128 bytes, and
>>>> possibly wait for TCP timeout if not.
>>> Yes, if the NVMe/TCP controller sends less than 128 bytes, we need to
>>> wait for it to send the remainder of the ICResp PDU. That's just how
>>> the NVMe/TCP protocol works. If we want to protect against
>>> buggy/malicious controllers that don't send a full ICResp, we need a
>>> timeout mechanism. That's the purpose of the existing
>>> `queue->sock->sk->sk_rcvtimeo = 10 * HZ;` in nvme_tcp_alloc_queue().
>>> Note that recvmsg() timing out was already possible in the original
>>> code if the controller didn't send anything on the TCP connection
>>> after accepting it.
>>>
>> Hmm. With checking the code 'rcvtimeo' is only evaluated if MSG_WAITALL
>> is _not_ set. Makes me wonder why we do set it...
>> But that's beside the point.
> I am not seeing where sk_rcvtimeo is ignored when MSG_WAITALL is used,
> can you point me to the code?
> It is certainly ignored for *non-blocking* recvmsg() (MSG_DONTWAIT),
> but I don't see why it would be ignored for MSG_WAITALL. man 7 socket
> also suggests it applies to all blocking socket I/O.
>
> static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
> {
>          return noblock ? 0 : sk->sk_rcvtimeo;
> }
>
> In tcp_recvmsg_locked():
> timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>
>>>> Testcase for this would be nice ...
>>>>
>>>> And I need to check if secure concatenation is affected here; with
>>>> secure concatenation we need to peek at the first packet to check
>>>> if it's an ICRESP or a TLS negotiation.
>>> Are you saying that with secure concatenation we don't know in advance
>>> whether the connection is using TLS between the TCP and NVMe/TCP
>>> protocol layers? Wouldn't the host already need to know that when it
>>> sent its ICReq PDU?
>> No, the host doesn't need to know. TLS is enabled by the lower
>> layers.
>>
>> But upon further checking, I guess it'll be okay with secure
>> concatenation.
>>
>> Nevertheless, I would vastly prefer to have a receive loop here
>> instead of waiting to receive the full amount as per MSG_WAITALL.
>> The entire tcp code is using nonblocking calls, so I'd rather
>> keep it that way and implement a receive loop here.
> The driver uses non-blocking socket I/O in the I/O path, but not the
> connect path. nvme_tcp_init_connection() is already using blocking
> socket I/O to send the ICReq PDU and receive the ICResp. I suppose we
> could change the connect path to register poll interest and use
> non-blocking operations, but that seems like a more involved code
> change and orthogonal to the issue of receiving the full ICResp.

I agree. the driver blocks on ICResp rcvmsg, there is no reason to
use async interface.

Caleb, can you please make sure to test this patch with TLS?
Do you have a reliable way to reproduce this?

