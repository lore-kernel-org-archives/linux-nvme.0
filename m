Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C23C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oi/++AM86hQyi+QYKhOHsLnIasDTZEsqZxanEFqTzjY=; b=KN2fS54EYMJcJr6hrggNhE9Wge
	SPBxtmqYsqeC5RnWsumjYR+x8w6/GOZ+Wg/kebS5dSNzXT09p3LYxXd+vzzt1s3MhFT50SXQdMliR
	22mVEz/gUHXdVOkydymcjDHoK2SiWC1BxJHa6p6+Q+vsPovJ+pwpcES9puNdftjik8P/rExBlCzAp
	vz4b9lXIatLxSD/HeeJkdiJeZa11RIah5wjVrGkJzkS6IQk2AAvWLQv/YRk4LlB5sqeRgvSh6DGIt
	BI7vyML7hJmwL12UPpAWdq7JkcDtFJkOVycdMWLmEL0zdYTuL5/GNh3O1r4FRB90E8GRURvkGI/jc
	aF5cpBLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqMZR-00En6h-8c; Wed, 02 Nov 2022 22:50:53 +0000
Received: from mail-pg1-f181.google.com ([209.85.215.181])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqMZO-00En4R-UP
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 22:50:52 +0000
Received: by mail-pg1-f181.google.com with SMTP id q1so101307pgl.11
        for <linux-nvme@lists.infradead.org>; Wed, 02 Nov 2022 15:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oi/++AM86hQyi+QYKhOHsLnIasDTZEsqZxanEFqTzjY=;
        b=3g+d94xYhCZXxTxm25WXzCcS3jlITGPZpjtFrBpBzXal5BfEX82wFoLlDynKbSGwSV
         Y4dBFP0uQUIwn2hA9UC2c/8xIObUDNu0greTrywHINwxsz8/KCnYQJW9lxVx4C0/TALM
         +4G19s9rJ5IjnlVWw73HFw+v6YiFQ1GVZ1hskGk23sgs04OgPa0amIKGYtfMwuW7ypHB
         yvWO4TA3Xl0PjYuDJEt7X6ehqODZ0xj3tVMP7e0oCOQ1zuE/D4+Z7bxUypzye7H6Udh6
         VxNDU3YieNw/OmJvZggrlh6rxGI2p422INn71IT3zeVNqeSU2ptRDMptOTLxxEsulOO/
         tHsQ==
X-Gm-Message-State: ACrzQf3N58GHX9i0mwmG7TYCRksUuA75Od23qnd7kccpYNeN+mQTREvD
	7RLr45rwsTH1GtnSsS2/pms=
X-Google-Smtp-Source: AMsMyM6bPaD6vkm2t6htya5qjFAYxNj4UjVLLKBnOw0YiQYnA2cdZTgepQevyScmNi+GFrRNkBEHRA==
X-Received: by 2002:a63:5909:0:b0:46e:c98d:e07c with SMTP id n9-20020a635909000000b0046ec98de07cmr23719156pgb.530.1667429449450;
        Wed, 02 Nov 2022 15:50:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:22d3:f380:fa84:4b89? ([2620:15c:211:201:22d3:f380:fa84:4b89])
        by smtp.gmail.com with ESMTPSA id f26-20020aa7969a000000b0056bfd4a2702sm8928050pfk.45.2022.11.02.15.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 15:50:48 -0700 (PDT)
Message-ID: <6faaba2b-5fb3-7121-5796-af2b2f73b6e7@acm.org>
Date: Wed, 2 Nov 2022 15:50:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 01/19] block: Add PR callouts for read keys and
 reservation
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-2-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221026231945.6609-2-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_155051_032037_52BD173C 
X-CRM114-Status: GOOD (  15.83  )
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

On 10/26/22 16:19, Mike Christie wrote:
> +struct pr_keys {
> +	u32	generation;
> +	u32	num_keys;
> +	u64	keys[];
> +};
> +
> +struct pr_held_reservation {
> +	u64		key;
> +	u32		generation;
> +	enum pr_type	type;
> +};
> +
>   struct pr_ops {
>   	int (*pr_register)(struct block_device *bdev, u64 old_key, u64 new_key,
>   			u32 flags);
> @@ -14,6 +26,18 @@ struct pr_ops {
>   	int (*pr_preempt)(struct block_device *bdev, u64 old_key, u64 new_key,
>   			enum pr_type type, bool abort);
>   	int (*pr_clear)(struct block_device *bdev, u64 key);
> +	/*
> +	 * pr_read_keys - Read the registered keys and return them in the
> +	 * pr_keys->keys array. The keys array will have been allocated at the
> +	 * end of the pr_keys struct and is keys_len bytes. If there are more
> +	 * keys than can fit in the array, success will still be returned and
> +	 * pr_keys->num_keys will reflect the total number of keys the device
> +	 * contains, so the caller can retry with a larger array.
> +	 */
> +	int (*pr_read_keys)(struct block_device *bdev,
> +			struct pr_keys *keys_info, u32 keys_len);
> +	int (*pr_read_reservation)(struct block_device *bdev,
> +			struct pr_held_reservation *rsv);
>   };

Is there any pr_read_keys() implementation that won't have to divide 
@keys_len by 8? How about leaving out that argument and making callers 
store the number of elements in the keys[] array in the num_keys member 
before calling pr_read_keys()?

Thanks,

Bart.


