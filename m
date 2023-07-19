Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D3C001DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iibJZf1MO5qf9sqGK5FjYmeBRCfxvOFvuqnNYLw9dxA=; b=yhzTJKTspd8QxTdKX00mNWM2wJ
	QItE1uLUwffjnyZL3j8/p6bBrj5Xpd31GINmnWjJCtQU6s8i0m99hMmyHrboDXYWIumtos1qVH3Vo
	dq/Z685G2b2m7aG9c4zXoQ7+7bmhnHL7jIMxIDAgRcJ1OqXkTxG6x5nvM/ztoiLLsRm74j7R8KJXL
	rX6tZS0P6u0zM1KmMrofZxFcM6zUbN2h06os5LhNJYgCIsTAzPewD2PPXFP2Hr/9RjqM1+p9i5Zj9
	FjpR0pqyVytGJZFqZnQHhHknoZyBlhktRUpwXz9F4fAegJM6mm/SKxa/l/RTbCszmIYxIADlkwFLj
	5ywabmnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5lJ-007KWS-10;
	Wed, 19 Jul 2023 11:54:33 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5lG-007KVZ-2H
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:54:31 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3159adb7cb5so1636498f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jul 2023 04:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767667; x=1692359667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iibJZf1MO5qf9sqGK5FjYmeBRCfxvOFvuqnNYLw9dxA=;
        b=YpYX2KsqpbMXd0B/ESS2Wpzb8ahhK/knA2DxDPbbXfNFHAN2Z/gtxoGpVArD0EU5AC
         T3gDo9cCo2YgPnIy9osaaR0eHGJ7XWS3ypBz2dCnaBEH21XWMB+scBGbsTlnpU5QEvBp
         IUOD0aZrp2oX0CwmayjKsw+8xKbvoeNvyer+hktY/g2e9n1EWIo7k5UVhjQowkP08ZFt
         1ieniz+SLlBx/tWuHEkSc4LdWywQCk1b6858jvJ/77OYCTmjm8YxBGcvpcSLW+0RKTjx
         /gwU9GxxBcOVDr1TVUauaZXkCchxmlCG5KzU+kpQSFtHh0vJfJPey7uEYThF8G5/SzcC
         xs2A==
X-Gm-Message-State: ABy/qLZpqc8CIM8slZimojpuUhty2kd1AvdABoavaNLtObhakaH5Kuyo
	sclGKX23/9ECPBbNk0s/M1c=
X-Google-Smtp-Source: APBJJlH76eIThhwx3BP0l3BGhULMnlpurLoS8TeSckHEAp0cIa9HBdeAS+mUAcNet9mJCEs04RomaQ==
X-Received: by 2002:adf:fc09:0:b0:313:e8fb:b00f with SMTP id i9-20020adffc09000000b00313e8fbb00fmr2267945wrr.6.1689767666572;
        Wed, 19 Jul 2023 04:54:26 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6411000000b00314145e6d61sm5173631wru.6.2023.07.19.04.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:54:25 -0700 (PDT)
Message-ID: <ce600dd6-90c2-6a4d-48df-02152174ad51@grimberg.me>
Date: Wed, 19 Jul 2023 14:54:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
 <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
 <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
 <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
 <9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
 <a77cd4ee-fb4d-aa7e-f0b0-8795534f2acd@suse.de>
 <20230718115921.4de52fd6@kernel.org>
 <8d866cf2-df52-5085-f0d4-864d15b8667d@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8d866cf2-df52-5085-f0d4-864d15b8667d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_045430_760296_1C1E2386 
X-CRM114-Status: GOOD (  19.94  )
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


>>>>> And my reading seems that the current in-kernel TLS implementation
>>>>> assumes TCP as the underlying transport anyway, so no harm done.
>>>>> Jakub?
>>>>
>>>> While it is correct that the assumption for tcp only, I think the
>>>> right thing to do would be to store the original read_sock and call
>>>> that...
>>>
>>> Ah, sure. Or that.
>>
>> Yup, sorry for late reply, read_sock could also be replaced by BPF
>> or some other thing, even if it's always TCP "at the bottom".
> 
> Hmm. So what do you suggest?
> Remember, the current patch does this:
> 
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
> precisely because ->read_sock() gets redirected when TLS engages.
> And also remember TLS does _not_ use the normal redirection by 
> intercepting the callbacks from 'struct sock', but rather replaces the 
> ->ops callback in struct socket.
> 
> So I'm slightly at a loss on how to implement a new callback without 
> having to redo the entire TLS handover.
> Hence I vastly prefer just the simple patch by using tcp_read_sock() 
> directly.

I think this is fine. The tls parser is exclusive to the bottom socket
being a tcp socket anyways, read_sock() was by definition until Hannes's
patch 6/6 always tcp_read_sock. So this is a valid replacement IMO.
I don't think that it is worth the effort to "prepare" for generalizing
the tls parser.

