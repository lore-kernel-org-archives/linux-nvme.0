Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3319BD3B98D
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F3yoydyNiuN0rSJxRIOYTIsz5+plA0TViJjCd+DIF2Q=; b=ITercdWPKfkD0Jpx+w5N3YySzy
	86PmDwzHuHCP0dn8ZfiMmL4q7B5RnTFlFe1NswzqH+7eLhNVJoUIaoOh//mQ0TBCgKtZ69FqroWLM
	u3fRlvxjjtH10v1jftGbmtQDAjpQ6VrTCTeWtmSsVSBsrRNlEa7sPYkpn91K9XjZ/Ttx9sghsKmVi
	quOG8N17AD8ye5Td6b+by5TF5Wg7XDqyUdQIvGpfwZlC66cS7spsrkZpBGlMC7rslIhI+qXP5TSTr
	45ORm34xqaOxJ/PjndFCfX1gzk9upZ5DHGY/31/dqogCnnY772j7NGb5BEoWFErD55yPtxu7YiCQe
	I+0svTxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFvRF-0000000AgIJ-2MYh;
	Tue, 26 Nov 2024 13:17:09 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFvAy-0000000AdW8-2ACY
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 13:00:21 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-aa543c4db92so383261366b.0
        for <linux-nvme@lists.infradead.org>; Tue, 26 Nov 2024 05:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732626018; x=1733230818; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3yoydyNiuN0rSJxRIOYTIsz5+plA0TViJjCd+DIF2Q=;
        b=iLyJBiDOI4YzO/Htyd73tJ8iuDKDslnj9TFRw89KgGHor2VOiLZaaNkAS4+yK+AXtI
         JjWuNh1jvzruJSnOenGexmkV2FwsCHL5bbNNcfOMgyNUbOf3xZA00aowB10yavZkWe5u
         ZD9LdqKvTCrOu0BTd0KFTyChghflyMnOcXFZLtLM6rJGCNZvE457AxCPeGo58n/vizSi
         6iJoYOeNL8Sdg6Yf+d7TDF9NwsFzreeQ7H8tHCr5xEDGXTswrM3q37E52Or5CXyKai2U
         mY1caklW2qUoEUaS2Z1tk0yhWaXbrEL2fx7PSwFnzHADZA9LSl4tyefcCJwHCUU/3Fay
         Jn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732626018; x=1733230818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3yoydyNiuN0rSJxRIOYTIsz5+plA0TViJjCd+DIF2Q=;
        b=bIKnmVHy5fItLA9fOMGvzKnlDph3G6rWl3Kd1s8fkZd6ayZPtBMD86MYrIEripITPY
         3NYfNhB0yJMg6eHmIpVojGgES80+oJcJyPa3T8fVJTm4YitVjG9jv1spWD17sK7aagQE
         GxFu56ygzcybmwRS0v8VigOIO/B8M4VKAuGiIlzvn/ZamH/RkLsgxgDVtMaPScK3fbfd
         dnV4kZZhTpwc7Efn1Vv5pp4TNO0DEade4NgKpLDOc2TX2MKpcOeTfBF6sw2PGjuZ7yxf
         kVTKPL7NFzZh7yP/8+pgbniJ+uE1Ug0QO4pWQzOsDPpWdaSGWuGZvan4pKXTd/v5J0WN
         tH3A==
X-Forwarded-Encrypted: i=1; AJvYcCWpnZtwXcq5PhH+eHTsgPaPXoMq1taTtOMAlo34yTJaMtC5UR6DfArwS7KHWqbNpvXqCjNfEQ20uC9u@lists.infradead.org
X-Gm-Message-State: AOJu0YyNoNHBppsG3rFLuQjbEiRG6mDZiCURFNog+HTJ9VQq9K9NFaHY
	Hnw/j++5IjEI2+rLC6yrkSwQ9BOCct/SZ4xIsC2rHIjOeHiTTLMd
X-Gm-Gg: ASbGncuTvaaq153X5IUkgXBx+jA/00khy3eH5ZFR4dKX2+grMKMlYBuWDYezpXAEpAp
	gWjwnPa+T+5mELrC5TZigW9gFbn7n9W4gFh8xMiYWixDm3EgRUda9C6cbYpJDYU0dcIm3bSndk8
	+s9LpOksfuPj8KK+XfqF6Ogpx42DegJtnVNbuL6O1tLvHxJPfLzL3p//BeZmIg1L9aqDLOFveQd
	T7KKXP7UB83vURSZ5sEJfTXpA5kpRu6V+0BFiTtDETSjFBPBWdADBYcDVcmdQ==
X-Google-Smtp-Source: AGHT+IEP82AjkuoW0ZVsrpYLJBWQ9XK9zYr9tk2OCe5t4oYFiJxerefDCiqo9eMqXwn0bVG+EkwlPA==
X-Received: by 2002:a17:907:770d:b0:aa5:29ef:3aa6 with SMTP id a640c23a62f3a-aa529ef3b9fmr1061664966b.23.1732626016527;
        Tue, 26 Nov 2024 05:00:16 -0800 (PST)
Received: from [192.168.42.208] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa52e45391dsm480198366b.60.2024.11.26.05.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 05:00:16 -0800 (PST)
Message-ID: <2cbbe4eb-6969-499e-87b5-02d19f53258f@gmail.com>
Date: Tue, 26 Nov 2024 13:01:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] io_uring: introduce attributes for read/write
 and PI support
To: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, martin.petersen@oracle.com, anuj1072538@gmail.com,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241125070633.8042-1-anuj20.g@samsung.com>
 <CGME20241125071502epcas5p46c373574219a958b565f20732797893f@epcas5p4.samsung.com>
 <20241125070633.8042-7-anuj20.g@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241125070633.8042-7-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_050020_557338_6D58F251 
X-CRM114-Status: UNSURE (   9.89  )
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

On 11/25/24 07:06, Anuj Gupta wrote:
...
> +/* sqe->attr_type_mask flags */
> +#define ATTR_FLAG_PI	(1U << ATTR_TYPE_PI)
> +/* PI attribute information */
> +struct io_uring_attr_pi {
> +		__u16	flags;
> +		__u16	app_tag;
> +		__u32	len;
> +		__u64	addr;
> +		__u64	seed;
> +		__u64	rsvd;
> +};
> +
> +/* attribute information along with type */
> +struct io_uring_attr {
> +	enum io_uring_attr_type	attr_type;

Hmm, I think there will be implicit padding, we need to deal
with it.

> +	/* type specific struct here */
> +	struct io_uring_attr_pi	pi;
> +};

This also looks PI specific but with a generic name. Or are
attribute structures are supposed to be unionised?

-- 
Pavel Begunkov

