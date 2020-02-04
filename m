Return-Path: <SRS0=ej39=3Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D39C35247
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 18:30:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6FD20674
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 18:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CiFGezj+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AOwX5WG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6FD20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PxgKgmXIKyytLPcz0DFg1xuoWfxzZtxzO3P8C7nrzds=; b=CiFGezj+rY/NqB
	3ACzpGaxWajEWk37K4A48PVPHOZx88GnnMs1RafEGNeuYdac74Dn0IJLjzWyDEBATTSdyqDcx3J4H
	yl4B0pOIbbFss2RwZfzIhJwVMhFKb3jffDtENkomIuUxEtzS9lQY49t0M1CNspXDFAqxxTlU22hY/
	cKWvFQqpRssDeSPIVKXWVnPC98mZCDoblGdiagQGnk0JGY+iXJHq0uwp7dB+PoMB8w3jRkU2ERGTD
	OxcP4SWSlYYZVjiYw9XUKO2BhrQKzI1Ofm6fCu1HHV8SNPb+flA73PrcHWk0bY2zLvGRlCmoTGDdK
	O9qIQ4T+yflbqPa92bdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iz2xp-0002uQ-Ok; Tue, 04 Feb 2020 18:30:21 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz2xn-0002ti-Ac
 for linux-nvme@lists.infradead.org; Tue, 04 Feb 2020 18:30:20 +0000
Received: by mail-pg1-x531.google.com with SMTP id g3so4364151pgs.11
 for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2020 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UbkJLzkmoT4LocCN7KNpbBMPWSNWbDHY7wdZPqDZZFE=;
 b=AOwX5WG40emXmKNcFSmtve18byrbSLyIqZKHo11y5jmDQmLd9/0MK3huogVRz2RrWZ
 o8azFN1GLigm7PGZzCdczSg8MgQO+A8bsCAet5gD+1V1Pbw5dBgsLd/4UqI4HmDCI/hx
 iGobmdVsDTO9qHTwQIWQEwfdMhxaOZvGuMh4AYbljEsX/X9cJxfEUVEcqHlKmatMqf07
 PcVLCqbd8affYQ5DN0ZXEs3wcwD8ZvoLjm8tUQkaOFth0+5oMbIZzfWSNH5pytn7YTNI
 0xGzCRpoqmiYeKpn2L0edlI+Vu6kWftHESiux/n3eQks+wK9G8f1FgHJLz/BcgQh2lTw
 TNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UbkJLzkmoT4LocCN7KNpbBMPWSNWbDHY7wdZPqDZZFE=;
 b=R+nSx5UCQxd0yOWCx8XA3h7fXEO6gSWtjtcucyKL6we+/aD+Yza5xsIOrrfRNPQnFt
 iy81+Ckockxw+/1e49o96aNDVP+Kfitdq1zd1gk1wf87XyKvfZg76wdXcjjJq59wAIq8
 DJK1yneLoK7nZM753QZIJT9P37BtJgZFX5UZ2R5Ou5hsWEYfz5Kb1NliCdH3K1hMllhH
 3TS1xio6PUFRuefKnsAhQt7z+4rVWVAylWWZzdLIXFaeEDZe1eko+lM8zQ+0PLD4SKKp
 aCGH4DSB7OIt0FY230pXh+TvvAe9ereGz5iC24WGt998+UPV+OUQqfCYSjW0eYWKHBRm
 Yjbw==
X-Gm-Message-State: APjAAAXH6SMF3r/jiZF/A3ghmhQUxup2iKwjaLEQDT+05VLXOguyiq2F
 t5sqtnTFkGnj12ymoe9um5Jnyg==
X-Google-Smtp-Source: APXvYqyXBve/KIrt66Ag0+w+KU8uRUBbOZNITa1pcWgwwtU08LE0NdiLZrF7TTlgCv9vc+9ZjymKmQ==
X-Received: by 2002:a63:551a:: with SMTP id j26mr32574746pgb.370.1580841018026; 
 Tue, 04 Feb 2020 10:30:18 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1250? ([2620:10d:c090:180::3dab])
 by smtp.gmail.com with ESMTPSA id u7sm24668245pfh.128.2020.02.04.10.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 10:30:17 -0800 (PST)
Subject: Re: [GIT PULL] nvme-5.6
To: Keith Busch <kbusch@kernel.org>
References: <20200204173734.GE6823@redsun51.ssa.fujisawa.hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <effc0920-45e1-c98b-eaf2-9ccdab210879@kernel.dk>
Date: Tue, 4 Feb 2020 11:30:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204173734.GE6823@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_103019_391639_E9E43CBA 
X-CRM114-Status: GOOD (  10.33  )
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
Cc: chaitanya.kulkarni@wdc.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/4/20 10:37 AM, Keith Busch wrote:
> Hi Jens,
> 
> Just a small collection of various fixes for 5.6 for this merge window's
> nvme pull request. We'll have more exciting features to consider for
> the next release.

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
