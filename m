Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648C2C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oe7KBssScEPSTtmYXJLb1keNsAXElNllDenRchEZULg=; b=ljtZcBApsqi8mXYDwjaXH+3xzk
	u1J100uFZn8JHHhpw4Ng7Jxv2Ojlw8O8sYaQE1JsRc4aesXWAZDvcepvIlT115o74vHQt5cHX/jeI
	QIoRH78oTKiqMg6tDPhbk2SzkbjGHNbTqHDuB/EfZBFpWC8BJjOq3EkNCA+WtgB86FePwhVFt5jJk
	zpvncdJz3jFddKtiPZeqdctN9ieelQOuBXq6LlWFuG+FM9R9GOrgwq0XG1Rl8tNXthTAbjpy10b5c
	pgFt8s8CMbVq2n5xeVbMNaT/Ri+lDYfgrsUce0HH59fBPGKyjfTxOy9ivkw7TdgxHCmHoWmedLPp0
	4vFqWZ6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp55e-00FPIc-SS; Mon, 22 Nov 2021 08:54:18 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp510-00FM4s-Jn
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:49:32 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 r9-20020a7bc089000000b00332f4abf43fso11627199wmh.0
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Oe7KBssScEPSTtmYXJLb1keNsAXElNllDenRchEZULg=;
 b=C0mBDSQqkGEaIhop2+ixxOJoulsxFjyutoKcZ/GL4hyRzhTanTghug+jLa84rn1TOf
 iuvi35m3NyG4poDmNYaTw8NkChGRQHHdDu5i6Wdv/qBuCvxc7PH4a218Z3HY4iu0HheB
 8+MmPqoQZTzApBWDGyYQaqtSTgeCLyNeHu/uqrC+iekJu2PQ6kGLLUBjihKkNagJKLP9
 IjiEQM3pZDIhxJSf1IJZWTp+txDajDUCtg7SeYD0lF3ql8xF6j80mNYpLW7HhOyB5Glt
 IrOSq+cp1xxqv4pfOPFXC4ClnnhdNbdWs310oM22Tmex7agPVXjJZbiThfYedCM0sHRk
 /now==
X-Gm-Message-State: AOAM533rrRoFeZpRA3rI/XngKqrW+OLoCO25jYJXVO59ZxVJYGgbMu3b
 SZQsdFBL0G8sDzyrrAcJKvPI0uHgzKg=
X-Google-Smtp-Source: ABdhPJw0H/BVXSPg1TkBrAU5mMbjrRL8FrBqr5KQEDZvK7Ef/U3OFpUT8w1qDrGaEdUMZB0Wgj/7QQ==
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr27608896wmi.178.1637570968473; 
 Mon, 22 Nov 2021 00:49:28 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m14sm10734552wrp.28.2021.11.22.00.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:49:28 -0800 (PST)
Subject: Re: [PATCH 1/9] nvme/rc: do not print error message when no nvme
 device is found
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8a895a42-56e1-c695-babb-86ba6b8487be@grimberg.me>
Date: Mon, 22 Nov 2021 10:49:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122075524.26207-2-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_004930_714891_2DACCF1C 
X-CRM114-Status: GOOD (  18.17  )
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


> _find_nvme_dev() will only print an nvme device node if one is found,
> so no point in printing an error message.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   tests/nvme/rc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1c27cde..086c094 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -306,6 +306,7 @@ _find_nvme_dev() {
>   	local subsysnqn
>   	local dev
>   	for dev in /sys/class/nvme/nvme*; do
> +		[ -e "$dev" ] || continue
>   		dev="$(basename "$dev")"
>   		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
>   		if [[ "$subsysnqn" == "$subsys" ]]; then
> 

OK,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

