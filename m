Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5BEC77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UrbQ52WnCDEzpuP7mp+Xy8URjdCv/Ow5DtS1hYS2qVQ=; b=GuhBXD5SCiPQmgKGv0lWoJFZMs
	JAOcdB/UuJ8jJoOnqZEB/Tl62SNBtItt4M0BBBo9ns2e7f+7OUvRYLbVVN10PCWT17Qy7gLbiVe+x
	4SPvm4B32jMI8QBgI3haA/3k2JrbWXSq+XvKv0zt3+9O9gkbAgGcKXZc31PmRdXrArnK4MA6lqxaA
	tCRCCmkRiLxkIkUZdJGQp+lI19ckWNAG20PjN9OT+ubM2OA5Rz7C3FyBixRVFYxXFTE2XWGqeIX/t
	SCshr/FYPddk/Ldn0HdLrjxfj7Y4KcBybs1OumFMN5RVvyIgprbQY90cHGtcPw7NJGo1pX4Qp1wAb
	jAju7ehg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4JR-004m9X-1w;
	Wed, 19 Apr 2023 09:41:17 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4JP-004m8u-0E
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 09:41:16 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so13993995e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 02:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897272; x=1684489272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrbQ52WnCDEzpuP7mp+Xy8URjdCv/Ow5DtS1hYS2qVQ=;
        b=ZtF7oUR4Q3As3ya2ntzSFaAdChtXVEaB6mNcuguHO3inYzbPYpuu/AHdjT7LjLftmy
         h5iArytCMYbPxlRGEvCF3EE7tuo/lClq3vlrNA2pMX0mbU50qf0xY/qIIMeGm+joPdPW
         7dVumGnQmT0ovAKAXt+KrO1hpt3VAy5uAAGlbElYEdP4gSPteYNgnWmevChPB6iuSpCB
         HKfn3LFf4yEBMD6RrNG3FCkjzSER+eott9qqHFJOyNmGTjaTcEfQe3cenW1Q3F+7iyIB
         s64ula/Uw/uo64W1myZyLOQStUYVxm+KI/ICBODWGW1vD/Mdw97RQt3uOruCSGJdxFn9
         Y3bQ==
X-Gm-Message-State: AAQBX9fq8F+eD0Nr2q0HyxGbV6acPeDFgTQoND+7Ota6JVLZxiqe9ZmY
	BbEOUM3J0L5YzZy6PamFEZ0=
X-Google-Smtp-Source: AKy350YN/Rf2SZ1ME0rb1VR3LA6oyESPfK71x6IS5j3OPheOdpplpGnd4DdvemgbvhcXY4+S55JHBw==
X-Received: by 2002:a05:600c:310e:b0:3f1:78bd:c38b with SMTP id g14-20020a05600c310e00b003f178bdc38bmr4795553wmo.4.1681897271920;
        Wed, 19 Apr 2023 02:41:11 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003f0aefcc457sm1608734wmo.45.2023.04.19.02.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:41:11 -0700 (PDT)
Message-ID: <a58b526d-2e29-6c4a-e277-b684f98636eb@grimberg.me>
Date: Wed, 19 Apr 2023 12:41:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH blktests v2 1/2] nvme-rc: Cleanup fc ports in reverse
 order
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-2-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230419084757.24846-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_024115_105741_D0D84575 
X-CRM114-Status: GOOD (  17.78  )
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



On 4/19/23 11:47, Daniel Wagner wrote:
> We need to free the resources in the opposite order as we allocate them.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/rc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index b44239446dcf..ec0cc2d8d8cc 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -204,10 +204,10 @@ _cleanup_fcloop() {
>   	local remote_wwnn="${3:-$def_remote_wwnn}"
>   	local remote_wwpn="${4:-$def_remote_wwpn}"
>   
> -	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> -			       "${remote_wwnn}" "${remote_wwpn}"
>   	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
>   	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
> +	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> +			       "${remote_wwnn}" "${remote_wwpn}"
>   }
>   
>   _cleanup_nvmet() {

Does this fix a bug? if it does, than it should probably be documented
that there is a driver bug because userspace teardown ordering should
not trigger a driver bug.

