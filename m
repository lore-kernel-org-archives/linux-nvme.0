Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F7EC636CC
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Feb 2023 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wP4KJ+sUVy984XavI9TlLdBqFbJPagaCXgo+4pa+BK0=; b=AjkGHV0nJiYhFXzxiDj3DHXpO5
	ibzXzLQgesgkPS9iZZrAR0MC6pabNvfBxlSMZIS4XVjjIQeXpEXxSlTrfcYIwlPn+HpeWl6znRM/x
	v8lxbW4mE+P/rNVwI6mtbZHs9fq+QlCknkoa5aBsjIEG+wfTHCQZ9yhax8vF1hIiSunrmNhOd4UeD
	cxhqczb9qn+23lbPfA9di4jRUQBI2PTlunqJMCOyHlryDBmw4Nz9H8HUEZwAj7VH/PhD2hyHgk+ih
	XOho8SZarn48Ek2uEJ0bHSVD6ZzigZTndjhrtHY/JK6gpaHloZjU+kOoazPlnrXiWc5KsPKU/JG6m
	jM5wodyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPOt1-00CSPo-7P; Tue, 07 Feb 2023 14:23:55 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPOsy-00CSLJ-6z
	for linux-nvme@lists.infradead.org; Tue, 07 Feb 2023 14:23:53 +0000
Received: by mail-pl1-x629.google.com with SMTP id r8so15799602pls.2
        for <linux-nvme@lists.infradead.org>; Tue, 07 Feb 2023 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wP4KJ+sUVy984XavI9TlLdBqFbJPagaCXgo+4pa+BK0=;
        b=dOzq7fmhkX0C94KaiqP3PAxTwWZeiv0eDwIEB9yzreSN75EPMu9zZdWxvT4siUoRk/
         jLyf+gWgipAEvrh5KV9dBzDcg6o2BiMHSb1vs3S3kX1LszcohTbKPNdhCH/tXhiXqWT1
         4Hq748sI/E4vpWz/2VI6E6X7yAm2V+HDawN6woX8bAMvb0AOj1CLsAGnLA7Z6SoFFBRl
         J5QMh5L+kfm9kVMmbZG9zDCed82YtXY1A88oS2r6u2jniV12hGnzd2DxpXn943O+MC03
         zrdL+dPHoNzzS4zg7QVM1QdCwfgkatXP8+NFdukB1/lQZAztG3sk9S98Iozlv8wEXWVL
         DP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP4KJ+sUVy984XavI9TlLdBqFbJPagaCXgo+4pa+BK0=;
        b=62Ij2UlZs8MbV7HVWfK3p6ojC/ptXOHv+NxKiEkrEJzGJ4E+QrSEQn+XWzZ3p1SVtp
         fsuxwJVJ6yDeVJedy5Q3m/72Qjuk8LU1xDfhCe+FM08hbIkxwqvQnc+ej8DMoKoUU3QJ
         PK+92QCiczkQj3YW2t/srhY7T7AIOPqMjpA4aaO08TkFcKL53nY4MlgqmEHyLPzArDEV
         ms4uwsMVAupdtgE93ug5cAPu9ydZ97rRFGaGXvYhcE1IQyfjiv1LfIx4a25YDPmPKD5x
         dgb6lMXc+2vHdf/4X5iVw9LsFcPLcIh8ab7yrMGa5Wl/fmKjgQGq2el0alE+8h1K/bJf
         Lt1Q==
X-Gm-Message-State: AO0yUKWm6KBYyV0Edbe8x82Mx+Cw/r1P9YmOs0qwZtwnD34eOT0Ku9rB
	rTuuzw+kVsv7u/xKJ6xvLdjPxQ==
X-Google-Smtp-Source: AK7set/LK2NJA8P7Ldh16A3GC7dgJXnpinpBlMVgFhhnYWxbKN2ji0deVq9tc0pA87XfR9cSIuMhrQ==
X-Received: by 2002:a05:6a20:690c:b0:be:9fff:48e3 with SMTP id q12-20020a056a20690c00b000be9fff48e3mr4174015pzj.5.1675779828395;
        Tue, 07 Feb 2023 06:23:48 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b004f06ccd76bcsm8047588pgp.70.2023.02.07.06.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 06:23:47 -0800 (PST)
Message-ID: <115b0b15-98de-3615-064e-3de15b40895a@kernel.dk>
Date: Tue, 7 Feb 2023 07:23:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] nvme updates for Linux 6.3
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y+Hsk7eOObSafEkz@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+Hsk7eOObSafEkz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_062352_272088_2CEDD6EC 
X-CRM114-Status: GOOD (  13.38  )
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

On 2/6/23 11:15 PM, Christoph Hellwig wrote:
> The following changes since commit 2d97930d74b12467fd5f48d8560e48c1cf5edcb1:
> 
>   block: Remove mm.h from bvec.h (2023-01-31 09:21:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-02-07
> 
> for you to fetch changes up to baff6491448b487e920faaa117e432989cbafa89:
> 
>   nvme: mask CSE effects for security receive (2023-02-01 16:10:10 +0100)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.3
> 
>  - small improvements to the logging functionality (Amit Engel)
>  - authentication cleanups (Hannes Reinecke)
>  - cleanup and optimize the DMA mapping cod in the PCIe driver
>    (Keith Busch)
>  - work around the command effects for Format NVM (Keith Busch)
>  - misc cleanups (Keith Busch, Christoph Hellwig)

Pulled, thanks.

-- 
Jens Axboe



