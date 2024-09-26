Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B50CDE034
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2024 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qja+XDs7guUN35rttc9FL0qVA6mpRjfv1Lp+wNX5FBc=; b=azEUtM9QEtLYtXTrv0ReQIJNC1
	0aLiYfherveLlhRpBNHiC2Am8T2L5f/OYoGZM79DqUIl0wLp3/ySY8L+ldDu4hshic5TjvXnmo7f0
	gX81mxP16z/m+MqYBotHVxpmz0hBFWFXrYNbCnerBuOV02ZQoRildSJlXaDFyC8nkslUWoOvFBOtL
	j9Ygg7QkWkrXCQzUrL5xjcD98aiMhy79mln1KTZ2+cZM0KeWfGAjdBLNMjXIiGZkJCFpljggsSSbW
	3oTb5XXzTsWu183u9ytISkoCWfZpoTB5XH317RaxgjynBWRJl4wP2y4Qr9X1mXS6vyjnzmwXcPs8n
	FYymhgww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stun1-00000009Hip-04nz;
	Thu, 26 Sep 2024 20:08:39 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stumy-00000009HiD-2Txy
	for linux-nvme@lists.infradead.org;
	Thu, 26 Sep 2024 20:08:37 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso9505675e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Sep 2024 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727381314; x=1727986114; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qja+XDs7guUN35rttc9FL0qVA6mpRjfv1Lp+wNX5FBc=;
        b=fJM4+N8umUwKGGVYMC2unxMqB2sN/K3F2DXe3siYjGF7mNwGr3eD+qorybYso+y9nO
         VUYd4jYdPeqr24TnxKQ3v7Hy6mhh33kSVKS2oTuMz61M6uy+UzpgUGIKUqwRkpPIV8r1
         etkVubJ1yBK5W12ObBGOOjF7ue0DJSeEqLPcynhALr2EmpDu1WYx0FRUS8RiAwId/YZ1
         mpMoPIlJ5GWTmLgr5T4bybIW6K/M0ggx0xZE0xDMramqjKWkkObBYuuk0tG72erJlEMm
         beZqTQBeZspa5INqyuk7sUpnlK4CKAimsZ5/HEuYVd7UMQs9RIbOKlEQJGx3FF3Qeqxn
         V1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727381314; x=1727986114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qja+XDs7guUN35rttc9FL0qVA6mpRjfv1Lp+wNX5FBc=;
        b=VJe4h9liGTqoQ+8QhIyx7I+V58IdhapHpTgvpuLhZnpm8/xlq6SAqZZ5e2guOQaXZq
         b782f26AiahxeVVTfRF8Z3bqjhu71RMOece169slgEBe35Q3l+HJWaqrCvF9KZDhXgyA
         4xLFPY++xZToI79hifIVrGLI6HqpciHj4Ofr/Vml7cVfV8O0yT+YikkyxKbdieaSTBqU
         mP016aalZpPFRmllBaNogvEjS3i3jHVSuEa6bWvJzQdIku0PPs0t62qbYdeDIoy8nkaf
         Hy/Gty8ppNxVTox5bIydgrEKdLgGWfhk83L5jL8UkDffttH8uVlSd7ozFp1TX+BWo/Z8
         xeaQ==
X-Gm-Message-State: AOJu0Yy4zqe0r0jSuURpOHrvpgM1Td3v+GwR7aGJQ5z6o28SHrdiKD5W
	QVKYgF4JZro8x0PoBb/r6jSbSfmHSRbaHwu/AC2WtIEyc/c7Js78
X-Google-Smtp-Source: AGHT+IECVBMYxZNk/vP2MiJPkmrQ4JB7C0Ivw5Fl0+CKBMqRmr9TgnFrLLY2uS80X1AGnQDRPQSYBQ==
X-Received: by 2002:a05:600c:5903:b0:42c:b7e1:a9c with SMTP id 5b1f17b1804b1-42f58bd7a9dmr3414365e9.5.1727381313633;
        Thu, 26 Sep 2024 13:08:33 -0700 (PDT)
Received: from [192.168.42.227] (218.173.55.84.rev.sfr.net. [84.55.173.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a56fd1sm54617485e9.48.2024.09.26.13.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 13:08:32 -0700 (PDT)
Message-ID: <3f4b4b60-d9f7-4dc7-9045-d41a560e2ad3@gmail.com>
Date: Thu, 26 Sep 2024 21:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] io_uring: enable per-io hinting capability
To: Kanchan Joshi <joshi.k@samsung.com>, Hannes Reinecke <hare@suse.de>,
 axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>
References: <20240924092457.7846-1-joshi.k@samsung.com>
 <CGME20240924093257epcas5p174955ae79ae2d08a886eeb45a6976d53@epcas5p1.samsung.com>
 <20240924092457.7846-4-joshi.k@samsung.com>
 <28419703-681c-4d8c-9450-bdc2aff19d56@suse.de>
 <678921a8-584c-f95e-49c8-4d9ce9db94ab@samsung.com>
 <cb3302c0-56dd-4173-9866-c8e40659becb@gmail.com>
 <8665404f-604e-ef64-e8d7-2a2e9de60ba7@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <8665404f-604e-ef64-e8d7-2a2e9de60ba7@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240926_130836_672550_904AB0DC 
X-CRM114-Status: GOOD (  18.67  )
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

On 9/25/24 14:21, Kanchan Joshi wrote:
> On 9/25/2024 5:53 PM, Pavel Begunkov wrote:
>> On 9/25/24 12:09, Kanchan Joshi wrote:
>>> On 9/25/2024 11:27 AM, Hannes Reinecke wrote:
>> ...
>>> As it stands the new struct will introduce
>>>> a hole of 24 bytes after 'hint_type'.
>>>
>>> This gets implicitly padded at this point [1][2], and overall size is
>>> still capped by largest struct (which is of 16 bytes, placed just above
>>> this).
>>
>> For me it's about having hardly usable in the future by anyone else
>> 7 bytes of space or how much that will be. Try to add another field
>> using those bytes and endianess will start messing with you. And 7
>> bytes is not that convenient.
>>
>> I have same problem with how commands were merged while I was not
>> looking. There was no explicit padding, and it split u64 into u32
>> and implicit padding, so no apps can use the space to put a pointer
>> anymore while there was a much better option of using one of existing
>> 4B fields.
> 
> How would you prefer it. Explicit padding (7 bytes), hint_type as u16 or
> anything else?

Explicit padding is better than the current version. Ideally,
I'd like the new fields gone (e.g. if it goes in the direction
of per file hints) or prefer to minimise the size and make the
leftover padding reusable, but that depends on what the feature
needs to be extendable.

And what hint types do we expect in the future? Another question,
don't we want an apui that allows to pass multiple hints? Quite
similar to what I asked about "meta" rw, and it might actually
make a lot of sense to combine them into common infra, like what
cmsg is for networking.

meta[] = [ {INTEGRITY, integrity_params},
            {write_hint, ...},
            ...];

Even though an actual impl would need to be a bit more elaborated.

-- 
Pavel Begunkov

