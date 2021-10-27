Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35398C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 09:49:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF6A60EDF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 09:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEF6A60EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R1mmwWiuBm+P2HuSVhsntwY9DvEERM7xiTsZGW16mKg=; b=kahE660FVoawNhUDFYHNPkNcEL
	ojfnZxoh1zqwfvX8+OTpi2S1vZq7DU7YI+bHUUGJKnSNTH0baa+ukr5n1G/H+EGki5QMZWWuVIWTO
	xa2Iu4qqI9ggHwvDiVI9epnyc4kz/EevYsHsHbUTI7JKZU3vqUtOVcybHU3D3dxCbZQ0XlkbaiwL+
	LDggaeRc5tkvR7tVnLHUE32d9TsQzyqdsheTJPA0mXZP7Q1k4xBqO4CntUMjuWdRGFP3Ff8+OTbsL
	Rr9ZIRo2lqXEq4D0ymWRUt8dlIyEXmJahMw5vrLc0EjM8tt3IgJpPrGquUNdfU+h0l6qGJoUMpM/i
	5aVss5Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mffYv-004TjN-Ra; Wed, 27 Oct 2021 09:49:37 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mffYs-004The-M1
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 09:49:35 +0000
Received: by mail-wm1-f41.google.com with SMTP id z200so1199270wmc.1
 for <linux-nvme@lists.infradead.org>; Wed, 27 Oct 2021 02:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R1mmwWiuBm+P2HuSVhsntwY9DvEERM7xiTsZGW16mKg=;
 b=qMZ8dOatYp3g/dSzwB5MJOP3c+ZYLcTWpAxiHluTaf4D4Px+VhCkz+JCm/JhK1puIh
 gFWyMfuuy1R0rCGSlU+D0spIvJhzAB9MFEuSpUwbfDmFH3kHJRzwwOoicVzlGlrDzSRL
 WLVBcGxRqnHh7fOX8MzcFOLU9Do5ZZIApuN6l3/TpWHPpkkmMfO5t+9Vc9by2mXCLZZs
 MYCtjJdG6AFInyO/JdiUqKhbH5qIeotvbXJOdbYnR1seiRMMumEyrxqBe/uLWwl9Ynbl
 bgN0xgEbDg2EnHHI1wuJJoitjJIsEbuM2Ykjr3ilwbyT6yzuz3OmiOmn5acy7LfcCi95
 KBKg==
X-Gm-Message-State: AOAM532wTZHdlFmfZxYhShsyJXsoGGTVRZ+3W+dXOWbs9w0zYZAm+KX1
 udti6kxSmHbcAp0yAct21WcI+QcCODU=
X-Google-Smtp-Source: ABdhPJzOeUM/21RbdwwGbQE8ByVudQmQq8lKVolcFsmEGNT+9BcI6OzftOwnKVE+a8H72YlyzeYp6Q==
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr4663243wmk.32.1635328172943; 
 Wed, 27 Oct 2021 02:49:32 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id v4sm14176615wrs.86.2021.10.27.02.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 02:49:32 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
To: Christoph Hellwig <hch@lst.de>
Cc: Varun Prakash <varun@chelsio.com>, linux-nvme@lists.infradead.org
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
 <20211027055725.GA9635@lst.de>
 <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
 <20211027071316.GA11266@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <252308fb-d557-34ce-5c7f-a6307f92b111@grimberg.me>
Date: Wed, 27 Oct 2021 12:49:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027071316.GA11266@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_024934_755626_4CA2F68F 
X-CRM114-Status: GOOD (  13.48  )
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


>>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>>> index 07ee347..d641bfa 100644
>>>> --- a/drivers/nvme/target/tcp.c
>>>> +++ b/drivers/nvme/target/tcp.c
>>>> @@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>>>>    	struct nvmet_tcp_queue *queue = cmd->queue;
>>>>    	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>>>>    	struct kvec iov = {
>>>> -		.iov_base = &cmd->exp_ddgst + cmd->offset,
>>>> +		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,
>>>
>>> Wouldn't be the better fix to divide cmd->offset by 4 instead of the
>>> casts?  I can fix this up inline if that is ok.
>>
>> Don't really mind, what makes it a better fix?
> 
> I generally prefer to avoid casts as they paper over bugs.

I'm fine either way.

