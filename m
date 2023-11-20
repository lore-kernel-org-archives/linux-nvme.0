Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7975C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EBjfkJyBXoUSjJtDaLOjdUY1bhjBGKEs8k1Y4r3sMi8=; b=xWNXAJ1uVf40vVKbBdLXmFZnNN
	l5mN+nCm/IP8v1f41ypeHmAohiH8gM2mrZEUcDf8U1BRiRS4LkkuSY4qLI8TSHJZJ87TiWqYvNUrT
	F7ntsoapC/AgPM+vZPHBmRkaV+BdBDBnM0kSUFG1rSBKokEAVVObKceehYYGaSh2kXhIVuPdGmAAA
	kZ7orA7eeqyVHkKEdbohMShBC25W37dkzhZJvGu/yPZPB4nQdZV40vmZTK4KpSm660UPRasaZnn//
	c9B7TuLN5BEcLno0h7qSHnTkVj8KGNjmcBNtKgPgbhFL+MWuwjw/xGuZ/dvyjlfut+xQ4x6Up7cB+
	kQ2N9zCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r54ht-00CCBm-2X;
	Mon, 20 Nov 2023 13:52:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54gv-00CBs4-09
	for linux-nvme@bombadil.infradead.org;
	Mon, 20 Nov 2023 13:52:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EBjfkJyBXoUSjJtDaLOjdUY1bhjBGKEs8k1Y4r3sMi8=; b=YSeT7CrpU+3/4xMafzIQ3zJaST
	GeXtuNmE7igBoIZNLAcW+INVyOuW0PeO2LgpUL8EL6Td49DNSR/O40W3l1nQ0oUXsVBKStyAPE3G7
	oRhte8U6eYFtkvKGNnBaEmuArKsxFNaUlI41ZL7mwt6oYceyw45WhDPXTqy3MaiOGV4JYnlqTxW4x
	G0f62P7g9PPPfrk8JVo7npaWHu7TVYDKigL5tK4SLy06DNWj3shthPYObf9LaQdwXxCPyg9VnUMl7
	PNvBp5K8LRQRAcYrnoVdt3zq2a8z9Egb58ZL18zIE7sdeozc1oIjaIW772ea72MsVTphlBll37sG3
	xcm+c5OA==;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54gr-00AzDm-1i
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 13:51:55 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-32f831087c6so1198237f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 05:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488310; x=1701093110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBjfkJyBXoUSjJtDaLOjdUY1bhjBGKEs8k1Y4r3sMi8=;
        b=J++yeE0dkfuK3XZDxI4LmPew1GWLVFHCHjMnla6gijq1f1IJ27VA+/+VsWSmGIGxa4
         dwEm8J3Frtnvndw8GfZkGG70aAt1Dzs3fVe/KC+LJo1UGjpxws522lniIUHEvrF84Edy
         vrr8EhzJhArvHp65TBl6lWMoE0nbX3JOfNwo+FVedRxp7KLmAubDaHXsjKwrLYzFK+0N
         dsEb6fzraIS/s3by1Hbk3Uo71Rztt2fSPc6Bh3tH7VlVUNxBDLqaLN6ojwn/jviz7a14
         YBJfWPYxcZO9sMN4S3Ixuw9MGbtvJHIS+d51qvkkyWrWGLsg4hsH/kQ3pkWnHmMfWDmq
         rS+Q==
X-Gm-Message-State: AOJu0YxdKp/pb5DXgWiZacp0GxvBIzgYKevb9rNJkOVUSPMKLurtZkAk
	BUWrWZWp/ZuRGkmbhsHbXs8o7NjelEo=
X-Google-Smtp-Source: AGHT+IGtfGcszaALKdok/gQAg+bpVnqvh3VY7SQ0fRrzq8DdiWFTac+fVhWZmnuemP/JJv76xozspw==
X-Received: by 2002:a5d:44c9:0:b0:32d:e435:92c4 with SMTP id z9-20020a5d44c9000000b0032de43592c4mr4973906wrr.0.1700488310124;
        Mon, 20 Nov 2023 05:51:50 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4c92000000b00331424a1266sm11249805wrs.84.2023.11.20.05.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 05:51:49 -0800 (PST)
Message-ID: <82b827fc-ce2c-4d87-b796-3ce81c4b52ce@grimberg.me>
Date: Mon, 20 Nov 2023 15:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: use crypto_shash_tfm_digest()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20231029050040.154563-1-ebiggers@kernel.org>
 <20231030132816.GC21741@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231030132816.GC21741@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_135153_763588_BD182EDD 
X-CRM114-Status: UNSURE (   7.81  )
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

>> From: Eric Biggers <ebiggers@google.com>
>>
>> Simplify nvme_auth_augmented_challenge() by using
>> crypto_shash_tfm_digest() instead of an alloc+init+update+final
>> sequence.  This should also improve performance.
> 
> Nice:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Indeed. fwiw:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

