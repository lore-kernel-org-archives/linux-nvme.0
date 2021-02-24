Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5EFC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 18:45:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F3E64F0A
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 18:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F3E64F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/bfzIX2mT/8KImeXdPSHWrcjhMXeMv/XDFwoqZ6qzdQ=; b=sz/M2Z31azdV3jSJo/iFTSw2G
	+H33SoGLYwEO/0Ifgs5oeEW4dV93kY/QAfOP2pC6zbbSeZFU0KRY13t49qMR92kGDq2MKBzOtwwK9
	aXW2SVHWQDAKRfgBwUsTLZDlTHzWnGNsqxfa+4x65/H3gY0Ya4h92QudRYuxLb7CtbczQcapyIfxQ
	WJFOqzzDDQ9uhqWm5tWlH8tD20WWGTRTDenR7p1R/PQAIY6BNJqM9QMobDc5lGjrXWK6PDq8n9zci
	CpBRPNAaBis+u3rsPfC3+BhzAQu8g2aqonRBD8rjEv4mOn8Gh3I9bjDS6WBUnpj6De4WlCKB9MBAp
	zNOsjB8lg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEz9Z-0004uM-Cp; Wed, 24 Feb 2021 18:44:53 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEz9V-0004u2-1K
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 18:44:50 +0000
Received: by mail-pg1-x52d.google.com with SMTP id t11so2044871pgu.8
 for <linux-nvme@lists.infradead.org>; Wed, 24 Feb 2021 10:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=P9aQpStscMGku60oH2hmTuYdF4P6Pwf73VuxOiTz16g=;
 b=uPjFK9+8QEwFHFhYGSLW/HvBbWmvpxRtPXqfa+zWMa4bwjJRsaiobgYrVg5GdjK3XR
 fzsC5dUwCzVf5/9s8/Ynm/7cSahGzinQKALF3PL1YPc0jK8UOVKnUz0ygPNBs0GdMbnf
 P8hmZVFHRYOMSh7kYPgN02kyCIxFAF9teQvZ3AWTULXCMSnOHs80XuSBl0KbGMRPhpQp
 xE4BEfZRQXIkMu7EDeWXZh6n57g5pRhSiVIKoy9tYRC91FzFQRTomofF2zoOpWbBQFmy
 2IkNxWBEUWuDbMFj5l+W+xWhl41ZF/pkSg4ZkDDmsmiauNDhynTRqAVy1IGYI2Mw8mC0
 i7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P9aQpStscMGku60oH2hmTuYdF4P6Pwf73VuxOiTz16g=;
 b=cDNjWSu0qSHPt5K7OdKxCScrN8nrgo6qVwdC9AnWeraNwFhFT/m6AGrXgUOmvRfiPJ
 D5W2SjAKslkCPz828HLOj99zmTUzx677D+pS/WkkG9PrT/hgOVoA3ryqBrTdMxEvQRnz
 iNWF47BG7F0shWehENTs1SEkD5SAQhFlef/+wEuSbLlwgKvQGR5++SY1rW3e5QvZM7Zi
 ayQXjKbseT75nVtIH0NAV9Eemnok7lpPCxVOVm0rmZcOtDLnnwGa+iUBKY4YdM+gaFCE
 E+lRlfNZu9pKmvafhkp0/wuPTbRoLNQIlqoBWXyB2MFZxG04As23JPzniJyZYTu9iFOv
 TyIQ==
X-Gm-Message-State: AOAM53191R3hQwSojnGsoy3H7GHMvSwhLN9FmmvXxnoap0msUurnyVU3
 FMccfi/A9L1Dzy7AFx5wEIg=
X-Google-Smtp-Source: ABdhPJwXNQ9x98vY4prYhSHoOKgJ+btDjgvYi4U+zcjPQwpsjYuh9eELs0I7mMXdiMsEMjEkm01QBA==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr15021933pgl.29.1614192284860; 
 Wed, 24 Feb 2021 10:44:44 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id c24sm3664136pfd.11.2021.02.24.10.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 10:44:44 -0800 (PST)
Date: Thu, 25 Feb 2021 03:44:41 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 2/2] nvme: allow open for nvme-generic char device
Message-ID: <20210224184441.GA2626@localhost.localdomain>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
 <20210222190107.8479-3-javier.gonz@samsung.com>
 <20210224164523.GB11338@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210224164523.GB11338@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_134449_109630_BA648884 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, javier@javigon.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-02-24 17:45:23, Christoph Hellwig wrote:
> On Mon, Feb 22, 2021 at 08:01:07PM +0100, javier@javigon.com wrote:
> > @@ -1885,7 +1885,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
> >  {
> >  #ifdef CONFIG_NVME_MULTIPATH
> >  	/* should never be called due to GENHD_FL_HIDDEN */
> > -	if (WARN_ON_ONCE(ns->head->disk))
> > +	if (WARN_ON_ONCE(!nvme_ns_is_generic(ns) && ns->head->disk))
> >  		goto fail;
> 
> Maybe just move the check into the block device caller instead?

Sure, then check for nvme_ns_is_generic(ns) will be not neccessary.  Let
me move this check to nvme_open() with only checking if it's head or not.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
