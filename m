Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2052EB64DC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jul 2023 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4xREcZBCRgrap1CvO65G463DVs9lKOUyCsG6yl/i6sw=; b=BBRa8d6cwQxNCsIkgZalScY6O/
	wcxZ0+9gXHVsDVxhFAxDsU1onUvsdbHmjiiquEHH42mZ+r1vkmV0uJbTnIkRREqrpKWOny1BCf4es
	v8E2Sm7AN4X2ZbXvSZuobDXcBIshwfg5pv2+UfyjeoCYoPtD8azCmx3nsgYLKtPf05oOCxSTVMPZZ
	m1rqR4AUX6toagSiBfBe0A4mDodjUVQD4cOa4PSWZ46g8Y82zT/KQ5eYTcq9K9eNzmNKsOnvXBwvP
	bbdr3AQ/74NMOpEQZ5V3+Sl4wQx1Ovcp9RQuPItSMUlgchji6T+RhQITsspiONZ5Pk3TCOr4s3UHN
	///A/6OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qKOtt-0079Gf-1i;
	Fri, 14 Jul 2023 19:56:25 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qKOtr-0079Ev-0Z
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jul 2023 19:56:24 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7748ca56133so21065439f.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Jul 2023 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689364578; x=1691956578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xREcZBCRgrap1CvO65G463DVs9lKOUyCsG6yl/i6sw=;
        b=JRKTRASfp1+4trDtXLt5G+AObAv82nveUz+EZTPNUz6zRQHIaBEH6mN3c/0/X4qXAa
         FKixwC6Di+f5piUKpd5at2nj+wrpWJBs0uNean0ye8PCLj1tH1QyI37Qc1I2GShgjpRw
         xCdxZt2Mc/d6q3o7WOSj0vco4HyD9w41XNpfqYPu/TMeat+Na/jBebnHtvyGbzMn/P3v
         vK8wBVj6KNwpvw3FKA3weoybetMQetpOAmz5niZZXHB+ws/29eZ9qdvN8x9z6ayat3W0
         OFbJ663LvEfCHu9t9rRG4soS4OnLPclRfE034giex21y0ljryKBis74APGOlGr88WJr7
         TAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689364578; x=1691956578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xREcZBCRgrap1CvO65G463DVs9lKOUyCsG6yl/i6sw=;
        b=Vp6+C+uK886nGD0LgWr4T5czpmixxi5WiaL63r0FAZMLZsZJiPEJ21Cic25aNZUtlL
         iggZs+NpJWK1znM/bYLErYkEVfpvKW9r0jnsbNGaaAoQex7p46cq0uh6kotn+TBjDFMT
         6YNi7QneadhayOfl9/tPbehewGw4M70AmYU54mildJD1e5nMUW6O6ib2v68X7OM+za8y
         5J78JSt6zAhPvoIYPPkVU5oHDGDbxoi9bkbZPLzau6ukVqd+280Qhi24U+YwozuGY81t
         QDWg4SW3yekfYo+I1SlNyah16G1FX4EPl5OitYaTo9Oampi2yuTgE01nNqhwLTBd183g
         SMhA==
X-Gm-Message-State: ABy/qLbSg8JrlqRhXwYofv5NwMrRhsk91Mz++VLUza5PhIgdW0RdfkLn
	QQe62d8qL8ZrJAaoRdFbVUTfbg==
X-Google-Smtp-Source: APBJJlHKIMlBpjv0ftDXLFrUfczPY/MGMUGopAyEvqjf3dwqA7X08ZdQ2uu/z8L8JDbG5W1VzDpsWA==
X-Received: by 2002:a05:6e02:c69:b0:345:69b3:ba41 with SMTP id f9-20020a056e020c6900b0034569b3ba41mr56419ilj.2.1689364578498;
        Fri, 14 Jul 2023 12:56:18 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z6-20020a92cd06000000b00345d6e8ded4sm2919465iln.25.2023.07.14.12.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 12:56:17 -0700 (PDT)
Message-ID: <31c4f301-a619-4af4-4697-b7ba43091683@kernel.dk>
Date: Fri, 14 Jul 2023 13:56:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme: fix dma direction macro in dma_unmap_page
Content-Language: en-US
To: zhichuang@google.com, kbusch@kernel.org
Cc: hch@lst.de, axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20230714191451.2700625-1-zhichuang@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230714191451.2700625-1-zhichuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230714_125623_214378_E9A0F4D1 
X-CRM114-Status: GOOD (  11.10  )
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

On 7/14/23 1:14?PM, zhichuang@google.com wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72725729cb6c..7778f384293c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -967,7 +967,7 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
>  	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  
>  		dma_unmap_page(dev->dev, iod->meta_dma,
> -			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
> +			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
>  	}
>  
>  	if (blk_rq_nr_phys_segments(req))

This already got fixed and applied by Keith, pulled by me, and heading
upstream today:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=b8f6446b6853768cb99e7c201bddce69ca60c15e

-- 
Jens Axboe


