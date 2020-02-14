Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39F0C2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBB420637
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UVL0/TyF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YV1tKP5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBB420637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mE+MCGbwAFwZ8O8XZFCnThBZpqkStFW4VE1p/HJ2YSs=; b=UVL0/TyF2ikGDV
	ll2vjT0JAwm9Wph6EjUY1DdVB91pTVAP/KMcyrv4KM0Fc6rzGIavLx171SimqA4lXf5DqhkO9b8Sf
	w6HUrXzqfosjZbzsKIeEGIOrANbbH7X3eR8BaTB0DGxyBBUktsOj6c5B9U2rI8l0zfNOEQ/aJIkPh
	iXOwcdGMSTTAi7k6qXgSLIzcv7i2AiHg4vPC6rSKA7ZjU4S/ttAYLjk4WZxyvnIRtmlPH6zu48Srz
	AvHRCvNkW6cWPahmMISQGsc3G8MhSPZ+5r1X6l4v+5ltFAWCyZ8cJTFOYXhgW+WDkf5pvFF/bsueE
	A/UyphvYdSUjxqToYmMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2eW8-0001NN-Rh; Fri, 14 Feb 2020 17:12:40 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2eW6-0001LY-0A
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 17:12:39 +0000
Received: by mail-io1-xd44.google.com with SMTP id t26so11294597ioi.13
 for <linux-nvme@lists.infradead.org>; Fri, 14 Feb 2020 09:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SA+VO0jccW8f+KodpH0rcGqtHmHHO9IVc9Q8RS0jEuc=;
 b=YV1tKP5JBCJ8pJTJboNZV98fm6M9PNYxXsHkMXXPshkTGjOL1Lm+JoJVz4Lcary6nK
 oel8ox1UK5KavobtjnU3jq9euyVGfX97YWgEtMaJpe1JS5xMeTEy9lxg3MKUw0r6AjG2
 NOhG6rt13Gdk/i5cpMO7cyMluIsNnRxOwLyAxqzATKQjXoANpSOdXvwwk4vwzfOalb8Q
 qgZb8RaoD9YKNuA5gHLmaPurT6NByDE/pB3PoHbNk/WLa4DDSwGbgqEKOCIBbNoq46jI
 S42y2EBHiJEq/uYaoVj9Vfg/L8z8TCME2+YUispqHd7Tvqbd0KOT8zLx9le4uBsw7lUf
 c/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SA+VO0jccW8f+KodpH0rcGqtHmHHO9IVc9Q8RS0jEuc=;
 b=LFlDzyGdm7X3UDnkVzdaxC/QTzh/41OnGJeS3twR+6BsBVYqh7LGU0zgtYoV09Mo0s
 gCMqZoj5pnYkujse3hobras5TddhRHw6Gkb4CuDjVuRh6NhijZ/K+d+98Lwsx1Je4FxL
 uF59otqiPSlhsrFHuOktRmPt/FFSCd1VHtVRfUekyZZykawN+LHQH6xjE54dWidcegxi
 KuB6yoqOW0AWFKpPPWe/LcP/0JyC7YAg04M7RYM8E9QF54JbKiLvjECewx40k1j5s3hd
 PFRW0gl/++e+9r4A8ksnYd+U717C+dWYalNN5AqVScsRMt65QuMra/4sOgKKyr6qigXv
 1DMg==
X-Gm-Message-State: APjAAAVn5ZQ8Z+V4kMCTty0gMhZOSdRPf5nkdrD6GQGilJAGJhxmgy5p
 2N1YZE1iXLFkntPxEwbUi7r9d8nbOW8=
X-Google-Smtp-Source: APXvYqxt5p89b39/leoean9/KwVUG5PnHD1c5knTMManbWbqvK8ryBFl3M0GxPEjkVNr0gmDvsZ3vw==
X-Received: by 2002:a6b:6e18:: with SMTP id d24mr3187709ioh.301.1581700356157; 
 Fri, 14 Feb 2020 09:12:36 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id q6sm1610242ioj.49.2020.02.14.09.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 09:12:35 -0800 (PST)
Subject: Re: [GIT PULL] nvme for 5.6-rc
To: Keith Busch <kbusch@kernel.org>
References: <20200214170939.GB10757@redsun51.ssa.fujisawa.hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <442966ed-d371-409c-45c0-0ec473c1ef5e@kernel.dk>
Date: Fri, 14 Feb 2020 10:12:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214170939.GB10757@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_091238_043195_9062CE50 
X-CRM114-Status: GOOD (  15.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, Chaitanya.Kulkarni@wdc.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/14/20 10:09 AM, Keith Busch wrote:
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.6-rc
> 
> for you to fetch changes up to 4c8337a0b7bb7fe7ffd75a7be2aa40804442cf16:
> 
>   nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info (2020-02-14 23:24:23 +0900)
> 
> ----------------------------------------------------------------
> Anton Eidelman (1):
>       nvme/tcp: fix bug on double requeue when send fails
> 
> Keith Busch (1):
>       nvme/pci: move cqe check after device shutdown
> 
> Nigel Kirkland (1):
>       nvme: prevent warning triggered by nvme_stop_keep_alive
> 
> Yi Zhang (1):
>       nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info
> 
>  drivers/nvme/host/core.c | 12 ++++++------
>  drivers/nvme/host/pci.c  | 23 ++++++++++++++++++-----
>  drivers/nvme/host/rdma.c |  2 +-
>  drivers/nvme/host/tcp.c  |  9 +++++++--
>  4 files changed, 32 insertions(+), 14 deletions(-)

Applied manually, as your branch is way ahead of block-5.6. I'll rebase
the branch once this is in, so we're more up-to-date.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
