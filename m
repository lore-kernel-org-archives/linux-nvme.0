Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB10DC369D1
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Apr 2025 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DH1vZkh6xRhbdUSgnCaUZdufTK3tqLDhrfKDi4j4iKE=; b=wOc5QHYKw4BZoSxgVcLm3FdhXK
	6seT2tP9kjUUGjHn549qdSJFnkVXXzdPSqICGiksJQ4I4o2iq2V9pnSpkw7KpjKwjrJyn+BwGG97C
	4hQ8kB6cwPoTmlFDPi8FxodTEFZ9ROICLEwbJWZ4livjROOlKxbW6o4LhPI7MOdYvqGv88bMdXgtq
	Bzq3priKVnUGvz4o5bBwPeeJY2RFHtfcnSMtHrsJZKjF8O1KVOXlPsisK0VolstePFTYdohUTjJrm
	6MWyjPdcy2lvkWLkYBW8LhRYMkHnEdLcEnqyQ9kvQThfrh2YbRV+4e2qUE7QvvyGOJfHZ8j1w1I87
	6SuqEJ4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u94PW-00000003khl-1KK0;
	Sun, 27 Apr 2025 15:59:18 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u94PU-00000003khN-0fRK
	for linux-nvme@lists.infradead.org;
	Sun, 27 Apr 2025 15:59:17 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso3420196a91.0
        for <linux-nvme@lists.infradead.org>; Sun, 27 Apr 2025 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745769555; x=1746374355; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH1vZkh6xRhbdUSgnCaUZdufTK3tqLDhrfKDi4j4iKE=;
        b=O8Ovcm13Gccywu9k9ACT8Yl56C669cBXejlH5+jY5QoJbYVkDcLXuKApFs+okhUU2h
         KzTc8uwREhKHw041Pif0xO7Oerc0Nz+NYkq1mBJlP1LeXtqlqyiOLrPThVcLi5OUML67
         D6Btb599dImQZOuwwXgnTRNcg1+/BJFZXtI/5jkqqLfjKQhOsXVt9zzZ4I8dejJL2nbv
         PFhPouJ5rOITgjrtmWovfYVEJr/QMK1/XtCuuI8yrChT9UoT91whb07+TUA+03/oZaoW
         FwX8AhvL/8U9TXdUeVhpuYHT2j3+QplNRqMM0IFS+DvgMStJga07ru9rQU9E5RNv29Jl
         ygwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745769555; x=1746374355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH1vZkh6xRhbdUSgnCaUZdufTK3tqLDhrfKDi4j4iKE=;
        b=plOoM8+STGfjskTo71iCM0gAlkv3kF0SY1rnTek6LmcUvbkdwbSmZdaF/+T4hvkQ92
         AceW84+dgrS91dt9QJ0nd4rCOMFtcAip5mCnm4Uu5oYJ7Y5jygSuJETT5IepL1HOFvvT
         L7ZUKLuMZwi+hmOHQt2Ana6q0FsAEFpiY8h3+0X54E8/PgYkQmKbQs3Y0+XBDn4fK2Iw
         DgwwMmcDNMfFGP/hLSRxzqXlmdHLwuvW+WGvlwyqFCnfwQRLjAlY5+++t5yTH845dWJt
         Um/gZKzn+ugmhfeSlv9RtgszuY7xbsKyQF+C5O4vW1Wk7XYGHoUA/wP59kt+3P3JviZ7
         Ys5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgyLON2M1lO3Ne99NkVpekS9XgRIMsb1U02kBmTw81R4QmOI6SPZY0Df5mwqh2d1VBxqmgld4HxqJz@lists.infradead.org
X-Gm-Message-State: AOJu0YwZSXkveu/MRdoS51pVpQ6qz4OexbrAlRHRB6XmzWqeCGnSy9mk
	3RvF5mkL+6yhcTs8DaE8cKUOa2B8OTKgFCbFDk13J2718N0BKUeF
X-Gm-Gg: ASbGncu6w0UK06QE4q6awO8ZH5ArVyhdYmhzv1FNxpWpvPtMeKVOb6M4FUlGNlN54DV
	Uay6arnSVaCs28PZ9e51Juh8/U265iSnhfPxuizVZZ4eTXn1EH8bgHt2aQaCmHD5+IZXOowAv2g
	xo1LK3RtIOZwFxKkUJEmQOCY1WXh2BB7hQ4yrTRW2gvrrX1FLY2zeb+2W+QNkMbwcMVWYfCRWVw
	Z/trvtQY8zFkEi+AWfLmje5wvRoQI5HAMhotQHgqSMubbRU0Sjc2SUZcyYZuZUSp4ldYB5Q3AfT
	Vc3SvPLW8H/pjScIGz2gwU6ovTODwShYld9p6FJcTjShs9uPuqH/nR7lX//hldO7
X-Google-Smtp-Source: AGHT+IE9zOdl17OfDh4A8izSVWLMKXuXlxIDZDZ7y/Y83J88TIMezz6KrQolIWFLf2m6u6ZNTG8gpw==
X-Received: by 2002:a17:90a:da8e:b0:301:1c29:a1d9 with SMTP id 98e67ed59e1d1-309f7dde9efmr12582303a91.21.1745769554650;
        Sun, 27 Apr 2025 08:59:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef0619d8sm7049585a91.14.2025.04.27.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 08:59:14 -0700 (PDT)
Date: Sun, 27 Apr 2025 08:59:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
Message-ID: <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_085916_196793_C29DB83A 
X-CRM114-Status: GOOD (  21.18  )
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

Hi,

On Fri, Feb 14, 2025 at 09:02:03AM +0100, Daniel Wagner wrote:
> The fabric transports and also the PCI transport are not entering the
> LIVE state from NEW or RESETTING. This makes the state machine more
> restrictive and allows to catch not supported state transitions, e.g.
> directly switching from RESETTING to LIVE.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

nvme_handle_aen_notice(), when handling NVME_AER_NOTICE_FW_ACT_STARTING,
sets the state to RESETTING and and triggers a worker. This worker
waits for firmware activation to complete and then tries to set the
state back to LIVE. This step now fails.

Possibly the handling of NVME_AER_NOTICE_FW_ACT_STARTING needs to be
improved. However, leaving the NVME in RESETTING state after an
NVME_AER_NOTICE_FW_ACT_STARTING event is worse.

I think this patch should be reverted at least for the time being until
the handling of NVME_AER_NOTICE_FW_ACT_STARTING no longer relies on a
direct state change from RESETTING to LIVE.

Please correct me if my analysis is wrong.

Thanks,
Guenter

> ---
>  drivers/nvme/host/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 818d4e49aab51c388af9a48bf9d466fea9cef51b..f028913e2e622ee348e88879c6e6b7e8f8a1cc82 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -564,8 +564,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  	switch (new_state) {
>  	case NVME_CTRL_LIVE:
>  		switch (old_state) {
> -		case NVME_CTRL_NEW:
> -		case NVME_CTRL_RESETTING:
>  		case NVME_CTRL_CONNECTING:
>  			changed = true;
>  			fallthrough;
> 
> -- 
> 2.48.1
> 

