Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054E3C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 22:35:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99ADB2084D
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 22:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C6FmcMMl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PSa10iNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99ADB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7mRbQcQEJ4vOw6i+Y5ze9x2IVutZyXfeY9WNnodDcPM=; b=C6FmcMMlyrNSPr
	MYon3cKhBtYNPkMtVk+eJLUnBOEumz+18UV9rvCPs3zubhzfNBS89m+R4pa80uSN3l6w+TVUD0j3l
	ni/Kr8yb0FyJFeSyzn+MbuNW3+96bO0pUj0eyZGQOjZATviyrfuIN/htS4YXPu3o3rUUD4lxs5tZd
	4k1EVnI6XLqDyBHl5n8Z3Ox87lF/XPjyud2U/uYRJ2YD5xAerix2LZvXYUgP3gudsgYD6Gj8TekAe
	n6DApZzAIQpz4IzScYfYqK/wJW5Q6HZfEBO4iWikwRgbpny6g1xADMN77fjA5kw1MDF7vWVCeEAV3
	ByAVi/Hnn7GRSeZtGaRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS7Ps-0001de-Qt; Tue, 05 Nov 2019 22:35:12 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS7Po-0001GF-Ts
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 22:35:11 +0000
Received: by mail-pf1-x441.google.com with SMTP id q26so17105222pfn.11
 for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2019 14:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7Z6eDaZ5yu4rMxX7xbW2h4FuctD04jkNBzPaSwXsipc=;
 b=PSa10iNJcUGtDojbLi5CqqlS6pYOQ+Pr28SqXDIdvuTZf1WoKVIloESvXHDA0rqxl3
 E6rxRs4TaAYT5WOlP27pVhm4TIPce1xq/jz9OOzWte9T6ew47JR5LxfkSIPYN7X8GnqF
 wUXXiYQkEUHYfb/mLasnmKydtb2Cs20sAOKe/8LyHnXTM9uCQP+zAI524d7+0aAJXySD
 0nvN65KBcEW1YZ0Luz0uJPr1LTRkY42YAuLa5V7/t4HoFGlqAsSXPt3Zz15KqUCCOKEJ
 khHUpRMk7c13cj3q1R5shi/W06SqqufoRbrZey6+/M2vw7ddWaGdrJI2Okn64gfpErAe
 JTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7Z6eDaZ5yu4rMxX7xbW2h4FuctD04jkNBzPaSwXsipc=;
 b=XtxHU3CdYFkYFWFFu+FAtO6GdgBDcXOWZnCKOxExgcafHpUgbJAiPbZd0cN5NGaTnz
 wBuu4jHbIDS8ynxAqsnlMPLfOYlBEK8OhVACWZVVTVzDo8H8v47VT3gSMV/BHFryBfNl
 t/UuepO9AZdznyGNEx48gb0U7HNAO2i6L+LzMWSqtPBC1n9b9RtIBomL3eDT2V03m7xH
 Bhftb29RpT0wgJbOmwu/QZUX5jORyeqpdoVeGTrw3fOz8bd9KFlupPeBmKamyA8E39iE
 egrIBbgMuQI9HXnXArske5hwcInEtR8m70F/6F6gl2Z4nNwvEy24UfZPLrF3rNhHnEiB
 5U2w==
X-Gm-Message-State: APjAAAUYXd9oHF/DWXWT1J+jGS85GE1yX5S0DMIm8mR04X0G6IOKQnV7
 FwvtHqka8/K03B0bvwCgdGsxWS23/wY=
X-Google-Smtp-Source: APXvYqxa9h401xD8hb0HLG6+hvA1hgA8Ti7k2rlNDkcNARveuGldabhIFea/TB1bBrHyZziPsbU81w==
X-Received: by 2002:a62:fc84:: with SMTP id e126mr39449420pfh.97.1572993307852; 
 Tue, 05 Nov 2019 14:35:07 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
 by smtp.gmail.com with ESMTPSA id w15sm6425545pfn.13.2019.11.05.14.35.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Nov 2019 14:35:06 -0800 (PST)
Subject: Re: [GIT PULL] nvme-5.4rc7
To: Keith Busch <kbusch@kernel.org>
References: <20191105223117.GB890@redsun51.ssa.fujisawa.hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b914bec2-f5b7-0652-8433-2fcdcaa1289b@kernel.dk>
Date: Tue, 5 Nov 2019 15:35:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105223117.GB890@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_143508_989640_2DE46F66 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/5/19 3:31 PM, Keith Busch wrote:
> Hi Jens,
> 
> We have a few late nvme fixes for a couple device removal kernel crashes,
> and a compat fix for a new ioctl introduced during this merge window.
> 
> The following changes since commit 41591a51f00d2dc7bb9dc6e9bedf56c5cf6f2392:
> 
>    iocost: don't nest spin_lock_irq in ioc_weight_write() (2019-10-31 11:40:57 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.infradead.org/nvme.git nvme-5.4-rc7

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
