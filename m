Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206C5C004C0
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxLJorg7sQZllVq+pAfloWwR0pqLP2/+/WDA8tc+KdQ=; b=b/mZaV0x82pZ+r1l87JXWS7ehX
	rS2wf6dJjb0cuifsavQ5NYAAtpsnRhxUXtvxRnnblgPHdI5GIUIAkVBCH8c1oCJrJL9W4KTmZhtNz
	+bMGZPCIRKIjD+ApwvUeWWVqCNiGmw3Py27o+E4K0XQfeXPzMAdI30i71wjaGHvU8d0MBc/66TK4c
	XmE66eCHcnXg8v5y0TCfoerDXGNL9VR2zmyzCAzwYle1l3VX98sdDM3zNWznFiatJUbsJC5G8gFyn
	KIvI41QwaGbYCE95vY/RgEE//ExdYxmZyvIWkQBgRA++kcnntkxO01nKE/FNmEwyMhV2lAuMtEY2U
	wGh6T5uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtcJm-000s46-08;
	Thu, 19 Oct 2023 23:20:42 +0000
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtcJh-000s3C-0R
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 23:20:41 +0000
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6cd1918afb2so163961a34.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697757629; x=1698362429; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxLJorg7sQZllVq+pAfloWwR0pqLP2/+/WDA8tc+KdQ=;
        b=aWXQ0RGcY9Rs22CwU2kmPaLivHCSPvwKxnfQdfBFuVS7X03HeXRQbkz1E1cfizBehU
         /LUaDAUjB5ycQcNk6aNu4GbMhkWOotlm4F/sfLU8YC4AS6tWfuIOvwDjcpPl3QczuGnP
         u7gZClTIZHjM89z6eSD3FucX2uJ5QqPa/adNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697757629; x=1698362429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxLJorg7sQZllVq+pAfloWwR0pqLP2/+/WDA8tc+KdQ=;
        b=g0zUxJXkn3ITfJ775qeYEEjdh63r7+DynLdl1AtGY9Zhx2JscNx6BTcw8xMoPokZXK
         R7+zydX32v0EnQKFD+oPUZq82fk/T3PsX+rgrH5od/0iMVOTuwLNI8wPhVBYSKrp664F
         PKafbOZuw1vjOt+4mprcZApUFK6RuRlqMnAPJaWBSWAAU3fGcSMcrVgwQaPQNI7NL+K8
         +7LtbsolDU0h+qopvg3VW6GvssWRQq3WBlPCR3oWS24poyw6Bc9yQC0vvSaY2L+dUN8z
         UT3xQdHEeJDvyU5lTxOA2AWmQZg6Hdciof/IXazFUmuYhgNg6hvTJuReWAXkD5g4KWV5
         YY8A==
X-Gm-Message-State: AOJu0YxcTabZAbMuOGdzm+uCseaHoszTM5MuGMonN2vLpmEqr72Mm+lZ
	6U4P+bYupJO0SvHaIyIUFUieYA==
X-Google-Smtp-Source: AGHT+IHEKbiPITy9hpXV8pY+6rphvwnVu5/SOd6iNrHlgO7+Ii4hKo6iceZRtrHcdzoNlQQHAXQilg==
X-Received: by 2002:a9d:74d7:0:b0:6cd:cac2:e504 with SMTP id a23-20020a9d74d7000000b006cdcac2e504mr248754otl.18.1697757629690;
        Thu, 19 Oct 2023 16:20:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020aa79e87000000b006b2e07a6235sm302622pfq.136.2023.10.19.16.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 16:20:29 -0700 (PDT)
Date: Thu, 19 Oct 2023 16:20:28 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: replace deprecated strncpy with strscpy
Message-ID: <202310191619.6BE8E38@keescook>
References: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_162037_179765_EE0E4DDB 
X-CRM114-Status: GOOD (  22.28  )
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

On Thu, Oct 19, 2023 at 09:34:35PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's instead use strscpy() [2] as it guarantees NUL-termination on the
> destination buffer.
> 
> Moreover, there is no need to use:
> 
> |       min(FCNVME_ASSOC_HOSTNQN_LEN, NVMF_NQN_SIZE));
> 
> I imagine this was originally done to make sure the destination buffer
> is NUL-terminated by ensuring we copy a number of bytes less than the
> size of our destination, thus leaving some NUL-bytes at the end.

Yeah, this is odd, but I agree that the resulting strscpy does the
intended copy, since we've seen that other nqn strings are expected to
be %NUL terminated.

> 
> However, with strscpy(), we no longer need to do this and we can instead
> opt for the more idiomatic strscpy() usage of:
> 
> | strscpy(dest, src, sizeof(dest))
> 
> Also, no NUL-padding is required as lsop is zero-allocated:
> 
> |       lsop = kzalloc((sizeof(*lsop) +
> |                        sizeof(*assoc_rqst) + sizeof(*assoc_acc) +
> |                        ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);
> 
> ... and assoc_rqst points to a field in lsop:
> 
> |       assoc_rqst = (struct fcnvme_ls_cr_assoc_rqst *)&lsop[1];
> 
> Therefore, any additional NUL-byte assignments (like the ones that
> strncpy() makes) are redundant.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com/

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

