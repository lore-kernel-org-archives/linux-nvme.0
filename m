Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3364CC76188
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ClRkonRNBH8O7NdfUT93YUzudQLnZcGd0jMnr/kHGA=; b=3v8neKTKwUsmU5eHh6GafJxaPL
	FTj0bqzaywTR7hv5sFLvRe6GgTKkBey05FsG6wyYgtsc72zmkTzDtldvE1k+AqZUbl3L8UGPT1JEe
	YNxQ+8vo293SNfgWiYZW1CHv2X6ExUvIWyJUCDRemRzWO4OVLUiD9MfxpT2HJAYxRkwh7iLA+qeEu
	HkOMBFeDHsywYJcxmDKvZQZOfDF3PEVq+J9t1m8FwT/GxAB3rAPmgjIDrqKAkFjwjLl9pawDCCxl5
	KLgYmrooqRcHtR4HEu/QEg9h/e15b3QtM9zPkKHb/UqZDHLB7mWAYTI/iTN5XyqAIoHMyMUV54mXF
	ii4zAH5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjMVO-00FsIa-1Y;
	Mon, 03 Apr 2023 15:54:02 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjMVL-00FsGQ-2X
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 15:54:00 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-2d17b1b21f1so542391f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 08:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ClRkonRNBH8O7NdfUT93YUzudQLnZcGd0jMnr/kHGA=;
        b=p1QQ1eyIGSYKbp+enMeyrbNZUv4XM64k9b13uS26bZdkt2p/XpHs5J+KaH1dxmd/Us
         gCNGwuiONMjZQYkXSqWXt40rIA0WbR6NAtGX5WUdxRGAGyMZexCSXOJnAFqV3aYn1s7r
         P9ufUtty9yy2N38TEGMtAgBXArKLEOAdc5nk0eQ9IeTeKZB9vbWUB1h+zSkxOQYT/ZFK
         FMdthFdNIxsfP3C5CESKONt+OEC6FeUFlQflfxXKo7qjwp8ia301TEjaci/HeY5pgH3n
         ac4WDDoDdpYjcwJVrAWiEh0xquNykfMusD39N+RKymqBkyXubt/YnsIv/GcAoZ4fOpeu
         gfyQ==
X-Gm-Message-State: AAQBX9cjVBI4YNWxARYpKAJhbwnqWaRUk0f/9NLxpbUFHHndBg8FyT0n
	/xeakRQFNMXiWREERbM4odEk4s9XOPM=
X-Google-Smtp-Source: AKy350abIeRfp3sEfbHUjS/39EXa4otYzwWvSMb2ZrNYUeahOFNo1/FAI48z8LrzEstVbJv5En/THQ==
X-Received: by 2002:a05:600c:4fc9:b0:3ef:7bc5:4e14 with SMTP id o9-20020a05600c4fc900b003ef7bc54e14mr12422421wmq.4.1680537236960;
        Mon, 03 Apr 2023 08:53:56 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b003edd1c44b57sm12455105wma.27.2023.04.03.08.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:53:56 -0700 (PDT)
Message-ID: <1b018791-9aa3-b988-7045-40b46bc50989@grimberg.me>
Date: Mon, 3 Apr 2023 18:53:55 +0300
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c7e895f1-1c95-f658-f7a1-c4cee5cf8c91@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_085359_822621_1453FE61 
X-CRM114-Status: GOOD (  11.27  )
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


>>> Add a configfs attribute to list and change the default keyring.
>>
>> is the keyring an attribute of a port? or a subsystem? Why the choice
>> of making it per port?
>>
> As per discussion at fmds each port might want to use different 
> credentials.
> We can move it to subsystems if we decide we don't want to support that 
> use-case.

I think we should move it to the subsystem in Linux.

