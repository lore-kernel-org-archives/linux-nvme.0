Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DF6D5CCAF
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IzD0f6x0FcSWSS2mErwii0h/GnGUEzj16FApQPTBDLY=; b=qrnw6uO0gRfioCWrrTnMEcudZ/
	R8p7O+85pupdnpcR7/2sGyCnKQrpjfj7gUYXLXCVvC5UiO0hdwZbVzl5CLxM7w8IN4tRlRPt+SnM2
	3xN+gPcSnjy3M/sGH/+PKRWnhnjC3Yi4w4mge7bjfCC/7CUwFz0WenkuLuig7b7Qmo8pPyhmsMwqt
	IDGKIebyLcGK3kC/H1Q3YwZiU+d0cMQhDLSopFF62Obcew68uSJ3z045xbvjcDtzdcchbt6Xqm5IS
	icummLasRy5DmglUeVs9Lu+Chh5M+c1WIezoznwQFbEq8fcdJlJKOlYW+AVzvkvTFjNgBINsZ194a
	9v0ja4UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t69AC-00000000Yba-0f9u;
	Wed, 30 Oct 2024 13:55:08 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t693C-00000000XH4-1WjT
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 13:48:09 +0000
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-83abcfb9f37so260089339f.1
        for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2024 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730296073; x=1730900873; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzD0f6x0FcSWSS2mErwii0h/GnGUEzj16FApQPTBDLY=;
        b=INSIc3EJ/MACoIMyjlxpOI10NdeN4V6C54XnkidCrjPxNBcR99lzEyZiS9Ne+uaT6P
         GR2Asz9yNZRYstWNSLF0qy929c13sQIMIWspIXzrZ4GWX12CX2TAwJnDj25LmTuRrnnr
         jiRKO+c5QxzfYR75jTYIKxvpyUKAOLeSguC2O5rEJlLs1yENGYBsCQ2WJzIHO8qUMxOA
         6r+Vip/n2UiKL+NCe0aRFc1dT4vv0wBvF9vWo9jMznG9NtaLL5wTi2/qG5395AdwTmKY
         zqXeEplFz+vpITo4ZuU+IG4uBVO3oS/6F2Z4GUfEA3siiG4eeybbLOqRiU1UI0EyD8eA
         S7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296073; x=1730900873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzD0f6x0FcSWSS2mErwii0h/GnGUEzj16FApQPTBDLY=;
        b=XukI6vz1h7EHkEDzgNvluwTvxSFtKV0WSJpGhp6mbvzhvzqS/dvkfBwEiz+tGgTMKN
         QZJfzqxyqr6a6IYoWBr1ZZ+EH4tILBryoDzojmjlajG3UlVeT6zx0NHXf5muiba0NdWd
         l/3AsbQMIFxXf3s7rSxDYxs6Ka9mxs2bre+Hs8gtwzBK077hZHhy5Ho0IznR8nKuFwOI
         UWr27yq696bfC98sTBNbcoRU0TCYk3YqLfSDfl2Tgc0H3JnNqgCoFD4/agjZW0B2dG34
         k3nuEhAWDNqE2Gz8zNXAxo+SCKX2zYAnEu0L5Bg49xUSeVFzT2FhIhdBHOUgMeG9y1hS
         E7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVMD5UnwHAopwJcOU/htgWFfi9X+yufpqnuHXw3Law11VRDBnt97ZaS5uMrj3du6RaGqYTtbm9nmxdu@lists.infradead.org
X-Gm-Message-State: AOJu0YxuzrsOwdLRhcZCGHzb29wrT8VpHeFhIzFI3VkeDMUKQQSba0wd
	NIhYaZxDJtsLsRCmr345ScGkIU7RW8UxihSuI+1daIEYWl2THxTbIu5G2NmR4oE=
X-Google-Smtp-Source: AGHT+IEUfmrDjxbnGC3Yqd/2uks+MpQ9zP6cr5heHW55n1ZgaWSgDdSH16y1iITqh/Mko19Tnld2IA==
X-Received: by 2002:a05:6602:2b01:b0:82a:3552:6b26 with SMTP id ca18e2360f4ac-83b1c5ddbebmr1707324939f.15.1730296072842;
        Wed, 30 Oct 2024 06:47:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72784f8dsm2860991173.150.2024.10.30.06.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:47:52 -0700 (PDT)
Message-ID: <c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
Date: Wed, 30 Oct 2024 07:47:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
 hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
 <20241016201309.1090320-1-kbusch@meta.com>
 <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_064754_439132_7B988D5A 
X-CRM114-Status: UNSURE (   8.46  )
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

On 10/30/24 7:38 AM, Kanchan Joshi wrote:
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> Jens,
> Please see if this can be picked.
> Helps to reduce a dependency for io_uring metadata series.

Keith, is this queued in the nvme tree?

-- 
Jens Axboe


