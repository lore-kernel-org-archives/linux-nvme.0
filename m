Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E014EC83F12
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6ONHVJq1guYQr4QsQ40LpMl6alYrT+WKUbUjt1YYvM=; b=sXpMPUr2lV/HmVYLvna8aI7XwC
	S+qvneh7nXq++nle+03Em/fAQwyqFKEeWjzUlnsdx3PigVMuc2ztfio6M682EnRGH1vUW6Dtg5QOV
	q3JqrJuQB7uh8mC+5CEH6MH/crtp7NKJ2KjN+yZG4As4Jacvy7uYnvWzahjYdFvspVdMdEghhQ0zc
	aEctINw853nNG6SW3M4SM/6+04MQG0UDkt9z/ZvfSpwXg8io6eN/TZMPtF6LqAwS+gKgOTZ/F/chH
	k7n7ORbDWp2IY8GwKPig56IgeVreKlnrenH+pNVH+djgVz3Y5Npnsh9Wmwv5JnEKQwE25aR8B/awC
	QURTiDiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxDE-00BRe2-1Y;
	Tue, 29 Aug 2023 11:48:48 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxDB-00BRcv-32
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 11:48:47 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31c49de7a41so499180f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Aug 2023 04:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309722; x=1693914522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6ONHVJq1guYQr4QsQ40LpMl6alYrT+WKUbUjt1YYvM=;
        b=NrUE/pafrxCP7GwkBA1kHNWO9opzv7lpX3qn4aRrgq29+//Ql+7QvewR35etI17mHL
         pWMscth6uKdi8UVFp8akEdWNbeBHAqTxzTZPsAzidXAVuXEP/Nul19ruEWDBkazhNZJL
         uLpbikcPI/UfCmo/2lieyEHxCz1wnZ4Dc1hakG2TTOJkQ9Ml9Q0zy3VgHHNucBooMUAA
         Jjqncele2+0TAsu5aUzN2pieyBpt3KfLyJReftIav/6U46CDerC0z19rYvtjK5886u68
         KBWNzvVM+ZQSYVLfXLMT6FkUUDrP8tBwSEQ0kEAyzB9XqpxgKjAFFBuQWGZCffOghNS0
         hX/Q==
X-Gm-Message-State: AOJu0YyZapLSC6EvfX9fV12vlo0ZQYZDMF+CQb2vHmiQm7i4+sZvaZ9T
	GQNwYf5LSCipHdPoQJgInn4=
X-Google-Smtp-Source: AGHT+IE4tuqa9SpwxzOSWSpU0gJbWYHlxMRc0N4CGlZkFNkQy5Qw74qnQEAmKDC+KvQc9nkSzI3gew==
X-Received: by 2002:adf:f892:0:b0:317:5f08:32a3 with SMTP id u18-20020adff892000000b003175f0832a3mr19853713wrp.6.1693309722571;
        Tue, 29 Aug 2023 04:48:42 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c4-20020a056000104400b00317a29af4b2sm13545101wrx.68.2023.08.29.04.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 04:48:42 -0700 (PDT)
Message-ID: <f96856ae-4842-8a50-dca1-2786153e491f@grimberg.me>
Date: Tue, 29 Aug 2023 14:48:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] nvme-tcp: always set valid seq_num in dhchap reply
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 kbusch@kernel.org, hare@suse.de
References: <20230828212033.3244512-1-shiftee@posteo.net>
 <20230828212033.3244512-2-shiftee@posteo.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230828212033.3244512-2-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_044845_974097_5EC1C1DB 
X-CRM114-Status: UNSURE (   8.43  )
X-CRM114-Notice: Please train this message.
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



On 8/29/23 00:20, Mark O'Donovan wrote:
> Currently a seqnum of zero is sent during uni-directional
> authentication. The zero value is reserved for the secure channel
> feature which is not yet implemented.

Hannes?

