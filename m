Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A33E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=S5yxjE9LYPAeo2fCX4NGvE6hiM
	XnWRNGt5uXrErzhGHpbRqNxKLBZ82s7REVFDuvT/pixmZRrhNElGYWAGPsPVzgq/EYxIn9nLsxoAM
	yxXoMHnMglkNTREN5eqykGXdGXDJIW0yEJd4+W/zywNklw+WPGVdbmS6kB4K7um9hsnGT1pyRAC7b
	1WkG3kISU/xNaM15TVmYHXkOQMKNwY2EfimvCCLAqoDkDFhqRbenhWD7LxLx5DoUuHOO8AAJ+WRkk
	GjfXSjmD/7JrkATB5APa3yio9jB0j8zue27DmQVaSCRgeQZ4twJhDmpAf8YA57cjA/MtYo74CrYgn
	o4qg7o0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3TK-0000000Bton-1JHM;
	Tue, 24 Dec 2024 11:53:10 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3TI-0000000BtoN-171Z
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:53:09 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43623f0c574so34357525e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735041186; x=1735645986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=sUDtDl+f8EPmIWkTjaptkE3vVExp0+8sPMnjqnIQJICVdXIiFIb2N/oNxL7LQ62FeL
         8upbAeiT22evV9ReOGZRUWMfOMrnP3EjpRSLk9UEYF4YVk4bBJ8MvobXSnM8Vvd7/giu
         UDdENhnU0gqRMsZ2/2J5T5HbTYlG8pihi2xE+t8G9T3fxR8Y7wZcijHlDpS8x3KYpY2P
         xfd5gg03RQf+8fMFbIkRBB2m9xRAm1pbljbUrzW1VggdtX6YZHmQ5LPYkYc61vCKOPXC
         w3dUzSNavJR7SmlkbYOSN070In6bVhyK+hvqNsIZxxu0yoRtoIoGat2EUVoGnYP55sgE
         nz4w==
X-Gm-Message-State: AOJu0YwDMPETOMOrGcf2PQQLdGDm1JNRY59uZxbMFzFsHfkcahPUH7LF
	Sh6N5TvPsjIH8OPNN8Mznw6WmqaCvyICWXzS1vG7WRF46MFtshMQ0ubs+w==
X-Gm-Gg: ASbGncukTj3r/lP4dOyJckgPhR07IProCejtYiMIIwGa0nEogdKmdzwzEcy/86s4Od7
	ICqFPfCHgPGQSeBzYOB3jSeErgw4dvs4V416VhIZ5mpF1MKuCeM8VFAn+qYTLFA9JUL7ZN2zibe
	gPJoAQhaauk2bcAsPyQ5hyoRB8PsCjzwiZki6LLsq+bSwGt44m+Wp5bpiZKSimCoKdEfKoDXPtU
	14+zI+bQdPx5X3XAyzIsfeQF/dR34MhoQ7sNztwTXKtO19riXlqOcgewsWHArdZrWIw/2RVc//K
	gUkYFLxu/5nJ5yKcCrPqXj0=
X-Google-Smtp-Source: AGHT+IFaCnNsuZPkl7hX6drB2iJ/qfdUxB/9LZHDNxWlntUQopZpf5XNvbg0xPa6dHLAM30h33RsuQ==
X-Received: by 2002:a05:6000:4a0a:b0:385:ef39:6ce9 with SMTP id ffacd0b85a97d-38a221f1716mr16260697f8f.21.1735041186330;
        Tue, 24 Dec 2024 03:53:06 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474c2sm13772782f8f.55.2024.12.24.03.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:53:05 -0800 (PST)
Message-ID: <68ad1576-dadf-4ed5-a3d5-2c93ba01243e@grimberg.me>
Date: Tue, 24 Dec 2024 13:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmetcli: fix double ana groupid when save config
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20241029034312.15083-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241029034312.15083-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_035308_301857_02D97D3A 
X-CRM114-Status: UNSURE (   4.27  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

