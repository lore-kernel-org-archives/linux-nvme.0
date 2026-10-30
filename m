Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC6606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y14rQS6Y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7zD9hK0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qUelzvzI0I1/N8qXjV1BcthIIh2qTCSRp7SQgDbPekE=; b=y14rQS6YeRKmjz
	J9Jo7wRJNCXiIAgIR36eZ+FjnV5tJnbP2NRCahQ7JOB5t+kVRh5PExCWRHZqDbGs/5xVFa1rr1Msw
	SZ+h0tCTPHf/+2MqqyuijSZ26G7Zwnqu8qWCrAXxjsIXa0SCeBT1fgE5Q+qkHfmgrKP0065vupdiA
	8MByxQfY+YCohZt2YyG9fFeJJF8ZQIzLa/SSwkepMXfo8vnOi7xPK5yJ4FBklNzktSBW+HQ2iznpD
	s/5JYywFZJA0C7mFZBh74U6Wo2+O7+3q9dT0baei77JAfXXvzTsV1QKW0LP/91qr9lBvbQpBEwwAu
	J4hgM2HOJMv13h59K6wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMjoM-0000000BOCG-36vu;
	Fri, 30 Oct 2026 10:26:14 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMjoK-0000000BOBh-00KL
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 10:26:13 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so291901f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355970; x=1793960770; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUelzvzI0I1/N8qXjV1BcthIIh2qTCSRp7SQgDbPekE=;
        b=h7zD9hK0ycdgupzJ3A45HMlYW5Wvjv8OpzO9d/qWbqwIlYxaDpJkvijJf/wIgjo4Ml
         SzJ9yTubITxHgQQbnhBFqzrRyx0Otb1VZBGlZAjLU8mAMk5mJy7K+jClAKvTTXPwloeu
         KmGnnVEYjM2/tyG06F001vzacPHZB/yC/7Y+FJU/qHocH+eVHNJ7LLOAwLWbHHVd/7SU
         X8MemzxQUfQcEjeXtU+kux8sXYhXcnLmYZoPQtTx8E9Y3WHBLqmU+S9r/D1GL00nuzjQ
         kdFPsX4oKdsXaKtPIlUgeB0lmoChqxICbTkLxa8qiCKK4rETsr3fmISjyPE1t0JhTaG9
         Uh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355970; x=1793960770;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qUelzvzI0I1/N8qXjV1BcthIIh2qTCSRp7SQgDbPekE=;
        b=aatk1GfXhwJ8sN7Rureubtnu0gjEky1qVcXUXzz1Rd58nXjWZt+93Co1ozjAESTGUo
         VnVT4vFgcs7v4Agvp37EhbrPfKK7vNNoi/oI7euC6yI355vQbx2tPVqbbezD69LPdNB6
         XOM9Nqd7HVx8sXcmczv/ZfPM8Ghg/ZXW8ahpYVt3sjr/KS1NU59Yc7i1oQ2B3pyZeC9p
         NiaAwl3EwZhVw69IIqKj9QIYIynFlbaqCDdk9IbXmMnDWtKFh30O1QH4jTw05Tx6Wuzh
         PuG/b+vBobEgH2NUVdKTsIG82QwunxTDW5LRNu5BATtidqSWP9hY39dbgfFEQrw+kKYZ
         +1bw==
X-Forwarded-Encrypted: i=1; AKwUvBykMSRLnCyltc2i7d4NomJQfstdSaB5hrMWZlB+UyjEx5Z5rRbyFzrvP0KUzpukF1PiOVSFkN2hhE8H@lists.infradead.org
X-Gm-Message-State: AFq9FYIGNvDPXhsHYAHUWpNI7Hysu445Bjp3V7urZGME33EABsgrFWAP
	mDeU4TyG5JDT/12mrQs6OmrwdqwfGpml5L1rX20Mjiyxy8YZ0JkfJIlN
X-Gm-Gg: AYBFou0IV2hIAPFqyr5hFjkuee2IFGrgq4klp9gERnciRPh5FqGkjkng9KMqGIowyTT
	3h5diJJsle+xLd8zWL30s2k54XRJgU04aYR3J7zPEZDNoGn3+V4qowWzXFjik8YcwuXKR1mDFUy
	n7K2vp0Tx7oSh/dIM5NidPjm0je2WjWYho+WxZE3mK662kQI4iC8BaQZW+9a0U0nWYx+Ong9/Q2
	1Rn61n4JbHxcHMutRt/NAQi1xj2TawP4tUaITKDuxx6kvo2rwu8sCQruHueRdbp06qToi4pA4r4
	1GzWV7PUCJzfE68imPVTxCdhMxAjtbARM6CxRuXD3SoI11W5T33Nzl+aTxRfrAGfY1cfpWGSIIt
	ffWNmC31ZCLEEU0Oy+mAcm4tLqTfPYSyzetNr7jlYh+e99Nm/xbDLO/woLi1SKNuiPTDeE6k/Ao
	2aeCURC2KAJUKxlJ0P/Fv47FrhdndkvQL6lY3Lmd6hUcmp7PTpCZpEn8BVkNFhVUumjnrjU7yxo
	q8TAuts//OxXznbnwvbWvmv4dcxQPEs77xAmjoy5AF/eaQ3MRo3On1KIFb3jgWRbUzuB5VqmB1S
	BO8j4FBv4zKQ78qKZroimPoJqnkmZNXl69eVepdnSzJ4IY/R15uZ606/yTUN61T6+uOnGZgxzAi
	kk2aiNJevV62Ih3DYcFWhX1DLnjH/EmaJStV4/5If3l2nsyZo0iVe8wfJSTMk+OObCJaC0ElB1Z
	6bow==
X-Received: by 2002:adf:e011:0:10b0:48e:6c3f:f7b2 with SMTP id ffacd0b85a97d-48e6c3ff7d7mr5879996f8f.23.1793355969523;
        Fri, 30 Oct 2026 03:26:09 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80ecbsm2527884f8f.35.2026.10.30.03.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 03:26:08 -0700 (PDT)
Message-ID: <bcafcbcf-9503-4fe5-82e4-ab9f8a3cb687@gmail.com>
Date: Fri, 30 Oct 2026 10:26:09 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: only fail dma-buf bios that need block layer PI
To: Kyle Bader <kbader@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261029155821.2983229-1-kbader@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261029155821.2983229-1-kbader@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_032612_060196_14C8E37C 
X-CRM114-Status: GOOD (  26.74  )
X-Spam-Score: -1.1 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 15:58, Kyle Bader wrote:
> From: Kyle Bader <kbader@ibm.com>
> 
> All dma-buf (P2P) I/O to a device with integrity data is rejected
> today, at registration and in blk_mq_submit_bio(). Only a bio for which
> the block layer generates or verifies PI needs that. The block layer
> then walks the bio_vecs, and a dma-buf bio has none.
> 
> Reject only those bios, and remove the check at registration. Then a
> submitter that attaches its own PI, for example with
> IORING_RW_ATTR_FLAG_PI, can do dma-buf I/O to such a device.

Looks good,

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

It's also enticing to shove it under the existing
bio_integrity_action() check, but it can be done later.


> Link: https://lore.kernel.org/all/bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com/
> Assisted-by: LLM
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kyle Bader <kbader@ibm.com>
> ---
> v2: a shorter commit message (Christoph), and Anuj's Reviewed-by. The
> code is the same as in v1, so the tests of v1 still apply.
> 
> v1: https://lore.kernel.org/all/20261028181412.1919506-1-kbader@redhat.com/
> 
>   block/blk-mq.c | 9 ++++++++-
>   block/fops.c   | 2 --
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7fff1305b..3fc9fdeb3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3138,8 +3138,15 @@ void blk_mq_submit_bio(struct bio *bio)
>   		goto queue_exit;
>   	}
>   
> +	/*
> +	 * The block layer cannot generate or verify PI for a dma-buf bio, as
> +	 * that walks the data pages.  Only fail the bio if it needs that, not
> +	 * if the submitter attached its own integrity payload or if PI
> +	 * generation or verification is turned off for the device.
> +	 */
>   	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
> -		     bdev_has_integrity_csum(bio->bi_bdev))) {
> +		     bdev_has_integrity_csum(bio->bi_bdev) &&
> +		     (bio_integrity_action(bio) & BI_ACT_CHECK))) {
>   		bio_endio_status(bio, BLK_STS_NOTSUPP);
>   		goto queue_exit;
>   	}
> diff --git a/block/fops.c b/block/fops.c
> index 01bc8afe3..5c8024011 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -947,8 +947,6 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>   		return -EINVAL;
>   	if (!disk->fops->init_dma_buf_io_ctx)
>   		return -EOPNOTSUPP;
> -	if (bdev_has_integrity_csum(bdev))
> -		return -EOPNOTSUPP;
>   	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
>   }
>   
> 
> base-commit: 45b716456dd99488a0cef58482120dc0474aa696

-- 
Pavel Begunkov


