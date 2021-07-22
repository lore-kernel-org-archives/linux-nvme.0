Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5261EC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 20:24:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5D460EB1
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 20:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D5D460EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1aFKHi4KkdgIDBVZA3OXOtuhKZC6FNVeHm9lZBRIr5Q=; b=oKSIKlcN0tihkI3Ota4rOXl9dN
	MEz9Ja+CTJrXvZvfIVNLY2/q1HK+qcExstD+qbhC3qOcESDb+AmzMyZZ593HJP4FUfHoxsKuL4CkY
	sy0QDRdc64YeVQ+qmupw6kgGSvCnm90NBLfUIx6X9MrIKEKgwtnDAj4I/yr1lMqf5orgaKYz240Eu
	KkxKNrI0ZNsOdhjghz/zQY/I5AAOL3+f6tusr6z0WHI8J6oJnEtwD1zUOb9UMqwMUJxhpF8J0esgr
	xwAh2MVuUAJHodLKzQKe7gUtlpXSDqY4khFK+VADLRwptrr4Ra3pUdPtGXgvFnB5jq0KRh3aREO+M
	PnSCSOqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6fEe-002guW-88; Thu, 22 Jul 2021 20:24:00 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6fEP-002gtk-C7
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 20:23:46 +0000
Received: by mail-wr1-x432.google.com with SMTP id f9so7201580wrq.11
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pDRzsfWNbIGxMOyGMfCCilb7XZdT846IuowuCU4dEF0=;
 b=Rcxa01wgsj9B0fVLSqmJnwHEcjScWIW8zXSqF2GzhCDTC3DA0Z1Mxk6bIuYCYeAtAN
 TuTjgAfh4ZYYqU58MmxnfSSEIaJb5mH/O4eP7K8x42MLuowL3VtvczPeY7fxoquSYB+l
 zZzCZh+z3vnCKEZqYwzlztWZ5EhlHj789LIHx/jFJ1VugIxGsuUn27AT/pVuXKwRvqGD
 Xi0AWA6Z63Y9TAUEwpd1GspPL//84FRiOTt9O3gVr11omcvYTVa+2rH7ITPaz4CxWWyU
 7pZmyJ+p9xABJzZ3TCLhWUrCitng9yvr0dWteV61ThfCC6fCyziw2h2Eesj4BGtQ5GRU
 NUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pDRzsfWNbIGxMOyGMfCCilb7XZdT846IuowuCU4dEF0=;
 b=tnXbNSgJ6ZhqsA3S5m1b4wvfknvd6DjfvEiHQtLW0phrXPBQP4So81qeQfWPtJDoCp
 UUERAsy3gRleR0Oy6JLAYgKT4irWJzTH/UN+Ca5Qae4kiAgOeJwsFTRFBXDJjy9tV6iT
 oxsyU8rXwKo+JF8atPnrBt4DHHoF3e+8NyZtjYYmhfhdbmT3JYZTkYxASjSsOwqPPAfo
 W1MgNRrQvYulE9GGcoZLdZteisfgagKiS8KvxbFPmbpp+Ie/Db9asypYPB5P7TH+V1fP
 Db7CwnAiGOO3+awohIfOHc8vug9QDbbFAnVWdP1m1+aMaSjJiUHjMTGZQC/pElRYFShE
 SG4w==
X-Gm-Message-State: AOAM5308nClegzUbhphp3aD8M9C4Qg/qfOWeGFLYjPl8ibclX6CHabPB
 W+YDBgBfy0ZYN2TUPQlo9PE=
X-Google-Smtp-Source: ABdhPJwhYVXgPJAWS08IIetPM9lId5ud3Uo5DxHgFl0bklH6Kq8Z8fAOUZfg2VpA7YBrnbUmrUZrGg==
X-Received: by 2002:adf:d235:: with SMTP id k21mr1736681wrh.222.1626985423687; 
 Thu, 22 Jul 2021 13:23:43 -0700 (PDT)
Received: from [192.168.1.28] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id y3sm31142636wrh.16.2021.07.22.13.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jul 2021 13:23:43 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 02/36] iov_iter: DDP copy to iter/pages
To: Christoph Hellwig <hch@infradead.org>, Boris Pismenny <borisp@nvidia.com>
Cc: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com, boris.pismenny@gmail.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, benishay@nvidia.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, Boris Pismenny
 <borisp@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 Or Gerlitz <ogerlitz@mellanox.com>, Yoray Zack <yorayz@mellanox.com>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-3-borisp@nvidia.com> <YPlzHTnoxDinpOsP@infradead.org>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <6f7f96dc-f1e6-99d9-6ab4-920126615302@gmail.com>
Date: Thu, 22 Jul 2021 23:23:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPlzHTnoxDinpOsP@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_132345_476796_886340B1 
X-CRM114-Status: GOOD (  22.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 22/07/2021 16:31, Christoph Hellwig wrote:
>> +#ifdef CONFIG_ULP_DDP
>> +size_t _ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
>> +#endif
>>  size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
>>  bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i);
>>  size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
>> @@ -145,6 +148,16 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>>  		return _copy_to_iter(addr, bytes, i);
>>  }
>>  
>> +#ifdef CONFIG_ULP_DDP
>> +static __always_inline __must_check
>> +size_t ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>> +{
>> +	if (unlikely(!check_copy_size(addr, bytes, true)))
>> +		return 0;
>> +	return _ddp_copy_to_iter(addr, bytes, i);
>> +}
>> +#endif
> 
> There is no need to ifdef out externs with conditional implementations,
> or inlines using them.
> 
>> +#ifdef CONFIG_ULP_DDP
>> +static void ddp_memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
> 
> Overly long line.
> 
>> +	char *to = kmap_atomic(page);
>> +
>> +	if (to + offset != from)
>> +		memcpy(to + offset, from, len);
>> +
>> +	kunmap_atomic(to);
> 
> This looks completely bogus to any casual read, so please document why
> it makes sense.  And no, a magic, unexplained ddp in the name does not
> count as explanation at all.  Please think about a more useful name.

This routine, like other changes in this file, replicates the logic in
memcpy_to_page. The only difference is that "ddp" avoids copies when the
copy source and destinations buffers are one and the same. These are
then used by nvme-tcp (see skb_ddp_copy_datagram_iter in nvme-tcp) which
receives SKBs from the NIC that already placed data in its destination,
and this is the source for the name Direct Data Placement. I'd gladly
take suggestions for better names, but this is the best we came up with
so far.

The reason we are doing it is to avoid modifying memcpy_to_page itself,
but rather allow users (e.g., nvme-tcp) to access this functionality
directly.

> 
> Can this ever write to user page?  If yes it needs a flush_dcache_page.

Yes, will add.

> 
> Last but not least: kmap_atomic is deprecated except for the very
> rate use case where it is actually called from atomic context.  Please
> use kmap_local_page instead.
> 

Will look into it, thanks!

>> +#ifdef CONFIG_CRYPTO_HASH
>> +	struct ahash_request *hash = hashp;
>> +	struct scatterlist sg;
>> +	size_t copied;
>> +
>> +	copied = ddp_copy_to_iter(addr, bytes, i);
>> +	sg_init_one(&sg, addr, copied);
>> +	ahash_request_set_crypt(hash, &sg, NULL, copied);
>> +	crypto_ahash_update(hash);
>> +	return copied;
>> +#else
>> +	return 0;
>> +#endif
> 
> What is the point of this stub?  To me it looks extremely dangerous.
> 

As above, we use the same logic as in hash_and_copy_to_iter. The purpose
is again to eventually avoid the copy in case the source and destination
buffers are one and the same.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
