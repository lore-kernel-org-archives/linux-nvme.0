Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A66CC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Feb 2022 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FzjJyXn/bqOXd4ZYAkke0bU4g6qSzR3Mr9gnRy2DvTg=; b=3vDlpZKePPfUfT4+hYs5zlm8fS
	VOpkHASlBvxRbgZPLm3psgjdCgtTgA3o3faH0ZS7GSCHCuAkMAVeSriGG7hjOegxRoQtPc3AAlppN
	0M5jv06lquPAOdIczumjHKMmLujkIVDXaqVD1TFzmoPCvBW1B9jKGNAgShQHjK1Jr84ATdr+0J4et
	HNSvyPOczfqNhphsnUZL1JT/2caoivYXcJSIcSH7EyujLzcRSW3Cz6YdqeCXVIhua08QkdJkYJF/e
	x9YTmp7gPwy1EZvIZXS5xgFHo7iZ/ytvo7E8sC5AqGqw2QQ5n27CFgpxNDN3jUwkysWF1qsfRMXnJ
	40AzJ6gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOgmc-00CoBm-CG; Mon, 28 Feb 2022 14:13:50 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOgYJ-00CjIO-0e
 for linux-nvme@lists.infradead.org; Mon, 28 Feb 2022 13:59:04 +0000
Received: by mail-pg1-x52e.google.com with SMTP id o23so11402562pgk.13
 for <linux-nvme@lists.infradead.org>; Mon, 28 Feb 2022 05:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=FzjJyXn/bqOXd4ZYAkke0bU4g6qSzR3Mr9gnRy2DvTg=;
 b=emMjftZwGqnvQ1Csf6dPnjraA5SYoxWJ4upPlVDyELTS1MxrD52sQOVyQQfZHHud9E
 n4PiZrOVHuD1p30t04u/zokGLZu2h9LHxx06ku9OYQHMky9qrusGrUMoG+0r7qF7dDxQ
 xvjzoabzSEE01OIot3iNZ2TId9Tc7TmAMm8j4Dnu+EAIg9EnGg1mgrv+ZiCA5xHXoS8l
 yBkiyjAG9xlxqSDQ/g/I1eEGDJ3N8fQ0fS2Ism64Kf1sIv0Duiwy2zAHnzBr3TU7gei8
 O9bA0FehEHNomNs22oJW4kYYQ6Wu7+tQSBrBRU/s55JtsxcErBW2udeVpERkYth/+Gdu
 HmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FzjJyXn/bqOXd4ZYAkke0bU4g6qSzR3Mr9gnRy2DvTg=;
 b=cqBcj2QD3JyqOA8/1u2OxjuzG1F7QmPa8sjDOGrvYctn6U4umlrflpQfSHRYczeD4Y
 8j0Qao8YFyimdfhk1QE+hqsv1stsW3OrIWOfInNM7gE6JiW139BSPRdR3xRvmdFDxKxh
 z3b4owWwBvX5xE8vmDD5Wa5Rj0ulRQlHpU6wcGKwj933CwFr6rzyhbcy+kdkKob44yIA
 T7pYGYNUPvcbhzy0VD83mKTm5VeL9ElTHvmogTCtqt6haEzo/tMfq+D1jp80v4N1EJ5b
 BCgQzjJfo0INLvmPePZM4iPmnK11EWNAK0n/lcRgFU4ahah70Oypp7eZyVJJfzogp/5N
 oynA==
X-Gm-Message-State: AOAM531dt5HELDNcgXKP8KyFRMVjWqVKCQiKyN8tiGKoeVdjp2MAKGGq
 3e94sDaxKq9kvSW9RLZE7kAyVA==
X-Google-Smtp-Source: ABdhPJzClDcESKk8VbFJpCZhSD/v69impDvOr5RcvpSjNZ/GD5HaNMYGmPul8QPhtciskytT/yiiXw==
X-Received: by 2002:a05:6a00:1692:b0:4df:c6b0:2f02 with SMTP id
 k18-20020a056a00169200b004dfc6b02f02mr21648679pfc.50.1646056741739; 
 Mon, 28 Feb 2022 05:59:01 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a056a00174800b004f26d3f5b03sm14287785pfc.39.2022.02.28.05.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 05:59:01 -0800 (PST)
Message-ID: <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
Date: Mon, 28 Feb 2022 06:58:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Enzo Matsumiya <ematsumiya@suse.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org
References: <20220227234258.24619-1-ematsumiya@suse.de>
 <20220228092215.GA8549@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220228092215.GA8549@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_055903_123384_300B933D 
X-CRM114-Status: GOOD (  10.13  )
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

On 2/28/22 2:22 AM, Christoph Hellwig wrote:
> I don't think we should add code to the absolutel fast path for
> blinkenlights.

Agree. It'd be a lot better to put the cost on the led trigger
side, and not need anything in the fast path for block devices.
Monitor disk stats, or something like that.

-- 
Jens Axboe


