Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BE8C77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXD+1pLvjDPPuobphY8yfGqnMPmwxQgBLjCdfAbCRyU=; b=n+snKV52wHkDS6oZQYSIxThlsz
	TF9e//IA+TYJf9lun2db9OX4MjHr8Fz6TadcyNKkYPW8tpAANlD2ntU2nzf8UOAB5aywrznzoWm40
	ykTEzFbb9xCUOQQos4kTQznQ1cHEmVMNXNNOZXTaobc8Cp57HbJonOO2O6nAX/jx9Rw9YuVuNpoZA
	JE+fjJMHMmn5OlYkausKjsAA+SyZFvFns5aAEQs//gywImy61M6+xShqAC6gGErhHfIPuu+iTvjwT
	dz62KOq/5I/u5dZGpMdp0I9IAxPgh3SNbwrMlxfmPl4BWj1aNUdVakGJaadctK9kjYLXVSPXOOMdY
	erLzd9/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poiFi-001abP-1H;
	Tue, 18 Apr 2023 10:07:58 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poiFg-001aZT-0v
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 10:07:57 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f16f792384so5292515e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Apr 2023 03:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812470; x=1684404470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXD+1pLvjDPPuobphY8yfGqnMPmwxQgBLjCdfAbCRyU=;
        b=YOK67yIRLTaoXSTzPA/uMU3D2nvys+Jydv53sGhOZAjit/BePuuhC23GutrXls34va
         hKcZsF+V6fDETRub+P6HJ0bGCBfw0m+q/BUwGf3hj6emkK4Ixi8Bs7X81ydvjztwkiXt
         RhnlEmHxoRt40TOIi+CVhPzfu8X+3meD124OXbytKBZP9iuke2MMho3QfDhqwmsOeo7H
         4W9BIIBxmcHwOib/lM8w4txBz9tS3tw0UDP2XUwsbFjLdnACyhYoXnMMJUqvO6UTwoLM
         d6oqYVEXrhwRn0Ky8VKE+iBAkZ8X/jUm6zEd7jkf1WKahjjKatInNux7IlmFoYKEY6R5
         NZ6w==
X-Gm-Message-State: AAQBX9fzvC47SN8ShRWF0z4B3Rl1E1NFznfSAyWxsi+9+6VZsgOSOff+
	ewf1/cEUfZZjEcPPXHA5xxw=
X-Google-Smtp-Source: AKy350al4TY3coJfCg4xQzmLVS7diXcY/czD8cIPMmmxWy98wBFX8Uublt3Jgch/rSSZ5n/P5YBhtg==
X-Received: by 2002:a05:600c:1e12:b0:3f1:727f:1967 with SMTP id ay18-20020a05600c1e1200b003f1727f1967mr5688956wmb.4.1681812469701;
        Tue, 18 Apr 2023 03:07:49 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b003f173956a82sm5577668wmq.21.2023.04.18.03.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:07:49 -0700 (PDT)
Message-ID: <beb7b0e8-2cb5-0c0e-63f9-6a13b9dfb787@grimberg.me>
Date: Tue, 18 Apr 2023 13:07:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/18] net/tls: sanitize MSG_EOR handling
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-8-hare@suse.de>
 <20af9713-8d64-77de-dfbe-e9e732776d3c@grimberg.me>
 <20230417131048.66b6b3a0@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230417131048.66b6b3a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_030756_322267_2A5A3B68 
X-CRM114-Status: GOOD (  12.98  )
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


>>> The TLS stack is using MSG_EOR internally, so the flag cannot be
>>> set for sendmsg()/sendpage(). But to avoid having the caller to
>>> check whether TLS is active modify the code to clear the MSG_EOR
>>> flag. And blank out MSG_MORE / MSG_SENDPAGE_NOTLAST, too, as they
>>> conflict with MSG_EOR anyway.
>>
>> This looks like a temporary workaround to me.
>>
>> The networking folks really need to be CC'd on this (same for patch 6).
> 
> Thanks, when I said "we can support EOR" I obviously meant support
> not ignore it :(  No ack.

Obviously neither Hannes or I have sufficient tls knowledge to properly
support it... It needs to be done by someone who knows the
implementation.

Is this a large scope to add support for it? Because if it is, I'd
simply change nvme to clear MSG_EOR when tls is used (despite my
preference to not do special things for tls).

