Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B01C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NOpI29WK93kPIoQN+4npStzaJDQP3VzNREpVcUJTXwI=; b=qcNCZZlRtNZuaUIVJUBRrelDbN
	HCYl85TLN2v49KbQ6WaydFAV2GrQHSLDPepWaCJD5RmQMJLUO6hsNJSJ3k1uPlcp8NdrHK/7wzALV
	pgeMY0EE3AbZbdhvG0STU2MRUGP6YJ6h1h2cK6hJTGgxjvEiqmpgshNogDY6Prus1bS6YuJKGn5Ch
	7QKNmMDmhJ3OlffkNwyCGGdeBfkyK02riphIPQMfc7PkR/Bg2vj1QJppIbEudxfFr1to25vnqE23F
	QqwiihxW2ZBp9uiJ/XFmJMMlw+6BhYT7OmsDhGIe3P0t/gpxmJJw7SHyLlyzLl/TAk22oKd8r6HfV
	47j4BKAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpALp-00GrbK-Ee; Mon, 22 Nov 2021 14:31:21 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpALm-00GraO-7m
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 14:31:19 +0000
Received: by mail-wr1-f46.google.com with SMTP id d5so33121277wrc.1
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 06:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NOpI29WK93kPIoQN+4npStzaJDQP3VzNREpVcUJTXwI=;
 b=EZUbrUV6CLENa03gi/EYrCsFKcJekAX0OzvhNrURVT5IBZf9f5nHTKTvlUAjEjWKEZ
 VFTF7ZXI5BxJnm0wUjTQzYBcQqWodf2HP5qrs+HOw7Jg6rC2nYa4rD7VVJaMYncZW40Y
 NCpcBwumpqNSuv8vi/rqPQur8yaxVpIr2JOg9288siSC1qXebO6oEKB6zZXBc60FGNUx
 2/Ej8bbpM1Ix/PKuKGUIUd0B7OjOcyApUQKFXZxsFBCHtUb1Hm1ocACMdfH06moT3NLC
 L8eZUzsK6sv8h+P7YPhBtg5GQPRYKjvBlLclBu43ups1FREDfvi0t3+erutUIKm+WXCs
 V1MQ==
X-Gm-Message-State: AOAM533YhAEmNPF0tGkREbGGgA4PyCpE1NxkWqChxPucjDPpblsk+NUV
 xIZZrX75KYuxt00YTBtsoVE=
X-Google-Smtp-Source: ABdhPJx3q5pqRSYEpp0EUSXAYEjgOp7ZwMBhmfiocfElS4LJr62IrLXfEQybOL8EzHGD3G34nBAdbw==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr40733574wrd.33.1637591475370; 
 Mon, 22 Nov 2021 06:31:15 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g6sm12354677wmq.36.2021.11.22.06.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 06:31:14 -0800 (PST)
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <20211122074727.25988-11-hare@suse.de>
 <762ce404-9035-30ca-078d-eb0b36223e4c@grimberg.me>
 <313b19d2-ea54-ce1c-f9cb-3f1fb6743787@suse.de>
 <891fe077-40d3-5bad-52fb-f0ee6f6107b6@grimberg.me>
 <f7011868-4542-bd09-6d44-3aaa192a9212@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <27432703-8e83-10c0-c428-090e6ec4b9af@grimberg.me>
Date: Mon, 22 Nov 2021 16:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f7011868-4542-bd09-6d44-3aaa192a9212@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_063118_301631_9FA6766B 
X-CRM114-Status: GOOD (  16.19  )
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


>>>>> +    if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
>>>>> +        if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
>>>>> +            /* Restart negotiation */
>>>>> +            pr_debug("%s: ctrl %d qid %d reset negotiation\n",
>>>>> __func__,
>>>>> +                 ctrl->cntlid, req->sq->qid);
>>>>> +            if (!req->sq->qid) {
>>>>> +                status = nvmet_setup_auth(ctrl);
>>>>
>>>> Aren't you leaking memory here?
>>>
>>> I've checked, and I _think_ everything is in order.
>>> Any particular concerns?
>>> ( 'd' is free at 'done_kfree', and we never exit without going through
>>> it AFAICS).
>>> Have I missed something?
>>
>> You are calling nvmet_setup_auth for re-authentication, who is calling
>> nvmet_destroy_auth to free the controller auth stuff?
>>
>> Don't you need something like:
>> -- 
>>          if (!req->sq->qid) {
>>              nvmet_destroy_auth(ctrl);
>>              status = nvmet_setup_auth(ctrl);
>>              ...
>>          }
>> -- 
> 
> nvme_setup_auth() should be re-entrant, ie it'll free old and reallocate
> new keys as required. Hence no need to call nvmet_destroy_auth().
> At least that's the plan.

OK, I see.

> Always possible that I messed up things somewhere.

Worth checking with kmemleak but it looks ok to me.

