Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316D7C678D5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwXc/jpU8P9SvE7/ufCSYYNysr1Ug87irwSTib4b2HM=; b=XgfSlSrZQBE5qOT5KZQyB6xwHf
	+k1Cq5BqJ7Uvy1/pX4McOBkAkWOrtcpY9EZJ6kEmKOAxtHonZl4z4DYgM9Y/9oNPWM5UU6yn8ZSir
	yBsbwc1q8Hgr6VfIFSFvcqFTqwsGwTdc41lS0tFUi7yR62HvuBdXNkRhTWzG9rg04O3y4YEOgDORl
	mOVerCzxknwAUro/zKVkBdHGl7DLS5fBmfeEjicGJKI5PIbln9savSriZAMJk2hGi3nu99st6oNdr
	7/Rld6EEdeBsWr27VTE4s47HkRn2OivvQf++0t9bStd4ZoKOGDYVHzAIR73lR4Je4ukftiARLVew5
	kaMc29Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZUIT-00HB2n-Nb; Tue, 07 Mar 2023 10:11:53 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZUIQ-00HB0A-7D
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 10:11:52 +0000
Received: by mail-wr1-f44.google.com with SMTP id e13so11522272wro.10
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 02:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwXc/jpU8P9SvE7/ufCSYYNysr1Ug87irwSTib4b2HM=;
        b=nHRxvnQkg4SkUd30wHUUev7fs7Yz4yT13j/cS1L4a3jvQPg5XhKL+XP3X+WmYcIWLZ
         OwWjdtGY1h0bg10W3CPEj2V43gQ7ets5iTzaRsnzckJf+3Joa/tYuKq4GVdYhgcufZxs
         9KtqWSWtn/yW7Jz46hftJoV0Pn9hSZMqKzzpvSm6gmAy0gnH49hXNHpKcyxc4+qq+DQw
         WI38RB315fZ1I0KugO9ubRXIOLqt+DY2vaf3U6hkYkAUU2Pwn2YdcVZR0Mlp7fUnBYqn
         Xx3Oe3rSUftiQVf6ruMfOG/wm0o71bjGPg7iPPX9rsaCs1694Jwde43HbL029tPWiLDQ
         O+eg==
X-Gm-Message-State: AO0yUKUqehXYG7GC3t4S8KYJxhn95/BloUAUOnx1SBFGBiqeNdPA3yIs
	WSat/DiAIy/1VOmILEYhShs=
X-Google-Smtp-Source: AK7set+dFM+iNBkj7YJ+P43iJzgw7oE7d6wNKl6Mh3AhyF/VaMARcKbGi6oVSfhN0kjcIUMmNUWQ1w==
X-Received: by 2002:a5d:5447:0:b0:2c7:91c7:8039 with SMTP id w7-20020a5d5447000000b002c791c78039mr7844181wrv.6.1678183905211;
        Tue, 07 Mar 2023 02:11:45 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe58d000000b002c569acab1esm12203441wrm.73.2023.03.07.02.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:11:44 -0800 (PST)
Message-ID: <81c57b4b-4568-baca-bf23-94b6e94873a0@grimberg.me>
Date: Tue, 7 Mar 2023 12:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v11 00/25] nvme-tcp receive offloads
Content-Language: en-US
To: Shai Malin <smalin@nvidia.com>, Aurelien Aptel <aaptel@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hch@lst.de"
 <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>
References: <20230203132705.627232-1-aaptel@nvidia.com>
 <72746760-f045-d7bc-1557-255720d7638d@grimberg.me>
 <DM6PR12MB3564B3D0D489B7F4325E69D9BCAD9@DM6PR12MB3564.namprd12.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <DM6PR12MB3564B3D0D489B7F4325E69D9BCAD9@DM6PR12MB3564.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_021150_283398_6F2A1D19 
X-CRM114-Status: GOOD (  59.28  )
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


> Hi Sagi,

Hey Shai,

> On Thu, 23 Feb 2023, Sagi Grimberg <sagi@grimberg.me> wrote:
>> Hey Aurelien and Co,
>>
>> I've spent some time today looking at the last iteration of this,
>> What I cannot understand, is how will this ever be used outside
>> of the kernel nvme-tcp host driver?
>>
>> It seems that the interface is diesigned to fit only a kernel
>> consumer, and a very specific one.
> 
> As part of this series, we are only covering the kernel nvme-tcp host driver.
> The ULP layer we are introducing was designed also for other kernel drivers
> such as the kernel nvme-tcp target and iSCSI.

Yes, I can see how this can fit iscsi, but my question was more for
userspace.

>> Have you considered using a more standard interfaces to use this
>> such that spdk or an io_uring based initiator can use it?
> 
> The main problem which I will explain in more detail (under the digest,
> teardown and resync flows) is that in order to use a more standard interface
> that will hide what the HW needs it will require duplicating the NVMeTCP
> logic of tracking the PDUs in the TCP stream – this seems wrong to us.

Hmm. Its not really the entire logic, its only the pdu/data
boundaries. Every data coming to the host is structured, with a standard
C2HData PDU.

If we assume for the sake of the discussion that such a parser exist,
how would the interface to the ulp look like?

> I can add that we are also working on an end-to-end user-space design for SPDK
> and we don’t see how the two designs could use the same socket APIs without
> impacting the performance gain of both cases.

Can you share a bit more how this will be done for spdk? spdk runs on
normal sockets today, hence I'd love to know how you plan to introduce
it there.

> 
>>
>> To me it appears that:
>> - ddp limits can be obtained via getsockopt
>> - sk_add/sk_del can be done via setsockopt
>> - offloaded DDGST crc can be obtained via something like
>>     msghdr.msg_control
> 
> If we wish to hide it from the NVMeTCP driver it will require us to duplicate
> the NVMeTCP logic of tracking the PDUs in the TCP stream.
> In the positive case, when there are no DDGST errors, nothing is needed to be
> done in the NVMeTCP driver, but in the case of errors (or just in the case of
> out of order packet in the middle of the PDU), the DDGST will need to be
> calculated in SW and it seems wrong to us to duplicate it outside of the
> NVMeTCP driver.

I didn't suggest that the recalc would be hidden, if the calculation
failed the ULP can do it.

Something like:
	ddp_ddgst = CMSG_DATA(CMSG_FIRSTHDR(msg))
	if (ddp_ddgst->valid) {
		great...
	} else {
		recalc_ddgst
	}

> 
>> - Perhaps for setting up the offload per IO, recvmsg would be the
>>     vehicle with a new msg flag MSG_RCV_DDP or something, that would hide
>>     all the details of what the HW needs (the command_id would be set
>>     somewhere in the msghdr).
> 
> Our design includes the following steps per IO:
> - ddp_setup (register the command id and buffer to the HW)
> - The existing flow which sends the command
> - The existing flow of read_sock()
> - ddp_teardown (for the per IO HW teardown, before posting the NVMe completion)
> 
> Using the recvmsg will only replace the read_sock() but this part in the NVMeTCP
> driver is not impacted by the offload design.
> The ddp_setup is needed in order to set the command id and the buffer, and this
> needs to be done before or as part of the sending of command and prior to the
> receive flow.

I agree, I didn't suggest that replacing the entire read_sock flow
(although that can change to recvmsg as well).

I was thinking more along the lines of MSG_PEEK that doesn't actually
reads anything, where the driver prior to sending the command, would do:

	// do a DDP recvmsg to setup direct data placement
	msg = { .msg_flags = MSG_DDP_SETUP };
	iov_iter_bvec(&msg.msg_iter, ITER_DEST, vec, nr_bvec, size);
	sock_recvmsg(queue->sock, &msg, msg.msg_flags);

	...

	// now send the cmd to the controller
	nvme_tcp_setup_cmd_pdu
	nvme_tcp_try_send_cmd_pdu
	...

That is what I was thinking about.
	
> In addition, without duplicating the tracking of the PDUs in the TCP stream,
> it is not possible to hide the teardown flow from the NVMeTCP driver.

The teardown flow is a bummer because it delays the nvme completion.
Is it ok to dma_unmap and then schedule a ddp teardown async without
delaying the nvme completion?

How does TLS offload handles the async teardown?

> 
>> - And all of the resync flow would be something that a separate
>>     ulp socket provider would take care of. Similar to how TLS presents
>>     itself to a tcp application. So the application does not need to be
>>     aware of it.
> 
> The resync flow requires awareness of TCP sequence numbers and NVMe
> PDUs boundaries. If we hide it from the NVMeTCP driver we would have
> to again duplicate NVMe PDU tracking code.

Its really a pretty trivial part of the pdu tracking. Just when
a C2HData PDU starts...

> TLS is a stream protocol and maps cleanly to TCP socket operations.
> NVMeTCP on the other hand is a request-response protocol.
> On the data path, it's not comparable.

Is it? looks similar to me in the sense that the input stream needs to
know when a msg starts and ends. The only difference is that the ULP
needs to timely provide the context to the offload.

> While it could be done by contorting recvmsg() with new flags, adding input
> fields to the msghdr struct and changing the behaviour of uAPI, it will add
> a lot more friction than a separate ULP DDP API specifically made for this
> purpose.

This may be true. I was merely asking if this was a path that was
genuinely explored and ruled out. To me, it sounds like it can
work, and also allow userspace to automatically gain from it.

>> I'm not sure that such interface could cover everything that is needed,
>> but what I'm trying to convey, is that the current interface limits the
>> usability for almost anything else. Please correct me if I'm wrong.
>> Is this designed to also cater anything else outside of the kernel
>> nvme-tcp host driver?
> 
> As part of this series, we are targeting the kernel nvme-tcp host driver,
> and later we are planning to add support for the kernel nvme-tcp target driver.
> 
> The ULP layer was designed to be generic for other request-response based
> protocols.

I understand.

> 
>>
>>> Compatibility
>>> =============
>>> * The offload works with bare-metal or SRIOV.
>>> * The HW can support up to 64K connections per device (assuming no
>>>     other HW accelerations are used). In this series, we will introduce
>>>     the support for up to 4k connections, and we have plans to increase it.
>>> * SW TLS could not work together with the NVMeTCP offload as the HW
>>>     will need to track the NVMeTCP headers in the TCP stream.
>>
>> Can't say I like that.
> 
> The answer should be to support both TLS offload and NVMeTCP offload,
> which is a HW limit in our current generation.

I can't complain about this because we don't have TLS supported in 
nvme-tcp. But _can_ they work together on future HW?

> 
>>
>>> * The ConnectX HW support HW TLS, but in ConnectX-7 those features
>>>     could not co-exists (and it is not part of this series).
>>> * The NVMeTCP offload ConnectX 7 HW can support tunneling, but we
>>>     don’t see the need for this feature yet.
>>> * NVMe poll queues are not in the scope of this series.
>>
>> bonding/teaming?
> 
> We are planning to add it as part of the "incremental feature".
> It will follow the existing design of the mlx HW TLS.

OK.

>>> Future Work
>>> ===========
>>> * NVMeTCP transmit offload.
>>> * NVMeTCP host offloads incremental features.
>>> * NVMeTCP target offload.
>>
>> Which target? which host?
> 
> Kernel nvme-tcp host driver and kernel nvme-tcp target driver.

Look, I did spend time looking into this patchset several times
in the past, and also provided feedback. The reason why I'm questioning
the interface now, is because I'm wandering if it can be less intrusive
and use the common socket interface instead of inventing a new one.

