Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA72AC77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rW08AcXe5h1yzwO/16VfGa8RMtIWOvyOCi3lznESrus=; b=gUeb0/5zSW46nHx0tNGdzV2hpy
	6K0B2PpYyj9PGArrGpDREXcY5wIR+clk038KgulcbKzKaniyzcqnTuLgHevQcAVWWJtJsOJUdrgOb
	01n0yYCAWKADyod6BKiNYNGpwbqn1vbwg8l8HFaQfJnhMOAmyjTtnxLIs1C+9V2KR/5yWl4RUwMiB
	RJDPWXIxwB/XyeTqp4lGzwzfXGFNwbL0v10uxxvghthaCCnAMl0j40M11MIfAfCvoxqKB9lrK6AUp
	st4lqJyURB4XSkzFKHkyI0uWbFleqfWMG/ddeFdRyZirEOgSez2Vs/kO+Cbtz8mCfW8fCAbFB77bE
	EUy7bGxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poPFz-00GU0c-1v;
	Mon, 17 Apr 2023 13:50:59 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poPFw-00GTzG-0M
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:50:57 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f16f792384so3001215e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 06:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681739453; x=1684331453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW08AcXe5h1yzwO/16VfGa8RMtIWOvyOCi3lznESrus=;
        b=G/YUqL5jUtqWucUfFJCRVmJCw23hj5lUSqdp2ebkyM5jE9cxLbadXMuRDNr0ZhgLMC
         apgBgzQyXTLPFbzQJDegS10zY9rk4tjvzrGDQXkcdS5c0CK0DGcnQiEB+UHCDrw31bcI
         iddfykKhRm/r7Iza5xx/YJ/24oO7MXjGgPDz0mnTT11mmKQ9x1yi6Tx/zPrxSHCoIjpw
         uqKOjXQynooPYxwlbTAAJAvuA5y0rQVdNvvzG/2byaObidDqzgLEMl8vj1o6wdFbEJb+
         icE4/X7Ky+ogBz5zgAW9UowMud88CaCzeqp7oUD34bF9nN9rBko4TbBHk5kkh/xAyHnA
         Eoag==
X-Gm-Message-State: AAQBX9d2y2nIRilt6MptJaaMuk3dHIgc5u5VeaRtfe/WWy/kYISwnx/8
	J402wVrO4wX9i/5M+WCl5WM=
X-Google-Smtp-Source: AKy350b1X6uGiq3uux1vDEuWjGbMRSgJevFg6hjeWvM+TsOvfsrYDWSWYdhSqBqqRF+8GiUVOXaing==
X-Received: by 2002:a05:600c:6025:b0:3f1:75a5:a369 with SMTP id az37-20020a05600c602500b003f175a5a369mr1310893wmb.3.1681739452680;
        Mon, 17 Apr 2023 06:50:52 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g12-20020adffc8c000000b002f79ea6746asm7582944wrr.94.2023.04.17.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:50:52 -0700 (PDT)
Message-ID: <ffb33351-e26b-470e-9849-e195d9b05b52@grimberg.me>
Date: Mon, 17 Apr 2023 16:50:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 18/18] nvmet-tcp: add configfs attribute 'param_keyring'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-19-hare@suse.de>
 <60ff89b4-5d63-a6db-18b1-e0f28055c5d9@grimberg.me>
 <c7e895f1-1c95-f658-f7a1-c4cee5cf8c91@suse.de>
 <1b018791-9aa3-b988-7045-40b46bc50989@grimberg.me>
 <02e4f6eb-32c2-8f3c-872f-831e70da6166@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <02e4f6eb-32c2-8f3c-872f-831e70da6166@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_065056_145916_035FCCB8 
X-CRM114-Status: GOOD (  14.05  )
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


>>>>> Add a configfs attribute to list and change the default keyring.
>>>>
>>>> is the keyring an attribute of a port? or a subsystem? Why the choice
>>>> of making it per port?
>>>>
>>> As per discussion at fmds each port might want to use different 
>>> credentials.
>>> We can move it to subsystems if we decide we don't want to support 
>>> that use-case.
>>
>> I think we should move it to the subsystem in Linux.
>>
> Easier said than done.
> 
> We can only fetch the subsystem once we have the NQN, which we will
> know after the connect command.
> But out of necessity the connect command will only be transferred
> after TLS handshake completed, so there is not subsystem NQN allowing
> us to figure out the correct subsystem.
> 
> So we'll have to keep it at the port level, I'm afraid.

Question, why does nvmet needs to support user defined keyrings?
I understood your argument for the host, but why should the target
support it?

