Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14330C77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nrtmfxt4yfxLY2UVAqI6rteBQZPnotIboHiGgYaz1iU=; b=D1UCFVRMWh0ySFIW0xGO+p94bm
	difIbw8YUCI/MT1j9q/mKp9JhC/1GYQpfu9XVNnPMggqKRQXgagOXqffS37leCpwaqGTlWhWByTaD
	IGmlpYfLnxn4OgW6BDxgRBK1WPhSsNCtkItXy/NxY0RXewDUhhKJbJ9HGfBUFKF/gpGpTeMjMJNRt
	ljfRr+9WJTnF0HNYpJes++j1Nniq+4lxYcya8qtm0V1Y2bAL0dOlvzGADsvaAcvObrwSFJKCw4wC0
	ihz0nN/FeGFDl4kn+3wOVc0EDn8sdLIO4FACbFcb9AjjiD3KaaiVFLXXhN9C8eSAgIeUmwV/ybXxz
	Z+5Dx2yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzHIt-00A0AN-2k;
	Wed, 17 May 2023 13:34:55 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzHIq-00A08P-2t
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 13:34:54 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so1148718a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684330489; x=1686922489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrtmfxt4yfxLY2UVAqI6rteBQZPnotIboHiGgYaz1iU=;
        b=dsLRMtC7bgsZ9K1/TGjOhMOvRp4l/usk0IYXRgra68RoVwo4q6Kas1pEZQBYoHuxYS
         1tJ+GUSs8vXwv6xvFD4JzT6hMQVKmE92CoWIeLsvuAJaL4D/Elvz7gKpy6d/jkVuhtGG
         LRnteuAfth65jcDVcCwxJkGAs27CxmI0TPJbpazDdkz5Y8rn2JrDttpPucpZATAxj/92
         rccfRGcgA5+L/RQB3UZ6aVNJ/xo0vjoyZ6rOZ+gKpPpT620vv62HaFpQQiNbOBkzy9aP
         YBUGOzPuV01tLvrco0NhNhiLjO45RyMBLU4iqkmFD0Cbb4UU0BnVOXMkSIEoFYbt8imc
         NeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684330489; x=1686922489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrtmfxt4yfxLY2UVAqI6rteBQZPnotIboHiGgYaz1iU=;
        b=kFxnc2g/G1izHwrOKqdu9gyoXbkuvDBPsPeNmfHLXECABWvzStg3wf2z6MQ8m/icmN
         lTgwA7YeBu9I+n2oVumuY5ZqAMBBPY/BcHFB0W1WVh5bNdR183hC/DSeoUQ5a6nX5E+/
         URiqZHz200WIwDRaXdNaAMaHh/BS6GwZRDsZIVsyU+rUTEZM5vZJ5he9rXhxU7AdYt3K
         npApXiv8wrM8hADi6gFGMZFiYCjqDDeIl/MUAodp4n1NJ4jml9oW4lwlUWTEv965lEK5
         Zebk4GzdxztPt1GZR0uJO+qrkyFtrn1KPe5taouxshT5bIpBpv8awGq3mWsa96chk+bO
         WpJA==
X-Gm-Message-State: AC+VfDyhMBMxXQRYKqcfjO0JcDqQMpYfJxe6rYBp+Ed0QST7dg2IpVpe
	3/d2cVch+RK7dCrOnAZj0s0=
X-Google-Smtp-Source: ACHHUZ7R/6MPttfoUfKR851xnOzMlb10IKMLwWJUo9hUtBqu6sCpegg1ztBOfMzusmeC76ySqq66Wg==
X-Received: by 2002:a17:907:a412:b0:96a:863c:46a9 with SMTP id sg18-20020a170907a41200b0096a863c46a9mr19383357ejc.71.1684330488633;
        Wed, 17 May 2023 06:34:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::2eef? ([2620:10d:c092:600::2:46a1])
        by smtp.gmail.com with ESMTPSA id jz24-20020a17090775f800b0096347ef816dsm12405450ejc.64.2023.05.17.06.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 06:34:48 -0700 (PDT)
Message-ID: <61787b53-3c16-8cdb-eaad-6c724315435b@gmail.com>
Date: Wed, 17 May 2023 14:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, axboe@kernel.dk, kbusch@kernel.org,
 sagi@grimberg.me, joshi.k@samsung.com
References: <cover.1684154817.git.asml.silence@gmail.com>
 <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
 <20230517072314.GC27026@lst.de>
 <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
 <20230517123921.GA19835@lst.de>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20230517123921.GA19835@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_063452_934136_16A38D3B 
X-CRM114-Status: GOOD (  19.71  )
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

On 5/17/23 13:39, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 01:32:53PM +0100, Pavel Begunkov wrote:
>> 1) ublk does secondary batching and so may produce multiple cqes,
>> that's not supported. I believe Ming sent patches removing it,
>> but I'd rather not deal with conflicts for now.
>>
>> 2) Some users may have dependencies b/w requests, i.e. a request
>> will only complete when another request's task_work is executed.
>>
>> 3) There might be use cases when you don't wont it to be delayed,
>> IO retries would be a good example. I wouldn't also use it for
>> control paths like ublk_ctrl_uring_cmd.
> 
> You speak a lot of some users and some cases when the only users
> are ublk and nvme, both of which would obviously benefit.
> 
> If you don't want conflicts wait for Ming to finish his work
> and then we can do this cleanly and without leaving dead code
> around.

Aside that you decided to ignore the third point, that's a
generic interface, not nvme specific, there are patches for
net cmds, someone even tried to use it for drm. How do you
think new users are supposed to appear if the only helper
doing the job can hang the userspace for their use case?
Well, then maybe it'll remain nvme/ublk specific with such
an approach.

It is clean, and it's not dead code, and we should not
remove the simpler and more straightforward helper.

-- 
Pavel Begunkov

