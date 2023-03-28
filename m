Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EC7C77B6D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UpCifbAQFmnrwNJzCRQqXbs9XH+eML8HHz8+PQTc/B4=; b=QSy/VIsvKPUdz043fx4xWxIS3k
	e3omV4cIhwdfgJRYGxQXFLsvfslfrWM9HlUXDU1R1KPXDXjFdaV4DWqouVDnbqIf5FAIa4bKfE4Ah
	4c5TpIEGSi43KhOGhvcTRmuF8GC6GAReil3EcGTOJ7shDvQESwf8VzaAWbrcDkC45RCiXdhMujH9t
	FqY3ollU9F0kxP0R5MAnwjkAcvvbKuPiwkygU1V6K8sZuhh1BYPVgZCS47+CGdeJ+h0WkqUgjVz86
	oKKOJoVjyqN5Nvwx8rMk26I3fCySo2o7Q3UwBR14OpVzR5RKHyHJ0s8T5LWsBC8jtsYqWXR59nZ1U
	jFBETEsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph5rP-00Dn5v-0w;
	Tue, 28 Mar 2023 09:43:23 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph5rM-00Dn53-1B
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 09:43:21 +0000
Received: by mail-wm1-f49.google.com with SMTP id u1so6507469wmn.5
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 02:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996598; x=1682588598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpCifbAQFmnrwNJzCRQqXbs9XH+eML8HHz8+PQTc/B4=;
        b=1+mIgI0MA0oTAk3wcyI26fqOafp/QLkfhcUWI4gNczuMFi8q3ByBsHtKZi3il8KBsc
         ZMJn4cNevKdG6UHVBJfCn9t5siYKtDddvoV5Cz+IQLtK9RFJYFC9jMOw0yJXsBOfRznW
         p/svYugAR8MbOHArmHS0p7hAVZ5HyXY0wRNpj49zuDFy4ykDAXpCV6d1Y9wSzZ66JZr5
         E6Lv78wOLh0WeoziS2k0g3KACnDm/iwk0CKHNmX/FnOap/+5iGsqWufyp8EB1MYazww7
         wF9yz1evkBZuksCBinPPaa35cOsa+3k5bqh7eSxlrG+ccpuirfEMBSLl0zxJ1Dr5oL9W
         a+Dw==
X-Gm-Message-State: AO0yUKWd7VhLjUDbD48qt9lchYLFexWsATp6jUAMNm1I/Cmzy5alNny3
	ErRV73/B37NIk/9N3h8KSUM=
X-Google-Smtp-Source: AK7set/rCJ0qGQGvAy44YkfwAdUspx7k76llslWAzbJ24bdJ3F8akoOKnTMhuktllVt1cevz2rmsJw==
X-Received: by 2002:a05:600c:1d1f:b0:3e9:b564:fae4 with SMTP id l31-20020a05600c1d1f00b003e9b564fae4mr12895102wms.0.1679996597804;
        Tue, 28 Mar 2023 02:43:17 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b003ef6ceedf14sm7796484wmb.38.2023.03.28.02.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 02:43:17 -0700 (PDT)
Message-ID: <3962f9d9-2ee0-2065-827f-ca0cda881271@grimberg.me>
Date: Tue, 28 Mar 2023 12:43:16 +0300
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
 <8d0ddb2d-0b4e-e782-6507-a1d61b5d53f4@grimberg.me>
 <8fa65f04-7e82-77a6-00de-f51d20138ece@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8fa65f04-7e82-77a6-00de-f51d20138ece@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_024320_406325_FD8DDB79 
X-CRM114-Status: GOOD (  18.61  )
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


>>> But there might be the odd case where the data_ready
>>> callback is invoked after kTLS has been started but before
>>> we're setting it to nvmet_tcp_data_ready().
>>
>> What does nvmet_tcp_data_ready has to do with it?
>> You are changing nvmet_tcp_listen_data_ready.
>>
> This is not a 'race;
>>> Then we cannot guarantee that sk_user_data really is set
>>> to the 'queue' pointer, so we should skip the function.
>>
>> nvme_tcp_listen_data_ready was invoked, then sk->sk_data_ready
>> is nvme_tcp_listen_data_ready. Are you referring to the case
>> where the callback has changed before the read lock ?
>>
> No. The callback is changed when the userspace daemon starts ktls, as
> that will set sk->sk_data_ready to tls_data_ready().
> 
> So before the userspace upcall we have the chain:
> 
> sk_data_ready -> nvmet_tcp_listen_data_ready()
> 
> and after a (successful) upcall we have the chain
> 
> sk_data_ready -> tls_data_ready
>    -> nvmet_tcp_listen_data_ready()
> 
> once we set our callback we have
> 
> sk_data_ready -> nvmet_tcp_data_ready
>    -> tls_data_ready
>      -> nvmet_tcp_listen_data_ready
> 
> Calling into nvmet_tcp_listen_data_ready() is pointless here,
> but we cannot remove the callback either. So we should to deactivate
> it to avoid any side effects.

Thanks for the explanation.

First, I would like to understand how is this different from
svc.

Second, we don't want nvmet_tcp_listen_data_ready keep being
called from the datapath, especially as it is taking a read
lock, for absolutly no good reason.

Why don't we restore the original socket callback before
we trigger the handshake? then we wait for the handshake
to complete, and then store nvmet_tcp_data_ready once it
is done?

