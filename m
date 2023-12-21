Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380FBC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 21:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YqeyCYyLepZo042HyrJDNBHf1lwKgrpPtkRRhxWl3Pw=; b=fGQ2l2uBYcSe9qBfbTGIeoXykW
	JrDQxE/7zfqRy2Nq5YUzu+49EW7GsT9raweMmgVWpk55lbwh9cFyv8RHpct02BzsisTCn3Q9yxBfj
	4aMMR8U81CraFBL7qVbrFO4v7Qt3sCOoa9zgJE5dUROAAHG8gnQyHRvXe/oNysSVgc5mSDxVi5r8t
	a1i2O6i51tFyChJ2f2lxJz+Lh7WqXLhgfr4Wbw002YMD5Z7okIayp8jLV/ayqzjQ1GsQQt+Uxm3yd
	ikAotZZWrv9JG2OEvE7WRT+Ah/qaDCpQNTDM8Ww6QekNqGU8+e4yQQxZwV7lmWWUK+3EWTs5tmvw+
	GtrJg6Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQfF-004AhR-1t;
	Thu, 21 Dec 2023 21:33:09 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQfC-004Ags-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 21:33:07 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7ba8f20df13so8759139f.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 13:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703194383; x=1703799183; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqeyCYyLepZo042HyrJDNBHf1lwKgrpPtkRRhxWl3Pw=;
        b=OulCEJcEaVgv1SICNMJ/TSlHxiXKJ4mZSFXSyIfFfBs38ZgTVr3KgJBljG563aRSfH
         xIeGvd3AocoXiA9zXFVrg4WJw1q37UpMeOj+PkpkQkApv9jg+n7i54fL70TFhxR3vtvs
         hcZ7j2FwFx8CR2OvdYLJE1+tm+FuqVdjH8F2FdiFGQnsT6V0Ybn/WbB0U/XCABMyBMpu
         XrcGYU77kmn/IYElGNJ+gAEKj5pQaf5xafrfWkt2IGqulSu9r/lENJtl/l5LvapYt3wU
         vKvnCrjNnwh5HetNJJOOLwAMcxwdBRVJPO4Lql7J9o3zzBTYBiNekWr5YvYr/mvunE/I
         /5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194383; x=1703799183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqeyCYyLepZo042HyrJDNBHf1lwKgrpPtkRRhxWl3Pw=;
        b=FcuBPX0qMOUMVLKEQcWSwBOQXVQedI/HJLC1e2VtsUswD6CVd7OSq9ayH+jqpyu2YQ
         tK9oFei2HYwN1eYL8TpMR1lT5Km7P2LjOI1N1/66PakD+V5bl8uwyvbUxPIgu6t4NzCT
         IkEctsTU5UuwXVZcfcaNRCKkfUTCsTZKC+t2AvitLnZDmHtUtH4vBjxpF0oYHs1Jf3g3
         nydCaedQ2ABatA6fJEhatpWc7FKYv6B/7/0DNp7YLgK7V1NGzu/5c7p2hLds9GwXn/py
         j3T1ksIdH9EU2tjF2KbakMCDQyNjToSjCGh+gET36WrpW8u+wSB71s7xmC7IPPFTVOv5
         qgcA==
X-Gm-Message-State: AOJu0YzWdTpvdCkgBNqxfJuQu5gyRVwJ9W52v4FJqWEfoH+idfibL1kA
	O9JVY4FMhUEH/v2s7OA/vJPXnfZ5xhsidQ==
X-Google-Smtp-Source: AGHT+IH/6HtLTERc9K953NFnaan/ndyB2ox4ffhXO05e+eVOapjb0LuELAqcvpp7HA6thjkxlZz3Pg==
X-Received: by 2002:a05:6602:1817:b0:7ba:9b40:1a47 with SMTP id t23-20020a056602181700b007ba9b401a47mr184233ioh.2.1703194382943;
        Thu, 21 Dec 2023 13:33:02 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cd5-20020a0566381a0500b004290fd3a68dsm664501jab.1.2023.12.21.13.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 13:33:02 -0800 (PST)
Message-ID: <7849a660-916b-494b-bb61-a22d82d3db8a@kernel.dk>
Date: Thu, 21 Dec 2023 14:33:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.7
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZYSukaa3fDv7p96Z@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZYSukaa3fDv7p96Z@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_133306_520661_A80F93EB 
X-CRM114-Status: UNSURE (   9.60  )
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

On 12/21/23 2:30 PM, Keith Busch wrote:
> This pull request is expected to be our last for Linux 6.7.
> 
> The following changes since commit c6d3ab9e76dc01011392cf8309f7e684b94ec464:
> 
>   Merge tag 'md-fixes-20231207-1' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7 (2023-12-07 12:15:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.7-2023-12-21
> 
> for you to fetch changes up to f6fe0b2d35457c10ec37acc209d19726bdc16dbd:
> 
>   nvme-pci: fix sleeping function called from interrupt context (2023-12-19 12:41:05 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.7
> 
>  - Revert a commit with improper sleep context (Keith)
>  - Fix async event handling sleep context (Maurizio)

Pulled, thanks.

-- 
Jens Axboe



