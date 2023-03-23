Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2470FC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oOhWx5hqgjPuc55ynmMAxZ4Nttm12OYOh7+N2OfmB+4=; b=XAwTnPnGtKA9RW0ZAZ/vlv4YWc
	5LJozkuzxXSsJVY0eVlNvtZbJpuGXDrw6Lzhtjf3hwKWdJcUewLDrsTajb4fyLBSDQ6cziCDK79DA
	X++idjEAgOOvX+w6+yrFpRDFlV61iV5lDuiyQksq2XWDUHjjKVpt9+dVy6O95Qxx3wGQhPUQJtIVR
	NTeFsuS2qzftz6hDwccFDwKCJVyXDV3HgLSvflisdrLAaGTOE0dIvUbuFcCR9UQN7aZCjOrleYRpM
	ZrDPvijfcXH2KgVL0mxmn1+a8BH2+UINhIDHysjlGngKXJHGXlVXTeB0CHxq5aNgT4M+rhN/CGERx
	EyMC/52A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFG5-0015hQ-0f;
	Thu, 23 Mar 2023 07:21:13 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFG1-0015gZ-1b
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:21:11 +0000
Received: by mail-wr1-f54.google.com with SMTP id r29so19351787wra.13
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 00:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556064; x=1682148064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOhWx5hqgjPuc55ynmMAxZ4Nttm12OYOh7+N2OfmB+4=;
        b=cfD2HOjdCffkRxdXplTR1MEvJfhohjnEEbHocNLWSnT7m/7DnLsA4e07fd7ainQ7/S
         Pi3JFtnIBBtI+kimhcRYyDLo8mI8wAQy+kxLhHtK0PmoK4y1K5VW+jeJiU8119HqoJYz
         6aQ/2+6CimTxhtzUipMyqZb0NRL3XjwaxjhNf+4LuvjVI7Y4lGJPdGxErqyqsnwBX8kz
         VnveZhZ6vhdEApDQ/UuJ8djlHtSJVhAFl+wznNrZ6wlQqikkebqYzal9vx99BBcqE069
         XzZrnUJ2YWvTkTfaniIuk9E64q5sFqAlxraHmVRyY1H1i79mSHrp38LtJsQVgxKy0Svo
         5lJA==
X-Gm-Message-State: AAQBX9d7RqtOUfWINhse+aY1POny3Kyew0FqotX+9L8vw3QUg39jiZ2G
	Bm7nB2Q9KXq6iOb/3ASxyMh6RPVhzBU=
X-Google-Smtp-Source: AKy350YqnStmgqqn0t1BZqc6IF7s4ryZPEhE56GlQconW8MZ82zQ0ro2hjnIIHgAy4QZYOFd1DuWzw==
X-Received: by 2002:a5d:404d:0:b0:2db:43ed:1bb6 with SMTP id w13-20020a5d404d000000b002db43ed1bb6mr1472663wrp.3.1679556064296;
        Thu, 23 Mar 2023 00:21:04 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b002d45575643esm13442756wrs.43.2023.03.23.00.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:21:04 -0700 (PDT)
Message-ID: <ea181844-69f5-66eb-e64e-e9871916532b@grimberg.me>
Date: Thu, 23 Mar 2023 09:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Chuck Lever III <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chuck Lever <cel@kernel.org>,
 "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
 <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
 <b8a2e1d4-3571-447b-25c6-c6dd25fbad02@suse.de>
 <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
 <c426d104-b7f2-e736-c23a-b94fda54ed37@suse.de>
 <e0620d94-9729-014c-2cb8-8ff826ebbefa@grimberg.me>
 <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
 <68AA3629-6B88-4098-AA03-BEDF614F8D0B@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <68AA3629-6B88-4098-AA03-BEDF614F8D0B@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_002109_551273_3FAC4379 
X-CRM114-Status: GOOD (  20.46  )
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


>>>>>> The 'data_ready' call might happen at any time after the 'accept' call and us calling into userspace.
>>>>>> In particular we have this flow of control:
>>>>>>
>>>>>> 1. Kernel: accept()
>>>>>> 2. Kernel: handshake request
>>>>>> 3. Userspace: read data from socket
>>>>>> 4. Userspace: tls handshake
>>>>>> 5. Kernel: handshake complete
>>>>>>
>>>>>> If the 'data_ready' event occurs between 1. and 3. userspace wouldn't know that something has happened, and will be sitting there waiting for data which is already present.
>>>>>
>>>>> Umm, doesn't userspace read from the socket once we trigger the upcall?
>>>>> it should. But I still don't understand what is the difference between
>>>>> us waiking up userspace, from the default sock doing the same?
>>>>>
>>>> No, it doesn't (or, rather, can't).
>>>> After processing 'accept()' (from the kernel code) data might already be present (after all, why would we get an 'accept' call otherwise?).
>>>> But the daemon has not been started up (yet); that's only done in
>>>> step 3). But 'data_ready' has already been called, so by the time userland is able to do a 'read()' on the socket it won't be seeing anything.
>>> Not sure I understand. if data exists, userspace will read from the
>>> socket and get data, whenever that is. >
>> That's what I thought, too.
>> But then the userspace daemon just sat there doing nothing.
> 
> I haven't been following this discussion in detail, but
> if the kernel disables the normal TCP data_ready callback,
> then user space won't get any data. That's why SunRPC's
> data_ready calls the previous sk_data_ready and then shunts
> its own data_ready callback during handshakes. Without that
> call to the old sk_data_ready, the user space endpoint won't
> see any received data.

Yes that is understood. But the solution that Hannes proposed
was to introduce nvmet_tcp_tls_data_ready which is overriding
the default sock data_ready and does pretty much the same thing.

The reason is that today nvmet_tcp_listen_data_ready schedules accept
and then pretty much immediately replaces the socket data_ready to
nvmet_tcp_data_ready.

I think that a simpler solution was to make nvmet_tcp_listen_data_ready
call port->data_ready (default socket stored data_ready), schedule
the accept_work and only after the handshake bounce to userspace is
completed, override the socket callbacks.

Something like:
--
static void nvmet_tcp_listen_data_ready(struct sock *sk)
{
         struct nvmet_tcp_port *port;

         trace_sk_data_ready(sk);

         read_lock_bh(&sk->sk_callback_lock);
         port = sk->sk_user_data;
         if (!port)
                 goto out;

         port->data_ready(sk); // trigger socket old data_ready

         if (sk->sk_state == TCP_LISTEN)
                 queue_work(nvmet_wq, &port->accept_work);
out:
         read_unlock_bh(&sk->sk_callback_lock);
}

...

static void nvmet_tcp_tls_handshake_done(void *data, int status,
					 key_serial_t peerid)
{
	...
	queue->state = NVMET_TCP_Q_CONNECTING;
	nvmet_tcp_set_queue_sock(queue); // now own socket data_ready
}
--

