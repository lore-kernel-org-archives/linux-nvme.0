Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48430EE6B46
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chld7W3Rbl2PUp6cBiIbC1iT7uESUsO9DngY57S8hBw=; b=p93j9Ql8Ap9HSLSTrpYVJp4BAh
	gQ7TuPynALjSXzFKbtRFOaf35tXrh5DcaYdL02i+WopwGJP7a69oicAn7+N2gUK5AJutr6hXH0Smo
	ryf1PicoiAp+DFL8K6UdfxgmyooLu/3V20yxCcOMLO4bJbK5znZc3XGLS1bLmWcvI0XPuAblixBvJ
	Sox7zFfu/6S0Yfj/MVYKc5x4No5upHi4MbOJy95NI1/zvlkY7DBqXk2nS2aD5pJVv2NLoy1hz0Xfl
	irKPYE7rBoytXjmw5UwJ5h/njshnelZblxMDTDjV8MKbeD9+5n+P5C+zuzphbTBPCTmpy2j4pNO48
	tXsvjAeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voQ98-0000000BeK1-01pH;
	Fri, 06 Feb 2026 18:01:34 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voQ95-0000000BeJi-3TxL
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 18:01:32 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso25362915e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 06 Feb 2026 10:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770400890; x=1771005690; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chld7W3Rbl2PUp6cBiIbC1iT7uESUsO9DngY57S8hBw=;
        b=gIVTnA7Mhv+Q3XwdwdDdI9u20Tx+p8bTtW+ogkkTL2lC3/oVRVKElt8Eu989FaMZKe
         /JjtUyoRSAltDuvVimC8roIBe0gTah4AZGlbiKokIGLODb+OuAZL/261fGsoUEOLF+ri
         J1mp/E8YOqoiWXWMTYJytQN4z0VccTkjLQPd7s3Fw/zXYjyhiQ4O9Thl51VZup2M3iwQ
         v82PHousSZfeYUz5KyjSyQihG/3zGAoGPdllcHc12xQiJ+EUzXwCilpwfxgTjoy17m6U
         wVL7iFYZMRsjM3ptv2vh6TU8u7QspOiZimFPwtIzLsv8Eub9mDG0VWkUwY4B7kuKu+5I
         m6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770400890; x=1771005690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chld7W3Rbl2PUp6cBiIbC1iT7uESUsO9DngY57S8hBw=;
        b=rseyz81hGNd9GSK1Ik2WmwGfIvnX6I1wrm6uv3a2AlZJCmsoAzQBkDDed4esxOuNMl
         vLxjWWGmkivMbN/hNVGgArK4PZwd6N+HjDrb+Dm2vNDdt5F4G7ETlr2mjj1iX2HYArMb
         ZKtR1CdfjGxGLNmrJyKtAo8EWiZwFJhtIKx1EqCGzPM6X2TkULjcrTmHxhNkF500JMDY
         X8/P17XXLROtHmljrz6RQJ6HgNVi8dYOARdLNQZ1UjaXY6Ubtp6h9qusHYEGpGWchQRv
         TQ9um2m/0JkBJYv22SkqGIF+1fyq6szrHWyuJlyUkt+DS1uehApwKRr5l44K/CtbMLQC
         OHAg==
X-Forwarded-Encrypted: i=1; AJvYcCWESZHAygOwaw1LR+nwVSpjVr7GjDEuxVSnwj8q0hoobBuIa2gxkNiBReUaMiwCL3AiNgreZJ1XsGlQ@lists.infradead.org
X-Gm-Message-State: AOJu0YwdxGnVLlq12gi4Y9wmD1BbIgM9DPMSURczT+aJ/2+Ovvh+tFlF
	qXLHysJh/Ibc4ejD+GaMJwHlI+x0I+sbDAmfVEIGnGkjdKwSKMByfFbf
X-Gm-Gg: AZuq6aKJE2xc71q7pn/3OambR3hfwtKI+x/8ThW9qlvkeNnU/bw8ruDbSkA2mkWte3K
	tColbbfVI7o34u11wx0k4mHQAIjc4frsDQz6lM80Fq5+ns0AUPCrbDXWZEx5fNz2G2k45yjo8ed
	DosM8OsuNHsKWl4RyJL1kuicsPonpUTMuzV8FWNujd8AK25m4z5CTc+rKUndbzOrWJR8kCUyutr
	eHlqcFhpUS/o5NDe8sPuH7qopb/QLzd5hSwxDgU6KnKi1dYQLElwwNzWk8eBnrBDW4mKhUJ35qW
	SwZ8mk5jY4SfC9bWBiKFq33dtfXD2BRhe7ubTGHmJG/kAPzB/+//WpVIbdvmXOubqi0+KFrWyxX
	7I5+D9hQKiSs/P2XtlSwUCjluXiorP6xUvTHf8d7ANXVYwjshBf7CzV52A3dopAOnV2tuSKWMZ9
	UCjhDLOLpwbTQ0NyCHLTkXglwNBobrCz00uqPq0oP8Gl087UZjBuWvDVhCgQti4wnNLA52NXsg7
	AQNxoFnoZ9zPg0OfOPkuu1aYQzRYhuLtmIseiinbBE6ePQLH8R6sdf2AQAzm9tYBQ==
X-Received: by 2002:a05:600c:628d:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-48320216d31mr49104765e9.23.1770400889507;
        Fri, 06 Feb 2026 10:01:29 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203e126dsm51230805e9.2.2026.02.06.10.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 10:01:29 -0800 (PST)
Message-ID: <b0ec01bc-4cbd-431b-bcdd-084cc14553be@gmail.com>
Date: Fri, 6 Feb 2026 18:01:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Anuj gupta <anuj1072538@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
 <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_100131_881320_9A18970D 
X-CRM114-Status: UNSURE (   9.28  )
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

On 2/6/26 15:08, Anuj gupta wrote:
>> +
>> +       dma_fence_init(&fence->base, &blk_mq_dma_fence_ops, &fence->lock,
>> +                       token->fence_ctx, atomic_inc_return(&token->fence_seq));
>> +       spin_lock_init(&fence->lock);
> 
> nit lock should be initialized before handing its address to
> dma_fence_init()

Good catch, thanks, I'll apply that and other suggestions. And I still
need to address bits Christoph pointed out during review.

-- 
Pavel Begunkov


