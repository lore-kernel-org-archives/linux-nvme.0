Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF4DC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAtZ/cLbKc8KrW9U/GX6Jr7XKhavaISbuyhZEe+m+eE=; b=VphdmxQkAVbvE1n01Zojean21K
	97igczcXYp+WA/6Ra01Ct2xdI8Z6vBZinZUUUjOF+50vnadcXVQzfr9Ai2+dJq8AcTz/VtY3ari0A
	nsuQIehz14HmuNzuesf/o9rBVaMc6rzIhyN0PZnU9gnVmPso59LSJql5d3IrcYPTxFqQMNh47P+rQ
	+7TcRkzWGbbdhS8JwL8M32Eg7whhPWn5NqxJqm+Alp5wcdjFU0e2M2orStm7TRthbRZpnATw+QW/w
	8ifx5J8AwSjJulKXhFLBrJ0iZs3uNI+GW9KuCOYJ3tV10vzolM2+Mgar3bODoN1TrzM/apiH3eF4S
	bWi3tU9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKbhG-007Y85-29;
	Tue, 02 Jan 2024 10:08:30 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKbhA-007Y78-1d
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 10:08:26 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50e766937ddso7164224e87.3
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jan 2024 02:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704190101; x=1704794901; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eAtZ/cLbKc8KrW9U/GX6Jr7XKhavaISbuyhZEe+m+eE=;
        b=Vt0/AV2F5wM0uit90DgcBl1vKGalIkGtHl99n64dXbucgGIKyuAlT59n/N0GUmfx2E
         p0xgq4imraKDWYj/l0KaMdsiozxdv2bTiiNn9NcY5xcAcH2vag4xp2FjHjyI7AaTrnRX
         pXH4XaUuPzzmTAG//xvT2x/jJHfOnz0yue8SKjgZ+LtgXWms11ZLmBtIbcAJ1vvG7jRb
         kq8mAKtzQNmaua0zPbDgGt5HXt81kmLOF+Jn4Pwl5sk/6QVNOShVDiFYGqVm2nPjLbls
         N3oQvTnSwuvmbuihtnCvVFCuiNklMoeZ5Ad+7XqmRpgsUaPKRjQdE1mBnAZB8Ft/c30X
         syOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704190101; x=1704794901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAtZ/cLbKc8KrW9U/GX6Jr7XKhavaISbuyhZEe+m+eE=;
        b=EJ2nwSMhEx2PZ9RWdxa+IIV7xJN1s+VsumK90Ay3sE0Y8W05lsbNIz82IaMPdO/3HM
         qVf84cIGg7JdP7jJc0ZSPcLQ/T5hgydqxIWcElmZJeL+kPmpax1NMeljkoz+rPQqa5kP
         hyyqVo58ckc1zlOzyNIZIDZyo5Qy6vIh+UgS/Eu0fawGrZiuiWkn5tCXiI6XrAbxhZCW
         6ANT/Wri5HZeOzJWDb7LrkLSKJ7q0B0oQa2qM5qRUSl83ptb42xBicaE1rBUQTTJIOw1
         J7D6B2PeXIpBcRfdmD0gBWCBxboYrbhz/2WLTuUN5nRNn3F1huc9t/0FHa7rXZgD/y+T
         z8fA==
X-Gm-Message-State: AOJu0YwnRpmeapNBnfgyKEku82uEFytrhLBd097rT4/3Hb9Tf6JX5qzh
	FKwyytdFwSDNUhAj1tUyU2lWX9jQ2pDE3g==
X-Google-Smtp-Source: AGHT+IE2mR6lqs7hEq/27M1sc6LtwTkvrnGtnYSFSdGG+/HIgINj2ipR2TYu6xVLxoJFnjeDuHETsg==
X-Received: by 2002:a05:6512:473:b0:50e:70b1:9544 with SMTP id x19-20020a056512047300b0050e70b19544mr5825234lfd.111.1704190100956;
        Tue, 02 Jan 2024 02:08:20 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000114f00b00337464bf71bsm1770277wrx.39.2024.01.02.02.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:08:20 -0800 (PST)
Date: Tue, 2 Jan 2024 11:08:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v22 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <ZZPgk3mrEkciwI_7@nanopsycho>
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-3-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221213358.105704-3-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_020824_563471_CEA0B32B 
X-CRM114-Status: UNSURE (   9.63  )
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

Thu, Dec 21, 2023 at 10:33:40PM CET, aaptel@nvidia.com wrote:
>Add a new netlink family to get/set ULP DDP capabilities on a network
>device and to retrieve statistics.
>
>The messages use the genetlink infrastructure and are specified in a
>YAML file which was used to generate some of the files in this commit:
>
>./tools/net/ynl/ynl-gen-c.py --mode kernel \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>    -o net/core/ulp_ddp_gen_nl.h
>./tools/net/ynl/ynl-gen-c.py --mode kernel \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
>    -o net/core/ulp_ddp_gen_nl.c
>./tools/net/ynl/ynl-gen-c.py --mode uapi \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>    > include/uapi/linux/ulp_ddp.h
>
>Signed-off-by: Shai Malin <smalin@nvidia.com>
>Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

