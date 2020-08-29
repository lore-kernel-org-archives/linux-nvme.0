Return-Path: <SRS0=h+kd=CH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30885C433E2
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 16:55:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029A32065F
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 16:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C5HsFYut";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QbRKLoIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029A32065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ce5jjGqsba1rxAKw5mSy6xippuaw9L3Aa0iZq4anoNA=; b=C5HsFYutO9UCP7nKHxuO2aKT1
	HgVUFqbA9Yo3aDn7qiEvyqznx6uHccHMot4++a3iVmDpkyxFKzzwfxTTVKR9Fh1G64bhAs2E7L5MD
	w2W8NGMOTHnxth/sC2sT6hnpeHhjYfcIzdUJkHGblI/uWGassELgaFvKUoR/Zua3UWpvjr8PnBwO3
	s64wzzvdw48I3iz1wS8Wng0TjtzD4DifFkTTrl9dNdwq+dU3bw65pLrGFS+V/SXbfupUxGrmN79V6
	MyFQuMkEYUggEnTWBnqHl2VaFOJu/C9EHxl3b+sdx9Iiajo3IK33JeJlrVj3IjMgdzereItj7AC9E
	s3jQg/IHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kC48p-00080H-Fv; Sat, 29 Aug 2020 16:55:47 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kC48m-0007zd-EI
 for linux-nvme@lists.infradead.org; Sat, 29 Aug 2020 16:55:45 +0000
Received: by mail-pf1-x442.google.com with SMTP id o68so2268431pfg.2
 for <linux-nvme@lists.infradead.org>; Sat, 29 Aug 2020 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gpCk8VygJk1zZ08Ty15aVZKL4rkUM5lf7IFSkXE+mKM=;
 b=QbRKLoIW/ndCidQfvSQKq6pdqhlWDnCNAIJWHE1fPzXe9c8+V7UpvHganwEBvpocr8
 xbJk0tF+BJQ/XtrOPdjlx6PjP9i24tfRlisOC7YlXlHj4lnp8X90mWLmsQ0jaIWH2RyS
 YMlSI7WKjDoSpIJ2t+MMkeeMvFtTKbzRE1L+Uqm541YgLso2hKVfwbhJ+kHW9Ikb+GWF
 foe8UwKa7E55gGQGlmCpqrQi8zvRn3SsVi6CK+Fs+1+UZEPtG01pom5JNsOgy46D1Ueu
 VgBBu6UO+1Y5iSTgnU9lGZHewpj8qN/ER8kD0CZGlTP/1zZZxfotc2AL29KX/sUh+5LK
 lfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gpCk8VygJk1zZ08Ty15aVZKL4rkUM5lf7IFSkXE+mKM=;
 b=cHcokun3Xof44zNsH+9NnRIvMp4KYPYM16dXhmYZ5SBETjBZlJD+0h97YuJt7HpCQA
 AYBUBYmgEjQ/0Aeb+7g9kEPKOXF8oXsfclgELcv7u2ss98cowjADRdgdwee7/QNerQXh
 Rz7r8K1+0YE0Qebxl1ru35PvXfxzWrey5gMc4ELp3iFmUKfkPo6p5JOGzd6dWySxnGjT
 WA+GPnlFBnyUD+HVg/FORfZvoMYMniP9+lG3QuBoIweVKlLyFXDlIWsl90t6jsMTG6ZY
 iQ/kzJC+3e0cWJC7FdtE7k5oZuL0smj9fqPlPV8nw9aW+OUkmZtPoC/g3qScMyYEV7No
 Q5Gg==
X-Gm-Message-State: AOAM533c40GdZl/OlJW+dYs71muOnIZnXyVAyLopQ+0babdQVrk72DGg
 2EJHSyp/K4/FtnqtjLKmEXwpHg==
X-Google-Smtp-Source: ABdhPJzpX5e6UXpjfRs8fVs5NiULAPs3P32fOIet9239Y9oMqYW/uFqBsq+B0saHLNIqTBWsY1HdMA==
X-Received: by 2002:a63:4621:: with SMTP id t33mr3075897pga.32.1598720141968; 
 Sat, 29 Aug 2020 09:55:41 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id a5sm2947812pgb.23.2020.08.29.09.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 09:55:41 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9 next rc
To: Sagi Grimberg <sagi@grimberg.me>
References: <20200829153243.324252-1-sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <18fdb68f-8747-6f44-de0d-390a3fbd41c3@kernel.dk>
Date: Sat, 29 Aug 2020 10:55:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829153243.324252-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200829_125544_542623_F65E6A45 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/29/20 9:32 AM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Some more nvme fixes:
> - instance leak and io boundary fixes from Keith
> - fc locking fix from Christophe
> - various tcp/rdma reset during traffic fixes from Me
> - pci use-after-free fix from Tong
> - tcp target null deref fix from Ziye
> 
> Please pull.
> 
> The following changes since commit a433d7217feab712ff69ef5cc2a86f95ed1aca40:
> 
>   Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9 (2020-08-28 07:52:02 -0600)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.9-rc

This doesn't look right... I pulled from the usual spot, diffstat and
changes match up.

BTW, in the future, can you switch to signed tags? They are nice to use
in general, but particularly for git repos that are outside the kernel.org
infrastructure.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
