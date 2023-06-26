Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B289DEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jun 2023 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qMePQhdtBcD145xWWP6ObKBgPBwVavSA5DCnm+uLPN8=; b=xNJf/rh1oqbpzS4PA+Ug1Y/VV6
	joP6DVmNvznE19vL7MyMOzrwfw6Z7636DUNb3h0rKZTsiQvFYBi/qJv6TFtJV33N9WW7EdQvcr+Ib
	FurmIp9IXG7gZm0owct3lgThlREjI380NB2gJdzCJHDu2qrN+uoPZUQJDGE2MLEqgsJtoRLVorDCH
	eWSguH+LaskQhjufw1Y51vMhHBX7toF5vwjHeddMfE1FOjFzK0rhXgTihie5VRuymUbM0oYmWc8M6
	ZlmqLKwet/HNsiAEAJG+zGyRC+ee4bBB6bq2OWttY3KGydKABEu0Lg2YuAKzGncbClHduqY5Opsrt
	+ryCjCXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDkTL-00A6GH-1X;
	Mon, 26 Jun 2023 11:33:31 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDkTI-00A6Ee-1S
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jun 2023 11:33:29 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa96fd7a04so9703575e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 26 Jun 2023 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687779205; x=1690371205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMePQhdtBcD145xWWP6ObKBgPBwVavSA5DCnm+uLPN8=;
        b=U6qu03h0316pgcKA70DgwCkGBgdWx68jKFZW+1WrRbBsaHb5uHLiy1iibBG3su9pDe
         n4qg8U1R2B0+Q71zIEflIORXD3QiaQU/DDloPAr7wnCXwOLQVfxhWE7iGBtSuafeHA1n
         McIfhqj0WwFIQLFFCB5JcbARHZvEHcMCwYDmkVCaIb69S3S73jdmMyOvg1Ryq5NIE35g
         bWVeYdHid7Dtw2zL/YB69XFYaYIiWbTVnSADSY2s4q1Q+6ArVrR39Axfvui+9+kx/kVd
         SliSHdJiwBXy5FFLZhNG6iy4Q7jX6afHZbji/zyaJEZJdkHVDnn0gUa+4K5mINDF3AtG
         UxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687779205; x=1690371205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMePQhdtBcD145xWWP6ObKBgPBwVavSA5DCnm+uLPN8=;
        b=Uf1KxoDHpVye6bKQ0cWwk56ajc3cBll7rSvhkNqG7W8Q48jjB5ur1uL5Qsr2tXHQox
         8UpF+YddotSYC7qMbukomBfp1+L3E4jcwLHlkkkxVilm7g+VBCGF+MnGfCjSxxTRoowF
         QfOcjIMHPucgKf125nuB3JCUCy0cdaVT+2uWjBBPodNq0AsRv3+xK1OF09efxmNrIhxF
         tA75uL3v5LAn+L+DOqorgi0aPHpi6V7u7QiWeQgU8bSV5SVTHh+gXcoZ+WMUDtWBwR7B
         CV+CKsTmOde15AJjEU6Aji0tT6lkqLK5YbfM1tr4xiVERVaA+63uQc8NMrvgZ/r1OF3C
         9eWw==
X-Gm-Message-State: AC+VfDy3tQhGsgtvB22WtPwLv2g/9Djd33GLh4JXVqZq7SfBWBBOXmLN
	fqn30h7mN7mnhXcks/E2o/zv3A==
X-Google-Smtp-Source: ACHHUZ4VqIEYP2PnHQc0NwXfgsVq3bgr+yPFv0RukQVPK2hxMBmZPFYLFUNb0ZpxLDmYzqbgruO3Yg==
X-Received: by 2002:a7b:cd11:0:b0:3f9:c7b0:4976 with SMTP id f17-20020a7bcd11000000b003f9c7b04976mr10274874wmj.12.1687779204683;
        Mon, 26 Jun 2023 04:33:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f8fb02c413sm7453169wmb.8.2023.06.26.04.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 04:33:23 -0700 (PDT)
Date: Mon, 26 Jun 2023 14:33:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Message-ID: <3ea88e87-9b24-4f7a-958c-97e27d94ec30@moroto.mountain>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620133711.22840-5-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_043328_494026_E8396965 
X-CRM114-Status: GOOD (  24.02  )
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

On Tue, Jun 20, 2023 at 03:37:10PM +0200, Daniel Wagner wrote:
> Commit 4c984154efa1 ("nvme-fc: change controllers first connect to use
> reconnect path") made the connection attempt asynchronous in order to
> make the connection attempt from autoconnect/boot via udev/systemd up
> case a bit more reliable.
> 
> Unfortunately, one side effect of this is that any wrong parameters
> provided from userspace will not be directly reported as invalid, e.g.
> auth keys.
> 
> So instead having the policy code inside the kernel it's better to
> address this in userspace, for example in nvme-cli or nvme-stas.
> 
> This aligns the fc transport with tcp and rdma.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 472ed285fd45..aa2911f07c6c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2943,6 +2943,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>  	/* force put free routine to ignore io queues */
>  	ctrl->ctrl.tagset = NULL;
>  
> +	if (ret > 0)
> +		ret = -EIO;

All these checks for ret > 0 make me unhappy.  I don't understand how
they are a part of the commit.

I have tried to look at the context and I think maybe you are working
around the fact that qla_nvme_ls_req() returns QLA_FUNCTION_FAILED on
error.

Also the qla_nvme_ls_req() function EINVAL on error.  I just wrote a
commit message saying that none of the callers cared but I missed that
apparently gets returned to nvme_fc_init_ctrl().  :/
https://lore.kernel.org/all/49866d28-4cfe-47b0-842b-78f110e61aab@moroto.mountain/

Let's just fix qla_nvme_ls_req() instead of working around it here.

And let's add a WARN_ON_ONCE() somewhere to prevent future bugs.

regards,
dan carpenter

