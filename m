Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C6CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 19:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dOtZo3cRckA5ert9S3WU3eYhNXvQg14EN+002Snt29k=; b=jpx/up4sqLH8z73iSknvu6To+Y
	wQZ+AbyDV9Q3j9pR9azrVZqoJHNgkK6qfkHYPvBZ4bkOuCF6olIX7Vz4k2wVI0OYmavnIkdGd6CfX
	orxY47BdIT3uMtmvARHN9RTckIHU7yXBWnpLJJ/xRFXl8qu8Onvresii0AFLhm4UknFz9UW8uWhS+
	UGSDUNO04/2WdKTKkkg/MNyArtV3KC2XurgfGOq6wwDqo8i5WmuKnvcP7FjvyOHVA9xBhvDwbGB2z
	W4BO7LeXfHnAOF7tzEJ8pSZDX9cj2MGxrNu03ItL1J5YsNXe0F6yScfpGhzDVYkbuSF29dW8utlnv
	CGTxUM0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAyDj-0013lY-3L; Thu, 29 Dec 2022 19:05:39 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAxhT-000ouk-3I
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 18:32:21 +0000
Received: by mail-pj1-x1030.google.com with SMTP id o2so14475964pjh.4
        for <linux-nvme@lists.infradead.org>; Thu, 29 Dec 2022 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOtZo3cRckA5ert9S3WU3eYhNXvQg14EN+002Snt29k=;
        b=mM/aGzUK2kNINF/aB272yG+USJf/zMKQmlzlkFNiBXa88iHjxQu30PR90FTIG+CAuC
         tJ4WOe/MsoraoJeNAa7NZPFFL8ZTEyJzT+6+eGMdQMtl9YndKaffp6hdg4kXfU82JMLX
         5JRQx+xOJMMTCIoHQSuNr4KB0uSQTgEF5muBvh+kTdF+cxYUb0P1BSC44Hw4i0gOFYze
         xZ/e6Q4vBE+fSLa0p45SJQnLBjuMTk+MZ2YQaYs//SWqFrG/rjXHNwW3RtUvuVMYk7Gn
         EZRp799GIVuTBdIUtkzRVWDra81ywcXBLfYz5GeGzZ+mfZRTkliW/Ynr/qohG9wvnfCj
         Te6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOtZo3cRckA5ert9S3WU3eYhNXvQg14EN+002Snt29k=;
        b=IxGWMZ0G1YKjFgnm9HlVNbBNNHYLgDGet0HUbKAf7D8zSwxizPMFta0MA+EecNHhQH
         VpDATglFO+rNSzLZn79XUnsHAJBp4Szye24WdPx3uieCAP2BD2luCK8o1ABx2n/M23r+
         kFB6Ijwj0LmkBIsviwU5Uq0QYwiPae2hfYWnWpIt1+OWgmNPF8muAxCMG7xNxmqbUpEz
         AgCBuVL0Gnp8QqDe9S5YRVdc17vdub35oP4NUhmGmxozXkyPli6aC/u7oaZsXeIj3EU9
         kPZtvWtzQoie821RqhSGEPL6r3ODbIsW2dgjVmcKEwUSm0taIK5ykPhMRZchn7IWvPKH
         V7Pg==
X-Gm-Message-State: AFqh2krmdveyB4sdNnoZmK9NbjwMLavnXjGQAw/xNt/hOj9++XKr50MG
	M0pyHvxB9MAiH+DqGoj55LEQpQ==
X-Google-Smtp-Source: AMrXdXsoHhmT0sjvBoNt7ieYjwYjsnxvgOpg1USM8tNdxy1z0QVtj2tCka45C/h0B8NxmV5lKokvLQ==
X-Received: by 2002:a05:6a20:a587:b0:a7:c027:f84a with SMTP id bc7-20020a056a20a58700b000a7c027f84amr9599886pzb.1.1672338735083;
        Thu, 29 Dec 2022 10:32:15 -0800 (PST)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e21-20020a63ee15000000b00478c48cf73csm11136937pgi.82.2022.12.29.10.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 10:32:14 -0800 (PST)
Message-ID: <e6f210dd-3a67-698c-6f56-b127ca1ea0ec@kernel.dk>
Date: Thu, 29 Dec 2022 11:32:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y63DQSUSW4aQlVJ+@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y63DQSUSW4aQlVJ+@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_103219_419605_3B69C702 
X-CRM114-Status: GOOD (  13.51  )
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

On 12/29/22 9:41 AM, Christoph Hellwig wrote:
> The following changes since commit 88d356ca41ba1c3effc2d4208dfbd4392f58cd6d:
> 
>   nvme-pci: update sqsize when adjusting the queue depth (2022-12-26 12:10:51 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2022-12-29
> 
> for you to fetch changes up to 76807fcd73b818eb9f245ef1035aed34ecdd9813:
> 
>   nvme-auth: fix smatch warning complaints (2022-12-28 06:26:35 -1000)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - fix various problems in handling the Command Supported and Effects log
>    (Christoph Hellwig)
>  - don't allow unprivileged passthrough of commands that don't transfer
>    data but modify logical block content (Christoph Hellwig)
>  - add a features and quirks policy document (Christoph Hellwig)
>  - fix some really nasty code that was correct but made smatch complain
>    (Sagi Grimberg)

Pulled, thanks.

-- 
Jens Axboe



