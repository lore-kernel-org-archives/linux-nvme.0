Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045BCC83F22
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6w/sVb1V8AHMK+B7FCKjsSM7VP3W2earJ8E8o0cKdaE=; b=Q/0t5BMNJ05zjrRETBBfHNjp8q
	bS/Ae9DpWZhcewh+Mq1P+Lli6d/6/cO4jv3z0Oxf1OUTp8Z9VonsImayWluh+mks0FlwSjl3NkNg4
	8z1V2xFbE3GmrGgAemFY+doQ9F+nWLH7cziP3JJrj+opMNEoVlR4NBksMchVqQYLCEQAZSurS15GO
	QnkxOfl+Q9y+SfFegzbeVVjdOH+i0dw1qvku6qAQ61I2XP4PLQceWnlBH6Y4gmLwO6WiJTday3EVg
	Z1vpt1jdP0Lg23z6TVCZR/VLc5ABhdfkzvYdP/DVVdPhnEmFL1RDD0UkFPc6vKLbgrFx/T5RHUi5K
	A1J8udfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubl6n-00000005xok-0TiQ;
	Tue, 15 Jul 2025 19:14:33 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubhEz-00000005XOv-29Xb
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 15:06:47 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3e057f2c8d8so44459705ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 15 Jul 2025 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752592004; x=1753196804; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6w/sVb1V8AHMK+B7FCKjsSM7VP3W2earJ8E8o0cKdaE=;
        b=qmdZw013A9AjflrAmLuPdy/+EB97ZZww2mG4RtANSgR1d4cGNAnqYukSKa/LCVgzdv
         zAf6M1+HGlPH3yF0lOFYwPc9LxJr2KXPhkko1ccPdpRn/KPElXC9OvzVX04MgACBPW1A
         Edxzfog4FRg/PZFnzZCFIU1DdoUgs2W5jZcYgjY1H5G4NV7m1VLSOXc2CdoM8h6oFcaj
         yhfESWcA7qtda7u3L/CYRg6oxo57Y8+Cv5oF9A8wx+yJ8aEv24BHnww+NAqq29OqU8Ab
         3OQp9qxJt5v/43sjzd/LqmysBJaZXscTqSuBeqHI1NgKDO+bB6uwTQznuij7DusEk7QK
         v0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592004; x=1753196804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6w/sVb1V8AHMK+B7FCKjsSM7VP3W2earJ8E8o0cKdaE=;
        b=hzbOybo1IB6oyPGz+12EdB+ivdDTnU6nQZzMlMEgVCS/KMg2CM/cDBO5F4nllUdDPo
         mPvqcrHc0LgUv9kxh2uTRywYfUxuuETuAFucKH5aLcUwZ8Aq8+ltWVxNLEN1SCJ/mwts
         bVOZWXIcycujPjR2lav6NJi5bk2CMn/9jY5YiAnchP+thP/6tsXbpdxqYhsrva6CJpIL
         U9NVyjpBAh/NrhSupFdUWeTU+gFGx+lhUz/0MM4eyHVfKWOCQ7Z1AUy3ONx8gufguFL4
         sRCX/3raFY3nU2IeWtbkzJJ3DtrqWjL22lwxRbpxBhfV0B/XV6gN3BlabtMZAj42NQ1B
         OZSA==
X-Forwarded-Encrypted: i=1; AJvYcCVCdn0F3XtxLGPu7+pJOu8R4JsZcJpj/Z1q55QBAkxPc/Fon7CiXCy1tEUlebaSEtWZCHubZIhNPZha@lists.infradead.org
X-Gm-Message-State: AOJu0YyW7Dn5XeFHJxN84sNn/EraQuDWGC9UOJihifj48brkcMlhquki
	Cle89D2WTLNHwsY/OxREkzkAZBJRIcUPqfjdcl0XvtzNHkJ4DVRWXrGbvnzc11jffk4=
X-Gm-Gg: ASbGnct2vq/UWR+WgBYXpBoqyStXXd4LDuE3SlVFlfqHLq9C85iCRV7JywAgutOfYYs
	uk97CpBle7/f3xXd2Ohv9SFirDTdQ6R+5tGk5UiSU3/xcx1oWZ0pEX7+2iHxhRbdEtUJa3aCPdg
	GqIoy+J/c7dvrf1K04Zk8XayKnmVR/oV/QHzVZGlIBHC5z0Yz54fau01Tnc6jCfClDg6cqv0VcP
	n0JAl/qxzjVjA73xKTI7pIPiS/1rzIz6UTwv0R59ehiw/dWYA0hp0jU4Ndq7VqZCAKGc2bzQ1Wj
	cnMy3ACp7NWJXGmqiuyL6KBfKnePS3FuJU67F/5Uh88rB/dmyhLmuz5Zqx6PvAc/EgqtqQ3a9pW
	RhND+lirppL+BC7iAYzU=
X-Google-Smtp-Source: AGHT+IHqM36QTp5FzfU26d/pDIhI7/8WfKRgrZUTQ/M+sQpnXNIDnRX6/CHFUrNquCYxmgforbIaeg==
X-Received: by 2002:a05:6e02:3bc7:b0:3df:3208:968e with SMTP id e9e14a558f8ab-3e2556650e5mr160301715ab.14.1752592003826;
        Tue, 15 Jul 2025 08:06:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556b0f2a2sm2603895173.124.2025.07.15.08.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:06:43 -0700 (PDT)
Message-ID: <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk>
Date: Tue, 15 Jul 2025 09:06:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
References: <20250715132750.9619-1-aaptel@nvidia.com>
 <20250715132750.9619-4-aaptel@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250715132750.9619-4-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_080645_580879_C6F93C74 
X-CRM114-Status: GOOD (  19.63  )
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

On 7/15/25 7:27 AM, Aurelien Aptel wrote:
> From: Ben Ben-Ishay <benishay@nvidia.com>
> 
> When using direct data placement (DDP) the NIC could write the payload
> directly into the destination buffer and constructs SKBs such that
> they point to this data. To skip copies when SKB data already resides
> in the destination buffer we check if (src == dst), and skip the copy
> when it's true.
> 
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  lib/iov_iter.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index f9193f952f49..47fdb32653a2 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -62,7 +62,14 @@ static __always_inline
>  size_t memcpy_to_iter(void *iter_to, size_t progress,
>  		      size_t len, void *from, void *priv2)
>  {
> -	memcpy(iter_to, from + progress, len);
> +	/*
> +	 * When using direct data placement (DDP) the hardware writes
> +	 * data directly to the destination buffer, and constructs
> +	 * IOVs such that they point to this data.
> +	 * Thus, when the src == dst we skip the memcpy.
> +	 */
> +	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
> +		memcpy(iter_to, from + progress, len);
>  	return 0;
>  }

This seems like entirely the wrong place to apply this logic...

-- 
Jens Axboe

