Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EE6C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7SIWr2ThFzB1tHI24D8Gk5qOz2TXXbNyYjOp42ZCuA=; b=BGOhpTwxGJ5gjEoR2p+ebrIT2u
	0SbEvISe6FzNaSr+3Tn84VZanrbn53iBKT3xf7rz/s9iIYfKbRsHhNWDf6dBIHT/VbXjFXyN2+bQd
	GmKKYyjFvzKXhOq8RZi5StxaUjP4L0aQy6qsC3bLtCCglKNhRtqtX+UQ1+AuBrBpYc9obyUTFRsZ1
	2fvO9bztrbCvPU0DMYGKMkPhkv+GGGjHguwgZ2YNRJT+rAaxIUZB58RJPBfA8Ymod9mSp4dv/q0PQ
	M+ie7tjOHaVcVyRyw+2ZkW+Jh8OEZha0KuKA2OIxHEf09WSLK9I2DPaWfYaJObMhZmU5rX5oY9eH+
	APyxy4aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnzKn-0000000Asgc-17Q2;
	Fri, 28 Feb 2025 12:19:17 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnzKG-0000000Asb5-0gaE
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 12:18:45 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5e4dc3d22b8so1322605a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2025 04:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740745122; x=1741349922; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7SIWr2ThFzB1tHI24D8Gk5qOz2TXXbNyYjOp42ZCuA=;
        b=LvM1WCyMNkone/kGq44NFId0WdvGWoQVMAoBeriLMlnL/5H264UQ6QgndOE6GpZstq
         QPzCMs2J62xN+2NJk2BDtz0G62fSP7orERpZUe+wVhIZFm1bIZHUs70bUl9uorL0ccwg
         lzlhZo70YYIMSNA+58ftH+2SU9NjDmcQ8Cp2FGaXqfa+GUJQtTsNix7xlwPZ/BKL6jvI
         8KBee0xdaTyUkatZYp+qn/43ueC0fVapQRfjUZzw+Kb2SHzOmzjPYEynsTiDqhJAL/n5
         ZIvRHwFp0FKpJjGCNUXgB4E72dvveVnSnZfdZd/bcdeQ14jnyKjDf4NT2yovCr4zkSdn
         qDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740745122; x=1741349922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7SIWr2ThFzB1tHI24D8Gk5qOz2TXXbNyYjOp42ZCuA=;
        b=NvpTHxS7MmsJTkAIdmQzns6ER3fptBuDv4cMLrFCPuaDmSXk1v0686DsRBZ8WzDupO
         5vfJMIB16tVfBxeVjtLKoJqc1FzKgjlx9zUMbOjoe+JdmAZ9l1i8UkFRwGxs5vO5t3rZ
         iAbGapRtUql6/9HUzjblePzI1hSfMzRb2VgaPV2/WqVc/aEQfkCEClHcW4mVqse6y+oU
         z9mz1/cKJ9b8ZHHRd3GDBk9wB5/3ZBfKK9u8d0OBr4LqM3yzw9ZWj+pBp5axMjUvmBQ1
         SCwlGjDY9dhE7c4BRe/XDbNXpu4EqqjJjgXvICnMfXwaiLHFQWEivhhHOSVgPdoh+m0J
         m8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUUqNQXSWnl1Lxvb4rN4p4EIcM9wEZSETlcg2NCCVRiBdkbsbusyBPs+/4Lg+3BCAFNZsmo5gkLkyiS@lists.infradead.org
X-Gm-Message-State: AOJu0Yw939suu/fxFTD88NLbeOid9HL0D5URedc7zvMFb0y0D68g9CAp
	r1LmGZZyN+nCIJxim7zlPg5ktB/6/8OmpoUVY7LBTghaUDVFVsar
X-Gm-Gg: ASbGncvseHLrleSrjzuR3OtAi6LTi+96wBkYNegzz+ylyAnKsDtiRanfpod0jv5/EP4
	Z5ICTIKRrHsC5Iso1JxoXyaB0/2lcKtQkpJmGcZvg+8rBtqm7kT/+j7KwMR5doiiK+PnJUEHWzg
	REq0ds5s+OQT/vkcUvb7XpPca0Y7S1xptTRGks0PAMtVSQDvfD9KlD3xr1IZnSZtvw1A/SOKCrK
	WpSmUtIR6xkyhv0m6Ad6+j3YkQktZwxTMRABV1o0Tnq3F3ldm302cK8BTe61b2gq92gCUqWAVmd
	SBM8LHPk4bbBzO5NZSYsQUYSf8nEf/09MPGs6kcgyO49THg6q5BrqmwROh8=
X-Google-Smtp-Source: AGHT+IGPHyLQsed5yUeRTWv+zphJytb9RblvbLpHZXgnTPHxwnh00nVYpIFZ8NrCIb54H4NVT7eoAg==
X-Received: by 2002:a17:906:c105:b0:aba:6385:576e with SMTP id a640c23a62f3a-abf26207785mr343879866b.3.1740745122166;
        Fri, 28 Feb 2025 04:18:42 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:aa16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9cbfsm286933666b.14.2025.02.28.04.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 04:18:41 -0800 (PST)
Message-ID: <9676dac3-446b-4476-819d-e3b2f4bd18ae@gmail.com>
Date: Fri, 28 Feb 2025 12:19:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/6] io_uring: add support for kernel registered bvecs
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com, axboe@kernel.dk,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org, bernd@bsbernd.com,
 csander@purestorage.com, linux-nvme@lists.infradead.org
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-3-kbusch@meta.com>
 <844f45ac-e36e-4784-9f8d-528b022dff9c@gmail.com>
 <Z8DrH7sBSS752Z3o@kbusch-mbp>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Z8DrH7sBSS752Z3o@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_041844_224733_25167A05 
X-CRM114-Status: GOOD (  16.00  )
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

On 2/27/25 22:45, Keith Busch wrote:
> On Thu, Feb 27, 2025 at 03:54:31PM +0000, Pavel Begunkov wrote:
>> On 2/26/25 18:20, Keith Busch wrote:
>>> From: Keith Busch <kbusch@kernel.org>
>>>
>>> Provide an interface for the kernel to leverage the existing
>>> pre-registered buffers that io_uring provides. User space can reference
>>> these later to achieve zero-copy IO.
>>>
>>> User space must register an empty fixed buffer table with io_uring in
>>> order for the kernel to make use of it.
>>
>> Can you also fail rw.c:loop_rw_iter()? Something like:
>>
>> loop_rw_iter() {
>> 	if ((req->flags & REQ_F_BUF_NODE) &&
>> 	    req->buf_node->buf->release)
>> 		return -EFAULT;
>> }
> 
> For posterity: the suggestion is because this function uses the
> file_operations' .read/.write callbacks, which expect __user pointers.
> 
> Playing devil's advocate here, I don't see how user space might know
> ahead of time if the file they opened implements the supported _iter
> versions. I think only esoteric and legacy interfaces still use it, so
> maybe we don't care.

Sure, but it's not like we can do anything about it anyway, we're
not going temporarily mmap the buffer into userspace for that. Normal
registered buffers use user ptrs we stashed during registration,
but I don't think even that is the right thing to do.

Reminds me that Jens was trying to completely get rid of the ->read/write
callbacks in favour of *iter variants, maybe that will happen at some
point.

-- 
Pavel Begunkov


