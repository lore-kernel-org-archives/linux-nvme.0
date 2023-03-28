Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D79C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 08:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sq4nT9N0o2/zS2QXl0qJAFl4VFvJRq9f1jczWkHjikc=; b=1sjf7+bgDSyiQtvvWNduYAKahR
	UJjDu57QVG/Je5T1k0nrl+pLvgEklS/sesXf9lqit7Aav5McDAXy6iy5nQJO22xX1PkzO+wcxlDnA
	ndbUN82Dn2rmdN5E951f6qnqZ4wLnqHwwlTFKESh7ReKyfh3X8KRFlnbidFULJCixiMHkeYWwgylF
	nqUhpnxtIrfRuY7UegPppADin3e3Mpk9MrP3/GxxvxbKq6vlku3RE4XUu8OfGxs5cy9BYR81Xuwt/
	4ZtR5oijlIBQZJ9Zu2OaqstNh59QUNtDIesr18Qd/AKU8AX/urYau05ODt825kLplPAMi+in5nauj
	UaQkRwvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph4wo-00Dd4p-1L;
	Tue, 28 Mar 2023 08:44:54 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph4wl-00Dd3z-1D
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 08:44:52 +0000
Received: by mail-wm1-f43.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso563316wmo.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 01:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679993089; x=1682585089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq4nT9N0o2/zS2QXl0qJAFl4VFvJRq9f1jczWkHjikc=;
        b=KqFsUzSH4yJAGbK0yQ4w+7/2KsZ++o442RLQyEogZ69ptK4ZWApRyWxffEcMgdENXy
         4xVZksbM2XTtSUUF4ddJByFA9Ah5QQO02upJXAUlLJHfOx1z2jOwPqexZcLwwnQ5B3pN
         kaXu3lTTwcTTHryoEUTvm6L1zyv4qdxrusg/jItPihrQOCRw5fLV8Hxqejv4VgPqTR41
         5HoFnyawyAP+gOa3Iya6UuhJSvYaz8qyYx+W/hs56jDZ+NM3PUsurnKRfPo51NXdrXsq
         +GI04JwIKBqAmuecWgzhREnp8aP9SG+HPIMCRTD1yE6aPLmdqqtVz33obExSTPLKYC+t
         CdAQ==
X-Gm-Message-State: AO0yUKUiIEWNqNd3egN6C874RkM/3jMgaSaQ1cDTZ31shateuobL90Cx
	kzy4IFnDR6+oRRukx04UsmmecYg0Gio=
X-Google-Smtp-Source: AK7set90+VL5KGJqEfkzuoVdDH1wCYjC2mOUWPZnyVj88gw2HdB5CMhd3SdkphQZUwDaETD6aF9a4w==
X-Received: by 2002:a05:600c:470c:b0:3ee:7d85:e0d1 with SMTP id v12-20020a05600c470c00b003ee7d85e0d1mr12685587wmo.2.1679993089610;
        Tue, 28 Mar 2023 01:44:49 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c1c9600b003eda46d6792sm11548669wms.32.2023.03.28.01.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:44:49 -0700 (PDT)
Message-ID: <8d0ddb2d-0b4e-e782-6507-a1d61b5d53f4@grimberg.me>
Date: Tue, 28 Mar 2023 11:44:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
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
 <ea181844-69f5-66eb-e64e-e9871916532b@grimberg.me>
 <3ad50302-6b3c-6d6a-669e-0b11c2df6a6b@suse.de>
 <c9b5bb2d-89d7-8805-6d60-2c53e13f5d58@grimberg.me>
 <7c3da604-251f-209e-db6d-d1bee5a838c5@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7c3da604-251f-209e-db6d-d1bee5a838c5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_014451_411200_3B236F3C 
X-CRM114-Status: GOOD (  21.86  )
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


>>>
>>> Nearly there.
>>>
>>> The actual patch would be:
>>>
>>> @@ -2031,10 +1988,16 @@ static void 
>>> nvmet_tcp_listen_data_ready(struct sock *sk)
>>>          trace_sk_data_ready(sk);
>>>
>>>          read_lock_bh(&sk->sk_callback_lock);
>>> +       /* Ignore if the callback has been changed */
>>> +       if (sk->sk_data_ready != nvmet_tcp_listen_data_ready)
>>> +               goto out;
>>>          port = sk->sk_user_data;
>>>          if (!port)
>>>                  goto out;
>>>
>>> +       if (port->data_ready)
>>> +               port->data_ready(sk);
>>> +
>>>          if (sk->sk_state == TCP_LISTEN)
>>>                  queue_work(nvmet_wq, &port->accept_work);
>>>   out:
>>>
>>> As the callbacks will be changed once TLS is activated, and we really 
>>> should not attempt to run if sk_data_ready() points to another function,
>>> as then the sk_user_data pointer will most likely be changed, too,
>>> causing all sorts of issues.
>>
>> Umm, something is unclear to me. if nvmet_tcp_listen_data_ready is
>> called doesn't it by definition mean that sk->sk_data_ready ==
>> nvmet_tcp_listen_data_ready ?
>>
>> Are you talking about a situation where between
>> nvmet_tcp_listen_data_ready is starting and until the
>> sk->sk_callback_lock the data_ready cb (and the user data
>> pointer) is changed?
> 
> No. Far simpler:
> Starting kTLS will change the callbacks.
> So sk->sk_data_ready will point to our callback before
> the upcall, but to the kTLS version _after_ the upcall.
> It typically doesn't matter, as we're setting it to
> nvmet_tcp_data_ready() anyway.

For ktls won't we set it to nvmet_tcp_data_ready only when
the handshake is done?

> But there might be the odd case where the data_ready
> callback is invoked after kTLS has been started but before
> we're setting it to nvmet_tcp_data_ready().

What does nvmet_tcp_data_ready has to do with it?
You are changing nvmet_tcp_listen_data_ready.

> Then we cannot guarantee that sk_user_data really is set
> to the 'queue' pointer, so we should skip the function.

nvme_tcp_listen_data_ready was invoked, then sk->sk_data_ready
is nvme_tcp_listen_data_ready. Are you referring to the case
where the callback has changed before the read lock ?

I would like to understand why svc_tcp_listen_data_ready doesn't
have this race as well. Chuck?

