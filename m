Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0993AC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 20:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5wxvZziXbUhtUP1Y9zXw54fZ6cDdnya/SKk+UDHGEFo=; b=i8ylo6Ri7sfyFpLZPbWK56cqPD
	DK/b+gaT1GB4pCqnifPB6mVPz/oqFBAZ9YRANU4ULQO6CNOZslDHKlCLFnqHuIWbMo00znLncbIKa
	vGiZmiEsQ+wTDsWPLxt9DIhwR9JJod11dnFHo57+BSiOHHG33PJE3YLhQwvK+oaWrzYLal8m8V/ui
	VJgfn70WRcylBpWOh6/+CY4fzyX6UJEAoVrbyO7qKiNAo9cAiLBMs5lJekccOHvBttXrgxYmDTWrU
	Ia3VTxbfOHVAndELwnzy0iN8sYUOZVjVcUVPtgxLy4dMWKkn+S+tBdw48TlAoim/JVZ6bhZtRSQ0i
	8PDHaONQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUv2V-00000000XuK-47G1;
	Tue, 30 Jan 2024 20:49:03 +0000
Received: from mail-qt1-f171.google.com ([209.85.160.171])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUv2A-00000000XpX-0cND
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 20:48:43 +0000
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42aa4a9d984so28857161cf.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 12:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706647719; x=1707252519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wxvZziXbUhtUP1Y9zXw54fZ6cDdnya/SKk+UDHGEFo=;
        b=wNuSi63vwuqbHAnzkK6EfcLTtxp4LUsSQFQH6ZVm79I6oDlLUJOqCkQHFmFyLfRZoz
         MoQYPPog+rTMd1mY7EDyJeKf0Qp4FJ2akOzqz0AasiAIgwHBumDsuP0KYAhropWseVz4
         /IvQOydgmCmSeyDoJ5iRC5h3scy3RFb4lng/RGluPhRgvuJkGLsUWUTAGLAvsehvMsXX
         XsBUeOqgA0onFEXfcWy9Mu9l3+YEjncG8lnOaJIpY9YuL7/P4U+9zqnsR3lZr3g2dCPy
         NXsl/IFwYqCdTkzM7M/xvpgEbpJTmvWusBth7BY0gJJWnQ52X9bFWQHJv/lc/N7XG2Zk
         DZHw==
X-Gm-Message-State: AOJu0YwE/xStIA/4njnZ2MZZlQAQ+ilMTnZLH7od+DYXbCUMgVWkVkW7
	G/tfzayK0GdCJD6RjvIkxyBdSg1Mvbx+4su+BMZ+VDFyQ/zSO2zeWmqUld6z0w==
X-Google-Smtp-Source: AGHT+IH5S9pyQeSM2K6WGjuq7LBNmUE3HoawjAO33JauM5M9qFYAUZROQj6Nk22MOXOq+8oUsCH3ng==
X-Received: by 2002:ac8:7f8a:0:b0:42a:b37f:4a75 with SMTP id z10-20020ac87f8a000000b0042ab37f4a75mr3021041qtj.16.1706647719211;
        Tue, 30 Jan 2024 12:48:39 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id x4-20020ac81204000000b00429bd898838sm4160126qti.47.2024.01.30.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:48:38 -0800 (PST)
Date: Tue, 30 Jan 2024 15:48:37 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio
 scope
Message-ID: <ZblgpVdHZqPaq7xD@redhat.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_124842_214944_804CD219 
X-CRM114-Status: GOOD (  10.91  )
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

On Mon, Jan 29 2024 at  2:52P -0500,
Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:

> Guard the calls to blkdev_zone_mgmt() with a memalloc_noio scope.
> This helps us getting rid of the GFP_NOIO argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

