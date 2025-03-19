Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4317C35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9fA0vigQcgLewl+P2hKDh1ek8N/s4rvS4ZYh23xgGc=; b=YSNDAldFVfDol3a5POVR2KnrnE
	Y1Sg28MD4M7qShQ9HU4AnbaQEP+77rbnCpZzxS+sev3WeLdiWffUtJb9m+v9MpqJfoWOVHA6j5YuJ
	Y/1e+nvzd5r+QJT+KMd7l7cf6JptnhKRMegs+p7q5kNyWBs/LbD8CdaIeB98w7sAb0bxjeBzV2XK7
	HTwN7oXRFA244+kctVkQBsiyEIGIbO+PmDP0kqQWEpT9gywN6jqkkYa3+uxkeTkou0BnyuNuX1+vc
	aLk3X+vGRz6dyde6FxonYCFgTZCcNrLgOy6SDhlrCIV6THRVFCZuN031QpZJBU1sp+9fmObSVBp0j
	eYL9fitQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv0Wk-0000000A63f-0PD2;
	Wed, 19 Mar 2025 21:00:38 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv0Wi-0000000A62c-13zL
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 21:00:37 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3913d45a148so28583f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 19 Mar 2025 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742418034; x=1743022834; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9fA0vigQcgLewl+P2hKDh1ek8N/s4rvS4ZYh23xgGc=;
        b=LlDR3cUCQ+OP4Qy2qb6vN8DG2OXmq1dMLURspxv8jvaqpvDyBQcy03YriVGTImSsCF
         W7VaRMYKaL4SsHWJWJ7nvtv4GaFhk1lzzONeetELvS2vzgyU0xYmpB3F6ez5BO/6HKiH
         9QY9iEY8CNflwxn55XdV+hGa91NX0OZvEgNhOZ7R/DQMtn95/O3/0v6EnItHqLIjGqCN
         WsPgKzFRiBK1iJWblFq862ZGiT4gEauR4c0/w0qhsHUSnnIqc2XHg5sn2UO9t0uOCZmc
         /YgHRgfzm8pQv6FJ+HQpMd8QCy8GHe4swE35uI7lovSdo0vznDsYDMfdB7yUi2S6txvt
         y07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418034; x=1743022834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9fA0vigQcgLewl+P2hKDh1ek8N/s4rvS4ZYh23xgGc=;
        b=u20gt3Z6XrD/NXeMhHcfx28X5k8pDsdxZCJoO6GNvdw/il/9tH9TxLyPz9ENrtZSqW
         l78NbBOJZSyaAjQZHmEQZvLo5xRuN2+8NrC2r/+yjhTW2unP9We6VDNxWm4RXYiHzSSu
         wyqQSFnaYK8NwuTmlXypajxJw6acT1KHYq6oQa5slzCkQ9EaWJ0JEmWD3ceI48FY1qaX
         FxA7d3jvL20TiI1hiuCp0I+nLryE83oMzsjByWFPrxhpExqbcOx7lxc3w7OLhHSz+jQG
         UlAD9pPJry/VjXfwoz1n90+ED/tsD+9nLWHzp8BGEYDMQ64TJrL9Q79ZhBt/eP+n3oJJ
         BxHw==
X-Forwarded-Encrypted: i=1; AJvYcCWlau5uceUh3B7jWI838UwlvtuJKSSBsqZXLuiumnOt4GrLwStB/6FZB48OsEHHHCBpYgknVpbr4a93@lists.infradead.org
X-Gm-Message-State: AOJu0Yxlezm8VnUY6NzJnAoOINn6USrvlfqCV1x3YrUnqgiwM7loTs1N
	71QMXKsIKoGIzQYZUBWy1drkvvuz4zPaeQDaWOMNqoAEtEf0eVaX
X-Gm-Gg: ASbGnctJswWIvJkQo4/HtcA82eDQdyCkAY1ZTLpzVwSa5emUPDCiSI6bHgTh7aHzUk0
	7l/vsNbgJzLzS4K1YRdR85RxnxGtWWVje2ynKhH+Joy89rUeIXh+MQ04Xyz6v84o32//JqM8dHt
	Un11bNIII9nLODGnyg9VvbWI55iIFpFdObxpR3kiTZScVNRx1MAPJA7nQ98o1PyMmqxHaTds+lA
	lZjd8QJiCjlpMAT/dsYz/B0CuUz4m1VNQyVxjMkHhvbUdTCHaqKNSoVPJrn3zEeCmB1C5txU344
	VjLjIKBXzN1uFXcm4gMD0lviPMsfOfsWOm94pdxBqnuz6lOx85czOQh1OsTusz962j1Rl3gkSXl
	CKQ61Ck8=
X-Google-Smtp-Source: AGHT+IEh14hIPzocWY61j2hM9V2XCwKM6EoxuGhHTrrI0GDTgEhJ9w5eegw2wU9kY9qwW+6pbIpMug==
X-Received: by 2002:a05:6000:21c4:b0:399:795e:d899 with SMTP id ffacd0b85a97d-399795ed8b6mr633215f8f.14.1742418034195;
        Wed, 19 Mar 2025 14:00:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3537sm21976764f8f.8.2025.03.19.14.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:00:33 -0700 (PDT)
Date: Wed, 19 Mar 2025 21:00:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: <shao.mingyin@zte.com.cn>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] nvme: replace max(a, min(b, c)) by clamp(b, a, c)
Message-ID: <20250319210032.5d442b0c@pumpkin>
In-Reply-To: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
References: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_140036_295239_5C98FB83 
X-CRM114-Status: GOOD (  16.60  )
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

On Mon, 17 Mar 2025 15:39:09 +0800 (CST)
<shao.mingyin@zte.com.cn> wrote:

> From: LiHaoran <li.haoran7@zte.com.cn>
> 
> This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the nvme
> driver. This improves the readability.
> 
> Signed-off-by: LiHaoran <li.haoran7@zte.com.cn>
> Cc: ShaoMingyin <shao.mingyin@zte.com.cn>
> ---
>  drivers/nvme/target/nvmet.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index fcf4f460dc9a..30804b0ca66e 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -819,7 +819,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>  /* Convert a 32-bit number to a 16-bit 0's based number */
>  static inline __le16 to0based(u32 a)
>  {
> -	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
> +	return cpu_to_le16(clamp(1U << 16, 1U, a) - 1);

Swap the arguments into a sane order - clamp(a, 1, 1 << 16)

	David

>  }
> 
>  static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)


