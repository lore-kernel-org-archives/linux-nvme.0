Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB2C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtcTSM6qICxFKRc6fIXVsjbZ9jLlwHtwIT1wcH3PWvo=; b=1VTf5e9miDMCHEVPwn8KoTnnsU
	1jdgLa9A+EqxztTmrmcTVvW1dyNy9wvb3zqOCWf7Mtnl4Qr6kYfWirZurR4nNGan5dZQrYgmJYh4n
	PI62vVa9HN5BASonqxyK7D2NmV1x7Zln6Bw4PxVPQwdWXnz822YcNl5wk2BzmmK8R7VXa7DUglF/G
	1NhCxTBdr+0NlplnTe5XVXViQQtdK0n8PuCBEv3+/X/O6Zm7OpD8xYiFK1G8lz9DSbbK2qZ22DLSo
	jExAsTNF+VyNxBOFP/58OSICNV30/a+cR15uT+6rRts7G/rDsmJB6tHSNcEPYGpIin8tset5dCOMx
	BwE6TQWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQuG-004Eqz-11;
	Thu, 21 Dec 2023 21:48:40 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQuC-004Eq6-1l
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 21:48:38 +0000
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7ba7d17184eso16480039f.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703195315; x=1703800115; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtcTSM6qICxFKRc6fIXVsjbZ9jLlwHtwIT1wcH3PWvo=;
        b=qFTH7BCkBSHOFLCA3jOd+Zt+JQQOZvdJM+EjMwnrAXv2vzYyKOTAab36Z4ROBGZv2h
         jwMIIbIi0W1xUvcfW7PwwIym4MrA/xZs3HDrwr5e5rXg91gb2nb5PUaudUQfrY9jbSet
         T9p9jBNCIk5SKwIKkW33uuultDkVYguOWWA9lN1sDAOVO4y02xraOVW5F/TPGQKi6ysI
         S6/TeXnwnblxpHxzQIdnJDJePNgf940ofpME58fE+4BAbZMSlFByqDrysGH1hpZnttvh
         MOxmfsaqH73ThmpzDL86WaYkVDxEMcg0fsndXio8UNPbRzNY4Ir51g3c1yR4CyRA6kZa
         bjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195315; x=1703800115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtcTSM6qICxFKRc6fIXVsjbZ9jLlwHtwIT1wcH3PWvo=;
        b=iuzql8YiLai4XeYNW/CaWI6ons1F7o9rheQZ3HbU8uxgRWMhNMZn+7QZtpUOotCf/s
         Qb5gFGwuyzALlLnlUTmbGxHKntQBxPdGLKyA00WiTEhQ2d7PvdtYom5WDvVy8PeK3Rlj
         5zUjemOnhGpbZKINCuhUzhpZa7hJzMUedznF31oCuBgcN/neghlXzuHW/mvfk5nxGo3E
         EC326AwL7yAjT0LC7BQQC4PvvpLqKfLeSUMOHfS4uZdnp/87xfv49q+3CZJwJXbfO1KD
         JZCydeKU233LjHPVCjRjhH2ujwo4howS5gm8EXNFj/gJ7jr9ydmj2ziRMW8C3Q3wWc5r
         mtAg==
X-Gm-Message-State: AOJu0YxvUEKmeVKKhXT5y8CuWPogvH9vYAECBVq2SS1Kq2R17mfwnk7v
	X88W2yFeduycyJOKsBWW7n9mBJjgjVp/wQ==
X-Google-Smtp-Source: AGHT+IGy4p7oTMbeTQOKqMh7bOUTrpaB+NWaJLvoESWTqBybF9SoppBt7BpW4IS1uBRx2lcgw9W99Q==
X-Received: by 2002:a05:6e02:1d13:b0:35f:da7a:3797 with SMTP id i19-20020a056e021d1300b0035fda7a3797mr631780ila.1.1703195315390;
        Thu, 21 Dec 2023 13:48:35 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 2-20020a056e020ca200b0035fa55f9f18sm744206ilg.37.2023.12.21.13.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 13:48:34 -0800 (PST)
Message-ID: <ec6130a0-8718-4522-b7c2-1b2a3ec0b7f3@kernel.dk>
Date: Thu, 21 Dec 2023 14:48:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.8
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@gimberg.me
References: <ZYSwqV6e_iTw8jgV@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZYSwqV6e_iTw8jgV@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_134836_603371_32C291B3 
X-CRM114-Status: GOOD (  11.74  )
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

On 12/21/23 2:39 PM, Keith Busch wrote:
> This is the first nvme pull request for the upcoming Linux 6.8 merge
> window. There is a minor merge conflict when merging into Linus' master
> branch, and I've provided a reference resolution here:
> 
>   https://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-6.8-merge
> 
> The following changes since commit 847c5bcdfb41704e52930783b028302f415a3209:
> 
>   block: skip QUEUE_FLAG_STATS and rq-qos for passthrough io (2023-12-01 18:29:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.8-2023-12-21
> 
> for you to fetch changes up to 5d51dc8db10190661232741c93a141bdfc05f5ee:
> 
>   nvme-fc: set numa_node after nvme_init_ctrl (2023-12-21 09:19:01 -0800)
> 
> ----------------------------------------------------------------
> nvme udpates for Linux 6.8
> 
>  - nvme fabrics spec updates (Guixin, Max)
>  - nvme target udpates (Guixin, Evan)
>  - nvme attribute refactoring (Daniel)
>  - nvme-fc numa fix (Keith)

Pulled (with typo fix in message), thanks!

-- 
Jens Axboe



