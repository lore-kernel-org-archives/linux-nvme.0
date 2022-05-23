Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC71C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xl1DiXEWFosO7EmK0KY6xXff7PH4cRmRO5TF3/Ll6eo=; b=QGpHvQ+e8X82325YYQD+5f6JSJ
	3YAft38f6wUbZmb9W+QvmBJbyKYnakJYcRrqk849SfKmAD7VNR3A86WvIBUruLqESscRP7Iji8qqm
	8S1GkdyDgy20/baq/EolJ3ZV8iPJDcFjj1yqnzZw22K0oZ4HIv8U6pQtlZ/2CF9xaG2P3TaWDenGp
	NTbb7swh1ezmkpPVIOXW0fJvebfTVjyRYTTy6ovVqLyRs9yj5JENda1+pp1UMH4pB/G5sYBHsrYsl
	IFnV89meM8nEAaAMAZFQKLQheFpcGxSCyiwmWEGdlRlgto3HhS43PQ5d+x66RySYbN4D5lyY8KP/U
	ix5DAmew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nt8FD-004SHT-D4; Mon, 23 May 2022 13:37:11 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt8F5-004SFr-0S
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 13:37:04 +0000
Received: by mail-wr1-f51.google.com with SMTP id h14so21420105wrc.6
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 06:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Xl1DiXEWFosO7EmK0KY6xXff7PH4cRmRO5TF3/Ll6eo=;
 b=3OJh3ZMsXKzg+Asn8rLugFFTnKVbTtdxC/a0S9cznbEtgYqceEEFCU4FngXG5sVxdB
 mhRwWjYlyDNFBcwFo4XB9VIoCrKe8uKiur0SSEi6ceTZ4u60XQl1Xu2vR9DtH3beEUWI
 LKHf0zyBFkrWJLWRrxc7qlbggMvogWtURpDghjpz42+/yrRMgZtoWjcdPUs7mJkPbRDw
 LBxogLJWLfMztrTUgzZaKucy5whHVb7+6hi9Dh3SQfxU8hmmmk7vJ+QLK37Cln64XDNK
 0YjLX+wR6Jp51l8Z+BM74C/14UDu1Lo6UpotsMmWkR3EvMsY9R0okW0LSksQJBAvu8lz
 hcRQ==
X-Gm-Message-State: AOAM533XKtehDSkJctTAHbkybh5RtdEV+Q2kv7U5ba6wATFSr8ckOa1V
 zM5yW874cg0BH8/UL7zSns4FsxXxVo8=
X-Google-Smtp-Source: ABdhPJzV/z/GvrG6E/8z+APyW+z7EwZR9f/dv/hqlXwEQylGyceGGaPscgA1Yrela84LvIrancDaMw==
X-Received: by 2002:a05:6000:2cc:b0:20d:e6c:e4f8 with SMTP id
 o12-20020a05600002cc00b0020d0e6ce4f8mr18501731wry.374.1653313019755; 
 Mon, 23 May 2022 06:36:59 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 m21-20020a7bca55000000b003942a244f47sm10076407wml.32.2022.05.23.06.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 May 2022 06:36:59 -0700 (PDT)
Message-ID: <96722b37-f943-c3e4-ee6a-440f65e8afca@grimberg.me>
Date: Mon, 23 May 2022 16:36:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-2-hare@suse.de>
 <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
 <96a3315f-43a4-efe6-1f37-0552d66dbd85@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <96a3315f-43a4-efe6-1f37-0552d66dbd85@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_063703_102933_A10AC310 
X-CRM114-Status: GOOD (  30.71  )
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


>> The patch title does not explain what the patch does, or what it
>> fixes.
>>
>>> When running on slow links requests might take some time
>>> for be processed, and as we always allow to queue requests
>>> timeout may trigger when the requests are still queued.
>>> Eg sending 128M requests over 30 queues over a 1GigE link
>>> will inevitably timeout before the last request could be sent.
>>> So reset the timeout if the request is still being queued
>>> or if it's in the process of being sent.
>>
>> Maybe I'm missing something... But you are overloading so much that you
>> timeout even before a command is sent out. That still does not change
>> the fact that the timeout expired. Why is resetting the timer without
>> taking any action the acceptable action in this case?
>>
>> Is this solving a bug? The fact that you get timeouts in your test
>> is somewhat expected isn't it?
>>
> 
> Yes, and no.
> We happily let requests sit in the (blk-layer) queue for basically any 
> amount of time.
> And it's a design decision within the driver _when_ to start the timer.

Is it? isn't it supposed to start when the request is queued?

> My point is that starting the timer and _then_ do internal queuing is 
> questionable; we might have returned BLK_STS_AGAIN (or something) when 
> we found that we cannot send requests right now.
> Or we might have started the timer only when the request is being sent 
> to the HW.

It is not sent to the HW, it is sent down the TCP stack. But it is not
any different than posting the request to a hw queue on a pci/rdma/fc
device. The device has some context that process the queue and sends
it to the wire, in nvme-tcp that context is io_work.

> So returning a timeout in one case but not the other is somewhat erratic.

What is the difference than posting a work request to an rdma nic on
a congested network? an imaginary 1Gb rdma nic :)

Or maybe lets ask it differently, what happens if you run this test
on the same nic, but with soft-iwarp/soft-roce interface on top of it?

> I would argue that we should only start the timer when requests have had 
> a chance to be sent to the HW; when it's still within the driver one has 
> a hard time arguing why timeouts do apply on one level but not on the 
> other, especially as both levels to exactly the same (to wit: queue 
> commands until they can be sent).

I look at this differently, the way I see it, is that nvme-tcp is
exactly like nvme-rdma/nvme-fc but also implements context executing the
command, in software. So in my mind, it is mixing different layers.

> I'm open to discussion what we should be doing when the request is in 
> the process of being sent. But when it didn't have a chance to be sent 
> and we just overloaded our internal queuing we shouldn't be sending 
> timeouts.

As mentioned above, what happens if that same reporter opens another bug
that the same phenomenon happens with soft-iwarp? What would you tell
him/her?

