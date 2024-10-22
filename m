Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93452D2C55D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFtsSDzudH6vBFl/jV0maYJVFCzzsiHFTMrplbR73TY=; b=z+SfBWgC92qg2w2phXTDDm+Dew
	AX34zZdaVzjza5Penio1h0+Csu+JuYBtAKUskt6cfgb1/NTEdF/cOheipAf20E58543+LBZos58SZ
	8Z8wQ6ZhJPCB8ti7vhEFcboFYfRCUYKEHtbYADME9PmnJS27Pf6UFHsVrsDlAiePuTmm9g3Fv7r2R
	djgTTdzoW2Q5K7eZTSy7LrvHN2d/Q/S6vBkl4iZJuu4Q5gXt4Rw/z6zXbzRzwH1W+WbcGEe8+x60i
	FZWrLbedtqOxGcY/ci1rr0bri+nH69vYNCm9w72lhQTkvrLmYsnDN3eVxxd66EyNOaQETIQqZbhon
	nMLJzfAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Fjm-0000000B5Dx-1Zqi;
	Tue, 22 Oct 2024 14:19:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Fjj-0000000B5Cg-0JSg
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 14:19:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 36602227AAA; Tue, 22 Oct 2024 16:19:43 +0200 (CEST)
Date: Tue, 22 Oct 2024 16:19:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>, sagi@grimberg.me,
	kch@nvidia.com, shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
Message-ID: <20241022141942.GA17410@lst.de>
References: <20241021110331.125962-1-kanie@linux.alibaba.com> <20241021110331.125962-3-kanie@linux.alibaba.com> <ZxbWxuzH3u6hAezr@kbusch-mbp> <b4bde72c-7123-4594-a064-a39aef7fa7ec@linux.alibaba.com> <ZxcIxhQMYt2fsPiY@kbusch-mbp> <20241022060639.GA10510@lst.de> <7e573e58-39b3-45c3-afde-0cfec3911326@kernel.dk> <9f42c09f-4082-4578-812f-62ba006c1c05@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f42c09f-4082-4578-812f-62ba006c1c05@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_071951_273992_75D4F392 
X-CRM114-Status: UNSURE (   9.81  )
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

On Tue, Oct 22, 2024 at 08:18:10AM -0600, Jens Axboe wrote:
> It's on 6.12-rc4 now.

Thanks a lot!


