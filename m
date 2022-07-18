Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48240C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BDk2cWyagxM+/BuKmtXJs6I1hNKLhtHk/a/QPeEpbPA=; b=gcd9tA/aWH1l+lDAic46t6w0iV
	7CMJ/1W3OZysbAGd7VA/BYUFC+GJVmCaB/d43hEJ5MdMbmEx1qePqcaZdpo0zQ66XH/FvtbCk+10A
	jHq+R64IF6RQvHIpyFmHf1ynqwGeDvjYq/f+4r7DR0Ty7Bqr5aN8+2bZiaDgxipvHZKlqOtLYRl3+
	8kTIArEHAX+8aw29pAUeieOyiYkr4QD7hRw/4qm+riIbuR2HqJYnO4l7gguzPJLRSRTO6Qqx5SAY2
	Ht29+jC43AoQyrvbL7vURd3Fq/J1PXrmZTxZnLPtv8lW6/cZQo/8x0vJGNP+COBafZ8N1SXIOixYV
	mKPMcueg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJjf-00B7jG-9h; Mon, 18 Jul 2022 05:56:03 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJjd-00B7iH-BS
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 05:56:02 +0000
Received: by mail-pl1-x631.google.com with SMTP id q5so8116496plr.11
        for <linux-nvme@lists.infradead.org>; Sun, 17 Jul 2022 22:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BDk2cWyagxM+/BuKmtXJs6I1hNKLhtHk/a/QPeEpbPA=;
        b=QY3Ib2vIO9RuVEVRhj5+qPtjjgB0zkckjPqm5ao9K0Qczo5Uuyh4bS4g5SqCiAu0Xm
         LX2F4CD4lPVn7YyAsVJo4+N9WIzdxQpFgaAJRmeyuOhixaiQj9Pcf7exxbbB4w1xom13
         AgBXgD6eCtPg1HPYSzT1RsakC5ch+h1bh16zxDHiRfozRQZnsTvDxz8Es7hAnUe9zVfF
         Qwi7LBqcnxhTFsHMSpBGtV6fBoUvm9utum3ck0vSi1rLcowmBS6s8TGxys92ZCPLleUp
         xFAxjd6hVsCvD/cQKYzVRJiky+ViE/2ihnfBO8hmSEfikchqFc84xp/odvY2jAlHmgP7
         2FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BDk2cWyagxM+/BuKmtXJs6I1hNKLhtHk/a/QPeEpbPA=;
        b=UivYlKhVACSIPr2SpwmkIH/DlD82rSHsDbd1ppjFjeClVA8j09xrcJpi0RuEXTeLs+
         w+LBUpwxaNsdLj8hURDdf24qr9JmCLkHQ0LeWbxeQqsSe+q2qo47Vw7awdb1YHMRXJUs
         L3zEeie3eAFioZOrC/UeyxQmlJyeHz72+z2ELY7MvOgwiP7RclGaq4dOTVFqGgDMFuUN
         pR8rep76olwen5f4TJJR8m9NAUh0ba9Vji6+Aw0zG5jZ0xOElRWdOr9M0fKL5wQsBs/a
         GvFiBL7HgY9J/zaXpnnAf5ltFrQtDYFatN3kUeCCqkn0N/PyYZKdiS98dz+d+FdjdKdR
         ODOg==
X-Gm-Message-State: AJIora9ZkD+NhvGuvQX8GVhCJzdvg1T1OOcSCFWQfJDFU9igsU1q+/YA
	xfESvMKarC2VU/BS032xZtegDqnx7GX3lQ==
X-Google-Smtp-Source: AGRyM1ulcwE79EcdRIyHhoLn+anJv1QA9eoJ7vfMZuVUuM4yNb8bs+HjbJXMORBtNLOsL4BuvSoJWQ==
X-Received: by 2002:a17:90a:880a:b0:1ef:76fb:d8b6 with SMTP id s10-20020a17090a880a00b001ef76fbd8b6mr30678032pjn.69.1658123759657;
        Sun, 17 Jul 2022 22:55:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ik5-20020a170902ab0500b00168b113f222sm8338976plb.173.2022.07.17.22.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 22:55:57 -0700 (PDT)
Message-ID: <46e50184-9cb3-4613-906d-3ffc4ec93391@roeck-us.net>
Date: Sun, 17 Jul 2022 22:55:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvmet: fix a format specifier in
 nvmet_auth_ctrl_exponential
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, sagi@grimberg.me
References: <20220718050356.227647-1-hch@lst.de>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220718050356.227647-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220717_225601_457152_C3130099 
X-CRM114-Status: GOOD (  16.67  )
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

On 7/17/22 22:03, Christoph Hellwig wrote:
> dh_keysize is a size_t, use the proper format specifier for printing it.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/nvme/target/auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index b41c7bbcc4366..cf690df347758 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -488,7 +488,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
>   		return -ENOKEY;
>   	}
>   	if (buf_size != ctrl->dh_keysize) {
> -		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
> +		pr_warn("ctrl %d DH public key size mismatch, need %zu is %d\n",
>   			ctrl->cntlid, ctrl->dh_keysize, buf_size);
>   		ret = -EINVAL;
>   	} else {


