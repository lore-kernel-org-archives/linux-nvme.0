Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8090C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:45:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEA760FE8
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACEA760FE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=baJJFL0hFUfU7Dc5WcdikeianeTx5afpvb9Zy0QEYec=; b=vMdBVplp3jvJ+3Gh1J7x52pv8B
	Hu/aANn3/pLBPWMrOgxmA7ZX9JNY8fNKML2wxFwUlQhXgej5OHt04Rm98r61b4wI+mgVkiJuoWUX+
	L6XeEpNeAgWmX8nA7zyBEvfx7Sf3TPYUPJuqT+7ZH7ElfWFBGd8NE3zz3wbIk+GI3tvCj1KtziQy5
	MnDG5P8IHBl9BTLpp0rN02lRz5L2qudyHeCT9TjcFA9zDfmoZWWbG5YQZb1ggomsDv2h2M2OQZTzL
	Rh46UCwaDPWRVZvgjKSODwATkwnie2IudY0jECzxiBWZoNkdgUHXch9FVfeLCOzZCxGV82ycUb7qY
	awKoTBuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoUK-001HNA-J0; Tue, 19 Oct 2021 12:45:04 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoUH-001HLR-PW
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:45:03 +0000
Received: by mail-wr1-f44.google.com with SMTP id y3so47691026wrl.1
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 05:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=baJJFL0hFUfU7Dc5WcdikeianeTx5afpvb9Zy0QEYec=;
 b=aVzi6SuLrfSlnfeH17uv2+zUDEJP4g0LT9SFxTkdpdtuYrITcCrvhV3x+k0a3dPljy
 TfD1VIi3L6UmBA+xtPhyoGgRk5ccZfVf0q+TkfI37Z5lV7Km61LuuJ9dwcWlTsUheV7Z
 z0JWqF0A9BilMygUQq2VdxQdt1R1XIBSkEdJcsTap8Xaf2osx7Q/OVCjtrcqwSGZk0J6
 zOTiiXFVV6/NW55lOpmE194CbYwU0H7e530eNiEyL9mxAuXjn9wRQO7PfQY89HoKSmFx
 MIEmFVgoaQmTQ053My5MrrIsEMukclfb+PtZemHDCP1LvgrEvftKso/RT8jqGHHiN6Wx
 Pi1A==
X-Gm-Message-State: AOAM531pffPKPSW3rKlUa5oV0ocp5AetEzMgKn/lVK49eljtIeXmnThK
 Fv3YJwXhlHBoEeApkndRWi8=
X-Google-Smtp-Source: ABdhPJy0M8t2Xn9kzo63YCuvyjm7/Wsm4KCNhHGIdARjx5EybHvTcPzx77qgihbvHWRSCv5y8pSdwA==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr42600021wrv.343.1634647499016; 
 Tue, 19 Oct 2021 05:44:59 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id a63sm2121659wmd.34.2021.10.19.05.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 05:44:58 -0700 (PDT)
Subject: Re: [PATCH 6/7] nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work
 API
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-7-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <56d9d289-53ee-75c4-37ee-c37d630fd226@grimberg.me>
Date: Tue, 19 Oct 2021 15:44:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-7-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_054501_940435_9179417A 
X-CRM114-Status: GOOD (  10.59  )
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


>   static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
> @@ -2435,6 +2416,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
>   	.get_address			= nvmf_get_address,
>   	.teardown_ctrl_io_queues	= _nvme_tcp_teardown_io_queues,
>   	.teardown_ctrl_admin_queue	= _nvme_tcp_teardown_admin_queue,
> +	.setup_ctrl			= _nvme_tcp_setup_ctrl,

This asymmetry is not great, what made you choose to go this way?

