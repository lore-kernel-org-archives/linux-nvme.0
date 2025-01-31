Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34727C0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ljk6Bjbe6KEIsfvfP8aXIclZ09kMqt6Zf6rAW6hJAjU=; b=lpYU3mXinW4gZVlZo3MCmEUuKh
	UfDUelae/DsZpldjYCCEGRbTwedO35lb2QnxKuPTLBupoo0Gs89bIiOUgwvOWv2hb7HtCzOzvWeBb
	qVr/zyMMmycomsnAIw9u96V4zItWC16TvoS2xeAri3EmxV2DjukDWcnxDily/+W1r4mBUZumq8B3K
	DsluUxwncOM3TDg1glLgxmQZolnYcOhFKQbTX+cguvukgZnJIoVAK+oUKKvNlxBnn4/B2vCOo7ZEy
	dHkHE2aK6EWgeDa3izEBJNPpxyxZh/cVv8RUV16t2Wgs2HsW9uVwMcqlgUf4NqWuXAxuH/bO3U9tj
	7EyINzQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm5S-0000000AAcd-3J90;
	Fri, 31 Jan 2025 08:09:14 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm5Q-0000000AAcH-1nnA
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:09:13 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f796586so18330075e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 00:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738310951; x=1738915751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljk6Bjbe6KEIsfvfP8aXIclZ09kMqt6Zf6rAW6hJAjU=;
        b=fqGexOc0bRFYlEFFHhHonxpmUA9TQLUCa09BcNqEZUdoTTmMEo310fDVkN9Mf7ZmyV
         K6NNl6RlOatZOqpwbnMyVago5WaZEuXzAAX/aDx0Es42Z8DXsj5mcOpWj3oarJRaEOH7
         e03YBqxKbWlSIe1iaE/QUsVFpUEFzP9NPrDZyytVZOjdph8B42IEtJkrHblTwlvHS4oU
         6Mpr5gt8OUnOqZro8LfhQ56a1qdnATFOugR/bT+Zgin5QBsha5oLvn2dFJdo8b7+jdZ3
         QPN8nLKZqLSbea74FU54tLbHDLHvtUqHFG/g4VIHyDnUPNW3wEAkhZAAxLfnbh3gKVzS
         +qSA==
X-Forwarded-Encrypted: i=1; AJvYcCWeYg8aGiiBmN/25zi13bXu7iGsHu4FfxiulS9WBsgyw2i6mPBspfM/MTfM33fbPxpjfnpowqVBh+3L@lists.infradead.org
X-Gm-Message-State: AOJu0YzDwApWly/vJLJUcDnWkY8dEhtXH9NkhVIPzAvEiF++vp/GfS2L
	0yDUR4aSgm5gcfswUwKdHDvJ2rtgS35SP/fInJfprCow1tA6dus3
X-Gm-Gg: ASbGncvD1ZYOkxYnymQbKEVT63lQPG8uU9vVIEGqEbU5X1EFYSB5Izcjd/f9RabXZZn
	i0TWr0q7BHt2bnvB6UcuUD0a0Dj0QP80YBC7F/vOk7v9m22RNzB3gNJCd2cQuuow/tXsn26keDi
	fVascucOswfLRoby/d0rW1KCetioi0IUsCgZDYGhAnqpfyBMN0C6XwW4lEH/BjpimmTtNECtCN+
	96MAr8Nwu/ll4ERKQ876RksWITOYbbZZFog5QwjefudnR/92mDL1GRhbdNVskmY4CC1d/X8+FHV
	i/P6rwT3nFQ12+0zfmIu31IjUAwaAKHjwvdVrachg+Ekf63A/6U=
X-Google-Smtp-Source: AGHT+IG8U8qtb55GKUG0cAn303iaS3JbFJZrFNF9WjJ6Adzj7bEnfTaN1soMYjK/D6qHIvxggSZ5OQ==
X-Received: by 2002:a05:600c:3c82:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-438dc4251f2mr81680585e9.28.1738310950470;
        Fri, 31 Jan 2025 00:09:10 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ef41sm47905815e9.32.2025.01.31.00.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:09:09 -0800 (PST)
Message-ID: <d944d241-cc33-460b-9975-e8b68eecefac@grimberg.me>
Date: Fri, 31 Jan 2025 10:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
 <20250129060534.GA29266@lst.de>
 <216ab5ef-1c8b-4f3e-8a1a-f11e28994620@flourine.local>
 <20250131072947.GB16012@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250131072947.GB16012@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_000912_473596_6298BAF9 
X-CRM114-Status: GOOD (  17.57  )
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




On 31/01/2025 9:29, Christoph Hellwig wrote:
> On Thu, Jan 30, 2025 at 04:25:35PM +0100, Daniel Wagner wrote:
>> On Wed, Jan 29, 2025 at 07:05:34AM +0100, Christoph Hellwig wrote:
>>> On Tue, Jan 28, 2025 at 05:34:46PM +0100, Daniel Wagner wrote:
>>>> If a lot of request are in the queue, this message is spamming the logs,
>>>> thus rate limit it.
>>> Are in the queue when what happens?  Not that I'm against this,
>>> but if we have a known condition where this error is printed a lot
>>> we should probably skip it entirely for that?
>> The condition is that all the elements in the queue->send_list could fail as a
>> batch. I had a bug in my patches which re-queued all the failed command
>> immediately and semd them out again, thus spamming the log.
>>
>> This behavior doesn't exist in upstream. I just thought it might make
>> sense to rate limit as precaution. I don't know if it is worth the code
>> churn.
> I'm fine with the rate limiting.  I was just wondering if there is
> a case where we'd easily hit it and could do even better.

I agree with the change. The reason why I think its useful to keep is 
because its
has been really useful indication when debugging UAF panics.

