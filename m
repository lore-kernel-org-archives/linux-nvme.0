Return-Path: <SRS0=enG1=OI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5BBC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Sep 2021 00:04:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB65C61164
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Sep 2021 00:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB65C61164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3TQRkA8V18AJuX37o28qgzDiJu7gs3BfRQGfix+luk0=; b=pFzlalMsWDFY0y
	zqiO6pofKLNlW6YXtP4P62oUGwzF1Zx8jcchfx5Mvv0IrEBt0YTqHlagYoP8svGJozFlN+x2/89vD
	L+1SmCDM8fbT6O8K9YhkEnFN4HgzbGFNJOReejjC+bKQzZ0mlqTFdBB41BHgNiM9mfulep7Yhq/ke
	33vKDHGDfhlZYsUUsddqGIJD9DxwY7/0rZPdNYEjsRtOQ73r2tfWE3pEFHtF4IpQAaVgwqEQKkYKA
	DDRBA/Biat8bdun1Tnvsu370NTZJ5m60nsKsQeXK+A9FiQiF2PE7YrRyRwckXhkus84vJkuGe7Clq
	ArkJZuuCeQRETZMGx+ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mRNpt-00FBxc-F7; Sat, 18 Sep 2021 00:04:05 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mRNpW-00FBww-Ig
 for linux-nvme@lists.infradead.org; Sat, 18 Sep 2021 00:03:43 +0000
Received: by mail-pl1-x62b.google.com with SMTP id 5so7222043plo.5
 for <linux-nvme@lists.infradead.org>; Fri, 17 Sep 2021 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R6i+W+EoLU/2rBj4+e2SaLzuquW8bdEJaHFtJMdW89k=;
 b=wfwTHnZzjxucMcdequzdsZjnx/UqchPJLWWfJj6UqG8wdXEu2lb+ZG/1HyQ5pKcutR
 gb4faFtIQ0PMMqooTfEFwz7MQMPwEzhLqyiciHnzax33AoHC+bG8eOP3c0ALPWBu+8zY
 zKNY7Hze+trGsmtL99aBggItwUzPyTHtOV5I+ANA+CbmVKqFyZk9fsvzDVwGHIU2VfZp
 d9RbiMzrk9HbXqx0RwiLxQ4M5vSkmQUeDOnH2MX9PNetJLkQ6/FW+UCFgx4eYQObd/pa
 wzz0/xbjaOoOOL+0lPbtanwRC8ii/SB1VHA9m4FY3nfPwpWszRx7ZQY++DZdzHjhvYE+
 wFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R6i+W+EoLU/2rBj4+e2SaLzuquW8bdEJaHFtJMdW89k=;
 b=p02ZoElRVFUBEtBQwIHD/kCIcy++VpaZliLSTVgyNXL6SZcCgKR5jFuUhlACZWVh+F
 w8E7nKKlU/GCk2dga5AofBXW0uNG+fuaiQinbjejijS4emzW95+IKW6orB4tdpTStPhI
 SvkGezfSpuDc/JJsoF/9cAtn51jN7l1gY6KdkSxiiS6blyMeMD7TIRRmu0HjVw3vasCV
 +M5d8IS7sLLfYFg4XfryhlI9CnC2TSR8vyLlU2bf+Cr/lb5Rv30BkREEacJLB9oZc5D0
 hh9j6ZJcvUz8wbRRyLDbw3SqyZHJu1p2jJSiCWAFmUikKnut8JGw4tagYWzS4dGVSsiy
 Duwg==
X-Gm-Message-State: AOAM531aA7JKcQ1tcWkStLOEPJzvhtFo7XKjsZZlLajDwC6hkdPv1MZW
 apyoP6At3TA2H5V8iiZpbQdkGg==
X-Google-Smtp-Source: ABdhPJzuO9f5UV07Uw7hq7nNmmJKa9n5B68Atjf4cKrrA0zH+s70Sr4+FZWOFjYeasnHCJGGeZI9Dw==
X-Received: by 2002:a17:90a:db95:: with SMTP id
 h21mr15328732pjv.11.1631923419420; 
 Fri, 17 Sep 2021 17:03:39 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::8b71])
 by smtp.gmail.com with ESMTPSA id u24sm7683618pfm.27.2021.09.17.17.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Sep 2021 17:03:38 -0700 (PDT)
Date: Fri, 17 Sep 2021 17:03:38 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: bvanassche@acm.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 blktests] nvmeof-mp/001: fix failure when
 CONFIG_NVME_HWMON enabled
Message-ID: <YUUs2i4RGjUpH2tJ@relinquished.localdomain>
References: <20210917030911.25646-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210917030911.25646-1-yi.zhang@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210917_170342_683924_0DFA697C 
X-CRM114-Status: GOOD (  11.41  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 17, 2021 at 11:09:11AM +0800, Yi Zhang wrote:
> skip checking ng0n1/hwmon5 in count_devices
> 
> $ use_siw=1  ./check nvmeof-mp/001
> nvmeof-mp/001 (Log in and log out)                           [failed]
>     runtime  3.695s  ...  4.002s
>     --- tests/nvmeof-mp/001.out	2021-09-12 05:35:17.866892187 -0400
>     +++ /root/blktests/results/nodev/nvmeof-mp/001.out.bad	2021-09-12 06:49:25.621880616 -0400
>     @@ -1,3 +1,3 @@
>      Configured NVMe target driver
>     -count_devices(): 1 <> 1
>     +count_devices(): 3 <> 1
>      Passed
> $ ls -l /sys/class/nvme-fabrics/ctl/*/*/device
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/hwmon5/device -> ../../nvme0
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/ng0n1/device -> ../../nvme0
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/nvme0n1/device -> ../../nvme0
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
> V2: update regex to hwmon[0-9]+|ng[0-9]+n[0-9]+
> 
> ---
>  tests/nvmeof-mp/001 | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
