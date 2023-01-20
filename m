Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396B7C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R+C6g8Zh7pdBqjSEEkolIBg6J1lTGJvYxJe1Tj3OyM4=; b=znb+6nCxGtbjPDGLGgpjteUzc1
	abaWga3NcLdF/uFwukducmoDevKA1g1X6YkOMblwgJVMCmY1PgDbPHd+K1ew6ERFFFKp3eek5wsvw
	56+k1mrDR2gsRrhg8FJa5WwXGZ4PHyFFbmqCqDHw7ai4YPRCFvIds9N6rnGpOg1B7knXSQPmZMcrf
	DbF9ghAmzUu8VkukayPeNxg3RePDnTaiMoPNINkjb9OeQvSBCH+oqpkfPGWinYrLnZNQIx5I/oUu7
	f6k2vdpib+AFpa5eQiP4GW/748cVpFjOXtWdaZ3IjE6KLp3fpySiqKXveZtSwIv7F8TB+hIdHjTK+
	uOgbof0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIxF7-00C7P7-4z; Fri, 20 Jan 2023 19:40:05 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIxF2-00C7O5-R8
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 19:40:02 +0000
Received: by mail-pf1-x431.google.com with SMTP id g205so4758802pfb.6
        for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 11:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+C6g8Zh7pdBqjSEEkolIBg6J1lTGJvYxJe1Tj3OyM4=;
        b=k6+lvmmLh/emf4XJ3aK9KPfhtqtkZS3pM7HOQzkIBQEHfG+RJ6ICVom9FdmTbSXugw
         KNLTP7uqIbtY6u/Nc6TUo+uGmaBkN+L3zZBlnTsVdY4kL2lGhpAgLvQ/f2ZMA1Tf/GjX
         vfifTx3qGbzZfFxtNs+wiQ6t797O54hKDqAvBeC7/YuBnp2R4r3g+OaBMWBcAieLyypS
         5xIHKyoaCRSOD7ZKKgv8O/AdmaK6DnDu6UMeQ3NC9vKAzOAaNqe390vT90RbQBrd0OW5
         0F6igzvUhyQgrhiuGel77mbjFnbQ1TH0V/gpJVM57Sv0kWOpDsjN+swM2vtUM4/1uO7S
         84ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+C6g8Zh7pdBqjSEEkolIBg6J1lTGJvYxJe1Tj3OyM4=;
        b=7Q1T1s0IEfNT930VFjuPiXGlFczCR3fyB5/1CYb/rT6dKyJEBcv9UL3u/fdcv1n8yR
         z53tk/2IQJCnYnMZyGjNs8nWNhexJKjbxxS9pTM7nfm/Y2531nl9BpcKzQdCkgm40clg
         Vs7TorJSwYkXFTCFZgyQbQlCnankKDv2Ts68hvR68C0oxNMznh9+nqmnJEF419trdUIn
         jzV55QmMbuNEsy6akX1nPe5z67npaa68cP9iXu6jhS1XDGgwv+egSNRhqQ8iov4fvcBU
         EXiFbuGZOpB2gNNQN9notAWxiwVUcPruTJBrj4t66PE4TV8lXCn+DR5+Y2xekcD8KzaK
         k5lA==
X-Gm-Message-State: AFqh2kql7dqz2P2DaaPRPh0IM13EAThvH5oam+B/rMpCwgeVE8OU1u5R
	eg/XH2MI7aC6IgxJ7g4PVa7P6Q==
X-Google-Smtp-Source: AMrXdXvjOVffbM4asUlHhk72wbecOt68xML3pPRNtZGJcyjLMjFOPkgkJG+rdAm2zPS4aqidZhWLtg==
X-Received: by 2002:a05:6a00:2a5:b0:587:9e50:3af9 with SMTP id q5-20020a056a0002a500b005879e503af9mr3666793pfs.0.1674243598067;
        Fri, 20 Jan 2023 11:39:58 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i126-20020a628784000000b0058e08796e98sm2964169pfe.196.2023.01.20.11.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 11:39:57 -0800 (PST)
Message-ID: <bb51ac9f-44e7-0a37-a11d-314e9d0d7481@kernel.dk>
Date: Fri, 20 Jan 2023 12:39:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] nvme: mask CSE effects for security receive
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20230120171731.652371-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230120171731.652371-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_114001_135244_0780E20C 
X-CRM114-Status: GOOD (  13.33  )
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

On 1/20/23 10:17 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme driver will freeze the IO queues in response to an admin
> command with CSE bits set. These bits notify the host that the command
> that's about to be executed needs to be done exclusively, hence the
> freeze.
> 
> The Security Receive command is often reported by multiple vendors with
> CSE bits set. The reason for this is that the result depends on the
> previous Security Send. This has nothing to do with IO queues, though,
> so the driver is taking an overly cautious response to seeing this
> passthrough command, while unable to fufill the intended admin queue
> action.
> 
> Rather than freeze IO during this harmless command, mask off the
> effects. This freezing is observed to cause IO latency spikes when host
> software periodically validates the security state of the drives.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



