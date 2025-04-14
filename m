Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3883C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCoS/lR2mEiWt46vRU0bslOt3UMAk6Y8abNKaa9JQZQ=; b=c0Fy6S3RkSrOoKtO6RdEh5luQq
	+m9SoCrl89IaQFfbvbu/F+fPMa3ycA/6mXuGxbD2229pxhihLoxWA6he+aDQYLD7snE2KGDAmfjim
	9P1UxhlogYA8coSORVQqVlB7TAKj5y3ddCg+Fmg0jf0U/w8tDMUa2mG1X6Boz2ZsqLDqqHm1HF7Wa
	xRn2qlufLD+Cgic4qBitewxI7qWlWVCC7j/+hfqiIHplxohKBpho8jbygIhSp6YFn72XwLtKsOP+Z
	0pVjxxF8Z0FPTx1q2r4xlRvcGm3X5MgR7/iGejguKqNrdBVtW84d7K+GEKyqrLypnVNQmHBqfdvZN
	eM9xmGyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4QU4-00000003Tqt-0jH2;
	Mon, 14 Apr 2025 20:32:48 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4QU2-00000003TqQ-1ZkZ
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 20:32:47 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac289147833so958464666b.2
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 13:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744662764; x=1745267564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCoS/lR2mEiWt46vRU0bslOt3UMAk6Y8abNKaa9JQZQ=;
        b=KM+lOsNoBsd+Id3Wceam6pYnqc6RkXCUtla6w9UI765xich1BcNBAB6MqfqhkffWzR
         8CZrzZDXKP4bthRXIjYzlqT7YHaZAWHrXp42MOiwu5OAdX7h6cp8KRy4nFGiiO51LCCm
         M7A4cmygDIz4RRdBqKMZtHAq3QBoozGxpKLPEHo2D5+NBwSDPYwdBa5vUSlrjl1Hl54o
         BhH0Aewsew4YiuMdwqv7yWHqMSXT+ZDeLTGKT1FExSB6jkq2bZKW4lpzL0DPmBNVJay4
         mQYrqXAygMkwXuGIumsTo93JGM+DsSLEbD0GJleFq1HPB6Ytt0F5ar7Ajo7z5SUlLNSk
         XXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHNbjJscqjQ8rqpl26pdnPvDsj1xJgVb+lMOtzqqOOrftce0Rzn1Z3HtJx1mydDMQtcs5rtagRkGJZ@lists.infradead.org
X-Gm-Message-State: AOJu0YySMBMsErcGS8qwQFJSV29ThIfOEQoaBvejIFdrko/kO98J6Tr5
	y87H90L8XMd0J8ySzwmWgdomp+GX1lqNbI9sn4VtOjrTTOmPf67L
X-Gm-Gg: ASbGncvCbYKSLoFeWddHK8SHOxP+XSx+sC/r8hUr3ljFa1oPE7aTCJOu/Gp1bNnkJVl
	sfYD8fd39HBhO7JmbOSYhXiKFDuSYlL6MzTuRBwZMjU3DvoKaHIde4VuwpfDFjWnRzcv1Tv6480
	zQmZvN9FGRX5UHJtcyIe3SJMpV3DTr0SLEzfoixx7HlS6S3J1WoD6ZbvfjYLDSgjlRXpYCwdHQ1
	s9wjDnNphplLi1Ckc6Gvqai9a6Zl6jBT21+YZQXdgfWNEJ7hSspmS7uoVKBKwrIyuOssXaJM5i3
	p0VSc664ripJvU5tpDWwptBf2s9PfPF6bGiMUsIxmRmYM8KK7ydEFIJXk7ROkRYyxrCF0ok9
X-Google-Smtp-Source: AGHT+IE8k1Gd+CMhd0Xtie07hAYqlCEpbJFz4xjYKwFTksWdhxJj83bkMc1FtEo481A9K4p75aUsYA==
X-Received: by 2002:a17:907:e989:b0:acb:205e:e0ac with SMTP id a640c23a62f3a-acb205ef5c9mr2337366b.57.1744662764393;
        Mon, 14 Apr 2025 13:32:44 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bea593sm984012166b.62.2025.04.14.13.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 13:32:44 -0700 (PDT)
Message-ID: <59574ff2-ad14-4df9-8202-b4997c3c34ee@grimberg.me>
Date: Mon, 14 Apr 2025 23:32:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: clear NVME_NS_SYSFS_ATTR_LINK when disk
 is not added
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Nilay Shroff <nilay@linux.ibm.com>
References: <20250414122545.140531-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250414122545.140531-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_133246_417567_AC5B6A14 
X-CRM114-Status: GOOD (  16.58  )
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



On 14/04/2025 15:25, Hannes Reinecke wrote:
> If the namespace disk is not added we need to clear NVME_NS_SYSFS_ATTR_LINK,
> otherwise the link will never be created upon rescan.
>
> Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 05eccd96d34a..5c28f0dc6fad 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1069,8 +1069,10 @@ void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
>   		 * Ensure that ns path disk node is already added otherwise we
>   		 * may get invalid kobj name for target
>   		 */
> -		if (!test_bit(GD_ADDED, &ns->disk->state))
> +		if (!test_bit(GD_ADDED, &ns->disk->state)) {
> +			clear_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
>   			continue;
> +		}
>   
>   		target = disk_to_dev(ns->disk);
>   		/*

Why not change the ordering of GD_ADDED and NVME_NS_SYSFS_ATTR_LINK checks?

