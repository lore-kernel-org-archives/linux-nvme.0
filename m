Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20D6C77B62
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qexeKim1ZlEK1Dz+xS1G2ct6jCCGIXB+0tiAHlwj1VM=; b=Lq1KKBymrm764FfzKHbl8Xs0uk
	VdO/ZS1EbVv0KA45Oswsm8nB+Dq9CE7aRkp+puSZbhV+kt3MFPACiPIc77iJn+OvqNGa9irY4imT1
	QV5lc29CJrzTmXTEuvMNjDRG9WuW0EdMD9yROXBkS09jM1zZici1Lc25Oa3EIxXXDdDjYBIxf2WwB
	FMI+qSPz2dznANS6BvqPYrFGQ10OQX/z2Sefkxp9j3IZnCysHcxNMiSdFK7Pj/gkNNfUoW2kduk4/
	q51KKi6IhOimUO858n3IbPkb7mnMnLUpgjmgFkCDOYqHJW+yv2OgXN+35do5n4tgZa2P3dynHkRf9
	p1hBYSLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phBGV-00EwRn-3A;
	Tue, 28 Mar 2023 15:29:40 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phBGT-00EwQs-1G
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 15:29:38 +0000
Received: by mail-wr1-f52.google.com with SMTP id t4so7423476wra.7
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 08:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017373; x=1682609373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qexeKim1ZlEK1Dz+xS1G2ct6jCCGIXB+0tiAHlwj1VM=;
        b=Hv4dcU8X4fk190eSm5oO8Rya3Ss85ArO9GJ/mq+jlnFo//zU6Vj1i+QJ35+NKIvEhd
         DBvAQ1jOatQgHYBb2+SRrVvHmn1NrpwoAb7MLlKSYwB0ck5gtXNnRd3Zmp6AxasuRVXh
         FnSPtxdxf7Y/v7tPAtWcrKPizL202ocNrbOT0xPKxv8ioDXp5IUkgHmWhJqUtnAJhL4d
         Ep0MejgaaifNXuQ4wb6ahz4bOJU+At+gPHlKHRLoeeO9XWQKjIN9FhFkAI539H68RZD0
         SOQNYvlVDOzLHwgupbGqkJVUbS4s4c6vfdzOxB0AKvvlO/pfbOac4SV7kYXXCaILfKkv
         Pmdw==
X-Gm-Message-State: AAQBX9ehgeMQgKDMALjqKJlJ/7elB+vIExNC9RgL1LlOrDUQ1XB794VB
	TQyRcVOqc+AoL7auzkdtArD6vJV5tq4=
X-Google-Smtp-Source: AKy350b0CMmJ6FjSU5ZNkToc1NWn0FhMTu9hxkGdLkaDMndAUxm8kRaaKwW1PmfbC0q50pHt8f5/FQ==
X-Received: by 2002:adf:e60a:0:b0:2c7:175e:e201 with SMTP id p10-20020adfe60a000000b002c7175ee201mr8716190wrm.1.1680017373082;
        Tue, 28 Mar 2023 08:29:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000181700b002c5694aef92sm27798980wrh.21.2023.03.28.08.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:29:32 -0700 (PDT)
Message-ID: <6350ad42-d6ab-b244-6bdd-9830c11fb1ea@grimberg.me>
Date: Tue, 28 Mar 2023 18:29:31 +0300
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <D2384BEF-CE08-4CC6-95C2-F5E6726E0970@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_082937_426046_FD52823A 
X-CRM114-Status: GOOD (  19.67  )
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


>>>>> As the callbacks will be changed once TLS is activated, and we really should not attempt to run if sk_data_ready() points to another function,
>>>>> as then the sk_user_data pointer will most likely be changed, too,
>>>>> causing all sorts of issues.
>>>>
>>>> Umm, something is unclear to me. if nvmet_tcp_listen_data_ready is
>>>> called doesn't it by definition mean that sk->sk_data_ready ==
>>>> nvmet_tcp_listen_data_ready ?
>>>>
>>>> Are you talking about a situation where between
>>>> nvmet_tcp_listen_data_ready is starting and until the
>>>> sk->sk_callback_lock the data_ready cb (and the user data
>>>> pointer) is changed?
>>> No. Far simpler:
>>> Starting kTLS will change the callbacks.
>>> So sk->sk_data_ready will point to our callback before
>>> the upcall, but to the kTLS version _after_ the upcall.
>>> It typically doesn't matter, as we're setting it to
>>> nvmet_tcp_data_ready() anyway.
>>
>> For ktls won't we set it to nvmet_tcp_data_ready only when
>> the handshake is done?
>>
>>> But there might be the odd case where the data_ready
>>> callback is invoked after kTLS has been started but before
>>> we're setting it to nvmet_tcp_data_ready().
>>
>> What does nvmet_tcp_data_ready has to do with it?
>> You are changing nvmet_tcp_listen_data_ready.
>>
>>> Then we cannot guarantee that sk_user_data really is set
>>> to the 'queue' pointer, so we should skip the function.
>>
>> nvme_tcp_listen_data_ready was invoked, then sk->sk_data_ready
>> is nvme_tcp_listen_data_ready. Are you referring to the case
>> where the callback has changed before the read lock ?
>>
>> I would like to understand why svc_tcp_listen_data_ready doesn't
>> have this race as well. Chuck?
> 
> svc doesn't alter the pointer address in the listener's
> sk_data_ready field, and neither does kTLS.

It is inherited from the parent socket sk. IIRC it is cloned in
inet_reqsk_clone.

> For a connected socket, when the handshake has completed,
> svc examines the socket for more work one last time before
> deciding it's idle (a kind of simulated data_ready). That
> should pick up work that arrived undetected.

The question is how does a ktls socket never calls its inherited
sk_data_ready (svc_tcp_listen_data_ready), which according to Hannes'
explanation, should be the case if this socket was created as its
offspring.

> Maybe I'm missing something?

I don't know yet.

