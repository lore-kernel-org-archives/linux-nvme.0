Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAB2D68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DU23KB9CDaJ/ylEjpMmh487mXVL8GrqTA9sTg8RR2Yo=; b=b8766LFCS0dqlTusjA0ia3sRXN
	S1TdZp5MdeTduHrh77iOwSJ8dHF1y+yYYkS7RdGScT0Q1AAstTS/imRZ+10rh/bOGxWOpSt+jjtyA
	dmTAuxvGOnQT6SlvK5G3iCnLyNKJrNFclbHJXLRPVc8DEUYMQrbv9aCSXxg7ugA2B07BeAMEuU/I0
	6pXzDzzj0B1R9SDmiR92GvbVrmT1IkjbPsL+MgN1JFbgVr9UdItdS8KHAw60N0bkYppBbQDovzWWc
	GuR2AR1TyRxh6AzQjFYGSQB1G8EFAQnesPogfMqrXGRnwT+6fE5nijUPDXWAENWnydgbS3m+UQ59Z
	7qpXzQgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzNH-00000003P3u-0nQo;
	Fri, 15 Nov 2024 16:40:47 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzMl-00000003OnP-45Q1
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 16:40:17 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso12668735e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688813; x=1732293613; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DU23KB9CDaJ/ylEjpMmh487mXVL8GrqTA9sTg8RR2Yo=;
        b=NHyQKnfXep7nOUXaAaqPrqkOz8WA5ewFMS+mLFYNHEuLRWomogisokEnhd+9dYRAh/
         hDsncg3QGzf2sSkbwXT3Oc3pvN7FzD7wq5QN13yVqtZ10k59Me4FITTItgPh1GeZVmwc
         ch8T8E1NGkO98oi/fhdifE3J5aKu/gfJy4RBpdr9hrDXdcxEKK0guFr2srPKKUKODHRr
         0e4x5Vk6/Hs1BRZ10XomGsv3A8rdYYSEUh562OxB5Gg/KmIwpBbrjxFggFWP09WOHQIY
         43kRKxf8K0nhX1zF1YAMUg+SX2mbWT/GH1hqC7/JWowmLrJPsMFsl95heBrh6Vqr0Fw6
         yh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688813; x=1732293613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DU23KB9CDaJ/ylEjpMmh487mXVL8GrqTA9sTg8RR2Yo=;
        b=AxRjbkyUBHkwN/XrTsx3m7Bj9lIAnAqOimYKhfSLmoKWImbuJOWqOxveo3/7MbvUpz
         F46I7UVHTzUOkpKWxWkFK/zz/b3hCR8hkL4UTSIaOicsEHvFGDY1DmTZyHO9okDZBGqu
         WSDaBIWau7W0DHdDLwCR0bs/t9lqTPZT0QUB61T5XZ69xs6mqXfBgn3BE6VjByEktRyb
         yu7m9TRVIjrfD9CnqS07z0i7pq5lFwnXhYR/n1t0lcUzWNcT6/7TiA9Jtb0sVpIcI1a3
         DrJw2N8KnEZvkehSvny184Rl16Hc4ycW/MRiXuPVQDPPmk4bD5KMB3VWm3wX/ITj44pY
         +DbA==
X-Forwarded-Encrypted: i=1; AJvYcCUVAtdHleJk2ki3YD9xaNmev9nPpeeyq7ZmMLsxdgenRua2LMD50ArwPWjTSFg4QG3CdIS9MnrSEV3V@lists.infradead.org
X-Gm-Message-State: AOJu0YxWVFnUFZKqWGncYQC2zr9FQg+yPfGP5d8OWhBssf88g6tkYgbG
	8VSl297SXYzwpCANjaSDn/lSXEy8x5H6LUHL3OKLQpkaib/cLFgh
X-Google-Smtp-Source: AGHT+IGYcRrADCDs0VXLudCPmoKNK8uAFXXrZZvU0GlTfdTzpK46osYHhclfaK73bM6gmSYsQl5j7Q==
X-Received: by 2002:a05:600c:3553:b0:431:405a:f93b with SMTP id 5b1f17b1804b1-432d9762473mr69603745e9.10.1731688813174;
        Fri, 15 Nov 2024 08:40:13 -0800 (PST)
Received: from [192.168.42.191] ([148.252.132.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265668sm61720245e9.10.2024.11.15.08.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 08:40:12 -0800 (PST)
Message-ID: <f945c1fc-2206-45fe-8e83-ebe332a84cb5@gmail.com>
Date: Fri, 15 Nov 2024 16:40:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 martin.petersen@oracle.com, anuj1072538@gmail.com, brauner@kernel.org,
 jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de>
 <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
 <20241114151921.GA28206@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241114151921.GA28206@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_084016_079898_4BF0C3A6 
X-CRM114-Status: GOOD (  25.76  )
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

On 11/14/24 15:19, Christoph Hellwig wrote:
> On Thu, Nov 14, 2024 at 01:09:44PM +0000, Pavel Begunkov wrote:
>>> Eww.  I know it's frustration for your if maintainers give contradicting
>>> guidance, but this is really an awful interface.  Not only the pointless
>>
>> Because once you placed it at a fixed location nothing realistically
>> will be able to reuse it. Not everyone will need PI, but the assumption
>> that there will be more more additional types of attributes / parameters.
> 
> So?  If we have a strong enough requirement for something else we
> can triviall add another opcode.  Maybe we should just add different
> opcodes for read/write with metadata so that folks don't freak out
> about this?

IMHO, PI is not so special to have a special opcode for it unlike
some more generic read/write with meta / attributes, but that one
would have same questions.

FWIW, the series was steered from the separate opcode approach to avoid
duplicating things, for example there are 3 different OP_READ* opcodes
varying by the buffer type, and there is no reason meta reads wouldn't
want to support all of them as well. I have to admit that the effort is
a bit unfortunate on that side switching back a forth at least a couple
of times including attempts from 2+ years ago by some other guy.

>> With SQE128 it's also a problem that now all SQEs are 128 bytes regardless
>> of whether a particular request needs it or not, and the user will need
>> to zero them for each request.
> 
> The user is not going to create a SQE128 ring unless they need to,
> so this seem like a bit of an odd objection.

It doesn't bring this overhead to those who don't use meta/PI, that's
right, but it does add it if you want to mix it with nearly all other
request types, and that is desirable.

As I mentioned before, it's just one downside but not a deal breaker.
I'm more concerned that the next type of meta information won't be
able to fit into the SQE and then we'll need to solve the same problem
(indirection + optimising copy_from_user with other means) while having
PI as a special case. And that's more of a problem of the static
placing from previous version, e.g. it wouldn't be a problem if in the
long run it becomes sth like:

struct attr attr, *p;

if (flags & META_IN_USE_SQE128)
	p = sqe + 1;
else {
	copy_from_user(&attr);
	p = &attr;
}

but that shouldn't be PI specific.

-- 
Pavel Begunkov

