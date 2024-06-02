Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDC8C25B74
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Jun 2024 07:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Mi/VKBiZjMcaZsYVmfXcA5vUMibCH5GQOs6BRjI06o=; b=FjOakvO/dOLHZHWOz78tmMICnf
	zZtjfD0gVcowVWUF2Ria14W/PBu6IrfOsgma3Cku/OyBAGtaR55nr0RyM8J9ZGvXi0wH6wUMUEIPT
	ffXqBYCDjbzRgdToG5SBzemzfsLyYwEeRlcJ2xmsCn4SalC6kETKo4nIFHBS+gJ+Q9wqBjJc0M5cD
	l1TqW5Zz3XBCA/HGit5fPRDybn5LnBF3KUfwpKS3lgRxaZ7ftFj8U836EU2T5UNM8lrognn3D/79s
	hYLaJtrjubzqopl1OP4R4FPlbiGLYP1oza4BDlL6JymKybO3HAl9Wp3ndYGNNAXnDGLTF9ryGTU58
	LXGF46Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDfx2-0000000Dufb-1qBe;
	Sun, 02 Jun 2024 07:48:24 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDfwz-0000000Duf6-2slT
	for linux-nvme@lists.infradead.org;
	Sun, 02 Jun 2024 07:48:23 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42112396582so2938995e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 02 Jun 2024 00:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717314496; x=1717919296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mi/VKBiZjMcaZsYVmfXcA5vUMibCH5GQOs6BRjI06o=;
        b=GYqTDpeMpVhErkNDH+g0wxKlpByyfPo+EM/y68amcV7s//CGCuwVp4oU9XvX2J+7mT
         MEilazojsaITLy7YsLOGnzBlfWw5NaP07D6g79V/Fvgt7LpVAsRVk/LFXrdGb7OKI7Co
         QfbQlIX5WXzSRadDX5ioQBcN6rQL5OTnVUhFSzyqyuW7YzqpxEBa97b8owHc5Y/1lHv6
         aInLjkuxgP2yVazn1Csf8LRFnOFWeGLc9NziJ+Nh9ToHvOK+j7DddX6I8ZlJHKKhfmYn
         aFQq7FVHfYf8Ob/Rsu/c4XMuyq6syTzDIY8DPgK919g0yHKlgPOOXGZtc5/7U5WuHl51
         YQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXbeFLwQbbw+IljGOzogqYoZ4079L5E4OD78MrGs72Enztp+nXqlv08WR16t41gW51KeqRUm+EfFIXmAM0zgtC/JzugLmv3VWciUuaQqD4=
X-Gm-Message-State: AOJu0Ywl2X8i3aDxrwJctIdJnORcGU4UDs9Zz8fwlVUeXT9bDvh/mB0r
	ydheYda4Nv1jnlfgFU0CkKlOfnrOnkM+azi4B1NiUFEQMtpoowNR
X-Google-Smtp-Source: AGHT+IFsCjXnSMmjNSZUGoj/v4xQvOLvmmlAnC28L1qi45HucRzp7Mm8nzhveD4Y6FLy0KHDf5ir5A==
X-Received: by 2002:adf:f547:0:b0:358:d0c:b9a0 with SMTP id ffacd0b85a97d-35e0f23ebc2mr4051664f8f.1.1717314495772;
        Sun, 02 Jun 2024 00:48:15 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062edcdsm5532084f8f.70.2024.06.02.00.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 00:48:15 -0700 (PDT)
Message-ID: <9f62247b-ae36-49d9-9ccc-6ea5a238e147@grimberg.me>
Date: Sun, 2 Jun 2024 10:48:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
To: Jakub Kicinski <kuba@kernel.org>, Ofir Gal <ofir.gal@volumez.com>
Cc: davem@davemloft.net, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 ceph-devel@vger.kernel.org, dhowells@redhat.com, edumazet@google.com,
 pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
 <20240601153430.19416989@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240601153430.19416989@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240602_004821_765960_2261BAFE 
X-CRM114-Status: GOOD (  11.77  )
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



On 02/06/2024 1:34, Jakub Kicinski wrote:
> On Thu, 30 May 2024 17:24:10 +0300 Ofir Gal wrote:
>> skbuff: before sendpage_ok - i: 0. page: 0x654eccd7 (pfn: 120755)
>> skbuff: before sendpage_ok - i: 1. page: 0x1666a4da (pfn: 120756)
>> skbuff: before sendpage_ok - i: 2. page: 0x54f9f140 (pfn: 120757)
> noob question, how do you get 3 contiguous pages, the third of which
> is slab? is_slab doesn't mean what I think it does, or we got extremely
> lucky with kmalloc?
>

The contig range according to the trace is 256K, the third page was just the
first time that it saw this !ok page.

I asked the same thing. nvme-tcp gets a bio and sets up its own iov_iter
on the bio bvec for sending it over the wire. The test that reproduces this
creates an raid1 md device which probably has at least some effect into how
we got this buffer.

With the recent multipage bvecs work from Ming, nvme-tcp bvec entries will
often point to contiguous ranges that are > PAGE_SIZE. I didn't look 
into the
implementation of skb_splice_from_iter, but I think its not very 
efficient to
extract a contiguous range in PAGE_SIZE granular vector...

