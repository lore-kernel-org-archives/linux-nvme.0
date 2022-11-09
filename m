Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21889C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 18:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vdXtXM8zEW2xrwNANEUFF1JLyZdfpfx3NcO+Sd9aBiE=; b=ldGXcPeFmNG/wcJPdrCz7n/axf
	rGqpqG5/uYTXgAnoralEHvWL3z4hvVDasVUzJIZD5BBYtpGTIddx47Qwy4qCXVk0g/08tr4UI1JoH
	juum4kzqZRDL3NXGJqzGIoTUcnCZyUWvjXcT99IxAq7/4qIrl1cj0Ktf+Lh2P5szbFfRLVDutBCs2
	GyE+86MZgYYl3bdnXJWq/JOq2Q7G/v1Pe7jNnSG5CMW7LLHvuSuhJIm0mAmLdTOFm6v+PkIpOaTJ9
	Sy2eGwh83BeCkyVqMBbI+U0A5DshkOqyW7Gq8j4ZHkPJT1B1+/p37UU7pfKw60KDhISdbjq/Iu6Aq
	U7/CFmgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ospRx-00Fw9I-Il; Wed, 09 Nov 2022 18:05:21 +0000
Received: from mail-qt1-f171.google.com ([209.85.160.171])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ospRv-00Fw82-PQ
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 18:05:21 +0000
Received: by mail-qt1-f171.google.com with SMTP id l2so10790907qtq.11
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 10:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdXtXM8zEW2xrwNANEUFF1JLyZdfpfx3NcO+Sd9aBiE=;
        b=2qn88ULY8Y5BAbfGGbbc6FK6hMYnwrcBKODn3k3lKnMZ0cacIhxK6gqTJ6PgXNRlKD
         LKJjn5lyFz18XHCo0TBEcdLLPRI2zrXGYWktYRZUGeJedMRXnXTViAYZMvpaINgA8NZe
         XZ2doamVoup+ELIwzMnxWEtoVBLLwo18x4Okbpg47dMHJpBBR3Gz+wLXAU5dtxQjlA3X
         SlmDHTLBISpqy8KUlLmiZy1kyZ11qQp2+NBnb/bdq3p16sAQ+/qZtfsLCjP6kQkllQia
         ys96qPIM1QAkx8VXA0Nv7HtGBo3Ub7QJ/MTZfhoyLQHL1W1ZKHRt0TlQ4E4kViZxblbU
         epAg==
X-Gm-Message-State: ACrzQf0CbF0D8vOp9zMIGMecC2UFD5/KIuiN8Rn0n6btUTelMKtx2Nf7
	iMGk1B3tXwAdjrokcLAk4vkiA1Ipv7Ur8A==
X-Google-Smtp-Source: AMsMyM4+uID2/m7lE1yRJI1yYjHW/dgqM59rzg2iydXF+athY+XKaEVDaTbT7MK3UTLD0iT5yseyvQ==
X-Received: by 2002:a05:622a:59c6:b0:3a5:3bfc:3faa with SMTP id gc6-20020a05622a59c600b003a53bfc3faamr36764312qtb.184.1668017117684;
        Wed, 09 Nov 2022 10:05:17 -0800 (PST)
Received: from [192.168.82.40] ([108.95.161.27])
        by smtp.gmail.com with ESMTPSA id bk32-20020a05620a1a2000b006cec8001bf4sm11598481qkb.26.2022.11.09.10.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:05:17 -0800 (PST)
Message-ID: <bf1f1e36-bbd4-d1b8-4cb0-d75e821fb131@grimberg.me>
Date: Wed, 9 Nov 2022 20:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/16] nvme-auth: don't keep long lived 4k dhchap buffer
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-9-sagi@grimberg.me> <20221109063914.GB10893@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221109063914.GB10893@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_100519_856345_79FEAB54 
X-CRM114-Status: GOOD (  13.65  )
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


>> dhchap structure is per-queue, it is wasteful to keep it for the entire
>> lifetime of the queue. Allocate it dynamically and get rid of it after
>> authentication. We don't need kzalloc because all accessors are clearing
>> it before writing to it.
> 
> Btw, do we need a mempool here to make sure we always get one for
> a reconnect under memory pressure?

We probably need it. Will add as an incremental patch.

>> +	/*
>> +	 * Allocate a large enough buffer for the entire negotiation:
>> +	 * 4k should be enough to ffdhe8192.
>> +	 */
>> +	chap->buf_size = 4096;
> 
> Same comments as for Hannes previous series:  no need for ->buf_size,
> this can be a global constant.
> 
> And in the comment the should is weird, it is enough.

Folding it in.

