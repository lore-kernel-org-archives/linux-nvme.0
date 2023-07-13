Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36652C001DC
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iPR1yMWcnyOiGmafPtw2/cYgBmCNFxdYca8sNpEDilo=; b=fIdvlkr6rFUZuUgcVVS3wADTgr
	rNx3myHLgUpVtUICmRinh6gDcH6Zm15a8cnDAUOp4sh7iyJYFb05mtpcblJljLOZwGv0YJAxtkWWw
	jJ+BDOtIz561IRAWlvkZXkwUQnIom1QUgLQPOuHthdVGFqGprcT7yo56iDwu4onb4TQekZPcl+Qf9
	RtBfjbjansB6xvxra6RECEJ9fJF8L0h0yNTlYBo2YYmt9wtNNj3x9CI19cahQ7SUnXZuatPCocZqE
	1XaVFh8TOas3xMg1ijVd2opjXwDExbH5RGB590qsSG47Ft6h6vkYudcyX/9daCTlYApceNxU3RIQL
	kONiVo0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJtIN-002lkS-1g;
	Thu, 13 Jul 2023 10:11:35 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJtIL-002lio-0j
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 10:11:34 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fa988809c0so919595e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 03:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689243090; x=1689847890;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPR1yMWcnyOiGmafPtw2/cYgBmCNFxdYca8sNpEDilo=;
        b=FNsE0fCUE3x1UhTskSGsghUuApvYxZu3Ybw0OajT0qvlh/Zs5sT5AmcgD1nGUVYGCm
         oZX/pY0DKI6Db9KD11t+8zYJ9IwadIOYM9V/Te0cljvN+QM13fb6R/pihExJ5h1tp/Xh
         Tn8xnMHus4/rZ6wiJoPs/ayVBBzoKU/v9seNjMknkak7HBpM1r7dWGmAqjGvOnt18j6k
         CeyM5Y5yHmbQvdDsMBmm8BHedXdtLmuwpbb46VvnBCpwembp5f9qIN5UkJgGJYIGjABC
         XeWBBTl/9z8nZdejXmlCkG+oCbvMncsOnV+TcpBEefFdJ9obrvOlVutn/LX1UGmzVLTk
         wQng==
X-Gm-Message-State: ABy/qLZKo8huc3LpqVON/FY6D0Wgg4ITTUoUvmg7A7uX+eg++rAgUNqH
	n4Y4hhBJTbEtb8+XjQ+Bvds++NEEqRY=
X-Google-Smtp-Source: APBJJlHSSOwWWcq5EnKi0HGVpp3whUMYunvm9+18uatw5jvZuogV3lrMw4sMRIzHpNVOkOhyf5vxaw==
X-Received: by 2002:adf:dd8a:0:b0:313:dfa5:291c with SMTP id x10-20020adfdd8a000000b00313dfa5291cmr957156wrl.7.1689243090288;
        Thu, 13 Jul 2023 03:11:30 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y18-20020adffa52000000b00313f031876esm7493988wrr.43.2023.07.13.03.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:11:29 -0700 (PDT)
Message-ID: <9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
Date: Thu, 13 Jul 2023 13:11:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
 <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
 <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
 <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_031133_263342_84A4E0FA 
X-CRM114-Status: GOOD (  18.52  )
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


>> skbs are unrelated to the TCP window. They relate to the socket send
>> buffer. skbs left dangling would cause server side to run out of memory,
>> not for the TCP window to close. The two are completely unrelated.
> 
> Ouch.
> Wasn't me, in the end:
> 
> diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> index f37f4a0fcd3c..ca1e0e198ceb 100644
> --- a/net/tls/tls_strp.c
> +++ b/net/tls/tls_strp.c
> @@ -369,7 +369,6 @@ static int tls_strp_copyin(read_descriptor_t *desc, 
> struct sk_buff *in_skb,
> 
>   static int tls_strp_read_copyin(struct tls_strparser *strp)
>   {
> -       struct socket *sock = strp->sk->sk_socket;
>          read_descriptor_t desc;
> 
>          desc.arg.data = strp;
> @@ -377,7 +376,7 @@ static int tls_strp_read_copyin(struct tls_strparser 
> *strp)
>          desc.count = 1; /* give more than one skb per call */
> 
>          /* sk should be locked here, so okay to do read_sock */
> -       sock->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
> +       tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
> 
>          return desc.error;
>   }
> 
> Otherwise we'd enter a recursion calling ->read_sock(), which will 
> redirect to tls_sw_read_sock(), calling tls_strp_check_rcv(), calling 
> ->read_sock() ...

Is this new? How did this pop up just now?

> It got covered up with the tls_rx_reader_lock() Jakub put in, so I 
> really only noticed it when instrumenting that one.

So without it, you get two contexts reading from the socket?
Not sure how this works, but obviously wrong...

> And my reading seems that the current in-kernel TLS implementation 
> assumes TCP as the underlying transport anyway, so no harm done.
> Jakub?

While it is correct that the assumption for tcp only, I think the
right thing to do would be to store the original read_sock and call
that...

