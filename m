Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C51C61DB3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vzEEFu6ah+pd11aCqEyHz92UyrRsWaxfqGc/IwuLEE=; b=OP5JlDDrcuHCejHMlP+8ecnWED
	bwK/U0TgtbUFYrdQJK7KJG8XOHaZ8CXSC/L39gPkX4ZhOv4ANsUZJ7k6aFDNGjwByz4CcC43NIV0Q
	5ptJPVMU/7zHg/7J53y2NF4hbXiafzKBl562F1CEZEsPA4WqxE+p1H2MK8vg6wEbEeXG4tjWVVf5J
	fcDuSHi32khmelUiovQ4S4yx8ktXjEjO2lkSst3ci34gGbxTBDLMpdpf3hKxWtMDK7EeoDOuwojY3
	Qa896M80seeOaO58g7C4kQUxNiV7HeI+ESS2EplizQAcDQ4/m5AzU6kLieq7z69nhmmQTvMWf92jE
	TL78m+7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1Wf-00G3SV-9H; Thu, 12 Jan 2023 17:38:05 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1Wa-00G3QM-5T
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 17:38:03 +0000
Received: by mail-il1-x136.google.com with SMTP id f8so3604146ilj.5
        for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vzEEFu6ah+pd11aCqEyHz92UyrRsWaxfqGc/IwuLEE=;
        b=6o7irQ9T2sXSzyzIBiTCY3++VoL9Y9edcc0yFyN2FOC2D6vQGDB4D6UEj7mc9wPWX6
         xdv5zFf2rxIwun+M6tYIDhDVMgzGpezvUm+x0Q+nYvpQ+ph06HajgJ5B9gWyJk4Uitjv
         DBtaKqHmu+cFxKa9Q1lK1HmuA1ZtZ5ZMajDkTvfvKN+M3i/oAEAwCIPvEAg7m5d9XSW9
         QCzQQpr0xn33VvO+Gdv+ie4OrCsTtJ9ZnI8ADoCuvQOOrIKTkBw/fAYiMGbaP8Ghq8AJ
         GQpjPB7KyGrtpQjny8F37HBghN42+N4hI8OSviWybU9px0n63NuHPyMW5r/epDrmZL3U
         h9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vzEEFu6ah+pd11aCqEyHz92UyrRsWaxfqGc/IwuLEE=;
        b=fc7rkvFS3IiSjiUtyFV7C5V2IcwUJAhJMWux5zfFKBpCKTCHOKmoAbTypoHMdljOS0
         aoriKTjZS+Fl19xWbvxdiOc//QUPQbixxMTN1kzdDHaffmeIJi+Vx4Xo8jmcr310ySN2
         6sY9ZTriLDyPgQpJv31xHvh3fDTw7+0roZE9P4qGNluh9EL5t+zUXVQOxqK61RUXH3PR
         OtrQI+peYQxtrImmRtFQySSzORlQVVFVuKnp1M+g5GX8grrOPVm6VHMdi18MsF1Lav7W
         J8jc8zv49CkWYtR8QmjGJeyMPd0KaoI/bOGZMzDnsQxqTQdHAXbBUBsLPxC4w2qnZOlJ
         L8Ew==
X-Gm-Message-State: AFqh2kpglIf1lc/yIzWMCRkTWG7dWo1+vfp8Pfi3GULPIq3OE5Wb6ZpL
	ACbbvch+vnolSAMekVBfAIEeJQ==
X-Google-Smtp-Source: AMrXdXuy91qcTH6QYEYlYY9Ke3oRmT3uQRx3pJ0m38xplz5S8q6hZMQDkxASWGkAjQbFNUjsE/B6EA==
X-Received: by 2002:a05:6e02:20e7:b0:30d:9eea:e51 with SMTP id q7-20020a056e0220e700b0030d9eea0e51mr4063359ilv.1.1673545076251;
        Thu, 12 Jan 2023 09:37:56 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o192-20020a0222c9000000b0039e92d559a3sm2969186jao.166.2023.01.12.09.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 09:37:55 -0800 (PST)
Message-ID: <76dc39b2-2f46-6cd8-9894-b069ffed2a1d@kernel.dk>
Date: Thu, 12 Jan 2023 10:37:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y7/D64Qubtqmdv04@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y7/D64Qubtqmdv04@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_093800_240928_54A35B43 
X-CRM114-Status: GOOD (  12.58  )
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

On 1/12/23 1:25 AM, Christoph Hellwig wrote:
> The following changes since commit 49e4d04f0486117ac57a97890eb1db6d52bf82b3:
> 
>   block: Drop spurious might_sleep() from blk_put_queue() (2023-01-08 20:29:28 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-01-12
> 
> for you to fetch changes up to c7c0644ead24c59cc5e0f2ff0ade89b21783614a:
> 
>   MAINTAINERS: stop nvme matching for nvmem files (2023-01-10 08:16:39 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - Identify quirks for Apple controllers (Hector Martin)
>  - fix error handling in nvme_pci_enable (Tong Zhang)
>  - refuse unprivileged passthrough on partitions (Christoph Hellwig)
>  - fix MAINTAINERS to not match nvmem subsystem headers (Russell King)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe



