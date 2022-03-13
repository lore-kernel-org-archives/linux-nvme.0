Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0605C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GhvMlaLXIBl69d2e2I1DBwNJZfAkADFlzhCg7cXuE7k=; b=GXtE1prjWmgKe3xXvEjmbqRB+8
	x7hIp7ERIHAygNuHrtyJ053bbG6r5DC879x4nbXKYHSgFicLGooK5wkHKZxEVI0L9nTf+6dR86APC
	4QsgWb09qo+FqeBKM37RvzcqZMXLh+HOeMWwj+TQglkGqF52CAEbbVKlcLY0Nezb0cVjiJueY4xxh
	xauvtn5/Rh5d8dB0B3ejf7X+75xExFdnzWcq0K/6yAPsVwmXJJIECDGu+rxloAbHEzY0KYMeaibwF
	2DtYzkP+WoFFaCZvEnEnTtLtzAMM6Q9i4O+OHfyu5i4A+nNviGWF/XJOpCBAYyi2MyRQkuUTy1X7N
	WGrWGutA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTW9o-003Qy8-58; Sun, 13 Mar 2022 21:53:44 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTW9l-003QxZ-C5
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 21:53:42 +0000
Received: by mail-ej1-f52.google.com with SMTP id dr20so29836447ejc.6
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 14:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=GhvMlaLXIBl69d2e2I1DBwNJZfAkADFlzhCg7cXuE7k=;
 b=D/LNhGovfoBYbhZAA7eN2yypKqnNF5s+1BoWro+yFVHSLk1XDnHFQJBDtE2ZU2Hby4
 liwH7gJvtNxT5rExMe4vf9B81Sl7ITBhgDlGJqUpkhd2M0YAZGqTIvhcGEJTLq9QUPuG
 0dW7yTRv8rOSo49Qbo1v9an/7xc2NVKnstQcs3OT0A+1KgssB9ZcgtAAiO2uIsh4omCZ
 G0XQRF45uMweUZxxri9qcgS6UvPZjLiZ6qFGb1eVO0fzHr5cETAYqgtl3qqzrF9AX5xQ
 GC7p1RvVreGaQWqv/p5XeD7TrPiXxaiIYj+qd8nyuN/gYO6JDf/mv6fuYxLJ6rUvOWsR
 9rZw==
X-Gm-Message-State: AOAM530zuNQhXfgm+YxMC5GOknPlyNyJZbvBbBHsXPWu1iIIQh60Tluj
 Zukf86HRNlulgLESLbX4jMY=
X-Google-Smtp-Source: ABdhPJxed+q6AT46dUxx+14XZWsrYC4Q4t/biXHM77QpXqFMCGdDrmRX1buo2MOHsW3KyPhpW3Z1qQ==
X-Received: by 2002:a17:906:2695:b0:6cf:e1b4:118b with SMTP id
 t21-20020a170906269500b006cfe1b4118bmr16156282ejc.348.1647208419888; 
 Sun, 13 Mar 2022 14:53:39 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119]) by smtp.gmail.com with ESMTPSA id
 q16-20020a170906145000b006bdaf981589sm5997845ejc.81.2022.03.13.14.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 14:53:39 -0700 (PDT)
Message-ID: <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
Date: Sun, 13 Mar 2022 23:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 pankydev8@gmail.com, javier@javigon.com, mcgrof@kernel.org,
 a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220308152105.309618-6-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_145341_450494_80A70573 
X-CRM114-Status: UNSURE (   9.47  )
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


> +int nvme_ns_head_chr_async_cmd(struct io_uring_cmd *ioucmd)
> +{
> +	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
> +	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
> +	int srcu_idx = srcu_read_lock(&head->srcu);
> +	struct nvme_ns *ns = nvme_find_path(head);
> +	int ret = -EWOULDBLOCK;
> +
> +	if (ns)
> +		ret = nvme_ns_async_ioctl(ns, ioucmd);
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +	return ret;
> +}

No one cares that this has no multipathing capabilities what-so-ever?
despite being issued on the mpath device node?

I know we are not doing multipathing for userspace today, but this
feels like an alternative I/O interface for nvme, seems a bit cripled
with zero multipathing capabilities...

