Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B171ACD5BD5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 08:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XgQGzbPdHi9wuXrNBoaSs1nkoN+3jJC287QW/UD3PPQ=; b=QlK1wseP1KPdHx89apGvwdfrEL
	Ce2gA9q4R0W/uzCaDi3hE5c0zDK36tQZPux76PRjTi+PvryYsaJ9mtLoFYOWWIhOEAstoQms+synn
	OHOm9PSuZkisBB6n/rZ6YpVI+TnNV+PTJvy7Wwp05DO5RqmG7uVFgYcS5H5S+DzvOGaaBSrhgtDU3
	waYH4H66CcKqFMu4OF/h3Tj0QpgQC4/Ae7dYeQIfcoFV0LFQ3/s5zEtvGUvPr5vTJ1FmKbpkqklvl
	fg2Q27ly9kPepLGu9PZN7h5DuJy8qw3/eT8vHHOHzE9JiW5WgWsP9Bzi5rDbgW+KbhcyZEu+C7eTJ
	f9eDr1Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWKc-00000005Q3u-0VQM;
	Thu, 28 May 2026 08:43:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWKZ-00000005Q37-0WNa
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 08:43:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2AAC468B05; Thu, 28 May 2026 10:43:04 +0200 (CEST)
Date: Thu, 28 May 2026 10:43:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v5] nvme: reject passthrough of driver-managed Set
 Features
Message-ID: <20260528084303.GA8199@lst.de>
References: <20260523225629.3964037-1-coshi036@gmail.com> <ahcAaPTOH9ELlAA4@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahcAaPTOH9ELlAA4@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_014307_301180_BDCB03E6 
X-CRM114-Status: GOOD (  14.00  )
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

On Wed, May 27, 2026 at 08:32:08AM -0600, Keith Busch wrote:
> On Sat, May 23, 2026 at 06:56:29PM -0400, Chao Shi wrote:
> > +			switch (le32_to_cpu(c->features.fid) & 0xff) {
> > +			case NVME_FEAT_KATO:
> > +				if (ctrl->ops->flags & NVME_F_FABRICS)
> > +					break;
> > +				fallthrough;
> > +			case NVME_FEAT_HOST_BEHAVIOR:
> > +			case NVME_FEAT_HOST_MEM_BUF:
> > +			case NVME_FEAT_NUM_QUEUES:
> > +			case NVME_FEAT_AUTO_PST:
> 
> I may have been overly restrictive with suggesting AUTO_PST for this
> filter. Messing with the other features will break something, but power
> state is just user policy. The driver may undo the user setting on a
> controller reset, but so what?

There's really no point in allowing it.  Just as we should have never
allowed low-level config of any kind, but unfortunately nvme admin
commands are a horrible grab all.

