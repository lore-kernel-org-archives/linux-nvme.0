Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E33CCDB483
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LHnQ4ZKZoaOJV3l4XUHkBLyFFjTJvcv5ctVeQO+EOoI=; b=d0pNc/RMj0gVcqDsxR7ZXxlLJf
	3TsM5QAxA0isYvA4GCnZv3jfhxCNTftlww8FuALsHAyOp+O/rGBgzGniHOLTIS9tROxNgXmFC+g/B
	+DfPKh514sRjObhEgthjbkHWvxXctfTJZ9ssLc9nBakhLjvTKmY8NAajBZCLXSNyXaaLIatQQHs2O
	i7LluYZ2YgIkVGUTTNIoFaqPFv0REEinurfRUKEHcs3ZAZQu6QM914FKnm1WReNNEr0WmIIPwUMQh
	vV+ySlviX4K77EYQDBKphNLGeWVx4JdFLdws6bNId1rd6HcsgxYm7d+nes3j5Z+mIEA2gBSPHryzn
	sYQVliXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLt5-00GOj1-0w;
	Thu, 19 Oct 2023 05:48:03 +0000
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLt1-00GOiL-2m
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:48:01 +0000
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57be3d8e738so4270244eaf.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 22:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697694477; x=1698299277; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHnQ4ZKZoaOJV3l4XUHkBLyFFjTJvcv5ctVeQO+EOoI=;
        b=JAGqUdauiFo0pchgASsjRWGWPpR+5rNgy0t4kjcsY77mAb9nEkA9KXCK1BTgsIeD8W
         wPt7vHnwc1EOC5nYtwrvVLnYxCRuzuSUZp3HvdPdeNuBc040fMpGWPgAegvm0focmDNw
         wwh8m4AD8ubwM/QdXCrtCFHase0Lu1bIInIoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697694477; x=1698299277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHnQ4ZKZoaOJV3l4XUHkBLyFFjTJvcv5ctVeQO+EOoI=;
        b=Cej66TBcE+gRSQPYxpdjcp70zhLo/kW9KqnkU5ijHxNAaAZpVpfFBs46PxyDakj8Tf
         qLIA8eOm5pL2AXyaXTDEdqa5ED1AMNCyI+4mIpVooAdedbHV1jHATIvQakAAiJdiwpwL
         Lw9w2ecLPkUo9aqJ5er2zU/w2XbNZID100shAx+q1rzxXqmK2pCIAirbnfaITeSI8MAH
         uTFEbFUFW7kKRtr9W49yVGyXIk5JAs+v3H79yIxweUilsL4f3NOBWcNh5+0e9aFcmumd
         hiqU7+u9kcftN1MrF1WB0q5+wDuIVRW0eIxNA2u1DBxY2uUG9i7Al74de81evk3IeFwB
         7YJg==
X-Gm-Message-State: AOJu0YyY9oc7JaG6GrMC+vcIVMzGhy6Y8Lqfw7SH34GvE/dwG+R/0KR4
	hXa2ReRWP0TOFZs9XwMvZEtrkw==
X-Google-Smtp-Source: AGHT+IEu5PHDRWVUI0+QX9JrLp+wZUJ1GzmUN+Qx4C1JP4SsZPYFUoT1fuhYI5qBjJPg/eBSdZrWhg==
X-Received: by 2002:a05:6358:7e16:b0:143:8c4e:283b with SMTP id o22-20020a0563587e1600b001438c4e283bmr1422228rwm.0.1697694477305;
        Wed, 18 Oct 2023 22:47:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r2-20020aa79882000000b0069344caf840sm4422330pfl.18.2023.10.18.22.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:47:56 -0700 (PDT)
Date: Wed, 18 Oct 2023 22:47:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
Message-ID: <202310182237.C256F5B54D@keescook>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_224759_918513_9079F084 
X-CRM114-Status: GOOD (  30.24  )
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

On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both data->subsysnqn and data->hostnqn to be NUL-terminated
> based on their usage with format specifier ("%s"):
> fabrics.c:
> 322: dev_err(ctrl->device,
> 323:   "%s, subsysnqn \"%s\"\n",
> 324:   inv_data, data->subsysnqn);
> ...
> 349: dev_err(ctrl->device,
> 350: 	 "Connect for subsystem %s is not allowed, hostnqn: %s\n",
> 351: 	 data->subsysnqn, data->hostnqn);
> 
> Moreover, there's no need to NUL-pad since `data` is zero-allocated
> already in fabrics.c:
> 383: data = kzalloc(sizeof(*data), GFP_KERNEL);
> ... therefore any further NUL-padding is rendered useless.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> I opted not to switch NVMF_NQN_SIZE to sizeof(data->xyz) because the
> size is defined as:
> |       /* NQN names in commands fields specified one size */
> |       #define NVMF_NQN_FIELD_LEN	256
> 
> ... while NVMF_NQN_SIZE is defined as:
> |       /* However the max length of a qualified name is another size */
> |       #define NVMF_NQN_SIZE		223
> 
> Since 223 seems pretty magic, I'm not going to touch it.

struct nvmf_connect_data {
	...
        char            subsysnqn[NVMF_NQN_FIELD_LEN];
        char            hostnqn[NVMF_NQN_FIELD_LEN];

Honestly, the use of NVMF_NQN_SIZE as the length arg looks like a bug.

struct nvmf_ctrl_options {
	...
        char                    *subsysnqn;
	...
        struct nvmf_host        *host;

struct nvmf_host {
	...
        char                    nqn[NVMF_NQN_SIZE];

ctrl->opts->host->nqn is sized as NVMF_NQN_SIZE, so this is like saying:

	strscpy(dest, src, sizeof(src));

Which can go wrong when dest is smaller than src, but that's not the
case here. It seems ctrl->opts->host->nqn is expected to be a C string:

drivers/nvme/host/fabrics.h:        strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||

And subsysnqn seems to be the same size:

drivers/nvme/target/core.c:     subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
drivers/nvme/target/core.c-                     GFP_KERNEL);

So these really look like bugs to me. Perhaps a follow-up patch to fix
this, if nvme maintainers agree?

Either way, strscpy is an improvement:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/nvme/host/fabrics.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 8175d49f2909..57aad3ce311a 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -386,8 +386,8 @@ static struct nvmf_connect_data *nvmf_connect_data_prep(struct nvme_ctrl *ctrl,
>  
>  	uuid_copy(&data->hostid, &ctrl->opts->host->id);
>  	data->cntlid = cpu_to_le16(cntlid);
> -	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
> -	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
> +	strscpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
> +	strscpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
>  
>  	return data;
>  }
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231018-strncpy-drivers-nvme-host-fabrics-c-416258a22598
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

