Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C93C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BAZKxJhTaJgMackVKM08joN9qY6YHLI94OBfZ6Xd8Q=; b=5ACDfyi8jz7M/x0UqQfzJdsgtl
	9SZpuba0pXD1x2L/bvV9C1dgVhlEpSEzHFgRwSKRTpac3hOr7mpz5c/CKZ+v54fDWvZwCCnjYefPp
	xOoZd1eDSAn8i98prm5aDuX7DI23SrOaYVEzVXL8JyALv72WIepdm83FCaOl58rnVb4w9RepEFHS2
	NSQzjtLah+jPJXUMFdJP0RTEUrKGr3T3c/Y8powouAp3iPp96NhF7ey4S6lb+BFmMw077CrCUKbSj
	DuOS+QCmA6kkVUUBZUq9UOujUZm590xmXr6hACbrbrW8mX8tY/q8yRv1eYJK3H9knMW/F5dzkkrby
	ouuihBqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prwhD-005mW0-1r;
	Thu, 27 Apr 2023 08:09:43 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prwh7-005mTr-1s
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 08:09:41 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-2f4b604e234so983848f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 01:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682582970; x=1685174970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BAZKxJhTaJgMackVKM08joN9qY6YHLI94OBfZ6Xd8Q=;
        b=KesMMdkgpXcCmdeRZJdYWz4V7V5tuPX+OkObLPJP64Dk8QGHnZSKrwhuXtQNX5AVu7
         K1CgwXnD9A7ItcoO6+nkoGrqpcuXHjAGZuM6dPF5HcIu86mZzDB4s+eLaZ63cpgPbVaG
         MpvpOIoEafhio+ZzwheKTJKPKRQLccZLHdhOraX4zR+gAdHHbtBG3uvy96ar6PdhQ+6p
         /5dFZPfZFyrNJZbbSkdSjf5MEza/Tjlaalcw8+nmwjOM5QnJrLmq9w/Kogn6Aw+eFmyd
         LXqX9Pazo/QVoZpHO2NZvBGrNqJCjTjHKHMkCA9ecglQooJf16SQAE6KLSuEWoCwtamU
         kfpg==
X-Gm-Message-State: AC+VfDwkob1VHFcM7oE4a8HerghNqUfFLl0tMsdZTZM9HvepinOv9OhX
	+tPrdhXeS8Umu6mJOzh11RA=
X-Google-Smtp-Source: ACHHUZ5WSjgiSiqkdfJOs86NLLnzdAWdGH8J9eMl2uzBSwkg6HOrQbACsqSmEL3H7QL8FxIvuDRJ8Q==
X-Received: by 2002:adf:d4c6:0:b0:2f7:ee2:c2a3 with SMTP id w6-20020adfd4c6000000b002f70ee2c2a3mr520690wrk.3.1682582970327;
        Thu, 27 Apr 2023 01:09:30 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s9-20020adfdb09000000b00301a351a8d6sm17259317wri.84.2023.04.27.01.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 01:09:29 -0700 (PDT)
Message-ID: <b0d4b552-4ed2-9338-b567-c23507b266a4@grimberg.me>
Date: Thu, 27 Apr 2023 11:09:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] nvme-core: fix memory leak in dhchap_secret_store
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20230427080456.18232-1-kch@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230427080456.18232-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_010937_618507_64FA77E3 
X-CRM114-Status: GOOD (  15.34  )
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

Needs a fixes tag

On 4/27/23 11:04, Chaitanya Kulkarni wrote:
> Free dhchap_secret in nvme_ctrl_dhchap_secret_store() before we return
> when nvme_auth_generate_key() returns error.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 518c759346f0..5a9d97c0c0c1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3814,8 +3814,10 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   		int ret;
>   
>   		ret = nvme_auth_generate_key(dhchap_secret, &key);
> -		if (ret)
> +		if (ret) {
> +			kfree(dhchap_secret);
>   			return ret;
> +		}
>   		kfree(opts->dhchap_secret);
>   		opts->dhchap_secret = dhchap_secret;
>   		host_key = ctrl->host_key;

Other than that, for this and the next one:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

