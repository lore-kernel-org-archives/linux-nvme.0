Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C99DC25B79
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwmN1/wcgDERsUT+7vZXM1tYtlmgawVxm4hFkdYbTEI=; b=mFyz3pEi1OpoyKuSsi3indhR6V
	G+AHmXJIVWvZQRzbIO5bI/8GbbjFltDQkBexc6rVthUZU/HLvw4CCb8pJGq7boZ7wqkdfm9dWLXtn
	bDs2zRX56dSftCMpTSRjYNvECTvwWEuxYUItgYSlkwSecYb+NHgIVLk3WnVRpnq0FBWMvH/3oCrTh
	j+29OFGYbCTKWIlhLXF+O+zR9u2Ggp8KYCpBTPDm/MdkWUVgmX298mkxmTbe1p3rOBd53dIeZcsSB
	E2pzJRGZllvx6nSd3EA7hgqaPirIIlLnA/wE9e1lE01R80elPOaPHUf8f9xPje9zNLXXwTN1GMuDM
	nO9TE1Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA9xB-00000006aF6-1dPX;
	Thu, 23 May 2024 15:02:01 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA9x7-00000006aAS-1ddZ
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 15:02:00 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-36da87c973cso3110365ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716476514; x=1717081314; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwmN1/wcgDERsUT+7vZXM1tYtlmgawVxm4hFkdYbTEI=;
        b=DOs7D6FV2fwiw316+sJ/m4PprycYGyQuQBOLVXEr2bruvBqTbtv1XMtW4CMWRcRQ85
         ELF6KEZu7pxQGX4g89eqRiNX6T6ZEcNdZ47UGHu/LbfmRiT/Dt8EwmSLKyt58oVrrSKk
         K4O1mwd6S12xJKOzu6tuISsAiz1EovofmeoPE3BH5QCZWBXvEKTaJLjo1K4UBoP690j6
         4IZ+lIz0LzmcPdXpQm3WpkDlT+AU1HO4Pbgs9IvEZBhT/H9HDQg0NW7oYedyZNdG03Gq
         vHnGgu7WZ12Y9UejoVfT+jQqIKagVtM3CPAW5KDf/CbBZB2L9lUo6M1PcoRx7VG9cP1a
         uc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476514; x=1717081314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwmN1/wcgDERsUT+7vZXM1tYtlmgawVxm4hFkdYbTEI=;
        b=ZzoHzFfmUygCRyP6hL2qg1XMMJk/2BDFEQdYbDf8x5hgDjvdY4D/ne3JHY0txqchX9
         VZr3uGLYMaIh9Y7geqU5prbpbpE66tARhwZZl61dw+ZC131WM0kWCfkcANzeQXJYNSfk
         senZIty5xtkzVV87+cdrxeuS6flgj1JGp/OxSBr1lu4SwAPu8x+aUn60fC8g/Px3wT/p
         IzngMWziDag9oz0zXyxvtGxudbqMVBgcR2sw4Bml7MFSIJiu8s9KITkppTCjbQxIt/4v
         rFdM4m6gXy2miHDObzH6b8PNcObs+PmvroSScY5eWhGsAUOg0tNB4xkwRmlXTzKZpWW7
         0oqw==
X-Forwarded-Encrypted: i=1; AJvYcCVgp8Lwrq6Ilpnw+O6eZrwKXxCM+mBWLRxhR8RetqK275A++50pyS34J+9CnzKfjEACvRZQ7dWa55RW1gWDJg8ETHaliisR4XjjbRdNM48=
X-Gm-Message-State: AOJu0YxAqu0ny7YribEpFar3bsDr2zXRxNEtOSvc8k06yN+AFFZb/Eb9
	E9AnDn90ZKxSKqV211CNXQGwR8lv9od8QuzxhBAiep+mEWbPTBockYSS+hp7WjI=
X-Google-Smtp-Source: AGHT+IHVmz1AA++sDfIunHQVTPZc2XbKAqF221gNkGhUA8RDMTfsc9xZRdyGFYY4e4U1yfCatj6GJQ==
X-Received: by 2002:a05:6e02:1447:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-371f92ff411mr67410825ab.3.1716476509096;
        Thu, 23 May 2024 08:01:49 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3714fa835dasm12756975ab.58.2024.05.23.08.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:01:48 -0700 (PDT)
Message-ID: <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
Date: Thu, 23 May 2024 09:01:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>,
 Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
 <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
 <7060a917-6537-4334-4961-601a182bca54@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7060a917-6537-4334-4961-601a182bca54@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_080157_748816_6F9B533A 
X-CRM114-Status: GOOD (  22.24  )
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

On 5/23/24 8:58 AM, Mikulas Patocka wrote:
> 
> 
> On Wed, 15 May 2024, Jens Axboe wrote:
> 
>> On 5/15/24 7:28 AM, Mikulas Patocka wrote:
>>> @@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
>>>  	return 0;
>>>  }
>>>  
>>> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
>>> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>>>  {
>>> -	return NULL;
>>> +	BUG();
>>>  }
>>>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>>>  #endif /* _LINUX_BLK_INTEGRITY_H */
>>
>> Let's please not do that. If it's not used outside of
>> CONFIG_BLK_DEV_INTEGRITY, it should just go away.
>>
>> -- 
>> Jens Axboe
> 
> Here I'm resending the patch with the function rq_integrity_vec removed if 
> CONFIG_BLK_DEV_INTEGRITY is not defined.

That looks better - but can you please just post a full new series,
that's a lot easier to deal with and look at than adding a v2 of one
patch in the thread.

> @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
>  			goto out_free_cmd;
>  	}
>  
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>  	if (blk_integrity_rq(req)) {
>  		ret = nvme_map_metadata(dev, req, &iod->cmd);
>  		if (ret)
>  			goto out_unmap_data;
>  	}
> +#endif

	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {

?

> @@ -962,12 +968,14 @@ static __always_inline void nvme_pci_unm
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>  	struct nvme_dev *dev = nvmeq->dev;
>  
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>  	if (blk_integrity_rq(req)) {
>  	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);

Ditto

> Index: linux-2.6/include/linux/blk-integrity.h
> ===================================================================
> --- linux-2.6.orig/include/linux/blk-integrity.h
> +++ linux-2.6/include/linux/blk-integrity.h
> @@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
>   * Return the first bvec that contains integrity data.  Only drivers that are
>   * limited to a single integrity segment should use this helper.
>   */
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> -		return NULL;
> -	return rq->bio->bi_integrity->bip_vec;
> +	WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
> +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +				 rq->bio->bi_integrity->bip_iter);
>  }

Not clear why the return on integrity segments > 1 is removed?

-- 
Jens Axboe


