Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A79AD10F21
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9W8RR5MgbRhcY9m7aVnTAI9cwuy2bidR0rGohdFtOc=; b=yEeRowK/lNivrH/ReZTLZT6OOe
	uwq5wXWIDknhq/+No1Bkn5vRc0riCzqGG2rK7ARurKIgm4FEoFD+neZGhq1qMh3n+LZyt7ag2m88+
	VeSD1sNckopt3OGgXKFxpGTgIv4y4N8vNcCIiqeJ+DkP2WbYLYaK4ZAHsidTdGh9c6oceBQumbT0Y
	eqYizxBPKBc49GVpuQVLNvGzVdS57VWkrN/M5m6UMKjheaimvexT06r69zKK2J9MW6sEhLlTBD96Y
	rwC4QGvtIJlJQXn2+lmkIGudIT834DOkaGURPI9QettQdReqLS9jl7TPjoeK4jleoCb6inGXaFzUQ
	MfBiic9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOCql-0000000Eo6Z-49W2;
	Wed, 26 Nov 2025 10:34:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOCqh-0000000Eo3R-3qO0
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 10:34:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9137668C7B; Wed, 26 Nov 2025 11:34:08 +0100 (CET)
Date: Wed, 26 Nov 2025 11:34:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"agk@redhat.com" <agk@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"mpatocka@redhat.com" <mpatocka@redhat.com>,
	"song@kernel.org" <song@kernel.org>,
	"yukuai@fnnas.com" <yukuai@fnnas.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>,
	"cem@kernel.org" <cem@kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH V3 6/6] xfs: ignore discard return value
Message-ID: <20251126103408.GC26228@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-7-ckulkarnilinux@gmail.com> <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com> <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_023412_348289_FC439EC3 
X-CRM114-Status: GOOD (  10.56  )
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

On Wed, Nov 26, 2025 at 08:07:21AM +0000, Chaitanya Kulkarni wrote:
> The retry for discard bio memory allocation is not desired I think,
> since it's only a hint to the controller.

Yes, it is.  The command is defined as a hint, but it's required for
a lot of workloads to work.  It's not just a speculative readahead.


