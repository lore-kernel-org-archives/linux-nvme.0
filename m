Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A48C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xAhAouquoLXV6R1b7M9GsqTyZGR2tDdw2bAIY7nozZ0=; b=D88nJeJVwTUgjSVvoir9vuILat
	8aGM1Pus88nyX2B6OH/czbt7Ey4CKZXaobN443gxocX8WYRp3x3b6G/jzF7+3Xn9FIna5MxGDdr2E
	y2C8n9kKJDC58ePsmXf6/8I1dk+TkJWBBBAnMrrTX0UzqM8kZz7OPU0y031zm4EygBEXf4fMG+jJq
	TVrhCDctdx7ta9gSvmXTJ0cjAiGvPPZNTfzjjS/yQwZgstQoPmIrdWjf1RC/4d7btMMOjWUZ4j1M9
	3wMXEOQuw+ICTx+vFHYvsckxsdTy9eXZ78syVkP5ZvcLhQQf5DcRlDsZ+9MQHol9WCff15n9m/EK5
	TVMPFFrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phPNV-00GokL-0H;
	Wed, 29 Mar 2023 06:33:49 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phPNQ-00Goiw-1t
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 06:33:47 +0000
Received: by mail-wr1-f51.google.com with SMTP id l27so14503111wrb.2
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 23:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680071620; x=1682663620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAhAouquoLXV6R1b7M9GsqTyZGR2tDdw2bAIY7nozZ0=;
        b=p4K+AlhZds4bhGdeNbPHbeolNUrmEhl7J7UfrOmoWy5x5SU8+F0C1mLhXLgrhlXN6b
         0VHb2zEWeysLsEN6qIVz//c/9IEXqZUmz/lqfxUrylJz+KUlDHeBu+eX7bizHJUXllxF
         mH8fsyepFxk3MIIHVvscAN5PMaxguBuiGb4LeE5rFsj0PlotajKflj3JnHfIrAO2OHnb
         QZ+aLk5GAozh4oNRxkRoMa23cgIiDhuSbF+c5v10J9zWoA6BcSa0G14k77WYM1I8y5Om
         T6gzpPpM9c+AQhJI96lXaBvrUh0WuPjSZGKsGoTivE3+HZqtwmiAnf5Mi4R5TyqSzUqF
         4sjQ==
X-Gm-Message-State: AAQBX9crIwrBnifczk02V1Nh0EUH2xGZ4snDjhhbjhzF+nJFBxzr6PEq
	KDlNZS48WMKVHAr3Pc91Bv17W0bml+c=
X-Google-Smtp-Source: AKy350bKAaWQWL36mC2fobfHZo1TgHqc+fSziiD8J6vO6IJkvHSjcOwu6E/aiV7GatuqMNZgh/hppw==
X-Received: by 2002:adf:ec82:0:b0:2c9:993a:f4cd with SMTP id z2-20020adfec82000000b002c9993af4cdmr10884133wrn.1.1680071619918;
        Tue, 28 Mar 2023 23:33:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b002cfe0ab1246sm29337299wrt.20.2023.03.28.23.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 23:33:39 -0700 (PDT)
Message-ID: <cac91fc0-ab9f-ab35-fb74-1e3dcbf3eecc@grimberg.me>
Date: Wed, 29 Mar 2023 09:33:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
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
 <ea181844-69f5-66eb-e64e-e9871916532b@grimberg.me>
 <3ad50302-6b3c-6d6a-669e-0b11c2df6a6b@suse.de>
 <c9b5bb2d-89d7-8805-6d60-2c53e13f5d58@grimberg.me>
 <7c3da604-251f-209e-db6d-d1bee5a838c5@suse.de>
 <8d0ddb2d-0b4e-e782-6507-a1d61b5d53f4@grimberg.me>
 <D2384BEF-CE08-4CC6-95C2-F5E6726E0970@oracle.com>
 <6350ad42-d6ab-b244-6bdd-9830c11fb1ea@grimberg.me>
 <D37E71E9-06C0-467A-A653-9F1B968590AA@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <D37E71E9-06C0-467A-A653-9F1B968590AA@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_233344_625191_5B7B3FA9 
X-CRM114-Status: GOOD (  22.32  )
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


>>>>>>> As the callbacks will be changed once TLS is activated, and we really should not attempt to run if sk_data_ready() points to another function,
>>>>>>> as then the sk_user_data pointer will most likely be changed, too,
>>>>>>> causing all sorts of issues.
>>>>>>
>>>>>> Umm, something is unclear to me. if nvmet_tcp_listen_data_ready is
>>>>>> called doesn't it by definition mean that sk->sk_data_ready ==
>>>>>> nvmet_tcp_listen_data_ready ?
>>>>>>
>>>>>> Are you talking about a situation where between
>>>>>> nvmet_tcp_listen_data_ready is starting and until the
>>>>>> sk->sk_callback_lock the data_ready cb (and the user data
>>>>>> pointer) is changed?
>>>>> No. Far simpler:
>>>>> Starting kTLS will change the callbacks.
>>>>> So sk->sk_data_ready will point to our callback before
>>>>> the upcall, but to the kTLS version _after_ the upcall.
>>>>> It typically doesn't matter, as we're setting it to
>>>>> nvmet_tcp_data_ready() anyway.
>>>>
>>>> For ktls won't we set it to nvmet_tcp_data_ready only when
>>>> the handshake is done?
>>>>
>>>>> But there might be the odd case where the data_ready
>>>>> callback is invoked after kTLS has been started but before
>>>>> we're setting it to nvmet_tcp_data_ready().
>>>>
>>>> What does nvmet_tcp_data_ready has to do with it?
>>>> You are changing nvmet_tcp_listen_data_ready.
>>>>
>>>>> Then we cannot guarantee that sk_user_data really is set
>>>>> to the 'queue' pointer, so we should skip the function.
>>>>
>>>> nvme_tcp_listen_data_ready was invoked, then sk->sk_data_ready
>>>> is nvme_tcp_listen_data_ready. Are you referring to the case
>>>> where the callback has changed before the read lock ?
>>>>
>>>> I would like to understand why svc_tcp_listen_data_ready doesn't
>>>> have this race as well. Chuck?
>>> svc doesn't alter the pointer address in the listener's
>>> sk_data_ready field, and neither does kTLS.
>>
>> It is inherited from the parent socket sk. IIRC it is cloned in
>> inet_reqsk_clone.
> 
> Ah. I meant the changes to support the use of kTLS sockets do
> not alter this svc code.
> 
> 
>>> For a connected socket, when the handshake has completed,
>>> svc examines the socket for more work one last time before
>>> deciding it's idle (a kind of simulated data_ready). That
>>> should pick up work that arrived undetected.
>>
>> The question is how does a ktls socket never calls its inherited
>> sk_data_ready (svc_tcp_listen_data_ready), which according to Hannes'
>> explanation, should be the case if this socket was created as its
>> offspring.
> 
> Have a look at svc_tcp_accept(). It resets the inherited callbacks
> before setting up the socket.
> 
> svc_tcp_init() then sets sk_data_ready to our data_ready function.

Yes, I see.
When starting a listener, it saves inet->sk_data_ready in
svsk->sk_odata, and sets sk->sk_data_ready to svc_tcp_listen_data_ready.
then when accepting, it returns it to newsock->sk->sk_data_ready,

then only when adding the new socket, it sets sk_data_ready to
svc_data_ready...

This is what I agreed with Hannes, that nvmet reset the newsock
inherited sk callbacks, and only restore them after the handshake.

Thanks.

