Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED19BCD5BC0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=; b=UPZ/nF+Of0dc/uJvVNSDVSAh8F
	ceXf3BK1ds2wf/EQepl/TyDisDy2l2eoale/aVmRapdHtXq5NByF0B/0mf+s+DpttCjSsn5Wo4P1+
	uGeHJzWEH9inlmdlajqi9EaRcl02NfIm1LybuRN5uFg8h1EQJqpm17zIokLZ1+iTYdQnWcIPIOBoU
	z+ladB3igdCj6ur1v7q7PIW24lc0EvpemxsJNTYdAihy5djWqAqZ3/w/GO1U/Wws9aIvCK91HEDR5
	sT3T++VA/fm0ji2It8n8qiM0JfYuMsMZx2aKjGqOyiynqyY9R8ZpcsvjcskSV7c2y9F7ySXx35GI/
	UBW9K6Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPkS-0000000GWrt-2xrK;
	Mon, 25 May 2026 07:29:16 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPkP-0000000GWrF-3lFD
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 07:29:15 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso18890265e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 May 2026 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779694152; x=1780298952; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=;
        b=jxYzTkI45IoHKTY+I9TnUEzPo0VfWTCOVQNC3Mp36wiZjNJj7eGqhILqejYfs+j4Yf
         rcSjON6g6sanas/zVsCxBQDD3P1/RNAArky/2NStZks2UVeofYuDZear9RA5thEZb0Ey
         Eyg7NgD8a3QlyBE6q/jJCAC3gc6AY7EHbhaSowSj4lS7f1d8v8eGYmXd/4E7iJhLns+Z
         7X6IGR2CpN7K/buozjWzQN/ft13VBw/T9c1B71Wpf/Ogzm8CRraJE1dieqDE0BcCj9H5
         8vOHzdyV85PEzIb2/UKXM/RyXhc2g4HXGTd7xgvPWf0G70VUOOYUnl0ewZXwoR4nJNzc
         oUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779694152; x=1780298952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=;
        b=KFO21uu/RHSaYN4hTmEEtbBHVIsXYl3Y9C7pqlDJ4qxkbe965jlNfeI02lWPCbq0eb
         T5XfhnxObe7Qb7U5MchmCGETfB3ZujrqjwocwzsiFYnRhc8esY5s/Mn57EI8ncNqBVs+
         Ird8btS9IqtYUlHWIAkoLRYCKpMMKruNeCRk6SYTUZNyBt+E4VRzJURZemeE9vTxsFyk
         EXMMJTcaHFcHpSiUESlF0LpJuvGMBhwaMR1XydOR8E5KIZ+LSbV3Y6Kdm06IUyEiLfLH
         l2ch6LclNlHqkNtH7BXLZo/uAyR8Nz2KcLbBir8bKqQqY52B36moa0lgFkpi2dU8N/nF
         8ayQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6kDfbxkDgpDmIOE/jK/t4938UeNSkP2LTn00vTj1N2UeDg+Ip/MLKsWngcFuZc8Gh322ute4vqJsn@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6hgjEvi6flTo7tSufvydPfbCKVvnXyOOzgZfVt0cL2gGljg/2
	oq9GXwR4ZvL0Nme5Rr+0/DEailR1VzNOrqshtDW1+XaJZY2q2cwN4rg5
X-Gm-Gg: Acq92OFaCQNL9EF5CSQJ7c1uirEZGIubfwu8+B5h0OnS5wx99GwOD1+2iyCEAa0bGhU
	71CnDXoI+nHQGK7ELhF7HHjbbJ4xbTUn7haRJor5xenI67AU36b32cEMmjpUXpUwRW4IdmsXtUo
	UlHSdaYoDVxHB1WAq8ZoxkPVXn0U8/vQRHGcJ39dxme3KcpdNkGmOuZKYEjI8h+rlU7XIb3psG9
	CHSTgKyvT3ZlED2vB3VaU7Ru2zgT+GRAfIY+9p3CrWqjwjRxpFGXY0CtTf5U5j6PJFVrehFURbX
	qocdc45LMUzDAnsbe0gmtbHJXgX1WvJlNBpyfIum6g3qpF1qj6t0dDiTHcumMfOXMCKghCP0udp
	7xS7xfQgnrkaQz8HpJRUG8XiMHHMnoxQ01U58/CXRYeyyThITTpZA6nqAh67vw6ehTk5h71pP32
	w6hKHVQSZF5SluZh3gSxc5XA5la2PiVYSRyoYF2vxKYh0txeivJbEexf4zBW4eGK+iqR2lBvp/Q
	91jrshnyFuSEqpqnw580juzmDlqv8ov74lYufOVEKVh8AdHadmiQjy4EuEe6sOBAjfxq9INZeaw
	joguUFrg5RTRMlxJGshdBd0=
X-Received: by 2002:a05:600c:c4a1:b0:490:1640:8269 with SMTP id 5b1f17b1804b1-490426d1a16mr227253215e9.18.1779694151663;
        Mon, 25 May 2026 00:29:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4cefsm81771025e9.14.2026.05.25.00.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:29:10 -0700 (PDT)
Message-ID: <57ae2e2f-8523-4cba-ad77-920535edd236@gmail.com>
Date: Mon, 25 May 2026 08:29:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <20260520083043.GA18893@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260520083043.GA18893@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_002913_952652_9EDC5CD7 
X-CRM114-Status: GOOD (  18.84  )
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

On 5/20/26 09:30, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 11:29:54AM +0100, Pavel Begunkov wrote:
>>>>    	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>>>    	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>>>> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
>>>
>>> Shouldn't this be a REQ_ flag as we should never mix and match bios with
>>> and without this flag in a single request?
>>
>> Do you mean adding both and propagating it from bio to req? submit_bio()
>> takes a bio, so we still need to set it there before it reaches blk-mq.
>> And there might be bio-based drivers using it in the future.
> 
> I think I forgot to reply to this, so let's do this now.
> 
> REQ_ is actually used by both bios and requests, so if you set it in
> bio->bi_opf it will automatically get propagated to the request, but
> it can also always be tested on the bio, including by bio-based
> drivers.

Ah yes, good point, thanks

-- 
Pavel Begunkov


