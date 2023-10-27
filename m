Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F34EC25B67
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sO3pDvoK2XqmvW6XHeM4oFmiaQfjqAPIGza9kcBSOXQ=; b=19E9qIqUhkZxKXA7heb8YwTU84
	FNXtzlAEjxziCb5t9GBAGQiXmP9LHQIBm1pg+WJ2e61wtRQwaVEcMOmJpiZnWRfi9CnCajuEabNQT
	K1cLqPaUpJfOb25EY3ElmQap2OzzkzH6BByw+hn2R9m6O31PxGFM3+rtxN+2/TtUPUX9NgdJNLEtZ
	4MMPVgFDLqa4xoUu2UKrBNZ9W3lp9SZ33rLJ0wTNB5hcKCakIcdzAqmgG630u/hgnxSORQWyCTenM
	tWcWOxVOGLr9apOKK+BasfhGfwaD6wEJt9rhm1hzf5k/cwU+nF0h9Ohsw4Yemq8ZGaV7ZSNHCEyCK
	unT7pv6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwJ92-00G1rf-1o;
	Fri, 27 Oct 2023 09:28:44 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwJ8z-00G1qx-27
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 09:28:43 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083f61312eso14350135e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698398919; x=1699003719; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sO3pDvoK2XqmvW6XHeM4oFmiaQfjqAPIGza9kcBSOXQ=;
        b=EraN6Ox5W4HFIbTq7YfqoLtdIySNlC4gQJK5pTyrsiPSDuM/c1B9uGlwN5CBUjDnhF
         Bp7f1p+vFj56UfYm0toha7F8z7ThbLjc0eVWdkVzOwp2SpLS9i3V9mYjcGBWyK2TSpMA
         xHUte11H+OW5Q1mb9cbNTgWUa7Fo71B72wPTeIX/tCzuBDKSwsd051GRlVMCq++cz0WP
         g0XnVLaqP85rpanwS74iTh16qhBgfiESMxN7mR25EWQ52CzSNgHVm4b614Jwu/j8/uoa
         aJRke0M2uXMZD5TeQQn1z34iItFp1uIo8wlYXf8iky/z6eWDN7ANFsx71cVs610Ij7RY
         15tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698398919; x=1699003719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO3pDvoK2XqmvW6XHeM4oFmiaQfjqAPIGza9kcBSOXQ=;
        b=OvQaC0xojeSs8oJgHRw3ErdflNeSliyTi6V9YvpnsiKQ1QQL3TNMjnMo9IyPWTyZ/R
         NtHDieQm2WrLRakCVZVo4QPcbqfDALz6BzZKrpPbIYKLQQ7fNXPhyyVOC6b99TxiTgIv
         7BipIi8IMc6np4Lgj2GMQhreC3fbYaEW1ecsNgdFXtGk6neYMPFhleCJOk4jbQrKkozu
         r104YXmJ8Efq6Y4rhxlTJbwbsDDtxO0SZRj859SymGiBhwfwcdmEsoRMMcWL6LOBZr4p
         cPl43tD4EKllwoIsxgUbdJFz5k1dtveC3d4lGyJEj/0FaoavMrf8Hgxe86Grr+a92pLT
         fnkw==
X-Gm-Message-State: AOJu0YyYh79r96gvU1B4CzijxTZijUseWWdSyLkNvIv15MRlFQg533I3
	O+FYKMdr+KgXC420AlJ+1ck3oahnvrfTIyn4uI1GqQ==
X-Google-Smtp-Source: AGHT+IGdZOFPu9N5qOq8J7r7QUSsltfmeU/YPCuaLg36q9UbxhlikmRWvDBae+Q+yyhiXBe+tOd6sw==
X-Received: by 2002:a05:600c:4748:b0:3fb:feb0:6f40 with SMTP id w8-20020a05600c474800b003fbfeb06f40mr1996803wmo.11.1698398918799;
        Fri, 27 Oct 2023 02:28:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm1168755wmq.14.2023.10.27.02.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:28:38 -0700 (PDT)
Date: Fri, 27 Oct 2023 11:28:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
	pabeni@redhat.com, imagedong@tencent.com
Subject: Re: [PATCH v17 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <ZTuCxUJnQM509L8e@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-3-aaptel@nvidia.com>
 <ZTfNfvtZz7F1up6u@nanopsycho>
 <253h6mcjuq0.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253h6mcjuq0.fsf@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_022841_714844_84C4C0A9 
X-CRM114-Status: UNSURE (   7.21  )
X-CRM114-Notice: Please train this message.
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

Fri, Oct 27, 2023 at 11:11:19AM CEST, aaptel@nvidia.com wrote:

[..]

>
>>>+      notify = !!ret;
>>>+      ret = prepare_data(data, ULP_DDP_CMD_SET);
>>
>> Why you send it back for set? (leaving notify aside)
>
>We send back the final caps so userspace can see and compare what was
>requested vs the result of what the driver could enable.
>This is following the convention of ethtool features.

Okay.

[..]

