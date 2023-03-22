Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23C8C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5ZG7J64QOSTUx9XiiDdRmUx6P1347DK8XQ+rqg+tkc=; b=NXQHqj0O/3ImhAWiquoKG8dilD
	sKtXPg2AAgQRNS8ZiI4SkGJZ32BSn1IxVf+4OzkWvomzVwzJxoDKTbY1T/uAOXgvmYfGHLUCRocKz
	0rlQm4HneBsHlp1cm6dzLrXVu6WoAGMfx4/WEGbWslCO2VKkMqS9i/lALsmfMjpQP42LsPr+qUhFz
	RtcfHNfG6HHdecdgKsazGExPpm3xinG1iZFT7aqlp9kRxo5DGPGG22RYq13/yrVlV3XKVxv2ipxU0
	oTyhvC/DwnGEsUysEyJGRFqL0YAMT2E8G9z7pxzZN7R8vb6YURwLAeRXpfNp2Iz35aKWnSJRCY/5W
	zBTPTGwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pevTo-00FbG2-07;
	Wed, 22 Mar 2023 10:14:04 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pevTl-00FbFF-1v
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 10:14:02 +0000
Received: by mail-wm1-f46.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so12648776wmb.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 03:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679480037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5ZG7J64QOSTUx9XiiDdRmUx6P1347DK8XQ+rqg+tkc=;
        b=3ess+r0miomL/JLNuBqkFDMmDjy5xBeiPY65pb0uwhmnAZKU+5UAHGnUIbXbkQWMBh
         A9cOL74uxWaHfhGgxUvvA0RmNC1+OmlSzAJCXTMPbqowc1HbMMWvC0OSIQnikB71IhS5
         k4y8o2SHkFa/YHLiwt5/qYY6dZxwQuN+8b+ufIFuissB7B9jfoAa5rdN4ibuU3LIl2Ri
         JfME9R9SfosE+zAuiezEEPurd/KuJq0NyzBDdnHgI1GODL0K5KECVyiVBRPKn/F3X8ty
         tAiPiMiYnCwR1tVWqjC/8dP0JeqHvMLKnBceVstwGRPa8ZAA9AAUHCahXC4XwKj6c+Rr
         VmPA==
X-Gm-Message-State: AO0yUKXFO0a0dJxxA2dgFwvZF/7IeGx/YvICyBvTz872yPbtey8jsXvu
	zHOEozxHkNNUR8WgLPsQ9bo=
X-Google-Smtp-Source: AK7set93TgwRQaw+xjse0ekF4SjABkMbOvVru2rCraEWY1WcVSB5UFoQBaTarvmF5EymqWEi3TTmIQ==
X-Received: by 2002:a05:600c:4744:b0:3ed:ebcb:e2c6 with SMTP id w4-20020a05600c474400b003edebcbe2c6mr5399548wmo.3.1679480037497;
        Wed, 22 Mar 2023 03:13:57 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c4e5600b003ee6def283bsm491089wmq.11.2023.03.22.03.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:13:57 -0700 (PDT)
Message-ID: <435745c4-9701-bb4d-5c2c-84ab10eb4747@grimberg.me>
Date: Wed, 22 Mar 2023 12:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/18] nvme-tcp: call 'queue->data_ready()' in
 nvme_tcp_data_ready()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-7-hare@suse.de>
 <d868b752-1d8b-1236-3543-c9ef82e42f23@grimberg.me>
 <3bd2c6b4-b276-b882-6f28-998118f96650@suse.de>
 <60d3a645-719a-40aa-959d-f461b0c3eed9@grimberg.me>
 <3b6796e4-93ea-c493-4e03-27712257f69b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3b6796e4-93ea-c493-4e03-27712257f69b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_031401_632204_2CC7D360 
X-CRM114-Status: GOOD (  13.20  )
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


>> I meant the change from read_lock_bh to rcu_read_lock_bh and the
>> same for rcu_dereference_sk_user_data. It needs to be in a
>> separate patch with explanation to why it is needed.
>>
> That is primarily for sanity checking.
> 
> Both us _and_ the tls code are setting the sk_user_data pointer,
> so I wanted to make sure that we do get things correct.
> But seems to work now, so I guess I can drop the rcu_dereference
> modifications.
> 
> Let's see.

As I said, I don't mind having it, seems harmless.
But need it as a separate patch, with a description for why
this is added.

