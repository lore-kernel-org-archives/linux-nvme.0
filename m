Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A806DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 08:26:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEA560FC0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 08:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BEA560FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NGUD3CpMsS473TSAs//TrvInw6qN3DscWY6xYvKituE=; b=ftf9BOINc4zTsR75tmG0D8cZAp
	LV9rXlG15FBr9pM6fiGOX6vf4FB0eLGnDRb37XlbxJ4D1Kef38V2ArPTQvH4QyxRf69zhJilWVaIV
	aoQJzJ5ILMusv5WhwqVjDlaWdm87884fyUC3NYSIfQy21BhF3eKPbalMfnSTIyO9CRf2d6e9fjSuf
	USDkeAdbuRRVM/r6XjCiWiOqMzcduC34U0lPr/tBLXzXzM3UKk2VirGxqrqcPJMA/SKDPtq8ssi6w
	iHgCsFYzJ3WPIecYIpV/NZf+LGyyaJqamY2dj0PV2401jQHsPso72u5+RRrTwMIirgIvdyBnsuc10
	e4+D8LEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg0ji-007HUC-Mp; Thu, 28 Oct 2021 08:26:10 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg0jf-007HTs-3P
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 08:26:10 +0000
Received: by mail-wr1-f42.google.com with SMTP id v17so8664773wrv.9
 for <linux-nvme@lists.infradead.org>; Thu, 28 Oct 2021 01:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NGUD3CpMsS473TSAs//TrvInw6qN3DscWY6xYvKituE=;
 b=vpAjMwSd6cKhMFA2lzCLkG/z01zv2ZZrkA7uDrysgzUL2T2YkigH0tEKoTyWGdJ8Tu
 CI2BX6kY3zGspKOJhocXyjBkDqlCmQ9cDu+nv7Wda7LkmoxmfezSRui3M8V52F8ycNG5
 /pRDbfLum1TLyZslq0OhUEVn4bcTPIi85NtTttF7X1criGmT9gJq85q00JGyDA0Gxd3f
 dd8iKX47b54cIuZsdAdHrztp6aYDl89zZWk1pDfYPzLSHylHudm47AYrpb0jh6eV0v6W
 Id9Z/cWTj0fXvCo6bnn5kKfh09gMk+8W8piiMwaNLmoCa3oAdV1BFSjxI3awCZtIGoW3
 g1tQ==
X-Gm-Message-State: AOAM531O2gKYpi6Rv7Y9dP0etWOgQQCdZzV6DUvy0Ez/VK397K29OmML
 09Em4aIqW/gIuRHSzbiAhPg54PWigoM=
X-Google-Smtp-Source: ABdhPJzEV6tkKPmQgOm3ad8/i+TI9Yw878iRweDHMh2itx9RFCSe60kXFDMCDvCaYxfBxB6AvSXuTQ==
X-Received: by 2002:a5d:4210:: with SMTP id n16mr3816887wrq.426.1635409564653; 
 Thu, 28 Oct 2021 01:26:04 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id f7sm2566216wmg.14.2021.10.28.01.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Oct 2021 01:26:03 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
To: Varun Prakash <varun@chelsio.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
 <20211027055725.GA9635@lst.de>
 <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
 <20211027071316.GA11266@lst.de>
 <252308fb-d557-34ce-5c7f-a6307f92b111@grimberg.me>
 <20211027144914.GA1851@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9dc338a1-d047-0d48-15cd-317b637d5491@grimberg.me>
Date: Thu, 28 Oct 2021 11:26:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027144914.GA1851@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_012607_201776_95636DF8 
X-CRM114-Status: GOOD (  15.58  )
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


>>>>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>>>>> index 07ee347..d641bfa 100644
>>>>>> --- a/drivers/nvme/target/tcp.c
>>>>>> +++ b/drivers/nvme/target/tcp.c
>>>>>> @@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>>>>>>    	struct nvmet_tcp_queue *queue = cmd->queue;
>>>>>>    	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>>>>>>    	struct kvec iov = {
>>>>>> -		.iov_base = &cmd->exp_ddgst + cmd->offset,
>>>>>> +		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,
>>>>>
>>>>> Wouldn't be the better fix to divide cmd->offset by 4 instead of the
>>>>> casts?  I can fix this up inline if that is ok.
>>>>
>>>> Don't really mind, what makes it a better fix?
>>>
>>> I generally prefer to avoid casts as they paper over bugs.
>>
>> I'm fine either way.
> 
> cmd->offset can have value 0,1,2,3. cmd->offset / 4 will always be 0.
> If 2 bytes of digest are transmitted in the first call to kernel_sendmsg()
> then in the second call remaining 2 bytes has to be transmitted so data digest
> buffer pointer should increase by 2 bytes.

Right, so let's just change the cast to (void *). Varun, can you respin
the patches?

