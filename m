Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597F6C47258
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 02:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2srdy/gEkxZEQX8yqvPWjPa+KiI9RaTtwGAFirYHPc=; b=3GivmI9L9OIk2l5xZmWk8NzOws
	hCtAp4QWtAY8KKSBn55lNDNwZFL68nu5I8n91CTu5ffVvo0RzYpzI/455t1KvIONY/8V/MoZb7x3P
	Drk86fem3CGeYeajkko3PIHS/8VPkyr9D8++mlHD+dvp6l4VGR4/e78TSDdrkr2khelHdmi5I6TWI
	8HQUS+9375q2+BNacYes064ei9NuRwPIwpRQpcXYhnSfo49zv7m35PJkSTSwtYAfR8ccgTosBkTZA
	b7f4b8tz087ePgo403YzbBjGxb/yVbpOt5AXwYK9gxyAeRnDdzuZ8p9GX6A9buDDC7hkFL6BI1A0G
	/RcP/3dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUHs6-0000000B4Wz-2bBX;
	Mon, 29 Jan 2024 02:59:42 +0000
Received: from mail-pl1-f173.google.com ([209.85.214.173])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUHs2-0000000B4V8-3jrM
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 02:59:40 +0000
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7393de183so8666725ad.3
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jan 2024 18:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497174; x=1707101974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2srdy/gEkxZEQX8yqvPWjPa+KiI9RaTtwGAFirYHPc=;
        b=NGV3rFVlgpwFGbEXSMKjjo2+KM9pve2T3jEszVfpulmEEXs00obPBeVFBbf37kSEKQ
         yD6pBFPFKM8J/WEVaF4FvcWt1faGLw+G0yy+bE79n1cI/1kXIpl/g4Honr/hTPmFgvmR
         pc51quERr+zQrvQf0MyMMkxKPqJd8SI1bUnwVv4rA+57lpg6Jky7C7xNs/V5K6eO7nz4
         Bd0dGcQx8L6oNFLxKwz8gWP7U3GPIau/T8AHsrw+cIqTethv4uw4rrw+R8Zp+HExBt6z
         im86T6nyznt9PnjXWCwcRF5+Qz9PHDDMU2kbDVFCsGLLxBpePKiAiqxdTGscU1eCEJ1q
         5b/w==
X-Gm-Message-State: AOJu0Yw30mB22NPDE427PBci46kFJJXmZGAsqDo1H4zeFMjUiLE3hb71
	x3hnPMxG1Gk8fra73dOMKk1oa7XMSXIXNQ8XaeH026WagdqvbEXc
X-Google-Smtp-Source: AGHT+IHLzWKpOpr3cILvZHyHMjuA82VdDmKya3ofyHQ2fh7NkcXPc/ZbcxRl9w9fzz4kk68FVx7Wdw==
X-Received: by 2002:a17:903:246:b0:1d7:147d:6a1d with SMTP id j6-20020a170903024600b001d7147d6a1dmr2077904plh.55.1706497174501;
        Sun, 28 Jan 2024 18:59:34 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902708200b001d89ed2d651sm4239317plk.102.2024.01.28.18.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 18:59:34 -0800 (PST)
Message-ID: <df263948-07e0-4aab-a645-ea401d4d413b@acm.org>
Date: Sun, 28 Jan 2024 18:59:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] block: refactor disk_update_readahead
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
 Hannes Reinecke <hare@suse.de>
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-3-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240128165813.3213508-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_185939_009380_20DD5235 
X-CRM114-Status: GOOD (  10.12  )
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

On 1/28/24 08:58, Christoph Hellwig wrote:
> +static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
> +		struct queue_limits *lim)
> +{
> +	/*
> +	 * For read-ahead of large files to be effective, we need to read ahead
> +	 * at least twice the optimal I/O size.
> +	 */
> +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> +	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
> +}

Would this be a good opportunity to change (PAGE_SHIFT - 9) into PAGE_SECTORS_SHIFT?

Thanks,

Bart.

