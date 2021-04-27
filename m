Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D8C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:56:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A36961401
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A36961401
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JDv/SJ7P5wSCMBXcWxCxiNeYpdXKc5QK+t6gpxRTTu0=; b=dy3T54IFlwsSJ2pghRHAX+qoj
	LikD97yM1cvYfrfhc6mbSH8CUPl5GKBp2FnIkWRU3wGYXF2kCfZ2u9v9KeBUeZFUEFhVjOeQVVcdr
	BKZtn8nDTOKOeYJnUm3Cm9TK3HtLXIXm0It8Q1InMWeK2b+jxEFbaGSbAK+McZ9xxTbcfKXdMWBBr
	3gJUiwuHXGAbkJKkdiqzaQ3fXICaBufzc9nD3LZbC0aJB0DqNdgZW3Q464tSy0uZf69bIFs0UliqH
	g7SVo5OpQWyVNPQcDT7gCgpyoFanRzBHYGsdVqTHyK4PtEk4LQXeggg0AIfkdiLjbmhHKV+oa+oFU
	pdlO7L7tw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbXYc-002RYd-Ea; Tue, 27 Apr 2021 23:55:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbXYZ-002RYV-DZ
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 23:55:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=M7JewVwiUhEK7GAuqtP8cpEO0vkxGMm9jj0usmp5V2g=; b=DtCyi5yfk9Wmx32hDZaR519h37
 DUv0VC+e2Dnb2r8tfUqwF3V2/ZtuitS9g2M2nI5Omx1TJxJu4GAj6takU8xUQ0PmHQ0ryescnWN7I
 H6T7P+/3MpgpbNkbCBi9/PyvreJ6qtwLEKrmXL4cKIpbA2BSEcffjixTN/4+ZDUgUaAa1vkj07Tyy
 WTPXsb96ogKiwIMsie3TCUe3BIguWArJt6To5VWwaR9fGpqSODRyVr2axt+cbXgt8DCplhXkaEeF7
 P0HvCnvDRjtxMNKadoJ/O6eFtUBsO2AG2EUO9Z7OmmIWUc0gyRJIMR1vlP3ZXh0Hz3VQNhimtJHOP
 qMwsLuDQ==;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbXYW-00H6Oq-Dx
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 23:55:53 +0000
Received: by mail-wr1-f41.google.com with SMTP id l2so8795057wrm.9
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 16:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M7JewVwiUhEK7GAuqtP8cpEO0vkxGMm9jj0usmp5V2g=;
 b=oFrWtSuMX0c+WZIvb8NZZzk9kLDzdkfr7bTLaTs1GskPZ9HD2SdkptMcGuBKwLUrNY
 FDtfYjH7r2BEH7EdPZMUR/HLhD/Andkoclk/ZxmiepVa6tAJvTZ3AY0taU+QLwcH7UhP
 dIJKKR30vZmrEvJUWoIk757pS3mh2mCxVqUI7zd+FjTZtbQT5uQrbz7pOq+Q0lmMnHQE
 HAJ2kdRIPyatUz+7ZaraH2Q2wkVyLyfiMkgeBa7sovx6M2wOXaUhmddIyqXmKSWDwwjH
 rj88HaMlwiOjAj6auO7Zn0euFhjs8rLMEBTudHHyFQ6FoYjThKR3weKEfKV0Gt/rOe5q
 0XEQ==
X-Gm-Message-State: AOAM531qPQL7ZjKPPtBPVEVORSfp5faXxf4xxV65zX65d3vhSl92Hi6s
 70nTVRqaBjBHDehghty5B/U=
X-Google-Smtp-Source: ABdhPJz6r9nq9zliU/hlbMFkBG6pwN5DEQ0qzHM46YEZyyCIZTh/c6fwvtcqjF1EmlBq/++HzWcgUA==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr24451008wrw.142.1619567747483; 
 Tue, 27 Apr 2021 16:55:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c15:5b14:335a:66ab?
 ([2601:647:4802:9070:4c15:5b14:335a:66ab])
 by smtp.gmail.com with ESMTPSA id z66sm4508536wmc.4.2021.04.27.16.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Apr 2021 16:55:47 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
 <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
Date: Tue, 27 Apr 2021 16:55:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_165552_509243_20267441 
X-CRM114-Status: GOOD (  26.80  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>>>> This was observed on the recent 5.12-rc4, so it has all the latest tcp
>>>>>>> fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
>>>>>>> difference. It is currently reproducible, though it can take over an
>>>>>>> hour right now.
>>>>>>
>>>>>> After reverting 0dc9edaf80ea, we are observing a kernel panic (below).
>>>>>
>>>>> Ah, that's probably because WRITE_ZEROS are not set with RQF_SPECIAL..
>>>>> This patch is actually needed.
>>>>>
>>>>>
>>>>>> We'll try adding it back, plust adding your debug patch.
>>>>>
>>>>> Yes, that would give us more info about what is the state the
>>>>> request is in when getting these errors
>>>>
>>>> We have recreated with your debug patch:
>>>>
>>>>     nvme nvme4: queue 6 no space in request 0x1 no space cmd_state 3
>>>>
>>>> State 3 corresponds to the "NVME_TCP_CMD_DATA_DONE".
>>>>
>>>> The summary from the test that I received:
>>>>
>>>>     We have an Ethernet trace for this failure. I filtered the trace for the
>>>>     connection that maps to "queue 6 of nvme4" and tracked the state of the IO
>>>>     command with Command ID 0x1 ("Tag 0x1"). The sequence for this command per
>>>>     the Ethernet trace is:
>>>>
>>>>      1. The target receives this Command in an Ethernet frame that has  9 Command
>>>>         capsules and a partial H2CDATA PDU. The Command with ID 0x1 is a Read
>>>>         operation for 16K IO size
>>>>      2. The target sends 11 frames of C2HDATA PDU's each with 1416 bytes and one
>>>>         C2HDATA PDU with 832 bytes to complete the 16K transfer. LAS flag is set
>>>>         in the last PDU.
>>>>      3. The target sends a Response for this Command.
>>>>      4. About 1.3 ms later, the Host logs this msg and closes the connection.
>>>>
>>>> Please let us know if you need any additional information.
>>>
>>> I'm not sure if this is just a different symptom of the same problem,
>>> but with the debug patch, we're occasionally hitting messages like:
>>>
>>>     nvme nvme5: req 8 r2t len 16384 exceeded data len 16384 (8192 sent) cmd_state 2
>>
>> According to this message, this means the host got an r2t for 16384
>> bytes after it already sent 8192 (which can only happen if it previously
>> got an r2t soliciting 8192 bytes or more that accumulate to that). Can
>> you share for each r2t pdus in this sequence:
>> r2t_length
>> r2t_offset
> 
> This one took a bit to go through. The traces all only have a single r2t
> pdu with 0 offset for the full length of the requested transfer. I had
> to add trace events to see what the heck the driver is thinking, and
> the result is even more confusing.
> 
> The kernel message error:
> 
>      nvme5: req 5 op 1 r2t len 16384 exceeded data len 16384 (4096 sent)
> 
> And all the new trace events for this request are:
> 
>      fio-25086   [011] ....  9630.542669: nvme_tcp_queue_rq: nvme5: qid=4 tag=5 op=1 data_len=16384
>      fio-25093   [007] ....  9630.542854: nvme_tcp_cmd_pdu: nvme5: qid=4 tag=5 op=1 page_offset=3664 send_len=72
>      <...>-22670 [003] ....  9630.544377: nvme_tcp_r2t: nvme5: qid=4 tag=5 op=1 r2t_len=16384 r2t_offset=0 data_sent=4096 data_len=16384
> 
> The fact "data_sent" is non-zero on the very first r2t makes no sense to me.

Yep, not supposed to happen... Like the traces though! very useful and
absolutely worth having.

> I so far can not find any sequence where that could happen.

The only way that data_sent can increment is either by getting an r2t
solicitation or by sending incapsule data.

What is the ioccsz the controller is exposing?
in nvme_tcp_sned_cmd_pdu we have:
--
                 if (inline_data) {
                         req->state = NVME_TCP_SEND_DATA;
                         if (queue->data_digest)
                                 crypto_ahash_init(queue->snd_hash);
                 } else {
                         nvme_tcp_done_send_req(queue);
                 }
--

Where inline_data flag is:
	bool inline_data = nvme_tcp_has_inline_data(req);
which essentially boils down to:
	req->data_len <= queue->cmnd_capsule_len - sizeof(struct nvme_command);

I wonder how does the nvme command sgl look like? is it an offset
sgl?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
