Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A97C00140
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 17:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3nQ1rVXLpDSEFDUYuvx5YwgSl2ilKx7UDUIcTLmdIuo=; b=JFFywkyFJWhLC0uuQ/Qr4ObGbX
	h0IPuxjdneuI81npgf8rygY3fMAnB7X+y2k7DYnFz3hTFngNTOzBuddq66RkAcN+O2WUcxPWW+qi6
	GgCnwOcR/qLRNbP6lw1LkxRjr2+MCypnAs7DNqiNKLp8lBygyyYwK+yx32HSpOi5ZVQdM45OkfUY0
	eXNaniI/3dfAPFahXk98K78As/SHPeHEtgMVuRzRx8nxPbt0tg87YdtAMCABH4rq7f4QOjhtWKLix
	CJGQzDTIEr5TdUAaceds4B1Ac/hszUwX5JU2wj+EhUESUZ4Hfwth3JieOomVeqA+i5m9vSbFGBqWw
	Ksowz4nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK0k0-00Gv4v-P6; Fri, 05 Aug 2022 17:04:04 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK0jx-00Gv1t-QN
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 17:04:03 +0000
Received: by mail-il1-x131.google.com with SMTP id p9so398400ilq.13
        for <linux-nvme@lists.infradead.org>; Fri, 05 Aug 2022 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3nQ1rVXLpDSEFDUYuvx5YwgSl2ilKx7UDUIcTLmdIuo=;
        b=G4ApnmUZDgpX2DJmLdTVMAJs8qbQzm92gbUQFUaXmWPNDuJ1O/43ntQr630qbpH2FN
         VemYqANkxAxoNDvqRwXnNv+d0P0IEFfxMsYHwTYbJ2PmJMcHAc3kYQ5DMUI6U5nWjbn0
         GfWksrjiw2cVYPX+7ApGFWdgKqb53JNYuTHuPp2YuIKD6Bp6DhoI5UAU6lAR+CnH3Pvm
         x0pKJ7yLKvuawC37VPBNaMRf1IoCIeNYIGwfZ5KRb5pmMhGAEjP/wbEoek3qUCiHIn/A
         OHdX6D5X0+QZfrTZRVEHQLaELAnauH4pLqGiMcDIhiut35i8efoEwES6yuHJdRhxBnSd
         gETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3nQ1rVXLpDSEFDUYuvx5YwgSl2ilKx7UDUIcTLmdIuo=;
        b=amOuJwsb1UgpYrYhd+1YfAWwjmkj5u/nDVS4EprNo+A65uoIz2/GeJkU9lRTiucF7o
         uRq05LqOBZgeWFN3wqUOKtZXThD0+DqegWHjbnlqRlxTR7MFt8/AWhay8EY/jRG4A3B7
         7s2hVdju1KQgLUjyL7OwPbZ7CH1S9e2ZeDhdf4Df5wZOQJKDQfQSBHihRCd1lcKHe9Lo
         arnB3z8TUdUg0fyVzvuNtbP/j9mvcB5aekshMYKqxrjbm4vBNcF/KjbENFo1cs4vuf26
         IaDEMzMRuOQUR4lVw3eCkonBHQiyzQ02DZ3nHu6VJTSMHn7nKTpN2fHfkqSw7jhfVvS2
         FpgA==
X-Gm-Message-State: ACgBeo3hs9GGdwF2F8QGLzctZW5fRuIqvXUgwqgNqGwVu3R1RVSjMxlm
	EhFYE5f9KjW+EFBZxUhYGqbjUA==
X-Google-Smtp-Source: AA6agR5xQA3di+F1B3DmrrgTAxXjfGE66ys1tZEHESkOge6dBVCelgqekLGqKnaWIx8jpVB/c/uRjA==
X-Received: by 2002:a05:6e02:b26:b0:2de:b192:9dfc with SMTP id e6-20020a056e020b2600b002deb1929dfcmr3612125ilu.273.1659719038985;
        Fri, 05 Aug 2022 10:03:58 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n16-20020a056602341000b0067ff1354b46sm2041257ioz.39.2022.08.05.10.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:03:57 -0700 (PDT)
Message-ID: <769524f5-c725-85f7-e7ac-ca3b2b2d884e@kernel.dk>
Date: Fri, 5 Aug 2022 11:03:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] nvme: wire up async polling for io passthrough
 commands
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, ming.lei@redhat.com, joshiiitr@gmail.com,
 gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
References: <20220805154226.155008-1-joshi.k@samsung.com>
 <CGME20220805155313epcas5p2d35d22831bd07ef33fbdc28bd99ae1d0@epcas5p2.samsung.com>
 <20220805154226.155008-5-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220805154226.155008-5-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_100402_108402_BBA48A6A 
X-CRM114-Status: GOOD (  11.88  )
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

On 8/5/22 9:42 AM, Kanchan Joshi wrote:
> @@ -685,6 +721,29 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>  	srcu_read_unlock(&head->srcu, srcu_idx);
>  	return ret;
>  }
> +
> +int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
> +{
> +	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
> +	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
> +	int srcu_idx = srcu_read_lock(&head->srcu);
> +	struct nvme_ns *ns = nvme_find_path(head);
> +	struct bio *bio;
> +	int ret = 0;
> +	struct request_queue *q;
> +
> +	if (ns) {
> +		rcu_read_lock();
> +		bio = READ_ONCE(ioucmd->private);
> +		q = ns->queue;
> +		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
> +				&& bio->bi_bdev)
> +			ret = bio_poll(bio, 0, 0);
> +		rcu_read_unlock();
> +	}
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +	return ret;
> +}
>  #endif /* CONFIG_NVME_MULTIPATH */

Looks like that READ_ONCE() should be:

	bio = READ_ONCE(ioucmd->cookie);

?

-- 
Jens Axboe


