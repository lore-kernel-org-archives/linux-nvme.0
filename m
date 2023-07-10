Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B540EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJErA4qd0WElNqdpCU9r0IqbOD1q4SGivoPWezaKt4c=; b=Bs5FcqFeuB+sETAJJbzeh2Xl1U
	GEVe5D750Dn//R765fujXY73lHjs5WKFXnEbE7DnQPqsIBvRWC9Rimcq3j1zCH1Fm18U+vLauHvcb
	bvsk+g5dPm7b1q1WReuw4dgG4i5whcGTLhkc+bVcasVchXhtoU2lUNIph4rsvkee+ZsYgBE7ZOs+5
	eunSgkbZqMHqLyKonJGUpUIYNmthD0aI9vzn9ITQdvuUBhQ9A392agOHIYzTqKr+mR3iEGxihHj1f
	iBF0DXopGHkddEGv0m2vklzBrfru+6MN3n1dkoYP1gvDnmgEpuYXBI0Wa91wE0XeCG7oIdlyo6EJ6
	RVwSKD3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIrRZ-00BomM-2x;
	Mon, 10 Jul 2023 14:00:49 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIrRX-00Bolg-3A
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 14:00:49 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3145fcecef6so965753f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 07:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688997645; x=1691589645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJErA4qd0WElNqdpCU9r0IqbOD1q4SGivoPWezaKt4c=;
        b=IS7wEd/Z8LqOgWybQi7y0ytDXh+kh/SifClxY5ppwCHXvFMIEuWVr7gJKbH4VNvzF4
         0UywxefsbA2Ms7zUURYo4kAVTGxvJ5DtlQ/teuLzQkSxjtgOQCy1f7vIhmiW1DCB9W6l
         m/hjuW7W/MUFOrjqz5MnPTX9Y5JGuot5q8bY7/J+nYt/oulNrNNeMO6cNbc/wEdwTauq
         Xpx6We5fLqyoHltfwN/uYKQr+XqSa7m2lFWU997d7zCXz6Hs3b1ydO9E8cR/DLQshmoh
         v9vEIEaxo7fRN9Xkg+JEXK5ymtkmfN6SdDhorQRURBD92PP2l9H31YeppH38/K/YyXag
         i/fg==
X-Gm-Message-State: ABy/qLZrkB04ROMUytAVYIStWAkz1LX3ebFq39aImniioyYvs9Izs7cA
	zanHilHiRgz/C9+80knw004=
X-Google-Smtp-Source: APBJJlF73m+d9scSG+8ojwGGRP7yqIeKpmYFj2IXxvl71h2CAMXT77QemBG3NAIpqjmMCn+LlZozpA==
X-Received: by 2002:adf:cd86:0:b0:314:1af1:4ea6 with SMTP id q6-20020adfcd86000000b003141af14ea6mr12094698wrj.5.1688997644245;
        Mon, 10 Jul 2023 07:00:44 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d5147000000b0030fb828511csm11729959wrt.100.2023.07.10.07.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 07:00:43 -0700 (PDT)
Message-ID: <4f9a578c-8aa6-5a87-884f-77271b5946f3@grimberg.me>
Date: Mon, 10 Jul 2023 17:00:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
 Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
 <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
 <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
 <ZKvUgDbdCdScx0e7@ovpn-8-33.pek2.redhat.com>
 <61fcbded-dbed-bd04-4b96-b3326265eb43@grimberg.me>
 <ZKvsGuYrf+tJTy41@ovpn-8-33.pek2.redhat.com>
 <725f5e57-7900-3836-6232-ce862ae9971e@grimberg.me>
 <ZKwHPqi21HUNUyaY@ovpn-8-33.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKwHPqi21HUNUyaY@ovpn-8-33.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_070048_017768_698DF822 
X-CRM114-Status: GOOD (  17.93  )
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


>>> OK, I got your idea now, but which is basically not doable from current
>>> nvme error recovery approach.
>>>
>>> Even though starting freeze is moved to reconnect stage, queue is still
>>> quiesced, then request is kept in block layer's internal queue, and can't
>>> enter nvme fabric .queue_rq().
>>
>> See error-recovery in nvme_[tcp|rdma]_error_recovery(), the queue is
>> unquiesced for fast-failover.
> 
> OK, sorry for missing the nvme_unquiesce_io_queues() called in
> nvme_tcp_error_recovery_work().
> 
> After moving start_freeze to nvme_tcp_reconnect_ctrl_work, new request
> can enter queue quickly, and all these requests may not be handled
> after reconnection is done because queue topo may change. It looks not
> an issue for mpath, but could be one trouble for !mpath, just like
> nvme-pci. I guess you don't care !mpath?

First, !mpath is less of a concern for fabrics, although it should still
work.

In the !mpath case, if the cpu topology changes, then this needs to be
addressed specifically, and it is a secondary issue, far less important
than not failing over quickly.

> nvme_tcp_queue_rq() highly depends on ctrl state for handling request
> during error recovery, and this way is actually fragile, such as:
> 
> 1) nvme_unquiesce_io_queues() has to be done after ctrl state is changed
> to NVME_CTRL_CONNECTING, in nvme_tcp_error_recovery_work().
> 
> At least we should be careful for this change.

queue_rq() depends on ctrl->state but also queue state, and the latter
is guaranteed to be stable across quiesce/unquiesce. This is already
the case today.

