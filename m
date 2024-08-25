Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0383C5320E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ijKgv1dIKHwLDKUDihAR2n1k+JksPwnhOuxXr0A3OIg=; b=3kcjKRydgRUiNa+FCOw2Z8u9eP
	ET6m6YLDypCuOKwaT8/g2Bmxq+DWTCxn0wuNCgyBnSrCgW3HUBruDQotGOnfZRL3t9L7UCoqWrE/B
	nBMeco7lhq0nZxMYGyZ14QGHaHBfFZneqnFXFFaree0GPW3g9GrchV24OyC7Nv/DIbs4TKfdTRmZz
	R7iZUkzc4ip0CEyqI4byDF+0qe1AZ3VCtkHtluCJHmHiK+eDhxrwQg17gycAiGR2tjNZwpAs92pz0
	9j2y4NFufhaXHUskVgoHwnt0GD9LuoIeBUKJBrO7vFXAF3GOyV9jAnu6q8hAbdBX/mNhIXa4bKHOY
	zNM4Jbgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si92D-000000040Oe-3dzl;
	Sun, 25 Aug 2024 08:55:41 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si92B-000000040O6-2JUu
	for linux-nvme@lists.infradead.org;
	Sun, 25 Aug 2024 08:55:41 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ab880b73eso29069735e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 25 Aug 2024 01:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576137; x=1725180937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijKgv1dIKHwLDKUDihAR2n1k+JksPwnhOuxXr0A3OIg=;
        b=UagiaodejAMLdKD42X6XFvD3YyLxbyDmyv2PfPICeI3qlQVudeBoPVScRKe1JNkMZu
         CbpxHJs0uoMTXBtrqfbYV/OSSvzoyqslIrfNTie2AFn8nWde9hVzzIU7GoJXkkAkewcA
         kIH6gS9HJ0guJaeAeCyovQT3AgcQ7wh95PJ6ev6sy9eayyWR0RzIyqz1yxznQWiJ+wfA
         MX02jG1PnzCNWb7VoCo/8s7EvVSf3qwniUktc/kuE45i3w/JvRfgBwkUk/ZaHtZjVksQ
         0QwmjBDz+HzcEc2pduFXVVy0y2hOc8JUXP9zlAvOJz+HfiwomKqYlWxLplkKwXvtKvwX
         rU0g==
X-Forwarded-Encrypted: i=1; AJvYcCXEYUTgXKLz4O7QS3reIHq0ftWAW8c4DqPLzdF+L9jOhWh0sUnSdyGSETvGoHx48YrjLRciYNE3nkHX@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3M5vrEv6w1vcp7rUJOZJpe5tdKB1t9P3/XTrzj43ZGSTazaoH
	3oDb3EJsJxapHI50MoZal11rCA5z5o59E30A+1K836+cvRbigztL7YCqyA==
X-Google-Smtp-Source: AGHT+IG0XXimBp1upFlDeBxhYESLqdJi/4e4va2MkK8hd9D7mES6+73Bvl3Tu0FjsxKKBuivFW3puA==
X-Received: by 2002:a05:600c:348e:b0:428:17b6:bcf1 with SMTP id 5b1f17b1804b1-42acc8e143amr52269215e9.22.1724576136648;
        Sun, 25 Aug 2024 01:55:36 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeffe93bsm155918865e9.42.2024.08.25.01.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 01:55:36 -0700 (PDT)
Message-ID: <35c9bea6-0898-428c-ba23-04c7444494de@grimberg.me>
Date: Sun, 25 Aug 2024 11:55:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] nvme: add nvme_auth_generate_digest()
To: Mark O'Donovan <shiftee@posteo.net>, linux-nvme@lists.infradead.org
References: <f82b4614b95be6f826da4350fb39c4eb8daafbfd.camel@posteo.net>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f82b4614b95be6f826da4350fb39c4eb8daafbfd.camel@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_015539_647583_7A0F5A6F 
X-CRM114-Status: GOOD (  10.51  )
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

Your patch is not formatted correctly.
Please create a proper patch and use git-send-email to send it to
the mailing list.


On 21/08/2024 13:18, Mark O'Donovan wrote:
> +	hmac_name = nvme_auth_hmac_name(hmac_id);
> +	if (!hmac_name) {
> +		pr_warn("%s: invalid hash algoritm %d\n",
> algoritm should be algorithm.
> This typo is also present in other patches.
>
>
> +	ret = base64_encode(digest, digest_len, hmac);
> +	if (ret < hmac_len)
> +		ret = -ENOKEY;
> +	*ret_digest = hmac;
> +	ret = 0;
> The value assigned to ret in the if statement will be overwritten.
> It looks like a goto is missing.
>
> Regards,
> Mark
>


