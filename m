Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A08C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FzsUXswUhqYEQy8OwcCNbzuC03X79npbhOLwmH4zQ3A=; b=pxl7nm51JEpQXpRRxDHAMOX5KN
	UWTMmwLt3maUV6lfZTp9fSEwAPa3Q//AZPgTQK8TTyCHWDONjd73dFwfgWuxcwhu9V8SLyjMF4b+f
	Tz4hCoz9DVmpBS2x2jzBpkqCSEExE/XLoIgSyl7BOYVwRqtjsgl87P3sZMEnQHUfXgV3NYNJJ6k0q
	a/cG62p+dEaL9ow/AF5sjLtltgOi/JRn/GGuK/DRKZdSXHrm6wgMOIwrZlkAwyXdtUXi4P5nYot48
	aoEhhwANe0yxu1n9pTgPj7L6HpYXnWhI/EeWlgpJw4orBE2ubC6MnmsTZTlnhJ8lZ09KI1Z3/xjiw
	Y0F7tLFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5Bv8-00Fgkz-CA; Wed, 05 Jan 2022 19:26:02 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5Bv4-00FgkA-Up
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 19:26:00 +0000
Received: by mail-il1-x131.google.com with SMTP id 9so316211ill.9
 for <linux-nvme@lists.infradead.org>; Wed, 05 Jan 2022 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=FzsUXswUhqYEQy8OwcCNbzuC03X79npbhOLwmH4zQ3A=;
 b=MW+peUHy5fzJsFssPXxnKJiwyp9ejGHC7+Aq98zxLT5QgDr1LmMjpU8nMb2OKQbyUJ
 h9il/hvvIVVdPU0rBkbk65NjXNM40l6ONc8bq+g1DeyRfqGMVU+oI+ZZPFaH3JVUJrBi
 UG96OgsszW8hF0sf3r2yqHd88CJVCQ6beT/+i08OPbkh65KHfK9XaKqnr3oIL9215we5
 qJzpFzsrbV0I3CceBb0lWFqv0YK3GEzLYHvvejN9Iv7sJALcqi61l+bp1JIhy+0O3fTU
 obizZB4vthNmn32aL7oD6b9m3LSUa2JRnrSzRm0axlOqsfM4nKizoOAf9VxKhAEWL0YN
 iX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=FzsUXswUhqYEQy8OwcCNbzuC03X79npbhOLwmH4zQ3A=;
 b=yGzp/2s/yCVcM71SeGe4EHFLiVFtUkbBr14lc0OdiCudPr3iRoimdGpdC3v5yYaEZJ
 0C4Rh/MnhvlaYPlygPkNPpRDFIfK9h3vtJXU1OlQCdb1IPaFGB3/dMQKsQ9GN+Uvg5tM
 R1x/NQOp85WUXfpGAERFDMlTVFXqppUqLcH3VHUwu48KJD+AlI6czyM5j/QwKkbWigLP
 uCvjRU/tlNBWzlf4mEoNEqSGtKKN8Rbd9ka6R4AFusrQeq7bA78hpNOVxCilhKPBHp28
 aJn68XnxoN6DJbY8PXd6mjhUe2BQcdvb/2DJIzbT9SoHavc0CiNWxnz10HbJv7mOqE+0
 6aXw==
X-Gm-Message-State: AOAM531a4b2UtF/gWBj/wGJGP1Pwkb0D4ABOfjLYcyntsRywj47wzCOz
 rpfy+vu3BVkJLBi/WGxUKcignBH94JCfUg==
X-Google-Smtp-Source: ABdhPJzDzyQ7qTti+zHMYNt5vw3nCHOdkI1/nZogYf1PCsUV4AYLBR7Y5fcY6gi4n8JeeUho3P5h1Q==
X-Received: by 2002:a05:6e02:1c27:: with SMTP id
 m7mr26446900ilh.114.1641410756794; 
 Wed, 05 Jan 2022 11:25:56 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id s6sm26159317ild.5.2022.01.05.11.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 11:25:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org
Cc: sagi@grimberg.me, hch@lst.de, mgurtovoy@nvidia.com
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
Subject: Re: [PATCHv3 0/4] queue_rqs error handling
Message-Id: <164141075584.313116.2242148358924227236.b4-ty@kernel.dk>
Date: Wed, 05 Jan 2022 12:25:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_112559_065037_43859A9D 
X-CRM114-Status: GOOD (  10.99  )
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

On Wed, 5 Jan 2022 09:05:14 -0800, Keith Busch wrote:
> The only real change since v2 is a prep patch that relocates the rq list
> macros to blk-mq.h since that's where 'struct request' is defined.
> 
> Patch 3 removes the 'next' parameter since it is trivially obtainable
> via 'rq->rq_next' anyway.
> 
> Otherwise, the series is the same as v2 and tested with lots of random
> error injection in the prep path. The same errors would have lost
> requests in the current driver, but is successful with this series.
> 
> [...]

Applied, thanks!

[1/4] block: move rq_list macros to blk-mq.h
      commit: edce22e19bfa86efa2522d041d6367f2f099e8ed
[2/4] block: introduce rq_list_for_each_safe macro
      commit: 3764fd05e1f89530e2ee5cbff0b638f2b1141b90
[3/4] block: introduce rq_list_move
      commit: d2528be7a8b09af9796a270debd14101a72bb552
[4/4] nvme-pci: fix queue_rqs list splitting
      commit: 6bfec7992ec79b63fb07330ae97f3fb43120aa37

Best regards,
-- 
Jens Axboe



