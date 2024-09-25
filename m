Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24012C369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVzPB9vrZln1C1cIggOtEXcmoRO8Od8qHNyK3KNRB0U=; b=iFTwaeB/3CzfNuq02aa74Md9dT
	on/xcONIaG3+AZkC8fsl0DN8/zJJrtL+9GXqILG5ljYyCjLYNTYMDjeNksHRgxo0Qif3UHTMWOHk/
	uoMkFTaL0vt1g7u99XXAcbl0K1nTlFd7q5HOzBw8ucK+1NsHZ7OaRkEaQupJzbyoJkU6WJRY2aaTs
	r/U8ZCei02Ft7s8oumEU1NWQ0a8w4Zl+fmcL4GS8+MnffRdqAKnQ+iyr120VnvDakt2x0zxLfymxE
	tsMgL4AbnLCPVz/dtnFHimZEPX0NPXnWvqVnsHC0AJBbGJxcjFbA8dr+RFtqj+68W/z4I4Po3K/rG
	nc6+aVAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stOLW-00000004cJq-070K;
	Wed, 25 Sep 2024 09:30:06 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stOLR-00000004cJD-26XU
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 09:30:03 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7acb0499ffeso613624685a.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Sep 2024 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727256600; x=1727861400; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVzPB9vrZln1C1cIggOtEXcmoRO8Od8qHNyK3KNRB0U=;
        b=MBgfhQAB7TRyKPRP7xeXcJ/DKs79eJQ1Me6HaQKVgKsqgMtmNZpukOdHLpiw+3GpFh
         rPbiju9umPw3oyGi7EjipSwyOJYegs8h6Fi4fc/jPAjxyZ2tCTuhcSZfw6X+vGXJMorJ
         nHqeAw5zr9N5jk2xoKqD81iGTtUm7oXa2S2honnyqnzP1lTv5rEkxaROXyh9rhXkejIU
         G8jtVAxPK5EChFfEvBHSf1MWbybhefnG4nw4UzBBi/AtkwAO05AChZRC18PSFnDut1Af
         ArA70BATge4DAxiDYank4/OHmcjBaTa8+w8vgh9usp/Zs3r7hwUulvhPzhiD98SWS0PZ
         YehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727256600; x=1727861400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVzPB9vrZln1C1cIggOtEXcmoRO8Od8qHNyK3KNRB0U=;
        b=hgRhwuGjx0Zu0eXJJHi0DbxJQu5Op6wrM95TX8PQx+75CPuiDDu8vDFYRGTkeGmwCP
         9LC/eO1+9C/xtBLlznQgPlHnLWHKNdpZqr6IhKI7lI99mBTHoYZCHP5Q3isUJ1lwys3m
         PRVWRbIx/Be7Hk7/1u2C26udG7SnlzEhhHAOduPvQcyplhWOWtJvULbozWr1Zt/ngJBX
         FwH2382ioO6wdo4xBcIgsW/lNHhVE7nA5NPjy1Fy2Xjb36DvigILBY9H/toczxvinKBu
         fZ1QXCt1ULcypU0BtnDa3o7B7u4d0VpdSBv3d9SCffhLLQyyN4xuv5mn92G57nQq/oa8
         Xa+w==
X-Forwarded-Encrypted: i=1; AJvYcCVIGMFNZ9b4y+YwFpAlft9pjGA8l7Z3MpUj/Ou8V7ik50N/K4VOcooM28D5cgkScwvzjJ4V9aTtrPJj@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3ueKimTC8oItg36dtN92/fu2pGdMBstysDhEm8Ks6Iuv2fYzI
	AG57MRIUN6m1GJ0OjItfagm8cTyvqjJt0/1LBUtc2iyEthByQXQoR/2aJND9Gps=
X-Google-Smtp-Source: AGHT+IGXEeDb4WlE6a99Ih56i5Jsu5iuKLY3XbfOpfyyDR64i+yB6VUIohPhAQ+ULRKAFZJwgH5Gsg==
X-Received: by 2002:a05:620a:424d:b0:7a9:c3da:a806 with SMTP id af79cd13be357-7ace74665b7mr252129485a.54.1727256599784;
        Wed, 25 Sep 2024 02:29:59 -0700 (PDT)
Received: from ?IPV6:2600:381:5a05:3d4c:39e:105b:6ca1:9d6a? ([2600:381:5a05:3d4c:39e:105b:6ca1:9d6a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde62b3a8sm153789285a.135.2024.09.25.02.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 02:29:58 -0700 (PDT)
Message-ID: <89e62f07-ad7a-4468-a519-b4f416a966fa@kernel.dk>
Date: Wed, 25 Sep 2024 03:29:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ZvOwViViFuQSeyVk@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZvOwViViFuQSeyVk@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_023001_842235_B7B816D3 
X-CRM114-Status: GOOD (  10.68  )
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

On 9/25/24 12:40 AM, Keith Busch wrote:
> The following changes since commit 65f666c6203600053478ce8e34a1db269a8701c9:
> 
>   lib/sbitmap: define swap_lock as raw_spinlock_t (2024-09-20 00:20:06 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.12-2024-09-25
> 
> for you to fetch changes up to 9064610348b16356d43e59e286aedfec31825541:
> 
>   nvme: remove CC register read-back during enabling (2024-09-24 23:35:10 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.12
> 
>  - Multipath fixes (Hannes)
>  - Sysfs attribute list NULL terminate fix (Shin'ichiro)
>  - Remove problematic read-back (Keith)

Pulled, thanks.

-- 
Jens Axboe


