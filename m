Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B34C5479D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 03:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5sBwTo/6FAVRuvQ8HNF1y6/qF8cF9N6TmicI4X3LQI=; b=OFqXtBap+qcs5C+LQ6fQ1FrDcf
	AhSZEK43j4ABL+LqBetheWts+3cgiALLp1mv9WXYStFQ4w+R5xoayaqOi4jzhEuuhgYgIBkp0Donu
	VqQlKD1QD7dvjGnp3mOzrQbh8XCgaXXnjIjt9k8wq6TnFiJPyBfVH6KgcdRgAZCdjVV32IALPZUK/
	+5UzxhR1PglVyT1Ze+DrXkDbgn9RxITdNAryZiwl2hasYFu05KDpKyPI+55V+kOd1Tz6txjvmCFAl
	5E2ys3fS7vHwr7y0Vb6GsGlBJHUaZugHGQ0oe7/8jpKzsbWWvFpu+x5n8PVT3jB3pbLPPyCynxLa4
	mLYYIL6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEisJ-00H85J-Ep; Mon, 09 Jan 2023 03:31:03 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEisH-00H7oH-1z
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 03:31:02 +0000
Received: by mail-pj1-x102e.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so10392594pjb.0
        for <linux-nvme@lists.infradead.org>; Sun, 08 Jan 2023 19:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5sBwTo/6FAVRuvQ8HNF1y6/qF8cF9N6TmicI4X3LQI=;
        b=HlP7takHmazfZe6JF4g+L9RoDC3sgEM2Ec1SrzhHpxYHZ+jhOxaqWezZvBOnaxK/IY
         rCkl0IA2ZTT6dnBsjgbvfT/FNkSUZBgPzNW8dsOOtArnxl/oIT0NTYWLVb3Is2maswj0
         APRNyvaEAOpMYyubFCe0ScAyIgJ7K6INO1g2twTpYZsqnwo8MbDYtfLQx4EvBwtvo5HL
         CqiCgNUjG8apj48hTeJOJcymSRc+gKDnBTsyCsjTQWOsQIwy/5MdpjUKKVv9aKgo2YUL
         QBqWRT2JwQ6dYFh8CDV1VGFmmBW4WNhba7hi2WY0byQoL6Fb6nP4YGuSTHdFnm0xTgNq
         gs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5sBwTo/6FAVRuvQ8HNF1y6/qF8cF9N6TmicI4X3LQI=;
        b=vxbeIELDNw7N4CqbT81V8OEtceDtkV6MQ2C5spavA8QKQ2HzQD9aNa88tO5t4JkRj3
         W8cbby+a3DahJ/N24rQw7MXmDBYyJz3FCfDEcCEjiryxSdLjqglRZhMYXYeUNtC8vI1/
         fg3RNoNNoCPvyzoLe9ZZd8caASxTcUdz66oHZHc02EeMYlQgLzA1CdUQiUvh0JZUFH+q
         Sh82ydbmYHGyzut3WS9EfTfkN0ykBQTsKkI8ys045NZAdRKIGzRAfsVwNhTbXA94fkkY
         0a1GJwofe2+w4mPW5Cho5WPZDvu5EjE1eWZraPvzR8LQSQG40kgwKfTYP9AQELrBSezQ
         0U7g==
X-Gm-Message-State: AFqh2koWdah4brFdcLyovK7Vec0XAXUe9dghGVWMZnGLN4JmalEw3EUr
	RzcGY+EYItxHNY5uf/Lr1c3u/w==
X-Google-Smtp-Source: AMrXdXtUcv9vSeNl1vzWbYRxzFHcRpi2J0lVJjud8hauboCrzb4sPwHS+V+iLvPCC2itAinUZNx8aA==
X-Received: by 2002:a17:902:b48e:b0:18b:cea3:645 with SMTP id y14-20020a170902b48e00b0018bcea30645mr16258531plr.0.1673235054540;
        Sun, 08 Jan 2023 19:30:54 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00192820d00d0sm4835420pli.120.2023.01.08.19.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 19:30:54 -0800 (PST)
Message-ID: <3265b214-5754-8d01-066d-3ec7853aa3de@kernel.dk>
Date: Sun, 8 Jan 2023 20:30:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] nvme-common: simplify nvme_auth_generate_key
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
 hare@suse.de
Cc: linux-nvme@lists.infradead.org
References: <20230108184123.393727-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230108184123.393727-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_193101_140466_66A424A4 
X-CRM114-Status: UNSURE (   7.23  )
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

On 1/8/23 11:41 AM, Christoph Hellwig wrote:
> Return the key or NULL on success, and an ERR_PTR on failure
> instead of passing a separate ret_key argument to return the key.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



