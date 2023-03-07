Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107A0C6FD1E
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 22:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bPKaOswbRQoMtVb/bJwTA4T0l4v+XGUjDNukkwoDnxc=; b=bvDnnFjMp7CKDK7Pt2gP5GaYZw
	z0491U5SvYi+4z5CEVWZR7UnMKhef+VLvXI8hsDu/Ne3l1r2/51tWjGNlgQGekbzxoaqOKvZ8/Bax
	0eyTeKcRX82UEbhSMZMU5q5GFDqZhZbYxT4hzJzzeXbcAbwJai6jyqus75saUyHsX/ORT4tMI6pqs
	V2VFCZ4yS4zH9F/cIGTg+IykFbY6B/UxDWwnfZqtng185OrSdqt3GDtcRyuX1UxJkoJfLV5LDTRGY
	nXTEetc1DU/S9sWg7xugJMALlu/aURIeRJMvILFWlZ/D06rfVmb9lSIG9+NL94emernBahQeWdfG2
	3FWaFqNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZfUa-002a3v-Sa; Tue, 07 Mar 2023 22:09:08 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZfUX-002a2i-F7
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 22:09:06 +0000
Received: by mail-qt1-x82f.google.com with SMTP id l13so16215788qtv.3
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 14:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678226943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPKaOswbRQoMtVb/bJwTA4T0l4v+XGUjDNukkwoDnxc=;
        b=CO6X+b3CnWd/cp3isYabKrCA7Qfpl8i9NtR2iey5+ehrkpprZ3kkJ880npBQGi/mJ+
         6N/GXurWYhbw+4ALlUUu3eUL3AGBppDY4VlWND8CDcXgrtO6x1pE+ey8OPTl0gHBHewN
         CPTDMT/f/E4L5dm1M/WZdSXZqEK5gs9E1SF6u8FiUB7EzrzaDGg/CtfnbievhsDcpamX
         DXw3oeEBDSO56g/f0mus2yOSZv4KQpi3QXsQ+OQS8c161vkdrxkVyk3HuXQYAm4HpVQP
         R29AKPjWh6Szqg0QC1Ma2MMkS8h+JQ8uUKql7rWj2uA/zXb1ho4qi33tg30rBRA1krJD
         hAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPKaOswbRQoMtVb/bJwTA4T0l4v+XGUjDNukkwoDnxc=;
        b=dxDDAYKJ1pAg2r0SN+W8HK+7wRBBOu/lKwQJao+q0y6lavusdTghQdEZWxA1Jf8XJF
         ajLsR/gPTOeGTTnIV8UYNaq1J3OXcZwiPV7KsPtJhiVDLDL/kLY/xUS+LeRZxSaInWFu
         R69RKp/AONYFjmTqnq8bAV/lASBrZEh7atO4Wd0b4m5d0Fal7oiOt7R3ICCScZKtqSR1
         dh6ofFkrRPpm+qPTI8pV7rc1HFZHy8TAl8A83iYbra0eu/SIuqy7UkGT2tlXByImYoG+
         kjsiErdzKIxi0oyz5K7gEv2r5YpP/BABEgYjg1pGnfSW0Q93fctY3uNKVccqM0vCLQXI
         vZtQ==
X-Gm-Message-State: AO0yUKWRG0OKCNjZw6gqMKf8ty9Z8cRM/lpBud1+A/6GVF7DG/Lf4mj+
	DwONgAu8QPgCigpeDtxtKF3+8mk6iP8=
X-Google-Smtp-Source: AK7set8q3G27xxMzHMTpo7qtRJg1/eITS+NShxngdRU/g4Aoi8qFzJzE4rFUOE6EdTQyZnRYZEkDeQ==
X-Received: by 2002:ac8:5dca:0:b0:3b8:6db0:7565 with SMTP id e10-20020ac85dca000000b003b86db07565mr29833168qtx.11.1678226943476;
        Tue, 07 Mar 2023 14:09:03 -0800 (PST)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x13-20020ac8120d000000b003bffe7fdc38sm10291945qti.9.2023.03.07.14.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 14:09:03 -0800 (PST)
Message-ID: <ce404c97-2716-9572-22de-3935c23757dc@gmail.com>
Date: Tue, 7 Mar 2023 14:09:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20230301082737.10021-1-dwagner@suse.de>
 <a73ea22a-9871-d152-080e-49c0904dbe94@grimberg.me>
 <20230307122849.3oc66ojdsgvvj77h@carbon.lan>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230307122849.3oc66ojdsgvvj77h@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_140905_542865_A8D828F5 
X-CRM114-Status: GOOD (  24.95  )
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

On 3/7/2023 4:28 AM, Daniel Wagner wrote:
> On Tue, Mar 07, 2023 at 11:26:12AM +0200, Sagi Grimberg wrote:
>> I think we should make all transports to unify setup/teardown sequences
>> (i.e. including pcie and fc). Otherwise we are not gaining much.
> 
> Not sure about pcie but I haven't really looked at it. The state machine is
> really handling all the fabrics specific queue handling.
> 
> Ideally, fc would use the same state machine. Though the current code base is
> differs quiet significantly but I can try to convert it too.

I'll certainly help for FC.

The 2 main hurdles are our differences around:
a) the new flag - which I replaced in the fc calling setup and a state 
flag. Shouldn't be much of an issue. We just need to look at when/where 
the tagsets are allocated (and embedding into admin queue setup isn't 
necessarily best).

b) the init_ctrl - I don't have the initial connect inline to the 
init_ctrl call - I push it out to the normal "reconnect" path so that 
everything, initial connect and all reconnects, use the same 
routine/work element. Also says the transport will retry the initial 
connect if there's a failure on the initial attempt. To keep the app 
happy, init_ctrl will wait for the 1st connect attempt to finish before 
returning.   Don't know how rdma/tcp feels about it, but I found it a 
much better solution and cleanup became cleaner.


> 
>> It will help if we make the ops higher level like
>>
>> ops.setup_transport(ctrl)
>> ops.alloc_admin_queue(ctrl)
>> ops.start_admin_queue(ctrl)
>> ops.stop_admin_queue(ctrl)
>> ops.free_admin_queue(ctrl)
>> ops.alloc_io_queues(ctrl)
>> ops.start_io_queues(ctrl)
>> ops.stop_io_queues(ctrl)
>> ops.free_io_queues(ctrl)
> 
> This is more ore less what v2 is.
> 
>> The init/deinit can be folded to alloc/free I think.
> 
> Yes, that would a good thing. In my first attempt I tried to keep things more a
> less identically with the existing code, just using the callbacks for the
> transport specific bits.
> 
>> This is indeed a much larger effort, but I don't know what
>> this unification of rdma/tcp buys us really...
> 
> My motiviation is that we are keep fixing the same bugs in rdma and tcp
> transport since a while. The state machine code is almost identically so why not
> trying to reduce the code duplication?
> 
> (*) There are a few small things which are not the same.



