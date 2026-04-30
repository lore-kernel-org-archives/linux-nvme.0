Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92221FF8873
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+sxVPeWzK/5JcscdkmY85m6FCWps4Q/alwynbpD7Pbo=; b=JcXr67VMKBGOKCnr/hoVsluqb4
	U3KI5nTCLiuln4miu92NguGlzbRqJjGctUsK2MJDBvkIJWLbucfAs63uqUWcCIpyaNPYC/re0UHfj
	jQhqWFWEXWoJQwneIHQ3aJy7y5KvuMq8uKXth4IpbukPa66qm4e8foTX4CobM52167L8OjSbTTPBf
	WphJAdCz9A5b4OY1gQ6IJorgehgw/a3xwC++Ad3vXgGHgfLZ+mUKJ5NwKmdCIq3kW0//53ZMWgc4s
	48GDDZP7Y5opHxo47n1ZT3LNxD5N9mPSfJvNKZqfaeZIxP+7YLKiqfclw/2pXX8e+ZOKcFZZuAH/W
	bugVGS6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIVyN-00000005osQ-1liH;
	Thu, 30 Apr 2026 18:18:51 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIVyK-00000005os1-3v7Y
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 18:18:50 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso10933025e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777573126; x=1778177926; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sxVPeWzK/5JcscdkmY85m6FCWps4Q/alwynbpD7Pbo=;
        b=RRdDZEA3HAYw6GHJMq/VkHh0aqqz0x44qvBERa0z6n9irbMflRCSDciskaM8uJVC0j
         cueR7os6UnwCCLrVj1LGfZJEhcwTpV+dn2WARRlbW/fKrcx31RL5gKQubpujNCXMDP58
         ej8sJhbYD9dmmdh8iwlVPcNVsbBzFzb9PM+N+ErESKGLbavTzrhPHQR7wrqCSyQgTai5
         aytMiVsk4g+7MbGA7ng65LKv8etHvqTOS3tl/6A9b6e2lBLM4Ajpn2NabEI+vPG5hKt9
         FeIKzAg82ggvvDpeKSyKWYnbfXBFsGK+94GzX6VwKJLfEHKtfORILnHkZT3Zl3V825jO
         7eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573126; x=1778177926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sxVPeWzK/5JcscdkmY85m6FCWps4Q/alwynbpD7Pbo=;
        b=KW1Ag8cDtAEngOcVjtlxzwV9649dk4IS/GnD2J2N12CDbIpU1BBh3TqEonFI0bkWCG
         PdKNQIQ5Sxaqyu0x6/6pyNLcZeNXrjms3vcbM/mWNeil+4Z5StcHfN0uFEwhEnGeReod
         Scd7XDQ8bnVWonWENpWiihD3h10KhS7dkjoIw3GRqUWXbprveUvRNOtHKwx/Smos8LVp
         FQCrGN1zQgWuj4FeJzGCGchmLOMDa56+NYMjgDNfRRMyhQfgm1K4JYogFaBLsIsWurMc
         EEU9qGas61bVAVfdj5bIZp6Z6QXmVeAriHo80/cqVLWXVs8k1TZHGu+2B/0hUQK99IzB
         r7Cw==
X-Forwarded-Encrypted: i=1; AFNElJ8QC+o8uRpPW+ABWmKdpEiiVuNm56sZFlWZ1GomGUsdE6668KwMn2+1/yScg/5KnQ+ckCon+NJNQZTn@lists.infradead.org
X-Gm-Message-State: AOJu0Yzc6f7TOSagx9uBK2T6Ea8btecTFu8/WqcqkrOU3tAFDRxlYWtB
	ikUGQaL3P9YXdBgKWqkbz2HPNWyvcMw/zpNEQd0k0JwwMXRKF57ui5Ae
X-Gm-Gg: AeBDietTOlbdUBNrjM//RaV9K0Z3F46oBiZDjSU9x1VzIeTY6yQh7/EooVKDy4aMkBh
	8oXLJrPjZfS2WvLXI8oLJMFyWjl2TQUkpSXdUbhmkM6z2Q27lFdayrHgDDAR11qQ0BbCzfm85vj
	2wG86ETi4VcpI25qqS0boQXwmG/rfr+WhDy4vxoCU5VA8Ml2hzYlOWnqlRAYQdHvlrCe6fGVItx
	XDVvddBUk4qXC6hZuudwgoNKhZ+UOoKAVLsGRcnR8yE5Q5C/kzf/tgiBjUJBeMdbvtedXMyLnV9
	mP04UV9lKQ29zuuypz06WyH+CeqOlRcn/j7kgHar8Tfq+BvrJcuI8HEJ/9jpgojDqc09qTimwA5
	yeu4S06GM5qqycN7z+/Nzv/XJdvCQECyxCGWrcB22SXGGLjpdAmK5BFe81qZ6dXUwb6P6veD00X
	TYxSZnGKWqRTFwL03t3JB96QGvkXYXlLRMJDRaIL+q+XlvxzfL7ymJ41CA2JRi/I1rhLMkslvnA
	8ZQCepVtd8bx2+MCq+wL4d2uM1fXDj1+C47Vu8zF/id0+7vkzg+JjgBScvXBZH1qspt44zfu6pt
	Kg==
X-Received: by 2002:a05:600c:3495:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48a83d62ffbmr66464485e9.3.1777573126483;
        Thu, 30 Apr 2026 11:18:46 -0700 (PDT)
Received: from [10.109.92.8] (net-2-37-141-89.cust.vodafonedsl.it. [2.37.141.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8d15fdedsm3944495e9.4.2026.04.30.11.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 11:18:45 -0700 (PDT)
Message-ID: <7f091660-2e60-4de5-a3b7-7b8d206fd6ab@gmail.com>
Date: Thu, 30 Apr 2026 19:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Maurizio Lombardi <mlombard@arkamax.eu>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <DI5RO76D5IWR.19K0ES58HUIVS@arkamax.eu>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <DI5RO76D5IWR.19K0ES58HUIVS@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_111848_998143_DB461FB3 
X-CRM114-Status: GOOD (  12.27  )
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

On 4/29/26 17:07, Maurizio Lombardi wrote:
> On Wed Apr 29, 2026 at 5:25 PM CEST, Pavel Begunkov wrote:
>> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
>> dmabuf when it's mapped, which is then used to initialise requests.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
...>> +
>> +static int nvme_create_dmabuf_token(struct request_queue *q,
>> +				 struct io_dmabuf_token *token)
>> +{
>> +	struct nvme_dmabuf_token *data;
>> +	struct dma_buf_attachment *attach;
>> +	struct nvme_ns *ns = q->queuedata;
>> +	struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
>> +	struct dma_buf *dmabuf = token->dmabuf;
>> +
>> +	data = kzalloc(sizeof(data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
> 
> Shouldn't this be kzalloc(sizeof(*data)...) ?

Good catch, I'll apply it all for next version

-- 
Pavel Begunkov


