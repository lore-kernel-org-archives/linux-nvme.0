Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70654CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSJpJJqFdrJxLEE58UNzbaTpmKMjawEvkKpKdcyr8wA=; b=PeHGDc95zL5oM4c4ta5A10fnCN
	8qx8ywBJnB/0Mityzpn9oc00/Fntum5kW1AmtOeSoWDbooiVMv6ocRitnsCxP+7eWu3I8bGNGb6ay
	0rnZwuUGRzipyyVuCFnzyx8x3GqfGx/Xj2N0fLNfBqvpvt17ruOMN/2bVE80XOWtvunBeCHfl1ELY
	FsdpXqmiy+1rvOpmdHPaF7BeO09AD4/VN8aX6VuUmwXmbRLK+5PvNVXDTNfAdUzmJ6AiO3qi6r78W
	uNyH/ll+SNp/3Wd2vzAClBmR5SBW3iOjCRn0gRaYeyEdZZXBwR3ommyHFnEftLPjzHIzjrSA4ryw8
	j231ZFEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGSs-00000004RFf-3REe;
	Wed, 27 May 2026 15:46:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGSq-00000004REy-1vQy
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:46:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EE51C40B10;
	Wed, 27 May 2026 15:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C531F000E9;
	Wed, 27 May 2026 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896795;
	bh=RSJpJJqFdrJxLEE58UNzbaTpmKMjawEvkKpKdcyr8wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H7MSrAo8cnQvLI7EPixVHkikvrIZADmroiUQfYgvY1GI9mdmz/AugHzwUEl9uVrgt
	 l0nL/7tCMaOg9Z+/4s4ccWcQXQ0ZNXHK2zM/pT233kVgaHmZVU53EnAHeazc1xshVK
	 b5c949ARCZf70qKNwXUtrKlL0/bGknMvwWuKMNwp9HtkpjO2KVctFmMLXcMovMOLy5
	 S9I5oEMMZHjYfPnDsDYto0PmynQmQ6VVSR9oht63oYRcz9xgwMdNLEuXDZqcNZz0Xd
	 Z1SD5r/LjXPOoJCimqbWkSHSVlP35GgvodWMDAj2eG0+5jA7gzyrqUrZda89TTnhCT
	 iybmIFNKYt+vg==
Date: Wed, 27 May 2026 09:46:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: bound the freeze drain in passthrough commands
Message-ID: <ahcR2vy8k2FZAp9D@kbusch-mbp>
References: <20260527055923.456769-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527055923.456769-1-coshi036@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_084636_518867_2D86DDCE 
X-CRM114-Status: UNSURE (   9.85  )
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

On Wed, May 27, 2026 at 01:59:23AM -0400, Chao Shi wrote:
> If a completion is silently dropped or the device hangs, the calling
> task wedges with ctrl->scan_lock and ctrl->subsys->lock held, fanning
> out into hung-task reports on any concurrent open/close/passthru on
> the same controller:

The IO timeout callbacks that nvme drivers provide are supposed to
forcefully reclaim any IO no matter what state the device is in. Is that
not happening for some reason?

