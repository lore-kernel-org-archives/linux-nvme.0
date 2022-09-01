Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2D5ECAAD1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3rhlMOL4EWk8zjjMTz1BdAT3tqR6UwbNtJDCPl3hXUo=; b=SbRU6YL7LVd55QQNX/zG5RVHn1
	y8b+4YiueRjMlDs1GqbuKkYX9z7UIHmAa1vnlV5BOkleASMvomitwouFFKW0HNp70VwdWQ2otQ8/h
	c/SKF2uGtpB6W81ruFOZwvLn9g9+1RvOgPzyjZ3ZE6PnDK1hN+DtZPT6wKzV0OcC4/OoSqR+mZVwt
	LX2JyJuCRUBlpbqyNKUzB4JzqdXypymUv+B04LPkAHZyPgLOHtTbXL7VHyT5GVeNAy4z7AMMlwXHF
	Auovo6TP6KzNYuGKL+C0rVVgwWy/REWIlLVYtKVc9GA3YQMd4WXLmKJncDeV/OJzN2tmNpNnH94wx
	+n5oDiww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTnYO-00DT06-5I; Thu, 01 Sep 2022 17:00:32 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTnYL-00DSzI-Cn
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 17:00:30 +0000
Received: by mail-ej1-f48.google.com with SMTP id h5so24453936ejb.3
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 10:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3rhlMOL4EWk8zjjMTz1BdAT3tqR6UwbNtJDCPl3hXUo=;
        b=HAr3PirHLV0ErkpFWecVurjtk7r5LJI0MxhUGcTyoU0qGggFYc165CIMY342brv6If
         dyUVRqwbLdBv7NoczVrsC90pnRkuc3G4aQID+iV72Gd0b2lDkCMIFHv7hwdHeyNlScH5
         BhEhiYTWjV7y9wdTTxxMBDmVu6pe/9PSi5bCWFn6rF3ilqagWdOOdIcURuJZpggwePQ+
         IqVWiG4TgwESbV3QOw8BakliQy8LOrFG6dZUTco9/fV8FEbWNLMcH7fkN6/jD25zp0bL
         kGLdUvspJIvQz6A1C51Dw2eWhHUMOgcXEDadaalGL6EPalJR3DiYpTsGTZDaEnp5kjEF
         vWBw==
X-Gm-Message-State: ACgBeo3ldPQyfjagKWOLKcOPnJg9AWBg7SNbIUFTJXPIaioq4C31W98P
	/qPR1gvA17mw0JoUeMAK7fB6J2Z3fi4=
X-Google-Smtp-Source: AA6agR46jR90kjzWUYAqTzwRcSDZHlrKcWfZP3EQfixyP6abNRsITzw6MIfHGRSXudHi0gd/rkrOMw==
X-Received: by 2002:a17:907:1688:b0:730:b3ae:347 with SMTP id hc8-20020a170907168800b00730b3ae0347mr24496674ejc.756.1662051627413;
        Thu, 01 Sep 2022 10:00:27 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id gh21-20020a1709073c1500b0073a644ef803sm8638151ejc.101.2022.09.01.10.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 10:00:26 -0700 (PDT)
Message-ID: <6cf7127b-561d-b59f-1dc0-aefae9ad7e76@grimberg.me>
Date: Thu, 1 Sep 2022 20:00:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: linux-nvme@lists.infradead.org
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me>
 <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me>
 <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me>
 <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_100029_466681_B19876F8 
X-CRM114-Status: GOOD (  20.65  )
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


>>> Here's a trace including state from nvme_tcp_try_send_cmd_pdu(), like so.
>>>
>>> req->dbg.send = 1;
>>> ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset, len, flags);
>>> req->dbg.sendpage = ret;
>>>
>>>
>>> nvme-trace.out
>>>
>>> tar-1785    [005] .....   232.768892:nvme_tcp_queue_rq:
>>>    nvme1: qid=6 tag=18 op=0 data_len=20480
>>> tar-1785    [005] .....   232.768894: nvme_tcp_queue_rq:
>>>    nvme1: qid=6 tag=17 op=0 data_len=32768
>>> tar-1785    [005] .N...   232.768895: nvme_tcp_queue_rq:
>>>    nvme1: qid=6 tag=14 op=0 data_len=32768
>>> kworker/5:1H-475     [005] .....   232.768923: nvme_tcp_queue_rq:
>>>    nvme1: qid=6 tag=13 op=0 data_len=32768
>>> kworker/5:1H-475     [005] .....   232.768924: nvme_tcp_queue_rq:
>>>    nvme1: qid=6 tag=12 op=0 data_len=12288
>>> tar-1785    [007] .....   232.769141: nvme_tcp_queue_rq:
>>>    nvme1: qid=8 tag=69 op=0 data_len=20480
>>>
>>>
>>> dmesg.out (reordered to match nvme-trace.out)
>>>
>>> [  262.889536] nvme nvme1: state: tag 0x18 io_cpu 5 smp_id 5 smp_id2 5 sync 1
>>>    empty 1 lock 1 last 0 more 0 send 0 sendpage -1
>>
>> Something is not adding up...
>> lock=1, means that we get into nvme_tcp_send_all(), but somehow we are
>> not able to send it to the wire?
>>
>> I'd look into this and add indication that it is pulled from the
>> req_list, and in turn from the send_list. It looks like it is somehow
>> picked out and silteny dropped, because as long as it is on the list(s)
>> another context should have picked it up at some point...
>>
>>> [  262.889337] nvme nvme1: state: tag 0x17 io_cpu 5 smp_id 5 smp_id2 5 sync 1
>>>    empty 1 lock 1 last 0 more 0 send 0 sendpage -1
>>> [  262.889110] nvme nvme1: state: tag 0x14 io_cpu 5 smp_id 5 smp_id2 7 sync 1
>>>    empty 1 lock 1 last 0 more 0 send 0 sendpage -1
>>> [  262.888864] nvme nvme1: state: tag 0x13 io_cpu 5 smp_id 5 smp_id2 5 sync 1
>>>    empty 0 lock 0 last 0 more 1 send 1 sendpage 72
>>> [  262.888727] nvme nvme1: state: tag 0x12 io_cpu 5 smp_id 5 smp_id2 5 sync 1
>>>    empty 0 lock 0 last 1 more 1 send 1 sendpage 72
> 
> Ugh. It was misleading because the send state tracking was
> re-initialized after the direct send case. Here's a better trace with
> more information. It appears as though sendpage() is always called
> with the NOTLAST flag set. I suppose this could mean that there is
> some confusion or race with nvme_tcp_queue_more()?

I don't know yet...

> tar-1872          [004] ..... 389.559784: nvme_tcp_queue_rq:
>   nvme1: qid=5 tag=28 op=0 data_len=16384
> tar-1872          [004] .N... 389.559786: nvme_tcp_queue_rq:
>   nvme1: qid=5 tag=27 op=0 data_len=16384
> kworker/4:2H-1873 [004] ..... 389.559798: nvme_tcp_queue_rq:
>   nvme1: qid=5 tag=26 op=0 data_len=32768
> kworker/4:2H-1873 [004] ..... 389.559798: nvme_tcp_queue_rq:
>   nvme1: qid=5 tag=25 op=0 data_len=32768
> kworker/4:2H-1873 [004] ..... 389.559799: nvme_tcp_queue_rq:
>   nvme1: qid=5 tag=24 op=0 data_len=32768
> 
> 
> [  419.790505] nvme nvme1: state: tag 0x28 io_cpu 4 smp_id 4 smp_id2 4 sync 1
>   empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> [  419.790299] nvme nvme1: state: tag 0x27 io_cpu 4 smp_id 4 smp_id2 0 sync 1
>   empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040

Here lock=1, which means that we send inline, however last=0, which
means that more requests are coming and corresponds with NOLAST flag.

> [  419.789809] nvme nvme1: state: tag 0x25 io_cpu 4 smp_id 4 smp_id2 4 sync 1
>   empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
> [  419.790065] nvme nvme1: state: tag 0x26 io_cpu 4 smp_id 4 smp_id2 4 sync 1
>   empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040

here lock=0, but last=0 as well, so we add the request to req_list and
_not_ trigger io_work, again because more requests are coming.

> [  419.789663] nvme nvme1: state: tag 0x24 io_cpu 4 smp_id 4 smp_id2 4 sync 1
>   empty 0 lock 0 last 1 more 1 send 1 send_ret 72 send_flags 0x28040

Here lock=0, last=1, and we have requests that are queued (more=1), so
we add the the req_list, and schedule io_work. Now sending the last
3 commands happens asynchronously, so by the time that we get to send
to the wire, it is possible that more requests got queued, which
may explain why NOLAST flag is set...

So we cannot know for sure... You can add what is nvme_tcp_queue_more
at the time the flag is determined, but according to the code, it is
set if more requests are queued in req_list/send_list.

At some point, we'd expect to send with a request that has NOLAST
flag cleared. Would be interesting to make sure that we are getting
there.

BTW, is this a read-only workload? filesystem? can you share more
about the workload?

