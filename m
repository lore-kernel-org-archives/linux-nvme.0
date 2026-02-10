Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4FBEB2700
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyWovkRTm+VBO7EWXfO8gUOOoB2/pAnZYbbbLZ/pIDI=; b=gGGblk3j0+DYH1aKcAOK/yTjDb
	D5DJDsF0/Vgpawb2u7sYFlyyVSUQt7go921P8ADXZ9fJHue3782PN/xJ6lbDyBXfwgo6ktp/+KtrQ
	NR/FK12DWS9zlrCPETIaYVJToSY0f4dZN9byFEaDJz2Hc+MUPUDtJWb+7QzkXIbxrFvJQj3tJhgxn
	Cs7x2oBTpibxKt08rcB2nJ4ZAKYqvGHkIrJfXco0WszC9iCFEe+aCQlNbLo3JiqrP1xOXyjiaRfVt
	xI8Gfvd+RQ+1iuyupQx6zXHYY31+Rs9TXHLxKsEfzfsPfkIslE93G9bGoKFE74ahqazjFjtNGxpaf
	3Pw4AZjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpvvK-0000000HXst-3Tjj;
	Tue, 10 Feb 2026 22:09:34 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpvvI-0000000HXsY-1W4K
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 22:09:33 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-2ba94dbf739so885463eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 14:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770761371; x=1771366171; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyWovkRTm+VBO7EWXfO8gUOOoB2/pAnZYbbbLZ/pIDI=;
        b=RlHAsq82wsFuhWv9I+n1S6l2c3dOdD/0XeIVUGtuwrMezzhiPu9GusQl8KTg8g1w8+
         YDrWvBH3ddQRbGKisCK3V6EZibxxxtK4hG3geVbluYLnuWJillUIZwqdkCWMmmfO6qzc
         HEm03P8UGA/K12jfRGcQjS+vn2YRsv/kqp8MUIhveXVRm2W42qHh4jXMF8GmgdnS2b12
         WOjG8wQLg5PzOBlwVGULK+PGMX1JT/uEAhB3r7AOCUJTyABFxsgbTEc6UAmkURYGR67K
         DJtzNS+3/wbHgvve4ylzu+ppMOiocj5V7eVXpw4Z+TB5YlFBh7bNsoX10Wm9hmZZIVcQ
         O/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770761371; x=1771366171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyWovkRTm+VBO7EWXfO8gUOOoB2/pAnZYbbbLZ/pIDI=;
        b=oh34j0xO98UAoVk1iL8o5hKR3d5tgz4o6rRv4KsXa0ex7rEqkLawSe9zKZ9/x1Zl20
         vGdDpb1oaWcH6hiJ9isdHgZ1536cFNI7U2jMdWfZzU5TVpM4HuJRNno2+TThySxpWsV1
         Qdo98US/xxLilaXyKenMQFJKNIiKB5rosTtKJQu6OanPMQJgt09JSTeGavAsk9BtySFv
         lDFY5DzFZVO/hcMtCvMiJ64ywIV9iQteL1/AJ2xhk5A9QaRt9SZakSdjEfyPSS5QWFB3
         DiSzwaiinxBX3jVIq4VsBwPH+YsS50OVB3x3WdLE/mHr60d0LELZzCa8R37QmCOjvWiM
         dcZA==
X-Forwarded-Encrypted: i=1; AJvYcCVjznCPvkVX1nixj5IzOpNEzGhXPix4UR6+9oj6bCjf+ICEONktiK2f85JCxrQspmhKpXQSK91K3ZZl@lists.infradead.org
X-Gm-Message-State: AOJu0YyIczxkGmp6ciamAGv9PM6pItbBpsA09cg0BoK3P/XZYnzGXBy2
	MLMEtpyTilBOyqCs23MesBumjULmu9yhqLuR8gMofCxTm6Bc3Y/cJrdT
X-Gm-Gg: AZuq6aIWmwt4HxUa8SL/XnHIxoZD5sffMZl+6HDVm6ItNMjYzJDUt1PqDkAOEAzKVRn
	ffqniN9cLTZdTGXzwwobIc7vF4TXwWXMnP/SfneaY2KgdlK3nnw99D7cgjxJGwDcasA+SHdqcph
	NAS054fcfiLNxmesUd9+GvICoHzOwOaWqUpDi0YsXwGlbqp5IpoS5I9si/7a8DfTbMeuWVKeyNd
	JN6kY4aXKUM+KzytCDdozBJDlUbmYUWNMBFOq308wGvag68eUVz3blSZztUCnRl6AWs6F63k9Kp
	mtpvM2oVxY8ekzzMXUmEmSs7/y5jnp772/I3L7hiu8Zbu/k1cYUsfzjh7gmbbkHkEl9cs/mirYu
	K55yA3isNq6XDFnueX65yGuyCsuCJf77JQ1V0TpZUguYjybY0TGBq/H8Hy9GmCT7gGqxRs/LUfn
	MSe7ZhhwsU9ira3E8oCe+ERbCULyMxJWhJbKMXLkHqS9r8r3uyAPmElw==
X-Received: by 2002:a05:693c:60c3:b0:2b8:6b32:1d16 with SMTP id 5a478bee46e88-2b86b3225eemr3692263eec.30.1770761370711;
        Tue, 10 Feb 2026 14:09:30 -0800 (PST)
Received: from [10.69.50.72] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855b1a6d3sm10586261eec.15.2026.02.10.14.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 14:09:30 -0800 (PST)
Message-ID: <05875e07-b908-425a-ba6f-5e060e03241e@gmail.com>
Date: Tue, 10 Feb 2026 14:09:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jsmart833426@gmail.com
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
Content-Language: en-US
From: James Smart <jsmart833426@gmail.com>
In-Reply-To: <20260130223531.2478849-9-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_140932_441140_AC47DDC9 
X-CRM114-Status: GOOD (  10.90  )
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

On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
...
> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> +{
> +	unsigned long deadline, now, timeout;
> +	struct nvme_ctrl *sctrl;
> +	u32 min_cntlid = 0;
> +	int ret;
> +
> +	timeout = nvme_fence_timeout_ms(ictrl);
> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> +
> +	now = jiffies;
> +	deadline = now + msecs_to_jiffies(timeout);
> +	while (time_before(now, deadline)) {

Q: don't we have something to identify the controller's subsystem 
supports CCR before we starting selecting controllers and sending CCR ?

I would think on older devices that don't support it we should be 
skipping this loop.   The loop could delay the Time-Based delay without 
any CCR.

-- james


