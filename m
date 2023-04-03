Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460B3C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4yfHxwfFzVgQnZp/Yx9Pk7v15x9g20qt8HaR7zZL0bs=; b=AOEDn5yYqxbA5BrAVa3QpMoZUr
	qAW+3ZugszoTPyPU8AnA3spx6V9/Se2IN30ZU9c0F2mn1F0Bkavd9Wf4rePuh6e2apaom/W402Zgk
	I5VszdAEC470W2UmI09UOwduqCPRfK+x20p/ammDOXxegdFut31ClZv56HIzIp8gqmqaMkGO2g+Bu
	AVvq5oq2GgiO3FggQz1BJb5z4Ii1D8LM1rxBOeAF+zAx/PLOn7jKUlJpMUGepe05q/bt5JWuAyBdB
	rTODm9vp9rB4guH8J4zfxy6ZE2og5JqjaDP1kh0hqkSLk1z0Sof54wffngPOHW/ZVgiWW8Z26Ww3N
	fAkQCe/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJu4-00FOmb-33;
	Mon, 03 Apr 2023 13:07:20 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJu2-00FOlh-0G
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 13:07:19 +0000
Received: by mail-wm1-f49.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so19465321wmq.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 06:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yfHxwfFzVgQnZp/Yx9Pk7v15x9g20qt8HaR7zZL0bs=;
        b=lEh41Q69asEbfksxlYSWdVQfwhG+9UCzjpfU1wIFQvNugIu8NT1OhOeOW8IwASKumF
         xlYoR7J1dX3wz5BlDXPKX1t0eVfus1BIPvJGqVHt7RPhmKjmyccGH/UfxpIoBzin3z3j
         HKPEbVoxe58wjfyNpt1URgpTGxNnZss/yJVidFS6qWrqGuBZQCq+/hhySFTD18q2D9fj
         2vBHFFTOtSIF717xz0s7aWVnhrvoHI8xPS1zKht+Ps2aGPupiT6Nqmah7kMKCQYLVFOQ
         XmPYXTgAzDTyEoycc41pehnvyOA/Szf7OcQNDlLpPyq+oEqz91IKgz+EwuLIuOrew5fC
         SRhw==
X-Gm-Message-State: AAQBX9cxdjL5dPEP1suBUP49aTQ55sLgeMcXQaImIxGKkGDQ+OJN2h7g
	WEK+hgAsv/d2P9JxLOu8mdk=
X-Google-Smtp-Source: AKy350YT2fTtu8c/NvUfYvoziMY5QCGuqYyL3l2IQRlWMYIBPbBMGno4eW01XnkRH+vNPU9DYgUmCg==
X-Received: by 2002:a05:600c:1d11:b0:3ed:793d:9dd6 with SMTP id l17-20020a05600c1d1100b003ed793d9dd6mr11438119wms.1.1680527236473;
        Mon, 03 Apr 2023 06:07:16 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003eda46d6792sm19377363wmo.32.2023.04.03.06.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:07:16 -0700 (PDT)
Message-ID: <a22946d2-e22d-a361-8768-8b34cbec1b03@grimberg.me>
Date: Mon, 3 Apr 2023 16:07:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-13-hare@suse.de>
 <677f3f9a-872d-27fe-9a21-b41bbe1c44ff@grimberg.me>
 <daf1e19e-119b-3ceb-7808-b74d8b113e05@suse.de>
 <f1bfbb7c-d8df-0386-1048-f141cb6e22bc@grimberg.me>
 <d67d9932-96eb-3548-cf40-b48a6db95739@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d67d9932-96eb-3548-cf40-b48a6db95739@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_060718_121647_72194B3F 
X-CRM114-Status: GOOD (  22.70  )
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


>>>>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>>>>> referenced keys in the options structure.
>>>>
>>>> Can you explain the reasoning to why a user need to pass a keyring
>>>> given that we already set up one?
>>>>
>>> Choice.
>>> With a single keyring we can only have a single identity.
>>> But there might be configurations where we want to have different PSKs
>>> for the same identity (eg for key rotation).
>>
>> How do you expect that rotation would work with this?
>>
> The user creates a new keyring, adds the necessary keys to it, and then
> either
> - updates the keyring for nvmet (via configfs)
> or
> - reconnects using the new keyring

And the user cannot update the nvme keyring?

>> How does nvmet handle a non-nvme keyring?
>>
> There is a configfs attribute 'param_keyring', allowing you to use a 
> different keyring (the nvme one is just the default).

OK.

>>> With this option we can prepare a new keyring, and use that instead 
>>> of the old one.
>>
>> On an existing controller?
>>
> Sure; when we are updating the keyring and the key id the controller 
> will use that after the next reset.
> Much like we do for DH-CHAP nowadays.
> 
>>> (And it really doesn't add much complexity...)
>>
>> I know, it just adds one more argument, and I want to understand if it
>> is really needed.
> 
> I do agree that the keyring argument would not necessarily required if 
> we pass in the key id, but I'll be needing the keyring for secure 
> concatenation. And plan is to move DH-HMAC-CHAP over to keyrings, too.

I'm not sure I understand why authentication move to keyrings requires
that the user is able to bring its own keyring.

> So I'd prefer to keep it.

I'm not against it, but I failing to understand in what situation a user
_must_ send a different keyring to the driver (and not use the nvme
keyring).

