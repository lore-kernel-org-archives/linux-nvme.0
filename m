Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD0C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 17:42:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93ED661073
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 17:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ED661073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bmRQTQbKn3JFmwan1JIog+h/rk8bWcPsu0hDdLFSEaA=; b=E8mLTUm8U/U8st+KOfIFC7jMG
	ybELxEDUNjC4MQD78bBgON1QhTdxSn+Kb3fsyaOB5uhItAnh5e+CmOt34n2/UTdXAsCFzVE/og1TX
	Nar1Iz+5eM31JB86iBI7PN11mXZ8Yj3ibXmeU5Y6PDTR+bu6rcCYqTNY+mhadmpzx0NFx/7xVoKNe
	8aMXsKxKf1la8pqEHZ+fzJqtFFhbf4H+vrLi3ubL70VmvJXinoQO8Erya4f0ObIk+3VE7Q84IzOlZ
	nAsAS2Cpd8I90nKy5XJgiGWXFOmkwYWGBiEaQsEIZjfYhGf6Fcz31s/ftRyk6/fn55bPKr1H7wX36
	8pzQflehQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lboCg-0040f2-9k; Wed, 28 Apr 2021 17:42:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lboCc-0040er-Ng
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 17:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=58hYmunxWG6GnycPM12i7BhsHKKSaATNB0A0mq7CEOo=; b=XmvZiUFcMxLmW/U43jNsIkr0FK
 ZHVTx0vqdkJv8xax5PnyAU7H0+4dly8FKubjpbHMDpJCjTKz4epyuCum4+Dfmk/Pr+rYgmOLsSS/j
 axufFZjLdvOhwldNyGHA9Nl4DHCa8jXuqVj7rh8M1dl2v8HwDOiVcntl2PdRqbQvORfVAUi4U2Wqm
 VSPy0p239RLjmGKF7jHerSX/sguSdR3PTHtK4DHCKQITPquEsWbwZp+2eusWZldt5GKJCrs6x+WuY
 76tCVcx2DRWRFk0gyvZtVjP4crYcEWEOGjgVR556+bAw55Q1QzO73mM3RUFleRgqWHhmZXHx95lDt
 dfObF7xg==;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lboCa-0004tO-7k
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 17:42:21 +0000
Received: by mail-wr1-f51.google.com with SMTP id h15so11705586wre.11
 for <linux-nvme@lists.infradead.org>; Wed, 28 Apr 2021 10:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=58hYmunxWG6GnycPM12i7BhsHKKSaATNB0A0mq7CEOo=;
 b=l/zORQ4emdrTNWtNbOtlVcGqD3zMalN4S0+4r1kXvT+wcMV3Kwbdu/Ii/LpQ9FCKkp
 12Ni8vfHFL/Ji1Z2LD+N7fx18w6B7v44TN6NZ2cAvC5qVyMBliDHx0mk0V4c2uOtqf3W
 YIIqm97UnNvM7GIXRIYDwWxtANeiJtq1KT/AqPBhB17aMtjMIbY2l1RDWHsSif3TQWzG
 esB8ed7ALxZOTOZtCMf8FjZrD3rraaKmQW9xa3uEWJSm3tSljOZFnpSgNloys4FZ4gsF
 DbOriWgjr0OsZYAt5y0ek2nPbUhUmJxGZWGJ8XpYLtK/0Ot14+G/Hv7RZDPdbvZGaMUs
 ddDQ==
X-Gm-Message-State: AOAM533OE8p/O7jhpb7xqZcXU9vzfLSyJNLOTERBrhqUP+s2ZaHk89Fn
 AO4vClcBWkwb0Pwlm+E0Y3M=
X-Google-Smtp-Source: ABdhPJzFR+xphBqjjThkfuxwxhrkFS5B/Wk8e5xD80lEKHrvDE4Dhm9OnxJPz5xaX9ev2jTBEzl8eg==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr1883616wro.249.1619631736885; 
 Wed, 28 Apr 2021 10:42:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:caa1:f76f:3865:edcb?
 ([2601:647:4802:9070:caa1:f76f:3865:edcb])
 by smtp.gmail.com with ESMTPSA id y8sm688716wru.27.2021.04.28.10.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Apr 2021 10:42:16 -0700 (PDT)
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
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
Date: Wed, 28 Apr 2021 10:42:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_104220_317230_376A24E7 
X-CRM114-Status: GOOD (  21.88  )
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


>>> This one took a bit to go through. The traces all only have a single r2t
>>> pdu with 0 offset for the full length of the requested transfer. I had
>>> to add trace events to see what the heck the driver is thinking, and
>>> the result is even more confusing.
>>>
>>> The kernel message error:
>>>
>>>       nvme5: req 5 op 1 r2t len 16384 exceeded data len 16384 (4096 sent)
>>>
>>> And all the new trace events for this request are:
>>>
>>>       fio-25086   [011] ....  9630.542669: nvme_tcp_queue_rq: nvme5: qid=4 tag=5 op=1 data_len=16384
>>>       fio-25093   [007] ....  9630.542854: nvme_tcp_cmd_pdu: nvme5: qid=4 tag=5 op=1 page_offset=3664 send_len=72
>>>       <...>-22670 [003] ....  9630.544377: nvme_tcp_r2t: nvme5: qid=4 tag=5 op=1 r2t_len=16384 r2t_offset=0 data_sent=4096 data_len=16384
>>>
>>> The fact "data_sent" is non-zero on the very first r2t makes no sense to me.
>>
>> Yep, not supposed to happen... Like the traces though! very useful and
>> absolutely worth having.
>>
>>> I so far can not find any sequence where that could happen.
>>
>> The only way that data_sent can increment is either by getting an r2t
>> solicitation or by sending incapsule data.
>>
>> What is the ioccsz the controller is exposing?
> 
> In capsule data is not supported by this target, so ioccsz is 4.
> 
>> in nvme_tcp_sned_cmd_pdu we have:
>> --
>>                  if (inline_data) {
>>                          req->state = NVME_TCP_SEND_DATA;
>>                          if (queue->data_digest)
>>                                  crypto_ahash_init(queue->snd_hash);
>>                  } else {
>>                          nvme_tcp_done_send_req(queue);
>>                  }
>> --
>>
>> Where inline_data flag is:
>> 	bool inline_data = nvme_tcp_has_inline_data(req);
>> which essentially boils down to:
>> 	req->data_len <= queue->cmnd_capsule_len - sizeof(struct nvme_command);
>>
>> I wonder how does the nvme command sgl look like? is it an offset
>> sgl?
> 
> Just a single data block descriptor SGL. The target supports only 1 and
> reports that through ID_CTRL.MSDBD.
> 
> What do you mean by "offset" SGL?

In tcp.c:
--
static void nvme_tcp_set_sg_inline(struct nvme_tcp_queue *queue,
                 struct nvme_command *c, u32 data_len)
{
         struct nvme_sgl_desc *sg = &c->common.dptr.sgl;

         sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
         sg->length = cpu_to_le32(data_len);
         sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
}

static void nvme_tcp_set_sg_host_data(struct nvme_command *c,
                 u32 data_len)
{
         struct nvme_sgl_desc *sg = &c->common.dptr.sgl;

         sg->addr = 0;
         sg->length = cpu_to_le32(data_len);
         sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
                         NVME_SGL_FMT_TRANSPORT_A;
}
--

What is the sgl type you see in the traces? transport specific sgl
(host-data i.e. non-incapsule) or inline?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
