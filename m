Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8689BEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WSJ7njo1frNB2wbznmgMSd/7sKrygugYA+ScAa+ssjk=; b=M5X6PkGx9ugPA8nH6ZKHXnlbq9
	HqVuaTffLoXexamtfVYf/T/PNbLgZzPM5Hz8ca6whGkP73LMh5nKkgOsLCZXnwYup7QHM5b/q3IWZ
	J531EPjDZVAbLYsAh5QVzObUlXCgmPPXc+EhzGmhCZrsLmovMfbve19+3OfNhBs/nMpy4TbvaDAFA
	oHoRUC1nsntnPRNBm8Z1sZbL/JPFeeME60UfU4U0wcXUo2vOhLRjW1AkwHchiV2rc6WXQudQr/9bw
	iwFdtnV84dbiyTg4w/3Or12Ngz4Jca16fJOwmGCnHUMMDbMdaLgMVXM+qZiZR4vrAW2FqqqMnQGtr
	RG7EGHPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJoi-00Af8P-0v;
	Mon, 03 Jul 2023 13:42:12 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJog-00Af7c-0b
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 13:42:11 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-313f5f5c6c3so1390329f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 06:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391725; x=1690983725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSJ7njo1frNB2wbznmgMSd/7sKrygugYA+ScAa+ssjk=;
        b=l2YRXNeo43OAkjQkhi+7K95rkRVRljTstw/O5yCohxz0GHEXRYunHdilRGTILYS1Ju
         JeV4EWM7/1zcz/wuLaUwtjMYLHyeYiVVxVwKhZ1Hn8y0QXAjTWHJiUeG4h92Gl62ZkHf
         sQYdqbXWOCljqAKa5b3ii6tXhINE4CtZTG0zCXsnnbo7qtja9RXwPvEJ3HoU8qgWOjF+
         AQ3leKfTAtZvz7gIJimGsccz8zt4AremTDCAPQ7wKTUhrORaXLq2H5UaCaUn4BiBUhCE
         CXRWdpT/JolM3oGt547005T1XZCC8XWlv4rj4MPBxw3eMtPcDnI+eMqDUNKG7fudy/aV
         WaZQ==
X-Gm-Message-State: ABy/qLYmZfYd9xfkObUYSBV/lrb5Uen7+2iTdidhEQVxNS0RQv2Z1dYL
	Ns11hEURDmdyDPr7fX+NGhc=
X-Google-Smtp-Source: APBJJlEmmmyuCovPziLK3HGeeAZFgTUR1+KeDjKK+DIWyKksv8HpLzKMWjOoJPla9nYz1yDcHNlMXw==
X-Received: by 2002:adf:f504:0:b0:313:e20c:b8e1 with SMTP id q4-20020adff504000000b00313e20cb8e1mr9320754wro.7.1688391724867;
        Mon, 03 Jul 2023 06:42:04 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b0031424950a99sm8432273wrp.81.2023.07.03.06.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:42:04 -0700 (PDT)
Message-ID: <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
Date: Mon, 3 Jul 2023 16:42:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
 <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
 <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_064210_250596_0A740E5C 
X-CRM114-Status: GOOD (  18.21  )
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


>>> Hannes Reinecke <hare@suse.de> wrote:
>>>
>>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>>
>>> Can you be more specific about the crash?
>>
>> Hannes,
>>
>> See:
>> [PATCH net] nvme-tcp: Fix comma-related oops
> 
> Ah, right. That solves _that_ issue.
> 
> But now I'm deadlocking on the tls_rx_reader_lock() (patched as to your 
> suggestion). Investigating.

Are you sure it is a deadlock? or maybe you returned EAGAIN and nvme-tcp
does not interpret this as a transient status and simply returns from
io_work?

> But it brought up yet another can of worms: what _exactly_ is the return 
> value of ->read_sock()?
> 
> There are currently two conflicting use-cases:
> -> Ignore the return value, and assume errors etc are signalled
>     via 'desc.error'.
>     net/strparser/strparser.c
>     drivers/infiniband/sw/siw
>     drivers/scsi/iscsi_tcp.c
> -> use the return value of ->read_sock(), ignoring 'desc.error':
>     drivers/nvme/host/tcp.c
>     net/ipv4/tcp.c
> So which one is it?
> Needless to say, implementations following the second style do not
> set 'desc.error', causing any errors there to be ignored for callers
> from the first style...

I don't think ignoring the return value of read_sock makes sense because
it can fail outside of the recv_actor failures.

But to be on the safe side, perhaps you can both return an error and set
desc.error?

> Jakub?
> 
> Cheers,
> 
> Hannes
> 
> 

